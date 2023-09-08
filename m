Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A85779822A
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:14:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUfx-0007Oi-Hp; Fri, 08 Sep 2023 02:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUfv-0007Je-UK
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:09:03 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUft-0008HB-8F
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:09:03 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-573d52030fbso1273163a12.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153339; x=1694758139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3GMmaRv5643/zMFtvt7wVvyPYUKUz8B7XAztTFlqi0U=;
 b=dXSHlGzmBELyWliq9uguILASctIHYlbsyv+E0eigvyMzWrnh6YRtK5LObAZay5D2Jo
 1Lut0D9TIMpf36W9u0ccKcnbU3O/2kIWCVncJ+tzo282Jhu8J7y8Na68hlwzZvMNOH3B
 2vyGgoL4Eqny9k/PVngld6nKCOYKAdFFv2oSw/QjeZxxsXKwf6bYx3b+vWKp26E495gs
 rZ1Nn2VWm4MLSCTFTnK1XrecR3fbdiS+vLQ+E5J/FLTLTND99aDf0H987rM2w3wUUrwq
 vo6VPJZPddnArq2q3oC4Z8F07TCAozx9RcP0tYLyS66wumaqR4TGiWLXX4etxcY/jhSG
 vayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153339; x=1694758139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3GMmaRv5643/zMFtvt7wVvyPYUKUz8B7XAztTFlqi0U=;
 b=U4tJ5uwFN4ldx+aBi5/WkcA8ohF3OGmkx1pUwA2xWCl19c9RQVTiivtU+9TfHYUyy7
 oXOxn4/cr+slgT1Z3a09NxktqW9xgvv0e18kvuaXGug1ERzcSx+sbPi0NX/jxgYDdjob
 2kRTMtW4hauwpRZUw4Um6xyHsLIBSjY6aGL9HzGsrcOjFq28LKow6fsDdnpvGzDH2rbP
 OJaJRItJItU/Rm9eQFLFy54XtuOQ44K/O7QFt6WOHYs8DqpACjpgl36JF/qHZHw6QWmb
 F5PuDxG9Ja3WhZWPUEQUNYJY+cwpZCEJz1FvbbpiP74d9QQoYpksqPgs15ZMYjZ41V3m
 qqsQ==
X-Gm-Message-State: AOJu0YwvexGPBFoKL+ClYl6xgZRUihIVsNxtERCN5TxDv5233T31tMJE
 uSqz7CQOk/olGsl9nyHrLjQVhhQX06UVzwO7
X-Google-Smtp-Source: AGHT+IGjWnUmLVaUdEr5a99APJlLvHWnEoyFx19U+xM6T89TTVyhBs8NDl1meV3E3kTL4vRuutBgIQ==
X-Received: by 2002:a05:6a20:3d92:b0:13e:9dba:ea52 with SMTP id
 s18-20020a056a203d9200b0013e9dbaea52mr2223908pzi.13.1694153339539; 
 Thu, 07 Sep 2023 23:08:59 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:08:58 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PULL 65/65] target/riscv/cpu.c: consider user option with RVG
Date: Fri,  8 Sep 2023 16:04:31 +1000
Message-ID: <20230908060431.1903919-66-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x536.google.com
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

Enabling RVG will enable a set of extensions that we're not checking if
the user was okay enabling or not. And in this case we want to error
out, instead of ignoring, otherwise we will be inconsistent enabling RVG
without all its extensions.

After this patch, disabling ifencei or icsr while enabling RVG will
result in error:

$ ./build/qemu-system-riscv64 -M virt -cpu rv64,g=true,Zifencei=false --nographic
qemu-system-riscv64: RVG requires Zifencei but user set Zifencei to false

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20230901194627.1214811-21-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 78382cb5f2..be1c028095 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1153,9 +1153,23 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
           riscv_has_ext(env, RVA) && riscv_has_ext(env, RVF) &&
           riscv_has_ext(env, RVD) &&
           cpu->cfg.ext_icsr && cpu->cfg.ext_ifencei)) {
+
+        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_icsr)) &&
+            !cpu->cfg.ext_icsr) {
+            error_setg(errp, "RVG requires Zicsr but user set Zicsr to false");
+            return;
+        }
+
+        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_ifencei)) &&
+            !cpu->cfg.ext_ifencei) {
+            error_setg(errp, "RVG requires Zifencei but user set "
+                       "Zifencei to false");
+            return;
+        }
+
         warn_report("Setting G will also set IMAFD_Zicsr_Zifencei");
-        cpu->cfg.ext_icsr = true;
-        cpu->cfg.ext_ifencei = true;
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_icsr), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_ifencei), true);
 
         env->misa_ext |= RVI | RVM | RVA | RVF | RVD;
         env->misa_ext_mask |= RVI | RVM | RVA | RVF | RVD;
-- 
2.41.0


