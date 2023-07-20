Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 356F875B581
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 19:21:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMXKS-0008SG-AR; Thu, 20 Jul 2023 13:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qMXKA-0007ue-F9
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 13:20:24 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qMXK4-0004os-Hr
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 13:20:21 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-563531a3ad2so719446eaf.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 10:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689873611; x=1690478411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=klVhwGjdzcWF1Sjx5AxdZ9uqA77HCAP9UFtKj55zOHM=;
 b=bA7pc+piQvJ5Z9V4I+XekSgL/pBK562hzPVdosnLETI1WeGOm3QgWrexlYA3mWStq2
 xQHrozPBheWlSQoBb92obeSMnYOsFs8P4BSpTrcP0bA1FbfDXWqFG9Cl7TXkZ9NC5sqm
 11glMEFFg3Zjd2NdtqSfEib3wKTQLI7IpD+2WpKDElWM+QWi6qCmOYPQNB7HDW9vFOxC
 wu+nTX8VMffVnKFPR93/a6DZrImQ9ELlVWa+gyeq17p9EhK+EbySD1EJ4Z3Sh+fORqae
 F8Cj8L+Z12FjukxvSsdmgCJefSKN4tyMY1dobb6dlG7UgNhDru5P16ckhqrZ5y19IMXS
 jLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689873611; x=1690478411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=klVhwGjdzcWF1Sjx5AxdZ9uqA77HCAP9UFtKj55zOHM=;
 b=LbDV5FekxDP9napk2E9wBp4Y302f7mtbfiW3PLayWO2pSNW74dXF73u0oioNGgLF7s
 1s7mq0qyEqwNgawu9lliTc2/+Zl+dKDOis4KkNf6R54ry/BKvIA/FHdr+AqvLdNOmS+i
 SxuA0YXcs3DqRuph3id7DDg7bnHYi9llKS1dwSLLdZif4tuluXaLg8gxPG8zhTbP3jYM
 GaISfZqMc08VJmeVvNH/HsADFE86EbECx4TH8YxvyAIVPSAkGfAmA9FGNh9UXRlTxAV8
 qPVb5qUCXt+DJtBO7cAUuENaZJzRmY1ejeYZ3jc+WJVdhIKAT5XE+of+I3pChblJfWpo
 /ocQ==
X-Gm-Message-State: ABy/qLZvEHELxzDEERyaSKZEzmrgkLj2RlitGFC+8k/rnoEF7W6nktW5
 F0qnQfropOru5K+3tsMyEhs3yUZNaUfQp7NaL6ualQ==
X-Google-Smtp-Source: APBJJlFDs+1J6kEPZ2sI9/7WaLII1T25rD/tW2DV6Zfaz5oc9OlDM2B92kwFTT9q1+1+Lu54IFwrEQ==
X-Received: by 2002:a05:6870:8197:b0:1b0:6dec:265 with SMTP id
 k23-20020a056870819700b001b06dec0265mr89878oae.55.1689873611511; 
 Thu, 20 Jul 2023 10:20:11 -0700 (PDT)
Received: from grind.. (201-69-66-211.dial-up.telesp.net.br. [201.69.66.211])
 by smtp.gmail.com with ESMTPSA id
 i2-20020a4aab02000000b0055975f57993sm582564oon.42.2023.07.20.10.20.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 10:20:11 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 v5 11/11] target/riscv: deprecate the 'any' CPU type
Date: Thu, 20 Jul 2023 14:19:33 -0300
Message-ID: <20230720171933.404398-12-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720171933.404398-1-dbarboza@ventanamicro.com>
References: <20230720171933.404398-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc30.google.com
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
index 0221bfcbef..9f21dc775e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1471,6 +1471,11 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
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


