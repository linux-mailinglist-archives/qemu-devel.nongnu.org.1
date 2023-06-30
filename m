Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DABA74391F
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 12:13:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFB4W-0005jy-Da; Fri, 30 Jun 2023 06:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qFB40-0005i6-SL
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:09:16 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qFB3z-0000rl-7J
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:09:16 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6b5cf23b9fcso1487995a34.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 03:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688119753; x=1690711753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6lg0fFq+YjoD1AN/3PteMvUngPOZVVOuhx5z40IRs/Q=;
 b=FdqvyRU7hrZeZdNndlqxux7MR/kwCsluTEsLGMQw8YBBhaqJ8oSpWedZk6xQ0XLK6d
 ytyVyicwUHbLn+7GBc0GnvJvWbjouqNI5IvwAdlRn9TX0aNpUhLJ/4RbvZ4nDV+UKGkO
 OXdggLnJiPmv0l1BFJsDZ1lMz98GYQ5RCqfakVZZRJUr4sYptlM2pCxfvMq5Gsoj/pA4
 xl4DLyL9k+BUNJ2PAJRxpiqcYuy7hDptVVqr3tpI9jFr5g4zj3Nmhc4O24BS2/YDANwS
 XQtWQW5fRlKVJ9nZ13UPo4XP3hatiDSxC6PyN7WLA6g5qNBH3zSuLWrT9w220RAJXXFA
 GbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688119753; x=1690711753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6lg0fFq+YjoD1AN/3PteMvUngPOZVVOuhx5z40IRs/Q=;
 b=M7bE3crOjlQOIrSyV/i6PAXTaeSHVZv7mvEKqZi8IwBDn9D5qXS0Io2RM7eec6479S
 iTMVJzsG7acAE4sStZGz1Q2zRrRK89gqZDcxcLp/LrqQtNCGNWX92DfAUn+9IJV0hSvj
 +az90kRcKTIZYg2mZqCj/sljpH/Gtp5r4SXmD7dxtowUbIQdNVvqjUlpraElCzKdXVPW
 MPWfLgE90ISnmgWRuFnJWWZuUCdM83H3G60KrQXXVgUotf3dIVdcUZSz1kKdWYR49ZX4
 1dW78ApSJDEWnldExSe6Ul4VF+jbpGBB3fCMG4MkCSrLby5t8wIAn8OWOg6TL8V76mMv
 EB0A==
X-Gm-Message-State: AC+VfDw9vL3ozy4x/ihowJ34A/oN7V6boCId6vkQ4UwVPHBPKtAwC8Z4
 9V9ih5nYFKHKYe1x2zgj6/GqnN4/EdnX1l6oFjE=
X-Google-Smtp-Source: ACHHUZ59z6BMw/Rr/TkB3m0YtUfg/aJK6HHGB64ecAtBjpoV4YZL9u8mJaW4JwhBgdWe1PxZKkcRtg==
X-Received: by 2002:a05:6871:6a9:b0:1b0:2a7f:5887 with SMTP id
 l41-20020a05687106a900b001b02a7f5887mr3345696oao.49.1688119753380; 
 Fri, 30 Jun 2023 03:09:13 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 eh18-20020a056870f59200b001a663e49523sm8707467oab.36.2023.06.30.03.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 03:09:13 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v7 16/20] target/riscv/cpu.c: remove priv_ver check from
 riscv_isa_string_ext()
Date: Fri, 30 Jun 2023 07:08:07 -0300
Message-ID: <20230630100811.287315-17-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630100811.287315-1-dbarboza@ventanamicro.com>
References: <20230630100811.287315-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x334.google.com
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

riscv_isa_string_ext() is being used by riscv_isa_string(), which is
then used by boards to retrieve the 'riscv,isa' string to be written in
the FDT. All this happens after riscv_cpu_realize(), meaning that we're
already past riscv_cpu_validate_set_extensions() and, more important,
riscv_cpu_disable_priv_spec_isa_exts().

This means that all extensions that needed to be disabled due to
priv_spec mismatch are already disabled. Checking this again during
riscv_isa_string_ext() is unneeded. Remove it.

As a bonus, riscv_isa_string_ext() can now be used with the 'host'
KVM-only CPU type since it doesn't have a env->priv_ver assigned and it
would fail this check for no good reason.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index db718eff65..6cdcbaac30 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2042,8 +2042,7 @@ static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
     int i;
 
     for (i = 0; i < ARRAY_SIZE(isa_edata_arr); i++) {
-        if (cpu->env.priv_ver >= isa_edata_arr[i].min_version &&
-            isa_ext_is_enabled(cpu, &isa_edata_arr[i])) {
+        if (isa_ext_is_enabled(cpu, &isa_edata_arr[i])) {
             new = g_strconcat(old, "_", isa_edata_arr[i].name, NULL);
             g_free(old);
             old = new;
-- 
2.41.0


