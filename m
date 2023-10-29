Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF057DAE69
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 22:10:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxD1u-0002i8-JI; Sun, 29 Oct 2023 17:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxD1r-0002h6-TQ
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 17:09:03 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxD1p-0005FT-Az
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 17:09:03 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ba172c5f3dso3272717b3a.0
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 14:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698613740; x=1699218540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iueO2fJnVCwUG1PEPwRmtLnpkdEncRsZS5LWEXo7ZOQ=;
 b=x3tKYq3vSuWMCFKLlcXeCktDhmi6OyiTFpjXMCmtYGMurUIUiya32wqOe6R1ce3YA1
 JqYvXTzKmVWx7QwY910qNOhmeDBVd95dWHMeX+kqWedbM2mUz/FUH4ysdvrhI7ai4HOF
 QDNFsXsnWDWLt9ybIY3MYyf85ln6urZDbd0O1xvRoeBizeoQ7GQ0Rd+mhpcKKHkWk0/A
 bj3eGLNN6U3+JHxCvKvkzvVseuFzx9j54LMUembKWJTQFf47T42IeDAnPS04+MuhbmwR
 BA+WBbLdcnXxEUcNImApYE9g+o7VKst5+i03Q1Uo/c50Y6njx2/dQEfdfviZr1bRHoQJ
 wPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698613740; x=1699218540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iueO2fJnVCwUG1PEPwRmtLnpkdEncRsZS5LWEXo7ZOQ=;
 b=uKau/OHPsCdiWSn0WsNpQXlB9O3KW2UPDIQ5aE0SpXHG/6pnnPCMyyHUPGYHKvSyBr
 L2K0DZIw6l/nTrR2Jefg8VJrrVToiy8dISV2fDOwuhGZYN+KicjpTylMJ3Ha0g8lWl1X
 dm5QD0zpl3JjusQqQxac3j6k8QGMaZkMiN9v/aUzQrk2lEyM+ZB7zzdEMyhx9it8kvJ5
 RxeVnUznaV4Z8tfuSDeKEBBrXULPDOClmzTpBYeAcUc30ZDnf2qzdf/7LiopwQ4F6UJd
 Ak1zutYd+JlC8hJrrLWXDcRHU3xe23IRFzXV0VDKZrzbFmjXDAuBFUmJ7RZhFLcRe4CS
 YnQg==
X-Gm-Message-State: AOJu0YwtQpfQjTG+9QPFc4FMi0rtHsBm1XuL1G67B4jkuCCMT+prBtFH
 dnWGTVYYpd0RsNWm4K4/uaPCzhY1XO+CiJtB+Po=
X-Google-Smtp-Source: AGHT+IHj9DPD5o4Jtr9xymWWNZNB7Mjlbq5LBA5B3LXcPw0/FkIyTBbT6p18kHIjYsJt97r0PwIhlA==
X-Received: by 2002:a05:6a00:2195:b0:690:c75e:25d7 with SMTP id
 h21-20020a056a00219500b00690c75e25d7mr6490293pfi.18.1698613739741; 
 Sun, 29 Oct 2023 14:08:59 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 z11-20020aa785cb000000b006c0685422e0sm4622847pfn.214.2023.10.29.14.08.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 14:08:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/11] tcg: Move tcg_temp_free_* out of line
Date: Sun, 29 Oct 2023 14:08:48 -0700
Message-Id: <20231029210848.78234-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231029210848.78234-1-richard.henderson@linaro.org>
References: <20231029210848.78234-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
 include/tcg/tcg-temp-internal.h | 29 +++++------------------------
 tcg/tcg.c                       | 25 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/include/tcg/tcg-temp-internal.h b/include/tcg/tcg-temp-internal.h
index 2d45cc45d2..44192c55a9 100644
--- a/include/tcg/tcg-temp-internal.h
+++ b/include/tcg/tcg-temp-internal.h
@@ -31,30 +31,11 @@
 
 void tcg_temp_free_internal(TCGTemp *);
 
-static inline void tcg_temp_free_i32(TCGv_i32 arg)
-{
-    tcg_temp_free_internal(tcgv_i32_temp(arg));
-}
-
-static inline void tcg_temp_free_i64(TCGv_i64 arg)
-{
-    tcg_temp_free_internal(tcgv_i64_temp(arg));
-}
-
-static inline void tcg_temp_free_i128(TCGv_i128 arg)
-{
-    tcg_temp_free_internal(tcgv_i128_temp(arg));
-}
-
-static inline void tcg_temp_free_ptr(TCGv_ptr arg)
-{
-    tcg_temp_free_internal(tcgv_ptr_temp(arg));
-}
-
-static inline void tcg_temp_free_vec(TCGv_vec arg)
-{
-    tcg_temp_free_internal(tcgv_vec_temp(arg));
-}
+void tcg_temp_free_i32(TCGv_i32 arg);
+void tcg_temp_free_i64(TCGv_i64 arg);
+void tcg_temp_free_i128(TCGv_i128 arg);
+void tcg_temp_free_ptr(TCGv_ptr arg);
+void tcg_temp_free_vec(TCGv_vec arg);
 
 TCGv_i32 tcg_temp_ebb_new_i32(void);
 TCGv_i64 tcg_temp_ebb_new_i64(void);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 29dbb29a0a..4ab6a35398 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1805,6 +1805,31 @@ void tcg_temp_free_internal(TCGTemp *ts)
     }
 }
 
+void tcg_temp_free_i32(TCGv_i32 arg)
+{
+    tcg_temp_free_internal(tcgv_i32_temp(arg));
+}
+
+void tcg_temp_free_i64(TCGv_i64 arg)
+{
+    tcg_temp_free_internal(tcgv_i64_temp(arg));
+}
+
+void tcg_temp_free_i128(TCGv_i128 arg)
+{
+    tcg_temp_free_internal(tcgv_i128_temp(arg));
+}
+
+void tcg_temp_free_ptr(TCGv_ptr arg)
+{
+    tcg_temp_free_internal(tcgv_ptr_temp(arg));
+}
+
+void tcg_temp_free_vec(TCGv_vec arg)
+{
+    tcg_temp_free_internal(tcgv_vec_temp(arg));
+}
+
 TCGTemp *tcg_constant_internal(TCGType type, int64_t val)
 {
     TCGContext *s = tcg_ctx;
-- 
2.34.1


