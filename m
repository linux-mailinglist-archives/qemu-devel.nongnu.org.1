Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CE57A09E3
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 17:56:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgog2-0001pp-Ff; Thu, 14 Sep 2023 11:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgofq-0001Uz-Kl
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:54:37 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgofl-000880-VH
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:54:34 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3ff7d73a6feso12566585e9.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 08:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694706867; x=1695311667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ra9feMe5mpTaaSeuQ9CkHp2J2B9ZX509sNZE9U1IO4U=;
 b=zECJimsKG9YKKF1SMlHRbrin2hPMqtmEcoK/V7Nq+q3U7ZZ2nmBn9ScN29BPjd7O0K
 0/OokFAWgkJd7NBOeOGQBUoC4Xv5BbPaJErAlvSm/yEn/iTQrlGs8dwfTpF/1TyVZJ6E
 yo27jHfFJLCIFx0IXJAT8EIDYP+Ll4q78kfVy/45PpdT7IpS+ulp4SRwMMiOHSrf9Bmw
 O/Zj1TSxDWmcQ/fUGCNzrO9kkvmphZtk8tpgLETk02hD56kD8WZ5QY5B+EQK2HHT+To2
 pmc3Rqo1L0Pr0+hzwyO2nrqYE781a1UUyy7Z6kHOsfbSQI39XIn5MW24aXnAc+TS0N8t
 WYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694706867; x=1695311667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ra9feMe5mpTaaSeuQ9CkHp2J2B9ZX509sNZE9U1IO4U=;
 b=f/jKzqD9PbRCZdHMlbjUE6idv3qtTqKnYWrqrjyOOIAA45cppwkmgPSipZYSe7kjB0
 aJ3t3ESwYfNPpbF9CsN2asIeoTL9Vero4rFoF/L6vWt7X0C/xiujWxX5jUpBKnbE1MQG
 cquplTjz8kchth1V3GFNzH0VFpvkkAL5gIBBfGiYWak6HXoCpz+0J3fbXNoHG2v/a4cT
 JAVY/SEbyU5FpuH5YqV6PtCvIirOa4aDOs3ZEeGFaWksgDOmB9wArZNXly22rGC2DwAi
 iTlRhC46BTIc1Y5UCoO5CIlx6vZZBPhl8HdiB4HX/+AYWptaIsjAnDxE3fd60yamPB4l
 CgVQ==
X-Gm-Message-State: AOJu0YwwfcRxarf9wlXLmi6RqvySN1dk7tbtrvUFl2CrlBqQ+UOMz1bk
 clhGQ6Oji7fvhOtm8seUmwCOuw==
X-Google-Smtp-Source: AGHT+IGVzc8qMdBfm9gV0Wg5WFAJuJJ6GSHzrZx7LYXbH3BEVUMq5WdLJvveBVE0tMNpQbmb5yS8Qg==
X-Received: by 2002:a7b:c44b:0:b0:3f7:f2d0:b904 with SMTP id
 l11-20020a7bc44b000000b003f7f2d0b904mr4787828wmi.8.1694706866826; 
 Thu, 14 Sep 2023 08:54:26 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f20-20020a7bcd14000000b003fe2b6d64c8sm5144804wmj.21.2023.09.14.08.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 08:54:25 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1DCB11FFC1;
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
Subject: [PATCH 6/9] gitlab: make Cirrus CI timeout explicit
Date: Thu, 14 Sep 2023 16:54:19 +0100
Message-Id: <20230914155422.426639-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230914155422.426639-1-alex.bennee@linaro.org>
References: <20230914155422.426639-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

On the GitLab side we're invoking the Cirrus CI job using the
cirrus-run tool which speaks to the Cirrus REST API. Cirrus
sometimes tasks 5-10 minutes to actually schedule the task,
and thus the execution time of 'cirrus-run' inside GitLab will
be slightly longer than the execution time of the Cirrus CI
task.

Setting the timeout in the GitLab CI job should thus be done
in relation to the timeout set for the Cirrus CI job. While
Cirrus CI defaults to 60 minutes, it is better to set this
explicitly, and make the relationship between the jobs
explicit

Signed-off-by: "Daniel P. Berrangé" <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230912184130.3056054-4-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/cirrus.yml       | 3 +++
 .gitlab-ci.d/cirrus/build.yml | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index 41d64d6680..816d89cc2a 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -15,6 +15,9 @@
   stage: build
   image: registry.gitlab.com/libvirt/libvirt-ci/cirrus-run:master
   needs: []
+  # 20 mins larger than "timeout_in" in cirrus/build.yml
+  # as there's often a 5-10 minute delay before Cirrus CI
+  # actually starts the task
   timeout: 80m
   allow_failure: true
   script:
diff --git a/.gitlab-ci.d/cirrus/build.yml b/.gitlab-ci.d/cirrus/build.yml
index a9444902ec..29d55c4aa3 100644
--- a/.gitlab-ci.d/cirrus/build.yml
+++ b/.gitlab-ci.d/cirrus/build.yml
@@ -16,6 +16,8 @@ env:
   TEST_TARGETS: "@TEST_TARGETS@"
 
 build_task:
+  # A little shorter than GitLab timeout in ../cirrus.yml
+  timeout_in: 60m
   install_script:
     - @UPDATE_COMMAND@
     - @INSTALL_COMMAND@ @PKGS@
-- 
2.39.2


