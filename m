Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2107D7DACDE
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 15:53:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qx77i-0007PR-Tp; Sun, 29 Oct 2023 10:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77g-0007OT-N7
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:40 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77d-00055c-8P
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:40 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2c4fe37f166so50410171fa.1
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 07:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698591035; x=1699195835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TtzoHzFGZpHfaBrIL5GLx8N7pNMzudr01+mXCMwBIpE=;
 b=rTsbYLgltU/oi13OLKGFidFRked0T/0ThrtiyQEaFal2pTCRJXNizOQbr0VaR9WlWA
 AkbrOgbocVy/wB3X95J1a/opZz1o11WujXlC0XyMFLwLntFkUS5tZSFQMs2zIgIXzzlq
 glcMbm6JLY3WS7gO3mXTampUr0Ol443Fko8xSGrUJdfJ5AQAgySESXLQgSZ6yQn/Qg6E
 SJcVKEhwfiS3EicqoaKKHRDwhjfjJTdudfL+WaoblEkq/A5sIHhs7XanI86lglrtMTOa
 4sBU5pBIgNtPmZZFArIYLBysftvWzfUdLHwvRlRDJZCIOOJvtCXWDA3kYSujg93mDpgL
 ntTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698591035; x=1699195835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TtzoHzFGZpHfaBrIL5GLx8N7pNMzudr01+mXCMwBIpE=;
 b=Rfm42vXe75TR2LsnfoL64Gw6xO+ucjQ980HmpCOjxeR623ZkyeTYJ4wJOK9Bzr1t1o
 UJnZ+VYeyvc6dabyVbAxN14eTAE7FFy8Pvu7C4IhDz5yjs+zk3XQsE7JcGRmzHqa5+QN
 pL+RpVUV2cjiYRVrchGkeXzATcX71koZSO/5cexe46ooQPg0l19sSBUUWosVnaN/J25W
 OO5++GWEQBY2Il7pNd/a/vDh4prRKukVqf/bW9TPhH+Z99RywNixaMPFNFm2pNMSU+5G
 Rouo+DCTvGx+QmB25nJMEmorC11ceOUL9jea7vQ7fED8rzfCy7sTIVJil0mwW0MHrBiJ
 mNVQ==
X-Gm-Message-State: AOJu0Yz4udKizcohZOldrMtODt2DXGIFUoHRyOWPZQ6KVsroNQSlN5aF
 oos/XggwqRlbAjlghAXR/WmayQ==
X-Google-Smtp-Source: AGHT+IGlMoB35lwjgdxoqFVg7cRdOnpHQkpm1wlrTmjRJuFq8jtE9vw3F8qT3QWXJMoAT2+kNqSYFg==
X-Received: by 2002:a2e:9a91:0:b0:2c0:a99:68e7 with SMTP id
 p17-20020a2e9a91000000b002c00a9968e7mr6337802lji.19.1698591035005; 
 Sun, 29 Oct 2023 07:50:35 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 q7-20020a05600c46c700b004076f522058sm10333416wmo.0.2023.10.29.07.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 07:50:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 236545F7A1;
 Sun, 29 Oct 2023 14:50:34 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Brad Smith <brad@comstyle.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Kyle Evans <kevans@freebsd.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Brian Cain <bcain@quicinc.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 01/19] tests/vm/openbsd: Use the system dtc package
Date: Sun, 29 Oct 2023 14:50:15 +0000
Message-Id: <20231029145033.592566-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231029145033.592566-1-alex.bennee@linaro.org>
References: <20231029145033.592566-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x232.google.com
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

From: Thomas Huth <thuth@redhat.com>

We can use the pre-packaged libfdt from the dtc package to avoid
that we have to compile this code each time again and again.

While we're at it, the "--python=python3" does not seemt to be
necessary anymore, so we can drop it.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231016154049.37147-1-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231028103311.347104-2-alex.bennee@linaro.org>
---
 tests/vm/openbsd | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 6b4fc29793..85c5bb3536 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -27,6 +27,7 @@ class OpenBSDVM(basevm.BaseVM):
     size = "20G"
     pkgs = [
         # tools
+        "dtc",
         "git",
         "pkgconf",
         "bzip2", "xz",
@@ -67,8 +68,9 @@ class OpenBSDVM(basevm.BaseVM):
         cd $(mktemp -d /home/qemu/qemu-test.XXXXXX);
         mkdir src build; cd src;
         tar -xf /dev/rsd1c;
-        cd ../build
-        ../src/configure --cc=cc --python=python3 {configure_opts};
+        cd ../build;
+        ../src/configure --cc=cc  --extra-cflags=-I/usr/local/include \
+                         --extra-ldflags=-L/usr/local/lib {configure_opts};
         gmake --output-sync -j{jobs} {target} {verbose};
     """
     poweroff = "halt -p"
-- 
2.39.2


