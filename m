Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFCE820A95
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:52:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrUn-0007nz-Pk; Sun, 31 Dec 2023 03:48:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrT2-0005Bp-M0
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSu-0000qv-B1
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PKhVB6YKhb+0z5VDwMAr6YKNtpTswqaTd9KGYVbENGs=;
 b=URaeHpvC52QyiLCam6Pg0u0HwZq7aom/HNL3c3jAaBPZmzKmbV2uDWeN9smXYg5n6uoi+9
 IgzkXo0CtPJo+HwwxZK9nA/TPd3FTd7bsWgVWqequODkCCcz+AMCD1J089lPbzmQsrXYnw
 tPtzf/AfefdToZbhmU4l0F2GHOulULg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-P_g9sNPvO4m8VU6aUsGZRg-1; Sun, 31 Dec 2023 03:46:29 -0500
X-MC-Unique: P_g9sNPvO4m8VU6aUsGZRg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40d3eabab1eso66802465e9.2
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:46:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012387; x=1704617187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PKhVB6YKhb+0z5VDwMAr6YKNtpTswqaTd9KGYVbENGs=;
 b=UZmk8CTxsjy9bhLwDbGe6kLjRPKyWBYpxXQONtjFXxcJ/e+etYieJNacfwCAu0QNll
 9jTDx06b4A3WeYv8v5VgIFh50kJgyBga2DVmsDpklnZE3RVMEP3ounUkqZ5J/wfD05q+
 iNjbZSepi3YnMYoCqXbudm0U0qt/+IhVtYhpJtWKGiBD1eFNv4yDbGOt208inLFT5NKp
 D/87Z3cyXeaADLRHxB3E1gs6SF121bF6JcNaQdJHpvsxDh+QXo0dnTshFjvXFyxKFpz/
 /dR/9rbAvBD2U2aevXNlcTtzKubSUtipkYqHGFvSiGW9Ued+kAVRKk6Axq3iCCu1ypBU
 CRhw==
X-Gm-Message-State: AOJu0Yzdanzv7wmIWSrbUkYEoOPXGrl3VObiyR0cXPzHGJevXf90OEp6
 qA+BuC3CEw3+Y4eMtJCiUp1b0N6C0L6gMQS2fEZUQPXPW7k124ZrlF8IXIeIQdWeoA8AcgD35cm
 leC97KJoHtNZ5oLV473+DZfAJTTkLZ2nUPI6yD6bjwAiF5U92lb0VEjDBVEhE25oQOVxvjGT/B2
 4n1A5rmBw=
X-Received: by 2002:a05:600c:2051:b0:40d:812f:c129 with SMTP id
 p17-20020a05600c205100b0040d812fc129mr1129572wmg.50.1704012387584; 
 Sun, 31 Dec 2023 00:46:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtqGCqv7RNq70mnkfZQYx03dYauUjww0IoszzF5oePMzoyK9hLKacs5RpbZyR8ej0phrTUFw==
X-Received: by 2002:a05:600c:2051:b0:40d:812f:c129 with SMTP id
 p17-20020a05600c205100b0040d812fc129mr1129568wmg.50.1704012387295; 
 Sun, 31 Dec 2023 00:46:27 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 g3-20020a5d4883000000b00336e32338f3sm12032341wrq.70.2023.12.31.00.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:46:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 31/46] meson: add more sections to main meson.build
Date: Sun, 31 Dec 2023 09:44:47 +0100
Message-ID: <20231231084502.235366-32-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/meson.build b/meson.build
index 6c77d9687de..c437e9f55e6 100644
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
@@ -3524,9 +3536,9 @@ specific_ss.add_all(when: 'CONFIG_TCG_BUILTIN', if_true: tcg_module_ss)
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


