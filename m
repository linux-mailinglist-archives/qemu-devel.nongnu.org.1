Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B8879028A
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 21:48:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcA7d-0008IW-BF; Fri, 01 Sep 2023 15:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qcA6z-00080Z-7e
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 15:47:25 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qcA6u-0003FR-3j
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 15:47:20 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1d0d3d40124so1544446fac.3
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 12:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693597633; x=1694202433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6bz0dqSG1/NR9vONR3Zg7ZJ3UJqOsJUfrg/aOBJFGTs=;
 b=gDAbgfWLU3eXboE7DbyCfvJslz2o+7WlFXcKWYMeBPsutavAcbwsSCFCdczRbUvYag
 63vTo/GMd6JjwWtWc6QfPpFGI4v409Il5alPga+cePnQA4+rai2oaEPFN1tRVT2Ldx0J
 DjKNH7MJFwccBZqwxmDZ+iihAExXO1Tiy2m8vnCardM46IKEgbz+z+wvxI/KtxsOu/SC
 bF2kM9i+J8GFjQBuA0V05ujq0A7+NK2xSjpo1BvY3AkM8AJYnSG9QqOQp6BxxFB/4D05
 vpjZIpI6BkMaXP0Z0On/12w8XX0jZfjHkuthaSvQG5p3W/Wv5m8/XljcmDu2iRCNba3L
 UqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693597633; x=1694202433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6bz0dqSG1/NR9vONR3Zg7ZJ3UJqOsJUfrg/aOBJFGTs=;
 b=CG4JADlNPHm/xG8MyyYXWdAHJrSI5Y/arv9OhC/jiJXcJp2CGl99fSfffPNy9sS3kC
 kKCFvU2huhMLray848ur55zFkctLJByNCgo5HQg1dmZ7w0r6eDFq8/P7S7ScwFZHCMEn
 wM1O4vdG/bGLnKagvHmRAZIkfF7ikimXKP/Z9Bqo6w+6X4qBmq88lOOt5Z6knbH6Vcwu
 LVfa1mBWaw++UBUN1nDlumNNZ4roijgqqAk/HqwEuuQ1uciNUq+3RllHVyur2tLX+IcA
 pP6Edfv91eUS3VbMxLrxQEU5J83XLa6iRZhulpLftwk8Cp2HDMtMk/nNzWCm154GEQK5
 y6aA==
X-Gm-Message-State: AOJu0Yw644m6GUdpxXIi6rppOdy6Kad8pIYMeag/IJ2pU0Ol2sE7+TjZ
 Hm7ATGcFD+7/cliFfIXCqYQEG3jgviVcAikYf50=
X-Google-Smtp-Source: AGHT+IEKEuW4D07TGSOb3OWzYiprA8+hyyIcBqHL5xjqhBcGGUIh8qxe6ZJbRXBOzs2q5E4xewrEoA==
X-Received: by 2002:a05:6870:8327:b0:1bf:6ec:dd4d with SMTP id
 p39-20020a056870832700b001bf06ecdd4dmr3890147oae.28.1693597633285; 
 Fri, 01 Sep 2023 12:47:13 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.194])
 by smtp.gmail.com with ESMTPSA id
 h187-20020a4a5ec4000000b00565d41ba4d0sm2303002oob.35.2023.09.01.12.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 12:47:13 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 12/20] target/riscv: deprecate the 'any' CPU type
Date: Fri,  1 Sep 2023 16:46:18 -0300
Message-ID: <20230901194627.1214811-13-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230901194627.1214811-1-dbarboza@ventanamicro.com>
References: <20230901194627.1214811-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 docs/about/deprecated.rst | 12 ++++++++++++
 target/riscv/cpu.c        |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 92a2bafd2b..7277d4e8a4 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -371,6 +371,18 @@ QEMU's ``vhost`` feature, which would eliminate the high latency costs under
 which the 9p ``proxy`` backend currently suffers. However as of to date nobody
 has indicated plans for such kind of reimplementation unfortunately.
 
+RISC-V 'any' CPU type ``-cpu any`` (since 8.2)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The 'any' CPU type was introduced back in 2018 and has been around since the
+initial RISC-V QEMU port. Its usage has always been unclear: users don't know
+what to expect from a CPU called 'any', and in fact the CPU does not do anything
+special that isn't already done by the default CPUs rv32/rv64.
+
+After the introduction of the 'max' CPU type, RISC-V now has a good coverage
+of generic CPUs: rv32 and rv64 as default CPUs and 'max' as a feature complete
+CPU for both 32 and 64 bit builds. Users are then discouraged to use the 'any'
+CPU type starting in 8.2.
 
 Block device options
 ''''''''''''''''''''
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 365c2b3b56..0dae259e02 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1522,6 +1522,11 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
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


