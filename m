Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F332A787B57
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 00:17:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZIc3-00081x-7h; Thu, 24 Aug 2023 18:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZIbq-0007pB-4v
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 18:15:28 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZIbn-0006Ff-IL
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 18:15:21 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1c50438636fso213854fac.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 15:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692915318; x=1693520118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xfWECJL6/0p2q0YLo0/rd8fdm47jpkcnxFZiic9PgSI=;
 b=hrYB6c53lor6t5f8C+A5HD2o38Gezd9xRzCdnlM9LeGpYG4ux2PNpeprlOfy5Hq5rv
 yCjuxefXd/JMt2XI86xDbgxzSNP0/I4FzTBmo0kFdaeOPFJYDhjjf/RTd4uA5oLHa93g
 3Gkst29kWHAl8VHkKhIlyVdO1INlXntC+/ao8p7gJNrxSmGUhkbMr6EjGUJBZd/Bb2aB
 8rrV510As8QdB2ODE1KcHCdA0kUqU+c6I/Zn9WkSGPl9EVLsnq7DdIchYUt5A3Nw9oyq
 KTe18s/At9dmvVz7Gbg+Wa4Xqrq7tX0E9/jgPrxjHAK1sfj9dWUblTu41UnjbalPh4of
 sizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692915318; x=1693520118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xfWECJL6/0p2q0YLo0/rd8fdm47jpkcnxFZiic9PgSI=;
 b=lsTx48SfmMAtQrgwNIbOv5i5kdiVo5oi3FRuDNX92IH80uzvOr1+8hAH6dGOrxxtIk
 hnnNOuKly0Mqt9FlRfG0+ElX16EFPINUKRQgW7zt4gyYmBQ4zKzAVHbGfXVnseM3VOCA
 ecUWFg6kU5/0vNXlsoEbrt7fxpzzBKeY4v99rKRoic86tXgcLycYC4xQEfttYa8yjMW/
 XJer2EqkLQWRT6H9GGGzlB9hKVpYvqgJaj9HuxieKH0Zr2G3mQp9jhwsqMo7ZU6YcV8c
 s/ENBFYg0M+gjkJuqPGY9PlEYzj8Q+4vW1R+9AA3JYPtEsyjpVdnyjycHzqrgUb06li9
 RwIw==
X-Gm-Message-State: AOJu0Yw1d3xN1YdRzT/MnEuim+RGT+PX+0cuEIxJUl+Ox/7xPrRxCCcn
 n5g3jJ3klMfZVac0g1htAKazEkN8AaDskR/362E=
X-Google-Smtp-Source: AGHT+IGpQmLtF+gcn8UzAN/sGOwsj/T6AZYUhLbN7qRhGkZ1q/gtMCDqJW/pRsWVU6kRNe3BOph0NQ==
X-Received: by 2002:a05:6870:a109:b0:1b0:3cd4:76d5 with SMTP id
 m9-20020a056870a10900b001b03cd476d5mr1143777oae.37.1692915318108; 
 Thu, 24 Aug 2023 15:15:18 -0700 (PDT)
Received: from grind.. ([179.93.21.19]) by smtp.gmail.com with ESMTPSA id
 o129-20020a4a4487000000b00565fcfabab8sm256338ooa.21.2023.08.24.15.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 15:15:17 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH RESEND v8 12/20] target/riscv: deprecate the 'any' CPU type
Date: Thu, 24 Aug 2023 19:14:32 -0300
Message-ID: <20230824221440.484675-13-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824221440.484675-1-dbarboza@ventanamicro.com>
References: <20230824221440.484675-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x35.google.com
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
---
 docs/about/deprecated.rst | 12 ++++++++++++
 target/riscv/cpu.c        |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 92a2bafd2b..4ced7427ac 100644
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
+special that aren't already done by the default CPUs rv32/rv64.
+
+After the introduction of the 'max' CPU type RISC-V now has a good coverage
+of generic CPUs: rv32 and rv64 as default CPUs and 'max' as a feature complete
+CPU for both 32 and 64 bit builds. Users are then discouraged to use the 'any'
+CPU type starting in 8.2.
 
 Block device options
 ''''''''''''''''''''
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8dc85f75bb..913b64264f 100644
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


