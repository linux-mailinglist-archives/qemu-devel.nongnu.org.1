Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5EF7DC167
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 21:49:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxZBj-0002H9-Sf; Mon, 30 Oct 2023 16:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qxZBg-0002Gz-5z
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 16:48:40 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qxZBc-0000mW-4z
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 16:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=whh/cACDv9J2cMNnRzJZZPO3AyVIRZZK9ctLJn496w4=; b=jpDKtqJqnVmM0RPVp7LYvW68HY
 sVMldK2aHIZ7Lr/bIrbcUhcSv2Sl96kUqxsKmhyLWmOC2bc62PqGEXZzP4Zbyn/1Im+gkAjXOFB69
 vj5Hat2zgHIM96GADoGIoKYFANTdMIfNEJVqAEuJ/ReOeijDkWnci1ZE/2Nb26gn0EmGpxTeYILkZ
 M3FgQkFw9XAMjUeHRPBXbOmjBrsqeLTcYL6J30CAF+qons8ofP2zLXHzfZ7qQ60V+qXBPcBPWU424
 jS6Wiv15UoCXq804CCOqmFllIQsdHkUXGzrVpGqfKjrwo6AWEQ2a8xscPJNcI3E1/GZhN26l3D0sj
 NPOZ9mhaPBusMYN9SKNcmqJfbFvUfh/5r64ZZX5IZfyJGuFnDZGVBmhG92/fJcs7BxZJ3FZlLwZyE
 1z8EAOODPCl2oCcL0egKZ/Rvj7gt2zFSR7FpdRyaFJCz2fL24C+UeDg1cOxkAJHPz3hXN0UWPJXWb
 T4A0jVJ8WLFJixzy4j8n9DthKssamkMYOhEtwVtTyttWouh1R4vpjyD7p8A6k0hVMsnU4O50+QHpP
 TUQ7kr0kw3ghT0WAeWwC1sj8cAG4uJ7aJZ2sAc5grI7BNOmAdTOeJYtB7fQF/pYYctxBjpZY5GBBg
 cMccFygii9rFGd1LzNp029U5/pikwWghC/uvRh8nM=;
Received: from [2a00:23c4:8bb0:5400:5ff2:9176:6cc5:bf69]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qxZBO-00008y-MQ; Mon, 30 Oct 2023 20:48:26 +0000
Message-ID: <92dce7a5-6a1c-41bd-8ac0-3884e4ad9ab3@ilande.co.uk>
Date: Mon, 30 Oct 2023 20:48:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, philmd@linaro.org
References: <20231030142658.182193-1-kwolf@redhat.com>
 <20231030142658.182193-13-kwolf@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20231030142658.182193-13-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:5400:5ff2:9176:6cc5:bf69
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 12/12] qdev: Rework array properties based on list
 visitor
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 30/10/2023 14:26, Kevin Wolf wrote:

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
> property of the 'rocker' device, which used to be configured like this:
> 
> -device rocker,len-ports=2,ports[0]=dev0,ports[1]=dev1
> 
> This patch reworks the external interface so that instead of using a
> separate top-level property for the length and for each element, we use
> a single true array property that accepts a list value. In the external
> interfaces, this is naturally expressed as a JSON list and makes array
> properties accessible again. The new syntax looks like this:
> 
> -device '{"driver":"rocker","ports":["dev0","dev1"]}'
> 
> Creating an array property on the command line without using JSON format
> is currently not possible. This could be fixed by switching from
> QemuOpts to a keyval parser, which however requires consideration of the
> compatibility implications.
> 
> All internal users of devices with array properties go through
> qdev_prop_set_array() at this point, so updating it takes care of all of
> them.

Is it possible to find a suitable place in the documentation to show how the new 
array syntax is used with -device on the command line? The description above is 
really useful, but I can see this being quite hard for users to find if it is only 
documented in the commit message.

> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1090
> Fixes: f3558b1b763683bb877f7dd5b282469cdadc65c3
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   include/hw/qdev-properties.h |  59 +++++----
>   hw/core/qdev-properties.c    | 224 ++++++++++++++++++++++-------------
>   2 files changed, 183 insertions(+), 100 deletions(-)
> 
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 7fa2fdb7c9..cac752bade 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -1,7 +1,10 @@
>   #ifndef QEMU_QDEV_PROPERTIES_H
>   #define QEMU_QDEV_PROPERTIES_H
>   
> +#include <stdalign.h>
> +
>   #include "hw/qdev-core.h"
> +#include "qapi/visitor.h"
>   
>   /**
>    * Property:
> @@ -61,7 +64,7 @@ extern const PropertyInfo qdev_prop_size;
>   extern const PropertyInfo qdev_prop_string;
>   extern const PropertyInfo qdev_prop_on_off_auto;
>   extern const PropertyInfo qdev_prop_size32;
> -extern const PropertyInfo qdev_prop_arraylen;
> +extern const PropertyInfo qdev_prop_array;
>   extern const PropertyInfo qdev_prop_link;
>   
>   #define DEFINE_PROP(_name, _state, _field, _prop, _type, ...) {  \
> @@ -115,8 +118,6 @@ extern const PropertyInfo qdev_prop_link;
>                   .bitmask    = (_bitmask),                     \
>                   .set_default = false)
>   
> -#define PROP_ARRAY_LEN_PREFIX "len-"
> -
>   /**
>    * DEFINE_PROP_ARRAY:
>    * @_name: name of the array
> @@ -127,28 +128,46 @@ extern const PropertyInfo qdev_prop_link;
>    * @_arrayprop: PropertyInfo defining what property the array elements have
>    * @_arraytype: C type of the array elements
>    *
> - * Define device properties for a variable-length array _name.  A
> - * static property "len-arrayname" is defined. When the device creator
> - * sets this property to the desired length of array, further dynamic
> - * properties "arrayname[0]", "arrayname[1]", ...  are defined so the
> - * device creator can set the array element values. Setting the
> - * "len-arrayname" property more than once is an error.
> + * Define device properties for a variable-length array _name.  The array is
> + * represented as a list in the visitor interface.
>    *
> - * When the array length is set, the @_field member of the device
> + * @_arraytype is required to be movable with memcpy() and to have an alignment
> + * such that it can be stored at GenericList.padding.
> + *
> + * When the array property is set, the @_field member of the device
>    * struct is set to the array length, and @_arrayfield is set to point
> - * to (zero-initialised) memory allocated for the array.  For a zero
> - * length array, @_field will be set to 0 and @_arrayfield to NULL.
> + * to the memory allocated for the array.
> + *
>    * It is the responsibility of the device deinit code to free the
>    * @_arrayfield memory.
>    */
> -#define DEFINE_PROP_ARRAY(_name, _state, _field,               \
> -                          _arrayfield, _arrayprop, _arraytype) \
> -    DEFINE_PROP((PROP_ARRAY_LEN_PREFIX _name),                 \
> -                _state, _field, qdev_prop_arraylen, uint32_t,  \
> -                .set_default = true,                           \
> -                .defval.u = 0,                                 \
> -                .arrayinfo = &(_arrayprop),                    \
> -                .arrayfieldsize = sizeof(_arraytype),          \
> +#define DEFINE_PROP_ARRAY(_name, _state, _field,                        \
> +                          _arrayfield, _arrayprop, _arraytype)          \
> +    DEFINE_PROP(_name, _state, _field, qdev_prop_array, uint32_t,       \
> +                .set_default = true,                                    \
> +                .defval.u = 0,                                          \
> +                .arrayinfo = &(_arrayprop),                             \
> +                /*                                                      \
> +                 * set_prop_array() temporarily stores elements at      \
> +                 * GenericList.padding. Make sure that this has the     \
> +                 * right alignment for @_arraytype.                     \
> +                 *                                                      \
> +                 * Hack: In this place, neither static assertions work  \
> +                 * nor is a statement expression allowed. This          \
> +                 * abomination of an expression works because inside    \
> +                 * the declaration of a dummy struct, static assertions \
> +                 * are possible. Using the comma operator causes        \
> +                 * warnings about an unused value and casting to void   \
> +                 * makes the expression not constant in gcc, so instead \
> +                 * of ignoring the first part, make it evaluate to 0    \
> +                 * and add it to the actual result.                     \
> +                 */                                                     \
> +                .arrayfieldsize = (!sizeof(struct {                     \
> +                    QEMU_BUILD_BUG_ON(                                  \
> +                        !QEMU_IS_ALIGNED(sizeof(GenericList),           \
> +                                         alignof(_arraytype)));         \
> +                    int dummy;                                          \
> +                }) + sizeof(_arraytype)),                               \
>                   .arrayoffset = offsetof(_state, _arrayfield))
>   
>   #define DEFINE_PROP_LINK(_name, _state, _field, _type, _ptr_type)     \
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index fb4daba799..4f3e1152be 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -546,98 +546,174 @@ const PropertyInfo qdev_prop_size32 = {
>   
>   /* --- support for array properties --- */
>   
> -/* Used as an opaque for the object properties we add for each
> - * array element. Note that the struct Property must be first
> - * in the struct so that a pointer to this works as the opaque
> - * for the underlying element's property hooks as well as for
> - * our own release callback.
> +/*
> + * Given an array property @parent_prop in @obj, return a Property for a
> + * specific element of the array. Arrays are backed by an uint32_t length field
> + * and an element array. @elem points at an element in this element array.
>    */
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
> +        .offset = (uintptr_t)elem - (uintptr_t)obj,
> +    };
> +}
> +
> +/*
> + * Object property release callback for array properties: We call the
> + * underlying element's property release hook for each element.
> + *
> + * Note that it is the responsibility of the individual device's deinit
> + * to free the array proper.
>    */
> -static void array_element_release(Object *obj, const char *name, void *opaque)
> +static void release_prop_array(Object *obj, const char *name, void *opaque)
>   {
> -    ArrayElementProperty *p = opaque;
> -    if (p->release) {
> -        p->release(obj, name, opaque);
> +    Property *prop = opaque;
> +    uint32_t *alenptr = object_field_prop_ptr(obj, prop);
> +    void **arrayptr = (void *)obj + prop->arrayoffset;
> +    char *elem = *arrayptr;
> +    int i;
> +
> +    if (!prop->arrayinfo->release) {
> +        return;
> +    }
> +
> +    for (i = 0; i < *alenptr; i++) {
> +        Property elem_prop = array_elem_prop(obj, prop, name, elem);
> +        prop->arrayinfo->release(obj, NULL, &elem_prop);
> +        elem += prop->arrayfieldsize;
>       }
> -    g_free(p->propname);
> -    g_free(p);
>   }
>   
> -static void set_prop_arraylen(Object *obj, Visitor *v, const char *name,
> -                              void *opaque, Error **errp)
> +/*
> + * Setter for an array property. This sets both the array length (which
> + * is technically the property field in the object) and the array itself
> + * (a pointer to which is stored in the additional field described by
> + * prop->arrayoffset).
> + */
> +static void set_prop_array(Object *obj, Visitor *v, const char *name,
> +                           void *opaque, Error **errp)
>   {
> -    /* Setter for the property which defines the length of a
> -     * variable-sized property array. As well as actually setting the
> -     * array-length field in the device struct, we have to create the
> -     * array itself and dynamically add the corresponding properties.
> -     */
> +    ERRP_GUARD();
>       Property *prop = opaque;
>       uint32_t *alenptr = object_field_prop_ptr(obj, prop);
>       void **arrayptr = (void *)obj + prop->arrayoffset;
> -    void *eltptr;
> -    const char *arrayname;
> -    int i;
> +    GenericList *list, *elem, *next;
> +    const size_t list_elem_size = sizeof(*list) + prop->arrayfieldsize;
> +    char *elemptr;
> +    bool ok = true;
>   
>       if (*alenptr) {
>           error_setg(errp, "array size property %s may not be set more than once",
>                      name);
>           return;
>       }
> -    if (!visit_type_uint32(v, name, alenptr, errp)) {
> +
> +    if (!visit_start_list(v, name, &list, list_elem_size, errp)) {
>           return;
>       }
> -    if (!*alenptr) {
> +
> +    /* Read the whole input into a temporary list */
> +    elem = list;
> +    while (elem) {
> +        Property elem_prop = array_elem_prop(obj, prop, name, elem->padding);
> +        prop->arrayinfo->set(obj, v, NULL, &elem_prop, errp);
> +        if (*errp) {
> +            ok = false;
> +            goto out_obj;
> +        }
> +        if (*alenptr == INT_MAX) {
> +            error_setg(errp, "array is too big");
> +            return;
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
> +            Property elem_prop = array_elem_prop(obj, prop, name,
> +                                                 elem->padding);
> +            if (prop->arrayinfo->release) {
> +                prop->arrayinfo->release(obj, NULL, &elem_prop);
> +            }
> +            next = elem->next;
> +            g_free(elem);
> +        }
>           return;
>       }
>   
> -    /* DEFINE_PROP_ARRAY guarantees that name should start with this prefix;
> -     * strip it off so we can get the name of the array itself.
> +    /*
> +     * Now that we know how big the array has to be, move the data over to a
> +     * linear array and free the temporary list.
>        */
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
> +    Property *prop = opaque;
> +    uint32_t *alenptr = object_field_prop_ptr(obj, prop);
> +    void **arrayptr = (void *)obj + prop->arrayoffset;
> +    char *elem = *arrayptr;
> +    GenericList *list;
> +    const size_t list_elem_size = sizeof(*list) + prop->arrayfieldsize;
> +    int i;
> +    bool ok;
> +
> +    if (!visit_start_list(v, name, &list, list_elem_size, errp)) {
> +        return;
>       }
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
> +    /* visit_check_list() can only fail for input visitors */
> +    ok = visit_check_list(v, errp);
> +    assert(ok);
> +
> +out_obj:
> +    visit_end_list(v, (void**) &list);
>   }
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
>   };
>   
>   /* --- public helpers --- */
> @@ -743,20 +819,8 @@ void qdev_prop_set_enum(DeviceState *dev, const char *name, int value)
>   
>   void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values)
>   {
> -    const QListEntry *entry;
> -    g_autofree char *prop_len = g_strdup_printf("len-%s", name);
> -    unsigned i = 0;
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
>       qobject_unref(values);
>   }


ATB,

Mark.


