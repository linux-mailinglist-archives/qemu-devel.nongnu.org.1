Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BED9F7E28CB
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 16:34:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r01b8-0008Oe-M2; Mon, 06 Nov 2023 10:33:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r01aw-00082T-Q2
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:32:57 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r01am-0004O6-QZ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:32:53 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-32f7c80ab33so2789120f8f.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 07:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699284763; x=1699889563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wE3VrpMqQ5iO8rOEAjV8Na1iX3YBEUPnu4z7701xXsQ=;
 b=s7bd05mjTtL1wWAdbx3tFffUAd6t5AGzOhoW0y1S8Pal+lZniOwig2FvmnVjNY4yxM
 uD2YPgV5Q5oSjA2yzxTkZ9a5+nUv1oZWpBqiHknV0iQ1e/FC24g/uVyirADzoV6EkpIm
 dbMCHJ/MIOvvHt9pCdmTV9zUxPsEkaQwnTf4gPekswgizQJcIT19wlQgm8wSa/9whBNd
 MXQqRt++KIAm8lVi/zDwA04Kt3X8lrP14SkBx0stw+WsdJIV3OyCqqZsMAB6PJci7kLi
 l0I7zm+tIWAj94doZDBGGaVUDPkJl39LeId7ADK8xMmtfMMYBlCNqtHe5d5yLWUYprtk
 jy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699284763; x=1699889563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wE3VrpMqQ5iO8rOEAjV8Na1iX3YBEUPnu4z7701xXsQ=;
 b=QOLoZNQQsOgxBMcmswT4Xwr9q5KcXJTstVtpkSDB9OOpIMlgBOXVfwqzI/qeKr9CoD
 HLz7ij/UusChy4W8JQGvfD0c7G3np4NCECR6+I4x9VsYLkXlN0aSCdIXILIiG/PS4nB5
 xbnitmakVGnnocY9CZIk2Ezqc5G4Y49sz9Fuyfep+8R3oFcKjvvia19AIKMve5QyEyLL
 jsXuC7Ah7kahbWUUJ9P2u4ncPul/BkYSQAqqgx26Cu7ijJd6VZx4zOwQZsM2hOBK3O4e
 ZhvcPICYU8qbj9kfTe+322IM5Dj+1WD+uSnRBRihKC9Y25zHf45JUzPcXS6i/zFuwoPZ
 A1fA==
X-Gm-Message-State: AOJu0YyQXx0NxXldHMVCBUsaVZ/wwIW6b060OJEJ0CawmODJo0DBFbwz
 SLInMVgkH8+vHWk5Ev5Xsz7FXA2R4kBCG7Kgnpo=
X-Google-Smtp-Source: AGHT+IFVT0pfhqRN78VCPQOu3QZhRirdSvQm5H9N9VBhCpy59qo+frBlxo1ShOQisbndiOVKSlXTCQ==
X-Received: by 2002:a05:6000:1882:b0:32f:aaaf:dad8 with SMTP id
 a2-20020a056000188200b0032faaafdad8mr10779315wri.47.1699284763531; 
 Mon, 06 Nov 2023 07:32:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d5-20020adff2c5000000b0032da6f17ffdsm9752176wrp.38.2023.11.06.07.32.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 07:32:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/12] hw/core/loader: gunzip(): initialize z_stream
Date: Mon,  6 Nov 2023 15:32:35 +0000
Message-Id: <20231106153238.1426649-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106153238.1426649-1-peter.maydell@linaro.org>
References: <20231106153238.1426649-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Coverity signals that variable as being used uninitialized. And really,
when work with external APIs that's better to zero out the structure,
where we set some fields by hand.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
Message-id: 20231017125941.810461-6-vsementsov@yandex-team.ru
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 4dd5a71fb79..b7bb44b7f7c 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -558,7 +558,7 @@ static void zfree(void *x, void *addr)
 
 ssize_t gunzip(void *dst, size_t dstlen, uint8_t *src, size_t srclen)
 {
-    z_stream s;
+    z_stream s = {};
     ssize_t dstbytes;
     int r, i, flags;
 
-- 
2.34.1


