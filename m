Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9601A990979
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Oct 2024 18:39:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlJ8-00049o-FJ; Fri, 04 Oct 2024 12:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlI0-0001ep-Bt
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:36:27 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlHs-0006eh-Ee
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:36:20 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5399651d21aso2266965e87.3
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728059774; x=1728664574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X8sRbzp8Sb06kpJ58T7p1q2wLwhmxDezE8ovGt3QAms=;
 b=B5rA090vVzw2ii4Gl1n/kpf0W6Jwd9i7cAUrCmFdToHrohcKcosfe6DjHrZ+xM6sBA
 PauUa9K7jf/SUY9DYbQJSlrlPQzp+g2eYR98KztqgdZCCNk7MTrqOQggjyZKpoVgxcLS
 hnet42xb+SoF2gtWNFQHh8qABtMQau3n1ZdiaZyD+v9okd7+HEpT8iePZLVIVKmxfiTP
 ohStaem7lOTzfrVrHWH1BP/PEjEgSo7L3OCE9DBqRPdLlIEJ3EjRcekhn8kANOsQEjq/
 tMWfPPuvTkjdAJqYBO4wWj5m5GdFV5G9mXkRfIDaGgnaCfAPyKXjyhAvC1QMjRSoD0nd
 sVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059774; x=1728664574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X8sRbzp8Sb06kpJ58T7p1q2wLwhmxDezE8ovGt3QAms=;
 b=rn8zZDm78ZzFEb0DuKfiKtdUIV8EmDcVG/guKtPY8SbdYiqqBKeRyaEyN9NXVKw7/d
 +jABbVY4T045W4qyeMSGltZED+/l7y/bJMjULH21asfHqPmaLhCXojHdZ1v603Jy8boO
 ietNMP/tRSo7wK893vHZQfsYoCVJ+Fd6TlQajV5izNsLqbOqPkajflKI+8Tqpm+7Xd1Y
 CenAXy4QZqDsGhDqbsUq3QchI9QuLpY/boBKFZ1BhM9LETOcLp1RU0/FSh2LBbg9rflq
 5T/fifV5bsCl92q9GYx6YxJgq4S/i/9+peGk7Mp3wiHlHJOG632h3rtQCeGveehLgLUl
 Rabw==
X-Gm-Message-State: AOJu0Yyf6TemTkdbHY6EGxG6QHQeUtfdrgsvWsj9mNAyMnfwtikx34zN
 DlB7zGhe5eekdm0t42fWc8bbsjq5FV7Eh19miaNMsFIikJ7QT11NVW00yfqFPPiAiVJ+TdakVhk
 /l7hqWw==
X-Google-Smtp-Source: AGHT+IHCO7KWi92pUHCnymdqy4Dg9Yo3gQQ+7O24zk92/FzCUblVaHS41a/Vq6fU3Dn9sGlPwM1yfQ==
X-Received: by 2002:a05:6512:12d1:b0:539:94df:38e9 with SMTP id
 2adb3069b0e04-539ab88af26mr2020980e87.31.1728059774064; 
 Fri, 04 Oct 2024 09:36:14 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.150])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539afec107esm2712e87.6.2024.10.04.09.36.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 09:36:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 22/25] hw/s390x: Use explicit big-endian LD/ST API
Date: Fri,  4 Oct 2024 13:30:38 -0300
Message-ID: <20241004163042.85922-23-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004163042.85922-1-philmd@linaro.org>
References: <20241004163042.85922-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The S390X architecture uses big endianness. Directly use
the big-endian LD/ST API.

Mechanical change using:

  $ end=be; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' hw/s390x/); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/ipl.c           |   4 +-
 hw/s390x/s390-pci-inst.c | 166 +++++++++++++++++++--------------------
 2 files changed, 85 insertions(+), 85 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index dd71689642b..5ab74339087 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -252,8 +252,8 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
              */
             romptr = rom_ptr(INITRD_PARM_START, 16);
             if (romptr) {
-                stq_p(romptr, initrd_offset);
-                stq_p(romptr + 1, initrd_size);
+                stq_be_p(romptr, initrd_offset);
+                stq_be_p(romptr + 1, initrd_size);
             }
         }
     }
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 30149546c08..41655082dac 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -55,26 +55,26 @@ static int list_pci(ClpReqRspListPci *rrb, uint8_t *cc)
     uint64_t resume_token;
 
     rc = 0;
-    if (lduw_p(&rrb->request.hdr.len) != 32) {
+    if (lduw_be_p(&rrb->request.hdr.len) != 32) {
         res_code = CLP_RC_LEN;
         rc = -EINVAL;
         goto out;
     }
 
-    if ((ldl_p(&rrb->request.fmt) & CLP_MASK_FMT) != 0) {
+    if ((ldl_be_p(&rrb->request.fmt) & CLP_MASK_FMT) != 0) {
         res_code = CLP_RC_FMT;
         rc = -EINVAL;
         goto out;
     }
 
-    if ((ldl_p(&rrb->request.fmt) & ~CLP_MASK_FMT) != 0 ||
-        ldq_p(&rrb->request.reserved1) != 0) {
+    if ((ldl_be_p(&rrb->request.fmt) & ~CLP_MASK_FMT) != 0 ||
+        ldq_be_p(&rrb->request.reserved1) != 0) {
         res_code = CLP_RC_RESNOT0;
         rc = -EINVAL;
         goto out;
     }
 
-    resume_token = ldq_p(&rrb->request.resume_token);
+    resume_token = ldq_be_p(&rrb->request.resume_token);
 
     if (resume_token) {
         pbdev = s390_pci_find_dev_by_idx(s, resume_token);
@@ -87,13 +87,13 @@ static int list_pci(ClpReqRspListPci *rrb, uint8_t *cc)
         pbdev = s390_pci_find_next_avail_dev(s, NULL);
     }
 
-    if (lduw_p(&rrb->response.hdr.len) < 48) {
+    if (lduw_be_p(&rrb->response.hdr.len) < 48) {
         res_code = CLP_RC_8K;
         rc = -EINVAL;
         goto out;
     }
 
-    initial_l2 = lduw_p(&rrb->response.hdr.len);
+    initial_l2 = lduw_be_p(&rrb->response.hdr.len);
     if ((initial_l2 - LIST_PCI_HDR_LEN) % sizeof(ClpFhListEntry)
         != 0) {
         res_code = CLP_RC_LEN;
@@ -102,33 +102,33 @@ static int list_pci(ClpReqRspListPci *rrb, uint8_t *cc)
         goto out;
     }
 
-    stl_p(&rrb->response.fmt, 0);
-    stq_p(&rrb->response.reserved1, 0);
-    stl_p(&rrb->response.mdd, FH_MASK_SHM);
-    stw_p(&rrb->response.max_fn, PCI_MAX_FUNCTIONS);
+    stl_be_p(&rrb->response.fmt, 0);
+    stq_be_p(&rrb->response.reserved1, 0);
+    stl_be_p(&rrb->response.mdd, FH_MASK_SHM);
+    stw_be_p(&rrb->response.max_fn, PCI_MAX_FUNCTIONS);
     rrb->response.flags = UID_CHECKING_ENABLED;
     rrb->response.entry_size = sizeof(ClpFhListEntry);
 
     i = 0;
     g_l2 = LIST_PCI_HDR_LEN;
     while (g_l2 < initial_l2 && pbdev) {
-        stw_p(&rrb->response.fh_list[i].device_id,
+        stw_be_p(&rrb->response.fh_list[i].device_id,
             pci_get_word(pbdev->pdev->config + PCI_DEVICE_ID));
-        stw_p(&rrb->response.fh_list[i].vendor_id,
+        stw_be_p(&rrb->response.fh_list[i].vendor_id,
             pci_get_word(pbdev->pdev->config + PCI_VENDOR_ID));
         /* Ignore RESERVED devices. */
-        stl_p(&rrb->response.fh_list[i].config,
+        stl_be_p(&rrb->response.fh_list[i].config,
             pbdev->state == ZPCI_FS_STANDBY ? 0 : 1 << 31);
-        stl_p(&rrb->response.fh_list[i].fid, pbdev->fid);
-        stl_p(&rrb->response.fh_list[i].fh, pbdev->fh);
+        stl_be_p(&rrb->response.fh_list[i].fid, pbdev->fid);
+        stl_be_p(&rrb->response.fh_list[i].fh, pbdev->fh);
 
         g_l2 += sizeof(ClpFhListEntry);
         /* Add endian check for DPRINTF? */
         trace_s390_pci_list_entry(g_l2,
-                lduw_p(&rrb->response.fh_list[i].vendor_id),
-                lduw_p(&rrb->response.fh_list[i].device_id),
-                ldl_p(&rrb->response.fh_list[i].fid),
-                ldl_p(&rrb->response.fh_list[i].fh));
+                lduw_be_p(&rrb->response.fh_list[i].vendor_id),
+                lduw_be_p(&rrb->response.fh_list[i].device_id),
+                ldl_be_p(&rrb->response.fh_list[i].fid),
+                ldl_be_p(&rrb->response.fh_list[i].fh));
         pbdev = s390_pci_find_next_avail_dev(s, pbdev);
         i++;
     }
@@ -138,13 +138,13 @@ static int list_pci(ClpReqRspListPci *rrb, uint8_t *cc)
     } else {
         resume_token = pbdev->fh & FH_MASK_INDEX;
     }
-    stq_p(&rrb->response.resume_token, resume_token);
-    stw_p(&rrb->response.hdr.len, g_l2);
-    stw_p(&rrb->response.hdr.rsp, CLP_RC_OK);
+    stq_be_p(&rrb->response.resume_token, resume_token);
+    stw_be_p(&rrb->response.hdr.len, g_l2);
+    stw_be_p(&rrb->response.hdr.rsp, CLP_RC_OK);
 out:
     if (rc) {
         trace_s390_pci_list(rc);
-        stw_p(&rrb->response.hdr.rsp, res_code);
+        stw_be_p(&rrb->response.hdr.rsp, res_code);
     }
     return rc;
 }
@@ -172,7 +172,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
         return 0;
     }
     reqh = (ClpReqHdr *)buffer;
-    req_len = lduw_p(&reqh->len);
+    req_len = lduw_be_p(&reqh->len);
     if (req_len < 16 || req_len > 8184 || (req_len % 8 != 0)) {
         s390_program_interrupt(env, PGM_OPERAND, ra);
         return 0;
@@ -184,7 +184,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
         return 0;
     }
     resh = (ClpRspHdr *)(buffer + req_len);
-    res_len = lduw_p(&resh->len);
+    res_len = lduw_be_p(&resh->len);
     if (res_len < 8 || res_len > 8176 || (res_len % 8 != 0)) {
         s390_program_interrupt(env, PGM_OPERAND, ra);
         return 0;
@@ -201,11 +201,11 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
     }
 
     if (req_len != 32) {
-        stw_p(&resh->rsp, CLP_RC_LEN);
+        stw_be_p(&resh->rsp, CLP_RC_LEN);
         goto out;
     }
 
-    switch (lduw_p(&reqh->cmd)) {
+    switch (lduw_be_p(&reqh->cmd)) {
     case CLP_LIST_PCI: {
         ClpReqRspListPci *rrb = (ClpReqRspListPci *)buffer;
         list_pci(rrb, &cc);
@@ -215,9 +215,9 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
         ClpReqSetPci *reqsetpci = (ClpReqSetPci *)reqh;
         ClpRspSetPci *ressetpci = (ClpRspSetPci *)resh;
 
-        pbdev = s390_pci_find_dev_by_fh(s, ldl_p(&reqsetpci->fh));
+        pbdev = s390_pci_find_dev_by_fh(s, ldl_be_p(&reqsetpci->fh));
         if (!pbdev) {
-                stw_p(&ressetpci->hdr.rsp, CLP_RC_SETPCIFN_FH);
+                stw_be_p(&ressetpci->hdr.rsp, CLP_RC_SETPCIFN_FH);
                 goto out;
         }
 
@@ -225,17 +225,17 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
         case CLP_SET_ENABLE_PCI_FN:
             switch (reqsetpci->ndas) {
             case 0:
-                stw_p(&ressetpci->hdr.rsp, CLP_RC_SETPCIFN_DMAAS);
+                stw_be_p(&ressetpci->hdr.rsp, CLP_RC_SETPCIFN_DMAAS);
                 goto out;
             case 1:
                 break;
             default:
-                stw_p(&ressetpci->hdr.rsp, CLP_RC_SETPCIFN_RES);
+                stw_be_p(&ressetpci->hdr.rsp, CLP_RC_SETPCIFN_RES);
                 goto out;
             }
 
             if (pbdev->fh & FH_MASK_ENABLE) {
-                stw_p(&ressetpci->hdr.rsp, CLP_RC_SETPCIFN_FHOP);
+                stw_be_p(&ressetpci->hdr.rsp, CLP_RC_SETPCIFN_FHOP);
                 goto out;
             }
 
@@ -249,29 +249,29 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
                 /* Take this opportunity to make sure we are sync'd with host */
                 if (!s390_pci_get_host_fh(pbdev, &pbdev->fh) ||
                     !(pbdev->fh & FH_MASK_ENABLE)) {
-                    stw_p(&ressetpci->hdr.rsp, CLP_RC_SETPCIFN_FH);
+                    stw_be_p(&ressetpci->hdr.rsp, CLP_RC_SETPCIFN_FH);
                     goto out;
                 }
             }
             pbdev->fh |= FH_MASK_ENABLE;
             pbdev->state = ZPCI_FS_ENABLED;
-            stl_p(&ressetpci->fh, pbdev->fh);
-            stw_p(&ressetpci->hdr.rsp, CLP_RC_OK);
+            stl_be_p(&ressetpci->fh, pbdev->fh);
+            stw_be_p(&ressetpci->hdr.rsp, CLP_RC_OK);
             break;
         case CLP_SET_DISABLE_PCI_FN:
             if (!(pbdev->fh & FH_MASK_ENABLE)) {
-                stw_p(&ressetpci->hdr.rsp, CLP_RC_SETPCIFN_FHOP);
+                stw_be_p(&ressetpci->hdr.rsp, CLP_RC_SETPCIFN_FHOP);
                 goto out;
             }
             device_cold_reset(DEVICE(pbdev));
             pbdev->fh &= ~FH_MASK_ENABLE;
             pbdev->state = ZPCI_FS_DISABLED;
-            stl_p(&ressetpci->fh, pbdev->fh);
-            stw_p(&ressetpci->hdr.rsp, CLP_RC_OK);
+            stl_be_p(&ressetpci->fh, pbdev->fh);
+            stw_be_p(&ressetpci->hdr.rsp, CLP_RC_OK);
             break;
         default:
             trace_s390_pci_unknown("set-pci", reqsetpci->oc);
-            stw_p(&ressetpci->hdr.rsp, CLP_RC_SETPCIFN_FHOP);
+            stw_be_p(&ressetpci->hdr.rsp, CLP_RC_SETPCIFN_FHOP);
             break;
         }
         break;
@@ -280,23 +280,23 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
         ClpReqQueryPci *reqquery = (ClpReqQueryPci *)reqh;
         ClpRspQueryPci *resquery = (ClpRspQueryPci *)resh;
 
-        pbdev = s390_pci_find_dev_by_fh(s, ldl_p(&reqquery->fh));
+        pbdev = s390_pci_find_dev_by_fh(s, ldl_be_p(&reqquery->fh));
         if (!pbdev) {
-            trace_s390_pci_nodev("query", ldl_p(&reqquery->fh));
-            stw_p(&resquery->hdr.rsp, CLP_RC_SETPCIFN_FH);
+            trace_s390_pci_nodev("query", ldl_be_p(&reqquery->fh));
+            stw_be_p(&resquery->hdr.rsp, CLP_RC_SETPCIFN_FH);
             goto out;
         }
 
-        stq_p(&resquery->sdma, pbdev->zpci_fn.sdma);
-        stq_p(&resquery->edma, pbdev->zpci_fn.edma);
-        stw_p(&resquery->pchid, pbdev->zpci_fn.pchid);
-        stw_p(&resquery->vfn, pbdev->zpci_fn.vfn);
+        stq_be_p(&resquery->sdma, pbdev->zpci_fn.sdma);
+        stq_be_p(&resquery->edma, pbdev->zpci_fn.edma);
+        stw_be_p(&resquery->pchid, pbdev->zpci_fn.pchid);
+        stw_be_p(&resquery->vfn, pbdev->zpci_fn.vfn);
         resquery->flags = pbdev->zpci_fn.flags;
         resquery->pfgid = pbdev->zpci_fn.pfgid;
         resquery->pft = pbdev->zpci_fn.pft;
         resquery->fmbl = pbdev->zpci_fn.fmbl;
-        stl_p(&resquery->fid, pbdev->zpci_fn.fid);
-        stl_p(&resquery->uid, pbdev->zpci_fn.uid);
+        stl_be_p(&resquery->fid, pbdev->zpci_fn.fid);
+        stl_be_p(&resquery->uid, pbdev->zpci_fn.uid);
         memcpy(resquery->pfip, pbdev->zpci_fn.pfip, CLP_PFIP_NR_SEGMENTS);
         memcpy(resquery->util_str, pbdev->zpci_fn.util_str, CLP_UTIL_STR_LEN);
 
@@ -304,16 +304,16 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
             uint32_t data = pci_get_long(pbdev->pdev->config +
                 PCI_BASE_ADDRESS_0 + (i * 4));
 
-            stl_p(&resquery->bar[i], data);
+            stl_be_p(&resquery->bar[i], data);
             resquery->bar_size[i] = pbdev->pdev->io_regions[i].size ?
                                     ctz64(pbdev->pdev->io_regions[i].size) : 0;
             trace_s390_pci_bar(i,
-                    ldl_p(&resquery->bar[i]),
+                    ldl_be_p(&resquery->bar[i]),
                     pbdev->pdev->io_regions[i].size,
                     resquery->bar_size[i]);
         }
 
-        stw_p(&resquery->hdr.rsp, CLP_RC_OK);
+        stw_be_p(&resquery->hdr.rsp, CLP_RC_OK);
         break;
     }
     case CLP_QUERY_PCI_FNGRP: {
@@ -326,23 +326,23 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
         if (!group) {
             /* We do not allow access to unknown groups */
             /* The group must have been obtained with a vfio device */
-            stw_p(&resgrp->hdr.rsp, CLP_RC_QUERYPCIFG_PFGID);
+            stw_be_p(&resgrp->hdr.rsp, CLP_RC_QUERYPCIFG_PFGID);
             goto out;
         }
         resgrp->fr = group->zpci_group.fr;
-        stq_p(&resgrp->dasm, group->zpci_group.dasm);
-        stq_p(&resgrp->msia, group->zpci_group.msia);
-        stw_p(&resgrp->mui, group->zpci_group.mui);
-        stw_p(&resgrp->i, group->zpci_group.i);
-        stw_p(&resgrp->maxstbl, group->zpci_group.maxstbl);
+        stq_be_p(&resgrp->dasm, group->zpci_group.dasm);
+        stq_be_p(&resgrp->msia, group->zpci_group.msia);
+        stw_be_p(&resgrp->mui, group->zpci_group.mui);
+        stw_be_p(&resgrp->i, group->zpci_group.i);
+        stw_be_p(&resgrp->maxstbl, group->zpci_group.maxstbl);
         resgrp->version = group->zpci_group.version;
         resgrp->dtsm = group->zpci_group.dtsm;
-        stw_p(&resgrp->hdr.rsp, CLP_RC_OK);
+        stw_be_p(&resgrp->hdr.rsp, CLP_RC_OK);
         break;
     }
     default:
-        trace_s390_pci_unknown("clp", lduw_p(&reqh->cmd));
-        stw_p(&resh->rsp, CLP_RC_CMD);
+        trace_s390_pci_unknown("clp", lduw_be_p(&reqh->cmd));
+        stw_be_p(&resh->rsp, CLP_RC_CMD);
         break;
     }
 
@@ -914,7 +914,7 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
 
     for (i = 0; i < len / 8; i++) {
         result = memory_region_dispatch_write(mr, offset + i * 8,
-                                              ldq_p(buffer + i * 8),
+                                              ldq_be_p(buffer + i * 8),
                                               MO_64, MEMTXATTRS_UNSPECIFIED);
         if (result != MEMTX_OK) {
             s390_program_interrupt(env, PGM_OPERAND, ra);
@@ -935,13 +935,13 @@ specification_error:
 static int reg_irqs(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib)
 {
     int ret, len;
-    uint8_t isc = FIB_DATA_ISC(ldl_p(&fib.data));
+    uint8_t isc = FIB_DATA_ISC(ldl_be_p(&fib.data));
 
     pbdev->routes.adapter.adapter_id = css_get_adapter_id(
                                        CSS_IO_ADAPTER_PCI, isc);
-    pbdev->summary_ind = get_indicator(ldq_p(&fib.aisb), sizeof(uint64_t));
-    len = BITS_TO_LONGS(FIB_DATA_NOI(ldl_p(&fib.data))) * sizeof(unsigned long);
-    pbdev->indicator = get_indicator(ldq_p(&fib.aibv), len);
+    pbdev->summary_ind = get_indicator(ldq_be_p(&fib.aisb), sizeof(uint64_t));
+    len = BITS_TO_LONGS(FIB_DATA_NOI(ldl_be_p(&fib.data))) * sizeof(unsigned long);
+    pbdev->indicator = get_indicator(ldq_be_p(&fib.aibv), len);
 
     ret = map_indicator(&pbdev->routes.adapter, pbdev->summary_ind);
     if (ret) {
@@ -953,13 +953,13 @@ static int reg_irqs(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib)
         goto out;
     }
 
-    pbdev->routes.adapter.summary_addr = ldq_p(&fib.aisb);
-    pbdev->routes.adapter.summary_offset = FIB_DATA_AISBO(ldl_p(&fib.data));
-    pbdev->routes.adapter.ind_addr = ldq_p(&fib.aibv);
-    pbdev->routes.adapter.ind_offset = FIB_DATA_AIBVO(ldl_p(&fib.data));
+    pbdev->routes.adapter.summary_addr = ldq_be_p(&fib.aisb);
+    pbdev->routes.adapter.summary_offset = FIB_DATA_AISBO(ldl_be_p(&fib.data));
+    pbdev->routes.adapter.ind_addr = ldq_be_p(&fib.aibv);
+    pbdev->routes.adapter.ind_offset = FIB_DATA_AIBVO(ldl_be_p(&fib.data));
     pbdev->isc = isc;
-    pbdev->noi = FIB_DATA_NOI(ldl_p(&fib.data));
-    pbdev->sum = FIB_DATA_SUM(ldl_p(&fib.data));
+    pbdev->noi = FIB_DATA_NOI(ldl_be_p(&fib.data));
+    pbdev->sum = FIB_DATA_SUM(ldl_be_p(&fib.data));
 
     trace_s390_pci_irqs("register", pbdev->routes.adapter.adapter_id);
     return 0;
@@ -994,9 +994,9 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
                     uintptr_t ra)
 {
     S390PCIIOMMU *iommu = pbdev->iommu;
-    uint64_t pba = ldq_p(&fib.pba);
-    uint64_t pal = ldq_p(&fib.pal);
-    uint64_t g_iota = ldq_p(&fib.iota);
+    uint64_t pba = ldq_be_p(&fib.pba);
+    uint64_t pal = ldq_be_p(&fib.pal);
+    uint64_t g_iota = ldq_be_p(&fib.iota);
     uint8_t dt = (g_iota >> 2) & 0x7;
     uint8_t t = (g_iota >> 11) & 0x1;
 
@@ -1289,7 +1289,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
         }
         break;
     case ZPCI_MOD_FC_SET_MEASURE: {
-        uint64_t fmb_addr = ldq_p(&fib.fmb_addr);
+        uint64_t fmb_addr = ldq_be_p(&fib.fmb_addr);
 
         if (fmb_addr & FMBK_MASK) {
             cc = ZPCI_PCI_LS_ERR;
@@ -1399,17 +1399,17 @@ int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
         return 0;
     }
 
-    stq_p(&fib.pba, pbdev->iommu->pba);
-    stq_p(&fib.pal, pbdev->iommu->pal);
-    stq_p(&fib.iota, pbdev->iommu->g_iota);
-    stq_p(&fib.aibv, pbdev->routes.adapter.ind_addr);
-    stq_p(&fib.aisb, pbdev->routes.adapter.summary_addr);
-    stq_p(&fib.fmb_addr, pbdev->fmb_addr);
+    stq_be_p(&fib.pba, pbdev->iommu->pba);
+    stq_be_p(&fib.pal, pbdev->iommu->pal);
+    stq_be_p(&fib.iota, pbdev->iommu->g_iota);
+    stq_be_p(&fib.aibv, pbdev->routes.adapter.ind_addr);
+    stq_be_p(&fib.aisb, pbdev->routes.adapter.summary_addr);
+    stq_be_p(&fib.fmb_addr, pbdev->fmb_addr);
 
     data = ((uint32_t)pbdev->isc << 28) | ((uint32_t)pbdev->noi << 16) |
            ((uint32_t)pbdev->routes.adapter.ind_offset << 8) |
            ((uint32_t)pbdev->sum << 7) | pbdev->routes.adapter.summary_offset;
-    stl_p(&fib.data, data);
+    stl_be_p(&fib.data, data);
 
 out:
     if (s390_cpu_virt_mem_write(cpu, fiba, ar, (uint8_t *)&fib, sizeof(fib))) {
-- 
2.45.2


