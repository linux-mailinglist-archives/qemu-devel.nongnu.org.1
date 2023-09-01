Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 811367902A1
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 21:51:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcA8g-0001de-O8; Fri, 01 Sep 2023 15:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qcA7S-0008Sy-Mt
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 15:48:02 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qcA7I-0003bB-3B
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 15:47:48 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5739972accdso179707eaf.1
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 12:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693597658; x=1694202458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8z25vDdEG5IVz8Qg1vlTTXuRnbOaZ4PfGqqUDmV7Do8=;
 b=EcX8TUfKN40yN3/J2Jb3HKnId4CZ196dCkijgICIC71FlSxCEc05+yTwEma+Rw0Seg
 zP0djSjQQTYUb2ZluWREHCjp71+cEtz9m6Rt+OQabiek16Zf417faNc9De9bNMV3v/Jn
 S5DTOBn5GiU2Z3ThGn21Fm7nxGlZBc2YtmQKqMGvzPo++cJ4zVVNaHEDffvitfOwaE4j
 +cvwe6O/lM6ym943AEDwWLkd6SBlWb1xz2RTaXZs+KO7256HRC/1ntn0uB18RXPSv6xe
 QbivMQloGxcLC6AQ3FfABD703+q/FEtoXct+NzJHugveC3yrmEIynL+L0jHeWOuovR6u
 d+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693597658; x=1694202458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8z25vDdEG5IVz8Qg1vlTTXuRnbOaZ4PfGqqUDmV7Do8=;
 b=BBfw/5twLASsYCDQVnPriPKPIKEuK+j09qmVzDk7gz9JCe+W0Qd3d8xE7B2sGh9jOd
 LcNKFQE5ullRjuWbyZytQDCeG6ERhIE1YjTMFFFu4ikjdNLByeMhQSF9uSsazvB7a8+y
 W0+JqxW+MYU/2fODeNSMtZcyIxzNn4U1xdBKY12oWwE/kmzivKhVaSDVavtyfMNrnlFC
 DdzSdkGS/R2kGYiRjdbVnQz805lg6yRbab2FHZa5a/jPRv6cy15IY+jWBfVVIpcwBRi/
 Ifr+Uc01CgCVXdm64sUZHUMPNy/djWRPQ14Zyx1nzw523OkzkMCHomI8fRVL6eTnG9Na
 uPCw==
X-Gm-Message-State: AOJu0YyzBZ037UekFX+2Ip8imoqbu9vuZlxXkoGKSIUvu05nZzt0Pkf/
 tNWTBYCMEg3x7RWhVVMrJSChzV1e1ef7M5DTcw0=
X-Google-Smtp-Source: AGHT+IGqD5rMIXpbQri84SQdEkjC9n4pFEl7VUkXz7nVtgSCIA5rGHxrLZCBwftIYeuJmmGW5O/02g==
X-Received: by 2002:aca:2809:0:b0:3a7:507d:7b20 with SMTP id
 9-20020aca2809000000b003a7507d7b20mr3078626oix.8.1693597658639; 
 Fri, 01 Sep 2023 12:47:38 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.194])
 by smtp.gmail.com with ESMTPSA id
 h187-20020a4a5ec4000000b00565d41ba4d0sm2303002oob.35.2023.09.01.12.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 12:47:38 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 20/20] target/riscv/cpu.c: consider user option with RVG
Date: Fri,  1 Sep 2023 16:46:26 -0300
Message-ID: <20230901194627.1214811-21-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230901194627.1214811-1-dbarboza@ventanamicro.com>
References: <20230901194627.1214811-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


