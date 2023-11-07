Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9187E41CD
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:28:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0N0K-0004Tt-Gj; Tue, 07 Nov 2023 09:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0N03-0004GU-W7
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:16 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0N02-0007ct-98
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:15 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40906fc54fdso43946525e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 06:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699367051; x=1699971851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wH+UzP6R6aU8otN15bfPCxhN8TIF9sNRq1R7pMAWDew=;
 b=ipfa/ZisHgt7tKHn+CrTed737FhFIWb5ulOxw9gNsVDPbALldTd0jDM61kfItrIeP0
 BluWCDhfRSBP6dTMeldJ6W59qC5LWtAzLnWOQcGXsbTCos9mgudCKjY+3pQ7LJiEDbNQ
 PJF1WURtttDCU0Hdo9EC7ZfCru8q3q+PtmTXssejaF0x53kNXc/aHXh2ESwG+UxTTBVj
 3L1LCV+uDGzolQdaHdojqTyO5pr+BfN5MTiitJqbpIKiivwJ276yPVZxWxgVI4IOUNLJ
 jfhgszetNA0RHtu14FLbx6LpF1nJRuQQbJr4Nv3xtaWbx2Q52x8/JlzcoQK4VN7zo/yq
 sqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699367051; x=1699971851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wH+UzP6R6aU8otN15bfPCxhN8TIF9sNRq1R7pMAWDew=;
 b=CvK48HFaKA0Ez/Wz8Sd3uj60vqU+cRd/+9CUYJBgJhISlGnRV+meJcAseoWdkHKGvi
 wQVXrfMrg/NEjmdozmc/MKN1nPw1SSaCqnl+/ZBwCWdkp1TJeJUWec/63pVnD2/eo6et
 6VQEZ+bh/was7/kYrGr1Jb5J6rcVBk6TAH/vaHQf9hfvVpo7eOHacW3AUCOPumabXlfL
 Q+RrlEg/uhdQsCfninTWwdLrBV4ZGBvGBtzlenWLk9WirrI3x6h6wqJUtWRIpD/aPKGK
 6yQ2ZgKCDztFRIckT1mgqfwFieKF+R/skpxw+SeaRCJ93PJBfzL2Gc13gIR4Nrdt6YaT
 ZaFg==
X-Gm-Message-State: AOJu0YzrD3wQD5Hd1IDGWKoYGMoskMv2544qx7/vgGiKYx/8KhPuY/Y7
 9NRA/qFJsQZ1n9WW4QMkCtbKeA==
X-Google-Smtp-Source: AGHT+IF1T98r8kySvcv8LWReXN7jPRn5U6LxyX8+dAt5EknfWUf9ukpvp7xCgZI883jrWFV0j9VD1A==
X-Received: by 2002:a05:600c:3112:b0:407:8ee2:9986 with SMTP id
 g18-20020a05600c311200b004078ee29986mr2445999wmo.26.1699367051178; 
 Tue, 07 Nov 2023 06:24:11 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bh7-20020a05600c3d0700b00401b242e2e6sm16058402wmb.47.2023.11.07.06.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 06:24:05 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2370365765;
 Tue,  7 Nov 2023 14:23:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Greg Manning <gmanning@rapitasystems.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 17/23] plugins: allow plugins to be enabled on windows
Date: Tue,  7 Nov 2023 14:23:48 +0000
Message-Id: <20231107142354.3151266-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107142354.3151266-1-alex.bennee@linaro.org>
References: <20231107142354.3151266-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Greg Manning <gmanning@rapitasystems.com>

allow plugins to be enabled in the configure script on windows. Also,
add the qemu_plugin_api.lib to the installer.

Signed-off-by: Greg Manning <gmanning@rapitasystems.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231102172053.17692-5-gmanning@rapitasystems.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[AJB: add check for dlltool to configure]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231106185112.2755262-17-alex.bennee@linaro.org>

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
index 4848930680..d7d841e71e 100644
--- a/meson.build
+++ b/meson.build
@@ -3944,6 +3944,11 @@ endforeach
 
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


