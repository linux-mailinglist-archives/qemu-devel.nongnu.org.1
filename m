Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 682847CEB49
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:30:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEzf-00089d-Cx; Wed, 18 Oct 2023 18:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzY-00087Q-9M
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:16 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzW-0002Ui-F4
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:15 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1caad0bcc95so6812565ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 15:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697667972; x=1698272772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YGlbtLg90LV1uY25eQEYhNteHi+RQnuiWgmb0RTVS6Y=;
 b=GexO8dz2NDh1NJv+wHDqTyyoLZtCtou9JYjSENpKgfr0HOANba2P6T3g9I4JPzWknX
 xVqQQzSs/YiqEdWBa8wWeSt97XuPkvWi53vKVzzZ3sVXlwtKrqhHOpTn8RDeUPrXgoL+
 SjrHNEivfquiUqACqjZ9VvX3e7CX0ujml6CKsvzMkEKMobVR9KgzZDNN7h5opLyG3saE
 Dkp7TpFsI2ZDjgvTZtTQatrQW8qjgz5d3kHnmfwDE0xeM6xJW1pAcqRv/2n2nQQXAxUq
 1XaUPjoG9BNGLWCdTZPrBRkKRZiWmhTi5cmCCAfnEZqHiAtgcJPweVzg5ewLK4T5FRXg
 fdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697667972; x=1698272772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YGlbtLg90LV1uY25eQEYhNteHi+RQnuiWgmb0RTVS6Y=;
 b=S40q64ooLaOKiHecFSTZ94gEGWiChr8dVSdVF6ik2KjVNVLYJHCdrSSXNejf7pRzhd
 vRsrlcRMH3srzOz4WSUCEzA3RDSadLguAwUOHKayAEzFmSlKgwm2lscPKM/bkh3VjdkB
 QBoW5j2RyMRMhUgbq+v15hShtNJlxemuBxv+y4UsNaDsBEFNyjrOGgcK6bxlfWA1HmU5
 xcsyWDiFcYHyq57moUpSiGeYq4ma6FjMWOMUqI7R3Pu47mZdkt7uah+bFxwe/8aGvd9W
 5DBIfsExfoNm7gcAFN/S51I8k9t0vGtaTN+ZFUyntzV7SIB8ZQ9pRHs4wfW5JBZMxm+M
 6FrA==
X-Gm-Message-State: AOJu0YwU+1k9KGjybQ57X4roK0zVhaIwQGuoJd6XHf8NBOkLrtgbIr18
 FR+52ZqQEjILziTaB0bGG/WThYchy18nY5ww408=
X-Google-Smtp-Source: AGHT+IF1C5bw6qmHlZa7boSd2ny2Yyuu0fdwpO6bD/x2DXRIGq7fzQZDJ7mn0aXFHzoNLr12ModcSw==
X-Received: by 2002:a17:902:d2cd:b0:1ca:87a1:cdf1 with SMTP id
 n13-20020a170902d2cd00b001ca87a1cdf1mr784920plc.27.1697667972614; 
 Wed, 18 Oct 2023 15:26:12 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001b9d95945afsm431058plg.155.2023.10.18.15.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 15:26:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/29] tcg: Provide guest_base fallback for system mode
Date: Wed, 18 Oct 2023 15:25:43 -0700
Message-Id: <20231018222557.1562065-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018222557.1562065-1-richard.henderson@linaro.org>
References: <20231018222557.1562065-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index d3a4a17ef2..35158a0846 100644
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


