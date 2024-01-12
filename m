Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6140A82BEFD
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 12:10:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOFQk-0007PQ-H2; Fri, 12 Jan 2024 06:10:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFQd-0007O5-Ld
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:10:23 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFQZ-0003PW-4r
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:10:22 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50eaabc36bcso7849523e87.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 03:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705057813; x=1705662613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rc+RI8coeqeNMBdNyZ5ZrH1HTFr+Hz1CUChlUEJQgAU=;
 b=tu/qpj4+x5Z6ZDPwSrOUVr/h5rVvJ+BxOZ2ApPqobALmA5JstYwnVlS6/uoLj4ITKl
 WhucEVoKXhocXbZm6Bf25LpqFw0qE0f2owIXfqSxPMFwoRlpYJVJqfvUlYaHXJoVhtM3
 02jGlSqlVS1mxMVlA/4/Ief2UcSjcrOrINL0XgLY03sP7mCyvEwvQSkv8KlIBdePmzbo
 aaNzw7Z4shC4Q6EHtHVLFKca5ZI353DML6UN6zo3Yxz876L1OzyijZv44KQEBt7hk9dH
 IdBh4KWgckMLL47ryozoLPhHwdlnHQRQJmKuc+a3No8J8ay00xlmv9r93pmy9pbARhqe
 uX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705057813; x=1705662613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rc+RI8coeqeNMBdNyZ5ZrH1HTFr+Hz1CUChlUEJQgAU=;
 b=GkSBpwHBm0NOHHEEChFwqqwo3/L9n3vZCmP15V89++qxrez9mOlUg9rK4bKatEwRvV
 mMTXkNs/wzizRVPUV46Za2SJTN34SOmRmpyv3Rcu7eMpJzAwgXsqMVxldOHh1aNAIlnW
 +iItKMQUKgh0Z26esROz0VgtRSjYI55lCbNQ5CYUDGxIC04zirKbW/sMUzJkr/e80aHJ
 KVKn0La23rL9pH3/fVtVTEOmIzc8ozCHkiPDajy3Kq2Ho45IskWvRuKfIBPyDLRBx10e
 sRZUwjkJcaHionc50fbQM0RdzMmuic1srMkWKODFGTyvryQiVmPHjnhhqRjBXSsedrvd
 r6Xw==
X-Gm-Message-State: AOJu0YxubcPa3f57w0yurfRGnB0I17vHxkX2evdfIYoyF4NioJ5FOf/8
 5Ec6ukmJJKOqgoIgy0SCtd9AK37WjrRnNA==
X-Google-Smtp-Source: AGHT+IFnqD/eGsJkua/3kG3NngrZ9uI/xHEhOvMqQ4J1AnNtVO6it2oL6gCZRfmwJvhFHP8Av7jcYQ==
X-Received: by 2002:a05:6512:1250:b0:50e:10e8:d544 with SMTP id
 fb16-20020a056512125000b0050e10e8d544mr718281lfb.68.1705057813259; 
 Fri, 12 Jan 2024 03:10:13 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l6-20020a5d6d86000000b0033788e357e1sm3597451wrs.108.2024.01.12.03.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 03:10:12 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E2DD85F9CD;
 Fri, 12 Jan 2024 11:04:36 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PULL 21/22] readthodocs: fully specify a build environment
Date: Fri, 12 Jan 2024 11:04:34 +0000
Message-Id: <20240112110435.3801068-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112110435.3801068-1-alex.bennee@linaro.org>
References: <20240112110435.3801068-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x132.google.com
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

This is now expected by rtd so I've expanded using their example as
22.04 is one of our supported platforms. I tried to work out if there
was an easy way to re-generate a requirements.txt from our
pythondeps.toml but in the end went for the easier solution.

Cc:  <qemu-stable@nongnu.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231221174200.2693694-1-alex.bennee@linaro.org>

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


