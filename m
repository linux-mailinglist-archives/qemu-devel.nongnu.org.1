Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B26BB7B6440
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:34:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnaoO-0002Gd-29; Tue, 03 Oct 2023 04:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnao9-00029G-B7
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnao7-0000IV-KP
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696321865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qJUl/ROgEOzlEPXIQ/RmbL6Jx87XvYZOKpE+KtRjM2c=;
 b=h7YVZSpYtX+lFGFxewfXIEEi1Ciha+29uJKCCImleUteym6nByvNE7bGeojLH0PpnTKxTE
 JKgFFOzcUxsbZT1gcld+s2r0BUTpzVLr1UtV2E/n2lOVoCSpIS8nYb6QzhYOvNLng/Dmxs
 Rg6AFoSOR5wiZlnCwn+fXGZSelZIvGs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-QZArtXkVPhu0InBXI27wVg-1; Tue, 03 Oct 2023 04:30:59 -0400
X-MC-Unique: QZArtXkVPhu0InBXI27wVg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9ae0bf9c0a9so50293866b.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696321857; x=1696926657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qJUl/ROgEOzlEPXIQ/RmbL6Jx87XvYZOKpE+KtRjM2c=;
 b=NJDymyCiYXfuGlOfwV9SbfvOuu79dci77xfBzxG3CWdhzdkCBBeWPu/lKy5U173ZLk
 eR2ZBq8skPrmFFZQbfCxXtO5szCNi5jihvF4wDL+y/F5+uuhdtv6oHDV0FsoUfCvI8Bl
 UE9kAuzOhgU9toitw+JlK/ZcjnonJ/79CW4JWcJQOswsrX4dQhIaMzcwEt/vBLtfmjuO
 ticUzxR0hpfjJgo01chIkDi91Zlz9J207S8KvHbvSTZHubdf9BN2aKCrJIkswrVU4izt
 rPPWUsc8wDwy6Q8oXJEV3lZyccq/cmR2wjlkWNdEZhIrK9mRJGsJJIQ6SIkN8aDU5L2n
 yCCA==
X-Gm-Message-State: AOJu0Yx9eztjCO/jYIl/iJQxplOZ63EmPDuNlBP0RJ0QtioOGYZRVV+y
 0YsprUPI2LUOsW65BIDL8gjaQg/0QlcFcNdvO7CRtDNa7r1Zn/oJ+LIxsd7SE3KmAHPtEa8ylrl
 caqfb4bPsPXbYt6pLsebPOvHs87WpKz0hdWBYWQur/UNk7D+DJFmGR4urrA74X0U5C1m7LEB0m6
 Q=
X-Received: by 2002:a17:906:8a74:b0:9ae:3e72:7c72 with SMTP id
 hy20-20020a1709068a7400b009ae3e727c72mr10462839ejc.58.1696321857506; 
 Tue, 03 Oct 2023 01:30:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1snEbVNPTaVJRoT54hhE5o9EOKMKXfV1vuE+pwIKg9GlKSzSjYkrGaugPBAn+x2008zfCrg==
X-Received: by 2002:a17:906:8a74:b0:9ae:3e72:7c72 with SMTP id
 hy20-20020a1709068a7400b009ae3e727c72mr10462822ejc.58.1696321857187; 
 Tue, 03 Oct 2023 01:30:57 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 gg24-20020a170906e29800b0099bd7b26639sm663471ejb.6.2023.10.03.01.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 01:30:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 07/24] Makefile: build plugins before running TCG tests
Date: Tue,  3 Oct 2023 10:30:24 +0200
Message-ID: <20231003083042.110065-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003083042.110065-1-pbonzini@redhat.com>
References: <20231003083042.110065-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add back test-plugins and, after making sure it is always defined,
do so unconditionally.

Reported-by: Alex Bennée <alex.bennee@linaro.org>
Fixes: 2c13c574418 ("configure, meson: move --enable-plugins to meson", 2023-09-07)
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include   |  2 +-
 tests/meson.build        |  5 +----
 tests/plugin/meson.build | 18 ++++++++++++------
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 38987426594..dab1989a071 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -73,7 +73,7 @@ $(TCG_TESTS_TARGETS:%=distclean-tcg-tests-%): distclean-tcg-tests-%:
 build-tcg: $(BUILD_TCG_TARGET_RULES)
 
 .PHONY: check-tcg
-.ninja-goals.check-tcg = all
+.ninja-goals.check-tcg = all test-plugins
 check-tcg: $(RUN_TCG_TARGET_RULES)
 
 .PHONY: clean-tcg
diff --git a/tests/meson.build b/tests/meson.build
index debaa4505eb..9996a293fbb 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -80,10 +80,7 @@ if 'CONFIG_TCG' in config_all
   subdir('fp')
 endif
 
-if get_option('plugins')
-  subdir('plugin')
-endif
-
+subdir('plugin')
 subdir('unit')
 subdir('qapi-schema')
 subdir('qtest')
diff --git a/tests/plugin/meson.build b/tests/plugin/meson.build
index 2bbfc4b19e1..322cafcdf6b 100644
--- a/tests/plugin/meson.build
+++ b/tests/plugin/meson.build
@@ -1,7 +1,13 @@
 t = []
-foreach i : ['bb', 'empty', 'insn', 'mem', 'syscall']
-  t += shared_module(i, files(i + '.c'),
-                     include_directories: '../../include/qemu',
-                     dependencies: glib)
-endforeach
-alias_target('test-plugins', t)
+if get_option('plugins')
+  foreach i : ['bb', 'empty', 'insn', 'mem', 'syscall']
+    t += shared_module(i, files(i + '.c'),
+                       include_directories: '../../include/qemu',
+                       dependencies: glib)
+  endforeach
+endif
+if t.length() > 0
+  alias_target('test-plugins', t)
+else
+  run_target('test-plugins', command: find_program('true'))
+endif
-- 
2.41.0


