Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AF5737550
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 21:48:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBhIo-0000J7-LL; Tue, 20 Jun 2023 15:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7X-0004Fh-Dt
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:23 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7U-0006bg-FF
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:23 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6b5853a140cso1750524a34.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 10:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687281977; x=1689873977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6HvrCL8rOJsuiwOG3muIoVRllaEm248y0LD47Kgrft0=;
 b=nmgU4y9Ln0rtIz80PAR3vTp7t61K68cxtW9WeRAqn7eaE3uMj1tya6GoffQApOwPAD
 kwbpLr9u2Y90w7sOrUMa+ArGM8Ep49feEFdPQONaGxHoMfoLK1N63oRqHGJpxj4lCw2C
 eIX4N0M/EYtGsqpl9NfqIMVk+rbdMPaJbFUp8SNYa5mPbJB2q99z+qXsrJQXNFsxMyB1
 NP+HYGwDfrCjlZ9JQZC6nHfjzf++zIthNMA0BoriKULZyJhp7bWZlO2SJbBUy/CXTPpV
 urJ/7Hw4lJxU78QQ1byX2mi/JGovBTW7NtftPygrxBG8yIV8IPUBkt4HtpgLWeu9wQdm
 3Oyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687281977; x=1689873977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6HvrCL8rOJsuiwOG3muIoVRllaEm248y0LD47Kgrft0=;
 b=OAMoKJeQVTF7NxrZu1j2nMSyEPtMOMIW69X0CJX5uI0c0IPW3PKyJqkEDFS2YypOBR
 ZPr4vE+KF0gcPCjTdQGWGAXwvYqUzfR0tSs+YZpEvTbNK6DJvyVD+jtZamJPjjixEWyb
 HR+ASMIZH3YMGmoJZHlG/iYNp1T5paEqZUnHxAlPP20lplcQdXpPN356P/MpZ/Nc5BkZ
 GbnbVY8BVHgyXkUdw1GozTPdBA6I4g7TRLyUllrYxsVd4AUztBCqqxodhQgBPhcKJy8u
 Ff6/bTCL1tXRGX8G+mqhyhAQGxiuy6+9MdiGnZhr9qTwsaz2F0sRzQml7RCyGNYPPQrg
 Lyyw==
X-Gm-Message-State: AC+VfDzWWeoGDd7TjJFxvz/VJbEsj3NiSWfpsuWQB4YPcuYlk85quMM9
 FjxWRY0pkUc3VZqGV+QmXqyXq9FyeY/UCg==
X-Google-Smtp-Source: ACHHUZ6Qt7O71pC+krywoR4rbBwRp9dAu+gyJXT+ubbJS5lT0aUS37r2zV6kUeMl6FXGYYhiuV77iQ==
X-Received: by 2002:a05:6358:455:b0:12b:e9fd:4b53 with SMTP id
 21-20020a056358045500b0012be9fd4b53mr8661292rwe.22.1687281977366; 
 Tue, 20 Jun 2023 10:26:17 -0700 (PDT)
Received: from joel-Precision-7920-Tower.. ([24.53.71.1])
 by smtp.gmail.com with ESMTPSA id
 e65-20020a0dc244000000b0056cffe97a11sm604604ywd.13.2023.06.20.10.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 10:26:17 -0700 (PDT)
From: Joel Upham <jupham125@gmail.com>
To: qemu-devel@nongnu.org
Cc: Joel Upham <jupham125@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs)
Subject: [PATCH v1 11/23] xen/pt: handle PCIe Extended Capabilities Next
 register
Date: Tue, 20 Jun 2023 13:24:45 -0400
Message-Id: <8687512cd728cd0ad00d9a7d35cd3ce5c3a2c2ca.1687278381.git.jupham125@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1687278381.git.jupham125@gmail.com>
References: <cover.1687278381.git.jupham125@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=jupham125@gmail.com; helo=mail-ot1-x336.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 20 Jun 2023 15:45:54 -0400
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

The patch adds new xen_pt_ext_cap_ptr_reg_init function which is used
to initialize the emulated next pcie extended capability pointer.

Primary mission of this function is to have a method to selectively hide
some extended capabilities from the capability linked list, skipping them
by altering the Next capability pointer value.

Signed-off-by: Alexey Gerasimenko <x1917x@xxxxxxxxx>
Signed-off-by: Joel Upham <jupham125@gmail.com>
---
 hw/xen/xen_pt_config_init.c | 87 +++++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 32 deletions(-)

diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index 34ed9c25c5..ed36edbc4a 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -27,7 +27,10 @@
 
 static int xen_pt_ptr_reg_init(XenPCIPassthroughState *s, XenPTRegInfo *reg,
                                uint32_t real_offset, uint32_t *data);
-
+static int xen_pt_ext_cap_ptr_reg_init(XenPCIPassthroughState *s,
+                                       XenPTRegInfo *reg,
+                                       uint32_t real_offset,
+                                       uint32_t *data);
 
 /* helper */
 
@@ -1928,48 +1931,68 @@ out:
     return 0;
 }
 
+#define PCIE_EXT_CAP_NEXT_SHIFT 4
+#define PCIE_EXT_CAP_VER_MASK   0xF
 
-/*************
- * Main
- */
-
-static uint8_t find_cap_offset(XenPCIPassthroughState *s, uint8_t cap)
+static int xen_pt_ext_cap_ptr_reg_init(XenPCIPassthroughState *s,
+                                       XenPTRegInfo *reg,
+                                       uint32_t real_offset,
+                                       uint32_t *data)
 {
-    uint8_t id;
-    unsigned max_cap = XEN_PCI_CAP_MAX;
-    uint8_t pos = PCI_CAPABILITY_LIST;
-    uint8_t status = 0;
+    int i, rc;
+    XenHostPCIDevice *d = &s->real_device;
+    uint16_t reg_field;
+    uint16_t cur_offset, version, cap_id;
+    uint32_t header;
 
-    if (xen_host_pci_get_byte(&s->real_device, PCI_STATUS, &status)) {
-        return 0;
-    }
-    if ((status & PCI_STATUS_CAP_LIST) == 0) {
-        return 0;
+    if (real_offset < 0x0010) {
+        XEN_PT_ERR(&s->dev, "Incorrect PCIe extended capability offset "
+                   "encountered: 0x%04x\n", real_offset);
+        return -EINVAL;
     }
 
-    while (max_cap--) {
-        if (xen_host_pci_get_byte(&s->real_device, pos, &pos)) {
-            break;
-        }
-        if (pos < PCI_CONFIG_HEADER_SIZE) {
-            break;
-        }
+    rc = xen_host_pci_get_word(d, real_offset, &reg_field);
+    if (rc)
+        return rc;
 
-        pos &= ~3;
-        if (xen_host_pci_get_byte(&s->real_device,
-                                  pos + PCI_CAP_LIST_ID, &id)) {
-            break;
-        }
+    /* preserve version field */
+    version    = reg_field & PCIE_EXT_CAP_VER_MASK;
+    cur_offset = reg_field >> PCIE_EXT_CAP_NEXT_SHIFT;
 
-        if (id == 0xff) {
-            break;
+    while (cur_offset && cur_offset != 0xFFF) {
+        rc = xen_host_pci_get_long(d, cur_offset, &header);
+        if (rc) {
+            XEN_PT_ERR(&s->dev, "Failed to read PCIe extended capability "
+                       "@0x%x (rc:%d)\n", cur_offset, rc);
+            return rc;
         }
-        if (id == cap) {
-            return pos;
+
+        cap_id = PCI_EXT_CAP_ID(header);
+
+        for (i = 0; xen_pt_emu_reg_grps[i].grp_size != 0; i++) {
+            uint32_t cur_grp_id = xen_pt_emu_reg_grps[i].grp_id;
+
+            if (!IS_PCIE_EXT_CAP_ID(cur_grp_id))
+                continue;
+
+            if (xen_pt_hide_dev_cap(d, cur_grp_id))
+                continue;
+
+            if (GET_PCIE_EXT_CAP_ID(cur_grp_id) == cap_id) {
+                if (xen_pt_emu_reg_grps[i].grp_type == XEN_PT_GRP_TYPE_EMU)
+                    goto out;
+
+                /* skip TYPE_HARDWIRED capability, move the ptr to next one */
+                break;
+            }
         }
 
-        pos += PCI_CAP_LIST_NEXT;
+        /* next capability */
+        cur_offset = PCI_EXT_CAP_NEXT(header);
     }
+
+out:
+    *data = (cur_offset << PCIE_EXT_CAP_NEXT_SHIFT) | version;
     return 0;
 }
 
-- 
2.34.1


