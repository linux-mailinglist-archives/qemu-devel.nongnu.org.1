Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E037F70924F
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 10:57:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzvv1-0002Dw-F8; Fri, 19 May 2023 04:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzvuz-0002Do-PY
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzvuy-0000B3-AF
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684486615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uUtXAKQS8Ep2JwRv2ViPkG70CMSe3SeT6qXKklp0sBQ=;
 b=CkEHzFtbGSEu0C3X0bGjnV2z5WFTgNehbOA9IM6jgR8KpkhKcTRxWAln80zdtFLA8olXDZ
 F9qQImxyNayyUEfTfZh6YNaMjK3/XHY9MeMTJQxwC5NsUR2bWWBJYgknD5M5z94eiXAae+
 xkLXsTAWQre2wr5O3PEW9xXkYw7K2Qk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-c4Wu7e-4NC6J_YEn4w9Ztw-1; Fri, 19 May 2023 04:56:54 -0400
X-MC-Unique: c4Wu7e-4NC6J_YEn4w9Ztw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-969ea6699fdso410816566b.3
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 01:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684486612; x=1687078612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uUtXAKQS8Ep2JwRv2ViPkG70CMSe3SeT6qXKklp0sBQ=;
 b=UjLcjQt9uACLNX5BlHTJSdG/Mb3O0pO8pPbgylXfRtPMgAIq7EV+20Y6piIcx+6UIL
 m6wDD0ALA6YOrvWKZTr3Vr3Ix0F+RQa/UxfiqyAYHXkNW44JMCFntfcqba7N2zfqMhaf
 XG2pZG0YR9chZwd/xRUwfkCNJqQkGXPC2ndqiS697JKy1fyIC+x034RB91XqPq8XqGHz
 3n8XZ1LlPzWTNa/CB82KkvuJ9m4rbZEp1V2t2tH0r4EeJr4fnyIWaqvkr9f0mXecjTSL
 4KksVieJFpmmPV6X9pAFVZ6OVEKDtg/vz/9wcuqPWpZoEB/vZ0i/yANQRgDXB5V3ZB5f
 q00Q==
X-Gm-Message-State: AC+VfDz+fAPeg54XdhIO1X1K+JkkcyDFAfJC5dAKcZ5qZhP6AiX0S9W1
 2NymTwiiZ9GYdHkqLTU/GPmr2xatrxy3gJXMAqKHuQNnOb9f9C1MIkqJ3xFxUqtPQlyjtmXRTfW
 imFeQG6O34s4fs/USzdfJO4yv6NDwdCRioL2QgEBDM6+qMdu9wRFcH0nrSESUYXJiUksoqPZlKk
 0=
X-Received: by 2002:a17:907:8a10:b0:96a:d916:cb2f with SMTP id
 sc16-20020a1709078a1000b0096ad916cb2fmr1298312ejc.36.1684486612507; 
 Fri, 19 May 2023 01:56:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4V1ztoV60ub/0cuDrcP/YyK88A7ykOSMEVp9psj7jNOBjwG3PRjCDy9sqborSAdY6nhOimIg==
X-Received: by 2002:a17:907:8a10:b0:96a:d916:cb2f with SMTP id
 sc16-20020a1709078a1000b0096ad916cb2fmr1298290ejc.36.1684486612050; 
 Fri, 19 May 2023 01:56:52 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a1709062bcb00b0096a91ab434fsm2016558ejg.40.2023.05.19.01.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 01:56:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, peter.maydell@linaro.org
Subject: [PATCH 2/6] meson: simplify logic for -Dfdt
Date: Fri, 19 May 2023 10:56:42 +0200
Message-Id: <20230519085647.1104775-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519085647.1104775-1-pbonzini@redhat.com>
References: <20230519085647.1104775-1-pbonzini@redhat.com>
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

fdt_opt == 'disabled' is going to give an error if libfdt is required
by any target, so catch that immediately.  For fdt_opt == 'enabled',
instead, do not check immediately whether the internal libfdt is present.
Instead do the check after ascertaining that libfdt is absent or too old.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/meson.build b/meson.build
index 41c87c441f8e..0de7a858bce1 100644
--- a/meson.build
+++ b/meson.build
@@ -3041,13 +3041,14 @@ if have_system and vfio_user_server_allowed
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
@@ -3056,14 +3057,19 @@ if have_system
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
@@ -3088,9 +3094,6 @@ if have_system
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


