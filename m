Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D45081BD75
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:42:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGN3k-000196-DL; Thu, 21 Dec 2023 12:42:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGN3i-00018O-Ig
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:42:10 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGN3g-00042d-U4
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:42:10 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3368b1e056eso628487f8f.3
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 09:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703180526; x=1703785326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EF4l2a33CD56po7wUzZ74Jg24AYIg2HXPZC20UbGT0Y=;
 b=KXrtKKqalFc7KYRVhNHrJrjNgKhaWbQDVXo9LMd4eeWdlzs428Kfn+WPBdI7YQqNB0
 mQJR5J5Y/YaCOqFtq9Kb8Qfbnm+SRYqyYnmji4Eox++zuBRB+OIqkTGRsjl5++WbQoLh
 690yoVfA0gcVtfUDoKxNZvaIgPpY7JSSFyw6ugUFc3D0pm8T5XmHFGbMlT/KHj8iTG3C
 WcZcRfXw2kEbIRNcDFGIyWsYpBfGuU/RBaSkCythnQxdG/W/fwYvKJGlZTGNVPeei5O3
 5B0P5gI0nQDNJuffWH6LA7oPdvJxfVCV5puvl0NPMlBxCIqP8z6SSqTILpmrKo5zaMY+
 83Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703180526; x=1703785326;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EF4l2a33CD56po7wUzZ74Jg24AYIg2HXPZC20UbGT0Y=;
 b=X+p6RmQ3KkVca/qYyQhA+UXjWzOgObXq/bxwri+RFcHu9imSfRfmcnRx1J7SrYQJEU
 GsIvczkMmv8TsdDu8xPoKWaPcUw9o1p18tf1NwoCaCjA2uypuGr9FATbaAWEvM8hnnBE
 pHcrsmjlHWQ4rKxnHvinlWcAUO9rezNpsn/N50kIYUrcb8ueZYEF7ANNe0cepKR+zoTO
 PfDCVizN/TwN3YmtGbmwQCwCh18wTm9nMXaPxxyysp5cqF0C6EOs21zyxA1FZNfIozzE
 weQqEfUuSvBrRJOK94ZkiPajcgoh72UTb5HG1csgGmUCGsNbKbgvf7L9h9CY1tYkwgbj
 aywg==
X-Gm-Message-State: AOJu0YzsK2++q1MDhkzpMyLnzze2t3okRnlFO4DIpI9GEOeRKtv2y+In
 +QukejZAN0mHlceAcehDYEsuGUL5eQB5qZG8ow9cWpl+hiw=
X-Google-Smtp-Source: AGHT+IEJ16WAhELCQ9Q0wWSvw4YjlGESCcNKUNBsgwqmJ0zg2SzJMzp7kcAG2yEau7JamMyQZCveuQ==
X-Received: by 2002:a05:600c:3c8a:b0:40c:31e5:49da with SMTP id
 bg10-20020a05600c3c8a00b0040c31e549damr40061wmb.136.1703180526210; 
 Thu, 21 Dec 2023 09:42:06 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 v8-20020a05600c444800b0040c2c5f5844sm4015096wmn.21.2023.12.21.09.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:42:05 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8E6A75F7DA;
 Thu, 21 Dec 2023 17:42:05 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-stable@nongnu.org
Subject: [RFC PATCH] readthodocs: fully specify a build environment
Date: Thu, 21 Dec 2023 17:42:00 +0000
Message-Id: <20231221174200.2693694-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This is now expected by rtd so I've expanded using their example as
22.04 is one of our supported platforms. I tried to work out if there
was an easy way to re-generate a requirements.txt from our
pythondeps.toml but in the end went for the easier solution.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
---
 docs/requirements.txt |  2 ++
 .readthedocs.yml      | 19 ++++++++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)
 create mode 100644 docs/requirements.txt

diff --git a/docs/requirements.txt b/docs/requirements.txt
new file mode 100644
index 00000000000..691e5218ec7
--- /dev/null
+++ b/docs/requirements.txt
@@ -0,0 +1,2 @@
+sphinx==5.3.0
+sphinx_rtd_theme==1.1.1
diff --git a/.readthedocs.yml b/.readthedocs.yml
index 7fb7b8dd61a..0b262469ce6 100644
--- a/.readthedocs.yml
+++ b/.readthedocs.yml
@@ -5,16 +5,21 @@
 # Required
 version: 2
 
+# Set the version of Python and other tools you might need
+build:
+  os: ubuntu-22.04
+  tools:
+    python: "3.11"
+
 # Build documentation in the docs/ directory with Sphinx
 sphinx:
   configuration: docs/conf.py
 
+# We recommend specifying your dependencies to enable reproducible builds:
+# https://docs.readthedocs.io/en/stable/guides/reproducible-builds.html
+python:
+  install:
+    - requirements: docs/requirements.txt
+
 # We want all the document formats
 formats: all
-
-# For consistency, we require that QEMU's Sphinx extensions
-# run with at least the same minimum version of Python that
-# we require for other Python in our codebase (our conf.py
-# enforces this, and some code needs it.)
-python:
-  version: 3.6
-- 
2.39.2


