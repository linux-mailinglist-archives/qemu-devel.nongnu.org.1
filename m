Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3371A793C3F
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 14:07:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdrIX-0003yI-1V; Wed, 06 Sep 2023 08:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qdrHx-0003pi-2N
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 08:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qdrHf-0006mH-VW
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 08:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694001923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KRRDuSc9d2084GvmqFodf9hiGX03EOCVB5XMORm3G3s=;
 b=Eag6uZctWBhfQXwR/Z50xXSHxp5KB13YRW2F0JvQY0dd24ZGxDh73UIt7Uj50FCPe+X9nQ
 n1FBOa1xP0gOfMU0LPr+mDlp4qNY/97CPSHAtE8ZUm5fA/AZ3OoE6Vo7C9vycv0I00j49w
 nZvbykGpOPeqGdjkqTDSlbjmCo7AIuY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-rc5KMrzYNNq7eXek2vv_xA-1; Wed, 06 Sep 2023 08:05:20 -0400
X-MC-Unique: rc5KMrzYNNq7eXek2vv_xA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27279181792E;
 Wed,  6 Sep 2023 12:05:20 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05EE947FC73;
 Wed,  6 Sep 2023 12:05:16 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thiner Logoer <logoerthiner1@163.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v4 03/11] backends/hostmem-file: Add "rom" property to support
 VM templating with R/O files
Date: Wed,  6 Sep 2023 14:04:55 +0200
Message-ID: <20230906120503.359863-4-david@redhat.com>
In-Reply-To: <20230906120503.359863-1-david@redhat.com>
References: <20230906120503.359863-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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

For now, "share=off,readonly=on" would always result in us opening the
file R/O and mmap'ing the opened file MAP_PRIVATE R/O -- effectively
turning it into ROM.

Especially for VM templating, "share=off" is a common use case. However,
that use case is impossible with files that lack write permissions,
because "share=off,readonly=on" will not give us writable RAM.

The sole user of ROM via memory-backend-file are R/O NVDIMMs, but as we
have users (Kata Containers) that rely on the existing behavior --
malicious VMs should not be able to consume COW memory for R/O NVDIMMs --
we cannot change the semantics of "share=off,readonly=on"

So let's add a new "rom" property with on/off/auto values. "auto" is
the default and what most people will use: for historical reasons, to not
change the old semantics, it defaults to the value of the "readonly"
property.

For VM templating, one can now use:
    -object memory-backend-file,share=off,readonly=on,rom=off,...

But we'll disallow:
    -object memory-backend-file,share=on,readonly=on,rom=off,...
because we would otherwise get an error when trying to mmap the R/O file
shared and writable. An explicit error message is cleaner.

We will also disallow for now:
    -object memory-backend-file,share=off,readonly=off,rom=on,...
    -object memory-backend-file,share=on,readonly=off,rom=on,...
It's not harmful, but also not really required for now.

Alternatives that were abandoned:
* Make "unarmed=on" for the NVDIMM set the memory region container
  readonly. We would still see a change of ROM->RAM and possibly run
  into memslot limits with vhost-user. Further, there might be use cases
  for "unarmed=on" that should still allow writing to that memory
  (temporary files, system RAM, ...).
* Add a new "readonly=on/off/auto" parameter for NVDIMMs. Similar issues
  as with "unarmed=on".
* Make "readonly" consume "on/off/file" instead of being a 'bool' type.
  This would slightly changes the behavior of the "readonly" parameter:
  values like true/false (as accepted by a 'bool'type) would no longer be
  accepted.

Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 backends/hostmem-file.c | 59 ++++++++++++++++++++++++++++++++++++++++-
 qapi/qom.json           | 17 +++++++++++-
 qemu-options.hx         | 16 ++++++++++-
 3 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index ef2d5533af..361d4a8103 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -18,6 +18,8 @@
 #include "sysemu/hostmem.h"
 #include "qom/object_interfaces.h"
 #include "qom/object.h"
+#include "qapi/visitor.h"
+#include "qapi/qapi-visit-common.h"
 
 OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendFile, MEMORY_BACKEND_FILE)
 
@@ -31,6 +33,7 @@ struct HostMemoryBackendFile {
     bool discard_data;
     bool is_pmem;
     bool readonly;
+    OnOffAuto rom;
 };
 
 static void
@@ -53,9 +56,33 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         return;
     }
 
+    switch (fb->rom) {
+    case ON_OFF_AUTO_AUTO:
+        /* Traditionally, opening the file readonly always resulted in ROM. */
+        fb->rom = fb->readonly ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+        break;
+    case ON_OFF_AUTO_ON:
+        if (!fb->readonly) {
+            error_setg(errp, "property 'rom' = 'on' is not supported with"
+                       " 'readonly' = 'off'");
+            return;
+        }
+        break;
+    case ON_OFF_AUTO_OFF:
+        if (fb->readonly && backend->share) {
+            error_setg(errp, "property 'rom' = 'off' is incompatible with"
+                       " 'readonly' = 'on' and 'share' = 'on'");
+            return;
+        }
+        break;
+    default:
+        assert(false);
+    }
+
     name = host_memory_backend_get_name(backend);
     ram_flags = backend->share ? RAM_SHARED : 0;
-    ram_flags |= fb->readonly ? RAM_READONLY | RAM_READONLY_FD : 0;
+    ram_flags |= fb->readonly ? RAM_READONLY_FD : 0;
+    ram_flags |= fb->rom == ON_OFF_AUTO_ON ? RAM_READONLY : 0;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
     ram_flags |= fb->is_pmem ? RAM_PMEM : 0;
     ram_flags |= RAM_NAMED_FILE;
@@ -201,6 +228,32 @@ static void file_memory_backend_set_readonly(Object *obj, bool value,
     fb->readonly = value;
 }
 
+static void file_memory_backend_get_rom(Object *obj, Visitor *v,
+                                        const char *name, void *opaque,
+                                        Error **errp)
+{
+    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(obj);
+    OnOffAuto rom = fb->rom;
+
+    visit_type_OnOffAuto(v, name, &rom, errp);
+}
+
+static void file_memory_backend_set_rom(Object *obj, Visitor *v,
+                                        const char *name, void *opaque,
+                                        Error **errp)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(obj);
+    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(obj);
+
+    if (host_memory_backend_mr_inited(backend)) {
+        error_setg(errp, "cannot change property '%s' of %s.", name,
+                   object_get_typename(obj));
+        return;
+    }
+
+    visit_type_OnOffAuto(v, name, &fb->rom, errp);
+}
+
 static void file_backend_unparent(Object *obj)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
@@ -243,6 +296,10 @@ file_backend_class_init(ObjectClass *oc, void *data)
     object_class_property_add_bool(oc, "readonly",
         file_memory_backend_get_readonly,
         file_memory_backend_set_readonly);
+    object_class_property_add(oc, "rom", "OnOffAuto",
+        file_memory_backend_get_rom, file_memory_backend_set_rom, NULL, NULL);
+    object_class_property_set_description(oc, "rom",
+        "Whether to create Read Only Memory (ROM)");
 }
 
 static void file_backend_instance_finalize(Object *o)
diff --git a/qapi/qom.json b/qapi/qom.json
index fa3e88c8e6..c53ef978ff 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -668,6 +668,20 @@
 # @readonly: if true, the backing file is opened read-only; if false,
 #     it is opened read-write.  (default: false)
 #
+# @rom: whether to create Read Only Memory (ROM) that cannot be modified
+#       by the VM.  Any write attempts to such ROM will be denied.  Most
+#       use cases want writable RAM instead of ROM.  However, selected use
+#       cases, like R/O NVDIMMs, can benefit from ROM.  If set to 'on',
+#       create ROM; if set to 'off', create writable RAM;  if set to
+#       'auto', the value of the @readonly property is used.  This
+#       property is primarily helpful when we want to have proper RAM in
+#       configurations that would traditionally create ROM before this
+#       property was introduced: VM templating, where we want to open a
+#       file readonly (@readonly set to true) and mark the memory to be
+#       private for QEMU (@share set to false).  For this use case, we need
+#       writable RAM instead of ROM, and want to set this property to 'off'.
+#       (default: auto, since 8.2)
+#
 # Since: 2.1
 ##
 { 'struct': 'MemoryBackendFileProperties',
@@ -677,7 +691,8 @@
             '*discard-data': 'bool',
             'mem-path': 'str',
             '*pmem': { 'type': 'bool', 'if': 'CONFIG_LIBPMEM' },
-            '*readonly': 'bool' } }
+            '*readonly': 'bool',
+            '*rom': 'OnOffAuto' } }
 
 ##
 # @MemoryBackendMemfdProperties:
diff --git a/qemu-options.hx b/qemu-options.hx
index 463f520c57..7634eebd0d 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4976,7 +4976,7 @@ SRST
     they are specified. Note that the 'id' property must be set. These
     objects are placed in the '/objects' path.
 
-    ``-object memory-backend-file,id=id,size=size,mem-path=dir,share=on|off,discard-data=on|off,merge=on|off,dump=on|off,prealloc=on|off,host-nodes=host-nodes,policy=default|preferred|bind|interleave,align=align,offset=offset,readonly=on|off``
+    ``-object memory-backend-file,id=id,size=size,mem-path=dir,share=on|off,discard-data=on|off,merge=on|off,dump=on|off,prealloc=on|off,host-nodes=host-nodes,policy=default|preferred|bind|interleave,align=align,offset=offset,readonly=on|off,rom=on|off|auto``
         Creates a memory file backend object, which can be used to back
         the guest RAM with huge pages.
 
@@ -5066,6 +5066,20 @@ SRST
         The ``readonly`` option specifies whether the backing file is opened
         read-only or read-write (default).
 
+        The ``rom`` option specifies whether to create Read Only Memory
+        (ROM) that cannot be modified by the VM. Any write attempts to such
+        ROM will be denied. Most use cases want proper RAM instead of ROM.
+        However, selected use cases, like R/O NVDIMMs, can benefit from
+        ROM. If set to ``on``, create ROM; if set to ``off``, create
+        writable RAM; if set to ``auto`` (default), the value of the
+        ``readonly`` option is used. This option is primarily helpful when
+        we want to have writable RAM in configurations that would
+        traditionally create ROM before the ``rom`` option was introduced:
+        VM templating, where we want to open a file readonly
+        (``readonly=on``) and mark the memory to be private for QEMU
+        (``share=off``). For this use case, we need writable RAM instead
+        of ROM, and want to also set ``rom=off``.
+
     ``-object memory-backend-ram,id=id,merge=on|off,dump=on|off,share=on|off,prealloc=on|off,size=size,host-nodes=host-nodes,policy=default|preferred|bind|interleave``
         Creates a memory backend object, which can be used to back the
         guest RAM. Memory backend objects offer more control than the
-- 
2.41.0


