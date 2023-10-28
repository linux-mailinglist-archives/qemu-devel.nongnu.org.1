Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2B17DA66F
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 12:34:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwgdC-0006Ag-2G; Sat, 28 Oct 2023 06:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgd9-000694-Tg
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:23 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgd5-00038n-Tu
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:23 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-408002b5b9fso21420015e9.3
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 03:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698489193; x=1699093993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t+wjfKtC3t92gnbhw0BVnIQd/2GtTprk8NcwGcBfDuk=;
 b=KDoWTs3kx54w1GxP4wBNjXtT1BN1wgxbyAokjSxTmEwuRXVOLD5rAgf9EeVh27ubhJ
 /Kzfb3acSgPOH3laX3xsboRoyKyBbvLn4kesTHeXZd0WVRyomX4W1s2aAvPHXZWFAv6d
 Z+5+4gB7Vn0P4f7rM/eNVpoTXDaBkIppJYWzIwpREbkDD74IqNh+aj8YXJt6lxsBZ6DF
 YBZLMwJbJdfRy5f22ItRGJm+fHxNHd1fYo6B/wDqncHOuAxRmhDTNhYtvdsn8uoIQTlW
 drvkoQD6HWX9D4d5AccC1R51ixT9pSx1DwAJfZ+RMqvPW+2gEZtiwbD+n6RN9WdIDqd6
 NnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698489193; x=1699093993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t+wjfKtC3t92gnbhw0BVnIQd/2GtTprk8NcwGcBfDuk=;
 b=lko57Z9Md8GxsFCmW8rAnRVnPkp14lMOJvqH6rMkQB+xtNtCR9hYTSJ/nDMV6n8tsW
 jOPmMUFrMXZWGbE7p8LBR/Xdeo2HEzOuWQT9B/4jVAgdF7ovbG7clrX/kC4gxJDET2Qp
 ox6HUzpX39smxxG1jYAVCemskYGcFYE/IWIdGUCGF+RoB2jQvwUFFFE5dnk8LqYXrocI
 elQHwj1BGzD7XadQe8dbIipz1lleLP0WAYCQo73fOXc8tIaiVTDsSZ4uht+zNFCpQlvX
 AH+uQVW//aq4pdbzTRRSsuj6UIIz2EiP2n8qrkD2U/obn/E5q7Youk+Pxev/Vyph3Eil
 G7qQ==
X-Gm-Message-State: AOJu0YxN6HBpTr9AiJ+mCwK4qBIEEAsAgrlx83K9jkPkV7qID9QVCxqM
 +JlX8F4wVNWk5KW97FbvX+ipsw==
X-Google-Smtp-Source: AGHT+IHmAMEph9EaBAYR+VxUH6+EItCcs7rC6ICMNzqz6EjxFNyrdTizqRw/gtFS8CC8aGvWawwtYQ==
X-Received: by 2002:a05:6000:2aa:b0:32f:7cfc:68ab with SMTP id
 l10-20020a05600002aa00b0032f7cfc68abmr882512wry.8.1698489192796; 
 Sat, 28 Oct 2023 03:33:12 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h6-20020a5d4fc6000000b00327de0173f6sm3539309wrw.115.2023.10.28.03.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 03:33:12 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0F02D5F797;
 Sat, 28 Oct 2023 11:33:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alexandre Iooss <erdnaxe@crans.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Brad Smith <brad@comstyle.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 01/17] tests/vm/openbsd: Use the system dtc package
Date: Sat, 28 Oct 2023 11:32:55 +0100
Message-Id: <20231028103311.347104-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231028103311.347104-1-alex.bennee@linaro.org>
References: <20231028103311.347104-1-alex.bennee@linaro.org>
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


