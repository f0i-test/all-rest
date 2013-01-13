class RestsController < ApplicationController
  def url
    request.path_parameters
  end

  def get
    request.GET
  end

  def post
    request.POST
  end

  def put
    request.PUT
  end

  def next_id thing
    thing = Thing.where(:thing, thing).order(:tid).last
    if thing
      thing.tid + 1
    else
      1
    end
  end

  # Find        GET      /thing/123
  # Find All    GET      /thing
  # Update      PUT      /thing/123
  # Create      POST     /thing
  # Delete      DELETE   /thing/123
  def find
    @thing = Thing.where(:thing, url[:thing]).where(:tid, url[:id]).last
    render json: @thing.object
  end    

  def find_all
    @things = Thing.find_all_by_thing(url[:thing])
    out = @things.collect{|t| t.object}
    render json: out
  end

  def update
    @thing = Thing.where(:thing, url[:thing]).where(:tid, url[:id]).last

    object = @thing.object.merge(put)
    object[:id] = url[:id]
    @thing.object = object

    if @thing.save
      head :no_content
    else
      render json: @thing.errors, status: :unprocessable_entity
    end
  end

  def create
    @thing = Thing.new
    @thing.thing = url[:thing]
    @thing.tid = next_id(@thing.thing)

    object = @thing.object.merge(post)
    object[:id] = @thing.tid
    @thing.object = object
    
    if @thing.save
      render json: @thing.object, status: :created, location: @thing.object
    else
      render json: @thing.errors, status: :unprocessable_entity
    end
  end

  def delete
    @thing = Thing.where(:thing, url[:thing]).where(:tid, url[:id]).each do |t|
      t.destroy
    end
    head :no_content 
  end
end

