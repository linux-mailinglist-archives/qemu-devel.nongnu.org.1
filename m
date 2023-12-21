Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C58DE81AD46
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:23:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9eQ-0006lY-0u; Wed, 20 Dec 2023 22:23:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9eN-0006cf-67
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:23:07 -0500
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9eL-0006kY-E0
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:23:06 -0500
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-67ee17ab697so1995916d6.0
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128984; x=1703733784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=b/6+wUvz6WQxJre4NGPMzqEP8t8qfLRBNDzheCSvrJw=;
 b=jeuvu6gRjAe6SuDFLHnZx2eUmVCEUq0v9UuA8eYUhHCdzinoepPSIs5ZyGxjHYFn4Q
 UGwpZCkD2mM+ev0PDju72QanBf21y3Z5SClw/HMsL+DbBMjbiKmh1Q82IzDbViLsk7Z6
 t0bjDS2FlzWhgSmVxOpr/JFDnqxbqyGfDaYFpgqfVGrec7/wM7Bz0GVDQUPeFltKSy6C
 YkDTvc/OU3m+Eesv6c0IctlQkpHiwKcfCgvbPnCBf1dNEefmCl3U9KyJUuEMcLarWDNr
 ibSinGmsuRD78aPassCw3JWt2rzLnQshGgf6ubDDAC/+55KeafGek8d8hp5fD6SSG7Nu
 +51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128984; x=1703733784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b/6+wUvz6WQxJre4NGPMzqEP8t8qfLRBNDzheCSvrJw=;
 b=TH1lJOif0BUiaoLM/oWeg+3vMSFJj9wqhrIDUlOdDfG0Wufy6IthyD0cDdT76mE4pF
 /mcWg3WGS2/7ze21b7BdGbykC9Rt9CbJ0GZAmPMwjVJSk5iAampzUJuTeArDMWuKmXjO
 k1W7mFYnActPXtqXeIaOXpcxSzOHc/RLnEjbjHDigq8lgqFQh6iVqLE2rXFPnfeQbkI+
 UnHSOAtiifTRAnV12feIntNRhrII1F0I2JcCE7Ck2/wSrOwO5/mp+nZ3rXrr2UvCCewI
 X8VtraGYIFQU15ymMSl0IdGn8BzvFcMLcNKG9HP/RZrCGAAuyYeKy5iYnLBiLbWBY4Kt
 epiA==
X-Gm-Message-State: AOJu0YwhBSTA3cGtAvVoLOvxW71pFtMrlV+q0+a42OQN0wylrhgUwNFv
 61e9Hz2o7tR3x8C6BLQCYAL9d2zDRdPn+pfgyMifHZlz
X-Google-Smtp-Source: AGHT+IFmJ10qndEeCz4bqd/5jTjd8HMCdYSZHmA7Ycbt/RRzbXUR4C0Zg1+VVcAjaaJSv1d96PdPaQ==
X-Received: by 2002:a05:6214:f24:b0:67f:3cb8:88bf with SMTP id
 iw4-20020a0562140f2400b0067f3cb888bfmr9797554qvb.62.1703128984422; 
 Wed, 20 Dec 2023 19:23:04 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 l16-20020ad44d10000000b0067f7b6318b9sm347257qvl.10.2023.12.20.19.23.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:23:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 43/71] hw/openrisc: Constify VMState
Date: Thu, 21 Dec 2023 14:16:24 +1100
Message-Id: <20231221031652.119827-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf35.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/openrisc/cputimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/openrisc/cputimer.c b/hw/openrisc/cputimer.c
index 10163b391b..835986c4db 100644
--- a/hw/openrisc/cputimer.c
+++ b/hw/openrisc/cputimer.c
@@ -145,7 +145,7 @@ static const VMStateDescription vmstate_or1k_timer = {
     .name = "or1k_timer",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(ttcr, OR1KTimerState),
         VMSTATE_UINT64(last_clk, OR1KTimerState),
         VMSTATE_END_OF_LIST()
-- 
2.34.1


