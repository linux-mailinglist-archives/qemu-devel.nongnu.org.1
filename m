Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9147D77D660
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 00:48:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW2pj-0006qU-Cj; Tue, 15 Aug 2023 18:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW2ph-0006pr-Le
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:48:13 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW2pf-0008Ic-Eq
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:48:13 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1bbdddd3c94so4621476fac.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 15:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692139689; x=1692744489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nHZruyGhS61hd7x1Y8uBGx8vYdEXaf7f0K0Y/6jZHbo=;
 b=f56eKBTC4sNCCjFlYrE+mSxa8BlcbGvrOnlGPkfhhf+uV3vGTTMH1nlmaBRmvhvcE5
 0bfzsTrTEUxdI1UJY+R77UEp6in0g6YFp1FzLXIlbWuP39ALP0ynoDyV8CyfFkGI3AG8
 ykU2T5zastD87wRn/VNNcHIRz6jZDa1vUHCWEVU9UrlabAOApzO+YB1GzVYqgANIp5Nq
 83Q6N2dQCToQFgQurKSqQhLKZCHd6B6k1bNDtV48h9KIIIuXF5T4K5JjA7B+Z+Y+X9fq
 /O9fKl5f2+ici+0u1jh0Yd0vlnPHepF2JVBn7SYNm6sNFkMHM4ZMl5NjxFk1f6wAbJYt
 337A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692139689; x=1692744489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nHZruyGhS61hd7x1Y8uBGx8vYdEXaf7f0K0Y/6jZHbo=;
 b=j9/arL6/GlNwGVyMYxT8cCecbJSeMftZjoF4TzN/Icg01Ryvnf+jNzKuIOmq35VY/5
 J3qfEYN9uvVxbDCO4SXqSFyrLYVnLtUi/YTl2k2Xgii2xPkoRo7wZlcN39pxYyGwXZxp
 zAW2imYyTIk5mskdQ3xtv7qZLxKDsi2MMv5MRbhCgs5bT5/YO8IrVcQl+qlBPi6B+lgP
 pR5pHVCMzQDSccBO3Mi6FQAurAiPnBB7GqOyn5IBS8HhspTMUxL8I86hfoWaeNsOHsei
 NIYHmYqUxPn0shrjx3I5gC4oQ+LBZXoOskhcMOHlo5BlyFgOHlgcplYf3dIIIm4QzEO4
 QBrg==
X-Gm-Message-State: AOJu0YyU9FzlJbNs187h9WvJKiT/MmMJQdQvItkdROzAohH1EomS9SsN
 tO/HJqcr1oL8vNmDNOsB0jVPxyfF4gE4OHsCXHk=
X-Google-Smtp-Source: AGHT+IF9QtcXGTHFaIGCXV0nkQh7+UaiQEvI8rWtgxClBYsHoEPqNxlpMTLwTicd5iKGBPEUGtW1mA==
X-Received: by 2002:a05:6870:f60c:b0:1bf:a95:7a3f with SMTP id
 ek12-20020a056870f60c00b001bf0a957a3fmr33911oab.54.1692139689630; 
 Tue, 15 Aug 2023 15:48:09 -0700 (PDT)
Received: from grind.. (189-69-160-189.dial-up.telesp.net.br. [189.69.160.189])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a9d4b09000000b006b9f26b9b94sm5655668otf.28.2023.08.15.15.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 15:48:09 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 7/8] target/riscv/cpu.c: honor user choice in
 cpu_cfg_ext_auto_update()
Date: Tue, 15 Aug 2023 19:47:32 -0300
Message-ID: <20230815224733.434682-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815224733.434682-1-dbarboza@ventanamicro.com>
References: <20230815224733.434682-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e24085fd64..2bab425f9f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -185,6 +185,12 @@ static int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
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
@@ -196,6 +202,10 @@ static void cpu_cfg_ext_auto_update(RISCVCPU *cpu, uint32_t ext_offset,
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


