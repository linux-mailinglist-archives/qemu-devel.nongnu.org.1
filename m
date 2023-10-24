Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 264647D5940
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 19:01:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKl0-0000d4-KC; Tue, 24 Oct 2023 12:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKks-0000bx-8N
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:59:46 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKkp-0002re-37
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:59:44 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5384975e34cso7438940a12.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698166780; x=1698771580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tnvgobrgvZ8fCptCv+JHpeuubvqilC8RCHSCmo0hdqY=;
 b=qrnu70PUE2+0AsIvz0zHDNlGRayobEuI6stphYkhhCcmvQJspRQKMBvOjTpxgMhQuH
 vog31loLmA6oGyoWnXDE/nRxqeYBTs64LysqrVqnYTXGYO8sYfWRhN/Yr655SUwP/S4o
 hSmI/4nSi3XWJvII8T2IhXJTG8R8vfS+pW6Lpq5hbz9moH8pBiigVRSUNjStMm+2J34g
 2wnuqWLt1DPEF93krXcdMcDoSwcx/fZ/t41U8eAPBxWDqPyco6kFWVIElnhV7LVbbZhh
 oXDXNnwPXlNpoLGz2d4SvRmya1vc9y/AlMmut9BHexejluIbmVcXJVyes7SYA0S6q3IA
 M9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698166780; x=1698771580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tnvgobrgvZ8fCptCv+JHpeuubvqilC8RCHSCmo0hdqY=;
 b=XDsvoT8u+9kmaWVnjsmZUWkpSYfcoAjCIM1O3T/afxbyhHBpXL9B2OuK4DG2MNXu4B
 ujZUrV1IQWfCCiC7Y+4ZffhNMLFS+XtBKM9MxH3BBBpuff4jzBMvSBya3tx0UFGe67Yk
 8q/HG7Y7H35iyfZ3GNYwSjNu5CF8UicLRV8TBGjuVxrvDpnUE2I3mvcq8MkV995hw8dI
 7HIlzdqtCFfO3daefeLtkLUbNg0bfAHvPfA831wDKavZS84gzmtznjMT/H085kGYXzyN
 Wmqu7ng5HVrdv8WGx0OD0z4yDuyY+gquKEK4KLvYaa1nvp7ZBV+kDUxCxQse1bYLSTf7
 j4oQ==
X-Gm-Message-State: AOJu0Yxg/NwpY7Ef3RN5wlGLQM503d1IqEeMc/WAxFRMP2wSSIb1Dsm/
 9Uk19kNoUr7U6HINjNY136nsbQigQ3qOxcMIMGA=
X-Google-Smtp-Source: AGHT+IHTnsakk7LLb3ZO7giYZQ/sk3EWFFW4gIFsmqwghtIXyRhfs1oQWe89u5KeoOJ0X0zz+aHIpQ==
X-Received: by 2002:a05:6402:3589:b0:53f:1ce2:a3ac with SMTP id
 y9-20020a056402358900b0053f1ce2a3acmr9985936edc.41.1698166780278; 
 Tue, 24 Oct 2023 09:59:40 -0700 (PDT)
Received: from m1x-phil.lan (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 n28-20020a5099dc000000b0053e37d13f4fsm8317919edb.52.2023.10.24.09.59.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 09:59:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v2 6/9] target/sparc: Use tcg_gen_extract_tl
Date: Tue, 24 Oct 2023 18:58:59 +0200
Message-ID: <20231024165903.40861-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024165903.40861-1-philmd@linaro.org>
References: <20231024165903.40861-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

Inspired-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index f92ff80ac8..16d9151b90 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -740,14 +740,12 @@ static void gen_op_eval_bvc(TCGv dst, TCGv_i32 src)
 static void gen_mov_reg_FCC0(TCGv reg, TCGv src,
                                     unsigned int fcc_offset)
 {
-    tcg_gen_shri_tl(reg, src, FSR_FCC0_SHIFT + fcc_offset);
-    tcg_gen_andi_tl(reg, reg, 0x1);
+    tcg_gen_extract_tl(reg, src, FSR_FCC0_SHIFT + fcc_offset, 1);
 }
 
 static void gen_mov_reg_FCC1(TCGv reg, TCGv src, unsigned int fcc_offset)
 {
-    tcg_gen_shri_tl(reg, src, FSR_FCC1_SHIFT + fcc_offset);
-    tcg_gen_andi_tl(reg, reg, 0x1);
+    tcg_gen_extract_tl(reg, src, FSR_FCC1_SHIFT + fcc_offset, 1);
 }
 
 // !0: FCC0 | FCC1
-- 
2.41.0


