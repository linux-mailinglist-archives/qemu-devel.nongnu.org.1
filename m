Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3E294189F
	for <lists+qemu-devel@lfdr.de>; Tue, 30 Jul 2024 18:24:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpcb-0008At-Uz; Tue, 30 Jul 2024 12:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpcZ-00089H-Sc
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:43 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpcY-0003Wv-7C
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:43 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a7ac469e4c4so5053166b.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 09:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722356560; x=1722961360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sv1yYe2fDl/D3XYptaj1UVlAvzIz+z/QMmVpNU4wrEY=;
 b=l683DmYpz/UtKahkrY34jx83u/+AXdAEnE4py7JvBsUHBFuUglzghr2zLSiImeW+px
 6m0xZM8Htc7ynD1STSNnX8jwyeprYPru+ma6cLVyP1HlI4b37pBmsPZWZn9F9gJG/DeE
 AugUqzxF5OyjN0y8u6TWLlo1/NTuOOLO4cWJzrho65fld2mUXTLlRoxLAJWDOgjHN6w1
 ytYqHVwiLlLBHaGprVtpo80hDsk1ySmeSZG6yNDSrp4mOTp0udnTsiYyISY61ZtK6Tl/
 hzBtP/MF5LRNh/KgAxecWg2g7b6rX8FmaTgNNJ422+AjRgjBzKQYwxNsED3jzf2e4ePA
 cDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722356560; x=1722961360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sv1yYe2fDl/D3XYptaj1UVlAvzIz+z/QMmVpNU4wrEY=;
 b=m4u2REzBBvWj3QW3jz9+Jk6N1wqauy24r+F6h306MFdZH+nTnoCwxm+i4Q/FQDrooy
 tMQsBKuvSvrCHQasVv3UvM86c0Rrr18N+UIMvn03aP5oheYflGOXMoH615wPrSu1SL4q
 85TCsr89euB0ztva80ZhhGG5lYFW5aYFOlP2rUnsKuegB/6hgDEumU4M3wW7DO3p6Zs4
 Pnd/jf6MMzL5h3WBev07SUKjFYTcB2EZlb6Kua2jdpzDQIpBnsXMz8h3Sfqd22elWrAX
 FjVl3YWwCWgAU/HMhaDWYFCNwKHkjAS6jbdXqh0ITN7gNolgynXWH3cxI9Hr1ETNTaXd
 j27g==
X-Gm-Message-State: AOJu0Yzp7uYzcHqHUVOFVOiT9nxVA8BeZoluGQAgdoVWbA8GtGtioyXe
 2p3UiYmmNqL+xAwbwe5UsmTp8q+p5uNuyCCrZiS62kn8ZmrUEuVRYbt/H84thOI=
X-Google-Smtp-Source: AGHT+IE1JHBiwF4czbRKI25fMU1YHseiybwH9433XRE+AfjwJ/GqiNpe3wzoRMCPYI2f1kAHxEq6Pw==
X-Received: by 2002:a17:907:3e84:b0:a7d:89ac:9539 with SMTP id
 a640c23a62f3a-a7d89ac9611mr177777866b.7.1722356559966; 
 Tue, 30 Jul 2024 09:22:39 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad9d41esm657770466b.154.2024.07.30.09.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 09:22:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 068A55F8D1;
 Tue, 30 Jul 2024 17:22:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 02/14] gitlab: display /packages.txt in build jobs
Date: Tue, 30 Jul 2024 17:22:25 +0100
Message-Id: <20240730162237.1425515-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730162237.1425515-1-alex.bennee@linaro.org>
References: <20240730162237.1425515-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

The lcitool created containers save the full distro package list
details into /packages.txt. The idea is that build jobs will 'cat'
this file, so that the build log has a record of what packages
were used. This is important info, because when it comes to debug
failures, the original container is often lost.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20240724095505.33544-3-berrange@redhat.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240729144414.830369-3-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 8f7ebfaed8..844c26623d 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -9,6 +9,7 @@
     when: always
   before_script:
     - JOBS=$(expr $(nproc) + 1)
+    - cat /packages.txt
   script:
     - export CCACHE_BASEDIR="$(pwd)"
     - export CCACHE_DIR="$CCACHE_BASEDIR/ccache"
diff --git a/.gitlab-ci.d/crossbuild-template.yml b/.gitlab-ci.d/crossbuild-template.yml
index d9f81b7061..53051ec793 100644
--- a/.gitlab-ci.d/crossbuild-template.yml
+++ b/.gitlab-ci.d/crossbuild-template.yml
@@ -8,6 +8,8 @@
     key: "$CI_JOB_NAME"
     when: always
   timeout: 80m
+  before_script:
+    - cat /packages.txt
   script:
     - export CCACHE_BASEDIR="$(pwd)"
     - export CCACHE_DIR="$CCACHE_BASEDIR/ccache"
-- 
2.39.2


