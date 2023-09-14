Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAE57A09E1
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 17:56:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgogG-0002DB-6e; Thu, 14 Sep 2023 11:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgofu-0001VQ-LT
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:54:39 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgofl-00086q-W1
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:54:37 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31c8321c48fso1509775f8f.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 08:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694706863; x=1695311663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IJP7tO/cH6sZ5F2skMW4pK7/7DONXwboi2ktB3ynH7Q=;
 b=ThZo090EiV6maDLc2hwFIOJMowiOJPOaBlWXd2Jxp0p9Ta5QoaSkCSoOhxh/f+1s5Y
 0R5g/uCgJUqC/Nf8MA2Ci8wGcx4Hfx8QzXR32jVKsfuNkVK2A5bYQ75Q8Yp1RFjGoNX8
 kimA4ZEpvKfWQpb3WItNrQrcGUL7CQ31XZZ621x9n0enpueisFhe84jE0WGgpjc8j+A4
 7YRG5gqdJFL2F9ybs1gkfpJrNAFlsA5oVVjc+TESV2zaYtZdCwn6nI/iL8sBilK0rBBN
 F40h75+RPaPs0a1nA9lArufRA7w3A9HR8Mx+rXIf30LCAIJ1gieWu1CtTw0qbgXgQDyi
 hVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694706863; x=1695311663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IJP7tO/cH6sZ5F2skMW4pK7/7DONXwboi2ktB3ynH7Q=;
 b=QkL30MeP/oBEb0JydfXjOrdq1RgPAfWTeg7qrce2SGw2cMAIMklZds9cx56xaTuheR
 KNTMGRtndLRpZYPkJNJMwAFWOB6IVWvwC+jgnAx4Ytpw/2QTX8TREz4GNH6LWg/kFHZm
 gTCTjnmEzFa936HSg/HxLz5dASp51zRyMMU+CYs3Ws0xZpb9f1f/O0NodhGE7nB2MV6k
 q3QevtHTTdDMyn+mxCIWaAD+qsdHhg6i5cOMGFdPJ6feJmOHDmLALpXwz0SlgpeUcePh
 y9c7w8M8SVF0BvUEh8s6SpCOAfmZWz9Yr0JJbRkzv/erXYUV15qDPTddJvB8LTqEdcj9
 0vXw==
X-Gm-Message-State: AOJu0YyRtPCNP0PcJUScKSxMKyZk1ht8bGe6sdXcFKyoSARKn5QiXNnS
 L+cDERH9OFkM+1egeSXLyX/11w==
X-Google-Smtp-Source: AGHT+IF+s+XP/RnjBEInL5fWeolHHRVTqjno1BLasAMcfCm6NJfkbuOoqd/q4q3X33NqbHCSBOAZ/A==
X-Received: by 2002:adf:fc51:0:b0:31f:829d:6b0c with SMTP id
 e17-20020adffc51000000b0031f829d6b0cmr1811771wrs.12.1694706863445; 
 Thu, 14 Sep 2023 08:54:23 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 b17-20020a5d4d91000000b0031c855d52efsm2083942wru.87.2023.09.14.08.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 08:54:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ADFE71FFBD;
 Thu, 14 Sep 2023 16:54:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 2/9] gitlab: fix typo/spelling in comments
Date: Thu, 14 Sep 2023 16:54:15 +0100
Message-Id: <20230914155422.426639-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230914155422.426639-1-alex.bennee@linaro.org>
References: <20230914155422.426639-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/base.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
index 188a770799..ef173a34e6 100644
--- a/.gitlab-ci.d/base.yml
+++ b/.gitlab-ci.d/base.yml
@@ -68,7 +68,7 @@ variables:
 
     #############################################################
     # Stage 2: fine tune execution of jobs in specific scenarios
-    # where the catch all logic is inapprorpaite
+    # where the catch all logic is inappropriate
     #############################################################
 
     # Optional jobs should not be run unless manually triggered
-- 
2.39.2


