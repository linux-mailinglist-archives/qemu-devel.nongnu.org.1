Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B577DEA29
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:37:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMYK-0005qM-Vn; Wed, 01 Nov 2023 21:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXp-0005lY-FB
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:49 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXn-0001dE-D3
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:49 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6be1bc5aa1cso487528b3a.3
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888646; x=1699493446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KL35RIOske5ZEwNLa4RVHtpQpzTuLRW6sfRRvrTR5m0=;
 b=TeF7SY4U12yNB5rKhwhDmYopqEKzq3xszeWHUB3I7ByFPg3WSbmrBqCBot5MHvRNOW
 J16/nCp/l69WPL0dFNDp/iG81hR3qzFfUupvnCvy2kw4V3rdVwoNcoqaMGrDEZu2OhlI
 RCjO/LEc6ubW7hW2sot6j5epvguIKD6LMvXOX27mHUW2ZAOxy21V6KVllESGPge+P5TQ
 z1B0q2fBjtmWgpbTf5SLflDMRUMa7NZ2f3t+jF2vE3xv8p1/7DJVeiENbh5YYr3gsU81
 1KtyHs7MIWe02LxdIzjIWuGlRmZZrc60IS0pRIaRU9nW6Coo+BA50bEK17xTPqEhULSI
 JyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888646; x=1699493446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KL35RIOske5ZEwNLa4RVHtpQpzTuLRW6sfRRvrTR5m0=;
 b=k+A01f9oQiF0JPgCoVLxeeJyz31HrOerYnHe+Iat6PAJuBiPBcL4HFkxAmdref/OJ9
 q+Uz93ZiDunZTX4ax+fQpvsx1PFLaU6ghjYYO0WcljOuJEpHxuXy0PcBeyJ7tshw9GoX
 K/nhWuvN2fHNhcBhxZWOnpWDcc7GSZ42VC1NeJURf4dDZuNOJRQobx7xkrrLc6QfHTcK
 qpxfwBvgd8hOe0KdpIN2beVj8wmey0w32nhUmalz5QJ1ZZyTl4UjeeMQ7oI6IR2m00Bd
 qc8a4UidWdeWQs4JGITq2D+/krSQMWOGnx1yQFZgzsDFcCL1qOZH8PkWTmJAc0vydihq
 +s8w==
X-Gm-Message-State: AOJu0YwhKO76r1brbZ8IrjkABGlvRy7IcAtf11qY716N5aaTCzpKq0Tk
 fWBkPru8R4vPLyZjGp9xCeVWPFlUV2H2IZWU01Q=
X-Google-Smtp-Source: AGHT+IHebAHHEXQIbh03kHPGqPzgwr3U3SfhgO0EivRLQOUi9cjX7ZrqlSIabNq380NXIP5PrPMs6Q==
X-Received: by 2002:a05:6a00:a27:b0:6b5:26ef:3261 with SMTP id
 p39-20020a056a000a2700b006b526ef3261mr20222904pfh.16.1698888645330; 
 Wed, 01 Nov 2023 18:30:45 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 30/88] target/hppa: Mask inputs in copy_iaoq_entry
Date: Wed,  1 Nov 2023 18:29:18 -0700
Message-Id: <20231102013016.369010-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Ensure that the destination is always a valid GVA offset.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index c2db2782f4..cf05d8b6e4 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -720,10 +720,22 @@ static target_ureg gva_offset_mask(DisasContext *ctx)
 static void copy_iaoq_entry(DisasContext *ctx, TCGv_reg dest,
                             target_ureg ival, TCGv_reg vval)
 {
-    if (unlikely(ival == -1)) {
+    target_ureg mask = gva_offset_mask(ctx);
+
+    if (ival != -1) {
+        tcg_gen_movi_reg(dest, ival & mask);
+        return;
+    }
+    tcg_debug_assert(vval != NULL);
+
+    /*
+     * We know that the IAOQ is already properly masked.
+     * This optimization is primarily for "iaoq_f = iaoq_b".
+     */
+    if (vval == cpu_iaoq_f || vval == cpu_iaoq_b) {
         tcg_gen_mov_reg(dest, vval);
     } else {
-        tcg_gen_movi_reg(dest, ival);
+        tcg_gen_andi_reg(dest, vval, mask);
     }
 }
 
-- 
2.34.1


