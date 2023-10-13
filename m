Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D84C37C8BED
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 19:05:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrLZu-0000vy-Pr; Fri, 13 Oct 2023 13:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qrLZs-0000qi-7M
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:03:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qrLZp-0003on-CL
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697216631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=huOjKsVen1M34pzo2ceLorSlxNZjtC2ZxCwJDlPQHQM=;
 b=fc5isRXHcJpSzgg4Llvv+wH/Y2Q7ESY14AAci6VZtXINHopNg/rrQb/k1WSs8cePYVZ41C
 clC6BEx6//hbY5flaYAbjM3+Wh5NE14fwQHIGY6rs8LZxYpBTWQUOjwnN1ywhvFNu9ARFi
 J8aMKPSuClL1CflTFRc2j9Tprf/wxWY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-5_-dHKJeO5q5f_LQTX2v4w-1; Fri, 13 Oct 2023 13:03:49 -0400
X-MC-Unique: 5_-dHKJeO5q5f_LQTX2v4w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A3331023111;
 Fri, 13 Oct 2023 17:03:49 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7194E492BFA;
 Fri, 13 Oct 2023 17:03:48 +0000 (UTC)
Date: Fri, 13 Oct 2023 19:03:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, peter.maydell@linaro.org,
 pbonzini@redhat.com
Subject: Re: [PATCH 11/11] qdev: Rework array properties based on list visitor
Message-ID: <ZSl4c1GwDAB+EH+i@redhat.com>
References: <20230908143703.172758-1-kwolf@redhat.com>
 <20230908143703.172758-12-kwolf@redhat.com>
 <874jjms0x6.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jjms0x6.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Am 22.09.2023 um 17:05 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Until now, array properties are actually implemented with a hack that
> > uses multiple properties on the QOM level: a static "foo-len" property
> > and after it is set, dynamically created "foo[i]" properties.
> >
> > In external interfaces (-device on the command line and device_add in
> > QMP), this interface was broken by commit f3558b1b ('qdev: Base object
> > creation on QDict rather than QemuOpts') because QDicts are unordered
> > and therefore it could happen that QEMU tried to set the indexed
> > properties before setting the length, which fails and effectively makes
> > array properties inaccessible. In particular, this affects the 'ports'
> > property of the 'rocker' device.
> >
> > This patch reworks the external interface so that instead of using a
> > separate top-level property for the length and for each element, we use
> > a single true array property that accepts a list value. In the external
> > interfaces, this is naturally expressed as a JSON list and makes array
> > properties accessible again.
> >
> > Creating an array property on the command line without using JSON format
> > is currently not possible. This could be fixed by switching from
> > QemuOpts to a keyval parser, which however requires consideration of the
> > compatibility implications.
> >
> > All internal users of devices with array properties go through
> > qdev_prop_set_array() at this point, so updating it takes care of all of
> > them.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1090
> > Fixes: f3558b1b763683bb877f7dd5b282469cdadc65c3
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  include/hw/qdev-properties.h     |  23 ++--
> >  hw/core/qdev-properties-system.c |   2 +-
> >  hw/core/qdev-properties.c        | 204 +++++++++++++++++++------------
> >  3 files changed, 133 insertions(+), 96 deletions(-)
> >
> > diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> > index 7fa2fdb7c9..9370b36b72 100644
> > --- a/include/hw/qdev-properties.h
> > +++ b/include/hw/qdev-properties.h
> > @@ -61,7 +61,7 @@ extern const PropertyInfo qdev_prop_size;
> >  extern const PropertyInfo qdev_prop_string;
> >  extern const PropertyInfo qdev_prop_on_off_auto;
> >  extern const PropertyInfo qdev_prop_size32;
> > -extern const PropertyInfo qdev_prop_arraylen;
> > +extern const PropertyInfo qdev_prop_array;
> >  extern const PropertyInfo qdev_prop_link;
> >  
> >  #define DEFINE_PROP(_name, _state, _field, _prop, _type, ...) {  \
> > @@ -115,8 +115,6 @@ extern const PropertyInfo qdev_prop_link;
> >                  .bitmask    = (_bitmask),                     \
> >                  .set_default = false)
> >  
> > -#define PROP_ARRAY_LEN_PREFIX "len-"
> > -
> >  /**
> >   * DEFINE_PROP_ARRAY:
> >   * @_name: name of the array
> > @@ -127,24 +125,21 @@ extern const PropertyInfo qdev_prop_link;
> >   * @_arrayprop: PropertyInfo defining what property the array elements have
> >   * @_arraytype: C type of the array elements
> >   *
> > - * Define device properties for a variable-length array _name.  A
> > - * static property "len-arrayname" is defined. When the device creator
> > - * sets this property to the desired length of array, further dynamic
> > - * properties "arrayname[0]", "arrayname[1]", ...  are defined so the
> > - * device creator can set the array element values. Setting the
> > - * "len-arrayname" property more than once is an error.
> > + * Define device properties for a variable-length array _name.  The array is
> 
> Please wrap comments around column 70.  More of the same below, not
> noted again.

My comments are consistent with the existing style of this file.

> > + * represented as a list in the visitor interface.
> > + *
> > + * @_arraytype is required to be movable with memcpy().
> >   *
> > - * When the array length is set, the @_field member of the device
> > + * When the array property is set, the @_field member of the device
> >   * struct is set to the array length, and @_arrayfield is set to point
> > - * to (zero-initialised) memory allocated for the array.  For a zero
> > - * length array, @_field will be set to 0 and @_arrayfield to NULL.
> > + * to the memory allocated for the array.
> 
> Worth mentioning that the @field member must be uint32_t?

It's actually already mentioned above in the description of the fields.

> > + *
> >   * It is the responsibility of the device deinit code to free the
> >   * @_arrayfield memory.
> >   */
> >  #define DEFINE_PROP_ARRAY(_name, _state, _field,               \
> >                            _arrayfield, _arrayprop, _arraytype) \
> > -    DEFINE_PROP((PROP_ARRAY_LEN_PREFIX _name),                 \
> > -                _state, _field, qdev_prop_arraylen, uint32_t,  \
> > +    DEFINE_PROP(_name, _state, _field, qdev_prop_array, uint32_t,     \
> >                  .set_default = true,                           \
> >                  .defval.u = 0,                                 \
> >                  .arrayinfo = &(_arrayprop),                    \
> 
> The backslashes are no longer aligned.
>
> > diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> > index 6d5d43eda2..f557ee886e 100644
> > --- a/hw/core/qdev-properties-system.c
> > +++ b/hw/core/qdev-properties-system.c
> > @@ -450,7 +450,7 @@ static void set_netdev(Object *obj, Visitor *v, const char *name,
> >      peers_ptr->queues = queues;
> >  
> >  out:
> > -    error_set_from_qdev_prop_error(errp, err, obj, name, str);
> > +    error_set_from_qdev_prop_error(errp, err, obj, prop->name, str);
> >      g_free(str);
> >  }
> >  
> 
> Intentional?

Yes, as I had explained to Peter. I'll make this a separate patch in v2
and explain in the commit message.

> > diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> > index 950ef48e01..b2303a6fbc 100644
> > --- a/hw/core/qdev-properties.c
> > +++ b/hw/core/qdev-properties.c
> > @@ -546,98 +546,152 @@ const PropertyInfo qdev_prop_size32 = {
> >  
> >  /* --- support for array properties --- */
> >  
> > -/* Used as an opaque for the object properties we add for each
> > - * array element. Note that the struct Property must be first
> > - * in the struct so that a pointer to this works as the opaque
> > - * for the underlying element's property hooks as well as for
> > - * our own release callback.
> > - */
> > -typedef struct {
> > -    struct Property prop;
> > -    char *propname;
> > -    ObjectPropertyRelease *release;
> > -} ArrayElementProperty;
> > -
> > -/* object property release callback for array element properties:
> > - * we call the underlying element's property release hook, and
> > - * then free the memory we allocated when we added the property.
> > +static Property array_elem_prop(Object *obj, Property *parent_prop,
> > +                                const char *name, char *elem)
> 
> @parent_prop is an array property.  It's backed by an uint32_t length
> and an element array.  @elem points into the element array.  Correct?

Correct.

> > +{
> > +    return (Property) {
> > +        .info = parent_prop->arrayinfo,
> > +        .name = name,
> > +        /*
> > +         * This ugly piece of pointer arithmetic sets up the offset so
> > +         * that when the underlying release hook calls qdev_get_prop_ptr
> > +         * they get the right answer despite the array element not actually
> > +         * being inside the device struct.
> > +         */
> > +        .offset = elem - (char *) obj,
> 
> Isn't this is undefined behavior?

It should be at least less illegal than the old version of it, which did
the calculation on void * and still worked in practice...

But yes, strictly speaking, it's probably undefined behaviour. I can
calculate on uintptr_t instead, and then it should be defined here.

The QOM counterpart object_field_prop_ptr() is probably still undefined
because it calculates on a pointer and I think the spec allows casting
back to a pointer only after we've applied the offset so that we stay in
the same object with pointer arithmetics.

> Delete the space between (char *) and obj.
> 
> > +    };
> > +}
> > +
> > +/*
> > + * Object property release callback for array properties: We call the underlying
> > + * element's property release hook for each element.
> > + *
> > + * Note that it is the responsibility of the individual device's deinit to free
> > + * the array proper.
> 
> What is a device's "deinit"?  Is it the unrealize() method?  The
> instance_finalize() method?

Who knows? I only moved this comment.

My guess is that it doesn't really matter as long as _something_ frees
the array when unplugging the device.

> >   */
> > -static void array_element_release(Object *obj, const char *name, void *opaque)
> > +static void release_prop_array(Object *obj, const char *name, void *opaque)
> >  {
> > -    ArrayElementProperty *p = opaque;
> > -    if (p->release) {
> > -        p->release(obj, name, opaque);
> > +    Property *prop = opaque;
> > +    uint32_t *alenptr = object_field_prop_ptr(obj, prop);
> > +    void **arrayptr = (void *)obj + prop->arrayoffset;
> 
> I'd call these @plen and @pelts, but that's clearly a matter of taste.

I just kept the old names in set_prop_array() and used the same names in
new functions to stay consistent. But to be honest, @plen and @pelts
would be equally confusing to me.

My own choice would probably have been something like array_len and
array_data (if you want to know that it's a pointer, look at its type).

> > +    char *elem = *arrayptr;
> > +    int i;
> > +
> > +    for (i = 0; i < *alenptr; i++) {
> > +        Property elem_prop = array_elem_prop(obj, prop, name, elem);
> > +        prop->arrayinfo->release(obj, NULL, &elem_prop);
> > +        elem += prop->arrayfieldsize;
> >      }
> > -    g_free(p->propname);
> > -    g_free(p);
> >  }
> >  
> > -static void set_prop_arraylen(Object *obj, Visitor *v, const char *name,
> > -                              void *opaque, Error **errp)
> > +/*
> > + * Setter for an array property. This sets both the array length (which is
> > + * technically the property field in the object) and the array itself (a pointer
> > + * to which is stored in the additional field described by prop->arrayoffset).
> > + */
> > +static void set_prop_array(Object *obj, Visitor *v, const char *name,
> > +                           void *opaque, Error **errp)
> >  {
> > -    /* Setter for the property which defines the length of a
> > -     * variable-sized property array. As well as actually setting the
> > -     * array-length field in the device struct, we have to create the
> > -     * array itself and dynamically add the corresponding properties.
> > -     */
> > +    ERRP_GUARD();
> > +
> 
> Drop the blank line.
> 
> >      Property *prop = opaque;
> >      uint32_t *alenptr = object_field_prop_ptr(obj, prop);
> >      void **arrayptr = (void *)obj + prop->arrayoffset;
> > -    void *eltptr;
> > -    const char *arrayname;
> > -    int i;
> > +    GenericList *list, *elem, *next;
> > +    const size_t list_elem_size = sizeof(*list) + prop->arrayfieldsize;
> 
> This can be smaller than the size of the QAPI-generated list type, since
> the compiler may add padding.  Does it matter?

If it happens in practice, it does matter. Do we have any cleaner way to
get the element size without knowing the content of the list?

I expect that because GenericList only contains a single pointer, the
rest should have natural alignment and therefore the compiler shouldn't
have any reason to insert padding.

If you think this is not enough and there is no other way to get the
size of the list elements, we might have to generate packed structs for
the QAPI list types (which are really only two pointers, so not much to
lose when we do that).

> > +    char *elemptr;
> > +    bool ok = true;
> >  
> >      if (*alenptr) {
> >          error_setg(errp, "array size property %s may not be set more than once",
> >                     name);
> >          return;
> >      }
> > -    if (!visit_type_uint32(v, name, alenptr, errp)) {
> > +
> > +    if (!visit_start_list(v, name, &list, list_elem_size, errp)) {
> >          return;
> >      }
> > -    if (!*alenptr) {
> > +
> > +    /* Read the whole input into a temporary list */
> > +    elem = list;
> > +    while (elem) {
> > +        Property elem_prop = array_elem_prop(obj, prop, name, elem->padding);
> > +        prop->arrayinfo->set(obj, v, NULL, &elem_prop, errp);
> > +        if (*errp) {
> > +            ok = false;
> > +            goto out_obj;
> > +        }
> > +        (*alenptr)++;
> > +        elem = visit_next_list(v, elem, list_elem_size);
> > +    }
> > +
> > +    ok = visit_check_list(v, errp);
> > +out_obj:
> > +    visit_end_list(v, (void**) &list);
> > +
> > +    if (!ok) {
> > +        for (elem = list; elem; elem = next) {
> > +            next = elem->next;
> > +            g_free(elem);
> > +        }
> 
> We consume the list even on error.  It's too late in my day for me to
> see why that's proper.

Who else would free it otherwise?

This is pretty much the same as the generated list visitors do.

> >          return;
> >      }
> >  
> > -    /* DEFINE_PROP_ARRAY guarantees that name should start with this prefix;
> > -     * strip it off so we can get the name of the array itself.
> > +    /*
> > +     * Now that we know how big the array has to be, move the data over to a
> > +     * linear array and free the temporary list.
> >       */
> > -    assert(strncmp(name, PROP_ARRAY_LEN_PREFIX,
> > -                   strlen(PROP_ARRAY_LEN_PREFIX)) == 0);
> > -    arrayname = name + strlen(PROP_ARRAY_LEN_PREFIX);
> > +    *arrayptr = g_malloc_n(*alenptr, prop->arrayfieldsize);
> > +    elemptr = *arrayptr;
> > +    for (elem = list; elem; elem = next) {
> > +        memcpy(elemptr, elem->padding, prop->arrayfieldsize);
> > +        elemptr += prop->arrayfieldsize;
> > +        next = elem->next;
> > +        g_free(elem);
> > +    }
> > +}
> >  
> > -    /* Note that it is the responsibility of the individual device's deinit
> > -     * to free the array proper.
> > -     */
> > -    *arrayptr = eltptr = g_malloc0(*alenptr * prop->arrayfieldsize);
> > -    for (i = 0; i < *alenptr; i++, eltptr += prop->arrayfieldsize) {
> > -        char *propname = g_strdup_printf("%s[%d]", arrayname, i);
> > -        ArrayElementProperty *arrayprop = g_new0(ArrayElementProperty, 1);
> > -        arrayprop->release = prop->arrayinfo->release;
> > -        arrayprop->propname = propname;
> > -        arrayprop->prop.info = prop->arrayinfo;
> > -        arrayprop->prop.name = propname;
> > -        /* This ugly piece of pointer arithmetic sets up the offset so
> > -         * that when the underlying get/set hooks call qdev_get_prop_ptr
> > -         * they get the right answer despite the array element not actually
> > -         * being inside the device struct.
> > -         */
> > -        arrayprop->prop.offset = eltptr - (void *)obj;
> > -        assert(object_field_prop_ptr(obj, &arrayprop->prop) == eltptr);
> > -        object_property_add(obj, propname,
> > -                            arrayprop->prop.info->name,
> > -                            field_prop_getter(arrayprop->prop.info),
> > -                            field_prop_setter(arrayprop->prop.info),
> > -                            array_element_release,
> > -                            arrayprop);
> > +static void get_prop_array(Object *obj, Visitor *v, const char *name,
> > +                           void *opaque, Error **errp)
> > +{
> > +    ERRP_GUARD();
> > +
> 
> Drop the blank line.
> 
> > +    Property *prop = opaque;
> > +    uint32_t *alenptr = object_field_prop_ptr(obj, prop);
> > +    void **arrayptr = (void *)obj + prop->arrayoffset;
> > +    char *elem = *arrayptr;
> > +    GenericList *list;
> > +    const size_t list_elem_size = sizeof(*list) + prop->arrayfieldsize;
> > +    int i;
> > +
> > +    if (!visit_start_list(v, name, &list, list_elem_size, errp)) {
> > +        return;
> >      }
> > +
> > +    for (i = 0; i < *alenptr; i++) {
> > +        Property elem_prop = array_elem_prop(obj, prop, name, elem);
> > +        prop->arrayinfo->get(obj, v, NULL, &elem_prop, errp);
> > +        if (*errp) {
> > +            goto out_obj;
> > +        }
> > +        elem += prop->arrayfieldsize;
> > +    }
> > +
> 
> You neglect to call visit_check_list().

It is documented to be intended for input visitors only. Do we need it
with an output visitor?

> > +out_obj:
> > +    visit_end_list(v, (void**) &list);
> >  }
> >  
> > -const PropertyInfo qdev_prop_arraylen = {
> > -    .name = "uint32",
> > -    .get = get_uint32,
> > -    .set = set_prop_arraylen,
> > -    .set_default_value = qdev_propinfo_set_default_value_uint,
> > +static void default_prop_array(ObjectProperty *op, const Property *prop)
> > +{
> > +    object_property_set_default_list(op);
> > +}
> > +
> > +const PropertyInfo qdev_prop_array = {
> > +    .name = "list",
> > +    .get = get_prop_array,
> > +    .set = set_prop_array,
> > +    .release = release_prop_array,
> > +    .set_default_value = default_prop_array,
> >  };
> >  
> >  /* --- public helpers --- */
> > @@ -743,20 +797,8 @@ void qdev_prop_set_enum(DeviceState *dev, const char *name, int value)
> >  
> >  void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values)
> >  {
> > -    const QListEntry *entry;
> > -    g_autofree char *prop_len = g_strdup_printf("len-%s", name);
> > -    uint32_t i = 0;
> > -
> > -    object_property_set_int(OBJECT(dev), prop_len, qlist_size(values),
> > -                            &error_abort);
> > -
> > -    QLIST_FOREACH_ENTRY(values, entry) {
> > -        g_autofree char *prop_idx = g_strdup_printf("%s[%u]", name, i);
> > -        object_property_set_qobject(OBJECT(dev), prop_idx, entry->value,
> > -                                    &error_abort);
> > -        i++;
> > -    }
> > -
> > +    object_property_set_qobject(OBJECT(dev), name, QOBJECT(values),
> > +                                &error_abort);
> >      qobject_unref(values);
> >  }
> 
> I like this very much.

Thanks for the review.

Kevin


