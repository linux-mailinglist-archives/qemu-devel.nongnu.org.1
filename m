Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF2E758CC8
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 06:47:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLz58-0001se-3i; Wed, 19 Jul 2023 00:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qLz4f-0001oa-TR
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 00:46:07 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qLz4a-0005LW-JX
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 00:46:02 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6687466137bso4282449b3a.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 21:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689741959; x=1692333959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8WbUdDwREb7+jUc50QF2GeSoE7i7C921v5vq8Yxj3Pk=;
 b=QTmCFfMgeiOZ7dgkT4Txy17wJHbKggvqtAKX7MehL2f/XihdqG8lQr6SCjH2yuatLj
 tBt+tMrFcNALs5Y6woC/pLXVoStfHmTsJVcEYzTVzdLVaeAek0KJz+UoT+b5DCGXYS7E
 eNdz3UK4SSDzUlIfS+nKKBKy3OY19WxOr48IWY+y0+X41+belpnHN4xgclH3DD6chTrl
 nNOeRvL1IKWAERk5ggDDey7Oz/89VlifeYlSvgRYR7FakjdhwqweDJooVEg5PU2hyaIj
 kHkydiveaqmrh3/yYT2H2ZfDqEfWbAN12i73M6nweoHPSHz9k25R1vamC43/0iCG0zLg
 0pzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689741959; x=1692333959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8WbUdDwREb7+jUc50QF2GeSoE7i7C921v5vq8Yxj3Pk=;
 b=JFn/t5XS8nXtqc1zKcKnwLEPCQ2Q9Gd5Ede0rUyghkEVwZI2eM7gTKaa/wJBM9YbP/
 EAhf300CPnGlUnCjpaLgE0MBsTS0ZggQW25ayoayM08Pd0lWkAnmMFbLOkW2pXMgf5E5
 tiQPFMum748XoiVmEyN29XZGISkprPiqmy+uXV/K6jGuCKvVxekqjrQRFKNKaJ97+Yfc
 8Q4vIkFcjuVSSZ2FzZ7/KreBpNe5hkVovCSlRgKcTMbfD8eShIyWPNRni0IhFez39QCu
 4fqvFDSSsYjjPP/2IENUFCdRQ2nNLHxZXAvZLdIWXSlMHR3GSxCbmtTe92/SOjRy2fxA
 VnQQ==
X-Gm-Message-State: ABy/qLYC0bBVozs+6JOF+pAwPjZEP44He1RwCKO1QhG+JsmMeUVE0stH
 lDrtEX+Ke7PQCG9cuV33MYnWCSN9MOqPYwL+
X-Google-Smtp-Source: APBJJlHL1rjQQaiQfSIgkm+IoO0RHZOiaqxB6FOw+vJ6x/Y5HtsK7RHCu8wRxK4U0UP5+bynL5NrJw==
X-Received: by 2002:a05:6a21:3297:b0:133:c9f0:ce66 with SMTP id
 yt23-20020a056a21329700b00133c9f0ce66mr1406459pzb.18.1689741958842; 
 Tue, 18 Jul 2023 21:45:58 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a17090301d000b001b890009634sm2731080plh.139.2023.07.18.21.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 21:45:58 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Conor Dooley <conor@kernel.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PULL 3/5] target/riscv/cpu.c: check priv_ver before auto-enable
 zca/zcd/zcf
Date: Wed, 19 Jul 2023 14:45:36 +1000
Message-Id: <20230719044538.2013401-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230719044538.2013401-1-alistair.francis@wdc.com>
References: <20230719044538.2013401-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Commit bd30559568 made changes in how we're checking and disabling
extensions based on env->priv_ver. One of the changes was to move the
extension disablement code to the end of realize(), being able to
disable extensions after we've auto-enabled some of them.

An unfortunate side effect of this change started to happen with CPUs
that has an older priv version, like sifive-u54. Starting on commit
2288a5ce43e5 we're auto-enabling zca, zcd and zcf if RVC is enabled,
but these extensions are priv version 1.12.0. When running a cpu that
has an older priv ver (like sifive-u54) the user is spammed with
warnings like these:

qemu-system-riscv64: warning: disabling zca extension for hart 0x0000000000000000 because privilege spec version does not match
qemu-system-riscv64: warning: disabling zcd extension for hart 0x0000000000000000 because privilege spec version does not match

The warnings are part of the code that disables the extension, but in this
case we're throwing user warnings for stuff that we enabled on our own,
without user intervention. Users are left wondering what they did wrong.

A quick 8.1 fix for this nuisance is to check the CPU priv spec before
auto-enabling zca/zcd/zcf. A more appropriate fix will include a more
robust framework that will account for both priv_ver and user choice
when auto-enabling/disabling extensions, but for 8.1 we'll make it do
with this simple check.

It's also worth noticing that this is the only case where we're
auto-enabling extensions based on a criteria (in this case RVC) that
doesn't match the priv spec of the extensions we're enabling. There's no
need for more 8.1 band-aids.

Cc: Conor Dooley <conor@kernel.org>
Fixes: 2288a5ce43e5 ("target/riscv: add cfg properties for Zc* extension")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Tested-by: Conor Dooley <conor.dooley@microchip.com>
Message-Id: <20230717154141.60898-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9339c0241d..6b93b04453 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1225,7 +1225,8 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         }
     }
 
-    if (riscv_has_ext(env, RVC)) {
+    /* zca, zcd and zcf has a PRIV 1.12.0 restriction */
+    if (riscv_has_ext(env, RVC) && env->priv_ver >= PRIV_VERSION_1_12_0) {
         cpu->cfg.ext_zca = true;
         if (riscv_has_ext(env, RVF) && env->misa_mxl_max == MXL_RV32) {
             cpu->cfg.ext_zcf = true;
-- 
2.40.1


