Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 786CA835E0A
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 10:24:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRqXU-0007D9-Ue; Mon, 22 Jan 2024 04:24:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rRqXS-0007Cv-Pc
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 04:24:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rRqXR-000626-2E
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 04:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705915455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xoQgOwyOMuVlXIGva6sxyRxJF4LYpW9O+ytvHsdPXy8=;
 b=aK/G1jYh8QEqMec+ZOnhCUuoJPb573GwoT2wYLAMxN5x8/WtQ23TvFmLW3nFax6aGfeeoB
 4Tny3v6Y2gzOa52+Qa0l/288gl3LBB5pWVH/6UbJKjg43OZKhSTjvSAj3CxwdIQVAbn9jQ
 wXgkzCK6vh7PRhAp3HGnMEpWpjaYM7U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-tK_8G8blNXOou15reClWOA-1; Mon, 22 Jan 2024 04:24:13 -0500
X-MC-Unique: tK_8G8blNXOou15reClWOA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40eaed4f393so5096845e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 01:24:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705915451; x=1706520251;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xoQgOwyOMuVlXIGva6sxyRxJF4LYpW9O+ytvHsdPXy8=;
 b=rTj4vhe9xibwV/eSNJMrS873Fvjw2xApVF5zSB3NykZtLWlAasFniBuY7YG/A+gbxk
 l2/FH4MdlL8RpXd7RBwrZb1K0BXZ5ZOzPIq0tf0eT1eg7I+2SNH2oZIZPtkZU0Pv4t1V
 w0bHf9mvC4zP8tD6pFXMB29keEFeKMqrDZOOCEuQap0HljkzyKwawk/4b1mH0vgs8cGs
 sIiGxazd51kpFpRjuy6J7sFzT3fSiDsromJ+2qGbRsiIwc0+ggwmgf3Fx+8V0XyBL3YO
 WwV28/Ff+2yrKMLmQbxkhKmdXWyq5zSnrzTzVm/covwaqJeJOGAUTRzHeudwH9pciLwb
 uh1A==
X-Gm-Message-State: AOJu0YzXI//3BCfaQIUDa5vUU8YTRAX57P1KfPsFwH3U4pcDOqpJflTh
 qhPjLh7kMGZtmyCQcDj8YaVQYxauA48HjNYcAXT2Fo4k09F3dP82AJfl5rxkIy93USku0Ii8mU0
 s/sqOuRkmzQat+RyT2f74qwq4oPga5OXvmzLYutylOXoIYCpBYDeCN/Z8268mhA/3EIpiKNw2Va
 GOFAfXgqU8BUpzPUzLQXLXLJCoJSiFPPHCIX6x
X-Received: by 2002:a05:600c:3b84:b0:40e:aed5:3218 with SMTP id
 n4-20020a05600c3b8400b0040eaed53218mr437676wms.39.1705915451299; 
 Mon, 22 Jan 2024 01:24:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTqryupOwj5ly+8xFZAiL5yRnrlMXCzoJB+41HPx4RBThwRVNsJSrovX+bqCP067QMUmCfjg==
X-Received: by 2002:a05:600c:3b84:b0:40e:aed5:3218 with SMTP id
 n4-20020a05600c3b8400b0040eaed53218mr437667wms.39.1705915450903; 
 Mon, 22 Jan 2024 01:24:10 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 m10-20020adffa0a000000b003392172fd60sm8167907wrr.51.2024.01.22.01.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 01:24:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com
Subject: [PATCH] monitor: add dumpdtb command only in device-tree-enabled
 targets
Date: Mon, 22 Jan 2024 10:24:09 +0100
Message-ID: <20240122092409.280919-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Remove the command altogether from targets that do not have device tree support,
instead of leaving it nonfunctional.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build        | 2 --
 qapi/machine.json  | 2 +-
 hmp-commands.hx    | 2 +-
 system/meson.build | 2 +-
 4 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index de8e5ad67dc..6bf7f3eb685 100644
--- a/meson.build
+++ b/meson.build
@@ -3126,8 +3126,6 @@ if fdt_required.length() > 0 or get_option('fdt').enabled()
   endif
 endif
 
-config_host_data.set('CONFIG_FDT', fdt.found())
-
 vhost_user = not_found
 if host_os == 'linux' and have_vhost_user
   libvhost_user = subproject('libvhost-user')
diff --git a/qapi/machine.json b/qapi/machine.json
index b6d634b30d5..c5e40857ba4 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1828,4 +1828,4 @@
 ##
 { 'command': 'dumpdtb',
   'data': { 'filename': 'str' },
-  'if': 'CONFIG_FDT' }
+  'if': 'TARGET_NEEDS_FDT' }
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 17b5ea839d9..f7263957240 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1819,7 +1819,7 @@ ERST
         .flags      = "p",
     },
 
-#if defined(CONFIG_FDT)
+#if defined(TARGET_NEED_FDT)
     {
         .name       = "dumpdtb",
         .args_type  = "filename:F",
diff --git a/system/meson.build b/system/meson.build
index 25e21172505..4e54f5d1a4b 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -32,7 +32,7 @@ if have_tpm
 endif
 
 system_ss.add(when: seccomp, if_true: files('qemu-seccomp.c'))
-system_ss.add(when: fdt, if_true: files('device_tree.c'))
+system_ss.add(when: 'TARGET_NEED_FDT', if_true: [fdt, files('device_tree.c')])
 if host_os == 'linux'
   system_ss.add(files('async-teardown.c'))
 endif
-- 
2.43.0


