Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FBF710E14
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 16:17:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Bkt-0004Qt-T9; Thu, 25 May 2023 10:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bkl-0004NO-L8
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:15:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bkj-0007Wz-9g
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685024140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6rWFKlVMy0k6QsZKVGs7nbdEOS1yECUynhVrbATw6mE=;
 b=jTVof/mgM46xQHGiCi8hzTKjjm0E76Qqm2kmnI89ofrKr0VHVAhIabgNQWYkxMgsxbxUy2
 e54TkLZV1pOHCRAphIjO8qL634mSJV7PTRFOHeSxy6Tt2I2ES1K3dxMXmXcnh9SPjIq5Aj
 +9lcNwlzE34m2mDWMAmt6fxBhAGvLnU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-vwj1a1wBOQiBN5bSTRRvyw-1; Thu, 25 May 2023 10:15:38 -0400
X-MC-Unique: vwj1a1wBOQiBN5bSTRRvyw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-96f9aa23593so69026166b.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 07:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685024136; x=1687616136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6rWFKlVMy0k6QsZKVGs7nbdEOS1yECUynhVrbATw6mE=;
 b=XHGdEZf1Gayq7jeWh4mzn/bYfwaXOA8Gkb71Dy5BMoW7fUkHlQdPnDVJrAvX3GK66J
 y7PEiPNQVENyTsVMlO3cElcQgwigLBQfB638y+3SPj4TKjFy0oIx+mkqY3uya2zCUoWD
 p1OMdeBGwegVLCpYsROKpgF+CS4tWbH1VFCob7GvjaD4He0W1qSrQ6YDkWsW3uZKSteZ
 Ymk24bR+pm/QIDrJrB+4XVMZJpyjKSvRZrkOG/KQ0qFx86Q8aVm83DoOW+ss4qIDc9c+
 ifUTbNw9Auxvj1jmy49b4800TU3/nKLcRfnFHNWR2LaxhOPllx2sOskcMAdHVR9qIKkS
 ma3g==
X-Gm-Message-State: AC+VfDxBHGNGIhRML7uPbI7WxB05n/8l5z5nVWHzJdaI6PAjAxcIm2I1
 zp9DAIIHtnP5pMeC+KwkA2zIeGKxTmEtSTRKSG0chHYSMmOMXjQyL+9uG+er4gvfsSAkah12Q0N
 Z8MOiaXTaq6cJi9LyOj0BqjIljCXgx5EVPGmEXD6YX/DvKQ4SkVOCZHuT3zI3vCokH507AxcWgG
 A=
X-Received: by 2002:a17:907:7288:b0:94f:4102:25c8 with SMTP id
 dt8-20020a170907728800b0094f410225c8mr2007805ejc.61.1685024136465; 
 Thu, 25 May 2023 07:15:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4zmLoTpFvXAEsM791/Ongute9HpMDYoxaU9v3+f8yfXQcTGXTZ/dVmrW22l38EffjvYDNdVQ==
X-Received: by 2002:a17:907:7288:b0:94f:4102:25c8 with SMTP id
 dt8-20020a170907728800b0094f410225c8mr2007783ejc.61.1685024136123; 
 Thu, 25 May 2023 07:15:36 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 z11-20020a170906714b00b0096f89fd4bf8sm900032ejj.122.2023.05.25.07.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 07:15:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/20] meson.build: Fix glib -Wno-unused-function workaround
Date: Thu, 25 May 2023 16:15:14 +0200
Message-Id: <20230525141532.295817-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525141532.295817-1-pbonzini@redhat.com>
References: <20230525141532.295817-1-pbonzini@redhat.com>
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

From: Nicolas Saenz Julienne <nsaenz@amazon.com>

We want to only enable '-Wno-unused-function' if glib's version is
smaller than '2.57.2' and has a G_DEFINE_AUTOPTR_CLEANUP_FUNC()
implementation that doesn't take into account unused functions. But the
compilation test isn't working as intended as '-Wunused-function' isn't
enabled while running it.

Let's enable it.

Fixes: fc9a809e0d28 ("build: move glib detection and workarounds to meson")
Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230524173123.66483-1-nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 0a5cdefd4d3d..448b71ad5b5c 100644
--- a/meson.build
+++ b/meson.build
@@ -770,7 +770,7 @@ if not cc.compiles('''
     g_free(f);
   }
   G_DEFINE_AUTOPTR_CLEANUP_FUNC(Foo, foo_free)
-  int main(void) { return 0; }''', dependencies: glib_pc, args: ['-Werror'])
+  int main(void) { return 0; }''', dependencies: glib_pc, args: ['-Wunused-function', '-Werror'])
   glib_cflags += cc.get_supported_arguments('-Wno-unused-function')
 endif
 glib = declare_dependency(dependencies: [glib_pc, gmodule],
-- 
2.40.1


