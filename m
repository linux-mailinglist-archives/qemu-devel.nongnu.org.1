Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E2C758679
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 23:05:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLrrs-0002pf-IX; Tue, 18 Jul 2023 17:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qLrrf-0002bv-Tm
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 17:04:16 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qLrrb-0007Qx-J3
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 17:04:09 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6b91ad1f9c1so4192189a34.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 14:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689714245; x=1692306245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q4G29VGflkTrZ5gEKZDD76lCp57OZJgV7/U2lXcg9NM=;
 b=C2ajsWHgb1nOfQwTHeGzEfxmqxtiClg+6kurDoKUKSwcKl2Xhz83zjsCbHz6TQV5pl
 ewKGNBfEhH+dIpEpf+psVO8mA8moTeD1hQvpFZHpMdqq2G+c9+MV0ZlZVMDgYjieg0TJ
 8OI7Tsij9Dzr1QD/ZF/w0UxZibbDnc3d7qQ1DP9BwmlNwsKNtAJptgmsuvRXNbgMs+s5
 GAglaZ+93WhKXHQgOEez0M/U6iLavS6jDCSmvtev8Sljd1m8JCKDV6Cn9UGWkZVuIXQ5
 aurPo740aBHtdrm1JnLLmmnqgOFDD5AYkHtrgkfH32d4QIXWzaEE8JgtJ4eKZVnERDeM
 b9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689714245; x=1692306245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q4G29VGflkTrZ5gEKZDD76lCp57OZJgV7/U2lXcg9NM=;
 b=jA4coCz8DenCfD8RrHzVsmJ74QITTr3HRrWISaOWqkaAOQ2awJXiM03Xse001bcIFW
 DJEiD8q0qZuNOxKnQjLi77VZcpItwen90ChXqPLn96F0bC15cvw0xvgB5QS0kqGvzjlQ
 +fXzfA9RrW9ahmPfZCkHRLJ5iyGw4l4YliRWxEltW+Pq+ZSXegfU/EtydbPmkkBD7DPb
 FF4MvsWP2rIugiwS5k55M5Ar7use9c1GnvF1sVm/sxrFtBHJZJaGfaadwofMK/MDgZSH
 65L+N3c8giVTXtavI2oDmcOIScFqV2MYZSXCGIXqX0BZ7LK1Q62WEGQnWcwGH3kpTQSV
 hBbg==
X-Gm-Message-State: ABy/qLb0RSB9CIh1DnlPBgQo01pV/TEME2ng/75YxxEFZuAl3Ri3Tlqa
 xgdqSmRpdbMpc49m7Lddwy8eMSfWl2OVafcPXmZs7Q==
X-Google-Smtp-Source: APBJJlEOHpbSJEah2dNT9imjqJTwN4bdN+PoCuaz7Zl1EsaQDjfKFVH1byney3f0a6oL6+32SIvniw==
X-Received: by 2002:a05:6830:1d61:b0:6b9:8ea6:f515 with SMTP id
 l1-20020a0568301d6100b006b98ea6f515mr674894oti.10.1689714245641; 
 Tue, 18 Jul 2023 14:04:05 -0700 (PDT)
Received: from grind.. (201-69-66-211.dial-up.telesp.net.br. [201.69.66.211])
 by smtp.gmail.com with ESMTPSA id
 v2-20020a056830140200b006b96384ba1csm1160657otp.77.2023.07.18.14.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 14:04:05 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 v4 11/11] target/riscv: deprecate the 'any' CPU type
Date: Tue, 18 Jul 2023 18:03:29 -0300
Message-ID: <20230718210329.200404-12-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718210329.200404-1-dbarboza@ventanamicro.com>
References: <20230718210329.200404-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32c.google.com
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

The 'any' CPU type was introduced in commit dc5bd18fa5725 ("RISC-V CPU
Core Definition"), being around since the beginning. It's not an easy
CPU to use: it's undocumented and its name doesn't tell users much about
what the CPU is supposed to bring. 'git log' doesn't help us either in
knowing what was the original design of this CPU type.

The closest we have is a comment from Alistair [1] where he recalls from
memory that the 'any' CPU is supposed to behave like the newly added
'max' CPU. He also suggested that the 'any' CPU should be removed.

The default CPUs are rv32 and rv64, so removing the 'any' CPU will have
impact only on users that might have a script that uses '-cpu any'.
And those users are better off using the default CPUs or the new 'max'
CPU.

We would love to just remove the code and be done with it, but one does
not simply remove a feature in QEMU. We'll put the CPU in quarantine
first, letting users know that we have the intent of removing it in the
future.

[1] https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02891.html

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 docs/about/deprecated.rst | 12 ++++++++++++
 target/riscv/cpu.c        |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 02ea5a839f..68afa43fd0 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -371,6 +371,18 @@ QEMU's ``vhost`` feature, which would eliminate the high latency costs under
 which the 9p ``proxy`` backend currently suffers. However as of to date nobody
 has indicated plans for such kind of reimplemention unfortunately.
 
+RISC-V 'any' CPU type ``-cpu any`` (since 8.2)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The 'any' CPU type was introduced back in 2018 and has been around since the
+initial RISC-V QEMU port. Its usage has always been unclear: users don't know
+what to expect from a CPU called 'any', and in fact the CPU does not do anything
+special that aren't already done by the default CPUs rv32/rv64.
+
+After the introduction of the 'max' CPU type RISC-V now has a good coverage
+of generic CPUs: rv32 and rv64 as default CPUs and 'max' as a feature complete
+CPU for both 32 and 64 bit builds. Users are then discouraged to use the 'any'
+CPU type starting in 8.2.
 
 Block device options
 ''''''''''''''''''''
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7fdde68dee..edf3b95a14 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1470,6 +1470,11 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
+    if (object_dynamic_cast(OBJECT(dev), TYPE_RISCV_CPU_ANY) != NULL) {
+        warn_report("The 'any' CPU is deprecated and will be "
+                    "removed in the future.");
+    }
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
-- 
2.41.0


