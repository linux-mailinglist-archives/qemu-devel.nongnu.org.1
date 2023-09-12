Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFE679D22C
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 15:31:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg3Ou-0003zi-M4; Tue, 12 Sep 2023 09:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qg3Or-0003oh-Tv
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 09:25:53 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qg3Of-0003z5-BL
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 09:25:53 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6bc9c01e154so3399293a34.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 06:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694525140; x=1695129940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b6iO2bfUgyZtWhxauloKtcvAGEb6vGPXh6RDEUPqof0=;
 b=V9+GzsNCOeVb6MUL3zSVjreRfvfQqk+ce4eeLOlVA0l79yfM2jph+kRXws/uK+7EEf
 KiCRKQx3+rykI0FkLnEf9Dz+v44TXjmloSsgB8RAb/dOwOZo8EsHqEWayv905k5xQBRk
 KzznQp0eCP9DkEmHwvrxXTYXaF9yELHLUHKdZ9HneCUFBB2FVN1TNLVexUo/7A4MtoHu
 fG+JR+03mXO+nqmSNBmIb24u1+PIlrriMnQOEECQLScRUnjjn9L+dzbF9ZxEfav2lRO5
 K0hXZZa+IlW45I5Kng0/UrNcd75ExUjNsCzItA/s5tqSIq9LpO2QrgUYsEKwL2FE9tZW
 w0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694525140; x=1695129940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b6iO2bfUgyZtWhxauloKtcvAGEb6vGPXh6RDEUPqof0=;
 b=rPnbKqDrtB2IZbE5O5HiwJd/b3jozadtjjZYcrujnIB6LuXp6vHRIv7yoGSV5+S1lo
 I/w0BmRhSA5X5so/iifD0lp2DrHN0oEynjbVCxfFQ4xdg3zM27B8gBqh9sYNWfTGz5Rc
 bTBnDArqN7hK1uinvqrydA1DK3t2muPvP8+T/ilSHS4/j9JPvfAV/IneTFajBnAEkznh
 ko0o/026Y1HC9W1kFUEeQXuVvT4lO4Rf/PYVzowWv/ctjxBSYKmrwQwOdXbXK49Yi1Bi
 3f5Fw8749ZLjXxVtfeeSGexsL3rWweMAw4S3y8WDa3rTTAtPK8/wZ51cZAjDhWSDJts2
 bxeg==
X-Gm-Message-State: AOJu0YxsyXEY6ytcStAmrhD5CHrhYsUWZUpCxeYkKWNldXod2hzhuKIU
 1BQT2V90mOxppHZWjOC6Pv7JO11HC0vXoA84kOg=
X-Google-Smtp-Source: AGHT+IF4JSmx+ozfKtiRFMjbJNbIbmpMGphRK01mXXOyJ4lnfl8TJPyHQ1boBgYzfu8nr1ejOcxdgA==
X-Received: by 2002:a05:6830:4126:b0:6be:f8b8:5945 with SMTP id
 w38-20020a056830412600b006bef8b85945mr1471401ott.19.1694525140130; 
 Tue, 12 Sep 2023 06:25:40 -0700 (PDT)
Received: from grind.. ([177.9.182.82]) by smtp.gmail.com with ESMTPSA id
 p15-20020a0568301d4f00b006af9d8af435sm3991255oth.50.2023.09.12.06.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 06:25:39 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v10 20/20] target/riscv/cpu.c: consider user option with RVG
Date: Tue, 12 Sep 2023 10:24:23 -0300
Message-ID: <20230912132423.268494-21-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912132423.268494-1-dbarboza@ventanamicro.com>
References: <20230912132423.268494-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
---
 target/riscv/cpu.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fb8e4d6a8f..2644638b11 100644
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


