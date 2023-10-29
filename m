Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7687DAAFF
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 07:05:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwyuG-0002Bl-Uq; Sun, 29 Oct 2023 02:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qwyuD-0002Ah-VR
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 02:04:15 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qwyuC-0001mB-DY
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 02:04:13 -0400
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-1c87a85332bso30278205ad.2
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 23:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698559451; x=1699164251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NYf3Mp/7wpNrEOrqYg1zrC2cEXg6lKB+hhoqy9GgIhw=;
 b=wB/dZ+xXqjLda4BrBANw2orAmrtCalwPV2jqYLq/FszIYPOeRaA5Njl/AR/XPa+V29
 E2S9WJqEsbx+ndJWT/AtoIgLY0AerqNhpmn8Ry2htliKqUzVW0lBC+8U9VsAEKXNIkVc
 4Hvtcu2RG/SZ9pJtQ2/d1mc4XYqw4/HQNHNzIshoerXeCiFlnXXobetvgfGkoGYSVE2W
 HeHkHbE2E2XxQ/XwEE8U0oPZ4Xbh2tfmWMCpVpcKuPYTYxxA5SiSAccaZZDkmrLaBOPA
 4Bk1Fjlr1dq2oRyE+be4JUqNRKZv42ExOpLSJun4PWUKliIBR+5U3fDaHwpC6p9axVQ1
 BSxA==
X-Gm-Message-State: AOJu0Ywj87h77ZWfTT3qw7SUFrXqgvu+PdUbvWG5tpVS5j/fhTtT9+ll
 kcoAqAHOACf+dRsd/TpwA+saOvt/PBLYKw==
X-Google-Smtp-Source: AGHT+IH26wqbhqmlBnfsyX6Fe9vnoBuHNZ6yLZk3170/KfMqHb4V1QlDkoBMNpqdzM38nB6kHUy7XA==
X-Received: by 2002:a17:902:e84b:b0:1cc:4559:f5 with SMTP id
 t11-20020a170902e84b00b001cc455900f5mr516788plg.14.1698559450924; 
 Sat, 28 Oct 2023 23:04:10 -0700 (PDT)
Received: from localhost.localdomain ([2601:642:4c02:6ead:344e:2b1:f5a5:58c6])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a17090341cc00b001b8943b37a5sm4019518ple.24.2023.10.28.23.04.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 28 Oct 2023 23:04:09 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Stefan Berger <stefanb@linux.ibm.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 02/14] tpm_crb: CTRL_RSP_ADDR is 64-bits wide
Date: Sat, 28 Oct 2023 23:03:15 -0700
Message-ID: <20231029060404.71196-3-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231029060404.71196-1-j@getutm.app>
References: <20231029060404.71196-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.169; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f169.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


