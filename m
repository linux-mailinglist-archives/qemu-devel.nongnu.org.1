Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC2882AF04
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 13:56:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNubD-0001Zn-Bn; Thu, 11 Jan 2024 07:55:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNub7-0001Yb-BX
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 07:55:50 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNub5-0000Vz-9o
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 07:55:48 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40e6296636fso750315e9.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 04:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704977745; x=1705582545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aI2NM3sDgPdmZ0R/42EOO2Fag3IFKQi4/hyjlUe7qB0=;
 b=FIiFQTKsyim9v9j1rm5fzWSxpM9+lQ7IdKwR2T661ZBeFNeJTloJGw60InCmGbAkRm
 qNJiJ6aFgkhLffgvGIfBLJhc8mPDKiqi3cwdZSvwrXhuIgwXpObM2UOyh1pk83CtG6BG
 cZsQCVn5Ro87vnqeR43JbBB9M4ODw+14N99FOEHKU4wVAEJdX1mN6xdvARoUxizNyWBS
 Xr+ss2UeaXaKm2N2HtyswbWwSaMTiLqtGFqko55/nSIIPzpz5qvoDivDDTsb6s+DO5Co
 XR/HKa9vkYvGEm+IXuS4hmqcMnEL8nwjmfqDNtFv+0JkMGuas9QJP5MqVwPNmWPCXi6c
 IkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704977745; x=1705582545;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aI2NM3sDgPdmZ0R/42EOO2Fag3IFKQi4/hyjlUe7qB0=;
 b=fSiK+A/rqwTg0K6k8h2yeO6hY28Mm+D257OwIHoOzx4+T95DnrgrpZiPZ7zefiu7zS
 XMG3DXfpOOzdI1UBziSGvU06IhBQVVYtyUlpkZILRKcHipjG3O9vM40E6JUswvFhjH3q
 Aq0Pb2hCJLw6DAdSe99q8tW1AO4rg0dukIc1098s3cnRlVdgF4kNtDDjZpBndUfLpPBE
 bCynDZ1uOp9NCgUWzNchoI7539To0ZSxtwmw2N3bcOaig0+HH8elMsEnqg9tkYRnkn9e
 XFhFGOtjqqUpSn1JMFSQiJdqObAy74rUspZ/59c/zh3PfaP85rLu2QfBBIUUTr4NX9gc
 euyQ==
X-Gm-Message-State: AOJu0YyDlEyOvSty/MdebrK2KQtAsPRoxKjMPcpHvO8Su3bsYHvtZIcE
 +SNZmpflf5zBqmDUOiX0fCzkkr7bxWuc5SRQkM4X728FCgs=
X-Google-Smtp-Source: AGHT+IEFo7uq7lgdudd+seltbaWCLS5DiyZyUWvN6I6iC7pvF+IiGUpZBxPJny4s3mLxD1DxNEirLg==
X-Received: by 2002:a05:600c:2315:b0:40e:5cf9:8ec6 with SMTP id
 21-20020a05600c231500b0040e5cf98ec6mr344460wmo.80.1704977745150; 
 Thu, 11 Jan 2024 04:55:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a05600c450500b0040d6d755c90sm1845941wmo.42.2024.01.11.04.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 04:55:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH] .gitlab-ci.d/buildtest.yml: Work around htags bug when
 environment is large
Date: Thu, 11 Jan 2024 12:55:43 +0000
Message-Id: <20240111125543.1573473-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Sometimes the CI "pages" job fails with a message like this from
htags:

$ htags -anT --tree-view=filetree -m qemu_init -t "Welcome to the QEMU sourcecode"
htags: Negative exec line limit = -371

This is due to a bug in hflags where if the environment is too large it
falls over:
https://lists.gnu.org/archive/html/bug-global/2024-01/msg00000.html

This happens to us because GitLab CI puts the commit message of the
commit under test into the CI_COMMIT_MESSAGE and/or CI_COMMIT_TAG_MESSAGE
environment variables, so the job will fail if the commit happens to
have a verbose commit message.

Work around the htags bug by unsetting these variables while running
htags.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2080
---
Cc'ing stable purely because it's probably useful to avoid flaky
CI jobs when testing stable branches too.

 .gitlab-ci.d/buildtest.yml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 91663946de4..0a01746cea9 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -647,7 +647,10 @@ pages:
     - mkdir -p public
     # HTML-ised source tree
     - make gtags
-    - htags -anT --tree-view=filetree -m qemu_init
+    # We unset variables to work around a bug in some htags versions
+    # which causes it to fail when the environment is large
+    - CI_COMMIT_MESSAGE= CI_COMMIT_TAG_MESSAGE= htags
+        -anT --tree-view=filetree -m qemu_init
         -t "Welcome to the QEMU sourcecode"
     - mv HTML public/src
     # Project documentation
-- 
2.34.1


