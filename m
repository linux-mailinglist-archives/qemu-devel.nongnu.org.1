Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 684EC786462
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 03:04:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYykL-00007e-L7; Wed, 23 Aug 2023 21:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYykI-00005e-1z
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 21:02:46 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYykE-0000QP-Vx
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 21:02:45 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68bec436514so343575b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 18:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692838961; x=1693443761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yER8RLCvXGE4QY1NsvgxkMYXrHTMG4W+91MMUIhX/Po=;
 b=DMW0px2xfF8NLZkQ0gx+QLO5+qybrbI1WOpDIOTMUuuaerdh4r0WKxEHjiKuWgdcJ2
 leNrxdNuTR0X3yLQdnbgnXy0vbSircTHy9bqQTJcnpBUPPTfLb/cucIy26W7I+KDI2Px
 rkaGqEI0vnn9Yp+MFnK24VKQ0J/mkKGy+naSA0c5xatezKuoY6+J29xCkT987tbrWxID
 3tSyefhMFJvLAxSllTMMgvPJ8u6o+5PPWemP9bVK3nfLE3RTgVNWtwtnFFjeUmSSzawu
 bMbt9jYxRUnTCjt0ZBa2f9T0aFZi50k4RuuiqFrFNCaISNJ5YOsQU1Fmf2BfJ2prODDd
 borQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692838961; x=1693443761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yER8RLCvXGE4QY1NsvgxkMYXrHTMG4W+91MMUIhX/Po=;
 b=I0mDGT5JlB/T62dDgR/cu/jqmySQUgWqI/X6OLuP3rNzksnot3ZBdAa7O/Xvi0dlbV
 cEBLgL0StUItanZRk63X5vdc5lp1QJSPqOW9Ltrfi0fWlXURFC/nIJn5kYGV3G9wNZoZ
 kziBU72bi7p9bKAGUoaz+/QtvdpKeLT7PnLp8B4lXiz7V/V7EFpsgLcgdbVL5maVYxOy
 ozESb4oGff4Fda9kH9D4IxeYn8qkGKI9rco7VqOQtjPQChlsQQqeV5bTCZUoPoejzSJb
 YBNlJ2j3gjVotcZpiCERy8/7MnnhBokP4nKJ0NO0m89W7v3FEG43538Abm7eisnzscCx
 aq+Q==
X-Gm-Message-State: AOJu0Yx9XhazQS5J/8RnCmBNk9fQ2p9T/+ozQTXz8ikdZP0E9cgBQFLQ
 LT0zn8FAEEeqOGKmK3BrZwg4p1xw7qmLbH7HA0U=
X-Google-Smtp-Source: AGHT+IGV4ec3zOJxYEEWBHhe5+2lYZE4HMOzvkTg5S++dPB1v0HDezsMPlwFsR9JVaA0R3lgAovc2Q==
X-Received: by 2002:a05:6a21:81a3:b0:11e:7ced:3391 with SMTP id
 pd35-20020a056a2181a300b0011e7ced3391mr10662236pzb.43.1692838961681; 
 Wed, 23 Aug 2023 18:02:41 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 c10-20020aa78c0a000000b006875df4773fsm2050789pfd.163.2023.08.23.18.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 18:02:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Michael Cree <mcree@orcon.net.nz>
Subject: [PATCH 03/13] linux-user: Emulate /proc/cpuinfo for Alpha
Date: Wed, 23 Aug 2023 18:02:27 -0700
Message-Id: <20230824010237.1379735-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824010237.1379735-1-richard.henderson@linaro.org>
References: <20230824010237.1379735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

From: Helge Deller <deller@gmx.de>

Add emulation for /proc/cpuinfo for the alpha architecture.

alpha output example:

(alpha-chroot)root@p100:/# cat /proc/cpuinfo
cpu                     : Alpha
cpu model               : ev67
cpu variation           : 0
cpu revision            : 0
cpu serial number       : JA00000000
system type             : QEMU
system variation        : QEMU_v8.0.92
system revision         : 0
system serial number    : AY00000000
cycle frequency [Hz]    : 250000000
timer frequency [Hz]    : 250.00
page size [bytes]       : 8192
phys. address bits      : 44
max. addr. space #      : 255
BogoMIPS                : 2500.00
platform string         : AlphaServer QEMU user-mode VM
cpus detected           : 8
cpus active             : 4
cpu active mask         : 0000000000000095
L1 Icache               : n/a
L1 Dcache               : n/a
L2 cache                : n/a
L3 cache                : n/a

Cc: Michael Cree <mcree@orcon.net.nz>
Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230803214450.647040-4-deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/alpha/target_proc.h | 68 +++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/linux-user/alpha/target_proc.h b/linux-user/alpha/target_proc.h
index 43fe29ca72..dac37dffc9 100644
--- a/linux-user/alpha/target_proc.h
+++ b/linux-user/alpha/target_proc.h
@@ -1 +1,67 @@
-/* No target-specific /proc support */
+/*
+ * Alpha specific proc functions for linux-user
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef ALPHA_TARGET_PROC_H
+#define ALPHA_TARGET_PROC_H
+
+static int open_cpuinfo(CPUArchState *cpu_env, int fd)
+{
+    int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
+    int num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+    unsigned long cpu_mask;
+    char model[32];
+    const char *p, *q;
+    int t;
+
+    p = object_class_get_name(OBJECT_CLASS(CPU_GET_CLASS(env_cpu(cpu_env))));
+    q = strchr(p, '-');
+    t = q - p;
+    assert(t < sizeof(model));
+    memcpy(model, p, t);
+    model[t] = 0;
+
+    t = sched_getaffinity(getpid(), sizeof(cpu_mask), (cpu_set_t *)&cpu_mask);
+    if (t < 0) {
+        if (num_cpus >= sizeof(cpu_mask) * 8) {
+            cpu_mask = -1;
+        } else {
+            cpu_mask = (1UL << num_cpus) - 1;
+        }
+    }
+
+    dprintf(fd,
+            "cpu\t\t\t: Alpha\n"
+            "cpu model\t\t: %s\n"
+            "cpu variation\t\t: 0\n"
+            "cpu revision\t\t: 0\n"
+            "cpu serial number\t: JA00000000\n"
+            "system type\t\t: QEMU\n"
+            "system variation\t: QEMU_v" QEMU_VERSION "\n"
+            "system revision\t\t: 0\n"
+            "system serial number\t: AY00000000\n"
+            "cycle frequency [Hz]\t: 250000000\n"
+            "timer frequency [Hz]\t: 250.00\n"
+            "page size [bytes]\t: %d\n"
+            "phys. address bits\t: %d\n"
+            "max. addr. space #\t: 255\n"
+            "BogoMIPS\t\t: 2500.00\n"
+            "kernel unaligned acc\t: 0 (pc=0,va=0)\n"
+            "user unaligned acc\t: 0 (pc=0,va=0)\n"
+            "platform string\t\t: AlphaServer QEMU user-mode VM\n"
+            "cpus detected\t\t: %d\n"
+            "cpus active\t\t: %d\n"
+            "cpu active mask\t\t: %016lx\n"
+            "L1 Icache\t\t: n/a\n"
+            "L1 Dcache\t\t: n/a\n"
+            "L2 cache\t\t: n/a\n"
+            "L3 cache\t\t: n/a\n",
+            model, TARGET_PAGE_SIZE, TARGET_PHYS_ADDR_SPACE_BITS,
+            max_cpus, num_cpus, cpu_mask);
+
+    return 0;
+}
+#define HAVE_ARCH_PROC_CPUINFO
+
+#endif /* ALPHA_TARGET_PROC_H */
-- 
2.34.1


