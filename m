Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5DD79080B
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Sep 2023 15:06:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcQEn-0001Ns-9V; Sat, 02 Sep 2023 09:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcQEV-0001El-1z
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 09:00:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcQEQ-0001x7-NK
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 09:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693659605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hdxMt1JWLcVMJ4q896LNcJMB3TzYb0uEnxCUsLKSwU4=;
 b=W2jgxHUgfqaQWtChva06bkGGeP09qHel2jkWsi6rhlCFtVaWO1HuWZG0PcF+DkViD+/n2F
 htyJTjNQQKP2umJ+sTcm0fq9t/ri4Q2ByZqk6AOo76TGEyhhUWUwJR2EcANkWnNk24eoOx
 sDzpDVmkUOgWi2wbAwlserTks2Y1UtA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-C0lsPNBVNUGh-HF92FIXVg-1; Sat, 02 Sep 2023 09:00:03 -0400
X-MC-Unique: C0lsPNBVNUGh-HF92FIXVg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-401d9abf21cso19541835e9.0
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 06:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693659601; x=1694264401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hdxMt1JWLcVMJ4q896LNcJMB3TzYb0uEnxCUsLKSwU4=;
 b=kfyJFF2DdU7RcjSFTYlzrrdi9SXHcArOElF325sifSpBG1dL2sBr8nJD8DW7q2yRvs
 +k6HpzLq287OiOHUt6yXFJ/hVT2rE+Y15FD/743tbAtj4o5f5iEGFeRYoekTW0CcxblK
 RB1Q0dkmXARrl2BfWJYHrYaz/gZIcJWoe7WppHDLcMX85Ui8B5b4vwqHpSW//0tIJhag
 k4BLaC7NgoIzjCZpNiEzgXJCgePKQ9Sbs54R/zqDxz1XF28MO1YVXl0Gw8VbKsMOqqdV
 nt6K6pQC7xveVYFGOdbDuhjTADsCFYwxZZxLMYMT85bg8eA8G17ByW1qPhjakpQHqtsn
 iBUg==
X-Gm-Message-State: AOJu0YwAiuCjzEf1jU9JECNxVbJHp5LCwgvyIugO0jZhoQV71r20FHO/
 5BnD8JLcf6LWix8HpwVgiCqZRrMY88awLwW/28VVeTyeemaSvUl8gidCDfiK1yCYXEnj8cbyGO3
 ULgmp+1PP6uPJa3PabTKyWIllQx0hS2ljasbxcnCuoRsxZL8ICUH4mM3xW2+n4PTMPsOHGnUoqr
 g=
X-Received: by 2002:a05:600c:c3:b0:3fe:dcd0:2e10 with SMTP id
 u3-20020a05600c00c300b003fedcd02e10mr3956801wmm.17.1693659601714; 
 Sat, 02 Sep 2023 06:00:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYZ5R3cNHt6kY5K6aryXMPnryPjEZ421Gmt/xEWIMvymt7u2pJm7xo4Pb9HIdoa3tc677WEw==
X-Received: by 2002:a05:600c:c3:b0:3fe:dcd0:2e10 with SMTP id
 u3-20020a05600c00c300b003fedcd02e10mr3956789wmm.17.1693659601317; 
 Sat, 02 Sep 2023 06:00:01 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 c20-20020a7bc854000000b003fee0741b8csm10942924wml.23.2023.09.02.06.00.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 06:00:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/15] meson: list leftover CONFIG_* symbols
Date: Sat,  2 Sep 2023 14:59:33 +0200
Message-ID: <20230902125934.113017-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230902125934.113017-1-pbonzini@redhat.com>
References: <20230902125934.113017-1-pbonzini@redhat.com>
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
 meson.build                 | 10 ++--------
 2 files changed, 4 insertions(+), 14 deletions(-)

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
index d3feac656cb..cde2b58b91e 100644
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


