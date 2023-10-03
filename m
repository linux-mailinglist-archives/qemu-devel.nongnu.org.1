Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A297B702C
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:44:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjRQ-0003Vk-B7; Tue, 03 Oct 2023 13:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjRK-0003Jc-7Q
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:44:10 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjRC-0001Mq-9a
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:44:09 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bf55a81eeaso9540145ad.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696355040; x=1696959840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NEOYlvNiNykkHb1IACDZLQQdADZPDVgjmBd2iBtQlqg=;
 b=FYBkqWyKP2u5dUcEIMNUJn+uYh5zoiPmHwxNyDrX1A2KGzbPxvYXywXWHl18CfLI2N
 fDEuKGDnDfM3znhqq8YaYNuouNIRF/UEVW0OJzxskMhvQtWRUAkxj/73W8yV5L5EFULe
 NdTWNDqSbJtRBCNyYkx8JPFqsJQGQ4m891kdTmrl6+yFJAzeC/nOnihZBavqTPupi2gD
 WjO9258I2UR0RRW8r41tH0DDpSoy9I/Zz8frJAt3qu+hSQxNxMSLqVgvKoSljWXg4GAj
 LLpwDFunoC4pV8jVKSEwzzF7aboB0nvzCgU1YDWOSipgUTdsfn9z0tO37LZKpA31KIOD
 atKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696355040; x=1696959840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NEOYlvNiNykkHb1IACDZLQQdADZPDVgjmBd2iBtQlqg=;
 b=RVfokzNVY05ugxOTh09oU50UxqsjVTd9VcxxzMlwDJmLAsf0gg6glm3LQZ1dK9p5Jr
 tXVY8F3TvJhpsn2WOUhqT2SpOyfZ1TBai0N8wsKg1yt//DlzGIEa5KZ/NsNJJ+kYOP+0
 NVJrp2giP0myKWUQaZJNqHVeQi049/vrx/3bSkj9+cZOfzfe2XGU7MVbNMpwHNWkzX6P
 vW97qbK6beod1bQunlpHiNo+uVd0AF1RjEsxtOJiQdAMfs1oG2fVrWyFw45VPEv1tBrM
 69yQVMr5Ky2O1yo8iu0TKPk55Pes8L/h3xBXKpWqQ4a6o/L/bCUvUYSSTu4J+k+LlMwE
 wpXg==
X-Gm-Message-State: AOJu0YzHeN9ZFnVsf4dULL6Aaf/E1Qi7tCcXmWA27pE6JMBThORPRcOU
 WktH3F03jS3XCrj6vwBES+RIGq2DwB5rEHmOIJc=
X-Google-Smtp-Source: AGHT+IEp1Uyii4hCw44c8wJT7VbRnXvby0PYhsFxR0rYYzgGD4660JQF6IFizJ+cVyOxbvubCeDhTg==
X-Received: by 2002:a17:902:ab13:b0:1c3:eb95:2d27 with SMTP id
 ik19-20020a170902ab1300b001c3eb952d27mr301629plb.48.1696355039767; 
 Tue, 03 Oct 2023 10:43:59 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jg2-20020a17090326c200b001c32fd9e412sm1876466plb.58.2023.10.03.10.43.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:43:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/10] tcg: Provide guest_base fallback for system mode
Date: Tue,  3 Oct 2023 10:43:48 -0700
Message-Id: <20231003174356.1602279-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003174356.1602279-1-richard.henderson@linaro.org>
References: <20231003174356.1602279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Provide a define to allow !tcg_use_softmmu code paths to
compile in system mode, but require elimination.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index e753387690..a841844eba 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -178,6 +178,10 @@ static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece);
 static int tcg_out_ldst_finalize(TCGContext *s);
 #endif
 
+#ifndef CONFIG_USER_ONLY
+#define guest_base  ({ qemu_build_not_reached(); (uintptr_t)0; })
+#endif
+
 typedef struct TCGLdstHelperParam {
     TCGReg (*ra_gen)(TCGContext *s, const TCGLabelQemuLdst *l, int arg_reg);
     unsigned ntmp;
-- 
2.34.1


