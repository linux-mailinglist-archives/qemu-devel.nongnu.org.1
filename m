Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D64786161
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:25:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOb-0008N4-Gr; Wed, 23 Aug 2023 16:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOU-0008KB-Kx
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:58 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOK-0005Uq-OD
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:50 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bba48b0bd2so40994695ad.3
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822227; x=1693427027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cOQO7o2a72Z7Kk92GO5oi+sem2mknf2Hztp1emYuv9c=;
 b=L3n57ZiSu01+TMzA7T5rPqKZkhxK4IHiwIpkiPF6j82KP6q5grAh4OvRreKmuvseji
 7D+3GaDoFWGSaypakokMwOUf/UGh4fnvA5dBLEGplXGEw9WjGzGLrZ8rO3pLdn+scjrz
 crW/lq2sbwSd32Y+Y3BFEgcs66yMY4H6zHEWzrUKn4IgtUpf9SfV4rxXoXODv4/Uxpgl
 JWDOyJ24iLk4K1/8AlYX5UkGRuIN6/fTZ+Yto1QE9EVQkMV55Mw6fHWbTW6X/jre4KJW
 VE3UHTMznPhFQS3ofhspim26rohwioP2tPF40MZaGRfxNomnrR9VS7dNQvGPwBf6PW5u
 zPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822227; x=1693427027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cOQO7o2a72Z7Kk92GO5oi+sem2mknf2Hztp1emYuv9c=;
 b=aC6AOQQBFGL+47iznNzAwmrGqbFDg1X/Q8nfzC3tZAU6XKLRL22JOx2+NDCwd3uo0d
 qpWcyILt5nRdo+u/8RrIgJtYwk4DOOXrOy2mJltG1tRUruluSpVWmkhOglezV8IBlfQm
 zpz66IdpxS7Kj4n8iom1o7aCtN9KW7jdMPXHs1V8hhQPoLdJTIH4jeCNwyFoUJNWo1Hy
 j2gY0RhoWECZkbud7VReyXzAkor/2WKdcwLUX9wlRcQa1qdfKL2W0snk9qsr3D+1SuGr
 AvFMDQnhlxXVK9C20W1jT2VqGQuVZokwH9jHiHACLqZryBCIQ7/C3rKUvMCiqalocUWB
 xHkA==
X-Gm-Message-State: AOJu0YyM73jS0SuIidzuMEi8VWcS9H/O5ctjSuZwoOBg+govmSoKJPp1
 gLQ8fBi0t3e57iry7RhoRFXdAQiJuQdC2Tt79FE=
X-Google-Smtp-Source: AGHT+IG3rTgMI/Q+70LR+DFC6c3Uj0yQnP/ctkAjxuCj5BQP8B6C9sQpZYpdDvEHmPEjeQuCRKOK7A==
X-Received: by 2002:a17:902:b907:b0:1bd:d566:cd92 with SMTP id
 bf7-20020a170902b90700b001bdd566cd92mr9535292plb.63.1692822227364; 
 Wed, 23 Aug 2023 13:23:47 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 21/48] target/openrisc: Use tcg_gen_negsetcond_*
Date: Wed, 23 Aug 2023 13:22:59 -0700
Message-Id: <20230823202326.1353645-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index a86360d4f5..7c6f80daf1 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -253,9 +253,8 @@ static void gen_mul(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
 
     tcg_gen_muls2_tl(dest, cpu_sr_ov, srca, srcb);
     tcg_gen_sari_tl(t0, dest, TARGET_LONG_BITS - 1);
-    tcg_gen_setcond_tl(TCG_COND_NE, cpu_sr_ov, cpu_sr_ov, t0);
+    tcg_gen_negsetcond_tl(TCG_COND_NE, cpu_sr_ov, cpu_sr_ov, t0);
 
-    tcg_gen_neg_tl(cpu_sr_ov, cpu_sr_ov);
     gen_ove_ov(dc);
 }
 
@@ -309,9 +308,8 @@ static void gen_muld(DisasContext *dc, TCGv srca, TCGv srcb)
 
         tcg_gen_muls2_i64(cpu_mac, high, t1, t2);
         tcg_gen_sari_i64(t1, cpu_mac, 63);
-        tcg_gen_setcond_i64(TCG_COND_NE, t1, t1, high);
+        tcg_gen_negsetcond_i64(TCG_COND_NE, t1, t1, high);
         tcg_gen_trunc_i64_tl(cpu_sr_ov, t1);
-        tcg_gen_neg_tl(cpu_sr_ov, cpu_sr_ov);
 
         gen_ove_ov(dc);
     }
-- 
2.34.1


