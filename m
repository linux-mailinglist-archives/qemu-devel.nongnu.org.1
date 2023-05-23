Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2F970DEFB
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:16:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SVl-0003SH-Gf; Tue, 23 May 2023 09:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SVh-0003MD-Fj
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:57:09 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SVb-0004Cw-HE
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:57:08 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-64d30ab1f89so3420625b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850222; x=1687442222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Br8zXaVAOKNlB9xv5g9cPNHLqbtW8oBpWMoxXID7zwE=;
 b=g81ezXOtth/xC8Z5cSOn/XNLj4zwn1LRG01CPvz1r7dICqD/FTDpXrB5buaTnKW/qa
 Uz81t2kIGV21gpS9BnzRAbtCM56FbnvcGhjNx3k9qlRnAzZEUkISK4SKg4u7FUCnMber
 sPk83NdFVfjongPY2YZXz76RV+awfelEd7cAfTNbFaFl9FwZ08C+YEL5app25d6Shj/5
 Dk/eUoPHoucin4v/mnnoe0ym20iWxyYv1/65WOTUZ2DrQ6cpdNYp2+u/FTCSubvwfVg7
 2yHxs6tyucwRA5oZHEldu9w5QEjWiOUX5iAfI5cDGq8l67FM1XhDvpJ7u//8YuhZQsVu
 oZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850222; x=1687442222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Br8zXaVAOKNlB9xv5g9cPNHLqbtW8oBpWMoxXID7zwE=;
 b=gcaZmOEBN2MYFLn5DpQCgOwNPc6aXgMrreK7kN+YuvGqtXi9ZP/hSgWa9dpHv3x0ox
 rGJ3a/YlHFj/H6M/kkMUTue9QXezQKYayqF72/mn35tR3i9LpUJ65sbDnnaH/BfXcAzE
 7t9XUr48LFpdTsJMbItiQxhiaX4oGnGtjRdGJno2itRDkW0zBX8MERcuBMd2sAywySgx
 prAxbqBrYeF0WTF/fae4fcvHbw2i1fathhvOauPQQyowoC1YUs3wqMHLVgphL78Szh3d
 cA06sAQaKfi/jGPZ/h8eeocpDkag0ig5iGtHyd/cRgWb+YicyNxjP+v40AZJE0emQXXv
 Yi6g==
X-Gm-Message-State: AC+VfDynAVyFKJfX1/i/nEverUjWM5HX0GRWNDACpVlcWgOfPf7i3+KH
 e/cP8cWcf/+Xww2aWw4pWaBBDd8+K3YlRoVf2Q8=
X-Google-Smtp-Source: ACHHUZ74Aozjn4YeX0V77wxD30Va322y51mhQsFJF1YvQ8YlDqj2jpU6z2joLqgj38LDAHbFhj2Gsg==
X-Received: by 2002:a05:6a00:2da8:b0:64b:20cd:6d52 with SMTP id
 fb40-20020a056a002da800b0064b20cd6d52mr18728001pfb.14.1684850222187; 
 Tue, 23 May 2023 06:57:02 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a62a50b000000b0063799398eaesm5805790pfm.51.2023.05.23.06.57.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:57:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 47/52] tcg: Move env defines out of NEED_CPU_H in
 helper-head.h
Date: Tue, 23 May 2023 06:53:17 -0700
Message-Id: <20230523135322.678948-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Since the change to CPUArchState, we have a common typedef
that can always be used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/helper-head.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/exec/helper-head.h b/include/exec/helper-head.h
index a355ef8ebe..28ceab0a46 100644
--- a/include/exec/helper-head.h
+++ b/include/exec/helper-head.h
@@ -22,6 +22,7 @@
 #define dh_alias_f64 i64
 #define dh_alias_ptr ptr
 #define dh_alias_cptr ptr
+#define dh_alias_env ptr
 #define dh_alias_void void
 #define dh_alias_noreturn noreturn
 #define dh_alias(t) glue(dh_alias_, t)
@@ -37,6 +38,7 @@
 #define dh_ctype_f64 float64
 #define dh_ctype_ptr void *
 #define dh_ctype_cptr const void *
+#define dh_ctype_env CPUArchState *
 #define dh_ctype_void void
 #define dh_ctype_noreturn G_NORETURN void
 #define dh_ctype(t) dh_ctype_##t
@@ -52,9 +54,6 @@
 #  endif
 # endif
 # define dh_ctype_tl target_ulong
-# define dh_alias_env ptr
-# define dh_ctype_env CPUArchState *
-# define dh_typecode_env dh_typecode_ptr
 #endif
 
 /* We can't use glue() here because it falls foul of C preprocessor
@@ -96,6 +95,7 @@
 #define dh_typecode_f32 dh_typecode_i32
 #define dh_typecode_f64 dh_typecode_i64
 #define dh_typecode_cptr dh_typecode_ptr
+#define dh_typecode_env dh_typecode_ptr
 #define dh_typecode(t) dh_typecode_##t
 
 #define dh_callflag_i32  0
-- 
2.34.1


