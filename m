Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 920477A32C0
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:46:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd36-0005DS-HO; Sat, 16 Sep 2023 17:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2y-0005Ae-Vy
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:49 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2x-0000Tc-Fh
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:48 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6c232d36da8so1879622a34.1
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900506; x=1695505306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s/Muc6q58T/I8t1/FsgbZeb0GzvuwJNmxxUL80PV3EI=;
 b=x9DbYvOopgiM4ZMQx2STZemBCbiuXhX6RjvuwAwbZMFzbsrHzty+/4FCEWxqQd3NLy
 mRb5BcGUGwR1debq1lO1MSYjl0Ly5NfB60czSajcjph6uy3vDGJRCcVOfHnIFsPLP++9
 h4dyydOf8OHYfeHfARlDFW4GJL+jzgxZf3BJxQsQ6TN8WEakyulTH3alhrHaalKfFmmP
 bueLeEBHOMINrMShPmw6PLYmumTd7NmBgZdTeQmtR+wIJ5v2bGQzKF63UYnQvBpLvuhx
 Y8L78sZswEqlk3b4LUNjxp6QyyreJHicxEZ5XM3uSBh3OHSqjLRCsk+0+NJOG38LdbEZ
 DYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900506; x=1695505306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s/Muc6q58T/I8t1/FsgbZeb0GzvuwJNmxxUL80PV3EI=;
 b=kPQF4eqNqmjKoyY0XuYXBraYNVoL+M1cuc8l586Ax0OdksniFpZ6m0FhxVk0ezAQTM
 LCKPDGuebIPuTMjXjLkldVUZWQrqzNObz9grwZw6Jecf6pcuClw2QtTgWKvKnjZ2u7gB
 TzjByppFJgFzE6UlywN/fjF3KHD8ix+sRMauBAADkOTTMq6wC3LTdLfAhaprtVldFzI6
 uiJy0uOViCY5DTcE6uxGHwxQz95DkZwSiNS+Nmktl/D4QFVMNF6x6jPFcGrX/zv06RNS
 /ybtA3pd+YIrT6aIfXIf5f1+Qxov5dszGtkL37j2WqLP4DVJnIU4RQyUcp4EtSCIJQdC
 xNhg==
X-Gm-Message-State: AOJu0Yx4AjHAVnm4vuBc8vjUwSiA3DbJbsMy/4I42u0zwoPfJXK8et6S
 R3LCCRjvpK2he0bbrMZppDmX7OEZsrOM/6MtPjQ=
X-Google-Smtp-Source: AGHT+IHu8O42J/rLDRCelearY9ZXyxcJ/2Z1bFtlsOAo1jqdTRIL4C8pKRVGERNv6uQlaLTLZk8QsQ==
X-Received: by 2002:a05:6358:9907:b0:135:3f5c:9675 with SMTP id
 w7-20020a056358990700b001353f5c9675mr6568585rwa.19.1694900506323; 
 Sat, 16 Sep 2023 14:41:46 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 21/39] accel/tcg: Remove env_tlb()
Date: Sat, 16 Sep 2023 14:41:05 -0700
Message-Id: <20230916214123.525796-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Anton Johansson <anjo@rev.ng>

The function is no longer used to access the TLB,
and has been replaced by cpu->neg.tlb.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230912153428.17816-9-anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[rth: Merge comment update patch]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h       | 11 -----------
 tcg/aarch64/tcg-target.c.inc |  2 +-
 tcg/arm/tcg-target.c.inc     |  2 +-
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index af9516654a..b37715c27d 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -451,15 +451,4 @@ static inline CPUState *env_cpu(CPUArchState *env)
     return (void *)env - sizeof(CPUState);
 }
 
-/**
- * env_tlb(env)
- * @env: The architecture environment
- *
- * Return the CPUTLB state associated with the environment.
- */
-static inline CPUTLB *env_tlb(CPUArchState *env)
-{
-    return &env_cpu(env)->neg.tlb;
-}
-
 #endif /* CPU_ALL_H */
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 06ea3c7652..69f2daf2c2 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1679,7 +1679,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     mask_type = (s->page_bits + s->tlb_dyn_max_bits > 32
                  ? TCG_TYPE_I64 : TCG_TYPE_I32);
 
-    /* Load env_tlb(env)->f[mmu_idx].{mask,table} into {tmp0,tmp1}. */
+    /* Load cpu->neg.tlb.f[mmu_idx].{mask,table} into {tmp0,tmp1}. */
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) != 8);
     tcg_out_insn(s, 3314, LDP, TCG_REG_TMP0, TCG_REG_TMP1, TCG_AREG0,
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index b1d56362a7..a2f60106af 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1420,7 +1420,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     ldst->addrlo_reg = addrlo;
     ldst->addrhi_reg = addrhi;
 
-    /* Load env_tlb(env)->f[mmu_idx].{mask,table} into {r0,r1}.  */
+    /* Load cpu->neg.tlb.f[mmu_idx].{mask,table} into {r0,r1}.  */
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) != 4);
     tcg_out_ldrd_8(s, COND_AL, TCG_REG_R0, TCG_AREG0, fast_off);
-- 
2.34.1


