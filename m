Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0B97C6A5A
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 12:03:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqsVP-0007Bc-En; Thu, 12 Oct 2023 06:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1qqsVJ-000780-EJ
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 06:01:20 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1qqsVH-0006yX-JK
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 06:01:17 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32483535e51so755625f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 03:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697104874; x=1697709674;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9XGMvvJZUGfMnQ/1RecN9n7QRTY4rets8V/xDm2EU20=;
 b=Juj5EbWp8nPuSQeTxDP6atjL9e6BnIGYosHgvD5mw+60+bbVLOit5s2gWpQGsr4q6j
 M04ggvzTLZFuP0GvsKsJ76wan0JpoElcFUOz8C5DdV7x0EvP5HQ47bhZTV0DRd8wjl8V
 xjNtz1OVHEvmgk2+P7X4HifI7qR+4GajeazMBFoARqnZYNBXLOx8Wd7s2ztXi9J9UQP3
 Co0XYMN9MSwhv4Vf1h3Cq8rXYudyVWO+Zxgk9RNY/EuDobit4dwaY6JTtPOOTzSJaJLC
 tyR/72rXMlzkIlkbeJEvdWYZxkzoEdRTKdiqgRDX5HfIU+B2I5vHA0g0c2nhQwaqZTdX
 Nodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697104874; x=1697709674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9XGMvvJZUGfMnQ/1RecN9n7QRTY4rets8V/xDm2EU20=;
 b=OGkcwh3Om2YingfsDZFCM2MU91F89TOlNZdUvpjziF/51MD0B+vFcbC2ti828r3EbB
 4tqDovWkSm06aFXWUdF7H/P35vKQhOMCPBCzMiHxAz6sbSax3b1NHdVvqjoRm3fWUgWB
 3Qqn4f2okm/NYIczjEvJ513hj0LRhdujlWWPwjWRKR+jd4SxBQCdQurwxsSNeit9RU6/
 ofF4Gzl9Sn0f/PVXKEubZU6C7lo9jguo5w2fya26ZEiA6Y7gYqY0K7XJc1gO+n7OSJzx
 MJeZv8akhW08M839u9D0MfWI+szYUXqnSs86U0S/AIm63mIylne80lUAnQM4WO/uZgHp
 6jrA==
X-Gm-Message-State: AOJu0YyGL7v78GuIuIbLHHckFyy155S1S6xZyy2VupWJK0soH659De+k
 /ONs1bIVjlgmLXFVXbyVv171DQ==
X-Google-Smtp-Source: AGHT+IHwKcwdmJri4A7SR9ovdcCDDHw2MjnX2rBdgbYCjJgsGomg6Wg0FdfDGEoB3/JqsqOPMwiOjQ==
X-Received: by 2002:a5d:4f85:0:b0:31a:ea9a:b602 with SMTP id
 d5-20020a5d4f85000000b0031aea9ab602mr23493717wru.1.1697104873739; 
 Thu, 12 Oct 2023 03:01:13 -0700 (PDT)
Received: from localhost.localdomain
 (cpc91760-watf12-2-0-cust235.15-2.cable.virginm.net. [81.111.69.236])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a056000024c00b0032d88e370basm3803122wrz.34.2023.10.12.03.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 03:01:13 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com,
 rkanwal@rivosinc.com
Subject: [PATCH v4 2/6] target/riscv: Check for async flag in case of
 RISCV_EXCP_SEMIHOST.
Date: Thu, 12 Oct 2023 11:00:59 +0100
Message-Id: <20231012100103.28612-3-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012100103.28612-1-rkanwal@rivosinc.com>
References: <20231012100103.28612-1-rkanwal@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

RISCV_EXCP_SEMIHOST is set to 0x10, which can be a local interrupt id
as well. This change moves RISCV_EXCP_SEMIHOST to switch case so that
async flag check is performed before invoking semihosting logic.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 8c28241c18..aaeb1d0d5c 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1605,15 +1605,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     target_ulong htval = 0;
     target_ulong mtval2 = 0;
 
-    if  (cause == RISCV_EXCP_SEMIHOST) {
-        do_common_semihosting(cs);
-        env->pc += 4;
-        return;
-    }
-
     if (!async) {
         /* set tval to badaddr for traps with address information */
         switch (cause) {
+        case RISCV_EXCP_SEMIHOST:
+            do_common_semihosting(cs);
+            env->pc += 4;
+            return;
         case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
         case RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT:
         case RISCV_EXCP_LOAD_ADDR_MIS:
-- 
2.34.1


