Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8E981BD18
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:22:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGMim-0007be-11; Thu, 21 Dec 2023 12:20:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMik-0007bV-I9
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMii-0004XQ-W6
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703179228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bXT4Dl0Kw/7UM64Z5onnUqN5IYVBTfeIAuQM9EaJTPg=;
 b=NxBCKLcWFS3twH9X9Qd2wkRkPBQg3WpteoKxBwGp+kZ9fQ5JnKdWxa3fEebYT/GajUc68h
 Oo8B54+Jnf2VyajdxTRC0J87QO0CTREIEMIJF9OArep2/rfefQ0QdCHx5Vm2d3OoOiZtN2
 C9abYDC7PeQ/mlAEf8AjVLz0+PHlHc0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-roYk5VeqNaal9V_83knv0Q-1; Thu, 21 Dec 2023 12:20:26 -0500
X-MC-Unique: roYk5VeqNaal9V_83knv0Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40c348e529fso8939135e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 09:20:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703179224; x=1703784024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bXT4Dl0Kw/7UM64Z5onnUqN5IYVBTfeIAuQM9EaJTPg=;
 b=Rd/Zk1taE3AYHgpXyFME2o39nQg86DO2B3ma1MpA90nD+x0biMhi9+c7XUe6nc9S+k
 FwsuY7Ax+4ukMhFBYELB1m10ik2oqF8xGss0cVedP8ZR6a/tcsXz+Q5thkypvBs8x6/Q
 /mM6CX6WdvjjZai6zv8gqCmiz03btUrdlLftI8U8SQlHnnyRqhSixGVD6YgowLjoR9Ni
 RySjQheXD45BOHq9PHDHtAM5kEozQpt2dhJiuZ8788pdbD5UmVUpWka9Wv8iMee0X17w
 OkYunwc+mT+T+UVPuiBj2YjgIgN+2PkrRCpfAkz0NP0003bMRJzFljo+h4oelHmiiCBZ
 oFcw==
X-Gm-Message-State: AOJu0YxRnhvrGyb1dGYg7LiRBevWyuydB7CdKW+VYL0ClYPMDIE4BhPB
 U1xmk/1sUufTFRsQIlr9yfMffWEY76H+oKfoh0+IuSIbinx4p9aWa9rX9qzgnqgzKiCg4Y58YZg
 9+uj0CCKqkSncs7LVoQW2SmnAeBbNuBK/ZKUgaJhHSrYio8PNuUNnQuPgXszwzY5uyFWrP3fa6e
 k+rK8jQ80=
X-Received: by 2002:a05:600c:40c:b0:40c:3417:233 with SMTP id
 q12-20020a05600c040c00b0040c34170233mr42208wmb.102.1703179224699; 
 Thu, 21 Dec 2023 09:20:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyljcVcXNeb+ld2T9i+/82DeC4yFp094jkIGHpaIIQvrjpJlWGHKt41mH9p76sgh2v+2YUfQ==
X-Received: by 2002:a05:600c:40c:b0:40c:3417:233 with SMTP id
 q12-20020a05600c040c00b0040c34170233mr42205wmb.102.1703179224331; 
 Thu, 21 Dec 2023 09:20:24 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a05600c138400b0040c03c3289bsm4025229wmf.37.2023.12.21.09.20.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:20:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/21] meson: add more sections to main meson.build
Date: Thu, 21 Dec 2023 18:19:50 +0100
Message-ID: <20231221171958.59350-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221171958.59350-1-pbonzini@redhat.com>
References: <20231221171958.59350-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/meson.build b/meson.build
index b5a85c4c255..b8c64c5ecf7 100644
--- a/meson.build
+++ b/meson.build
@@ -9,6 +9,10 @@ add_test_setup('thorough', env: ['G_TEST_SLOW=1', 'SPEED=thorough'])
 
 meson.add_postconf_script(find_program('scripts/symlink-install-tree.py'))
 
+####################
+# Global variables #
+####################
+
 not_found = dependency('', required: false)
 keyval = import('keyval')
 ss = import('sourceset')
@@ -86,8 +90,16 @@ enable_modules = get_option('modules') \
   .allowed()
 have_block = have_system or have_tools
 
+############
+# Programs #
+############
+
 python = import('python').find_installation()
 
+#######################################
+# Variables for host and accelerators #
+#######################################
+
 if cpu not in supported_cpus
   host_arch = 'unknown'
 elif cpu == 'x86'
@@ -518,9 +530,9 @@ if sparse.found()
                        '-Wno-non-pointer-null'])
 endif
 
-###########################################
-# Target-specific checks and dependencies #
-###########################################
+#####################
+# Option validation #
+#####################
 
 # Fuzzing
 if get_option('fuzzing') and get_option('fuzzing_engine') == '' and \
@@ -3495,9 +3507,9 @@ specific_ss.add_all(when: 'CONFIG_TCG_BUILTIN', if_true: tcg_module_ss)
 target_modules += { 'accel' : { 'qtest': qtest_module_ss,
                                 'tcg': tcg_real_module_ss }}
 
-########################
-# Library dependencies #
-########################
+##############################################
+# Internal static_libraries and dependencies #
+##############################################
 
 modinfo_collect = find_program('scripts/modinfo-collect.py')
 modinfo_generate = find_program('scripts/modinfo-generate.py')
-- 
2.43.0


