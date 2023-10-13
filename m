Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DC37C88FE
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 17:45:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrKL3-0001oX-MS; Fri, 13 Oct 2023 11:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrKL1-0001nd-RZ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:44:31 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrKKz-00055f-U8
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:44:31 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-405361bb9f7so23537245e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 08:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697211868; x=1697816668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iAeqGixyxkvAoiPjnZ0DO2UxMXc74+byfWcK6aCBvWw=;
 b=sWHD+kxZ/GAMw1KjCIQVETFXdLdYLhmXsxxBKJ5vRX93WeYCxkfsfz9eGlNnyh2NXj
 2nn1xLQP+77HVHU2Q58z8fTNQVbEhI9qP9B32SZt62ryczEXBJwgmzXA6XQEIpwy2LXX
 FHNggVMPSh5z/4MuNOdY9Afn0bLN6rDi8SBTj9dJ5UzLwuyIiOuHlOQgOvRxOZHf18PW
 ldqDBLMMdCYAcFkOZDuru35/5bTtK8C1UIWQKYOx69ERXsgp/QbjCxrp9LSFK4shsnH1
 zbzB7h02FhjvTzqdSXPBmeXW3m9q2Q5M2VcXPR2NmWRt/uu++VgeVNrCK3kX+dJwJg+V
 yStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697211868; x=1697816668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iAeqGixyxkvAoiPjnZ0DO2UxMXc74+byfWcK6aCBvWw=;
 b=QPArGFb7Gat6jc7LLXMTat/cWWuxRoNR1odQI70tLYTjwgrhA/47Lb6DMBpRzHK9ga
 /oUV+C+UpEy8UowR3/7egPZUxLbjicGAZy9+h+mFoqWVPeqWx4RHAKeVRaf4ypzY8PZV
 E5I9LNoeXm6sktxQOyBhCd7J2XgwnJDfrmHoM1FZjnIAOd4kW2AFLYnib88r+Q2x8UCq
 J1V1FB1XQHF92QGQJEMpjtUAnlmXt84Ls0XmCoFElgHfZCT69XGmg8bOVxhy3OJBdPx/
 Bj9gndUPoxSkColh73t283EJLfrRMwU6D3LJC2cUmiMI72+vpVkopjxKxlojpQTteFj+
 qKzA==
X-Gm-Message-State: AOJu0YwenbHSE5xugEE2pe4f65PuzOaBnKOIR5sq+fQe7VEih+vDp0bD
 0JZn4DxJniB1UjVguxggLyJ8Wg==
X-Google-Smtp-Source: AGHT+IEmacwsn2a0H91vWjYK5aawmN1HuvUz0zoZCI+7tiTfW99P3pdccO61ZElwImGOLNj/adulIw==
X-Received: by 2002:a05:600c:3546:b0:406:8496:bd8b with SMTP id
 i6-20020a05600c354600b004068496bd8bmr21686414wmq.9.1697211868634; 
 Fri, 13 Oct 2023 08:44:28 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n12-20020a05600c500c00b0040773c69fc0sm464326wmr.11.2023.10.13.08.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 08:44:26 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F23C41FFC2;
 Fri, 13 Oct 2023 16:44:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viktor Prutyanov <viktor@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 7/8] contrib/gitdm: add Daynix to domain-map
Date: Fri, 13 Oct 2023 16:44:23 +0100
Message-Id: <20231013154424.1536392-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013154424.1536392-1-alex.bennee@linaro.org>
References: <20231013154424.1536392-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

Daynix describes itself as a cloud technology company so I assume
employee contributions should count as such.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Viktor Prutyanov <viktor@daynix.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 42571fc1c4..bf1dce03fd 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -17,6 +17,7 @@ cmss.chinamobile.com China Mobile
 citrix.com      Citrix
 crudebyte.com   Crudebyte
 chinatelecom.cn China Telecom
+daynix.com      Daynix
 eldorado.org.br Instituto de Pesquisas Eldorado
 fb.com          Facebook
 fujitsu.com     Fujitsu
-- 
2.39.2


