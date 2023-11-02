Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F02837DEA49
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:42:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMcZ-0008C9-Qo; Wed, 01 Nov 2023 21:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbB-0006Ze-Jp
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:18 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMb8-00022i-Pd
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:17 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5aaebfac4b0so305506a12.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888853; x=1699493653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eDzYxooTETsUZpkDPcJF0snGWWzzcelkJpEZxKcE6J8=;
 b=AhlRKFdl3Uy5YU6mTDgjI0/UkwijiUE+3yDdZBZaxThYQXPIQQ60Nn8qWIJEZDgBJ3
 LRBNvmM8IiFHBlN6QcBGh4nITpyJzvkSZvSeiJRWG1/68AXaroUrpUEWX3P0sQX1mMmR
 sJC567chgQMve7PEZNOfhOgS8TIL8zW4z46Yhqm6CwCxsOVK46sq2peBOXsfmdsC7aOW
 coNTXhX+uwvhTsKcY9NdatjTWoBra+d1vy7lilhxrccBe6Rd5cPOzNVMO85MfvOFVyqH
 y1IXLPLeTLW21yOrJSm8qoG/Ty1xJdZxAYouD5c36J0DIPyq+CR/mWoUqi1l97ncwMBW
 SFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888853; x=1699493653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eDzYxooTETsUZpkDPcJF0snGWWzzcelkJpEZxKcE6J8=;
 b=QiyDxxKki5923CBlP1Skt1hv+36x/XmheB3eikV9mZyDFuBZK6Ez2wA/T+Bzm6c+VI
 DJsCz4ZD6Xvh4HxDToTNglw6IRcawz7IuRNZ3eGyZ0qNzpRgm66+FTduR75SCsF4sRGP
 lxPiVyF9mfFmSzQE8Bm8jOeHGEEKrjhnS0qKMzJx8SkQXnm8c4hrRInvT9icmUt0NPgU
 OR8t+q/yScFMBvDn+LEBl05OxyJ3rkcMQeDQzmn+eC4pq2IiNQz41Clr+SInnWdDDppH
 +iJZjZeSFMH3WKmAO5Ke6+9YSBRL5841SDcsTteXRMu+E9+0WxZFxo2Cwlt+4B03YtJ5
 N2jg==
X-Gm-Message-State: AOJu0YyPGIs+H08xZGhBz8zMpErNRI7B6c4HZYNWr2jBKB4uSHGRhxyn
 YF5wDe5cC5oA4EtX+hZD8FkypozxOBNxgFEXOVU=
X-Google-Smtp-Source: AGHT+IGwvTfVxyhpn2B8XayBDtmZ6hd5jCNfO0B9i3v3VJ6wpdqJ7nrZX9uKqz4TJxhGvmKdIUTczw==
X-Received: by 2002:a17:903:22c5:b0:1cc:4669:c0eb with SMTP id
 y5-20020a17090322c500b001cc4669c0ebmr9957733plg.21.1698888853487; 
 Wed, 01 Nov 2023 18:34:13 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:34:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 65/88] target/hppa: Implement HAVG
Date: Wed,  1 Nov 2023 18:29:53 -0700
Message-Id: <20231102013016.369010-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
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
index 02798aa105..51c24b31b0 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -16,6 +16,7 @@ DEF_HELPER_FLAGS_1(ldc_check, TCG_CALL_NO_RWG, void, tl)
 
 DEF_HELPER_FLAGS_2(hadd_ss, TCG_CALL_NO_RWG, i64, i64, i64)
 DEF_HELPER_FLAGS_2(hadd_us, TCG_CALL_NO_RWG, i64, i64, i64)
+DEF_HELPER_FLAGS_2(havg, TCG_CALL_NO_RWG, i64, i64, i64)
 DEF_HELPER_FLAGS_2(hsub_ss, TCG_CALL_NO_RWG, i64, i64, i64)
 DEF_HELPER_FLAGS_2(hsub_us, TCG_CALL_NO_RWG, i64, i64, i64)
 
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
index 2f1333b91c..2fdd4448ae 100644
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


