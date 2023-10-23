Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A16897D3BE6
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 18:12:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quxVo-0002Hi-Vi; Mon, 23 Oct 2023 12:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quxVg-00021V-Q9
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:10:33 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quxVf-0001q9-8H
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:10:32 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40806e40fccso25619095e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 09:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698077429; x=1698682229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a2aDD8+H4pT9uJ8J9/1URUzXa0n+4QaQuTomlnp3aRg=;
 b=bHr8z2B/HuIiNG4o6s2w86Ib2aACq8iXQJTZe63HTZYW6mBR9KH2JxRalvNE3+je0B
 ygUKAJlN9QfmL5eqP/q7/1xm++9by6QoPg4CfYwcOwEX74u8eyX3WeCLCina9z0OYhZt
 U2VrkdVU9zhoHNmVylk0dH6u87kCRgfAeTFVOgEUcVVYYfm6IzViff19NBSWetuJvmI0
 i7ZtaJ0j6WGaYbk80+t9r96oMqg5aYTM5j4nkkE9pRkAf2HpEgbxuXRd82PtCP9NQaF6
 ZUmP/XEMhDKHKqlLSRu8KmAmOJjroEcmGOG4OcuwnQzO/ScZYAsyVvH7+XLBTDa2hSDc
 aFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698077429; x=1698682229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a2aDD8+H4pT9uJ8J9/1URUzXa0n+4QaQuTomlnp3aRg=;
 b=nWCnkXw5/8zJOesa8afn0kxWrub0UI+twlqz+JFayluKNs+9gU1LVB1hYkzlzEPYAR
 R5OUYSE6WShF+c8LvuvuPbPDaIVgvhriYVbNesFFOuELuetBagE6IEER3tu/ip+jovBT
 5sTDQ4Y7yaAfdUbo59UQc2SrlOJ3dio4KqijXbHy1j0LvUJN/EKanwc39m3Gf1hb59kb
 syP4Nb9wTC2ckZq/w2Ciqxf6HbqPQTTwKyDUjATkakxtaLefrHqJR2Qv4zq3lcPI7bAV
 Wf794VIKjF6DvAivztiKyM8zRtbu9blszSDNK+lXNVqEywdPKvn07lz+8FRn+bQxxYJD
 h1PA==
X-Gm-Message-State: AOJu0YyDpshUHrD/tjOjillcz9PuNSYRS/BdMQkJmhbLy1FGWdeOW/TK
 cmn2rThzYkLLt3+SJMZiZgpt65X7ytLsJAdmcRI=
X-Google-Smtp-Source: AGHT+IGyxlslxmuuWR3XfBqtnk0k7LrWPFsSRN/cVZslLVJYfoR79mz0DBOukJwhXJuc2t4lMIeJng==
X-Received: by 2002:a05:600c:4f12:b0:401:bdd7:49ae with SMTP id
 l18-20020a05600c4f1200b00401bdd749aemr8370112wmq.18.1698077429362; 
 Mon, 23 Oct 2023 09:10:29 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-216-159.dsl.sta.abo.bbox.fr.
 [176.170.216.159]) by smtp.gmail.com with ESMTPSA id
 c16-20020a05600c0ad000b003fee567235bsm14511150wmr.1.2023.10.23.09.10.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Oct 2023 09:10:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PATCH 7/9] target/mips: Use tcg_gen_sextract_tl
Date: Mon, 23 Oct 2023 18:09:42 +0200
Message-ID: <20231023160944.10692-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023160944.10692-1-philmd@linaro.org>
References: <20231023160944.10692-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Inspired-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index c517258ac5..6eb73256b2 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -3840,8 +3840,7 @@ static void gen_mxu_Q16SAT(DisasContext *ctx)
             tcg_gen_movi_tl(t0, 255);
 
             gen_set_label(l_lo);
-            tcg_gen_shli_tl(t1, mxu_gpr[XRb - 1], 16);
-            tcg_gen_sari_tl(t1, t1, 16);
+            tcg_gen_sextract_tl(t1, mxu_gpr[XRb - 1], 0, 16);
             tcg_gen_brcondi_tl(TCG_COND_LT, t1, 0, l_less_lo);
             tcg_gen_brcondi_tl(TCG_COND_GT, t1, 255, l_greater_lo);
             tcg_gen_br(l_done);
@@ -3876,8 +3875,7 @@ static void gen_mxu_Q16SAT(DisasContext *ctx)
             tcg_gen_movi_tl(t0, 255);
 
             gen_set_label(l_lo);
-            tcg_gen_shli_tl(t1, mxu_gpr[XRc - 1], 16);
-            tcg_gen_sari_tl(t1, t1, 16);
+            tcg_gen_sextract_tl(t1, mxu_gpr[XRc - 1], 0, 16);
             tcg_gen_brcondi_tl(TCG_COND_LT, t1, 0, l_less_lo);
             tcg_gen_brcondi_tl(TCG_COND_GT, t1, 255, l_greater_lo);
             tcg_gen_br(l_done);
-- 
2.41.0


