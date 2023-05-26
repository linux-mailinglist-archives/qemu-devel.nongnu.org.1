Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE606712A34
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:09:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Zzk-0004HT-6k; Fri, 26 May 2023 12:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Zzi-0004Gc-18
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:08:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Zzg-0002gJ-FN
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685117323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K3xl8UbdGcTKh1BLqGUoGqKT03WUGrTPnPlpqcrB0qo=;
 b=INe1stRGMIc0t4aSeycjBjI6AHWCXdFsdW/50NNjiWHsD9ANhqPtaysXLhlXwAcy7s5uFD
 VYtIe5424rwtzCKqbcj3AH+S99PSVZHNzY41hNRkS49pBSb6DLdtSa7KAg5XKFNvg6p/OO
 SD40ncPfI8NevwyUDhsgdH2N0dCV/rU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-N4aGOhQFPYuMFJ9pZRmDJA-1; Fri, 26 May 2023 12:08:42 -0400
X-MC-Unique: N4aGOhQFPYuMFJ9pZRmDJA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-96f83b44939so93231966b.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685117321; x=1687709321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K3xl8UbdGcTKh1BLqGUoGqKT03WUGrTPnPlpqcrB0qo=;
 b=AKilzzBgmnVTMTfd+kqsu04eUAmz2Oca5Mk3mKt5O+O67jWGccaAiZX2dX6SwhcP5g
 0ONRR1j2gpx5xI6RSas4aRFUV9Gj7aR6HRUFbzA1L4ZX4XjdsDtjUOlyeQEwmwcf090C
 DkqV4G0owew4AWdUFWbwrjHkLM96oDU4CASOR0WWxLlqAa/c/H90f6VKa8nhPxPgDKKc
 mHV2MwbgS9hYIhbikER/HqFVgfOyMp7kZklFQHxmvsm8PtauSzFJp1dnNsJSorA4vbf6
 1lFtsWvrdvqeO/ivUAwktwV14PNnOnoUsgPO0NGGCoiEmrIN+fPuzZP+vw8Ncg8g7HHG
 NDsg==
X-Gm-Message-State: AC+VfDybAsErvz5wCBxONH0VSFxfaoNIriqh4t8mDGlGFCmKTNAfMIJ8
 Ew7GO0MQJqYkWdVYRWyhYEJ5B0+kllZ42RJfn2WepJklTe+n7zF+SQbBLmEbgHhlMLACpMFFSPl
 hQJy5kl9Ki0JZgJhSfO+ifBgKQ9vUkjRnAjR710ZwssgunYVrgpiSQhcGWGDwTHTne9ib9E751d
 I=
X-Received: by 2002:a17:907:6d89:b0:96f:4ee4:10d4 with SMTP id
 sb9-20020a1709076d8900b0096f4ee410d4mr2878793ejc.43.1685117320947; 
 Fri, 26 May 2023 09:08:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Xww/uDQsImh2VvNEQSTxEgCcsCaDDhl1bFTLilpEZAq/p+OLPffTuF5xUihFc4B64Lq0qFQ==
X-Received: by 2002:a17:907:6d89:b0:96f:4ee4:10d4 with SMTP id
 sb9-20020a1709076d8900b0096f4ee410d4mr2878773ejc.43.1685117320657; 
 Fri, 26 May 2023 09:08:40 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 gv16-20020a170906f11000b00969dfd160aesm2339721ejb.109.2023.05.26.09.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 09:08:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 09/12] meson: simplify logic for -Dfdt
Date: Fri, 26 May 2023 18:08:21 +0200
Message-Id: <20230526160824.655279-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526160824.655279-1-pbonzini@redhat.com>
References: <20230526160824.655279-1-pbonzini@redhat.com>
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

fdt_opt == 'disabled' is going to give an error if libfdt is required
by any target, so catch that immediately.  For fdt_opt == 'enabled',
instead, do not check immediately whether the internal libfdt is present.
Instead do the check after ascertaining that libfdt is absent or too old.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/meson.build b/meson.build
index ee1b7dac730b..218428841d36 100644
--- a/meson.build
+++ b/meson.build
@@ -3059,13 +3059,14 @@ if have_system and vfio_user_server_allowed
 endif
 
 fdt = not_found
-if have_system
-  fdt_opt = get_option('fdt')
+fdt_opt = get_option('fdt')
+if fdt_required.length() > 0 or fdt_opt == 'enabled'
+  if fdt_opt == 'disabled'
+    error('fdt disabled but required by targets ' + ', '.join(fdt_required))
+  endif
+
   if fdt_opt in ['enabled', 'auto', 'system']
-    have_internal = fs.exists(meson.current_source_dir() / 'dtc/libfdt/Makefile.libfdt')
-    fdt = cc.find_library('fdt',
-                          required: fdt_opt == 'system' or
-                                    fdt_opt == 'enabled' and not have_internal)
+    fdt = cc.find_library('fdt', required: fdt_opt == 'system')
     if fdt.found() and cc.links('''
        #include <libfdt.h>
        #include <libfdt_env.h>
@@ -3074,14 +3075,19 @@ if have_system
       fdt_opt = 'system'
     elif fdt_opt == 'system'
        error('system libfdt requested, but it is too old (1.5.1 or newer required)')
-    elif have_internal
-      fdt_opt = 'internal'
     else
-      fdt_opt = 'disabled'
+      fdt_opt = 'internal'
       fdt = not_found
     endif
   endif
-  if fdt_opt == 'internal'
+  if not fdt.found()
+    assert(fdt_opt == 'internal')
+    have_internal = fs.exists(meson.current_source_dir() / 'subprojects/dtc/meson.build')
+
+    if not have_internal
+      error('libfdt source not found - please pull git submodule')
+    endif
+
     fdt_files = files(
       'dtc/libfdt/fdt.c',
       'dtc/libfdt/fdt_ro.c',
@@ -3106,9 +3112,6 @@ if have_system
 else
   fdt_opt = 'disabled'
 endif
-if not fdt.found() and fdt_required.length() > 0
-  error('fdt not available but required by targets ' + ', '.join(fdt_required))
-endif
 
 config_host_data.set('CONFIG_CAPSTONE', capstone.found())
 config_host_data.set('CONFIG_FDT', fdt.found())
-- 
2.40.1


