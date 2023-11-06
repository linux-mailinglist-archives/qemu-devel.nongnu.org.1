Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FE47E2C85
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 19:59:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r04o9-0002xC-Vq; Mon, 06 Nov 2023 13:58:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04o7-0002wH-Sb
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:58:43 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04ny-0002QF-Bk
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:58:43 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4083f613272so42115905e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 10:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699297112; x=1699901912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eQYn9T9uZSh6JgFI7JEYQpVIP7VUC/yhVeEeSSJ6yyU=;
 b=Ffz08mJmPHnSu1CketK/PB+eYFpgdH/qpoMMKAfhpoZkmD9z7sEXDzLgx8Pa7HP6Nn
 u+7cmxOwpTdhScL6Yj4uZrsvBCl8HkNTKYtVmeHyHKdLcu3UObrSiGSeiJOs8GdeXI7f
 Q79Ox1qT55VchkthkGehmExo8SCqHan5iFqbK7O17npmoFOp6qUK6poV5tSJUtvF3Ta0
 tbcCQVumTFWas3/6oPSnaETOk2xA05848NWbEdu/VPpAcimtVnOrruZzoF3FMfX3btU5
 Vza+DQiB2h9Owa6oN6834CrFsQO3otfOpNNTyB7slJeglgWU5V/Bpw3hKhwhkd7/MXnM
 zCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699297112; x=1699901912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eQYn9T9uZSh6JgFI7JEYQpVIP7VUC/yhVeEeSSJ6yyU=;
 b=SUJB1PPhjZgNOsj5ZYzMFFIshvtVJBg2aeYkINvT/A8waq6YI5b7zv33OL5yvcjOWs
 veBiIJUswwRZxCyOJm998Le+j3ytpWjtS0tABrxiSet7dwxbtDpfeqFFK/fuO/pxrN6i
 oVGNoOSBW3w+9WhtWLrO5d1pZLZl1jrKjW78eS+tf4rwE8WyuKQSQvKomYkekNZNV9W/
 VUC6r+sXp1qjFL8yr0+fQ7KCANDncDRuCcM6SeMvLeaHV85P6Ae0sANFWNnn7vUX/FcX
 4F/4+rKTb2aMYO+1UyX3v6KtGdNRA84mjsGNyGdMB8Hn1onZdc2M8PUUE1k24KrJAYHt
 3Obw==
X-Gm-Message-State: AOJu0YyK3CgEcdC2BFzqjKqwiP+FZhaPPlONyZ2yFPR6Ze/TsUQOJ1tv
 xmuQOOiDImIBBe7RcW7egCKmVg==
X-Google-Smtp-Source: AGHT+IGtsF0grBWuUcGA6NZ7mxp6IgMVm9YnBZXjtMggNggfSp3xeYboy9hwkwaqtWSlxyI+vSQmfA==
X-Received: by 2002:a1c:4b09:0:b0:408:4eb2:3b1b with SMTP id
 y9-20020a1c4b09000000b004084eb23b1bmr506592wma.21.1699297111806; 
 Mon, 06 Nov 2023 10:58:31 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 y23-20020a05600c341700b00406408dc788sm12869598wmp.44.2023.11.06.10.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 10:58:30 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E75A265760;
 Mon,  6 Nov 2023 18:51:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Greg Manning <gmanning@rapitasystems.com>
Subject: [PATCH 16/22] plugins: allow plugins to be enabled on windows
Date: Mon,  6 Nov 2023 18:51:06 +0000
Message-Id: <20231106185112.2755262-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231106185112.2755262-1-alex.bennee@linaro.org>
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

From: Greg Manning <gmanning@rapitasystems.com>

allow plugins to be enabled in the configure script on windows. Also,
add the qemu_plugin_api.lib to the installer.

Signed-off-by: Greg Manning <gmanning@rapitasystems.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231102172053.17692-5-gmanning@rapitasystems.com>
[AJB: add check for dlltool to configure]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231103195956.1998255-30-alex.bennee@linaro.org>
---
 configure   | 4 ++--
 meson.build | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index e50ec99fe2..abcb199aa8 100755
--- a/configure
+++ b/configure
@@ -1011,9 +1011,9 @@ if test "$targetos" = "bogus"; then
 fi
 
 # test for any invalid configuration combinations
-if test "$targetos" = "windows"; then
+if test "$targetos" = "windows" && ! has "$dlltool"; then
   if test "$plugins" = "yes"; then
-    error_exit "TCG plugins not currently supported on Windows platforms"
+    error_exit "TCG plugins requires dlltool to build on Windows platforms"
   fi
   plugins="no"
 fi
diff --git a/meson.build b/meson.build
index dcef8b1e79..b855224acc 100644
--- a/meson.build
+++ b/meson.build
@@ -3904,6 +3904,11 @@ endforeach
 
 if get_option('plugins')
   install_headers('include/qemu/qemu-plugin.h')
+  if targetos == 'windows'
+    # On windows, we want to deliver the qemu_plugin_api.lib file in the qemu installer,
+    # so that plugin authors can compile against it.
+    install_data(win32_qemu_plugin_api_lib, install_dir: 'lib')
+  endif
 endif
 
 subdir('qga')
-- 
2.39.2


