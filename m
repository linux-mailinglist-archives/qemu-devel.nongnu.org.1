Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E70E17532A6
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 09:11:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKCwN-0006R6-8s; Fri, 14 Jul 2023 03:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qKCwK-0006Pq-Kx
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 03:10:08 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qKCwI-0005By-Su
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 03:10:08 -0400
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so1281000a12.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 00:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689318605; x=1691910605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uYVdqywbJShpgDMurqrcqFNmgvVUfJjOwR2IDROVAag=;
 b=idIULIa7TFsj0KBcru/NwbURpnoYoYms4wgytzVBf60QLv3O1koRfpKVFCVof7Kus6
 APfeyNHA/PSOp3l415M2707b064bgY5X+huiMrg+GIDb1ybfu+lIq0WyFhhmYbjgZVV8
 6OkzBghXxm+G3KJbgxAHKdkspghIyGgt8TrBP/eVE35+TYtJETmDu+id7C4lkrKcEkvQ
 Sti2iwCqi4mkks+8ewatS0OXmvv670kzffuZ2gMwADcpKn4IsDggqi3iCMDVdZH0aowZ
 Ex/jO+gunVRR8liR4j6zzAQplZ7t2kfDumN1Rgm7Z519UtKqHKHQW/l6DSRDJSvyMZf7
 SteA==
X-Gm-Message-State: ABy/qLaFe7djVWyZYIvdLZFhaPCDvbPx4caUyE2v1BOJabRGEyUo28eb
 3Cr3A6PqrR7S3b7wqGYpHngO0rXijqor4g==
X-Google-Smtp-Source: APBJJlH2yAX7VlMEqAmm4gPg5C2hq4KxjmLtn945mIwtSmqNPZclnq2AED1DR6HKZi+yl3AeLh/C5g==
X-Received: by 2002:a17:902:e742:b0:1b3:d4d5:beb2 with SMTP id
 p2-20020a170902e74200b001b3d4d5beb2mr4457438plf.9.1689318604999; 
 Fri, 14 Jul 2023 00:10:04 -0700 (PDT)
Received: from localhost.localdomain
 ([2607:fb90:dd17:8dad:e558:8948:1ff6:c8c1])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a170902b20800b001b89466a5f4sm7041513plr.105.2023.07.14.00.10.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 14 Jul 2023 00:10:04 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v2 11/11] tpm_crb: support restoring older vmstate
Date: Fri, 14 Jul 2023 00:09:27 -0700
Message-ID: <20230714070931.23476-12-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714070931.23476-1-j@getutm.app>
References: <20230714070931.23476-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.215.182; envelope-from=osy86dev@gmail.com;
 helo=mail-pg1-f182.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

When we moved to a single mapping and modified TPM CRB's VMState, it
broke restoring of VMs that were saved on an older version. This
change allows those VMs to gracefully migrate to the new memory
mapping.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 hw/tpm/tpm_crb.h        |  1 +
 hw/tpm/tpm_crb.c        | 14 ++++++++++++++
 hw/tpm/tpm_crb_common.c |  7 +++++++
 3 files changed, 22 insertions(+)

diff --git a/hw/tpm/tpm_crb.h b/hw/tpm/tpm_crb.h
index 7cdd37335f..7d8f643e98 100644
--- a/hw/tpm/tpm_crb.h
+++ b/hw/tpm/tpm_crb.h
@@ -70,5 +70,6 @@ enum TPMVersion tpm_crb_get_version(TPMCRBState *s);
 int tpm_crb_pre_save(TPMCRBState *s);
 void tpm_crb_reset(TPMCRBState *s, uint64_t baseaddr);
 void tpm_crb_init_memory(Object *obj, TPMCRBState *s, Error **errp);
+void tpm_crb_restore_regs(TPMCRBState *s, uint32_t *saved_regs);
 
 #endif /* TPM_TPM_CRB_H */
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 594696ffb8..be29ca8c28 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -40,6 +40,7 @@ struct CRBState {
     ISADevice parent_obj;
 
     TPMCRBState state;
+    uint32_t legacy_regs[TPM_CRB_R_MAX];
 };
 typedef struct CRBState CRBState;
 
@@ -67,10 +68,23 @@ static int tpm_crb_isa_pre_save(void *opaque)
     return tpm_crb_pre_save(&s->state);
 }
 
+static int tpm_crb_isa_post_load(void *opaque, int version_id)
+{
+    CRBState *s = opaque;
+
+    if (version_id == 0) {
+        tpm_crb_restore_regs(&s->state, s->legacy_regs);
+    }
+    return 0;
+}
+
 static const VMStateDescription vmstate_tpm_crb_isa = {
     .name = "tpm-crb",
+    .version_id = 1,
     .pre_save = tpm_crb_isa_pre_save,
+    .post_load = tpm_crb_isa_post_load,
     .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(legacy_regs, CRBState, TPM_CRB_R_MAX),
         VMSTATE_END_OF_LIST(),
     }
 };
diff --git a/hw/tpm/tpm_crb_common.c b/hw/tpm/tpm_crb_common.c
index 4ecf064c98..5714ac7fc4 100644
--- a/hw/tpm/tpm_crb_common.c
+++ b/hw/tpm/tpm_crb_common.c
@@ -224,3 +224,10 @@ void tpm_crb_init_memory(Object *obj, TPMCRBState *s, Error **errp)
         tpm_ppi_init_memory(&s->ppi, obj);
     }
 }
+
+void tpm_crb_restore_regs(TPMCRBState *s, uint32_t *saved_regs)
+{
+    uint32_t *regs = memory_region_get_ram_ptr(&s->mmio);
+
+    memcpy(regs, saved_regs, TPM_CRB_R_MAX);
+}
-- 
2.39.2 (Apple Git-143)


