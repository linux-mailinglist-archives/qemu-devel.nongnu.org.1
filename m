Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8405D765FD7
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 00:42:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP9BU-0001R4-8g; Thu, 27 Jul 2023 18:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qP9BO-0001QE-UJ
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 18:10:06 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qP9BN-00059a-6P
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 18:10:06 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-56c4c4e822eso753108eaf.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 15:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1690495804; x=1691100604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TT8K7Pgq6e6QtLVLiCrNKns9T2qf11s3cVvYvb10ScU=;
 b=pMxfzMBdrvd82CWGYg86oNRaFJAXanjZK70NRyfOUs0qGPqFzivfOh9O2ngVsSQ/WZ
 jzUDwEpYQpOV8wGORXWoCe1FXg2cc8cJ0a3ahIlG2DrzYa8gOYaTYGd+G8zWQXyMNALG
 SPlXUJhiCdEgJx+WfLpWbivTCgKFbguGwBJRxz8rUT+eTP+PbNe3UDFMNj0yNukfU+lk
 HCgsAeAG5dlVbc4WgHe+ddG+3M/ZejiZEq7S0V6dp1Jk7EooHm2bVt324f0nT+aJDL4h
 glj7huceNVSguqow2rBJjrybvjXvZBlHtAz1f1y2QfkKUN5MQF7Lo23n87a1lclk94aa
 7G4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690495804; x=1691100604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TT8K7Pgq6e6QtLVLiCrNKns9T2qf11s3cVvYvb10ScU=;
 b=f4VMx/2aI5PFtwwIDNFW+WJDNhl/PavfNY5OjLAadyU9JvjyFsdtVuOXZ7xcdqnyIo
 0sZOkcs7lnz2X4iw8jqzF5WHKlOz8TFtzfkJOzwkFOyTylULBm3b15HjfPlA/4jyzgTx
 JFWvFUPV6A6Sp23Iybl7BcspOCpqGA1vW27NCKl01zQk61HSaBWPpjjXFVXokBQPoRCL
 k4WespzhBkDLSLrDZm3lpeU9LqyO0GuyS1C77cyDnhEMh/ClnDOCFQZwxzPWu3406nkH
 lzPyt1hgPBs8dSZ9XdESodCLo9zfG+gT01CPg4SNuP4z8n3fFdS634mIxo3t6A1LQVzr
 iezg==
X-Gm-Message-State: ABy/qLYn+TQMKiC3dJUzvkOwy+s0H30nkzQ3pdNZ3xmeeJJF0mMw4Jst
 sFXWe8eiSKtysCk0t4V3s/elIJV5JfVEiRZs2BhP1w==
X-Google-Smtp-Source: APBJJlHiOPKnHku+ugc5hKpiGo/NlmOPAfiieJSTtOSrkY2748GR/Qdb4yuRySu0AG0vnPAAPzacdA==
X-Received: by 2002:a4a:3c4e:0:b0:566:f1f6:9de7 with SMTP id
 p14-20020a4a3c4e000000b00566f1f69de7mr789556oof.9.1690495803860; 
 Thu, 27 Jul 2023 15:10:03 -0700 (PDT)
Received: from grind.. (201-69-66-36.dial-up.telesp.net.br. [201.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 y136-20020a4a458e000000b0051134f333d3sm1070471ooa.16.2023.07.27.15.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 15:10:03 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 12/12] target/riscv: deprecate the 'any' CPU type
Date: Thu, 27 Jul 2023 19:09:27 -0300
Message-ID: <20230727220927.62950-13-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727220927.62950-1-dbarboza@ventanamicro.com>
References: <20230727220927.62950-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
index 3e840f1a20..b5a2266eef 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1477,6 +1477,11 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
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


