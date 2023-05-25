Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E11BE710E1A
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 16:17:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Bkw-0004Yk-Cr; Thu, 25 May 2023 10:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bkr-0004WV-BD
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:15:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bko-0007YF-RQ
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685024145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ue2IISUToeEGa1zJJrZYBh+J7bbH46VZA+Gd1EDOEyQ=;
 b=NBUOqvm3xusWjawmKF8fEjFIQAGlvb197TB7C+fgCw+T8+jFI3woSj9+vLjVftZmvZ5t/S
 GsBHzs+0mKreY8QPMsFIyknNEtEpJp9nWSX1dQ8IfDoxZAfG3D4fHkN+l0tABu7+g4g7JC
 dpQrBUgHMHC8Gy/banQ5xF6bOZJ2Dj8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-uAMTOqJuNHCJOQG__m1PAg-1; Thu, 25 May 2023 10:15:41 -0400
X-MC-Unique: uAMTOqJuNHCJOQG__m1PAg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-96f46e5897eso85654366b.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 07:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685024139; x=1687616139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ue2IISUToeEGa1zJJrZYBh+J7bbH46VZA+Gd1EDOEyQ=;
 b=eL75luDgcSnumlEqktMv+Za7uhbo8jNPa+j9ohEGlThHF0LLEHO1De7ACc+NK4UAK+
 Vr3+DxYHEH54s6yiXABDzan0wgLd1fe2/zbp5sfHvGlDDwmuwPJYKJzOAEJphigzKrGx
 oh8DWOySScclK9oMDxAcPs4sruB+OzTBEIlEalI68+tKLKbxJ6CFyvT9A4r9WsbiwyJP
 xOUeQkljJA/CpNukqv7afsq5s4fjw+JmVe/CEnKD78DxVZ1i3DgcEr9S5jWlQiJQJv1O
 rjrg6Wlo9KL9pt6sMuyhrjTZATvyNArhQ0UyrmfYvIoQk4JKpWA1G68D1bUO8IJnuRX9
 rFHQ==
X-Gm-Message-State: AC+VfDwGTJPwnVQBClhOiT8B88zOwfbyoEHYDFcVs2WCDcYSZYAIDiCy
 wLhqInMJzdqmhWybuFtCzgJGuDpUmJOq5EXzpiZny/CCnh/16i6S8/aONyoR0g48mYj7g2HdmdF
 oqo728/mHcLhhEF0oKKUZk/DPGCRZOFnRH4oBYBrZ2s3Ne0J9DmoDIwKrcbCqq4IymSLwnaxbNp
 M=
X-Received: by 2002:a17:907:60cc:b0:970:132f:698f with SMTP id
 hv12-20020a17090760cc00b00970132f698fmr2386779ejc.2.1685024139543; 
 Thu, 25 May 2023 07:15:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5EtY2hCqm9r+Bh5dftpTRBSduBwcdXSMnk3iEa4aQb+dV8+MNOuDqLw4vXllhzOW8ZCDMDig==
X-Received: by 2002:a17:907:60cc:b0:970:132f:698f with SMTP id
 hv12-20020a17090760cc00b00970132f698fmr2386738ejc.2.1685024139094; 
 Thu, 25 May 2023 07:15:39 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 t14-20020a170906948e00b0096f8d8bd046sm889250ejx.187.2023.05.25.07.15.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 07:15:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/20] meson: move -no-pie from linker to compiler
Date: Thu, 25 May 2023 16:15:16 +0200
Message-Id: <20230525141532.295817-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525141532.295817-1-pbonzini@redhat.com>
References: <20230525141532.295817-1-pbonzini@redhat.com>
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

The large comment in the patch says it all; the -no-pie flag is broken and
this is why it was not included in QEMU_LDFLAGS before commit a988b4c5614
("build: move remaining compiler flag tests to meson", 2023-05-18).  And
some distros made things even worse, so we have to add it to the compiler
command line.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1664
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index 448b71ad5b5c..2e47608353d1 100644
--- a/meson.build
+++ b/meson.build
@@ -265,12 +265,21 @@ endif
 
 # Meson currently only handles pie as a boolean for now, so if the user
 # has explicitly disabled PIE we need to extend our cflags.
+#
+# -no-pie is supposedly a linker flag that has no effect on the compiler
+# command line, but some distros, that didn't quite know what they were
+# doing, made local changes to gcc's specs file that turned it into
+# a compiler command-line flag.
+#
+# What about linker flags?  For a static build, no PIE is implied by -static
+# which we added above (and if it's not because of the same specs patching,
+# there's nothing we can do: compilation will fail, report a bug to your
+# distro and do not use --disable-pie in the meanwhile).  For dynamic linking,
+# instead, we can't add -no-pie because it overrides -shared: the linker then
+# tries to build an executable instead of a shared library and fails.  So
+# don't add -no-pie anywhere and cross fingers. :(
 if not get_option('b_pie')
-  qemu_common_flags += cc.get_supported_arguments('-fno-pie')
-  if not get_option('prefer_static')
-    # No PIE is implied by -static which we added above.
-    qemu_ldflags += cc.get_supported_link_arguments('-no-pie')
-  endif
+  qemu_common_flags += cc.get_supported_arguments('-fno-pie', '-no-pie')
 endif
 
 if not get_option('stack_protector').disabled()
-- 
2.40.1


