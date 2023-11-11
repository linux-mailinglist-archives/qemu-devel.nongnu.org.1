Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDA37E8796
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 02:34:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1crM-00028F-6Q; Fri, 10 Nov 2023 20:32:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1crJ-000247-43
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 20:32:25 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1crH-0001ar-BT
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 20:32:24 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6c4cf0aea06so1597852b3a.0
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 17:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699666342; x=1700271142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VYBNYKyRQnZm5Azne5zwUk2eDMhVMq7sbSEJ06OYxG8=;
 b=joIdKz9H3s/7p5IjyeoHY1pq63iuHC9fM6bx0NMhaknX1l6iQQiq+mQH64AxRQq6T1
 M23gc6zeSDkYWgAPezB6oi7MNI/MWNNQ8iElKOvCoPyv3tRhcj/8Jq+c7XpvWdEJJF/P
 YO3J4XTW5LuLZPIfKYv/LUv4fKw8YSdLiazj0/2mBxIauO9awi10nNaIC3trk9pPSuwp
 fpF5Jc0ZsD9GcP8zm9Arj5XDlM478I1+/ylNlTCMd3PXWYxLEpv6gCOpstezksPUcCMd
 pYSLPAyGYhU5AqR7F8TSzK648bF/pwDS3XIVCSP/Tb0h2bn/EPwbRNC3uQRS/pPDg3/r
 FXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699666342; x=1700271142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VYBNYKyRQnZm5Azne5zwUk2eDMhVMq7sbSEJ06OYxG8=;
 b=hjhPdVkbRQ9RxKV/IKNzpDYJqiA34Q9nuUcaWkjWHKQ9UlL4ju68rkQx7XdtQ06pBG
 +FBRg375JecK/eRYSgOT8z6h9NlNhsVY7GtZ5c2va643JCDZRHd6qJReGinFIshaXr1k
 PJvejASSWOFbsGez7/vBUyZ5KIq/SQ2K0PPVL+UHDMCMTs0jTehI/t6Mzbpd0Or0odxN
 AdIIx0sJtElQ5RpygyC749hYZ4wfVLQ053AOXo17tt/K9Tlfm0sd8U4XzJU9rQlbiict
 GH6Tw9dvZ8tQbfEP4PbXJP3Aicw9NCtZ/rhcoFJOeKQ2KkTEbts8yZvyyZeg7dZRCVSC
 5IEg==
X-Gm-Message-State: AOJu0YxY4eIYLEOzGLdTD6mlDAdE+xKuWpU8TSE/HBgtaOX04CEq+IJL
 yC7tHXghx/EgndkfYHOP9UdXdsJC3z+F4hp3S6k=
X-Google-Smtp-Source: AGHT+IEIcz9PB3xD2hizh2bbVL55BCRTOzlvG9kfK7swTt09yV5Xvg3E0XXzfJgUIzZ/kw+i0NRQBA==
X-Received: by 2002:a05:6a21:7988:b0:16b:bd0f:ad06 with SMTP id
 bh8-20020a056a21798800b0016bbd0fad06mr1023101pzc.31.1699666342001; 
 Fri, 10 Nov 2023 17:32:22 -0800 (PST)
Received: from stoup.hsd1.or.comcast.net
 ([2601:1c0:5e02:2a20:a99c:45a6:14e9:ea6])
 by smtp.gmail.com with ESMTPSA id
 m11-20020a62f20b000000b006c1221bc58bsm333502pfh.115.2023.11.10.17.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 17:32:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 06/11] target/hppa: Fix calculation of CR_IIASQ back register
Date: Fri, 10 Nov 2023 17:32:07 -0800
Message-Id: <20231111013212.229673-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231111013212.229673-1-richard.henderson@linaro.org>
References: <20231111013212.229673-1-richard.henderson@linaro.org>
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

From: Helge Deller <deller@gmx.de>

Need to use iasq_b and iaoq_b to determine back register of CR_IIASQ.
This fixes random faults when booting up Linux user space.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/int_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 467ee7daf5..98e9d688f6 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -126,7 +126,7 @@ void hppa_cpu_do_interrupt(CPUState *cs)
         env->cr[CR_IIASQ] =
             hppa_form_gva_psw(old_psw, env->iasq_f, env->iaoq_f) >> 32;
         env->cr_back[0] =
-            hppa_form_gva_psw(old_psw, env->iasq_f, env->iaoq_f) >> 32;
+            hppa_form_gva_psw(old_psw, env->iasq_b, env->iaoq_b) >> 32;
     } else {
         env->cr[CR_IIASQ] = 0;
         env->cr_back[0] = 0;
-- 
2.34.1


