Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E322B745DB2
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:47:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJrU-00080V-FY; Mon, 03 Jul 2023 09:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJr7-0007Wi-4y
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:41 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJr2-0005hu-Qa
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:40 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fbc54cab6fso36477455e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688391874; x=1690983874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3QXiG/9ekTa+RipLUg3DjWaS82wOBRs7qXSyJ9mS8po=;
 b=OX8Lig9jcvKXa/fhr8tRctbnhrcGwT4msuel2EO76pRQzOzi+YGrxVblOK3LFh4uPn
 IazMnh45lmJm4OAL+6b8MWd00oIXtadrjnCHQy8whDFSqkVxdFKnu/C9yHoxrZazQF8m
 9Twlhhl2sAkolorUj5IoLXhz93X7Iw7XJEEYYXzqhPlkipVpzgisEL8vMtdBEFwJljqd
 nLx5UzzScVxJPk2qeTeZgFss+fs56qRgUxY9dXDhUlWj09oAjdflQZ6ZG9h/33KcuRoS
 jxdkTk1tlRgSbC+lTvWTlOzO/MGPg1G4Wj50TOl2mxNcZLQho8p3kJnDOyQTghcjU/cb
 9RZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688391874; x=1690983874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3QXiG/9ekTa+RipLUg3DjWaS82wOBRs7qXSyJ9mS8po=;
 b=S5JHD+wWb24nZtEyxVRX0H4B4B6HEfuhpNDMDhcisLA1HFtRIJo++ASS4IWNFy/bbd
 qqJ9YQtah9dlVDWRvLQIWoNC3HlnTYU/JCnKNI+GUBHxicauvjJYrCfgmYb8YY5EcLRd
 09E5fw2Hmf1h7jPkx7kmGQ1MQ2YxVTwdFuE6yEdUZZltCcwXKmJhgGvhK7Bmiws8HtdB
 cihCOfgp7Cl2cEA8wAIg9t/9re30lCWIFULE75muqKkAjKC7g+Iy2ACnF18nZPWM+ha7
 j5F9cC9O+3H6egHHIB+IRLEO2n/Et9upiQlxmKC49B7GeJZpAWm9jgl/u/klU41NiDx9
 Vl0w==
X-Gm-Message-State: AC+VfDznmQiHt9yZvIdyOCnQSyB2w4cF9Y5yq1gn0FmVYCvT0/9iNuRT
 8RGy7hM9JUl7bm8HyTsUjGiQS94mxlXrdBUI7k8=
X-Google-Smtp-Source: ACHHUZ5rNk1fo9IPiKahAtLooApFx7yq8FIwtVmdG5MQL4wbCJECLG7Z9LvoCWyeY5jRsFZLmmM/GQ==
X-Received: by 2002:a05:600c:230d:b0:3fb:973:fdba with SMTP id
 13-20020a05600c230d00b003fb0973fdbamr7789331wmo.31.1688391873937; 
 Mon, 03 Jul 2023 06:44:33 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 t24-20020a7bc3d8000000b003fba94c9e18sm17097059wmj.4.2023.07.03.06.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:44:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 71A721FFC6;
 Mon,  3 Jul 2023 14:44:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 14/38] tests/lcitool: introduce qemu-minimal
Date: Mon,  3 Jul 2023 14:44:03 +0100
Message-Id: <20230703134427.1389440-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

This is a very bare bones set of dependencies for a minimal build of
QEMU. This will be useful for minimal cross-compile sanity check based
on things like Debian Sid where stuff isn't always in sync.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230630180423.558337-15-alex.bennee@linaro.org>

diff --git a/tests/lcitool/projects/qemu-minimal.yml b/tests/lcitool/projects/qemu-minimal.yml
new file mode 100644
index 0000000000..d44737dc1d
--- /dev/null
+++ b/tests/lcitool/projects/qemu-minimal.yml
@@ -0,0 +1,27 @@
+# Very minimal set of qemu packages, used for minimal cross-compile sanity checks
+---
+packages:
+ - bash
+ - bc
+ - bison
+ - ccache
+ - findutils
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
+ - sed
+ - tar
-- 
2.39.2


