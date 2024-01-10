Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4F48295C3
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:07:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUUP-000624-6C; Wed, 10 Jan 2024 04:03:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUT7-0003Yv-5v
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:01:58 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUT5-0005jp-9f
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:01:48 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3bc4f49a3b6so4329917b6e.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 01:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877306; x=1705482106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VQ15+37RwYMgkj6mErbuFjZWFMTcLVfNxoikLH6/6Uk=;
 b=KmrCBHbNRF31RSoyZNkmxaxuvH9RUzCMoV1oPuXpZ07KiGdooCIzZxOH1qUdSW/o5R
 PnwJQ+XQlCbiJi9lSS5Y3rJWufdi0p9h6mdJNaWgMXavSbjHpfGd2GkQwXbSLUGcucz5
 /mDvIhIlYvZ8soH+hScGCPfkpjZUmShTNYRpwgGIAMcbMniAFcdYnaw7uPOhq6W5lgya
 ZnoOpPbWeJBcLVgJ4TWLgLUVBEQTr9Vpl909ZgGSlobE+UCtpZPA93ROmvEHf2kHut6B
 1us2P1sSdj6HQwlC8Ub2YuI4qLkjASGbOHNHnnzXCJjRgQkT7W/6JN9f8A2gLm1R+M4W
 vpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877306; x=1705482106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VQ15+37RwYMgkj6mErbuFjZWFMTcLVfNxoikLH6/6Uk=;
 b=bIJm+VUTxWAUyzVKgMXQMBdfRJVnI9WVA8UbN9y1X3Ns/aPPrJBHMbnhwLKGCBdgry
 jPTrr9NbNnVCNuuICApSU50daAJ7QOZ9REV/4nXR/ZMWg1/vUzzRtw7KmekJZOem+6Gb
 YHASRzJZchD2vOKMrtRZ8C/sZS01c2JJS+N21E4PTEts1t3TzarmfBUSwno/+7wXMpQB
 XPxpsCc+wQT9yeNsUTl2fngVTz7Gv4Z00scepp5Pm/Q6vd1BHAHba3gx8a14Wd+Z9TEF
 ByHp/HAa/h0A8WV4kUbBybGjVw+CnwOXTt6kXuISVk892CvySstt4UdYOZGYk8MJ7XR/
 29jA==
X-Gm-Message-State: AOJu0Yys0Oa3pU4TqXyhQ+6O9FH8eJSFEw16cj5Q87C9v8tXToaxTSqG
 RU5k62xZMhiXtxAUldre/n1KkHaAMXSN+qr6
X-Google-Smtp-Source: AGHT+IFC/1vTeFA23p3NOjdxKva8a0v56SdR/ZAntpgi0TNTPZaNgLqoaj5lSGm2U9rg5Yf/rU/EBw==
X-Received: by 2002:a05:6808:1707:b0:3bd:31b2:d240 with SMTP id
 bc7-20020a056808170700b003bd31b2d240mr888635oib.14.1704877306113; 
 Wed, 10 Jan 2024 01:01:46 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.01.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 01:01:45 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 64/65] target/riscv: Don't adjust vscause for exceptions
Date: Wed, 10 Jan 2024 18:57:32 +1000
Message-ID: <20240110085733.1607526-65-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x229.google.com
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

From: Alistair Francis <alistair23@gmail.com>

We have been incorrectly adjusting both the interrupt and exception
cause when using the hypervisor extension and trapping to VS-mode. This
patch changes the conditional to ensure we only adjust the cause for
interrupts and not exceptions.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1708
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240108001328.280222-3-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 99d1275729..c7cc7eb423 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1749,8 +1749,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                  * See if we need to adjust cause. Yes if its VS mode interrupt
                  * no if hypervisor has delegated one of hs mode's interrupt
                  */
-                if (cause == IRQ_VS_TIMER || cause == IRQ_VS_SOFT ||
-                    cause == IRQ_VS_EXT) {
+                if (async && (cause == IRQ_VS_TIMER || cause == IRQ_VS_SOFT ||
+                              cause == IRQ_VS_EXT)) {
                     cause = cause - 1;
                 }
                 write_gva = false;
-- 
2.43.0


