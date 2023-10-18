Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 568D57CEA5E
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:57:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEVl-0002Fc-0B; Wed, 18 Oct 2023 17:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVh-0002Dp-TV
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:25 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVg-00054Z-6P
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:25 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6b26a3163acso4843448b3a.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697666123; x=1698270923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MREtjG0NHY4k+Z9J9RKPRuQgui8LzKGqqV/WUmlbHKg=;
 b=nr/qyplX6fZSmDV9CV1v2zf0+FbMrQoBFQ7paGFk5fOhwTnwjjhoA2mN1TYSLq7QiT
 2xCySNXzeNGSRx8NDGnpOeHtat2YZYj6SdMc/512+XxfO55WXRaTcHydH1kE9NUbyJj0
 PWr41auHeFXYXBjkw3rMu1i3xQsyWyTG1w6OVGjZV583OUYLQv9EXK/cBS3bOqxPlDuJ
 PVNrxLESJf/rybDXjaz7Y7KgN2g2mL87wzMpodvi5bsi9LSCRM/hfMuS+ZDciVamdk8L
 J9ZaxQp06XHQ4l/U0EsXxvU65Jg7/oqiDaGMbTpzAIdnhs9hMScz0pAvFkZ0XITogHcM
 vMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697666123; x=1698270923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MREtjG0NHY4k+Z9J9RKPRuQgui8LzKGqqV/WUmlbHKg=;
 b=gLOpR5uEgBzTLp1nIuHRsRN2Osnq4Q2Xy0McCp0J6VSF65ThIZQujM4gnuriCQaftG
 YuKk91Tyfa1FKeueUbGiTjmKOyetUV44ib2bFlr9OlA3TUXFAWq+XVKtfOOoyS/QkRZt
 8kgUwJnf0dNiZdoHLXiVr/Y8hEcQCmLV+DVLaty9iflwnkdrt1jG7UlldYbQ2NT2BL55
 UC77OGIuSeyb/v5hZ2eO1gvgL+DFfAAZSa9txA4yk9SlnIX//0biwO7NVXD/YEYJbhuE
 64JMaLnZXTJc6LIxA/fnfM6mVhQb+0AAzvv8TnSagU9/KCwNMfN+roUdUCgvcQZ998ka
 sXJQ==
X-Gm-Message-State: AOJu0YwUlAVYEXlWys4SoEGa+4iCZ7vaue+GKZucECWGPMJ48FZdBrN4
 GReLB3lRiKvPIBg2As/FTib4ajoTd7c3FeL8EA8=
X-Google-Smtp-Source: AGHT+IGt9re8nDuQLq9VQl8QAmFsRRRK0SHC650YLhIiHgXT1zDxfig3kpw0Qs5ZgKi9FeKRLYJt/Q==
X-Received: by 2002:aa7:9852:0:b0:68a:4bef:5f9a with SMTP id
 n18-20020aa79852000000b0068a4bef5f9amr329534pfq.0.1697666122787; 
 Wed, 18 Oct 2023 14:55:22 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r15-20020aa7962f000000b006889348ba6esm3796263pfg.127.2023.10.18.14.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:55:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 53/61] target/hppa: Implement HAVG
Date: Wed, 18 Oct 2023 14:51:27 -0700
Message-Id: <20231018215135.1561375-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/helper.h     |  1 +
 target/hppa/insns.decode |  2 ++
 target/hppa/op_helper.c  | 14 ++++++++++++++
 target/hppa/translate.c  |  5 +++++
 4 files changed, 22 insertions(+)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 99486f4cf8..1feb2fdfc4 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -16,6 +16,7 @@ DEF_HELPER_FLAGS_1(ldc_check, TCG_CALL_NO_RWG, void, tl)
 
 DEF_HELPER_FLAGS_2(hadd_ss, TCG_CALL_NO_RWG, i64, i64, i64)
 DEF_HELPER_FLAGS_2(hadd_us, TCG_CALL_NO_RWG, i64, i64, i64)
+DEF_HELPER_FLAGS_2(havg, TCG_CALL_NO_RWG, i64, i64, i64)
 DEF_HELPER_FLAGS_2(hsub_ss, TCG_CALL_NO_RWG, i64, i64, i64)
 DEF_HELPER_FLAGS_2(hsub_us, TCG_CALL_NO_RWG, i64, i64, i64)
 
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 1830b06c76..fb0f9d6dbd 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -214,6 +214,8 @@ hadd            000010 ..... ..... 00000011 11 0 .....  @rrr
 hadd_ss         000010 ..... ..... 00000011 01 0 .....  @rrr
 hadd_us         000010 ..... ..... 00000011 00 0 .....  @rrr
 
+havg            000010 ..... ..... 00000010 11 0 .....  @rrr
+
 hsub            000010 ..... ..... 00000001 11 0 .....  @rrr
 hsub_ss         000010 ..... ..... 00000001 01 0 .....  @rrr
 hsub_us         000010 ..... ..... 00000001 00 0 .....  @rrr
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index ece523bea0..cba610ac75 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -410,6 +410,20 @@ uint64_t HELPER(hadd_us)(uint64_t r1, uint64_t r2)
     return ret;
 }
 
+uint64_t HELPER(havg)(uint64_t r1, uint64_t r2)
+{
+    uint64_t ret = 0;
+
+    for (int i = 0; i < 64; i += 16) {
+        int f1 = extract64(r1, i, 16);
+        int f2 = extract64(r2, i, 16);
+        int fr = f1 + f2;
+
+        ret = deposit64(ret, i, 16, (fr >> 1) | (fr & 1));
+    }
+    return ret;
+}
+
 uint64_t HELPER(hsub_ss)(uint64_t r1, uint64_t r2)
 {
     uint64_t ret = 0;
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 97d27cb2a9..b3335ba595 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2776,6 +2776,11 @@ static bool trans_hadd_us(DisasContext *ctx, arg_rrr *a)
     return do_multimedia(ctx, a, gen_helper_hadd_us);
 }
 
+static bool trans_havg(DisasContext *ctx, arg_rrr *a)
+{
+    return do_multimedia(ctx, a, gen_helper_havg);
+}
+
 static bool trans_hsub(DisasContext *ctx, arg_rrr *a)
 {
     return do_multimedia(ctx, a, tcg_gen_vec_sub16_i64);
-- 
2.34.1


