Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD8A7A09E2
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 17:56:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgogI-0002G3-Jd; Thu, 14 Sep 2023 11:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgofw-0001XZ-J1
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:54:41 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgofn-00088G-Rw
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:54:39 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-403004a96a4so12347275e9.3
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 08:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694706867; x=1695311667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ar/Na+5UA9tN2heidPJESlS3zwJBlN8svfE9CzG3edA=;
 b=grxQCo/kEbmBb2ICFf6himleEERQgukNB2NFqj8sqrbW/MSkZpGJW46umGXNeUdHBy
 9KAMvcQenUJL0VibZT28+NJYym/RmFkikFt033IFy+mlC7kgXGq4mcFfNZZ2asiw9lDV
 i1JoKNKhkWaqCbSTe4bwXTIC/uuR8jCU5qNGaGzjyTckFCNuU1CKppLDhkgPA2ftwNRX
 UsqjcRwE/bqZH+Ay+/CAwUvYipK+jn4kJynTEvBY6hnttYGnHJDO1wTXRFtwHJhIYpsh
 gCc+nZ0ewOtKyYGzx68oSyWu/3ynmA5Q6TWXVHy7Xw051/PtmMfCOPcDiQQpZJrLQpVI
 w/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694706867; x=1695311667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ar/Na+5UA9tN2heidPJESlS3zwJBlN8svfE9CzG3edA=;
 b=MjCO0gKG2f7XxU9mmC1mbvK+jmnVhFPkreT1a83Izvg/dA2cArMEACBzPTy3hnKWCV
 N91iYtMtJ4yXIOWdjhZ0haOI7Zt7cFov59NzTBp9VkvZN8hdxOWPaSpFymV6i1rbNS87
 YmjuaGGTbdPrt1FPVUO0vBkKBSRJW65xTCPQePqFyNbpOyAl3KzdreLm9ulz2lK6ilBh
 rSH5mNxozAAHrv+atj9ODXJ4eetIKqDTxQo76uoK27+L6LaCu0O4zTGV3UPHX+qWiP9b
 DTCIRO4QOEXTQYYZReBbMURSWAbFTsXNsZarz4w45b38kxSP9wJ6cXktYu/VEA/mRMjc
 98NQ==
X-Gm-Message-State: AOJu0Yz8NdYCxshY0BJO20jggvqnzv+0lCZYjfgIK2Z89JDVCoxCTWF4
 +dNhkM4uZ61PtSD+Y96hTyQIrw==
X-Google-Smtp-Source: AGHT+IE+xPbO7ZdSSK1P8Xqc7zL1S0cRKyTJdvsfVa+0sVGguWG01Kg07e+O1eZr0oQDOSu2duguBw==
X-Received: by 2002:a7b:c846:0:b0:3fc:3e1:7105 with SMTP id
 c6-20020a7bc846000000b003fc03e17105mr4926867wml.24.1694706867558; 
 Thu, 14 Sep 2023 08:54:27 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c00d100b003fe0a0e03fcsm5180621wmm.12.2023.09.14.08.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 08:54:25 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 355A61FFC2;
 Thu, 14 Sep 2023 16:54:23 +0100 (BST)
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
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 7/9] gitlab: make Cirrus CI jobs gating
Date: Thu, 14 Sep 2023 16:54:20 +0100
Message-Id: <20230914155422.426639-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230914155422.426639-1-alex.bennee@linaro.org>
References: <20230914155422.426639-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

The Cirrus CI jobs have been non-gating for a while to let us build
confidence in their reliability. Aside from periodic dependancy
problems when FreeBSD Ports switches to be based on a new FreeBSD
image version, the jobs have been reliable. It is thus worth making
them gating to prevent build failures being missed during merges.

Signed-off-by: "Daniel P. Berrangé" <berrange@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230912184130.3056054-5-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/cirrus.yml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index 816d89cc2a..e7f1f83c2c 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -19,7 +19,6 @@
   # as there's often a 5-10 minute delay before Cirrus CI
   # actually starts the task
   timeout: 80m
-  allow_failure: true
   script:
     - source .gitlab-ci.d/cirrus/$NAME.vars
     - sed -e "s|[@]CI_REPOSITORY_URL@|$CI_REPOSITORY_URL|g"
-- 
2.39.2


