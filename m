Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1165774F102
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 16:03:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJDwM-00032T-77; Tue, 11 Jul 2023 10:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJDwL-00032K-21
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:02:05 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJDwF-000824-8e
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:02:04 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-99384a80af7so663339166b.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 07:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689084113; x=1691676113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LsVbQDzTSwp+23NIUM9Hpbj8QGWieQ9A3lfiJDyMzDQ=;
 b=hl0U7FqdHFvQatIk6gV4ujDSFDkmcCg7wWRJ0losznKMW6BVtaUtGyF2Fp+10ZzHMZ
 FvJDFU+73ZRhS8kO6xXWHXeQclQ30bDHPBoQcf4lPOqc+xplG1w0Las9KwmG8YxuBBg9
 CKcMlI11//4xA2W65GiRI6gxCcjwl+qSZb5PJPSLJWOh0osdYCg3GaO4M9lfzwTnQdA3
 GZCv9qycuZTV+MadJfbl0yO9NJGm5MQ7G3wmI71R6EEw5Wq+yU9Pa3EnQNIT6ejfcbAe
 NwfbyPEd15X687B83U+ZKLhJUb358td7H+Wdnke49cWVnACgBTJpfLz5wRm5kSuAKkqp
 Ik4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689084113; x=1691676113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LsVbQDzTSwp+23NIUM9Hpbj8QGWieQ9A3lfiJDyMzDQ=;
 b=EcDJDGIvuG4bnS5IO/Golf8t8AM4Iz+kqZ3+bUO23Sf11GpICZ9j/T+vjDePi0DhmK
 Y4U9V1C3pkRjxMsmPtgC7268Ue7sVzYCdZzNKGjgHZls1C0ZXXC0D11gX0v17FSnPj0a
 3ckojqDp9EjukYVNwPcR+/x26+gkL5sMUqa3oRoKrYJ3mA0De6y6RoS8VsL/Z/qrgSXG
 qRQHZEn4oJN0nT/tUDlQ5EN36NFLbZJZw5+5V+vdnYqoMTUu59/Dr22uvzVwG8ptY9Qp
 75b24mvPirAjRjF4vKdNtPqc8QZDBNplf6dyauE8kcMB8YoZWngwpZSnQXo/aEZESrsK
 ztYA==
X-Gm-Message-State: ABy/qLYK54O3y/tVKEbpP+hcQ34qWEMfuClOgMzghqWobYD2A2MgoXlt
 ZfhIELpRg+6ObmjC3kOmfZb4exNqu9KoOrTMhHY=
X-Google-Smtp-Source: APBJJlFnUnKs0M2GY7UQ54z06PwCM5U8nXM78V+2YZ9DYDkj3Jhp9FVeTpYa+H7haPgorPCtKey8Ug==
X-Received: by 2002:a17:906:51cd:b0:993:d6e8:2386 with SMTP id
 v13-20020a17090651cd00b00993d6e82386mr12185713ejk.16.1689084112929; 
 Tue, 11 Jul 2023 07:01:52 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a17090603c300b009931baa0d44sm1229137eja.140.2023.07.11.07.01.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jul 2023 07:01:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Erik Skultety <eskultet@redhat.com>
Subject: [PATCH v2 1/3] tests/lcitool: Generate distribution packages list in
 JSON format
Date: Tue, 11 Jul 2023 16:01:41 +0200
Message-Id: <20230711140143.65818-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230711140143.65818-1-philmd@linaro.org>
References: <20230711140143.65818-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

Add the generate_pkglist() helper to generate a list of packages
required by a distribution to build QEMU.

Generate the FreeBSD JSON file (based on FreeBSD 13).

Suggested-by: Erik Skultety <eskultet@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/lcitool/refresh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index b54566edcc..a5df096074 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -84,6 +84,12 @@ def generate_cirrus(target, trailer=None):
     generate(filename, cmd, trailer)
 
 
+def generate_pkglist(vm, target):
+    filename = Path(src_dir, "tests", "vm", vm + ".json")
+    cmd = lcitool_cmd + ["variables", "--format", "json", target, "qemu"]
+    generate(filename, cmd, None)
+
+
 # Netmap still needs to be manually built as it is yet to be packaged
 # into a distro. We also add cscope and gtags which are used in the CI
 # test
@@ -191,6 +197,11 @@ try:
     generate_cirrus("freebsd-13")
     generate_cirrus("macos-12")
 
+    #
+    # VM packages lists
+    #
+    generate_pkglist("freebsd", "freebsd-13")
+
     sys.exit(0)
 except Exception as ex:
     print(str(ex), file=sys.stderr)
-- 
2.38.1


