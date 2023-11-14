Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A217EA899
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 03:12:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2is1-0001G8-99; Mon, 13 Nov 2023 21:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r2irz-0001Fj-2k
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 21:09:39 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r2irx-0007ZM-G1
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 21:09:38 -0500
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-5c18a3387f5so1018349a12.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 18:09:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699927776; x=1700532576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NYf3Mp/7wpNrEOrqYg1zrC2cEXg6lKB+hhoqy9GgIhw=;
 b=ZiIbb6+GjrbLwRlNoBtQuSmfZc9kWPL2CF1GfqlIqN7dEhte0rFHz2SuMq+0hbO6Bf
 5nv4buGeZLIK0oJ+KXmRAGP2F6Fo1wu2hOtwq6c76WARIV81YoMzaRkngOe6J/8XfAge
 oQK6r77ufoeO945MRfV56PelSyG/LTXuNvLgfid65hNebggiPCQ6SQE3RBVsyZN5Be/r
 UR63eTdE1n6kOnHS+B1P/gzH1gVYZTV7OcmVxp26/7fw74hZtyL1WRmTx1zQ/AY9Sdr3
 xfW6GSEHuD8GdP8Dm4PfgXenivw3UjqmZWof/2rwb61BXb1Ie2jyf3uoLZ7EIWflIWvT
 RFpQ==
X-Gm-Message-State: AOJu0YzS6MvisuLkgrfTdb72HQtcPflkF7rpU7xxqFjgZUB1N6JNH8gC
 FcgU439chlMvSzZ2Dzj5/gv47xpoJ2xVcA==
X-Google-Smtp-Source: AGHT+IE2HiFsrm0XSh7nZv097dnZL3mwIdNea176u/c0VjmS2NSpCQZTy1wEVtOMWxBoj6ToqdDIXQ==
X-Received: by 2002:a17:90b:3b43:b0:27d:6b5:9e07 with SMTP id
 ot3-20020a17090b3b4300b0027d06b59e07mr6318423pjb.1.1699927776039; 
 Mon, 13 Nov 2023 18:09:36 -0800 (PST)
Received: from localhost.localdomain ([2601:642:4c01:2f7:5d09:c219:9099:a639])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a17090ae58d00b0027d12b1e29dsm6175362pjz.25.2023.11.13.18.09.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Nov 2023 18:09:34 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Stefan Berger <stefanb@linux.ibm.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 02/14] tpm_crb: CTRL_RSP_ADDR is 64-bits wide
Date: Mon, 13 Nov 2023 18:09:12 -0800
Message-ID: <20231114020927.62315-3-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114020927.62315-1-j@getutm.app>
References: <20231114020927.62315-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.215.176; envelope-from=osy86dev@gmail.com;
 helo=mail-pg1-f176.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The register is actually 64-bits but in order to make this more clear
than the specification, we define two 32-bit registers:
CTRL_RSP_LADDR and CTRL_RSP_HADDR to match the CTRL_CMD_* naming. This
deviates from the specs but is way more clear.

Previously, the only CRB device uses a fixed system address so this
was not an issue. However, once we support SysBus CRB device, the
address can be anywhere in 64-bit space.

Signed-off-by: Joelle van Dyne <j@getutm.app>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/hw/acpi/tpm.h      | 3 ++-
 hw/tpm/tpm_crb_common.c    | 3 ++-
 tests/qtest/tpm-crb-test.c | 2 +-
 tests/qtest/tpm-util.c     | 2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
index 579c45f5ba..f60bfe2789 100644
--- a/include/hw/acpi/tpm.h
+++ b/include/hw/acpi/tpm.h
@@ -174,7 +174,8 @@ REG32(CRB_CTRL_CMD_SIZE, 0x58)
 REG32(CRB_CTRL_CMD_LADDR, 0x5C)
 REG32(CRB_CTRL_CMD_HADDR, 0x60)
 REG32(CRB_CTRL_RSP_SIZE, 0x64)
-REG32(CRB_CTRL_RSP_ADDR, 0x68)
+REG32(CRB_CTRL_RSP_LADDR, 0x68)
+REG32(CRB_CTRL_RSP_HADDR, 0x6C)
 REG32(CRB_DATA_BUFFER, 0x80)
 
 #define TPM_CRB_ADDR_BASE           0xFED40000
diff --git a/hw/tpm/tpm_crb_common.c b/hw/tpm/tpm_crb_common.c
index fa463f295f..01b35808f6 100644
--- a/hw/tpm/tpm_crb_common.c
+++ b/hw/tpm/tpm_crb_common.c
@@ -197,7 +197,8 @@ void tpm_crb_reset(TPMCRBState *s, uint64_t baseaddr)
     s->regs[R_CRB_CTRL_CMD_LADDR] = (uint32_t)baseaddr;
     s->regs[R_CRB_CTRL_CMD_HADDR] = (uint32_t)(baseaddr >> 32);
     s->regs[R_CRB_CTRL_RSP_SIZE] = CRB_CTRL_CMD_SIZE;
-    s->regs[R_CRB_CTRL_RSP_ADDR] = (uint32_t)baseaddr;
+    s->regs[R_CRB_CTRL_RSP_LADDR] = (uint32_t)baseaddr;
+    s->regs[R_CRB_CTRL_RSP_HADDR] = (uint32_t)(baseaddr >> 32);
 
     s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->tpmbe),
                             CRB_CTRL_CMD_SIZE);
diff --git a/tests/qtest/tpm-crb-test.c b/tests/qtest/tpm-crb-test.c
index 396ae3f91c..9d30fe8293 100644
--- a/tests/qtest/tpm-crb-test.c
+++ b/tests/qtest/tpm-crb-test.c
@@ -28,7 +28,7 @@ static void tpm_crb_test(const void *data)
     uint32_t csize = readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_SIZE);
     uint64_t caddr = readq(TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_LADDR);
     uint32_t rsize = readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_SIZE);
-    uint64_t raddr = readq(TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_ADDR);
+    uint64_t raddr = readq(TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_LADDR);
     uint8_t locstate = readb(TPM_CRB_ADDR_BASE + A_CRB_LOC_STATE);
     uint32_t locctrl = readl(TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL);
     uint32_t locsts = readl(TPM_CRB_ADDR_BASE + A_CRB_LOC_STS);
diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
index 1c0319e6e7..dd02057fc0 100644
--- a/tests/qtest/tpm-util.c
+++ b/tests/qtest/tpm-util.c
@@ -25,7 +25,7 @@ void tpm_util_crb_transfer(QTestState *s,
                            unsigned char *rsp, size_t rsp_size)
 {
     uint64_t caddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_LADDR);
-    uint64_t raddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_ADDR);
+    uint64_t raddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_LADDR);
 
     qtest_writeb(s, TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL, 1);
 
-- 
2.41.0


