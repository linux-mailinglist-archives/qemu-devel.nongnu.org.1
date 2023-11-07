Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA9F7E41E9
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:36:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0N9t-0003pt-TD; Tue, 07 Nov 2023 09:34:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0N9r-0003oM-0Y
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:34:24 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0N9a-0001TI-4f
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:34:22 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507e85ebf50so7116825e87.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 06:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699367617; x=1699972417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YMoZZcxgNzTmqfpOzorw5f2xERwmkzqwcLwISjGwm4k=;
 b=MXQRmRYCB6Fac8Z3HJwDFppPmvi/8WE+95dVLcxX75Euw8l/t/DbBR6rTh1159a2X9
 8Ya1gQS1xjjAl1y0Lw3QE4PYrhVw10Hs97H6ttFDrf5yBe9+34mMPvV/++l5TjGsctYO
 qy+XFBJWl3kqvnx87RYMuU3X9PlXqap4unxm3e4UnLpE+OeMEtUfobNjG7lqCi1uPJNH
 S52xoVL7W4Q8C44v4ZKSEvIIBlB48WDroHETjOlWfqwI48hzM+4EwoZI/tKG741exQKH
 Wp3qpB+iZ3YduahgUByV56HwmuinCW1GL7a6S7kXgA0iN7/zhTTQiZWb68TGFuUZcTXa
 vxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699367617; x=1699972417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YMoZZcxgNzTmqfpOzorw5f2xERwmkzqwcLwISjGwm4k=;
 b=mEA12YyrxO48itCNxPFTElcewGF/M33LKQbKMSi2qiGeQrsZh6P997r/akSAmwK5Pd
 Wfg7lpI9xIY4EINIrDfCf1xVduE1BcuOSE3MgvEr1d/gJOaU2Ceo8AWeBNUtdXIOyD6t
 HoCalnHJLF+jKDKGalO6D0FEZA5EdAH9auaNj6qa54sVPwufUn9mNJUKkGwyOVmNGLZA
 oX7LdumCie0g6Fu9aZ4AL+R2w6HyY1DcrwlJBBVnoB7wa8e5RFRLW3u6952JlCGpbuNd
 pDLYcSt6wcHf4As9e3K3u01usr6Lmh3VtTyQ93jhOTTUNToSMT669Gg3jnsIBdUFYkB4
 AdXw==
X-Gm-Message-State: AOJu0YxNXOuRnLYtPI8aBCf0ElJV7Z2zZzZ2YPg4cJ8cc5Z8w8f8jHir
 +r+WxyyZYh5ajA0xJsfSyJNTtpgH+xfPtIHfr8QyyA==
X-Google-Smtp-Source: AGHT+IED2fbM16xvToPTF5okafOyCgHaZVZBEsfIAX8P7smEF83UWtGzuiwFLOqPuWzUPcyAkMMTnw==
X-Received: by 2002:a05:6512:48d1:b0:500:bf33:3add with SMTP id
 er17-20020a05651248d100b00500bf333addmr22247031lfb.47.1699367616672; 
 Tue, 07 Nov 2023 06:33:36 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 n5-20020adfe345000000b0032f7cc56509sm2521587wrj.98.2023.11.07.06.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 06:33:35 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 669E365769;
 Tue,  7 Nov 2023 14:23:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yicong Yang <yangyicong@hisilicon.com>
Subject: [PULL 20/23] contrib/gitdm: map HiSilicon to Huawei
Date: Tue,  7 Nov 2023 14:23:51 +0000
Message-Id: <20231107142354.3151266-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107142354.3151266-1-alex.bennee@linaro.org>
References: <20231107142354.3151266-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x133.google.com
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

HiSilicon is a wholly owned subsidiary of Huawei so map the domain to
the same company to avoid splitting the contributions.

Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231106185112.2755262-20-alex.bennee@linaro.org>

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


