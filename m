Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D24C179A3C5
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:47:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfagZ-0003et-TD; Mon, 11 Sep 2023 02:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfafq-0002jf-Fk
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:45:33 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfafo-00051d-6k
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:45:30 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68fb7fb537dso688941b3a.2
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694414726; x=1695019526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s9QHVi3wOzOBTnchANYcU4Sl/KIRcnvifC0QwRT4WCQ=;
 b=DamTlWPBpPu8GR3df+JHTFLT1EvMJ7Wq914e6K2cYAgJvTmxQ5Z/TXmM7s/1PRxoPx
 LI8Uvk1CeLO7q70GCIL6Kw68t2iLQCgkif4YnugjW+YqB+mKSTXA3Qss/6U2pHKwdrcQ
 ZaJhBqki9bHYl2FNK1sB0EfsHoAy1M+lD0esbwbVDLhQQim3TVjFyOndXPJJ2XQKiQfc
 onTxCJPxxfyt4XG+9DL/KCjClvkCb3xrSrilt+KKSwkwVpoXFQJ01Un8rlizamPWg1N8
 qMcgjszBgag8mGsFDMW/UxaMTUYBxLzyH9H4I9cqcz/nIbXmPafiRUlTcBGPsSlozKL4
 nmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414726; x=1695019526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s9QHVi3wOzOBTnchANYcU4Sl/KIRcnvifC0QwRT4WCQ=;
 b=SnF/Fu4wEetwrznz86Nt0W3TxYBRGgrCnKWYP2pQIWYzPNvOILy93uxdz8SMC8wzPf
 yzk+M5qXWjdc2HX2bDQjlLHW/taDibfN0cPpykVc6Su8QLn1dErmcwlLFbaeRtX9QxH+
 5Pqaj/9CJMQ4u3z06fi0pHnFwnNEnuBluL6rchg32MhUgZjM0qN31qkcmps31U5g13XE
 RWFuAQ1sTDjWxq3RKudDv8AnhkOTrG7NR/sV4gAQAiFiD9+bYhrbilJG+c+GTydUTRQe
 3qugI08RG8yCZvyuFfJfe2depwx9IlOL6v3v8Yq18bseCyL6+n1hiN4k8vjjBurGPIub
 PQwg==
X-Gm-Message-State: AOJu0YwrVing0z9MJoTQHDHqPVEFHLr9CcfknRp4TyIbT4lBimzFI1hl
 DdloeEjREL6jRnQr3h9sEm69Z1DCwkITEw==
X-Google-Smtp-Source: AGHT+IGE1HaLby79ASquSyO64T38p1dwtsaXWt9ueOFD7md0hnAIuT0SR8U1WTehXo+Zs8JbTPjXKw==
X-Received: by 2002:a05:6a00:2d11:b0:68b:daa9:7bf2 with SMTP id
 fa17-20020a056a002d1100b0068bdaa97bf2mr8723061pfb.7.1694414725725; 
 Sun, 10 Sep 2023 23:45:25 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a656a8c000000b00553dcfc2179sm4264606pgu.52.2023.09.10.23.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:45:24 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 28/45] linux-user/riscv: Use abi type for target_ucontext
Date: Mon, 11 Sep 2023 16:43:03 +1000
Message-ID: <20230911064320.939791-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

We should not use types dependend on host arch for target_ucontext.
This bug is found when run rv32 applications.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230811055438.1945-1-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 linux-user/riscv/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
index eaa168199a..f989f7f51f 100644
--- a/linux-user/riscv/signal.c
+++ b/linux-user/riscv/signal.c
@@ -38,8 +38,8 @@ struct target_sigcontext {
 }; /* cf. riscv-linux:arch/riscv/include/uapi/asm/ptrace.h */
 
 struct target_ucontext {
-    unsigned long uc_flags;
-    struct target_ucontext *uc_link;
+    abi_ulong uc_flags;
+    abi_ptr uc_link;
     target_stack_t uc_stack;
     target_sigset_t uc_sigmask;
     uint8_t   __unused[1024 / 8 - sizeof(target_sigset_t)];
-- 
2.41.0


