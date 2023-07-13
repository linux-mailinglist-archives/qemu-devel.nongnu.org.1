Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 614D47516F4
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 05:54:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJnNw-0005O2-K5; Wed, 12 Jul 2023 23:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qJnNs-0005Nb-Cj
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 23:52:52 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qJnNm-0004be-Pp
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 23:52:51 -0400
Received: by mail-ot1-f41.google.com with SMTP id
 46e09a7af769-6b91ad1f9c1so211299a34.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 20:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689220363; x=1691812363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9h5vBblEtE1OyPUpivP53Ye96Vt/PwFBGANZtWgSnbQ=;
 b=ObBz1NFaS6dDnZrrJcjKuQ5NeMVkWvYRe1AyHv9d2Xh29wug2lagwW3/dIhnyVtsI0
 LRxSqPlNlshQab3Tvt6vbmvSYGbJX6U+pxIF8PQCmedE/lIy6ABryr5u64ga49DxLiN8
 MK4WsPgIn9NW7GRNDbw1MV59ef6IfX+1geX1SWUiylB5C89UqGxiE+gj0phO1tro9zg3
 MtksPKrSUlKeHFz3C/qzNylD6+ihssw6AKnHwLjp8v7IDeqNnj6TpQwRfV5XOVP7srdY
 Pza9TwLzfNS8piQqVX6d9cpc7iZdH96UIZm45Fp8HXaIcpn+WMGC3l3+G8BPe0HJ6Nq/
 IrVg==
X-Gm-Message-State: ABy/qLZuiRavMEPcLwIr62vSssM4IPl5oz+t8DzyynfGga/ki34JII4v
 veprBSxEj5BvyJ4cKq76tTH+0RSx6xugeg==
X-Google-Smtp-Source: APBJJlHXiRP0GwcqvIqnGyIS06QKBorSkUV0T8temaJQahHs11/7QyRAB7X54fwmpCVbhEajMU1KBw==
X-Received: by 2002:a05:6830:2048:b0:6b8:67bf:fdf2 with SMTP id
 f8-20020a056830204800b006b867bffdf2mr542726otp.11.1689220363348; 
 Wed, 12 Jul 2023 20:52:43 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:8b82:587c:b800:84d:31b7:313d])
 by smtp.gmail.com with ESMTPSA id
 x6-20020a1709027c0600b001b8a37ffb5asm4756199pll.4.2023.07.12.20.52.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Jul 2023 20:52:43 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 02/11] tpm_crb: CTRL_RSP_ADDR is 64-bits wide
Date: Wed, 12 Jul 2023 20:51:07 -0700
Message-ID: <20230713035232.48406-3-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713035232.48406-1-j@getutm.app>
References: <20230713035232.48406-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.210.41; envelope-from=osy86dev@gmail.com;
 helo=mail-ot1-f41.google.com
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

The register is actually 64-bits but in order to make this more clear
than the specification, we define two 32-bit registers:
CTRL_RSP_LADDR and CTRL_RSP_HADDR to match the CTRL_CMD_* naming. This
deviates from the specs but is way more clear.

Previously, the only CRB device uses a fixed system address so this
was not an issue. However, once we support SysBus CRB device, the
address can be anywhere in 64-bit space.

Signed-off-by: Joelle van Dyne <j@getutm.app>
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
index 4c173affb6..228e2d0faf 100644
--- a/hw/tpm/tpm_crb_common.c
+++ b/hw/tpm/tpm_crb_common.c
@@ -199,7 +199,8 @@ void tpm_crb_reset(TPMCRBState *s, uint64_t baseaddr)
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
2.39.2 (Apple Git-143)


