Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 617877A01A3
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 12:26:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgjXs-0000cp-1e; Thu, 14 Sep 2023 06:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qgjXJ-00008T-Hi
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 06:25:35 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qgjXB-0002iH-EL
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 06:25:20 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-530199bca8eso801337a12.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 03:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694687112; x=1695291912; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6INuFBBOTuxSr8xHrTOqOjHVuXOfWXEQtdxq/W2J9B0=;
 b=yyR2P39CV2cndBu3km2SojPLcJsvNSJwP4dzA9HhavrI8EWAdOs18oHqiVEZbCbuGk
 jNrPYUUVtcnbDTHrbA1TfdZRh2UCP6ct4gCEwbRRJx8v2lB8oKdaY21KPqo3p0eU9lHd
 hsdaaPp3fI4P7XCHiFqvwc/z4kFv4tDM+2tdTI1p0f41L7u0bS9K9lqZfqiq7kf6GghR
 VCPIjUwbrLxbnIKAJp8I+mVpGh63HBeTXQ34kvY3LbDT3cATFHaVydI5WTv0taKR0JQh
 oZ85H+Vn8MPm3hLPgheQIqXUCbfwLzl49L3qHJecT629DerB18HWj9vUstoC6CLDwzEk
 umHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694687112; x=1695291912;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6INuFBBOTuxSr8xHrTOqOjHVuXOfWXEQtdxq/W2J9B0=;
 b=VRGdM9FuoBpalsRsrJRC7N2HbU4/DAhOn45+MUbxtmJLD+DMTOVjGbf0I2dyzZpiu0
 3vK7yAUQz/fh8q893MrUqVMFkgh2cP4ugEFnVGU20WR2xTI6wOIIacDOnqV2LDPqqneC
 5XHJ8PrHCzzb+uTVj9y9KG00BWOCuy1zubzivIFEtH9G/FPKJ0hQw1LJlv+AmTfs6gIU
 0/0JI4PyT2XNPvG9f8ihLmOyQ5wvTMMzG7HmN6ZOcTdaMtblaXzgf4csycnHK4blzezB
 uwqPlpaopi6bQf/gvaikr40pV9ekVhWGuW1sgWYN8A7/XT1vcm/Wxh0Rq7cYu+nmYBEk
 N/VQ==
X-Gm-Message-State: AOJu0YyfvLJEu0gcIvce39gMydC0V45fFZoH6NcPJszqlGOXLdgKCVCk
 cuUTAS9zOIVC4a1QLFO35wW2nrQ+rg6/iuVgigH73Q==
X-Google-Smtp-Source: AGHT+IHLAzigQMZiM4kP6dd4mrpJdaykk4yM/6NvjCtsRdMUzykdgSw+K61Bplr1d0NjhhSh/Gm+bQwr8sOkZ+nKjdk=
X-Received: by 2002:a05:6402:2695:b0:52e:4789:bee2 with SMTP id
 w21-20020a056402269500b0052e4789bee2mr2204075edd.6.1694687111630; Thu, 14 Sep
 2023 03:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230908143703.172758-1-kwolf@redhat.com>
 <20230908143703.172758-12-kwolf@redhat.com>
In-Reply-To: <20230908143703.172758-12-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2023 11:24:51 +0100
Message-ID: <CAFEAcA-KAVhJhMCb+CqdSS_AO=VsVuj5akySS3pVYHKg=atE0w@mail.gmail.com>
Subject: Re: [PATCH 11/11] qdev: Rework array properties based on list visitor
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 8 Sept 2023 at 15:37, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Until now, array properties are actually implemented with a hack that
> uses multiple properties on the QOM level: a static "foo-len" property
> and after it is set, dynamically created "foo[i]" properties.
>
> In external interfaces (-device on the command line and device_add in
> QMP), this interface was broken by commit f3558b1b ('qdev: Base object
> creation on QDict rather than QemuOpts') because QDicts are unordered
> and therefore it could happen that QEMU tried to set the indexed
> properties before setting the length, which fails and effectively makes
> array properties inaccessible. In particular, this affects the 'ports'
> property of the 'rocker' device.
>
> This patch reworks the external interface so that instead of using a
> separate top-level property for the length and for each element, we use
> a single true array property that accepts a list value. In the external
> interfaces, this is naturally expressed as a JSON list and makes array
> properties accessible again.
>
> Creating an array property on the command line without using JSON format
> is currently not possible. This could be fixed by switching from
> QemuOpts to a keyval parser, which however requires consideration of the
> compatibility implications.
>
> All internal users of devices with array properties go through
> qdev_prop_set_array() at this point, so updating it takes care of all of
> them.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1090
> Fixes: f3558b1b763683bb877f7dd5b282469cdadc65c3
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

I'm hoping that somebody who understands the visitor APIs
better than me will have a look at this patch, but in the
meantime, here's my review, which I suspect has a lot of
comments that mostly reflect that I don't really understand
the visitor stuff...

> ---
>  include/hw/qdev-properties.h     |  23 ++--
>  hw/core/qdev-properties-system.c |   2 +-
>  hw/core/qdev-properties.c        | 204 +++++++++++++++++++------------
>  3 files changed, 133 insertions(+), 96 deletions(-)
>
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 7fa2fdb7c9..9370b36b72 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -61,7 +61,7 @@ extern const PropertyInfo qdev_prop_size;
>  extern const PropertyInfo qdev_prop_string;
>  extern const PropertyInfo qdev_prop_on_off_auto;
>  extern const PropertyInfo qdev_prop_size32;
> -extern const PropertyInfo qdev_prop_arraylen;
> +extern const PropertyInfo qdev_prop_array;
>  extern const PropertyInfo qdev_prop_link;
>
>  #define DEFINE_PROP(_name, _state, _field, _prop, _type, ...) {  \
> @@ -115,8 +115,6 @@ extern const PropertyInfo qdev_prop_link;
>                  .bitmask    = (_bitmask),                     \
>                  .set_default = false)
>
> -#define PROP_ARRAY_LEN_PREFIX "len-"
> -
>  /**
>   * DEFINE_PROP_ARRAY:
>   * @_name: name of the array
> @@ -127,24 +125,21 @@ extern const PropertyInfo qdev_prop_link;
>   * @_arrayprop: PropertyInfo defining what property the array elements have
>   * @_arraytype: C type of the array elements
>   *
> - * Define device properties for a variable-length array _name.  A
> - * static property "len-arrayname" is defined. When the device creator
> - * sets this property to the desired length of array, further dynamic
> - * properties "arrayname[0]", "arrayname[1]", ...  are defined so the
> - * device creator can set the array element values. Setting the
> - * "len-arrayname" property more than once is an error.
> + * Define device properties for a variable-length array _name.  The array is
> + * represented as a list in the visitor interface.
> + *
> + * @_arraytype is required to be movable with memcpy().
>   *
> - * When the array length is set, the @_field member of the device
> + * When the array property is set, the @_field member of the device
>   * struct is set to the array length, and @_arrayfield is set to point
> - * to (zero-initialised) memory allocated for the array.  For a zero
> - * length array, @_field will be set to 0 and @_arrayfield to NULL.
> + * to the memory allocated for the array.
> + *
>   * It is the responsibility of the device deinit code to free the
>   * @_arrayfield memory.
>   */
>  #define DEFINE_PROP_ARRAY(_name, _state, _field,               \
>                            _arrayfield, _arrayprop, _arraytype) \
> -    DEFINE_PROP((PROP_ARRAY_LEN_PREFIX _name),                 \
> -                _state, _field, qdev_prop_arraylen, uint32_t,  \
> +    DEFINE_PROP(_name, _state, _field, qdev_prop_array, uint32_t,     \
>                  .set_default = true,                           \
>                  .defval.u = 0,                                 \
>                  .arrayinfo = &(_arrayprop),                    \
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index 6d5d43eda2..f557ee886e 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -450,7 +450,7 @@ static void set_netdev(Object *obj, Visitor *v, const char *name,
>      peers_ptr->queues = queues;
>
>  out:
> -    error_set_from_qdev_prop_error(errp, err, obj, name, str);
> +    error_set_from_qdev_prop_error(errp, err, obj, prop->name, str);
>      g_free(str);
>  }

Is this change intentional? It's not clear to me why the netdev
property setter needs to change.

> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 950ef48e01..b2303a6fbc 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -546,98 +546,152 @@ const PropertyInfo qdev_prop_size32 = {
>
>  /* --- support for array properties --- */
>
> -/* Used as an opaque for the object properties we add for each
> - * array element. Note that the struct Property must be first
> - * in the struct so that a pointer to this works as the opaque
> - * for the underlying element's property hooks as well as for
> - * our own release callback.
> - */
> -typedef struct {
> -    struct Property prop;
> -    char *propname;
> -    ObjectPropertyRelease *release;
> -} ArrayElementProperty;
> -
> -/* object property release callback for array element properties:
> - * we call the underlying element's property release hook, and
> - * then free the memory we allocated when we added the property.
> +static Property array_elem_prop(Object *obj, Property *parent_prop,
> +                                const char *name, char *elem)
> +{
> +    return (Property) {
> +        .info = parent_prop->arrayinfo,
> +        .name = name,
> +        /*
> +         * This ugly piece of pointer arithmetic sets up the offset so
> +         * that when the underlying release hook calls qdev_get_prop_ptr
> +         * they get the right answer despite the array element not actually
> +         * being inside the device struct.
> +         */
> +        .offset = elem - (char *) obj,

Stray space after ')'.

> +    };
> +}
> +
> +/*
> + * Object property release callback for array properties: We call the underlying
> + * element's property release hook for each element.
> + *
> + * Note that it is the responsibility of the individual device's deinit to free
> + * the array proper.
>   */
> -static void array_element_release(Object *obj, const char *name, void *opaque)
> +static void release_prop_array(Object *obj, const char *name, void *opaque)
>  {
> -    ArrayElementProperty *p = opaque;
> -    if (p->release) {
> -        p->release(obj, name, opaque);
> +    Property *prop = opaque;
> +    uint32_t *alenptr = object_field_prop_ptr(obj, prop);
> +    void **arrayptr = (void *)obj + prop->arrayoffset;
> +    char *elem = *arrayptr;
> +    int i;
> +
> +    for (i = 0; i < *alenptr; i++) {

Is there something somewhere that enforces that a list can't
have more than INT_MAX elements? Otherwise this will go wrong,
I think, since we're iterating with an 'int'.

> +        Property elem_prop = array_elem_prop(obj, prop, name, elem);
> +        prop->arrayinfo->release(obj, NULL, &elem_prop);
> +        elem += prop->arrayfieldsize;
>      }
> -    g_free(p->propname);
> -    g_free(p);
>  }
>
> -static void set_prop_arraylen(Object *obj, Visitor *v, const char *name,
> -                              void *opaque, Error **errp)
> +/*
> + * Setter for an array property. This sets both the array length (which is
> + * technically the property field in the object) and the array itself (a pointer
> + * to which is stored in the additional field described by prop->arrayoffset).
> + */
> +static void set_prop_array(Object *obj, Visitor *v, const char *name,
> +                           void *opaque, Error **errp)

Is there something somewhere in this that guards against the
caller trying to set an array property with a list that doesn't
have elements that are all the same type?

>  {
> -    /* Setter for the property which defines the length of a
> -     * variable-sized property array. As well as actually setting the
> -     * array-length field in the device struct, we have to create the
> -     * array itself and dynamically add the corresponding properties.
> -     */
> +    ERRP_GUARD();
> +
>      Property *prop = opaque;
>      uint32_t *alenptr = object_field_prop_ptr(obj, prop);
>      void **arrayptr = (void *)obj + prop->arrayoffset;
> -    void *eltptr;
> -    const char *arrayname;
> -    int i;
> +    GenericList *list, *elem, *next;
> +    const size_t list_elem_size = sizeof(*list) + prop->arrayfieldsize;
> +    char *elemptr;
> +    bool ok = true;
>
>      if (*alenptr) {
>          error_setg(errp, "array size property %s may not be set more than once",
>                     name);
>          return;
>      }
> -    if (!visit_type_uint32(v, name, alenptr, errp)) {
> +
> +    if (!visit_start_list(v, name, &list, list_elem_size, errp)) {
>          return;
>      }
> -    if (!*alenptr) {
> +
> +    /* Read the whole input into a temporary list */

Why do we need the temporary list? Shouldn't we already know
at this point the length of the list and be able to allocate
the memory and write directly into that?

> +    elem = list;
> +    while (elem) {
> +        Property elem_prop = array_elem_prop(obj, prop, name, elem->padding);
> +        prop->arrayinfo->set(obj, v, NULL, &elem_prop, errp);

Why do we call a set() function if we're getting the value
of the array item ?

> +        if (*errp) {
> +            ok = false;
> +            goto out_obj;
> +        }
> +        (*alenptr)++;
> +        elem = visit_next_list(v, elem, list_elem_size);
> +    }
> +
> +    ok = visit_check_list(v, errp);
> +out_obj:
> +    visit_end_list(v, (void**) &list);
> +
> +    if (!ok) {
> +        for (elem = list; elem; elem = next) {
> +            next = elem->next;
> +            g_free(elem);
> +        }
>          return;
>      }
>
> -    /* DEFINE_PROP_ARRAY guarantees that name should start with this prefix;
> -     * strip it off so we can get the name of the array itself.
> +    /*
> +     * Now that we know how big the array has to be, move the data over to a
> +     * linear array and free the temporary list.
>       */
> -    assert(strncmp(name, PROP_ARRAY_LEN_PREFIX,
> -                   strlen(PROP_ARRAY_LEN_PREFIX)) == 0);
> -    arrayname = name + strlen(PROP_ARRAY_LEN_PREFIX);
> +    *arrayptr = g_malloc_n(*alenptr, prop->arrayfieldsize);
> +    elemptr = *arrayptr;
> +    for (elem = list; elem; elem = next) {
> +        memcpy(elemptr, elem->padding, prop->arrayfieldsize);
> +        elemptr += prop->arrayfieldsize;
> +        next = elem->next;
> +        g_free(elem);
> +    }
> +}
>
> -    /* Note that it is the responsibility of the individual device's deinit
> -     * to free the array proper.
> -     */
> -    *arrayptr = eltptr = g_malloc0(*alenptr * prop->arrayfieldsize);
> -    for (i = 0; i < *alenptr; i++, eltptr += prop->arrayfieldsize) {
> -        char *propname = g_strdup_printf("%s[%d]", arrayname, i);
> -        ArrayElementProperty *arrayprop = g_new0(ArrayElementProperty, 1);
> -        arrayprop->release = prop->arrayinfo->release;
> -        arrayprop->propname = propname;
> -        arrayprop->prop.info = prop->arrayinfo;
> -        arrayprop->prop.name = propname;
> -        /* This ugly piece of pointer arithmetic sets up the offset so
> -         * that when the underlying get/set hooks call qdev_get_prop_ptr
> -         * they get the right answer despite the array element not actually
> -         * being inside the device struct.
> -         */
> -        arrayprop->prop.offset = eltptr - (void *)obj;
> -        assert(object_field_prop_ptr(obj, &arrayprop->prop) == eltptr);
> -        object_property_add(obj, propname,
> -                            arrayprop->prop.info->name,
> -                            field_prop_getter(arrayprop->prop.info),
> -                            field_prop_setter(arrayprop->prop.info),
> -                            array_element_release,
> -                            arrayprop);
> +static void get_prop_array(Object *obj, Visitor *v, const char *name,
> +                           void *opaque, Error **errp)
> +{
> +    ERRP_GUARD();
> +
> +    Property *prop = opaque;
> +    uint32_t *alenptr = object_field_prop_ptr(obj, prop);
> +    void **arrayptr = (void *)obj + prop->arrayoffset;
> +    char *elem = *arrayptr;
> +    GenericList *list;
> +    const size_t list_elem_size = sizeof(*list) + prop->arrayfieldsize;
> +    int i;
> +
> +    if (!visit_start_list(v, name, &list, list_elem_size, errp)) {
> +        return;
>      }
> +
> +    for (i = 0; i < *alenptr; i++) {
> +        Property elem_prop = array_elem_prop(obj, prop, name, elem);
> +        prop->arrayinfo->get(obj, v, NULL, &elem_prop, errp);
> +        if (*errp) {
> +            goto out_obj;
> +        }
> +        elem += prop->arrayfieldsize;
> +    }
> +
> +out_obj:
> +    visit_end_list(v, (void**) &list);
>  }
>
> -const PropertyInfo qdev_prop_arraylen = {
> -    .name = "uint32",
> -    .get = get_uint32,
> -    .set = set_prop_arraylen,
> -    .set_default_value = qdev_propinfo_set_default_value_uint,
> +static void default_prop_array(ObjectProperty *op, const Property *prop)
> +{
> +    object_property_set_default_list(op);
> +}
> +
> +const PropertyInfo qdev_prop_array = {
> +    .name = "list",
> +    .get = get_prop_array,
> +    .set = set_prop_array,
> +    .release = release_prop_array,
> +    .set_default_value = default_prop_array,
>  };
>
>  /* --- public helpers --- */
> @@ -743,20 +797,8 @@ void qdev_prop_set_enum(DeviceState *dev, const char *name, int value)
>
>  void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values)
>  {
> -    const QListEntry *entry;
> -    g_autofree char *prop_len = g_strdup_printf("len-%s", name);
> -    uint32_t i = 0;
> -
> -    object_property_set_int(OBJECT(dev), prop_len, qlist_size(values),
> -                            &error_abort);
> -
> -    QLIST_FOREACH_ENTRY(values, entry) {
> -        g_autofree char *prop_idx = g_strdup_printf("%s[%u]", name, i);
> -        object_property_set_qobject(OBJECT(dev), prop_idx, entry->value,
> -                                    &error_abort);
> -        i++;
> -    }
> -
> +    object_property_set_qobject(OBJECT(dev), name, QOBJECT(values),
> +                                &error_abort);
>      qobject_unref(values);
>  }
>
> --
> 2.41.0

thanks
-- PMM

