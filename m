Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3BA8251DC
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 11:25:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLhNk-0007nV-1d; Fri, 05 Jan 2024 05:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rLhNh-0007mk-DA
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:24:49 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rLhNf-0004Mb-Mx
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:24:49 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-337520892f7so215634f8f.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 02:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1704450285; x=1705055085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyhXeq5O9PIrBjHu1IQT114KkUm0/yE3+A0a8VWqx9o=;
 b=JktbmNP6RiAAVB4mFSE4yymfmknCy/qR954cl51YAfl37n0GK4MgKdRr+11qeEGdPA
 0FCwmpgV3czTJRJA+VPpfzZZS+j7A0ekfejyo8U3A7/GxMf07KNUkLalczO6CvRdrl3N
 Z8R5m63LXnt8NSAHYlx1L10gNZQDEY2ltuHb3B0IQ6h8Q0p3vdp7z5pqdvQk/f6ulwAM
 8hwq5h0V7rKhL1FZTNfmmSEkIiHKiFVLC8EUt8cM5ni07NNxCTPDSu4hV0N3UUJrPmCe
 I6Dj0PGq7tY5eBjEydEsG7VSUrO86bRCeVfXDL/xmuQZASt7NnHoo5rLwjzdpYoXuIPL
 ny6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704450285; x=1705055085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyhXeq5O9PIrBjHu1IQT114KkUm0/yE3+A0a8VWqx9o=;
 b=PJ7xHWaSu7SY36NIf+DXQqMQSutJa7vkKuuuYZRCVIX/67utW8G3Uv39t2BPrgQDg8
 ez+gZCCEQBNOp+SLUOK0qI4XaSyB/05wMIEnhd9di0bCg44i77buXNl4ZBBU3/Vk8TrE
 xLP/8otug2cTSKLQkA31fj65cWu3zGs3kAe5sjxtyv1tYDMyo6fbxmyvxak4uc0BSBrE
 B4FkQ1mGxFBOyaMpaRMSgkWLu6Bfs7WWtG+pqMZ6xbBzWXbfDD/aRmuhGtRiSfkcdf1R
 A9N7idLlsqIjj3ejZCpmwWBeHdBtCq9hXUGk5WSUZsaXkD7+aPS5N8+26em+EtJGZgld
 YPNA==
X-Gm-Message-State: AOJu0YxEAKKSgZ+DHoNiFz++OgxLx6GGFmrQMuLXt4Pg/nEdwz4EB2gT
 G3mgrFSaWqPatB6hKQpDbcN8XwKxncHo6xJq013+mZU0tA==
X-Google-Smtp-Source: AGHT+IFZfSonu2LWihWEAXG4WxVUqYFrV1VR3yx1FtqVmEbEODNAaqTeJWgSfQmZFeu6R6i8/3Rprg==
X-Received: by 2002:a05:600c:1c10:b0:40d:81d3:8d21 with SMTP id
 j16-20020a05600c1c1000b0040d81d38d21mr1118152wms.124.1704450285624; 
 Fri, 05 Jan 2024 02:24:45 -0800 (PST)
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:323e:281a:689:2b09])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a05600c444800b0040d934f48d3sm1117548wmn.32.2024.01.05.02.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 02:24:45 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>
Subject: [PATCH 8/9] leon3: check cpu_id in the tiny bootloader
Date: Fri,  5 Jan 2024 11:24:20 +0100
Message-Id: <20240105102421.163554-9-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240105102421.163554-1-chigot@adacore.com>
References: <20240105102421.163554-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=chigot@adacore.com; helo=mail-wr1-x42f.google.com
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

Now that SMP is possible, the asr17 must be checked in the little boot code
or the secondary CPU will reinitialize the Timer and the Uart.

Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 hw/sparc/leon3.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 38fb8d9af1..7498eaa827 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -98,13 +98,27 @@ static uint32_t *gen_store_u32(uint32_t *code, hwaddr addr, uint32_t val)
 
 /*
  * When loading a kernel in RAM the machine is expected to be in a different
- * state (eg: initialized by the bootloader). This little code reproduces
- * this behavior.
+ * state (eg: initialized by the bootloader).  This little code reproduces
+ * this behavior.  Also this code can be executed by the secondary cpus as
+ * well since it looks at the %asr17 register before doing any
+ * initialization, it allows to use the same reset address for all the
+ * cpus.
  */
 static void write_bootloader(CPUSPARCState *env, uint8_t *base,
                              hwaddr kernel_addr)
 {
     uint32_t *p = (uint32_t *) base;
+    uint32_t *sec_cpu_branch_p = NULL;
+
+    /* If we are running on a secondary CPU, jump directly to the kernel.  */
+
+    stl_p(p++, 0x85444000); /* rd %asr17, %g2      */
+    stl_p(p++, 0x8530a01c); /* srl  %g2, 0x1c, %g2 */
+    stl_p(p++, 0x80908000); /* tst  %g2            */
+    /* Fill that later.  */
+    sec_cpu_branch_p = p;
+    stl_p(p++, 0x0BADC0DE); /* bne xxx             */
+    stl_p(p++, 0x01000000); /* nop */
 
     /* Initialize the UARTs                                        */
     /* *UART_CONTROL = UART_RECEIVE_ENABLE | UART_TRANSMIT_ENABLE; */
@@ -118,6 +132,10 @@ static void write_bootloader(CPUSPARCState *env, uint8_t *base,
     /* *GPTIMER0_CONFIG = GPTIMER_ENABLE | GPTIMER_RESTART;        */
     p = gen_store_u32(p, 0x80000318, 3);
 
+    /* Now, the relative branch above can be computed.  */
+    stl_p(sec_cpu_branch_p, 0x12800000
+          + (p - sec_cpu_branch_p));
+
     /* JUMP to the entry point                                     */
     stl_p(p++, 0x82100000); /* mov %g0, %g1 */
     stl_p(p++, 0x03000000 + extract32(kernel_addr, 10, 22));
-- 
2.25.1


