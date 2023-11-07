Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB1E7E3419
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:16:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CRt-0005gk-CV; Mon, 06 Nov 2023 22:08:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRe-0004s1-00
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:02 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRZ-0001Pj-Er
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:01 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5b980391d70so3939836a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326476; x=1699931276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eZfz6CwDToub3uloE73o6N9zkTY/K6RLHbmy8kpVa68=;
 b=iaAeyV8UslAlA+V5u9nFHn0XQ2lbMxwBChKtlZ8/NVlO4yr7A35liNbJ3CvXa7dzgb
 1LA+Kxd2uf1WAmZKNnz8xMLXeIkld7I3FVaqJfX9nJEAa9mHvNzzs+RgmmfzxgxZ2GSw
 wGUVyXg0N7n32N9ftsio4o/JVMvT0VvAi7eUJRrmwJ9aJ2b0ELTXS+rrOtlmeQ47msko
 rX1+1Dbay0GG6GVG71MP2f5yfe9ePRp4MDhdZAA3EoLSx5c2bg/OSbwBSa1VO+qJJUSn
 ls/aq6n8SMrQiEdG1oTiSCkgQXLMi3W3tI36xIp9Y4O+pOqBI5By7GilwHnVpt1rrAzM
 i23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326476; x=1699931276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eZfz6CwDToub3uloE73o6N9zkTY/K6RLHbmy8kpVa68=;
 b=SwfcBv2NgBoJcI2jODT6P4ZbwmnvHJZhFirNfUc5pSMM3ihWhzUWdwgwBVmLm3HjD9
 pgdcfMFvBYiPN4+C77wm8QER9FYFMh1Rnfa2Czw6F4vxEmXPymO+fS0eykB1/UyAVtp8
 kD014Fo6VEezgHjSm9Heuf9IvR3gBNMjntDGw3eHbMdYUE4B4yylOefq22Fov2thkMnU
 1raqs0lcdQ+BA8IvSiOsJ+hI0DcLzmQe5ipSqplqlyPo4eVnL1uH62rCxaGpJI11iy6y
 jqeDUKusXMQNW2dVvh1RJgFyKE14Ov/7kSn51QgdPmqPyG9B9rBsC/+9pKQFGVj2G5Zl
 tzyg==
X-Gm-Message-State: AOJu0YwW90nyw3pJZK/7/+u5VofQDPpMe1fcdLVFvNtCdKCUPFzXZfj7
 V/8A/U8ODhybKyVvmnw7avklM5g8s1xy4Ygv/1E=
X-Google-Smtp-Source: AGHT+IFAq+yGTwcxha26WDwAStYPek3Uabi0DkMlgT2+6/Huas8Kwu3TUenCkZFvhaMtSLFdBJgAGw==
X-Received: by 2002:a05:6a21:3d84:b0:184:1c37:c3d2 with SMTP id
 bj4-20020a056a213d8400b001841c37c3d2mr6151608pzc.21.1699326475886; 
 Mon, 06 Nov 2023 19:07:55 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.07.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:07:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 63/85] target/hppa: Implement HAVG
Date: Mon,  6 Nov 2023 19:03:45 -0800
Message-Id: <20231107030407.8979-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/helper.h     |  1 +
 target/hppa/insns.decode |  2 ++
 target/hppa/op_helper.c  | 14 ++++++++++++++
 target/hppa/translate.c  |  5 +++++
 4 files changed, 22 insertions(+)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 64fd1ef1ef..3b3a543216 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -16,6 +16,7 @@ DEF_HELPER_FLAGS_1(ldc_check, TCG_CALL_NO_RWG, void, tl)
 
 DEF_HELPER_FLAGS_2(hadd_ss, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(hadd_us, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(havg, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(hsub_ss, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(hsub_us, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 29b49c6cf4..6959555bf3 100644
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
index de51905428..e76f201472 100644
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
index e5a3873d25..e20ce40fe3 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2804,6 +2804,11 @@ static bool trans_hadd_us(DisasContext *ctx, arg_rrr *a)
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


