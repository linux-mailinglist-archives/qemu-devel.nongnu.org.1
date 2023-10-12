Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6157C63EE
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:19:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn3O-0001IU-G0; Thu, 12 Oct 2023 00:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn38-0000zG-Uq
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:11:51 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn37-0002Jd-5P
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:11:50 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-584a761b301so424952a12.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083907; x=1697688707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZwwMzIi6RAAHdGdWRIXn2P9ObL5Rkf0mKhB7bpAY6gM=;
 b=EcoWInzrx4GDKHSHGebzsgdKIGsZ/xpiFuyzxZVc5gouqiimM8280Xr5hcuEyBMuEi
 jOXLo8l7wmnoezLjKCA34kIQRD+hYnxHtYiK+uKTOgGAMWeXwoLyur/MyKpJvoU+dzWd
 8NnffbgBjUaSTQnIbZIZbMxz6C8aJc2WCRxLAQmSlW+KYzdd/IFHToN1BigjnDu8WXBM
 BtTlla1ItSREr2zjn4UblaDNYg4KjMnqzRzgOOTEAQkyX0dedwVazzlK3i8ICQB0ZjtE
 vZH08WrmZBSVR1I2w9a3yCIJ34PogZzuehsBN78ZbBK6xk0zGZVOK/qgW/WdHmRDQ4Tr
 1YJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083907; x=1697688707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZwwMzIi6RAAHdGdWRIXn2P9ObL5Rkf0mKhB7bpAY6gM=;
 b=NaTZVSvmr1F1o0pq4hw2aOKP9AchrX1nu04UsTVhH4pGQtkMvzHDGfn9T8ypTZIdGS
 SQpbwZZv3XOeuTq5Vdt5wlJMmJFpOfb3exXG6CSSGyo0kVD6An2W89E1Ls4QBx88QOZj
 GNI8lQUOb8t3d4/NEmMRvRt4TPJd7HWTQBc+JHUuGOC6dWa6/1otsbGccp2ZwMpYQulH
 0YLRuEQG26BQZzgIbkZoR/2oyIu81C6KRclw9L0vPa5JXe9z2Dr0CLr++NPFbuW3PPtc
 2js2vQf9TnJDm0LW0H87JXEY6TSIaQdlm+mkhB8wauWbfqAbbodY/NM2g4e4qysfHJ2p
 RPoA==
X-Gm-Message-State: AOJu0Yy0Dn73WpkIyZ8BG+qsx0swP0tF0/h8fimG4JrtboOH5ZCkOg1i
 3JUZobO5DDA59YnKRZflyPC4fRZv2hLAiQ==
X-Google-Smtp-Source: AGHT+IELMiqHLKN2gOPVq4bkwfn8w08m8F8FOq9m5G9b+Pxy8TuwigBL19ehn5RTCIlBIDFwtUFEkA==
X-Received: by 2002:a05:6a20:8f0c:b0:13f:9cee:ff42 with SMTP id
 b12-20020a056a208f0c00b0013f9ceeff42mr29752151pzk.41.1697083907407; 
 Wed, 11 Oct 2023 21:11:47 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:11:46 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/54] target/riscv: deprecate the 'any' CPU type
Date: Thu, 12 Oct 2023 14:10:09 +1000
Message-ID: <20231012041051.2572507-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x534.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230912132423.268494-13-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/about/deprecated.rst | 12 ++++++++++++
 target/riscv/cpu.c        |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 8b136320e2..5e3965a674 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -327,6 +327,18 @@ QEMU's ``vhost`` feature, which would eliminate the high latency costs under
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
index c9de7ddb4e..115c2d2fa4 100644
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


