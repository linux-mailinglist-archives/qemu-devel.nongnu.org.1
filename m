Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D5981C961
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 12:50:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGe1X-0004e6-5w; Fri, 22 Dec 2023 06:49:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGe1P-0004Wv-9W
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 06:48:56 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGe1N-00040e-KB
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 06:48:55 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40d3352b525so17400815e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 03:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703245731; x=1703850531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UcNQNKUtd9L8dnm/vomapOEDlbZmNJZwoNMjNIrhxbQ=;
 b=FO2gbRugLjRZz4SuT1pZpl+jii6BXpKk/IGjWAzokaoPe1XQ9ZQF7ElDOGKE4+R15y
 rl5a46bDvEhRCvOA0MlSa25CI8dxVmMaLpEmDmfgAexdVcuoMFI5+7NseI9edgaT5Jgc
 oNOOgstamFWhHYJnMR48dgbih8IjdC+QwjvQhhuGvRHuUe35so4oNw8/9sKIGP2OsYzZ
 E2TYNkr0NKWjrW0NhCwDYqdJtO6s5niOlijLHK0VyzRGN0jHrvcta1QDF9pvcyDUFY0M
 18pTFfffxSxGml6JYP4DOiFwbIZjJyGK21bGdk4VPkDOSrZUzBnLZ1V6oXP7KI7Y1BSq
 7QGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703245731; x=1703850531;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UcNQNKUtd9L8dnm/vomapOEDlbZmNJZwoNMjNIrhxbQ=;
 b=NCIGMRNWA5pRLlXZSsQYWvoVK8V9XuKFFo1434y2+sL2vGEV4pI/4krC1BIbuXUh2s
 cP4aZtA7FpbcUz7STXI8Wd/XOBj21osFs66go0J3JA7Wsclpl2CpHStANWnp7Q1l8U10
 1B2Vu9JINH6Ci3fHLjoAHYJpLwIejT4UheFv4xS5Y45watZ9oMhtlrSFjiepvI/pgPoR
 36PVTMNp/0gyr9qS+pvpSJwYQpavNo8RJXgWcSsxJnPY0yVgnkGXKM9L1r/e21c1ZoG4
 NsCK9NUPiGJN+tfK9NDrgv2dhV7P0XI0fkSFsXMNkLoQGCqQ7gjwLTdBc6+aFQssy9ba
 lK4g==
X-Gm-Message-State: AOJu0YxvxnSQfQw9SGBeD+FTRJ/eeXgBjrYKELXB6TPiSvV6tU2Ay1ew
 VJbi0TPSZiXpNafytt3O5YqXiqrJKG2xog==
X-Google-Smtp-Source: AGHT+IF2hgTqfsWJOzqa9Mam5npQ2LepoS2I8F79+wg/7MbILGYxWJTcLjDn3bBRPJyDYS79hzgFUA==
X-Received: by 2002:a05:600c:3093:b0:40c:2b4c:e9c with SMTP id
 g19-20020a05600c309300b0040c2b4c0e9cmr726458wmn.102.1703245731545; 
 Fri, 22 Dec 2023 03:48:51 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 g3-20020a05600c310300b0040c6b2c8fa9sm14495936wmo.41.2023.12.22.03.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 03:48:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D00915F76B;
 Fri, 22 Dec 2023 11:48:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] meson.build: report graphics backends
Date: Fri, 22 Dec 2023 11:48:46 +0000
Message-Id: <20231222114846.2850741-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

To enable accelerated VirtIO GPUs for the guest we need the rendering
support on the host but currently it's not reported in the
configuration summary. Add a graphics backend section and report the
status of the VirGL and Rutabaga support libraries.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 meson.build | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/meson.build b/meson.build
index 6c77d9687de..93868568870 100644
--- a/meson.build
+++ b/meson.build
@@ -4307,6 +4307,12 @@ summary_info += {'curses support':    curses}
 summary_info += {'brlapi support':    brlapi}
 summary(summary_info, bool_yn: true, section: 'User interface')
 
+# Graphics backends
+summary_info = {}
+summary_info += {'VirGL support':     virgl}
+summary_info += {'Rutabaga support':  rutabaga}
+summary(summary_info, bool_yn: true, section: 'Graphics backends')
+
 # Audio backends
 summary_info = {}
 if targetos not in ['darwin', 'haiku', 'windows']
-- 
2.39.2


