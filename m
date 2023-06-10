Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E1F72ABB9
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:33:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yhD-0004Qr-Ft; Sat, 10 Jun 2023 09:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhB-0004Q5-1r; Sat, 10 Jun 2023 09:31:57 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yh9-0007aD-Ds; Sat, 10 Jun 2023 09:31:56 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-38c35975545so1272323b6e.1; 
 Sat, 10 Jun 2023 06:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686403913; x=1688995913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dJA42PKMV5DCxoTW+swU3bkKFLofsw1iAtmb+IC54bs=;
 b=dO+CwLVvALxOVUpdzCfnplyK6DyB3PSWTzGhI8/0zRaCA7QehI/2w8BXUPCdGQlOub
 5Zrsci7YRRdbBdQ25J5Xm9BC84AE6KaJG0b1soZEvPuaiWWun7fHzPO3TjVECp0FAK0a
 fanjvyfWmzC3ZLfgRSXRC+n7MEI/ZYWxj3k1D3jQimZCHAjKkjWkGwC654wummwFnjBq
 P5lm2IXCo5JPl04fANZ+X0F+bisNdV0/Q7OkGI22CdnFYJl9nxFZxqC2qytges4dSwER
 jkfH503YykD/DVx6TBo8Rj4gfpQrG1Qmm0t/ldqLzpBhOGAsPCAw/CdSYdwJxVImNSZH
 c6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686403913; x=1688995913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dJA42PKMV5DCxoTW+swU3bkKFLofsw1iAtmb+IC54bs=;
 b=MY3fZCDiykSvj1v7PRe+kvuUZuUcPlZ6HT2Y3pkekga7Mm4ZiplFqdpwjWCwXuQ7Ld
 dH07HQ3Mf2ilvjaN08TfiAQwvxvLgvjrtIQuG6L5jk9l5UwJtNjsL1QPoMrF3LFg0GIp
 45KaldRlEC3ie6eXH6BlsBO++dDmxexDt8HCSC4Ikj1erv6xx2wePYx2VF2A8Bq4LcQP
 9qTDhL6r6mTDS681ZlaI2q0hJ46tJWiRn/R7jCIQuXNkv3WgF/elPlTby5kbWeGp8zQn
 +JoACYKFKcgmM21IX4EhqM/tqaUJ7eIYQ5M/Alv7CRrtseEckPgH54cfqHplsmbYMoI+
 eZzA==
X-Gm-Message-State: AC+VfDzpyPC1GfE24+X/4iWAKsCRYYEY6egOX+kMXQHo9D3b9x4cDpAU
 s2b3F3MFOBBv0ws3Cvr6B5rRHhqFiUs=
X-Google-Smtp-Source: ACHHUZ7L/vOP0Qi337ra/k0o+81FnncGWSfj1Xq0L8Q6HMUGSWHHO7jl7OmyZ8JV8z6aJ1NycCDV5A==
X-Received: by 2002:a05:6808:1b11:b0:398:1104:ef6c with SMTP id
 bx17-20020a0568081b1100b003981104ef6cmr957546oib.43.1686403913589; 
 Sat, 10 Jun 2023 06:31:53 -0700 (PDT)
Received: from grind.. ([177.170.117.52]) by smtp.gmail.com with ESMTPSA id
 y3-20020a544d83000000b00395f2c84b81sm2428420oix.54.2023.06.10.06.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 06:31:53 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Frederic Barrat <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 05/29] pnv/xive2: Handle TIMA access through all ports
Date: Sat, 10 Jun 2023 10:31:08 -0300
Message-Id: <20230610133132.290703-6-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610133132.290703-1-danielhb413@gmail.com>
References: <20230610133132.290703-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

The Thread Interrupt Management Area (TIMA) can be accessed through 4
ports, targeted by the address. The base address of a TIMA
is using port 0 and the other ports are 0x80 apart. Using one port or
another can be useful to balance the load on the snoop buses. With
skiboot and linux, we currently use port 0, but as it tends to be
busy, another hypervisor is using port 1 for TIMA access.

The port address bits fall in between the special op indication
bits (the 2 MSBs) and the register offset bits (the 6 LSBs). They are
"don't care" for the hardware when processing a TIMA operation. This
patch filters out those port address bits so that a TIMA operation can
be triggered using any port.

It is also true for indirect access (through the IC BAR) and it's
actually nothing new, it was already the case on P9. Which helps here,
as the TIMA handling code is common between P9 (xive) and P10 (xive2).

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <20230601121331.487207-6-fbarrat@linux.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/intc/pnv_xive2.c | 4 ++++
 hw/intc/xive.c      | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 132f82a035..e5a028c1e6 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -1662,6 +1662,8 @@ static void pnv_xive2_tm_write(void *opaque, hwaddr offset,
     bool gen1_tima_os =
         xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
 
+    offset &= TM_ADDRESS_MASK;
+
     /* TODO: should we switch the TM ops table instead ? */
     if (!gen1_tima_os && offset == HV_PUSH_OS_CTX_OFFSET) {
         xive2_tm_push_os_ctx(xptr, tctx, offset, value, size);
@@ -1681,6 +1683,8 @@ static uint64_t pnv_xive2_tm_read(void *opaque, hwaddr offset, unsigned size)
     bool gen1_tima_os =
         xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
 
+    offset &= TM_ADDRESS_MASK;
+
     /* TODO: should we switch the TM ops table instead ? */
     if (!gen1_tima_os && offset == HV_PULL_OS_CTX_OFFSET) {
         return xive2_tm_pull_os_ctx(xptr, tctx, offset, size);
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index ebe399bc09..5204c14b87 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -500,7 +500,7 @@ static const XiveTmOp xive_tm_operations[] = {
 static const XiveTmOp *xive_tm_find_op(hwaddr offset, unsigned size, bool write)
 {
     uint8_t page_offset = (offset >> TM_SHIFT) & 0x3;
-    uint32_t op_offset = offset & 0xFFF;
+    uint32_t op_offset = offset & TM_ADDRESS_MASK;
     int i;
 
     for (i = 0; i < ARRAY_SIZE(xive_tm_operations); i++) {
-- 
2.40.1


