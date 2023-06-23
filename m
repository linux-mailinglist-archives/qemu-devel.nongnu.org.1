Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0365373B730
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:28:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfoT-0006QC-5u; Fri, 23 Jun 2023 08:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfn3-0003pS-Ne
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:27 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfmp-0003iv-Uh
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:20 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f90b4ac529so7561095e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687522867; x=1690114867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=45GYP/JtJUGxc1t0ZJqBnVyPwHBwWmagxJQ92CrfkDY=;
 b=MASR4jubaJF4yMx6QhLUzaP0taiF6ciJadXweFghiMDBZn38BORedd9C+r5UZ6+ffI
 5xMfWHW8jaYB+m+CBv2zY5Co6Gd3n+qU39sjYwxB9lVcn1R6GeuwXCrdwsLjKpqznRn4
 hSLRj1yQqCVHeEnqrX4deIMJ6WiQtnRNfnstVQxiryci+OkYNFY9Nao48jBk5d6eZNvu
 WXeCRHjDNYqmH/emssg4BqmsTzPjKuWvg7Mi0fgc60aIg0Brw6nSaefYzqWIzU0yFh1U
 2nRS9nQtJRDdw03zRxCJQ6RCNA8Sf9UELJxN1Gyj+VQFNjc0BEmC616FwZhyrYxbthV6
 p0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687522867; x=1690114867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=45GYP/JtJUGxc1t0ZJqBnVyPwHBwWmagxJQ92CrfkDY=;
 b=dvTps9ZnubmpUK6xnf4znOx+gZYf9GPjY2nfiq+ploAno1QTEtQCewW0TZ+jfAaqdH
 SrRlUP8EYVDDMI7p472iAsgx3hpU7GSV+KqeoW7IwMsMMGOCTUKXSXQt5ZAY93pIbI9G
 N2r8j5BpiyjUDVGrubMl7TrkdNXQE+C43yzNQZHny4aWQfYNs+PTUPXvi9QPBHjx0AcJ
 hMGmpw8tO8aL8juFdnP3o5HOUJzm6vIl0Z0boQMPFtJy0cyVOMYAqT0CUXqyot9uBgEQ
 XqUQb/N3dMkC5c90jf4WrtzVjTGBJQN0JGbOqopgLFxPArN5yXzK7nhhiQ7w2f2uuHaE
 ehtw==
X-Gm-Message-State: AC+VfDzy47XyhzDB2e/gPLcNaPBkCSBuRxGTxEne1DUg6uhT+jn9/2ev
 gXfI/2Cvk6NZstG4Hxbgv1Qkjg==
X-Google-Smtp-Source: ACHHUZ4sbToiX5OVJQGZ1kz53JGDHIGF1qcSS4BI8pK99iGzVXKlFOtKTZwGOcDqIh2FVuZs4UyHiw==
X-Received: by 2002:a7b:c017:0:b0:3f7:aad8:4e05 with SMTP id
 c23-20020a7bc017000000b003f7aad84e05mr16715012wmb.11.1687522867668; 
 Fri, 23 Jun 2023 05:21:07 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a5d4d8d000000b003048477729asm9433125wru.81.2023.06.23.05.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:21:07 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 489A91FFC6;
 Fri, 23 Jun 2023 13:21:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>,
 qemu-arm@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Riku Voipio <riku.voipio@iki.fi>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Bulekov <alxndr@bu.edu>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 15/26] tests/lcitool: introduce qemu-minimal
Date: Fri, 23 Jun 2023 13:20:49 +0100
Message-Id: <20230623122100.1640995-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623122100.1640995-1-alex.bennee@linaro.org>
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

This is a very bare bones set of dependencies for a minimal build of
QEMU. This will be useful for bootstrapping cross compile images based
on things like Debian Sid where stuff isn't always in sync.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/lcitool/projects/qemu-minimal.yml | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 tests/lcitool/projects/qemu-minimal.yml

diff --git a/tests/lcitool/projects/qemu-minimal.yml b/tests/lcitool/projects/qemu-minimal.yml
new file mode 100644
index 0000000000..507f1f6881
--- /dev/null
+++ b/tests/lcitool/projects/qemu-minimal.yml
@@ -0,0 +1,23 @@
+# Very minimal set of qemu packages, used for early bootstrap
+---
+packages:
+ - bash
+ - bc
+ - bison
+ - flex
+ - g++
+ - gcc
+ - gcc-native
+ - glib2
+ - glib2-native
+ - glib2-static
+ - libc-static
+ - libfdt
+ - libffi
+ - make
+ - meson
+ - ninja
+ - pixman
+ - pkg-config
+ - python3
+ - python3-venv
-- 
2.39.2


