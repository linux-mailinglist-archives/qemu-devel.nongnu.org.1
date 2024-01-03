Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 284CE82339D
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 18:41:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL5DX-0007xA-AC; Wed, 03 Jan 2024 12:39:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rL5DP-0007gN-SV
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:39:39 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rL5D2-0000ld-5q
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:39:39 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33677fb38a3so10735509f8f.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 09:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704303554; x=1704908354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ciRl9sFGERSf23eviyCL0uKOJ2+yOOkqWUqo8JImKW0=;
 b=KPOJ1yQC10ewHPKxj0B56GN6UZ1LRUX0woBBGNOU953v1Aybbebr0PjThiMdEa5Bz1
 mtD1OM0DV/x15Jf43KsENEvXzDn7SmIrmcWItPe1M1kjv3KKPt2r5QKzNU/NmnhlzpNX
 xnOJFpnCw9VdZrd860OtvfGFA7V38QR4oN/+JM84/vV5PBsgtQgJtCPQMyhS33e0fkIt
 1AwJZLyhYVExi7DrEPwdAkw2xEd3HaIaNN1/7O2B1FiSgMzil+LQ8RLgLOrSxi49eMsk
 qS/wWrCOdDvNjFL5clIGjR4JKvrXMsSHSy8IqjZMO1gL8lDJfkfit5KPuKSzRYNr+xz8
 bqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704303554; x=1704908354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ciRl9sFGERSf23eviyCL0uKOJ2+yOOkqWUqo8JImKW0=;
 b=QYp4cLcCNq2qQ5ToKUJh4Cb1CL7lYpw31wr4V0AnImqZKRSVD95RVfDxT4aCL5YByn
 qTSUDteS5HtPclIS9TrXTRm/bTQE5HfTcandgr8eOh4M43oXfanGwOMBpLGtilRmtj3x
 kfoht8zmOZucpTKhLrg4MvVF5QxS0XowKm1ekW6FuB8mC/mWKFewClTFfzfexjPtLmgC
 OAc5If7z6jz3TyVNndvqSpfJ2i75C5wtWqNscdjRzvNQQ+1ETg6bXEXphsjAueBRWfEo
 +NvGO7h6YtCdHFPmZdr2zNNfBHSjXwJlBXDyTnGxvNR0JPvqMymGuYAe4hKfrMEW/t7S
 iiVg==
X-Gm-Message-State: AOJu0YycTOI8EQFlv5Df/XkEMagOwtuQZocdLi/QA13ggPDq5F11wiXl
 YiZSnOg3MkX1f0BoB/KN2DLpIvpRdljw5A==
X-Google-Smtp-Source: AGHT+IFDLpxCZNS1nZaWXFfbL0Qz+KalAUozXFnUwdorNdWC3gGHXn5UNlLNInmNypjXhCCaw7+rvA==
X-Received: by 2002:a5d:4849:0:b0:336:8f9f:c69c with SMTP id
 n9-20020a5d4849000000b003368f9fc69cmr10597659wrs.40.1704303554593; 
 Wed, 03 Jan 2024 09:39:14 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 x18-20020adff0d2000000b003365aa39d30sm30989513wro.11.2024.01.03.09.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 09:39:13 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3FDAA5F951;
 Wed,  3 Jan 2024 17:33:51 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Bin Meng <bin.meng@windriver.com>,
 Laurent Vivier <lvivier@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, David Woodhouse <dwmw2@infradead.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <bcain@quicinc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Beraldo Leal <bleal@redhat.com>, Paul Durrant <paul@xen.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Cleber Rosa <crosa@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 21/43] readthodocs: fully specify a build environment
Date: Wed,  3 Jan 2024 17:33:27 +0000
Message-Id: <20240103173349.398526-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240103173349.398526-1-alex.bennee@linaro.org>
References: <20240103173349.398526-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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


