Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D78A27C63E4
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:19:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn3Q-0001Uq-AV; Thu, 12 Oct 2023 00:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn2z-0000xx-Kf
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:11:45 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn2x-0002CC-NY
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:11:41 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-690f7bf73ddso433037b3a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083897; x=1697688697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Duj6zM86+ECbgQcBaFI2s0n0D/QwnI7casWscv+atw=;
 b=GeP8Y53DtoaUfypaHHnmo+FBokKam1j2B6HoOp2cAtTd8vS5DUOqUveCsdbSks++PM
 F/QY268BRFOu+UTFtRaXQPZ6pZDwLEimZLSVej0eV5FY6D/rQg5Hny8VfYncwBF8IzeG
 TcFIlDbda66+C37IPqo3hV6roVOl8DvHNT4Pi7+w/Cnf78xl6Tt86xBiSti5QUhs/MHy
 UuIp08uO0TkmJ+ICP1NpY1nRPpxiGGtshiWzO7KGCfvq8T4ncCo63X9TQcUX+Ks9OFRz
 QoVY+m2rgeTMaDDVTl0vwzVKHhMw31+N+De4Mv4y+dKKZurLucw5kJ3mk/7QXHM3Cbdf
 S0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083897; x=1697688697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Duj6zM86+ECbgQcBaFI2s0n0D/QwnI7casWscv+atw=;
 b=f16y59//AaNJXMaCpKqlIMEa6GqC/gSvks9wKy03Ru1Hv/VBASFQZIh5c5ccf8jOR5
 91gmT6L43qDDXbj2Rh/34R5/N+z+SPmW0bQIjUJJi/uUcL41a0CPOuOV8f9TeDyCgwFL
 2ZLrU0hVCmkBAW8XQyYexS9qFDqb3flB0TYPBDw9NOqPrDFPlrJxLUyY/CbfTpIJPIwt
 jVtRAbW/pAlap2N02Zbcvk84/b60PBMztBB3r95lP2BHGheH04A9rUZ3kkFjcck94OGl
 LEMdAkhQbxjQe2zTZoUCzT3sEYfBAhAqCjun+B3WQoyMJpEa7zuHrpJW3hfHH9jb7VJy
 ZdPQ==
X-Gm-Message-State: AOJu0YwiC7N2iOFOiQ6RKxGRySRuF8dmcFD8S7gq5NzTmoRIEKp4jzxW
 nj5H8ohkTs6JN6uMUmoie2SqNR+Wz0cYUg==
X-Google-Smtp-Source: AGHT+IFhULk04WZ20Ojc6AS98EYpZPFuddTwbBXAPdX8nVvtEwRKW2/KObNcG/FAFVhqqMktd0tyFw==
X-Received: by 2002:a05:6a20:2451:b0:14d:5580:8ff0 with SMTP id
 t17-20020a056a20245100b0014d55808ff0mr23058968pzc.25.1697083896962; 
 Wed, 11 Oct 2023 21:11:36 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:11:36 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>
Subject: [PULL 09/54] target/riscv/cpu.c: limit cfg->vext_spec log message
Date: Thu, 12 Oct 2023 14:10:06 +1000
Message-ID: <20231012041051.2572507-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x431.google.com
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

Inside riscv_cpu_validate_v() we're always throwing a log message if the
user didn't set a vector version via 'vext_spec'.

We're going to include one case with the 'max' CPU where env->vext_ver
will be set in the cpu_init(). But that alone will not stop the "vector
version is not specified" message from appearing. The usefulness of this
log message is debatable for the generic CPUs, but for a 'max' CPU type,
where we are supposed to deliver a CPU model with all features possible,
it's strange to force users to set 'vext_spec' to get rid of this
message.

Change riscv_cpu_validate_v() to not throw this log message if
env->vext_ver is already set.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Message-ID: <20230912132423.268494-10-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3cc7cfd7ef..7b9d0c7e52 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -959,8 +959,6 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
                                  Error **errp)
 {
-    int vext_version = VEXT_VERSION_1_00_0;
-
     if (!is_power_of_2(cfg->vlen)) {
         error_setg(errp, "Vector extension VLEN must be power of 2");
         return;
@@ -983,17 +981,18 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
     }
     if (cfg->vext_spec) {
         if (!g_strcmp0(cfg->vext_spec, "v1.0")) {
-            vext_version = VEXT_VERSION_1_00_0;
+            env->vext_ver = VEXT_VERSION_1_00_0;
         } else {
             error_setg(errp, "Unsupported vector spec version '%s'",
                        cfg->vext_spec);
             return;
         }
-    } else {
+    } else if (env->vext_ver == 0) {
         qemu_log("vector version is not specified, "
                  "use the default value v1.0\n");
+
+        env->vext_ver = VEXT_VERSION_1_00_0;
     }
-    env->vext_ver = vext_version;
 }
 
 static void riscv_cpu_validate_priv_spec(RISCVCPU *cpu, Error **errp)
-- 
2.41.0


