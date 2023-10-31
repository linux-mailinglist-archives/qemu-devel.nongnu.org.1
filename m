Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 892767DCF87
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:45:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpyS-0004mA-Fy; Tue, 31 Oct 2023 10:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyQ-0004lZ-K9
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:06 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyO-00026t-Or
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:06 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2c514cbbe7eso80046641fa.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698763443; x=1699368243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K56e2j6HhTbRJYsH8gBjmdIthJBVnnxscxJWS7h1h0Y=;
 b=QEqeF8zzxsmtCOnpd5EOAAmu1eIkE94o9sxfxHhL2O/oY+zqP32eYB3E3Sqi06ZnFB
 UN9X3ERon+fabNafsid4dpj6QXUEB1BoQRoRS+bIN3JxqiCBV484zCzSMVp/6wpbIvbT
 YTri93CuunBPfZzs8lBIjpeRkX0uJaZMyYD64CF+pBWhALtKYDPAyBR/qY7PfnfMWhOx
 EW3OI3aU3CtaNISL/X00hkEpxzl5TD2Fv/LRasge3AHGEy1QAKU1wjWeKVfZ9+IswaZj
 MQhdpX9WeIElX3btrVqrDKLQJ1N9/u0MxzhpHfHJxMLassFcJpcqOwFnxJhz89P3rMkz
 pBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698763443; x=1699368243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K56e2j6HhTbRJYsH8gBjmdIthJBVnnxscxJWS7h1h0Y=;
 b=LeuaUy9+POmJKf21A9r6jEDPUVCTbiCzO0AxCnTRzdOdUhX7XnSSds4NbzqWlx+LvB
 qeN2j2WV3C6AbHioRBkENPmqBhUHhFKqiXJ2PfSk66n882epkH+lS+rWHZViMmXPllen
 jNsS3jhFNIdmuxVAJQZ8i/GbUy1t5Sp7V8P6R6hsGhl2Pces1HDKorAg9F7sQ5BPkEQb
 IGzFQeQ3IHltU385XCa9XQqEZZNwHKLfWrLra5cc3iP+17PdvkWOSGztVA/j0WDAP1H5
 uLXa7juXYXadvNnqri5EECFCWoakpQKx/2+mmA0UStwX87RhnvILUR9g422YqK71fjOu
 1Log==
X-Gm-Message-State: AOJu0YzW1Y9y+i8cS5Ltvd/gDoqWgNhpaeuDRdb+y+H4J1/mmDdsEmxN
 /XV/t3cyor9HhpMLy3pCEMMlPQ==
X-Google-Smtp-Source: AGHT+IHa3u1nTmcy7hw0Zt8OHKxkRtHpj1ynZwf0YuAxX17PKwSLIkmpaD4nKldF36l/iGqoqtqirw==
X-Received: by 2002:a2e:98c8:0:b0:2c5:32a:cfe8 with SMTP id
 s8-20020a2e98c8000000b002c5032acfe8mr10209224ljj.44.1698763442808; 
 Tue, 31 Oct 2023 07:44:02 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 u24-20020a05600c00d800b004068de50c64sm1885295wmm.46.2023.10.31.07.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:44:02 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D865765712;
 Tue, 31 Oct 2023 14:44:01 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Brad Smith <brad@comstyle.com>
Subject: [PULL 01/19] tests/vm/openbsd: Use the system dtc package
Date: Tue, 31 Oct 2023 14:43:43 +0000
Message-Id: <20231031144401.1238210-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031144401.1238210-1-alex.bennee@linaro.org>
References: <20231031144401.1238210-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22b.google.com
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

From: Thomas Huth <thuth@redhat.com>

We can use the pre-packaged libfdt from the dtc package to avoid
that we have to compile this code each time again and again.

While we're at it, the "--python=python3" does not seemt to be
necessary anymore, so we can drop it.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231016154049.37147-1-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231029145033.592566-2-alex.bennee@linaro.org>

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


