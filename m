Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A57937E7099
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 18:44:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1943-0003la-41; Thu, 09 Nov 2023 12:43:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r1940-0003ik-5c
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:43:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r193x-0004rX-LS
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699551807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZAJHTnjAWTvJxIVcj6K2NpUMu7yvdMDqgo3eS8mj08=;
 b=iYKE2aPla4zNuOqwSnZUKwy+95gcO63+jj1iGlMo6zCyCzYpkmdLgzJ3xivVLQ3KArKn2l
 VT94tw7vVJEoe/Cde8h23V7Jz5VIMCxb4lgQ9KUt2GbLzVAxi8w4gQjnNcRP3Zlep48Iry
 7EAzUVCH0iGJAZMLEejgVE0ql9MCtIM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-eFwAzH6rPvadijmiHD_Haw-1; Thu, 09 Nov 2023 12:43:23 -0500
X-MC-Unique: eFwAzH6rPvadijmiHD_Haw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 784E6101A529;
 Thu,  9 Nov 2023 17:43:23 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6CF9F2026D37;
 Thu,  9 Nov 2023 17:43:22 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v3 11/11] qdev: Rework array properties based on list visitor
Date: Thu,  9 Nov 2023 18:42:40 +0100
Message-ID: <20231109174240.72376-12-kwolf@redhat.com>
In-Reply-To: <20231109174240.72376-1-kwolf@redhat.com>
References: <20231109174240.72376-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Until now, array properties are actually implemented with a hack that
uses multiple properties on the QOM level: a static "foo-len" property
and after it is set, dynamically created "foo[i]" properties.

In external interfaces (-device on the command line and device_add in
QMP), this interface was broken by commit f3558b1b ('qdev: Base object
creation on QDict rather than QemuOpts') because QDicts are unordered
and therefore it could happen that QEMU tried to set the indexed
properties before setting the length, which fails and effectively makes
array properties inaccessible. In particular, this affects the 'ports'
property of the 'rocker' device, which used to be configured like this:

-device rocker,len-ports=2,ports[0]=dev0,ports[1]=dev1

This patch reworks the external interface so that instead of using a
separate top-level property for the length and for each element, we use
a single true array property that accepts a list value. In the external
interfaces, this is naturally expressed as a JSON list and makes array
properties accessible again. The new syntax looks like this:

-device '{"driver":"rocker","ports":["dev0","dev1"]}'

Creating an array property on the command line without using JSON format
is currently not possible. This could be fixed by switching from
QemuOpts to a keyval parser, which however requires consideration of the
compatibility implications.

All internal users of devices with array properties go through
qdev_prop_set_array() at this point, so updating it takes care of all of
them.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1090
Fixes: f3558b1b763683bb877f7dd5b282469cdadc65c3
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/hw/qdev-properties.h |  35 +++---
 hw/core/qdev-properties.c    | 237 +++++++++++++++++++++++------------
 2 files changed, 172 insertions(+), 100 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 7fa2fdb7c9..25743a29a0 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -61,7 +61,7 @@ extern const PropertyInfo qdev_prop_size;
 extern const PropertyInfo qdev_prop_string;
 extern const PropertyInfo qdev_prop_on_off_auto;
 extern const PropertyInfo qdev_prop_size32;
-extern const PropertyInfo qdev_prop_arraylen;
+extern const PropertyInfo qdev_prop_array;
 extern const PropertyInfo qdev_prop_link;
 
 #define DEFINE_PROP(_name, _state, _field, _prop, _type, ...) {  \
@@ -115,8 +115,6 @@ extern const PropertyInfo qdev_prop_link;
                 .bitmask    = (_bitmask),                     \
                 .set_default = false)
 
-#define PROP_ARRAY_LEN_PREFIX "len-"
-
 /**
  * DEFINE_PROP_ARRAY:
  * @_name: name of the array
@@ -127,28 +125,25 @@ extern const PropertyInfo qdev_prop_link;
  * @_arrayprop: PropertyInfo defining what property the array elements have
  * @_arraytype: C type of the array elements
  *
- * Define device properties for a variable-length array _name.  A
- * static property "len-arrayname" is defined. When the device creator
- * sets this property to the desired length of array, further dynamic
- * properties "arrayname[0]", "arrayname[1]", ...  are defined so the
- * device creator can set the array element values. Setting the
- * "len-arrayname" property more than once is an error.
+ * Define device properties for a variable-length array _name.  The array is
+ * represented as a list in the visitor interface.
+ *
+ * @_arraytype is required to be movable with memcpy().
  *
- * When the array length is set, the @_field member of the device
+ * When the array property is set, the @_field member of the device
  * struct is set to the array length, and @_arrayfield is set to point
- * to (zero-initialised) memory allocated for the array.  For a zero
- * length array, @_field will be set to 0 and @_arrayfield to NULL.
+ * to the memory allocated for the array.
+ *
  * It is the responsibility of the device deinit code to free the
  * @_arrayfield memory.
  */
-#define DEFINE_PROP_ARRAY(_name, _state, _field,               \
-                          _arrayfield, _arrayprop, _arraytype) \
-    DEFINE_PROP((PROP_ARRAY_LEN_PREFIX _name),                 \
-                _state, _field, qdev_prop_arraylen, uint32_t,  \
-                .set_default = true,                           \
-                .defval.u = 0,                                 \
-                .arrayinfo = &(_arrayprop),                    \
-                .arrayfieldsize = sizeof(_arraytype),          \
+#define DEFINE_PROP_ARRAY(_name, _state, _field,                        \
+                          _arrayfield, _arrayprop, _arraytype)          \
+    DEFINE_PROP(_name, _state, _field, qdev_prop_array, uint32_t,       \
+                .set_default = true,                                    \
+                .defval.u = 0,                                          \
+                .arrayinfo = &(_arrayprop),                             \
+                .arrayfieldsize = sizeof(_arraytype),                   \
                 .arrayoffset = offsetof(_state, _arrayfield))
 
 #define DEFINE_PROP_LINK(_name, _state, _field, _type, _ptr_type)     \
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 950ef48e01..91632f7be9 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -546,98 +546,187 @@ const PropertyInfo qdev_prop_size32 = {
 
 /* --- support for array properties --- */
 
-/* Used as an opaque for the object properties we add for each
- * array element. Note that the struct Property must be first
- * in the struct so that a pointer to this works as the opaque
- * for the underlying element's property hooks as well as for
- * our own release callback.
+typedef struct ArrayElementList ArrayElementList;
+
+struct ArrayElementList {
+    ArrayElementList *next;
+    void *value;
+};
+
+/*
+ * Given an array property @parent_prop in @obj, return a Property for a
+ * specific element of the array. Arrays are backed by an uint32_t length field
+ * and an element array. @elem points at an element in this element array.
  */
-typedef struct {
-    struct Property prop;
-    char *propname;
-    ObjectPropertyRelease *release;
-} ArrayElementProperty;
-
-/* object property release callback for array element properties:
- * we call the underlying element's property release hook, and
- * then free the memory we allocated when we added the property.
+static Property array_elem_prop(Object *obj, Property *parent_prop,
+                                const char *name, char *elem)
+{
+    return (Property) {
+        .info = parent_prop->arrayinfo,
+        .name = name,
+        /*
+         * This ugly piece of pointer arithmetic sets up the offset so
+         * that when the underlying release hook calls qdev_get_prop_ptr
+         * they get the right answer despite the array element not actually
+         * being inside the device struct.
+         */
+        .offset = (uintptr_t)elem - (uintptr_t)obj,
+    };
+}
+
+/*
+ * Object property release callback for array properties: We call the
+ * underlying element's property release hook for each element.
+ *
+ * Note that it is the responsibility of the individual device's deinit
+ * to free the array proper.
  */
-static void array_element_release(Object *obj, const char *name, void *opaque)
+static void release_prop_array(Object *obj, const char *name, void *opaque)
 {
-    ArrayElementProperty *p = opaque;
-    if (p->release) {
-        p->release(obj, name, opaque);
+    Property *prop = opaque;
+    uint32_t *alenptr = object_field_prop_ptr(obj, prop);
+    void **arrayptr = (void *)obj + prop->arrayoffset;
+    char *elem = *arrayptr;
+    int i;
+
+    if (!prop->arrayinfo->release) {
+        return;
+    }
+
+    for (i = 0; i < *alenptr; i++) {
+        Property elem_prop = array_elem_prop(obj, prop, name, elem);
+        prop->arrayinfo->release(obj, NULL, &elem_prop);
+        elem += prop->arrayfieldsize;
     }
-    g_free(p->propname);
-    g_free(p);
 }
 
-static void set_prop_arraylen(Object *obj, Visitor *v, const char *name,
-                              void *opaque, Error **errp)
+/*
+ * Setter for an array property. This sets both the array length (which
+ * is technically the property field in the object) and the array itself
+ * (a pointer to which is stored in the additional field described by
+ * prop->arrayoffset).
+ */
+static void set_prop_array(Object *obj, Visitor *v, const char *name,
+                           void *opaque, Error **errp)
 {
-    /* Setter for the property which defines the length of a
-     * variable-sized property array. As well as actually setting the
-     * array-length field in the device struct, we have to create the
-     * array itself and dynamically add the corresponding properties.
-     */
+    ERRP_GUARD();
     Property *prop = opaque;
     uint32_t *alenptr = object_field_prop_ptr(obj, prop);
     void **arrayptr = (void *)obj + prop->arrayoffset;
-    void *eltptr;
-    const char *arrayname;
-    int i;
+    ArrayElementList *list, *elem, *next;
+    const size_t size = sizeof(*list);
+    char *elemptr;
+    bool ok = true;
 
     if (*alenptr) {
         error_setg(errp, "array size property %s may not be set more than once",
                    name);
         return;
     }
-    if (!visit_type_uint32(v, name, alenptr, errp)) {
+
+    if (!visit_start_list(v, name, (GenericList **) &list, size, errp)) {
         return;
     }
-    if (!*alenptr) {
+
+    /* Read the whole input into a temporary list */
+    elem = list;
+    while (elem) {
+        Property elem_prop;
+
+        elem->value = g_malloc0(prop->arrayfieldsize);
+        elem_prop = array_elem_prop(obj, prop, name, elem->value);
+        prop->arrayinfo->set(obj, v, NULL, &elem_prop, errp);
+        if (*errp) {
+            ok = false;
+            goto out_obj;
+        }
+        if (*alenptr == INT_MAX) {
+            error_setg(errp, "array is too big");
+            return;
+        }
+        (*alenptr)++;
+        elem = (ArrayElementList *) visit_next_list(v, (GenericList*) elem,
+                                                    size);
+    }
+
+    ok = visit_check_list(v, errp);
+out_obj:
+    visit_end_list(v, (void**) &list);
+
+    if (!ok) {
+        for (elem = list; elem; elem = next) {
+            Property elem_prop = array_elem_prop(obj, prop, name,
+                                                 elem->value);
+            if (prop->arrayinfo->release) {
+                prop->arrayinfo->release(obj, NULL, &elem_prop);
+            }
+            next = elem->next;
+            g_free(elem->value);
+            g_free(elem);
+        }
         return;
     }
 
-    /* DEFINE_PROP_ARRAY guarantees that name should start with this prefix;
-     * strip it off so we can get the name of the array itself.
+    /*
+     * Now that we know how big the array has to be, move the data over to a
+     * linear array and free the temporary list.
      */
-    assert(strncmp(name, PROP_ARRAY_LEN_PREFIX,
-                   strlen(PROP_ARRAY_LEN_PREFIX)) == 0);
-    arrayname = name + strlen(PROP_ARRAY_LEN_PREFIX);
+    *arrayptr = g_malloc_n(*alenptr, prop->arrayfieldsize);
+    elemptr = *arrayptr;
+    for (elem = list; elem; elem = next) {
+        memcpy(elemptr, elem->value, prop->arrayfieldsize);
+        elemptr += prop->arrayfieldsize;
+        next = elem->next;
+        g_free(elem->value);
+        g_free(elem);
+    }
+}
 
-    /* Note that it is the responsibility of the individual device's deinit
-     * to free the array proper.
-     */
-    *arrayptr = eltptr = g_malloc0(*alenptr * prop->arrayfieldsize);
-    for (i = 0; i < *alenptr; i++, eltptr += prop->arrayfieldsize) {
-        char *propname = g_strdup_printf("%s[%d]", arrayname, i);
-        ArrayElementProperty *arrayprop = g_new0(ArrayElementProperty, 1);
-        arrayprop->release = prop->arrayinfo->release;
-        arrayprop->propname = propname;
-        arrayprop->prop.info = prop->arrayinfo;
-        arrayprop->prop.name = propname;
-        /* This ugly piece of pointer arithmetic sets up the offset so
-         * that when the underlying get/set hooks call qdev_get_prop_ptr
-         * they get the right answer despite the array element not actually
-         * being inside the device struct.
-         */
-        arrayprop->prop.offset = eltptr - (void *)obj;
-        assert(object_field_prop_ptr(obj, &arrayprop->prop) == eltptr);
-        object_property_add(obj, propname,
-                            arrayprop->prop.info->name,
-                            field_prop_getter(arrayprop->prop.info),
-                            field_prop_setter(arrayprop->prop.info),
-                            array_element_release,
-                            arrayprop);
+static void get_prop_array(Object *obj, Visitor *v, const char *name,
+                           void *opaque, Error **errp)
+{
+    ERRP_GUARD();
+    Property *prop = opaque;
+    uint32_t *alenptr = object_field_prop_ptr(obj, prop);
+    void **arrayptr = (void *)obj + prop->arrayoffset;
+    char *elem = *arrayptr;
+    GenericList *list;
+    const size_t list_elem_size = sizeof(*list) + prop->arrayfieldsize;
+    int i;
+    bool ok;
+
+    if (!visit_start_list(v, name, &list, list_elem_size, errp)) {
+        return;
     }
+
+    for (i = 0; i < *alenptr; i++) {
+        Property elem_prop = array_elem_prop(obj, prop, name, elem);
+        prop->arrayinfo->get(obj, v, NULL, &elem_prop, errp);
+        if (*errp) {
+            goto out_obj;
+        }
+        elem += prop->arrayfieldsize;
+    }
+
+    /* visit_check_list() can only fail for input visitors */
+    ok = visit_check_list(v, errp);
+    assert(ok);
+
+out_obj:
+    visit_end_list(v, (void**) &list);
 }
 
-const PropertyInfo qdev_prop_arraylen = {
-    .name = "uint32",
-    .get = get_uint32,
-    .set = set_prop_arraylen,
-    .set_default_value = qdev_propinfo_set_default_value_uint,
+static void default_prop_array(ObjectProperty *op, const Property *prop)
+{
+    object_property_set_default_list(op);
+}
+
+const PropertyInfo qdev_prop_array = {
+    .name = "list",
+    .get = get_prop_array,
+    .set = set_prop_array,
+    .release = release_prop_array,
+    .set_default_value = default_prop_array,
 };
 
 /* --- public helpers --- */
@@ -743,20 +832,8 @@ void qdev_prop_set_enum(DeviceState *dev, const char *name, int value)
 
 void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values)
 {
-    const QListEntry *entry;
-    g_autofree char *prop_len = g_strdup_printf("len-%s", name);
-    uint32_t i = 0;
-
-    object_property_set_int(OBJECT(dev), prop_len, qlist_size(values),
-                            &error_abort);
-
-    QLIST_FOREACH_ENTRY(values, entry) {
-        g_autofree char *prop_idx = g_strdup_printf("%s[%u]", name, i);
-        object_property_set_qobject(OBJECT(dev), prop_idx, entry->value,
-                                    &error_abort);
-        i++;
-    }
-
+    object_property_set_qobject(OBJECT(dev), name, QOBJECT(values),
+                                &error_abort);
     qobject_unref(values);
 }
 
-- 
2.41.0


