Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D48D766E9F
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 15:43:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPNKL-0006hD-1m; Fri, 28 Jul 2023 09:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qPNJx-0006Sc-UQ
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 09:15:54 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qPNJt-0003St-3y
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 09:15:53 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1bb7297c505so1656515fac.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 06:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1690550145; x=1691154945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mOnI9hH6NlaZaaUBLQ1CH8wjZUIfM0115L0/n42OTo4=;
 b=fu4ufrwxg2vhijt8buawqU/RP6oniT5YH0MQGy6Jnthk7FFIfyg7Pw/d6p3ItxZSh1
 taGn0yhRksbe9wKGnN5TYtmimPhNjKKdXZPwpQ5tZihDirPWJyCfbiHi7hE9OuycEEKv
 5nEwAeOM6UvEDZE1cFSSowRE/MBtWC0YV4xvniV6U7pJfMEADV+xligTYUqVpYwMISBz
 leu7v5oVjER4djNmDdLiO+XZjwA9RHXLIOyIbR3V4GJQ+Pvw/6FmLPcDLu2prEv4vCiX
 VTRz0njjoXE+YvuqCL9TH61eFtcLy2KuIvALfP3ZDSiO7luK4DdrBW8D44GC0PefxqCA
 OtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690550145; x=1691154945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mOnI9hH6NlaZaaUBLQ1CH8wjZUIfM0115L0/n42OTo4=;
 b=MTqx42W3nxGWPu4HsOg5spJ7HjulrW572dfmCasaBzaaW4SoBhlE8VEIkFNmEjhum0
 TOvZ8IsE0BPzGBviW65GY1miB/wBHbkqFwoiTBNoYijU9xjcsgIdZLaSVHYRGFXAXNJS
 nNTpXMjmvLslDpMCUAY6SdE+AvJIjrJOusgj3xO91h1wNFR428QKSkgRRSAzUQaRSpx/
 dzeMtkv7vVvyDQToKZAZBoI1JOrok17oQB+WC7b9CngSsvKoB1kV4BqKYz0s0PT/Bmc3
 50qOFhCqMHmZonnpDHI+snFmPw7JwhphkpM6Q6ES+M5kxY/cAYNWyXz/6tcZCt0GAAPP
 vU3Q==
X-Gm-Message-State: ABy/qLYCmvD2smMtrj+Au17Psz2jrqJGUHq7SeP6MfwASUFA0pzHxW+f
 aybsFdsF8bWJuNCkFdAWMkzW+1CzdSxj+LihFuMFyw==
X-Google-Smtp-Source: APBJJlEH+bAbhWlP6MwIjmF0E3VKTVXK/Soat3fmbaPbzmXLJa9k46TU1LZau/0uxJ/uRjq7IuAbqg==
X-Received: by 2002:a05:6870:e30e:b0:1b3:8285:153e with SMTP id
 z14-20020a056870e30e00b001b38285153emr2508163oad.44.1690550145312; 
 Fri, 28 Jul 2023 06:15:45 -0700 (PDT)
Received: from grind.. (201-69-66-36.dial-up.telesp.net.br. [201.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 hv6-20020a056871cc0600b001b3d93884fdsm1699371oac.57.2023.07.28.06.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 06:15:45 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 7/8] target/riscv/cpu.c: honor user choice in
 cpu_cfg_ext_auto_update()
Date: Fri, 28 Jul 2023 10:15:19 -0300
Message-ID: <20230728131520.110394-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728131520.110394-1-dbarboza@ventanamicro.com>
References: <20230728131520.110394-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x35.google.com
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

Add a new cpu_cfg_ext_is_user_set() helper to check if an extension was
set by the user in the command line. Use it inside
cpu_cfg_ext_auto_update() to verify if the user set a certain extension
and, if that's the case, do not change its value.

This will make us honor user choice instead of overwriting the values.
Users will then be informed whether they're using an incompatible set of
extensions instead of QEMU setting a magic value that works.

For example, we'll now error out if the user explictly set 'zce' to true
and 'zca' to false:

$ ./build/qemu-system-riscv64 -M virt -cpu rv64,zce=true,zca=false -nographic
qemu-system-riscv64: Zcf/Zcd/Zcb/Zcmp/Zcmt extensions require Zca extension

This didn't happen before because we were enabling 'zca' if 'zce' was enabled
regardless if the user explictly set 'zca' to false.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a40dc865a0..644d0fdad2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -187,6 +187,12 @@ static int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
     return PRIV_VERSION_1_10_0;
 }
 
+static bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)
+{
+    return g_hash_table_contains(multi_ext_user_opts,
+                                 GUINT_TO_POINTER(ext_offset));
+}
+
 static void cpu_cfg_ext_auto_update(RISCVCPU *cpu, uint32_t ext_offset,
                                     bool value)
 {
@@ -198,6 +204,10 @@ static void cpu_cfg_ext_auto_update(RISCVCPU *cpu, uint32_t ext_offset,
         return;
     }
 
+    if (cpu_cfg_ext_is_user_set(ext_offset)) {
+        return;
+    }
+
     if (value && env->priv_ver != PRIV_VERSION_LATEST) {
         /* Do not enable it if priv_ver is older than min_version */
         min_version = cpu_cfg_ext_get_min_version(ext_offset);
-- 
2.41.0


