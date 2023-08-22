Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F5578415D
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 14:58:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYQxU-0004Lj-6A; Tue, 22 Aug 2023 08:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYQxQ-0004HS-No
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:58:04 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYQxM-0003Rt-Qb
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:58:04 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fe4cdb72b9so42516835e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 05:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692709079; x=1693313879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pHBA30PSCUnBRne2oNj9oNGhYXtpgOXc/MJu68ppsA8=;
 b=G2Gy0yMoT0DkNP8xD2JzjgaNH0X8wtgfafL8lDh8T8kPEJCV7eHDS7VB3wcI8EKff1
 gy6y9Q2By7tDkMlfZH/SjypJchmOuOAqYvCEUklIAzpKoTmHDEk9wGt0vVrBHOueEFFV
 8F/zEUyR/LE6r2xc7D/vNkfmbSrjGYA2gEmYPfbXAyp2abQqrEXfXscIOMD21v8XnyW4
 Ga8zcTnxn1iSNkfz3hhWaMd3mTOSfgoA5HN7BB72qTknto4wupucc2aqdu2GzDuUyPTv
 XtWeJNSPkuMD1gfB/yYOQk4rB2ZPKKZBSDkWCdVcvzFyrp2NEY+hyQ3DPN3MVcdF+Cam
 cPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692709079; x=1693313879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pHBA30PSCUnBRne2oNj9oNGhYXtpgOXc/MJu68ppsA8=;
 b=eCo8KJAn/9WJsBzlJbxRiv+OC4GZjWIV45m2PLxry+Fa/Pl+AqFpYQANTPSr04a4N9
 E5D2Q8HuSu09jjiSUmTfAjaxS1RpZvAnEzEcLEI9DtpZlQbr3IRy0wr8HLhPk+6MJnir
 ro9d18nfW4ptvWzjgZmg7Mlpltlic0qpa/gsevb0DAm1ZIh1ty+WGRCR2QcqeHrM7lOz
 CX5bOYJCHjSpu/FBNOPnA4NGnZ+r87wzLWUVbRU81bLNrDndFf8Zvf2lljgm8qBRDyrx
 4UNerpD63KuMT3gFBHesNVC7WNkPAiGW2nm2HLG6zrVGwt2DMniGUg42dZUIOYpQ03gG
 zavQ==
X-Gm-Message-State: AOJu0YxnU2iQhbnBTy6l5S+TPyWhnk+GOvhukdxpQPUbn3OdZgSMeVvP
 yHXGyfwLm5quSvl417W2ezBpWjpQQORda5xGDoBO0Q==
X-Google-Smtp-Source: AGHT+IFgfMuvk+8hHVZhZ0sBG+3IoM5LC+cqghN7zamhwQ5Gy8no9ql043z0jNALw/gV1KEA2a6XFQ==
X-Received: by 2002:a7b:cb41:0:b0:3fe:1f93:8cf4 with SMTP id
 v1-20020a7bcb41000000b003fe1f938cf4mr7508972wmj.8.1692709078966; 
 Tue, 22 Aug 2023 05:57:58 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 z9-20020a7bc7c9000000b003fef57e64c4sm3780056wmk.25.2023.08.22.05.57.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 05:57:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Greg Kurz <groug@kaod.org>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Nicholas Piggin <npiggin@gmail.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/12] target/mips: Use generic hrev64_i64() in DSBH opcode
Date: Tue, 22 Aug 2023 14:57:51 +0200
Message-ID: <20230822125752.55328-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822124042.54739-1-philmd@linaro.org>
References: <20230822124042.54739-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 4f34ea9b6a..08ee745a6d 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -4936,16 +4936,7 @@ static void gen_bshfl(DisasContext *ctx, uint32_t op2, int rt, int rd)
         break;
 #if defined(TARGET_MIPS64)
     case OPC_DSBH:
-        {
-            TCGv t1 = tcg_temp_new();
-            TCGv t2 = tcg_constant_tl(0x00FF00FF00FF00FFULL);
-
-            tcg_gen_shri_tl(t1, t0, 8);
-            tcg_gen_and_tl(t1, t1, t2);
-            tcg_gen_and_tl(t0, t0, t2);
-            tcg_gen_shli_tl(t0, t0, 8);
-            tcg_gen_or_tl(cpu_gpr[rd], t0, t1);
-        }
+        tcg_gen_hrev64_i64(cpu_gpr[rd], t0);
         break;
     case OPC_DSHD:
         tcg_gen_hswap_i64(cpu_gpr[rd], t0);
-- 
2.41.0


