Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC38A7972AD
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:11:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEdk-0003tK-P7; Thu, 07 Sep 2023 09:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdW-0003VM-Qr
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdU-0007QY-Ha
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qAYgh80D2/9tY4w2B9vStIRJ3whg/M/jMo9CcVK8jZk=;
 b=VM5fZRh2JqyEtwKunmslNR26hrmptS1YbzDHQ+cA7HhrQgH4aIIiIIVkXF8h0FKVIbKtVz
 QN81E+7QjwIiMCUPHSGkyoy5yjUHUAKb2btClo09AkYzjFb6sxgeAcyqfM9NYtonUQrHmK
 OfMWhVcWzaoB5eQphQA9NRChD5cGWjs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-VfxP4UDaMJ6zinttu3snNw-1; Thu, 07 Sep 2023 09:01:25 -0400
X-MC-Unique: VfxP4UDaMJ6zinttu3snNw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b8405aace3so10659941fa.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091682; x=1694696482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qAYgh80D2/9tY4w2B9vStIRJ3whg/M/jMo9CcVK8jZk=;
 b=Bj0Wv30dgMgpsw1E9kT9k6Lh/EkPn01cjB/8quXQk/6mJs1/JU5vRidOUqC3JCxopr
 rVGVJpZSKovgCM8xcjtaEtU5v4i30UD+8Yse4/mi6iuL6Uamabg5LVa8AC/dWy3Zw8wY
 AVeLM1LxUpQBVYW7nclZFMz0gKHlVhvT4NdOA0aU+E5+lPKdcdHs3HWj4gQEM+Wm/acp
 8xm1t/h04PNQ25BE8CfqALUiG1K3Eb9GkIQchlnXeoUCGbBKIWfdibRwpQ2wO1CSXtOh
 fXv4B9I+rGjWhSuavcRwssGsmSQ8SR8dSraJB2v7FLuAylWkJTWXquZVHNb2ZNBM0JLo
 H+Fw==
X-Gm-Message-State: AOJu0YwSxwnOpTYz7q+3I3QN9u7kM5V4xhU7QJdYWsmXJoVa7cEMxZK2
 4i/g7suXze+iz+rhat2Di+8f3B802zOaAPim6R7MZOeg0Z8f+E542OAmLDoTuL/gyZgHm/Qakth
 TMLoUtrCwhl8tmcw/CI0ifvrt6lArZGxMQBGHlzw78LNP3+CGw+V3OrEWLEWOSeVRdrZ9Szv4cm
 g=
X-Received: by 2002:a2e:b013:0:b0:2bd:d31:cf32 with SMTP id
 y19-20020a2eb013000000b002bd0d31cf32mr4313360ljk.15.1694091682233; 
 Thu, 07 Sep 2023 06:01:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfqrbHuS8J2QDHfhaVbAadoYw1EYTetXAHinSk7pKqXNGfm78PHCY7hiHjeKdKawid/wkVVg==
X-Received: by 2002:a2e:b013:0:b0:2bd:d31:cf32 with SMTP id
 y19-20020a2eb013000000b002bd0d31cf32mr4313337ljk.15.1694091681713; 
 Thu, 07 Sep 2023 06:01:21 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 l16-20020adfe9d0000000b00317e77106dbsm23221588wrn.48.2023.09.07.06.01.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:01:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 32/51] meson: list leftover CONFIG_* symbols
Date: Thu,  7 Sep 2023 14:59:41 +0200
Message-ID: <20230907130004.500601-33-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
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

There are no config-host.mak symbols anymore that are needed in
config-host.h; the only symbols that are included in config_host_data via
the foreach loop are:

- CONFIG_DEFAULT_TARGETS, which is not used by C code.

- CONFIG_TCG and CONFIG_TCG_INTERPRETER, which are not part of config-host.mak

So, list these two symbols explicitly.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/build-system.rst |  8 ++------
 meson.build                 | 12 ++++--------
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 64efa26b905..0f990bb3e90 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -460,17 +460,13 @@ Built by configure:
 
 ``config-host.mak``
   When configure has determined the characteristics of the build host it
-  will write them to this file for use in ``Makefile`` and to a smaller
-  extent ``meson.build``. These include the paths to various tools and a
-  variety of ``CONFIG_*`` variables related to optionally enabled features.
+  will write the paths to various tools to this file, for use in ``Makefile``
+  and to a smaller extent ``meson.build``.
 
   ``config-host.mak`` is also used as a dependency checking mechanism. If make
   sees that the modification timestamp on configure is newer than that on
   ``config-host.mak``, then configure will be re-run.
 
-  The variables defined here apply to all QEMU
-  build outputs.
-
 ``config-meson.cross``
 
   A Meson "cross file" (or native file) used to communicate the paths to
diff --git a/meson.build b/meson.build
index 16f0475955d..c24ea69f774 100644
--- a/meson.build
+++ b/meson.build
@@ -691,7 +691,6 @@ if get_option('tcg').allowed()
   endif
   if get_option('tcg_interpreter')
     tcg_arch = 'tci'
-    config_host += { 'CONFIG_TCG_INTERPRETER': 'y' }
   elif host_arch == 'x86_64'
     tcg_arch = 'i386'
   elif host_arch == 'ppc64'
@@ -701,7 +700,6 @@ if get_option('tcg').allowed()
                         language: all_languages)
 
   accelerators += 'CONFIG_TCG'
-  config_host += { 'CONFIG_TCG': 'y' }
 endif
 
 if 'CONFIG_KVM' not in accelerators and get_option('kvm').enabled()
@@ -2132,6 +2130,10 @@ if seccomp.found()
 endif
 config_host_data.set('CONFIG_SNAPPY', snappy.found())
 config_host_data.set('CONFIG_SOLARIS', targetos == 'sunos')
+if get_option('tcg').allowed()
+  config_host_data.set('CONFIG_TCG', 1)
+  config_host_data.set('CONFIG_TCG_INTERPRETER', tcg_arch == 'tci')
+endif
 config_host_data.set('CONFIG_TPM', have_tpm)
 config_host_data.set('CONFIG_TSAN', get_option('tsan'))
 config_host_data.set('CONFIG_USB_LIBUSB', libusb.found())
@@ -2760,12 +2762,6 @@ if targetos == 'windows' and 'cpp' in all_languages
 endif
 config_host_data.set('HAVE_VSS_SDK', have_vss_sdk)
 
-foreach k, v: config_host
-  if k.startswith('CONFIG_')
-    config_host_data.set(k, v == 'y' ? 1 : v)
-  endif
-endforeach
-
 # Older versions of MinGW do not import _lock_file and _unlock_file properly.
 # This was fixed for v6.0.0 with commit b48e3ac8969d.
 if targetos == 'windows'
-- 
2.41.0


