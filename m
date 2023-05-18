Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB947081C7
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:52:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd6T-0004Cn-26; Thu, 18 May 2023 08:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6B-00048k-Sh
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:19 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd67-0007w6-IE
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:12 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f41dceb9d1so19555945e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684414270; x=1687006270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=71bqprvJHFwaprTBPUqH8YYr/a1cVIn1wiv2+BaYT4w=;
 b=XxhhaI73zrKQLFUp0bAKtZlL+vGjWTJ87alMItSmwVZ4xEkcELr7i88BQSVYhnoF/5
 mw8ISmByqZlfjYGamX7TJnnsHUDKxntwBkRfhz8UI0PmXXfBueJ1mTXsPREhP7WcyRLx
 ubahybu+3KACBoMj8JjtmkNQmWxwDvhrAhyH/jwPcPPS8qOY/clr4zhOIwYGrfaGTxn7
 kzA9pC8KTbBIkHcmK3R1eV9MqWkHnXSNMp30H4mXE6LX4bLeuFXa2hoMzMQDj68FlTdb
 CJOlejLDeLnUsBp60Q08+tkQtelsxcKtIOrb+qCQRK+b2CYFf75xklT2dKYhyfEz1qDr
 3psA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414270; x=1687006270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=71bqprvJHFwaprTBPUqH8YYr/a1cVIn1wiv2+BaYT4w=;
 b=hgMg8tsn/j4qurNPl3EbxEJWPJ+IVIk6hZ1XkNu2FjKtPnO+VmdlhQsbgJp2NGVoJ+
 pB/WrAUbXsAJUmQLTSGjw0r7yMLXo+mTmLsgIR2BOWYHsnx1FstxLCni7j3iNu2QyZNy
 qksx73WqfGIdiSbGeOCE2MruAz/Szjq1nXOvBiDdTY2Y0pPuEOa+nWq7asifyzdz215b
 a1YJCbeMe9xVyxI9D8DHrgyFNPEhL0UxRBRoWb5qZ/2drpaxmYlrww4TD9QRjVTSAOQA
 DfV0kL762k6Wir8Lp/1RbSBPbfIoPE6SttrQeIcg1+6sTO8JHuFOiIPXcTXYZ3ZyUmES
 +HVg==
X-Gm-Message-State: AC+VfDwSGbJGJgB0NV5I8e7dR6M1lTnNWZMu+dZrI0PENOziaPwcoaA8
 be5dwPjoG22BH1A7cb9FjXmKEHGFcZp0bznWMls=
X-Google-Smtp-Source: ACHHUZ6Dkm55MfVU8Y0gWVYIqoRcqiCa89NT3pjxNLn5FdqSWGBzXX0LuPVYOx7P7RbGWFAmckYeZw==
X-Received: by 2002:a1c:7910:0:b0:3f4:f0c2:127 with SMTP id
 l16-20020a1c7910000000b003f4f0c20127mr1577334wme.22.1684414269989; 
 Thu, 18 May 2023 05:51:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a1c4c15000000b003f42d2f4531sm5201321wmf.48.2023.05.18.05.51.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 05:51:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/29] Maintainers: add myself as reviewer for sbsa-ref
Date: Thu, 18 May 2023 13:50:41 +0100
Message-Id: <20230518125107.146421-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518125107.146421-1-peter.maydell@linaro.org>
References: <20230518125107.146421-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

At Linaro I work on sbsa-ref, know direction it goes.

May not get code details each time.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230515143753.365591-1-marcin.juszkiewicz@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 50585117a0b..d0e604c725d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -940,6 +940,7 @@ SBSA-REF
 M: Radoslaw Biernacki <rad@semihalf.com>
 M: Peter Maydell <peter.maydell@linaro.org>
 R: Leif Lindholm <quic_llindhol@quicinc.com>
+R: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/sbsa-ref.c
-- 
2.34.1


