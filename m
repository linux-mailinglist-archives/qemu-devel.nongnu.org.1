Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FE6756837
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 17:43:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLQMG-0002sb-8g; Mon, 17 Jul 2023 11:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qLQME-0002pX-Ja
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 11:41:54 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qLQMC-0008EU-VG
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 11:41:54 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3a43cbb432aso2604233b6e.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 08:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689608511; x=1692200511;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Am7ITXKQFOljx/D2CumawP5jQcrbC9JOhJwqTweZbs0=;
 b=mbxYukwALILqAXBz2kaHG52McAF9qFc4Tze2F805D9lwYtZU2XDtcDwG4rYk2mVVB+
 7IBPjfMbKyTyy2DJX0Y+58EiuTz5ciAJRzELHL/6wHkRD2JqYQl4wYRkduozBoueLIHk
 H1IyrDtZaALaFFkhc1lZO+9XslaGTrMN5b+tojaTfw70L956tlu32R6iS+F9vL+b0vrn
 /SgPC1exmZulFoXcFgC7XwvlXzJZVqBjxobuPRyqlPPHgVtr1xISol/64LeNXAKv789Q
 aZmiQmG+cFnvPKq3FmxaHrVLI+lmArM7QRe2wfQmJjQZ6AnMUudmrvfiAoGJNudyjTUM
 /X1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689608511; x=1692200511;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Am7ITXKQFOljx/D2CumawP5jQcrbC9JOhJwqTweZbs0=;
 b=LNu/r87Eyr58qmP+aFz+Sr113p5K+KmZMQmPidKH08kEd1YbT9lfEeW+EzBzh67p8b
 5KIA3IwEuvV7apfNV/ra3SkCQtMg02cpxS58ws5RjLvuzWOzKX++aveJeJFicIVm068r
 qnDAYqqElKWZl6FbkYM/x/Cn3/g8erlsumaqpQ1BnoNIDHHoDVnUjuQxiKglT+Ka5TOV
 /ULd/85pvXAwpWvCYOmdf/6UYrkHhOtrmIB4gRCAWeSd3T5gI70hD8vrS7FfWLNACpf6
 bhmIBYToFWRuL251pP7Og39fNOUDzvj/rDePeehWbzamQpiy9jbPbAhjWB50IiFMfPCS
 4lAg==
X-Gm-Message-State: ABy/qLZD5hmlgkdaRcKLLqsYtAAWwYCV3ZsO1ZIRnAxiRob/zrZc0tKf
 nwI4y+BUeCmoU8daoRBONCokzUxrjoWQ/FxQZ5+3zA==
X-Google-Smtp-Source: APBJJlGvyak+uCnoVgXDa/t1NGEoGgs24p6AQknuTQvoFbz3wwYf34FzUzrkHx0LTq4f99wqu8yMtA==
X-Received: by 2002:a05:6808:1914:b0:3a3:e0ad:e332 with SMTP id
 bf20-20020a056808191400b003a3e0ade332mr15604435oib.38.1689608510724; 
 Mon, 17 Jul 2023 08:41:50 -0700 (PDT)
Received: from grind.. (201-69-66-211.dial-up.telesp.net.br. [201.69.66.211])
 by smtp.gmail.com with ESMTPSA id
 eh1-20020a056808274100b003a1d29f0549sm6934093oib.15.2023.07.17.08.41.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 08:41:50 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Conor Dooley <conor@kernel.org>
Subject: [PATCH] target/riscv/cpu.c: check priv_ver before auto-enable
 zca/zcd/zcf
Date: Mon, 17 Jul 2023 12:41:41 -0300
Message-ID: <20230717154141.60898-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x22c.google.com
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
2.41.0


