Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C5173EE64
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 00:08:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDuJS-0005cF-Nf; Mon, 26 Jun 2023 18:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qDuIY-0002o7-Ai
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:03:06 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qDuIV-000613-78
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:03:02 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1b014f0b9aeso2245492fac.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 15:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687816977; x=1690408977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=veNPdoP0KMiS6MurmQQ4EerCcRcND9mpTP9rXWTlN60=;
 b=hp7y1kSpfrUF1PBEqp1Xr2y9irc6b6g8GTTAL1qkrSKS2Szommgx/Z9ajylminWpME
 kAeYnBG/muC7XPGr1rfLf/b1xYZBBVLiVajkwxEXyfLeQVd9+U4ZQPWdJ8G3KfddCpkx
 xLv5AFN0eQc0HIvdLhpbW4zmCj7914zHtI1urmiQfxMHti+eHJ10g5gttt//THcNz2MG
 U7zz068Et1JkmwlaPltezQ+ILiXhLiaOLD6BXF9mDPo5Rp7vCXj5M5I8KFBu/u9lTBSl
 kwL1ARRrdxa9/4XQyAnkgWJVN3rsCzzUceu00d+acRfalHO350eMJikaI0gWxqIpPHjj
 klRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687816977; x=1690408977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=veNPdoP0KMiS6MurmQQ4EerCcRcND9mpTP9rXWTlN60=;
 b=mD6gAqcWQTj1rXYPpTWGdrLcjd+hVIp1ZJWqDUr6J2idkhgbb83AKE61Vh98h6Rd5h
 yg+YQ40YFjcgU7LFT/gMnggr0LkYSKSadZ2KGTQ27VbNmwWl3im8uNVaEZ2chVJ82lzT
 wVALsJTtZj2WiJiLWHIKpzHbAPCa1tYA3Z+9jq4QhnGaV6m76jCHgAn5Ga86wApbU7F1
 6wf3WCyZUt+1oXQbKfMgsU2qMzYAmGGI3zQajK1xOVee+ypWQV7X7VT6CPAQwjOq1CdX
 1++CP3ebFWdPMYPYsCGu4pO1NG2pp2kQA+aMUepragfU2/41M2rJQa63/Y8BixahT9ff
 9i2A==
X-Gm-Message-State: AC+VfDzYQXJSjPh3UO5OzO+Fh97dBFyvFD8NX0ghOHkbkHHQQK+6z9sH
 swk6rxJg/THnMegjc9LTq7foF1ElllEtyFa6J40=
X-Google-Smtp-Source: ACHHUZ6xGwOtwQ2/cCHSrHfaEXePAWnx1lbeqk8rnFAOJCFS9Y+YOtP7MWIEGZoznWFSwdO1m8OUZQ==
X-Received: by 2002:a05:6870:7345:b0:1b0:4eb2:cc7f with SMTP id
 r5-20020a056870734500b001b04eb2cc7fmr1669929oal.55.1687816977670; 
 Mon, 26 Jun 2023 15:02:57 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a056870a10c00b001b03fbfa0c5sm1831419oae.39.2023.06.26.15.02.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 15:02:57 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 15/19] target/riscv/cpu.c: remove priv_ver check from
 riscv_isa_string_ext()
Date: Mon, 26 Jun 2023 19:02:05 -0300
Message-ID: <20230626220209.22142-16-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626220209.22142-1-dbarboza@ventanamicro.com>
References: <20230626220209.22142-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2c.google.com
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
index 5a50cb1d0b..b65db165cc 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2001,8 +2001,7 @@ static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
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


