Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDCE783E8F
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 13:05:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYP9i-0006Rk-Fx; Tue, 22 Aug 2023 07:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYP9I-0006IC-F9
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 07:02:13 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYP9F-0003Lm-0U
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 07:02:12 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fee7b7689dso26073975e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 04:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692702122; x=1693306922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=emowz0axu/kGB6eTmVL35kBP/OFbuZg2HRDsrnbXrTA=;
 b=HJp2t9c41grX9JI1wNgMU9cHLkvXsxLAxm54fboaHuOiSqdzi2jm2DWq/MTHvWe/Q0
 Ft0BQIkNxlqpSyxNB1GUIeXD3vU8F+OCGTucV93L0CUFPP6PGjvE59H1ISjgpw7GI3NM
 2ZXvCUW/O200mQBVJfOyi4sLgj/JE2/HcQ7q0uysG9kMkI1GOijtFGZ4PgBJ4N86XLmk
 iJf1Rrnhkd5hvHcf6jjcLCLOrgq5hVV3a267Vj4ZDuEqjVip+fCBoSuH+OibkCcmSTJi
 nyuKqDsV1twNMhJXZDeGObB4O+g8gLcmnG1HUTsmSuIoc+SfPlgdMYQftsTKAW978mCH
 PiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692702122; x=1693306922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=emowz0axu/kGB6eTmVL35kBP/OFbuZg2HRDsrnbXrTA=;
 b=aD/SpqE6IeT/wRmZ976jgeUlphR2P0g8Lcap54AhSAo110Fhzbb3uijwqR421tD+cM
 V/mdduhFWg8agYO8Bm/RkGtyLDgf6XkLhTpEn6YwPFP7YNulKmyOPV6Cee29eYOya0HM
 1DTGUkC9ggoGhyPC6I3Lp4yREGiwnUDA7lN+YgEn4p0F2IYBuTRo87MFIMlmwVsPDtB9
 qTqPKcZnhspbTy81CG9tbMXo936nOJMyMKEgPoOHYIXDfO55cQK2z2EVoOX6D6b4KEYe
 dqYueyosNzCKXRaCSYaFo5iYlidY0kZJcUIoLmYuQyTngFEcgy0hA0KTP+45m9RJ8fHp
 9f5A==
X-Gm-Message-State: AOJu0YwEjck6rf9pKvjx4UL/pyLQkFUHtCIOO0LNaCOUfESmQW/7DZVA
 jWmJbGjVpDCK4AAFe7MGhbOyfMO7WRHjXrguCg0eyw==
X-Google-Smtp-Source: AGHT+IETBfQHdP04sxGZX7f13LGNmP4+AxrjuJsRMH6s/vZmIblKY9X0YJsBFCdwykcPC8avxpBhPg==
X-Received: by 2002:a5d:58d9:0:b0:31a:d344:38eb with SMTP id
 o25-20020a5d58d9000000b0031ad34438ebmr6621664wrf.45.1692702122703; 
 Tue, 22 Aug 2023 04:02:02 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 n16-20020adfe790000000b0030ae53550f5sm15380844wrm.51.2023.08.22.04.01.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 04:02:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>
Subject: [PATCH 4/6] target/sh4: Use hswap_i32() in SWAP.W opcode
Date: Tue, 22 Aug 2023 13:01:27 +0200
Message-ID: <20230822110129.41022-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822110129.41022-1-philmd@linaro.org>
References: <20230822110129.41022-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Commit 46be8425ff ("tcg: Implement tcg_gen_{h,w}swap_{i32,i64}")
introduced the generic hswap_i32(). Use it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 49c87d7a01..0f96a099b3 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -678,7 +678,7 @@ static void _decode_opc(DisasContext * ctx)
 	}
 	return;
     case 0x6009:		/* swap.w Rm,Rn */
-        tcg_gen_rotli_i32(REG(B11_8), REG(B7_4), 16);
+        tcg_gen_hswap_i32(REG(B11_8), REG(B7_4));
 	return;
     case 0x200d:		/* xtrct Rm,Rn */
 	{
-- 
2.41.0


