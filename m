Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 249068201DB
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:33:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKQK-0000ug-I9; Fri, 29 Dec 2023 16:29:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKQD-0000BZ-Si
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:38 -0500
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPz-0000QA-Bf
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:37 -0500
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2046dee3c14so2357689fac.1
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885360; x=1704490160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ygcgPh+qdF+j3UM+Oeu3tve2dul26F15sx2+x6giXog=;
 b=Z8VjfRxM1+1PkLu4vyjI1ZsF9WSk17/rBE/Kld3rVku3CbBtJNsxpX7JS5FGeCiqGm
 4IQxcUaFUkNDMrI6HKofzvg5YL0a/i/a9qGGiV+9eZOFRRJO67dhCpqKXHoS0js744vx
 XjY++KoVLRID4Ve4gAGQ8XOOHOOuAO0HiVuIoXQS/J3ThYC6INrBmkCrzigeqC+5zqRp
 yZG0kRgOvFAIOBtsPE85sbcmPXHNb9HeLh+kcPv5LxX25IFbT6UlmOdj0xunbiJtVYaA
 WkJW2LxTD+58A4cJV2JbbOY5uYQAq/YCJaoCAANsVFG+GMJZ3HNv1/fwdEZvN85QSELy
 l9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885360; x=1704490160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ygcgPh+qdF+j3UM+Oeu3tve2dul26F15sx2+x6giXog=;
 b=amsolLofWPxZiDxkID0UNwD6ZYpqriuQ92uY8MeHfALoYkvhbo0K/hrkd2pghgOc9O
 O/fs62UI7KUD5Dh8qJp4yPvYSGcv2wdzqrOPJ5+rFgdZKG7Tt8prxDeOpKw5BGPvfCPv
 L7novQqZBt5nmL892T1E8l5/FA40Frzph17LJUECcqOavuQcNJbYld4Vazv9dsAoeQti
 jCIFyrOaMlyTbTBeHoumdBRRRkJKcmhcZvBYBE/K+UqnfrBKiCDk0CQm0sFpXa2Fn7dk
 sUqdFYS94wHvxPsfAXDFLQV0QAO0WFi7im7GHmlH/VnK4zUZJppYpmiR2mwBheBg407C
 MkFA==
X-Gm-Message-State: AOJu0YxHo00pmB+HRbkGwK9jHWfacRyqNNV+V+OmL1gaN2Ov73wyiLVS
 UURAEkTAFUVklLQBu/yyFyBa4mYEMW393VH17Ylybx2GhEsMYg==
X-Google-Smtp-Source: AGHT+IGK2jjC3PK0LkPbhWYXxdwcXed/Fv6fyYO1IZf8QscHJiVC6IHfRSFPKE7+fRUl+fGkQlPX4g==
X-Received: by 2002:a05:6871:588:b0:204:8d0:9993 with SMTP id
 u8-20020a056871058800b0020408d09993mr11150045oan.77.1703885360429; 
 Fri, 29 Dec 2023 13:29:20 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 bd33-20020a056a0027a100b006d9a96b7d0dsm11285396pfb.208.2023.12.29.13.29.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:29:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 63/71] audio: Constify VMState
Date: Sat, 30 Dec 2023 08:23:38 +1100
Message-Id: <20231229212346.147149-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Message-Id: <20231221031652.119827-64-richard.henderson@linaro.org>
---
 audio/audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/audio.c b/audio/audio.c
index 8d1e4ad922..a1097bb016 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1683,7 +1683,7 @@ static const VMStateDescription vmstate_audio = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = vmstate_audio_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.34.1


