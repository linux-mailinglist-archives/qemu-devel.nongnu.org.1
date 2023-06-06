Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E20172462B
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:33:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Xij-00055A-TW; Tue, 06 Jun 2023 10:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xih-00054w-Q2
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xig-0001Fj-4p
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686061893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FD6a498aoDtqiiIhkSM6jMTT9LT3DOi6SlHQJkDwt/E=;
 b=GD8CBEV5In+VxEYR0KtIbQWddFduRxDne/81+CyFytkcHV8bn71Gmjp/0A3Cp8+8KSmxvq
 VbEWJNUiPSZwUDm+nEjja1AflATO5tu6mLRoovDKbuKvzCK76brlYCMxqIGMUPDYBdhWy0
 /uo7sAkJ4DpIEp24TSAom6HlWi1uFas=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-o45vb37PPjadK5GIbHWZRg-1; Tue, 06 Jun 2023 10:31:32 -0400
X-MC-Unique: o45vb37PPjadK5GIbHWZRg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-977c516686aso335300466b.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686061889; x=1688653889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FD6a498aoDtqiiIhkSM6jMTT9LT3DOi6SlHQJkDwt/E=;
 b=ZHnO5E9K5gVLS6JyCLq0QM+WDPMsY8m/NbFPCd0OpAY6/t/KfpXl7tR/d7BBmzLHBJ
 D3gUDb82ui4ApSH6UoZkvZ9y3h2EtzNMm/2WlgnMTmL23NjBaHGcpAb7pesiNdYcpQYP
 vX7qZKUijJqN2VGDtZnT/r9HvKVKL8S2Hzvpc+Mht0hGyjI4+dPrFj6xf9U9fAUWomSx
 IXYvhvkLuscTf/HpvIrFxqRopCgw3QN6/LbeA7DdFtMAw3RoDQkaWGOOp/n4l9faim7a
 0aWTnNKIi6GFAh0xZAMpJ/iStDew+ok2GOyUMi4R+za9+j0agqVKjrps8YdnYXKE+ktX
 TN3A==
X-Gm-Message-State: AC+VfDy8fHXaC0AYaMvOq34BKrJvFtQuxfPxCXN2qXOVjaMNeda5VGJB
 JYHRUlTYTrq76/+7NqQ7cYUoMGnW4FT/HMhvLmdjik9uPpP+6Y2k/5BAwjmvmzUuBGVUCkbt+wv
 cN+vP+WCq6cTK9E8JJni6y7Ds2Fr9f+HswJ+7NswE+CTsQWZ2xyaMj9gyhRHXPfJyocEfyZFVee
 A=
X-Received: by 2002:a17:906:58d2:b0:96f:a935:8997 with SMTP id
 e18-20020a17090658d200b0096fa9358997mr3216642ejs.12.1686061888841; 
 Tue, 06 Jun 2023 07:31:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ62zwwrdTZWdgJiWQg+bBX/K4WNmJjgE5TG7+rFm6T2+8wxX+mnCknG6baj0YuaCs5JGpX2UQ==
X-Received: by 2002:a17:906:58d2:b0:96f:a935:8997 with SMTP id
 e18-20020a17090658d200b0096fa9358997mr3216629ejs.12.1686061888558; 
 Tue, 06 Jun 2023 07:31:28 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 g15-20020a1709061c8f00b00965a52d2bf6sm5649488ejh.88.2023.06.06.07.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 07:31:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PULL 07/21] meson.build: Use -Wno-undef only for SDL2 versions that
 need it
Date: Tue,  6 Jun 2023 16:31:02 +0200
Message-Id: <20230606143116.685644-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606143116.685644-1-pbonzini@redhat.com>
References: <20230606143116.685644-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

There is no need to disable this useful compiler warning for
all versions of the SDL. Unfortunately, various versions are
buggy (beside SDL 2.0.8, the version 2.26.0 and 2.26.1 are
broken, too, see https://github.com/libsdl-org/SDL/issues/6619 ),
but we can use a simple compiler check to see whether we need
the -Wno-undef or not.

This also enables the printing of the version number with
good versions of the SDL in the summary of the meson output
again.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230605114523.282987-1-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 97b32e9beb5..6bbeffe5711 100644
--- a/meson.build
+++ b/meson.build
@@ -1273,10 +1273,16 @@ if not get_option('sdl').auto() or have_system
   sdl_image = not_found
 endif
 if sdl.found()
-  # work around 2.0.8 bug
-  sdl = declare_dependency(compile_args: '-Wno-undef',
-                           dependencies: sdl,
-                           version: sdl.version())
+  # Some versions of SDL have problems with -Wundef
+  if not cc.compiles('''
+                     #include <SDL.h>
+                     #include <SDL_syswm.h>
+                     int main(int argc, char *argv[]) { return 0; }
+                     ''', dependencies: sdl, args: '-Werror=undef')
+    sdl = declare_dependency(compile_args: '-Wno-undef',
+                             dependencies: sdl,
+                             version: sdl.version())
+  endif
   sdl_image = dependency('SDL2_image', required: get_option('sdl_image'),
                          method: 'pkg-config')
 else
-- 
2.40.1


