Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F297CEA84
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:59:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESV-00018r-S0; Wed, 18 Oct 2023 17:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESE-00015E-Ia
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:50 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESB-0004Oa-PP
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:49 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1ea82246069so1519476fac.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665906; x=1698270706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cjdPIOgHmvrr+30vbWYAH4JEvq1rx9Ce0rUnUJEWHoQ=;
 b=SeD0Az0dBHb7xSoXjFMGlJbSuXXxDlZj/nB5zduenr34ujmDZMFUrg8ajQivjvNSHe
 QJXPddKJlyc6WVlOn6HVn6pQeeVeUoPJ5Rf8xnkKoHJJ9YiBAyNg1qaZXJTzVnJLOBbI
 vg7KMo01RkKPSL5rRWSurFkKptsi23R2hR9lJI4n6MveBsCgXxgPXGoE4seSIR/Jchd0
 PX0oDxtx6dUWuJcoBUBPBE2BNq8KtdQr7WFLv7EePJyRVhO60plY5QvTvq9utcug0EfE
 wDQldeX8pKHGcq2xrTwveH96McjTaMNSH6tu3BUIVvQv5S6HCPHSPX4iFQQiXkrHpp2p
 PgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665906; x=1698270706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cjdPIOgHmvrr+30vbWYAH4JEvq1rx9Ce0rUnUJEWHoQ=;
 b=T1L7A4xYcgn26mg5So6j00jU6eLpNJ2+H/zurqrimQb1aavKc66yXofW/0nQCl4QEh
 PV6QgAbV2BN3u18hmG5KYjn2gz1oho9lsT3yVD8rTSwS3KYjRtY0LzyW2tckiPYRGYYv
 GhvJ6srgfyjrmsFpHm8qbyRzUSaeufskp6IGJWbKUvmFnLzdX7TrsBPkmQ/Uco4hMTom
 zS3G4zNIehXJYsTCXbe9Sp5K2y3LqKOroMES5GsfhOFDX8+wwcvsdgVyOzPnb2eItM2I
 hYi5dUdJSu5IIHRU710GdmVqonXZhUe/KwRS9EU2+eXReo1WYah5qJtjTEJP4JuYjZIY
 DWRg==
X-Gm-Message-State: AOJu0YyoR89mSVogSrmdvN8642Sf7PkaeOecF+NJhaTxGhUlCoxxoqNb
 B8QEWXIIgc/BBfp0GPnom+JfO0LiDj2dSnHmhDA=
X-Google-Smtp-Source: AGHT+IE72wZEgbzWcSF1B2tVVJJos6PkL59U5SUugE2SWxzwn7ZiY763xj11NntGRAsVJeWsCay7IA==
X-Received: by 2002:a05:6870:cb82:b0:1ea:478c:a26b with SMTP id
 ov2-20020a056870cb8200b001ea478ca26bmr788073oab.9.1697665906695; 
 Wed, 18 Oct 2023 14:51:46 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:51:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 12/61] target/hppa: Introduce TYPE_HPPA64_CPU
Date: Wed, 18 Oct 2023 14:50:46 -0700
Message-Id: <20231018215135.1561375-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

Prepare for the qemu binary supporting both pa10 and pa20
at the same time.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu-qom.h   |  1 +
 target/hppa/cpu.h       |  7 +++++++
 target/hppa/cpu.c       | 17 +++++++++++++++++
 target/hppa/translate.c |  3 +++
 4 files changed, 28 insertions(+)

diff --git a/target/hppa/cpu-qom.h b/target/hppa/cpu-qom.h
index b96e0318c7..4a85ebf5e0 100644
--- a/target/hppa/cpu-qom.h
+++ b/target/hppa/cpu-qom.h
@@ -24,6 +24,7 @@
 #include "qom/object.h"
 
 #define TYPE_HPPA_CPU "hppa-cpu"
+#define TYPE_HPPA64_CPU "hppa64-cpu"
 
 OBJECT_DECLARE_CPU_TYPE(HPPACPU, HPPACPUClass, HPPA_CPU)
 
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 798d0c26d7..743fc90e14 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -239,10 +239,17 @@ struct ArchCPU {
 
     CPUHPPAState env;
     QEMUTimer *alarm_timer;
+
+    bool is_pa20;
 };
 
 #include "exec/cpu-all.h"
 
+static inline bool hppa_is_pa20(HPPACPU *cpu)
+{
+    return cpu->is_pa20;
+}
+
 static inline int cpu_mmu_index(CPUHPPAState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 1644297bf8..ed5b6afd10 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -218,9 +218,26 @@ static const TypeInfo hppa_cpu_type_info = {
     .class_init = hppa_cpu_class_init,
 };
 
+#ifdef TARGET_HPPA64
+static void hppa64_cpu_initfn(Object *obj)
+{
+    HPPACPU *cpu = HPPA_CPU(obj);
+    cpu->is_pa20 = true;
+}
+
+static const TypeInfo hppa64_cpu_type_info = {
+    .name = TYPE_HPPA64_CPU,
+    .parent = TYPE_HPPA_CPU,
+    .instance_init = hppa64_cpu_initfn,
+};
+#endif
+
 static void hppa_cpu_register_types(void)
 {
     type_register_static(&hppa_cpu_type_info);
+#ifdef TARGET_HPPA64
+    type_register_static(&hppa64_cpu_type_info);
+#endif
 }
 
 type_init(hppa_cpu_register_types)
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index f86ea9b9ca..9d6670f91c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -262,6 +262,7 @@ typedef struct DisasContext {
     int mmu_idx;
     int privilege;
     bool psw_n_nonzero;
+    bool is_pa20;
 
 #ifdef CONFIG_USER_ONLY
     MemOp unalign;
@@ -4087,10 +4088,12 @@ static bool trans_diag(DisasContext *ctx, arg_diag *a)
 static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
+    HPPACPU *cpu = HPPA_CPU(cs);
     int bound;
 
     ctx->cs = cs;
     ctx->tb_flags = ctx->base.tb->flags;
+    ctx->is_pa20 = cpu->is_pa20;
 
 #ifdef CONFIG_USER_ONLY
     ctx->privilege = MMU_IDX_TO_PRIV(MMU_USER_IDX);
-- 
2.34.1


