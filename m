Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E092D7829D2
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 15:01:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY4X5-0000pm-7l; Mon, 21 Aug 2023 09:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY4WC-0000JL-V4
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 09:00:31 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY4W7-00018W-LI
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 09:00:26 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fe12820bffso32873885e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 06:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692622822; x=1693227622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BKQfb1Masg0LUXafLP8DDVqoNx75e63Lg2kg56KHPJU=;
 b=EPfeNXFdRxPD+IEi1EH5vbxv/Rxb3+w6X1qydqFslcvxaypRHVXWPW8nurWtgYScs4
 gIxGKMnqWajKkMcEg1W/zqOfSTfx7urUCVNiz+kGRDVQ3JC4wbjcPZs4S6HbwXDJ/XGX
 ceERdWsI1Z69sf2g4ynrlydfSwH2AjV8f4oW/gt2VMXIHOmHPokVXGwrZogk+HwsqPMw
 m4zQqV5uorRwNQm/qhIlYv1HN8FRKVuCruqiPHbJsPO4eL/31dcbbg4wg8/p0zO8ZmWX
 pdJeMVGFu8TQD8LWbFfDZbur7g3+PEHrKO78j7XKolcZed/8/LwUolI+Cff3sSVZiJEJ
 8Ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692622822; x=1693227622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BKQfb1Masg0LUXafLP8DDVqoNx75e63Lg2kg56KHPJU=;
 b=aRghPR4DYm73ng1D3BkgqQQD3dcIh6QUGvbYzwMtnV/3l3UD/TM9oFQrql5GJjk/2I
 oDTgQi8ggSqtCTs1ZdpDZOfpeARxvuRaQLndCqPy4MjrVrIheb1h2UrebtdbLTUaxtWn
 IkZbL2RiJNwTFSek8wySKfQZ2RoMxFFj0RvRGj1/+9xPqyOkKJ5453sfzGOZmQtyMrOi
 5NhkkYnXehVU7S4fLsYF7bBb2M+E5gPbwXu1zmHAWA9AO1D7A9H/3OetyLTxHXORWhxP
 bZnlShv6pbJy6DO3twbj+SCekBOnPFwmxVIh7caipXk7JXlVZjTkmYCmszmj3ovMfpE2
 Namw==
X-Gm-Message-State: AOJu0YywNIqk8ub9IaN2eXF0kjh8PM1mhrW0vNeXdyUl8w1DlOPmKBWo
 thgQJORoy8zYmQaEJd15+INJ2Mcu0XuxDs1FLiU=
X-Google-Smtp-Source: AGHT+IFn9WJ2CO3DRc/8z7nyeiN9VLw1AvwmTgz8yhgDYVrfw7Mb0VStUtaJX3Fgciweb9riB4szJw==
X-Received: by 2002:a7b:cbcb:0:b0:3fe:34c2:654b with SMTP id
 n11-20020a7bcbcb000000b003fe34c2654bmr4988052wmi.14.1692622822071; 
 Mon, 21 Aug 2023 06:00:22 -0700 (PDT)
Received: from m1x-phil.lan (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 f15-20020a7bcd0f000000b003fe1c332810sm16202208wmj.33.2023.08.21.06.00.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 21 Aug 2023 06:00:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Jiajie Chen <c@jia.je>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 3/8] target/loongarch: Fix loongarch_la464_initfn() misses
 setting LSPW
Date: Mon, 21 Aug 2023 14:59:54 +0200
Message-ID: <20230821125959.28666-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821125959.28666-1-philmd@linaro.org>
References: <20230821125959.28666-1-philmd@linaro.org>
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

From: Song Gao <gaosong@loongson.cn>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230817093121.1053890-11-gaosong@loongson.cn>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index dc617be36f..a1ebc20330 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -391,6 +391,7 @@ static void loongarch_la464_initfn(Object *obj)
     data = FIELD_DP32(data, CPUCFG2, LSX, 1),
     data = FIELD_DP32(data, CPUCFG2, LLFTP, 1);
     data = FIELD_DP32(data, CPUCFG2, LLFTP_VER, 1);
+    data = FIELD_DP32(data, CPUCFG2, LSPW, 1);
     data = FIELD_DP32(data, CPUCFG2, LAM, 1);
     env->cpucfg[2] = data;
 
-- 
2.41.0


