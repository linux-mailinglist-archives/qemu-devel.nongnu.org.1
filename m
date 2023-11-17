Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B927EEB34
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 03:49:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3otH-00011e-Nd; Thu, 16 Nov 2023 21:47:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1r3oRq-0007zO-MK
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 21:19:10 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1r3oRo-0003Tx-Li
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 21:19:10 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-41cbf31da84so8175291cf.0
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 18:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700187546; x=1700792346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MDsi/eHH6cNPGDKxqKHoPLffLHpmLdfKEynt7jrqP/g=;
 b=mQpjsPAMI0HvKj8W6ESqo4B2CzRCLTtr+rDJ2C27u2npNqkN9bYTVEhQlrIjeEHb2S
 NE3QHNYpo1ORf6liOfzviJeHum8tQuN3NoErqu6qyuurDjytAfq7W2v9jNYscGftySAL
 Y9ULm959mPumuh56VSTNVFqxbibSj8xnLNOk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700187546; x=1700792346;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MDsi/eHH6cNPGDKxqKHoPLffLHpmLdfKEynt7jrqP/g=;
 b=iR6JApHMCL55TuXxUYSd+D5x+Nrwrf+hJCZv06kR9qMofp/U1Ei0rF7QOz/mFUiSLd
 tQk6LLe//08iKEvq4KE/bVhi99JyC+WYlmFJ7l5HNtwT2CrznTTk7rhkfND1dAnRWLhB
 Wvti4Ai7tIPpDwcP7Phr1hnj4zfOWvCS29OKXafOK0OH/ZkGOx3n4zrRGsIceT6PfYrV
 P+hSpGQJNeVJtdMDYAYwuqrIVjxEnEbcAGTnKLjZGr4vzNzjH0X3IAfDM2H6QnX9rn81
 Tin0he2CulObL0Emz+94OiRreBQOdesl46pLClvDww/bu5zPy27uv3fKO7dHTCaTGYJr
 fNPw==
X-Gm-Message-State: AOJu0YwoG0hYNyYxx5yy3cxbIIGz4PNglOFsMUci9HXAtL83aqwYCY7y
 dW2CbD4gS6hbrvtW1WzwGA0kcC+WsVakTJP+bT4=
X-Google-Smtp-Source: AGHT+IFnXsA6a5MH1h9KYInDPwYCXG2dG7/OwrFssKYsMKa6JtvWMfbqyof7F5nSO8JrpB0MK9rSPA==
X-Received: by 2002:a05:622a:1003:b0:41e:3ca6:2b37 with SMTP id
 d3-20020a05622a100300b0041e3ca62b37mr12229907qte.2.1700187546417; 
 Thu, 16 Nov 2023 18:19:06 -0800 (PST)
Received: from kea.bld.corp.google.com ([100.107.108.219])
 by smtp.gmail.com with ESMTPSA id
 o10-20020ac86d0a000000b004181aa90b46sm250970qtt.89.2023.11.16.18.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 18:19:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Simon Glass <sjg@chromium.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v2] hw/arm/virt: Allow additions to the generated device tree
Date: Thu, 16 Nov 2023 19:18:26 -0700
Message-ID: <20231117021840.117874-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=sjg@chromium.org; helo=mail-qt1-x832.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 16 Nov 2023 21:47:26 -0500
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

At present qemu creates a device tree automatically with the 'virt' generic
virtual platform. This is very convenient in most cases but there is not
much control over what is generated.

Add a way to provide a device tree binary file with additional properties
to add before booting. This provides flexibility for situations where
Linux needs some tweak to operate correctly. It also allows configuration
information to be passed to U-Boot, supporting verified boot, for example.

The term 'merge' is used here to avoid confusion with device tree overlays,
which are a particular type of format.

[resending this as the original patch has gone stale]

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Rebase to master

 docs/system/arm/virt.rst |  13 +++-
 hw/arm/virt.c            | 135 +++++++++++++++++++++++++++++++++++++++
 hw/core/machine.c        |  20 ++++++
 include/hw/boards.h      |   1 +
 qemu-options.hx          |   8 +++
 system/vl.c              |   3 +
 6 files changed, 178 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 7c4c80180c..0f63a773f2 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -186,8 +186,17 @@ Hardware configuration information for bare-metal programming
 The ``virt`` board automatically generates a device tree blob ("dtb")
 which it passes to the guest. This provides information about the
 addresses, interrupt lines and other configuration of the various devices
-in the system. Guest code can rely on and hard-code the following
-addresses:
+in the system.
+
+The optional ``-dtbi`` argument is used to specify a device tree blob to merge
+with this generated device tree, to add any properties required by the guest but
+not included by qemu. Properties are merged after the generated device tree is
+created, so take precedence over generated properties. This can be useful for
+overriding the ``stdout-path`` for Linux, for example, or to add configuration
+information needed by U-Boot. This is intended for simple nodes and properties
+and does not support use of phandles or device tree overlays.
+
+Guest code can rely on and hard-code the following addresses:
 
 - Flash memory starts at address 0x0000_0000
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index be2856c018..fb790a2e24 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -41,6 +41,7 @@
 #include "hw/vfio/vfio-calxeda-xgmac.h"
 #include "hw/vfio/vfio-amd-xgbe.h"
 #include "hw/display/ramfb.h"
+#include <libfdt.h>
 #include "net/net.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/numa.h"
@@ -320,6 +321,135 @@ static void create_fdt(VirtMachineState *vms)
     }
 }
 
+
+/*
+ * From U-Boot v2021.07 (under BSD-2-Clause license)
+ *
+ * This does not use the qemu_fdt interface because that requires node names.
+ * Here we are using offsets.
+ *
+ * overlay_apply_node - Merges a node into the base device tree
+ * @fdt: Base Device Tree blob
+ * @target: Node offset in the base device tree to apply the fragment to
+ * @fdto: Device tree overlay blob
+ * @node: Node offset in the overlay holding the changes to merge
+ *
+ * overlay_apply_node() merges a node into a target base device tree
+ * node pointed.
+ *
+ * This is part of the final step in the device tree overlay
+ * application process, when all the phandles have been adjusted and
+ * resolved and you just have to merge overlay into the base device
+ * tree.
+ *
+ * returns:
+ *      0 on success
+ *      Negative error code on failure
+ */
+static int overlay_apply_node(void *fdt, int target, void *fdto, int node)
+{
+    int property;
+    int subnode;
+
+    fdt_for_each_property_offset(property, fdto, node) {
+        const char *name;
+        const void *prop;
+        int prop_len;
+        int ret;
+
+        prop = fdt_getprop_by_offset(fdto, property, &name, &prop_len);
+        if (prop_len == -FDT_ERR_NOTFOUND) {
+            return -FDT_ERR_INTERNAL;
+        }
+        if (prop_len < 0) {
+            return prop_len;
+        }
+
+        ret = fdt_setprop(fdt, target, name, prop, prop_len);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    fdt_for_each_subnode(subnode, fdto, node) {
+        const char *name = fdt_get_name(fdto, subnode, NULL);
+        int nnode;
+        int ret;
+
+        nnode = fdt_add_subnode(fdt, target, name);
+        if (nnode == -FDT_ERR_EXISTS) {
+            nnode = fdt_subnode_offset(fdt, target, name);
+            if (nnode == -FDT_ERR_NOTFOUND) {
+                return -FDT_ERR_INTERNAL;
+            }
+        }
+
+        if (nnode < 0) {
+            return nnode;
+        }
+
+        ret = overlay_apply_node(fdt, nnode, fdto, subnode);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
+/* Merge nodes and properties into fdt from fdto */
+static int merge_fdt(void *fdt, void *fdto)
+{
+    int err;
+
+    err = overlay_apply_node(fdt, 0, fdto, 0);
+    if (err) {
+        fprintf(stderr, "Device tree error %s\n", fdt_strerror(err));
+        return -1;
+    }
+
+    return 0;
+}
+
+/* Finish creating the device tree, merging in the -dtbi file if needed */
+static int complete_fdt(VirtMachineState *vms)
+{
+    MachineState *ms = MACHINE(vms);
+
+    if (ms->dtbi) {
+        char *filename;
+        void *fdt;
+        int size;
+        int ret;
+
+        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, ms->dtbi);
+        if (!filename) {
+            fprintf(stderr, "Couldn't open dtbi file %s\n", ms->dtbi);
+            goto fail;
+        }
+
+        fdt = load_device_tree(filename, &size);
+        if (!fdt) {
+            fprintf(stderr, "Couldn't open dtbi file %s\n", filename);
+            g_free(filename);
+            goto fail;
+        }
+
+        ret = merge_fdt(ms->fdt, fdt);
+        g_free(fdt);
+        if (ret) {
+            fprintf(stderr, "Failed to merge in dtbi file %s\n", filename);
+            g_free(filename);
+            goto fail;
+        }
+        g_free(filename);
+    }
+    return 0;
+
+fail:
+    return -1;
+}
+
 static void fdt_add_timer_nodes(const VirtMachineState *vms)
 {
     /* On real hardware these interrupts are level-triggered.
@@ -2314,6 +2444,11 @@ static void machvirt_init(MachineState *machine)
 
     create_platform_bus(vms);
 
+    if (complete_fdt(vms)) {
+        error_report("mach-virt: Failed to complete device tree");
+        exit(1);
+    }
+
     if (machine->nvdimms_state->is_enabled) {
         const struct AcpiGenericAddress arm_virt_nvdimm_acpi_dsmio = {
             .space_id = AML_AS_SYSTEM_MEMORY,
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0c17398141..f156481754 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -349,6 +349,21 @@ static void machine_set_dtb(Object *obj, const char *value, Error **errp)
     ms->dtb = g_strdup(value);
 }
 
+static char *machine_get_dtbi(Object *obj, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    return g_strdup(ms->dtbi);
+}
+
+static void machine_set_dtbi(Object *obj, const char *value, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    g_free(ms->dtbi);
+    ms->dtbi = g_strdup(value);
+}
+
 static char *machine_get_dumpdtb(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -994,6 +1009,11 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "dtb",
         "Linux kernel device tree file");
 
+    object_class_property_add_str(oc, "dtbi",
+        machine_get_dtbi, machine_set_dtbi);
+    object_class_property_set_description(oc, "dtbi",
+        "Linux kernel device tree file to merge with the generated device tree");
+
     object_class_property_add_str(oc, "dumpdtb",
         machine_get_dumpdtb, machine_set_dumpdtb);
     object_class_property_set_description(oc, "dumpdtb",
diff --git a/include/hw/boards.h b/include/hw/boards.h
index a735999298..bb6548e98d 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -359,6 +359,7 @@ struct MachineState {
 
     void *fdt;
     char *dtb;
+    char *dtbi;  /* filename of device tree to merge with the generated one */
     char *dumpdtb;
     int phandle_start;
     char *dt_compatible;
diff --git a/qemu-options.hx b/qemu-options.hx
index 42fd09e4de..20c1ac1c44 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4033,6 +4033,14 @@ the guest image is:
 
 ERST
 
+DEF("dtbi", HAS_ARG, QEMU_OPTION_dtbi, \
+    "-dtbi   file    merge 'file' with generated device tree\n", QEMU_ARCH_ARM)
+SRST
+``-dtbi file``
+    Merge a device tree binary (dtb) file into the generated device tree and
+    pass the result to the kernel on boot.
+ERST
+
 DEFHEADING()
 
 DEFHEADING(Debug/Expert options:)
diff --git a/system/vl.c b/system/vl.c
index 5af7ced2a1..6684b1bdd0 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2907,6 +2907,9 @@ void qemu_init(int argc, char **argv)
             case QEMU_OPTION_dtb:
                 qdict_put_str(machine_opts_dict, "dtb", optarg);
                 break;
+            case QEMU_OPTION_dtbi:
+                qdict_put_str(machine_opts_dict, "dtbi", optarg);
+                break;
             case QEMU_OPTION_cdrom:
                 drive_add(IF_DEFAULT, 2, optarg, CDROM_OPTS);
                 break;
-- 
2.43.0.rc0.421.g78406f8d94-goog


