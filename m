Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A687D01AF
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:34:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXmD-0001U5-77; Thu, 19 Oct 2023 14:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtXm2-00018z-8b
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:29:34 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtXlz-0006zq-VI
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:29:33 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5b837dc2855so29887a12.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697740170; x=1698344970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T4DZaKL6rPO4eOmJB5sgPBMNx7MhU9e4zPB2kNBWFXU=;
 b=Ba4cu1ZbCKqzQFiqJa5lLoVDXMEbhBpgJaa4vlC1Wn8N84L2I5yh1c/sK4VSodW86y
 N7Rctrz9ia6A5xxH1VoxokDF3/7jsBBPfdvc3xpUHLXXMzQyL5GkOXBYvIDBO1jsL8Pf
 Akay/L58pJ8wvqG8y70PH2YkKrkmquOWIMvl5QRQjGabdm/QzZx+kNKy1GP8tQCyfw8d
 ZT6ZdPwH0aFhDcUXhBB6+77OnZWfcMz+1EPv7ayvFM7NUC0Q6Jh1dtVa3YHs02HVok8k
 0qbrtc1tqDTo0gitcxmS+iYa0+4pN1zWcFJNKoSYd0eNGouVmOx1cmvfJEXHODUkCP4U
 511A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697740170; x=1698344970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T4DZaKL6rPO4eOmJB5sgPBMNx7MhU9e4zPB2kNBWFXU=;
 b=JOVJhkM4C92gvkVDp7LaUbXpoyKULNt1hxKM0ceLmsgeu7pn1kEUK13gxFbiLJIY6K
 V+zHyw6zD5mdg2TU1j28dcH0XwvyVT6RR/Bt0inxQ1ZMmiLq0gLBUFHLkkD/GEtdxieH
 TGbRYihINcWqVB9LF+AjS9HyJfqsr4/+No3lXCHw47rb1WWDIoD2RYpAVBAFY1p+zgtN
 2EkzLbpTjr7iN99s2jEcSqHCkprW+97qlvPcfIpYhnS0txe6HnOE66sCq5kB7nEUG2To
 tszbllNAIuymBNO3N2/+57zouWV+YwH8Q376vbVYJzyufisAmJ2r74l1MWie4fD7QOHM
 SFBg==
X-Gm-Message-State: AOJu0YyW9u1N36bFza0T6cXMexHfRu4JYDVorKMdVXqswfEB5OZXJHaG
 9PrrQBPP/KNIOziZCLgK3VyfOP0OxreWmjM7Exw=
X-Google-Smtp-Source: AGHT+IF/uRMmGstdn4HUFyv6LHLqy+XBtiHAL157HTuuKsvgUpvZoXD18jJVhWZopJqsIBPXpf+L5A==
X-Received: by 2002:a05:6a21:a5a8:b0:133:1d62:dcbd with SMTP id
 gd40-20020a056a21a5a800b001331d62dcbdmr3977924pzc.28.1697740170085; 
 Thu, 19 Oct 2023 11:29:30 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 e1-20020a630f01000000b005b856fab5e9sm72216pgl.18.2023.10.19.11.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:29:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-arm@nongnu.org, laurent@vivier.eu,
 ysato@users.sourceforge.jp, kbastian@mail.uni-paderborn.de,
 jcmvbkbc@gmail.com
Subject: [PATCH 2/7] target/arm: Use tcg_gen_ext_i64
Date: Thu, 19 Oct 2023 11:29:16 -0700
Message-Id: <20231019182921.1772928-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019182921.1772928-1-richard.henderson@linaro.org>
References: <20231019182921.1772928-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

The ext_and_shift_reg helper does this plus a shift.
The non-zero check for shift count is duplicate to
the one done within tcg_gen_shli_i64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 37 ++--------------------------------
 1 file changed, 2 insertions(+), 35 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 10e8dcf743..ad78b8b120 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1324,41 +1324,8 @@ static void ext_and_shift_reg(TCGv_i64 tcg_out, TCGv_i64 tcg_in,
     int extsize = extract32(option, 0, 2);
     bool is_signed = extract32(option, 2, 1);
 
-    if (is_signed) {
-        switch (extsize) {
-        case 0:
-            tcg_gen_ext8s_i64(tcg_out, tcg_in);
-            break;
-        case 1:
-            tcg_gen_ext16s_i64(tcg_out, tcg_in);
-            break;
-        case 2:
-            tcg_gen_ext32s_i64(tcg_out, tcg_in);
-            break;
-        case 3:
-            tcg_gen_mov_i64(tcg_out, tcg_in);
-            break;
-        }
-    } else {
-        switch (extsize) {
-        case 0:
-            tcg_gen_ext8u_i64(tcg_out, tcg_in);
-            break;
-        case 1:
-            tcg_gen_ext16u_i64(tcg_out, tcg_in);
-            break;
-        case 2:
-            tcg_gen_ext32u_i64(tcg_out, tcg_in);
-            break;
-        case 3:
-            tcg_gen_mov_i64(tcg_out, tcg_in);
-            break;
-        }
-    }
-
-    if (shift) {
-        tcg_gen_shli_i64(tcg_out, tcg_out, shift);
-    }
+    tcg_gen_ext_i64(tcg_out, tcg_in, extsize | (is_signed ? MO_SIGN : 0));
+    tcg_gen_shli_i64(tcg_out, tcg_out, shift);
 }
 
 static inline void gen_check_sp_alignment(DisasContext *s)
-- 
2.34.1


