Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FB370701A
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:55:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLH2-00057j-49; Wed, 17 May 2023 13:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEf-0001bR-4y
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEc-0004PT-De
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BTl8dz4S4KQFdMauiBtgxB/zEVjX+4oDG4c1HH7MeJg=;
 b=dROU/QQo/5Gqs+/SoI6CQDHdwQRg3vlDnGZU/M/WCMK2a7kKWFXrFimy4qZQgwnrQeZnw0
 C0QohA/BQyxFVCJXnxZyAYBFrBiq+r5e5/nTQtkI+Es/c1nCwp2mtAtOB/HvIrzw656xZP
 vv62RF0GoaX2Q3MYsEtlcLpbq8WWt3Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-qRe7LmtVPNGxYTivGFKGww-1; Wed, 17 May 2023 13:46:44 -0400
X-MC-Unique: qRe7LmtVPNGxYTivGFKGww-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3063089cff4so679066f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345603; x=1686937603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BTl8dz4S4KQFdMauiBtgxB/zEVjX+4oDG4c1HH7MeJg=;
 b=ZCSDDiISSkwAGmpJR81ovRK8tYOrch/D2xGJ5JqBE5IYwIm2wFK6F4PE5Eo51vwq+v
 qzugMaRellKqQSDaFzmmfZII/wn7OYqLIjkQwjzq81Q33BwmJ7WfP6UL+zWMeHlU+Mdy
 Ela/zPvNTJ9yB7kowhzs+3OIH11BkfLki5bjFMQvj9tlofLkOnSKFln6Txcf/cVcFr7d
 CqpkFFmbz0WTG9IQoBcGJCjeWc47ncI5CtGDRX4P2qyjhKRY1KLs2CvZ0nbNS4Lj+BOc
 iuWfSaocX9c+8f3re1hmBhZjUWji5wRNmmQISBSwD0sIZwC284bODthRRs6u+9eOxhmm
 pv3A==
X-Gm-Message-State: AC+VfDxd5o+Mul97EZjaYjjql6Tap+VJWGeq1UKjeC67K3ZKC4+uIa+u
 yAFiol963fIU9L0g97uQGyy6Ze0LEBw/ni3Y5XDbayK6d/rPbS+f3HSCIdSW6sIxRMpduyJ8ZJg
 9yK65l2cFeOrSPWIrEnuHp3TN2j9uTvyO9zmJj1JPBMBimH+SUyigMCMRkeBdsT7CUht+3qJAtq
 g=
X-Received: by 2002:adf:df07:0:b0:307:34d4:7ec8 with SMTP id
 y7-20020adfdf07000000b0030734d47ec8mr1345097wrl.34.1684345603229; 
 Wed, 17 May 2023 10:46:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6gsIsnbUfO0XtbmZZJeYW+9/FbDq+OSTDmVx2Y3PM/3426MOo0jN3/Y2tnPUWCYcXyUyTtqA==
X-Received: by 2002:adf:df07:0:b0:307:34d4:7ec8 with SMTP id
 y7-20020adfdf07000000b0030734d47ec8mr1345084wrl.34.1684345602894; 
 Wed, 17 May 2023 10:46:42 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 o4-20020a5d4a84000000b003068f5cca8csm3386942wrq.94.2023.05.17.10.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 49/68] meson: add more version numbers to the summary
Date: Wed, 17 May 2023 19:45:01 +0200
Message-Id: <20230517174520.887405-50-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Whenever declare_dependency is used to add some compile flags or dependent
libraries to the outcome of dependency(), the version of the original
dependency is dropped in the summary.  Make sure that declare_dependency()
has a version argument in those cases.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/meson.build b/meson.build
index 132f309bdab2..464890d99ac0 100644
--- a/meson.build
+++ b/meson.build
@@ -888,7 +888,8 @@ if have_system and get_option('curses').allowed()
   curses_compile_args = ['-DNCURSES_WIDECHAR=1']
   if curses.found()
     if cc.links(curses_test, args: curses_compile_args, dependencies: [curses])
-      curses = declare_dependency(compile_args: curses_compile_args, dependencies: [curses])
+      curses = declare_dependency(compile_args: curses_compile_args, dependencies: [curses],
+                                  version: curses.version())
     else
       msg = 'curses package not usable'
       curses = not_found
@@ -977,7 +978,8 @@ endif
 if sdl.found()
   # work around 2.0.8 bug
   sdl = declare_dependency(compile_args: '-Wno-undef',
-                           dependencies: sdl)
+                           dependencies: sdl,
+                           version: sdl.version())
   sdl_image = dependency('SDL2_image', required: get_option('sdl_image'),
                          method: 'pkg-config')
 else
@@ -1198,9 +1200,10 @@ if not gnutls_crypto.found()
     # as it "spreads unnecessary dependencies" which in
     # turn breaks static builds...
     if gcrypt.found() and get_option('prefer_static')
-      gcrypt = declare_dependency(dependencies: [
-        gcrypt,
-        cc.find_library('gpg-error', required: true)])
+      gcrypt = declare_dependency(dependencies:
+        [gcrypt,
+         cc.find_library('gpg-error', required: true)],
+        version: gcrypt.version())
     endif
   endif
   if (not get_option('nettle').auto() or have_system) and not gcrypt.found()
@@ -1234,7 +1237,8 @@ if not get_option('gtk').auto() or have_system
     gtkx11 = dependency('gtk+-x11-3.0', version: '>=3.22.0',
                         method: 'pkg-config',
                         required: false)
-    gtk = declare_dependency(dependencies: [gtk, gtkx11])
+    gtk = declare_dependency(dependencies: [gtk, gtkx11],
+                             version: gtk.version())
 
     if not get_option('vte').auto() or have_system
       vte = dependency('vte-2.91',
-- 
2.40.1


