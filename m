Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C9D821333
	for <lists+qemu-devel@lfdr.de>; Mon,  1 Jan 2024 08:55:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKD7T-00054k-Fh; Mon, 01 Jan 2024 02:53:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rKD7Q-00053k-JX
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 02:53:52 -0500
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rKD7O-0007QN-Fg
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 02:53:52 -0500
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-427b8775aebso51860331cf.1
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 23:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704095629; x=1704700429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8FUEEGnGsBaweemMprQnXlz3wR+5ydknYqnb+TOQpYo=;
 b=jhT7iw9yegd/R9AE0kfASXPchHT6JlOCIoD/ZhUO+8WyMzCXRQDERpsnhI3SIQ8l4d
 iY61bTRVFb4CNET2DcPKtMXHERPD8eNKX8WjhTlbvvn/6500x36ktZUQ5YsWS9eE1Asi
 pQdr1FWo7uQyMg8AQJcKKAwOURIWxhOFLE24KnMoS4Zv0PtsSPQc/vldu+iuq44STO2o
 uwuoYvlQkJntUvc26dopDlonC07fnVCLXVgxXsRKtT53axlQJrxjA36q01BM8D6Ol/Ce
 b7UqsxXCP9o5f2QJ3VHYzfQSMCGhn5XNuo3EATI4R9O+JPl0P8bARM6DRCs7Sr1R4yvk
 8/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704095629; x=1704700429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8FUEEGnGsBaweemMprQnXlz3wR+5ydknYqnb+TOQpYo=;
 b=pB0kSEWdBJ38g32TIHQvbGe+ccAJhoi/qshc70vb+ZXSAc3s6Ts//Xr9Z4jp2g1E22
 5AAUSV+e/yQerG8FTI+3GGBPWRLbbBSk+dE179lLUGFocXOYLTUuYX/B9N1gEvxZNHRy
 C5MZe61y1QZ2nOlH355ABH32iFlBVtHcVH/LlAGdkObRAzCNyuvDPVjs+RQrmVA+6RKb
 BrWREncvU5++4LLQmd9VxOLmnnjG2PEC2rOJKMGklQovxe9Un29m3SVIJbUlxN4zasoF
 WDgO6l7LpYlStA+1lfuG+O3IOorzo2lvVUv+uS72UkpQ2qdBGDHQLtK6kdxcaBijI6Q6
 TZww==
X-Gm-Message-State: AOJu0YyBKYlFZ8fPuOAZGYYORg5ucmW5sD+QR8ZZfA4faxEJrEtbhzr1
 Ioi7oNQQdtb5uXlGfmA8HGxZCiWsclAc+w==
X-Google-Smtp-Source: AGHT+IETp0NQPl5rZvtW0mxc9ERREZGzkHxXHcf0ZU9nXvUfuC9skWSvcJ3vGosbP2+gSBWH9Uih3w==
X-Received: by 2002:ac8:5795:0:b0:428:1de2:e591 with SMTP id
 v21-20020ac85795000000b004281de2e591mr1762564qta.57.1704095629024; 
 Sun, 31 Dec 2023 23:53:49 -0800 (PST)
Received: from n73-164-11.byted.org ([72.29.204.230])
 by smtp.gmail.com with ESMTPSA id
 bx4-20020a05622a090400b00427f5c73636sm4465361qtb.27.2023.12.31.23.53.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 23:53:48 -0800 (PST)
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 "Hao Xiang" <hao.xiang@bytedance.com>,
 "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 "Ben Widawsky" <ben.widawsky@intel.com>,
 "Gregory Price" <gourry.memverge@gmail.com>, "Fan Ni" <fan.ni@samsung.com>,
 "Ira Weiny" <ira.weiny@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Cc: "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 linux-cxl@vger.kernel.org
Subject: [QEMU-devel][RFC PATCH 1/1] backends/hostmem: qapi/qom: Add an
 ObjectOption for memory-backend-* called HostMemType and its arg 'cxlram'
Date: Sun, 31 Dec 2023 23:53:15 -0800
Message-Id: <20240101075315.43167-2-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240101075315.43167-1-horenchuang@bytedance.com>
References: <20240101075315.43167-1-horenchuang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=horenchuang@bytedance.com; helo=mail-qt1-x834.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Introduce a new configuration option 'host-mem-type=' in the
'-object memory-backend-ram', allowing users to specify
from which type of memory to allocate.

Users can specify 'cxlram' as an argument, and QEMU will then
automatically locate CXL RAM NUMA nodes and use them as the backend memory.
For example:
	-object memory-backend-ram,id=vmem0,size=19G,host-mem-type=cxlram \
	-device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
	-device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
	-device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0 \
	-M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=19G,cxl-fmw.0.interleave-granularity=8k \

In v1, we plan to move most of the implementations to util and break down
this patch into different smaller patches.

Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 backends/hostmem.c       | 184 +++++++++++++++++++++++++++++++++++++++
 include/sysemu/hostmem.h |   1 +
 qapi/common.json         |  19 ++++
 qapi/qom.json            |   1 +
 qemu-options.hx          |   2 +-
 5 files changed, 206 insertions(+), 1 deletion(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 747e7838c0..3bede13879 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -44,6 +44,133 @@ host_memory_backend_get_name(HostMemoryBackend *backend)
     return object_get_canonical_path(OBJECT(backend));
 }
 
+#define FILE_LINE_LEN 256
+static int
+is_valid_node(const char *path) {
+    FILE *file = fopen(path, "r");
+    if (file == NULL) {
+        return -1;
+    }
+
+    char line[FILE_LINE_LEN];
+    if (fgets(line, sizeof(line), file) != NULL) {
+        int target_node = atoi(line);
+
+        if (target_node >= 0) {
+            fclose(file);
+            return target_node;
+        }
+    }
+
+    fclose(file);
+    return -1;
+}
+
+static int
+is_directory(const char *path) {
+    struct stat path_stat;
+    stat(path, &path_stat);
+    return S_ISDIR(path_stat.st_mode);
+}
+
+static int
+is_symlink(const char *path) {
+    struct stat path_stat;
+    if (lstat(path, &path_stat) == -1) {
+        return 0;
+    }
+    return S_ISLNK(path_stat.st_mode);
+}
+
+#define CXL_DEVICE_PATH "/sys/bus/cxl/devices/"
+#define REGION_PATH_LEN 307
+#define DAX_REGION_PATH_LEN 563
+#define DAX_PATH_LEN 819
+#define TARGET_FILE_PATH_LEN 831
+/*
+ * return: the number of valid numa node id found
+ */
+static int
+host_memory_backend_get_cxlram_nodes(int *valid_cxlram_nodes) {
+    DIR *base_dir = NULL, *region_dir = NULL, *dax_region_dir = NULL;
+    const char *base_dir_path = CXL_DEVICE_PATH;
+    struct dirent *entry;
+    int valid_node = 0, ret = 0;
+
+    base_dir = opendir(base_dir_path);
+    if (base_dir == NULL) {
+        return valid_node;
+    }
+
+    while ((entry = readdir(base_dir)) != NULL) {
+        char region_path[REGION_PATH_LEN];
+
+        ret = snprintf(region_path, sizeof(region_path), "%s%s",
+                                            base_dir_path, entry->d_name);
+        if (ret < 0 ||
+            !is_symlink(region_path) ||
+            strncmp(entry->d_name, "region", ARRAY_SIZE("region") - 1)) {
+            continue;
+        }
+
+        region_dir = opendir(region_path);
+        if (region_dir == NULL) {
+            goto region_exit;
+        }
+
+        while ((entry = readdir(region_dir)) != NULL) {
+            char dax_region_path[DAX_REGION_PATH_LEN];
+
+            ret = snprintf(dax_region_path, sizeof(dax_region_path), "%s/%s",
+                                                    region_path, entry->d_name);
+            if (ret < 0 ||
+                !is_directory(dax_region_path) ||
+                strncmp(entry->d_name, "dax_region",
+                            ARRAY_SIZE("dax_region") - 1)) {
+
+                continue;
+            }
+
+            dax_region_dir = opendir(dax_region_path);
+            if (dax_region_dir == NULL) {
+                goto dax_region_exit;
+            }
+
+            while ((entry = readdir(dax_region_dir)) != NULL) {
+                int target_node;
+                char dax_path[DAX_PATH_LEN];
+                char target_file_path[TARGET_FILE_PATH_LEN];
+                ret = snprintf(dax_path, sizeof(dax_path), "%s/%s",
+                                            dax_region_path, entry->d_name);
+                if (ret < 0 ||
+                    !is_directory(dax_path) ||
+                    strncmp(entry->d_name, "dax", ARRAY_SIZE("dax") - 1)) {
+                    continue;
+                }
+
+                ret = snprintf(target_file_path, sizeof(target_file_path),
+                                                    "%s/target_node", dax_path);
+                if (ret < 0) {
+                    continue;
+                }
+
+                target_node = is_valid_node(target_file_path);
+                if (target_node >= 0) {
+                    valid_cxlram_nodes[valid_node] = target_node;
+                    valid_node++;
+                }
+            }
+        }
+    }
+
+    closedir(dax_region_dir);
+dax_region_exit:
+    closedir(region_dir);
+region_exit:
+    closedir(base_dir);
+    return valid_node;
+}
+
 static void
 host_memory_backend_get_size(Object *obj, Visitor *v, const char *name,
                              void *opaque, Error **errp)
@@ -117,6 +244,12 @@ host_memory_backend_set_host_nodes(Object *obj, Visitor *v, const char *name,
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
     uint16List *l, *host_nodes = NULL;
 
+    if (backend->host_mem_type == HOST_MEM_TYPE_CXLRAM) {
+        error_setg(errp,
+            "'host-mem-type=' and 'host-nodes='/'policy=' are incompatible");
+        return;
+    }
+
     visit_type_uint16List(v, name, &host_nodes, errp);
 
     for (l = host_nodes; l; l = l->next) {
@@ -150,6 +283,11 @@ host_memory_backend_set_policy(Object *obj, int policy, Error **errp)
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
     backend->policy = policy;
 
+    if (backend->host_mem_type == HOST_MEM_TYPE_CXLRAM) {
+        error_setg(errp,
+            "'host-mem-type=' and 'host-nodes='/'policy=' are incompatible");
+    }
+
 #ifndef CONFIG_NUMA
     if (policy != HOST_MEM_POLICY_DEFAULT) {
         error_setg(errp, "NUMA policies are not supported by this QEMU");
@@ -157,6 +295,46 @@ host_memory_backend_set_policy(Object *obj, int policy, Error **errp)
 #endif
 }
 
+static int
+host_memory_backend_get_host_mem_type(Object *obj, Error **errp G_GNUC_UNUSED)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(obj);
+    return backend->host_mem_type;
+}
+
+static void
+host_memory_backend_set_host_mem_type(Object *obj, int host_mem_type, Error **errp)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(obj);
+    backend->host_mem_type = host_mem_type;
+
+#ifndef CONFIG_NUMA
+    error_setg(errp, "NUMA node host memory types are not supported by this QEMU");
+#else
+    int i, valid_cxlram_nodes[MAX_NODES];
+
+    if (backend->policy > 0 ||
+        !bitmap_empty(backend->host_nodes, MAX_NODES)) {
+        error_setg(errp,
+            "'host-mem-type=' and 'host-nodes='/'policy=' are incompatible");
+        return;
+    }
+
+    if (host_memory_backend_get_cxlram_nodes(valid_cxlram_nodes) > 0) {
+        for (i = 0; i < MAX_NODES; i++) {
+            if (valid_cxlram_nodes[i] < 0) {
+                break;
+            }
+            bitmap_set(backend->host_nodes, valid_cxlram_nodes[i], 1);
+        }
+    } else {
+        error_setg(errp, "Cannot find CXL RAM on host");
+        return;
+    }
+    backend->policy = HOST_MEM_POLICY_BIND;
+#endif
+}
+
 static bool host_memory_backend_get_merge(Object *obj, Error **errp)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
@@ -536,6 +714,12 @@ host_memory_backend_class_init(ObjectClass *oc, void *data)
         host_memory_backend_get_share, host_memory_backend_set_share);
     object_class_property_set_description(oc, "share",
         "Mark the memory as private to QEMU or shared");
+    object_class_property_add_enum(oc, "host-mem-type", "HostMemType",
+        &HostMemType_lookup,
+        host_memory_backend_get_host_mem_type,
+        host_memory_backend_set_host_mem_type);
+    object_class_property_set_description(oc, "host-mem-type",
+        "Set the backend host memory type");
 #ifdef CONFIG_LINUX
     object_class_property_add_bool(oc, "reserve",
         host_memory_backend_get_reserve, host_memory_backend_set_reserve);
diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index 39326f1d4f..afeb9b71d1 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -70,6 +70,7 @@ struct HostMemoryBackend {
     ThreadContext *prealloc_context;
     DECLARE_BITMAP(host_nodes, MAX_NODES + 1);
     HostMemPolicy policy;
+    HostMemType host_mem_type;
 
     MemoryRegion mr;
 };
diff --git a/qapi/common.json b/qapi/common.json
index 6fed9cde1a..591fd73291 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -167,6 +167,25 @@
 { 'enum': 'HostMemPolicy',
   'data': [ 'default', 'preferred', 'bind', 'interleave' ] }
 
+##
+# @HostMemType:
+#
+# Automatically find a backend memory type on host.
+# Can be further extened to support other types such as cxlpmem, hbm.
+#
+# @none: do nothing (default).
+#
+# @cxlram: a CXL RAM backend on host.
+#
+# Note: HostMemType and HostMemPolicy/host-nodes cannot be set at the same
+# time. HostMemType is used to automatically bind with one kind of
+# host memory types.
+#
+# Since: 8.3
+##
+{ 'enum': 'HostMemType',
+  'data': [ 'none', 'cxlram' ] }
+
 ##
 # @NetFilterDirection:
 #
diff --git a/qapi/qom.json b/qapi/qom.json
index 95516ba325..fa3bc29708 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -626,6 +626,7 @@
             '*host-nodes': ['uint16'],
             '*merge': 'bool',
             '*policy': 'HostMemPolicy',
+            '*host-mem-type': 'HostMemType',
             '*prealloc': 'bool',
             '*prealloc-threads': 'uint32',
             '*prealloc-context': 'str',
diff --git a/qemu-options.hx b/qemu-options.hx
index b66570ae00..39074c1aa0 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5211,7 +5211,7 @@ SRST
         (``share=off``). For this use case, we need writable RAM instead
         of ROM, and want to also set ``rom=off``.
 
-    ``-object memory-backend-ram,id=id,merge=on|off,dump=on|off,share=on|off,prealloc=on|off,size=size,host-nodes=host-nodes,policy=default|preferred|bind|interleave``
+    ``-object memory-backend-ram,id=id,merge=on|off,dump=on|off,share=on|off,prealloc=on|off,size=size,host-mem-type=cxlram,host-nodes=host-nodes,policy=default|preferred|bind|interleave``
         Creates a memory backend object, which can be used to back the
         guest RAM. Memory backend objects offer more control than the
         ``-m`` option that is traditionally used to define guest RAM.
-- 
Regards,
Hao Xiang and Ho-Ren (Jack) Chuang


