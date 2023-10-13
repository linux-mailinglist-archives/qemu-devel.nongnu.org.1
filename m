Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE737C890B
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 17:46:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrKL5-0001p8-9D; Fri, 13 Oct 2023 11:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrKL3-0001oE-1w
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:44:33 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrKKz-00055e-VX
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:44:32 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32caaa1c493so1808272f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 08:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697211868; x=1697816668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C6SS7sgvy+nD5iyjsrgsB7iDEpkHXyOxm+TGOn5D/JA=;
 b=eLDXwgbhonAESnaR8TPq1aUo2fVZqCvXRJY1pIp5DFlN9O4L8f1NGImtmFDfCnYaup
 3ZPFARhI6mxRWJUIZoP4rFXhoSMPhyt/WA/02mID09uRtV8v4GcG6B83+azJcK1RxrT0
 3RM3D/vwyPnHqxgYdRa/knFMpll6BoFICw3wCizRtesNNOm8KtGB+9YlU5+U5/xEzDzI
 RoJBFgIVHJj9SIyO7ZtF3sJfijKa3qXcf2O93F8c+qWVxuNrq0k+oj/KfEc/TwOEtk1w
 uj8ycjldAa4siHx7uZh9XleRJx78sapRcTMbEpl1DH7RLDBDDSL7L6jmOCLfjO0DX9Lp
 qY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697211868; x=1697816668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C6SS7sgvy+nD5iyjsrgsB7iDEpkHXyOxm+TGOn5D/JA=;
 b=OWCrYO2iEEmuYrHA31LIfCQihDlSuh5yKmUWXM54DVeF90MrhpnFFkXNOMa7Vqp+Ju
 0yWNbxmVsm7k9PTn8U9UFaQ3kKF291YUgBYg0bAirtJfSCgDOe7Xt9CX8w3y9wemm8Dm
 zk2MCzN+XQZ11aldchxdQCbeSfWF3hmKtEjUySzeN6EjLg9Lw/xRcTkWTwnG6wsMSsJF
 VXi6luwd2BzL5iYBb4C2KCcUVd4EQT0Z0b1XgBywZV/BLmPNRWJpwD/m6kvUv6VyAuUn
 lUVUbGDrTWBeWK5bHo3vqsUAaTcbMW5sQEtJeQbowWNIm4hTNLKp9dlTFNCgGRMYadsh
 C9cA==
X-Gm-Message-State: AOJu0YyC3xYa30++0s6cQhI61EeNElAlncUAWvd/iZKSajYchL1OmINz
 zCSstn7ABQbEnEFMvbH1nJuMsA==
X-Google-Smtp-Source: AGHT+IHKSU792pukYfg9dQX5P7UNbbmpXJGKnZIDjqzLsPdoZKTjFqqfCX/G7SW76Cg9M5lgiTJlDw==
X-Received: by 2002:a5d:4388:0:b0:32d:9755:44f1 with SMTP id
 i8-20020a5d4388000000b0032d975544f1mr3008688wrq.32.1697211868637; 
 Fri, 13 Oct 2023 08:44:28 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 p21-20020a05600c469500b003fe1c332810sm462256wmo.33.2023.10.13.08.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 08:44:26 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DC79E1FFC1;
 Fri, 13 Oct 2023 16:44:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6/8] contrib/gitdm: map HiSilicon to Huawei
Date: Fri, 13 Oct 2023 16:44:22 +0100
Message-Id: <20231013154424.1536392-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013154424.1536392-1-alex.bennee@linaro.org>
References: <20231013154424.1536392-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

HiSilicon is a wholly owned subsidiary of Huawei so map the domain to
the same company to avoid splitting the contributions.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Yicong Yang <yangyicong@hisilicon.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 38945cddf0..42571fc1c4 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -22,6 +22,7 @@ fb.com          Facebook
 fujitsu.com     Fujitsu
 google.com      Google
 greensocs.com   GreenSocs
+hisilicon.com   Huawei
 huawei.com      Huawei
 ibm.com         IBM
 igalia.com      Igalia
-- 
2.39.2


