Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A9C8146E6
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 12:29:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE6NJ-0002nD-SI; Fri, 15 Dec 2023 06:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rE6NF-0002m7-2r
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 06:28:58 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rE6NA-00087N-5a
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 06:28:53 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d0b2752dc6so3907055ad.3
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 03:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702639729; x=1703244529;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VZJAznuesX8ySXoW7pIxzli6WPy8swHkLJj7jCZBmjA=;
 b=G25HGncS9UR8AIFhxopZvGpggzJNUB9q/z+oAtzOlGaofABCXORE0D2yPabThWHoSV
 uQQVE7XwGJibGxcK6wZhHQJXMlY63KGMOzJ1woBhXaFihvzOxgjplaF+A+gQF3vKZih4
 h+PE0qJNN6F5DzOaHXc/pzv0BLQjoGh6Su2w9k4Qx21BcIm/ONwQj6xLySc55+L0vgj5
 YCFOgfo4/gvcbtGi2QoiJk0VbF/r9pWosSR+erUp5eo7g8Byk2IEOKshivWhcUfCqUMg
 8vOkKsjkIVc9jEl+OIRUXy+Jl16ge2XJYy1CPznFptOgClARPN20lVRscvfit/eSJL4p
 s6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702639729; x=1703244529;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VZJAznuesX8ySXoW7pIxzli6WPy8swHkLJj7jCZBmjA=;
 b=PUTPSfw9U28FXlci+OsTTUR0MuEyV4sCjCQXhXrtgu+tkeelBFsYGqg91QJz3oI+CP
 9x7/VrUAiwgcO3ZG8WnaHdJIoc/oy0ioq63Lj4TsCKgUeRGsQbR2HhV0csWFcdyiwJjH
 qMEV75m/8DqWsdCIpq0qjZgdF1YBI2W0fFUzmr83e1a3Fv2nzKsAysWL3djAIvtPUCcs
 c16mIObZ+LUi9JQmo8Vk5TmdioMWaxykte5tBzCzLqBoK8DyIIW/NLEs7jHxJwhEixyp
 xlsTannaM1oW8Saa2dvH0QfZwZM3PIcSbBkkv15JEQ/jI/GHkvEDWTFw7ofL4dCrerKF
 v0gg==
X-Gm-Message-State: AOJu0YwiEKp0JBpXdivFctT2QXW8ghzeglwnjapWMUX35A9Su69g38Yk
 NShwJyfgE+wkcFnj184+J8G+qg==
X-Google-Smtp-Source: AGHT+IGu5YlrwZKTb8f4Fu5k+B6lKlazWMxpyLpt5zRM1EDYHsMBMQ/oZ//UylWlYqgxKR57gXEgPA==
X-Received: by 2002:a17:902:784c:b0:1d3:185a:eba4 with SMTP id
 e12-20020a170902784c00b001d3185aeba4mr7713252pln.4.1702639729155; 
 Fri, 15 Dec 2023 03:28:49 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 iz12-20020a170902ef8c00b001d349240e60sm562423plb.72.2023.12.15.03.28.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 03:28:48 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 15 Dec 2023 20:28:35 +0900
Subject: [PATCH v2 3/4] meson: Explicitly specify dbus-display1.h
 dependency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-dbus-v2-3-1e2e6aa02115@daynix.com>
References: <20231215-dbus-v2-0-1e2e6aa02115@daynix.com>
In-Reply-To: <20231215-dbus-v2-0-1e2e6aa02115@daynix.com>
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Explicitly specify dbus-display1.h as a dependency so that files
depending on it will not get compiled too early.

Fixes: 1222070e7728 ("meson: ensure dbus-display generated code is built before other units")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 5e1b25a47184..c31168e11cfb 100644
--- a/meson.build
+++ b/meson.build
@@ -2032,7 +2032,7 @@ if dbus_display
                                           '--c-namespace', 'QemuDBus',
                                           '--generate-c-code', '@BASENAME@'])
   dbus_display1_lib = static_library('dbus-display1', dbus_display1, dependencies: gio)
-  dbus_display1_dep = declare_dependency(link_with: dbus_display1_lib, include_directories: include_directories('.'))
+  dbus_display1_dep = declare_dependency(link_with: dbus_display1_lib, sources: dbus_display1[0])
 endif
 
 have_virtfs = get_option('virtfs') \

-- 
2.43.0


