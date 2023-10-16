Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FC27C9F9A
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 08:32:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsH8g-0003sx-W3; Mon, 16 Oct 2023 02:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH8e-0003sC-VV
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:31:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH8c-0005RJ-PN
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697437898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eu916VXR4bjLP9kWhBXksgOVS+7PTywOtWPRUF1/pAo=;
 b=eS/Xp/FYnXwERMQPUMwZ2Etlmv0FRtn7RVC/Vv2jLI/9Cx+20bCjndtPiryGJyiIQdowyz
 7UX0c5hzHwoUMTjO+GBqvVPgHDa/aPtmVGMa8LrAYg/z7qQ6fyLqfLCbCQ7m+iVh7xj5SK
 0UFgHHIujq/YfjS5pRHUfOyB8G5HGco=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-6HZ-o9kDM7KmlQ0xLkfx0g-1; Mon, 16 Oct 2023 02:31:36 -0400
X-MC-Unique: 6HZ-o9kDM7KmlQ0xLkfx0g-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-53e3bfec5bdso2002538a12.0
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 23:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697437895; x=1698042695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eu916VXR4bjLP9kWhBXksgOVS+7PTywOtWPRUF1/pAo=;
 b=O05CFfQ1fYSuHlCMIOzvLXk7E4JNIwjHdSw74jTfkC+X2fOVe5K8JAuAJwk8XA686A
 eWcA1hOnT0iP+bZMXx5jGh3kfa91Lpwx3QeNjWZrAKIha7z4FN/g0639utC3OgZ7hJAF
 sca3AbeYVSM+KkWI8kchU0bkkP/7sW4ctErDhSfClEp1vAiadta5O5xMVkZqHzTOK5ck
 bUMkA/TCzdapLLGJlZ04G+UHZkeGWh3wehNNpkX8Z6bGrxnNVShDEYpYOFzy4Qn1N3Qp
 HD7WD6guXd2eWM1t0Dc6Ko2HkQt74eyEJUqgchyfx0DQji8nmuV+z9LWdRa7p/TzCN+Y
 Ic6w==
X-Gm-Message-State: AOJu0YxVrL7Og0Li6Jy+zMQ1jq+zcCXz9rGA4gpLjW/4Fdwt6v/fK2Lf
 n8MxVuTxuYia7ltQYewwAqhru8VktixFdMMBcBLulhiXxhFo4SRIdEJgYcJVveF8S3yGjfT+zV7
 2ghPFHLaEhNlg98TBnJ+3fTSN5oTpBXihC9FJKECXbrvM2HcV0qeuI+/PbFqyseRGY+llcSlBA4
 U=
X-Received: by 2002:a05:6402:4405:b0:53e:5dad:dce7 with SMTP id
 y5-20020a056402440500b0053e5daddce7mr7207981eda.29.1697437895187; 
 Sun, 15 Oct 2023 23:31:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3Eczpa7yE0kVG/pozhF/qWJQK4FETyHhXhnnjN4QYpps10gcvzjOqk6k9AO4P5MYaLcpjzA==
X-Received: by 2002:a05:6402:4405:b0:53e:5dad:dce7 with SMTP id
 y5-20020a056402440500b0053e5daddce7mr7207942eda.29.1697437894693; 
 Sun, 15 Oct 2023 23:31:34 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 g22-20020a50d0d6000000b0053e3d8f1d9fsm4507989edf.67.2023.10.15.23.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 23:31:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 03/17] meson, cutils: allow non-relocatable installs
Date: Mon, 16 Oct 2023 08:31:13 +0200
Message-ID: <20231016063127.161204-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016063127.161204-1-pbonzini@redhat.com>
References: <20231016063127.161204-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Suggested-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                   | 21 +++++++++++++++++++++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 util/cutils.c                 | 11 ++++++++---
 4 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 010d2c649c2..251838f2609 100644
--- a/meson.build
+++ b/meson.build
@@ -2111,6 +2111,7 @@ config_host_data.set('CONFIG_OPENGL', opengl.found())
 config_host_data.set('CONFIG_PLUGIN', get_option('plugins'))
 config_host_data.set('CONFIG_RBD', rbd.found())
 config_host_data.set('CONFIG_RDMA', rdma.found())
+config_host_data.set('CONFIG_RELOCATABLE', get_option('relocatable'))
 config_host_data.set('CONFIG_SAFESTACK', get_option('safe_stack'))
 config_host_data.set('CONFIG_SDL', sdl.found())
 config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
@@ -4054,6 +4055,7 @@ if 'simple' in get_option('trace_backends')
 endif
 summary_info += {'D-Bus display':     dbus_display}
 summary_info += {'QOM debugging':     get_option('qom_cast_debug')}
+summary_info += {'Relocatable install': get_option('relocatable')}
 summary_info += {'vhost-kernel support': have_vhost_kernel}
 summary_info += {'vhost-net support': have_vhost_net}
 summary_info += {'vhost-user support': have_vhost_user}
@@ -4356,3 +4358,22 @@ if host_arch == 'unknown' or not supported_oses.contains(targetos)
   message('If you want to help supporting QEMU on this platform, please')
   message('contact the developers at qemu-devel@nongnu.org.')
 endif
+
+actually_reloc = get_option('relocatable')
+# check if get_relocated_path() is actually able to relocate paths
+if get_option('relocatable') and \
+  not (get_option('prefix') / get_option('bindir')).startswith(get_option('prefix') / '')
+  message()
+  warning('bindir not included within prefix, the installation will not be relocatable.')
+  message()
+  message('Use --disable-relocatable to remove this warning.')
+  actually_reloc = false
+endif
+if not actually_reloc and (targetos == 'windows' or get_option('relocatable'))
+  if targetos == 'windows'
+    message()
+    warning('Windows installs should usually be relocatable.')
+  endif
+  message()
+  message('QEMU will have to be installed under ' + get_option('prefix') + '.')
+endif
diff --git a/meson_options.txt b/meson_options.txt
index 6a17b909680..e237b268469 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -101,6 +101,8 @@ option('cfi_debug', type: 'boolean', value: false,
        description: 'Verbose errors in case of CFI violation')
 option('multiprocess', type: 'feature', value: 'auto',
        description: 'Out of process device emulation support')
+option('relocatable', type : 'boolean', value : 'true',
+       description: 'toggle relocatable install')
 option('vfio_user_server', type: 'feature', value: 'disabled',
        description: 'vfio-user server support')
 option('dbus_display', type: 'feature', value: 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 2a74b0275b3..d4b89e6b443 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -17,6 +17,7 @@ meson_options_help() {
   printf "%s\n" '                           code for the Hexagon frontend'
   printf "%s\n" '  --disable-install-blobs  install provided firmware blobs'
   printf "%s\n" '  --disable-qom-cast-debug cast debugging support'
+  printf "%s\n" '  --disable-relocatable    toggle relocatable install'
   printf "%s\n" '  --docdir=VALUE           Base directory for documentation installation'
   printf "%s\n" '                           (can be empty) [share/doc]'
   printf "%s\n" '  --enable-block-drv-whitelist-in-tools'
@@ -421,6 +422,8 @@ _meson_option_parse() {
     --disable-rbd) printf "%s" -Drbd=disabled ;;
     --enable-rdma) printf "%s" -Drdma=enabled ;;
     --disable-rdma) printf "%s" -Drdma=disabled ;;
+    --enable-relocatable) printf "%s" -Drelocatable=true ;;
+    --disable-relocatable) printf "%s" -Drelocatable=false ;;
     --enable-replication) printf "%s" -Dreplication=enabled ;;
     --disable-replication) printf "%s" -Dreplication=disabled ;;
     --enable-rng-none) printf "%s" -Drng_none=true ;;
diff --git a/util/cutils.c b/util/cutils.c
index c99d26c5e2d..64f817b477b 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -1178,9 +1178,11 @@ char *get_relocated_path(const char *dir)
 #else
         g_string_append(result, dir);
 #endif
-    } else if (!starts_with_prefix(dir) || !starts_with_prefix(bindir)) {
-        g_string_assign(result, dir);
-    } else {
+        goto out;
+    }
+
+    if (IS_ENABLED(CONFIG_RELOCATABLE) &&
+        starts_with_prefix(dir) && starts_with_prefix(bindir)) {
         g_string_assign(result, exec_dir);
 
         /* Advance over common components.  */
@@ -1203,7 +1205,10 @@ char *get_relocated_path(const char *dir)
             assert(G_IS_DIR_SEPARATOR(dir[-1]));
             g_string_append(result, dir - 1);
         }
+        goto out;
     }
 
+    g_string_assign(result, dir);
+out:
     return g_string_free(result, false);
 }
-- 
2.41.0


