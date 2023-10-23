Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD117D3ED9
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:17:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzRE-0005jt-TW; Mon, 23 Oct 2023 14:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzR6-0005cO-MB
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:57 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQw-00089r-9o
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:55 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6b20a48522fso2904354b3a.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084824; x=1698689624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YGlbtLg90LV1uY25eQEYhNteHi+RQnuiWgmb0RTVS6Y=;
 b=yo8Quzg4fhJuqGKXoXmb1KcezsIoY1RzKzhroa4fEjgaq4+hMqVCRPo/yWV7ynNSkf
 baY8ylj3lHKvEqakH1dMeNlgl9N/olXGDbnSPRGUjVkpb1jG+4GqnTU6d21KJjZ/nXC0
 Dn0wCFg3x7dSI5tP3uXT80yEDyKqoYyjpb8BmIRQqngq6BFjIgsUtxEDDfEnal1njXee
 1bUBax1R95Nfn+23PT9re2YLvcthlTxwrVfM4uX7IW73t5EQJnRs5ABRjNYF+lgykIzr
 QciyrrF2Vunp1vvcqganwwmJNrFp9NF7SlFyjJsfi/0D2YKj2KPg1IAl4mEni15WEkBY
 kqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084824; x=1698689624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YGlbtLg90LV1uY25eQEYhNteHi+RQnuiWgmb0RTVS6Y=;
 b=LDP+pIWYSM9oUOlnZp+bJz8ek3JP/+BpEtQ+NgkWTmdBPyeehA1+O+OF2aaKWWCKg1
 PAlg5rzDYXyRdbDRjarCGwSUzMR+qqTN+nCgoPhmFPBJ10ZVA6+mhjAHKCby2iZtyXhD
 xTGqNEgZZfpNwJBSqU+V0hi3eR5KSIIP0nftXIcvEqESCInBllFMOUqwM4HCSPv38EzL
 xsPuD/9hPFfcGr9JAwdnrKZPi6Kbk7A1EW5UAh33748H7IAdr6UCMF9ar/oUJFMj9ifM
 JLI2ees1xKJOiYQk9Ts57qEMtqdgwCoxXTbxFKyi8LUdO5qlprD5NVDTjF0+198irkIV
 gs+A==
X-Gm-Message-State: AOJu0Yy+24Qrmq3XS++Z1VEvaXsSNbksgTTU3EYVsC0f9htvFfNyPgdY
 Bz7CrFdkvSOS5KGncfnbmAW1O6p4LabEU867OTE=
X-Google-Smtp-Source: AGHT+IFJwRJBxvmeT8khxpUISFw1j4ggyiz84LH5BivBxeYSFVUMq+xmdJSVl6yzCKSYiEzVoep5hQ==
X-Received: by 2002:a05:6a20:3956:b0:15d:c274:2eb1 with SMTP id
 r22-20020a056a20395600b0015dc2742eb1mr476907pzg.10.1698084823859; 
 Mon, 23 Oct 2023 11:13:43 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v3 15/38] tcg: Provide guest_base fallback for system mode
Date: Mon, 23 Oct 2023 11:13:06 -0700
Message-Id: <20231023181329.171490-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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


