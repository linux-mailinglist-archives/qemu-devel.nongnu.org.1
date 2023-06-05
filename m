Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD7872314A
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:26:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GgE-00070a-VH; Mon, 05 Jun 2023 16:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gft-0006tz-Kf
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:19:33 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gfq-0005l2-Ps
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:19:32 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-543ae674f37so975183a12.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996369; x=1688588369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lRZfmLEHt5BGsHL2wDYj2+9bUOvf3/u2iHm8wiPgZqI=;
 b=kJ0Bkroo/DWziREa1n1noOetNp41O6Ox58UrIuhCJU4rx91T1V/BI8t2AqjfTSEcwV
 q0suTmJNw6CzrahEgC63C7mjCRqRALeAr3fAPGb3uUjy3x4GgrWdoH9+/wnz+Hn2edZO
 6GSlAMsNnO26Gw0xtCDzTw9eZFylJXZ/tjJYOgvDUMARtMFKwUmcmaxkNB61D9KMmaN3
 7/OTqJKFCT8cvovfeX3OjF9DftPq57Uvr9eNIDQ4LaEAnLP5nAW2mh/+VA9k1bNwj9+9
 sAZ1i8vij/rS6eqJlCY+mqHPhSbiv+P+RoHliqr71a02RMwjVQj60v/dplGBSObEgB3h
 YgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996369; x=1688588369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lRZfmLEHt5BGsHL2wDYj2+9bUOvf3/u2iHm8wiPgZqI=;
 b=MoP2reL7z4R4Q6McIYhUv23f7D6KjULiAnXbVvsMCVSV4MoU+Jb+vSL3zsH2BLPAvC
 DkLxNG33u3E0gy43xDOrR5LM5a/TEb5wE8BHRyCtpelTP4iQM0G343pfOzHBsaNKg97s
 hPMQ//1WX5ub235w1fyyXpclrquMTZSmLT4WVaB7l412igh+36qHUclHryoUNqD+iFG9
 r0RR3Vai9MIi/NMvJI87+bbCNKjdtqainjjB4N2YCbcEM0KaU7hoMrBM0y096zF+lDoB
 ZnBHB5qCxCH+QCsOfpXtaica2eDH2LBR2KnoaB6hwHn3YxfhLCKTF+lpVVusmKgOkUiI
 sCvQ==
X-Gm-Message-State: AC+VfDx+i6L3RxYU60PbAHHZDIJeS5sht9vtQOWY28eE42GXDG19BpbN
 DcyIx0K9w1j1AeWoH7+HH/txY2ZovS0/ZcXFEEg=
X-Google-Smtp-Source: ACHHUZ539miFFldy7kZQ+sUO9QdaTT3m3PivBFg+tBUPi0EjH3GbDxbb4GZKwyu+VbtDu8IXb4jZdQ==
X-Received: by 2002:a05:6a20:7492:b0:10f:176d:6ae9 with SMTP id
 p18-20020a056a20749200b0010f176d6ae9mr195389pzd.1.1685996369177; 
 Mon, 05 Jun 2023 13:19:29 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 w20-20020a170902c79400b001a980a23802sm7018184pla.111.2023.06.05.13.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:19:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 45/52] tcg: Move env defines out of NEED_CPU_H in helper-head.h
Date: Mon,  5 Jun 2023 13:15:41 -0700
Message-Id: <20230605201548.1596865-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


