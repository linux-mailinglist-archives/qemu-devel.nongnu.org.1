Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A23E7EA1DB
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:33:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2ano-0001S3-4Q; Mon, 13 Nov 2023 12:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2anl-0001Rr-JE
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:32:45 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2anj-0000v9-IQ
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:32:45 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1ccbb7f79cdso34221515ad.3
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699896762; x=1700501562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VYBNYKyRQnZm5Azne5zwUk2eDMhVMq7sbSEJ06OYxG8=;
 b=S0PtDprvn/PO4ELVzuUJLN8x8PQjmX0lBLjFWw+88zS2W5ZaV9Wm2bzUDazZK5tChg
 84rdTiqf1Ue1XZa4SQfXzfz3c3doa4gJe33XH3AgTdeS2Fvs7Ix62Igr1ZNxDPx6WoUF
 sFMygBJDz5Uz6uQnwamHB3Dx0W3iiL6rXqkNj9nIwv56/ArCa2IgVv7bajU0dUgWXzeu
 98wGtIsl7h49heTHntwyLnptf1xR5waCnReaVDCXKk1p33dFbccu5fnY3/4gcsJZc21w
 m4nF41O8ud/SDbVB5NzVnXdW3v6sXp80Cml9dFwcQy+TB1hrXddjk9gyX1sqwPNKgvNn
 gKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699896762; x=1700501562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VYBNYKyRQnZm5Azne5zwUk2eDMhVMq7sbSEJ06OYxG8=;
 b=EzQgcVOkI9K6GdbR5/5Xj0cI9oY+y770SrBnJbPftILQ/VqjcOYjqay4tMgtlbXozn
 WKOHioy+CMe1kgAA2K03oL7o2q+FSYMn1sqKXl8wycE1FtL1p7+tzZQWb1kJTuM3vUqM
 ITWISr2ZzmkIyPPkL1Pf18HpRlQadkBZXoCOyvKVOlGODl+x/PFONUJjgmLtSsioKFMI
 oXsLe3teCVzef1nNHFQO7ATJGNk49ZK03M5mUn6gexJ6vG4lvnGYOj3nPob3+buKfRDt
 rEZ7cgSWYmmHWx6LOdPkRsKlVUZzFvyy+tLpNgWCTunMINmtcdvZT1u9e+F+L4fBhtmq
 ZyLg==
X-Gm-Message-State: AOJu0Yxq/0TVTG1OuUqDLK02Tda8mj+DmQDeqVdc7sJVAPwbM63MUIXO
 wy2bMDjM6Y6x8Pp2G4huy6l+eDgNvbKTBDVb2PQ=
X-Google-Smtp-Source: AGHT+IEHE0WFY/1RbFK/sTzfUI9yVdcjLNjjGDl0Ldohc30GPQHxR3ynxeUQECq7THzFNcuaQL1eJw==
X-Received: by 2002:a17:902:f7c7:b0:1cc:70dd:62e7 with SMTP id
 h7-20020a170902f7c700b001cc70dd62e7mr203603plw.32.1699896762150; 
 Mon, 13 Nov 2023 09:32:42 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 e6-20020a170902d38600b001c731b62403sm4271910pld.218.2023.11.13.09.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 09:32:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 04/12] target/hppa: Fix calculation of CR_IIASQ back register
Date: Mon, 13 Nov 2023 09:32:29 -0800
Message-Id: <20231113173237.48233-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113173237.48233-1-richard.henderson@linaro.org>
References: <20231113173237.48233-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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


