Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C16C77D64D
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 00:40:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW2gV-0005NT-UX; Tue, 15 Aug 2023 18:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW2gM-0005CX-6x
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:38:34 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW2gF-0006MM-15
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:38:31 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3a751d2e6ecso5016741b6e.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 15:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692139104; x=1692743904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H4pnnHXPSSjR2BrIC+lFb47RzccWp4/dbdlHeRAoFGs=;
 b=Zi9UwB/rTwnhnxKJ8Th1/cMqzdD6UZVIP/UGk3mWgUGrZHaNXW1O2wjdUp4OuHbZIf
 pEoEZ0FyGDXYySUspctuGRDnpWjBMGXhyYqa/9YchoZdu/w6ttCGMCpL7sdf+SxE39H5
 2dU4bpHz8+hUvZINjSbWGbTc5t8wsbItpxAYOB1xGqZaIjLdy2lQMnaZwoU3SUvMJLw3
 Cfc4vT6aLrWd9tevv8Qg9rGlLzYfLmBRw/tfQd+cRHERhPiHQoq5BF65PkQrCQTKi7dH
 vcs9/2xibcaXBehpmXHQg/F9Z6ioz4C0xzsKg+uo1nxEzYZfAqbEoN+nX1n/ozhaZeOw
 CeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692139104; x=1692743904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H4pnnHXPSSjR2BrIC+lFb47RzccWp4/dbdlHeRAoFGs=;
 b=QxbdLckkrer7UYNIZ5R7nkJsM3+Dh7EbryzgX+V/t9LSH53J+s0sn64mZb7LvToTGM
 vlGogehgGGC/p9aQ7pyPAWDwyfpYRP7noGGpwEkB6EdU5q+C9ZwAnJP7jra5Gr2QuKLx
 BGUx9Tyu1uzQPi1+9yPdTbEMJe+iqOmCby+q4249elbxmI6ERMIeK0md5SLFjiE0TdM7
 In0nfzPX55VGLdVwY8vT0wtVZkmVb6PiJNaxlXs8VqIDiiJl+tW+/eXMcGUFir3u/Mfo
 1IIT45/3DUYZOG18zzlUfOx1ro9aQy2XG4ODHsOI9V9KO8ncTUzwFq9o9wz7XD9lpvrr
 f2yw==
X-Gm-Message-State: AOJu0Yz506aRUSb2IhwLshMekB7knGxetGkxUeuMvV6oUtLQ7RfOhHWb
 pDt3EBx3pcyMX6aYD52bE4GImnQsHOXnm2VtI/4=
X-Google-Smtp-Source: AGHT+IHrun8S8aLUXsYgmCBeOiPLKKg10i0BdKbIhnKmyiMgeVL8HqRikPi3opKkSny+hpHXT08bIQ==
X-Received: by 2002:a05:6808:1902:b0:3a7:e4a:5cbd with SMTP id
 bf2-20020a056808190200b003a70e4a5cbdmr72651oib.31.1692139104282; 
 Tue, 15 Aug 2023 15:38:24 -0700 (PDT)
Received: from grind.. (189-69-160-189.dial-up.telesp.net.br. [189.69.160.189])
 by smtp.gmail.com with ESMTPSA id
 be15-20020a056808218f00b003a40b3fce01sm5903418oib.10.2023.08.15.15.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 15:38:23 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 12/12] target/riscv: deprecate the 'any' CPU type
Date: Tue, 15 Aug 2023 19:37:41 -0300
Message-ID: <20230815223741.433763-13-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815223741.433763-1-dbarboza@ventanamicro.com>
References: <20230815223741.433763-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
index 326b016723..59bd37e033 100644
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


