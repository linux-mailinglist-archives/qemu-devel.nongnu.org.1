Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F1E70D509
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:32:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MTn-0006R6-17; Tue, 23 May 2023 03:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q1MTd-0006PV-62
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:30:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q1MTb-0003mk-AU
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fpR28WxEL6UJr1zH3CvHH4pkZ0VC6wvHdgt53LgIVhE=;
 b=eRz+VjfA7i8qdX9SzUbOKzDan9N6L0idMcE94yc+tfAQDsz8hTst8mVejX5ePWeBl4SpC7
 3uOxHzcWhISbD/LCeJp8M9i+5Me2yQSrZuQvWSt26ZCngiBTsbL3wi34gf8dFdU3IPeHos
 mdhsoxDRxtBhI8SQbSSFljC64yJT1TY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-WxmMcyrxPXKH_Y4gmI3ouQ-1; Tue, 23 May 2023 03:30:32 -0400
X-MC-Unique: WxmMcyrxPXKH_Y4gmI3ouQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-96fa4c724fdso389737666b.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 00:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684827031; x=1687419031;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fpR28WxEL6UJr1zH3CvHH4pkZ0VC6wvHdgt53LgIVhE=;
 b=DBFmLTyd80914x8/GBIrF9+1FoxNvdBRr78237ca5a5vxlQ20u4YVeMcnRl07+fCO+
 NdYrI1a735Vmc9WQCuIBlprsCjUehcI3gX6xCp/ul3GNF8Oojq+YvybF9W9vpORTS5Q1
 Bg8RrBeb1nwfvKeKGGiY7x8QDEKruJQEkput/40W/A00tSYXyLKklaoOo/Amjd9Utgbd
 QS9UZOOtbJIE583H2HNNpSJJ7ZH4troYG5rw1IHdSlfdlWzJ6rMj8aH6HVO0OputPZ22
 y3BllmhVf7grzxyiZTu/x8VqW1JriLhG57wCW99zti5CkKVh/IsqHmQKB9Vdx5zrISlb
 4xrw==
X-Gm-Message-State: AC+VfDwUIcTufd5HHxfE/kHzaecbT0oxUTKRnXJZ9yVA+JkpYtLAyKII
 qQ9jj3/687Y3oW/08RzCDIHF8oRlvex5q+0I74i48594qclEncXENumYTOok86EYUzeABT6iaNr
 o0+ckkbkUBJ3sr0fAeUpsDFSDFoXWwY/F5UOOp2eys0v+A8V8z9DZjB1Ls4MYWlW+Qn0TtRiFWc
 A=
X-Received: by 2002:a17:907:985:b0:96f:b40a:c85f with SMTP id
 bf5-20020a170907098500b0096fb40ac85fmr7248677ejc.23.1684827031419; 
 Tue, 23 May 2023 00:30:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ67w3/1mS5X2JsSJGpKV+sqlpzoDLJLJrphE1t4E/JwMHl4FaB+f+lTPpCmYBLE1CE4oEWP8A==
X-Received: by 2002:a17:907:985:b0:96f:b40a:c85f with SMTP id
 bf5-20020a170907098500b0096fb40ac85fmr7248654ejc.23.1684827031074; 
 Tue, 23 May 2023 00:30:31 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 hx17-20020a170906847100b00965b5540ad7sm4075502ejc.17.2023.05.23.00.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 00:30:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, vr_qemu@t-online.de,
 richard.henderson@linaro.org
Subject: [PATCH v2] meson: move -no-pie from linker to compiler
Date: Tue, 23 May 2023 09:30:29 +0200
Message-Id: <20230523073029.19549-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
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
index 0a5cdefd4d3d..20accae99281 100644
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


