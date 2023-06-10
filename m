Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4263072ABC7
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:36:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yi4-00059h-7Y; Sat, 10 Jun 2023 09:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yi2-00058j-Gj; Sat, 10 Jun 2023 09:32:50 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yi0-0007jB-Vu; Sat, 10 Jun 2023 09:32:50 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-38c35975545so1272911b6e.1; 
 Sat, 10 Jun 2023 06:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686403967; x=1688995967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oCMxM0s80e3nqNvS0gBoQGxCi+E1uH3byLDTSuvXq34=;
 b=U8VNKp3u/kGBWQT4YK5w2dALgZczIZU2g3ijhBOFPVUK0bGH7Qhr4feWJBSG6gsOzS
 M4HFSLTiI0MRSYVgzd7q44C9FrFhF5OI2Y14hSNeUUYfPECQQ/zkssyB+T/xozJv9P1s
 quLzKO7upa615SvMwJ42TjGKWF8KHAll+CpGCBqTptICSNbwIyGTL7JYyAVeUDNZWYM3
 7sjhnhmmCFkiPKyU1uxm6KLTmv3jaeW3nlM5gq/OqpW6tJih7l4ZyjFt24Y1fPS62R3x
 yQfppoZp5hYTGHaIMBsZsYkOLOeYZl25KfBN0cpOCE3IN1pBQDleLrxlXs+GrUQ/oAA4
 5VEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686403967; x=1688995967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oCMxM0s80e3nqNvS0gBoQGxCi+E1uH3byLDTSuvXq34=;
 b=WWVbPsETX30LV2GS3fSq6X9QMaPxq8x+R9vTuZ+ABSt2fg63r0yyp9mbWbDsVK+3Jf
 rr89OnHXxcimGgeLk/xRKU36Rm+sKC7rJvxc5hlE+OZfeso/NuklpQTfT4tQhepCwlIc
 DiXTCm82nZTWjvbguBN7ncx3Lzx965M27hGsfBXW2MeM5S/y5sygYGSyF3lQFXA/w+UY
 2yGJI1R9Ac7wbiHpIh6eRHK/geammaXpDMLsnTypwTQ63WLGUDK1m/v9slbRp4mARUDV
 ZNyVwQfUZKnXrUrhZwUP9luTA/osJtBvd12FdAQTtF8Dz8X8bxGabSXbEWb16CYG2BjF
 nn1Q==
X-Gm-Message-State: AC+VfDwkoUwpe3rTKRvUWVvxj6cIjY/iSgT3bCgWLm9JK7f6aLS/p+q9
 KMFr9Jt1bnsMGyymo85oLaD5fcWLqpA=
X-Google-Smtp-Source: ACHHUZ6+qyxAaEl3EiMrxjK88dDaAEUToQYfb7PhzM2Kn5usFCmRC92ToaeMV9JAbFQ+HZJCaG9WTg==
X-Received: by 2002:a05:6808:190d:b0:398:bdb:956a with SMTP id
 bf13-20020a056808190d00b003980bdb956amr1173192oib.35.1686403967108; 
 Sat, 10 Jun 2023 06:32:47 -0700 (PDT)
Received: from grind.. ([177.170.117.52]) by smtp.gmail.com with ESMTPSA id
 y3-20020a544d83000000b00395f2c84b81sm2428420oix.54.2023.06.10.06.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 06:32:46 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 27/29] tests/avocado/tuxrun_baselines: Fix ppc64 tests for
 binaries without slirp
Date: Sat, 10 Jun 2023 10:31:30 -0300
Message-Id: <20230610133132.290703-28-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610133132.290703-1-danielhb413@gmail.com>
References: <20230610133132.290703-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Thomas Huth <thuth@redhat.com>

The ppc64 tuxrun tests are currently failing if "slirp" has been
disabled in the binary since they are using "-netdev user" now.
We have to skip the test if this network backend is missing.

Fixes: 6ee3624236 ("improve code coverage for ppc64")
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230606192802.666000-1-thuth@redhat.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 tests/avocado/tuxrun_baselines.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
index 3a46e7a745..e12250eabb 100644
--- a/tests/avocado/tuxrun_baselines.py
+++ b/tests/avocado/tuxrun_baselines.py
@@ -184,6 +184,7 @@ def common_tuxrun(self,
 
     def ppc64_common_tuxrun(self, sums, prefix):
         # add device args to command line.
+        self.require_netdev('user')
         self.vm.add_args('-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0-:22',
                          '-device', 'virtio-net,netdev=vnet')
         self.vm.add_args('-netdev', '{"type":"user","id":"hostnet0"}',
-- 
2.40.1


