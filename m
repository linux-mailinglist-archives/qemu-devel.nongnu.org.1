Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6883B790807
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Sep 2023 15:05:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcQEl-0001ED-K0; Sat, 02 Sep 2023 09:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcQEQ-0001Dd-RR
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 09:00:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcQEM-0001kr-Jx
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 09:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693659601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GENUN+wRZ+w6qH1+GNjgyBWTmZzTfEOkM7dN6ffdvWY=;
 b=XUyzosdjVN18ztXAg5F1gWJpTlghgQsxB5aeFrdEObrYtZ5KlJCUTYM02pWApAsBHNcDC4
 Z0TfJUDXLBTaVthDS3h+mAh5zzHu7Fb+jTasbJII6tZq72mP4vtq+VimTHTW/tIgf7txmZ
 tzVIgKCq3sG1GbZDwrwOqnUWA6etKj8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-zETp8ISOO2CwuQBDFQTiQA-1; Sat, 02 Sep 2023 09:00:00 -0400
X-MC-Unique: zETp8ISOO2CwuQBDFQTiQA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso20492065e9.2
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 06:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693659598; x=1694264398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GENUN+wRZ+w6qH1+GNjgyBWTmZzTfEOkM7dN6ffdvWY=;
 b=f0/Pk6E7gRAFMF7dsbXa6Gz8zCx9VSBXEBpC987SHkxntQahFOCfFkJm4TzYmcOoYm
 xttORenp6yg2GQfHlig6vvc8HhSo+Rqgi/OsT808rF73LjraF8X92uQm2dVjw+UbHkgE
 H9QG9eRqrXWB+fdrnKiu9C6KrnIYJNeid13irHchhgF0BeXfmI+I2cXWYAV8UFr8+0/A
 0bWQdkG5UYkrPOajDJ9TdGns27iaUT7FDVmeyNDfRFk+dyjAHpzn7RSxMR3pxGmNA6Ld
 9jwd06m7j9N5U6yvpXVmJ+Yput6FNnUmFf55cDCC0TRjzRMIBkkTFZd+/vsEa4XZENsX
 gS0A==
X-Gm-Message-State: AOJu0Yy8yFoEikX/xKm2b8CiFoctn7sxIeVL0HY18ufecSLmCj3NFeOH
 TGlDflesWSANuTwT4nFgYmVYmo7nu33JCWL+kru1LVyzWF6n47YTc5bRAmsaSzUMARAkNO6v8FJ
 6z7DPEtoK6YsqUhIBC3CszS1BR47h1U5EKnv9BWuEDESMOWial23MiVYHWVJhe+tAtt6iJtsuM7
 4=
X-Received: by 2002:a7b:ce92:0:b0:402:d72:bee5 with SMTP id
 q18-20020a7bce92000000b004020d72bee5mr3837027wmj.21.1693659598547; 
 Sat, 02 Sep 2023 05:59:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyOZWUQWzp3l+xNebGo8+cKrT1f6Vl87nuhX9WTex0X0kYPrmAhoYDzGciewOFXzFACcg1lQ==
X-Received: by 2002:a7b:ce92:0:b0:402:d72:bee5 with SMTP id
 q18-20020a7bce92000000b004020d72bee5mr3837020wmj.21.1693659598252; 
 Sat, 02 Sep 2023 05:59:58 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 y11-20020a05600c20cb00b003fc02e8ea68sm10929549wmm.13.2023.09.02.05.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 05:59:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 12/15] configure,
 meson: remove CONFIG_SOLARIS from config-host.mak
Date: Sat,  2 Sep 2023 14:59:31 +0200
Message-ID: <20230902125934.113017-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230902125934.113017-1-pbonzini@redhat.com>
References: <20230902125934.113017-1-pbonzini@redhat.com>
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

CONFIG_SOLARIS is only used to pick tap implementations.  But the
target OS is invariant and does not depend on the configuration, so move
away from config_host and just use unconditional rules in softmmu_ss.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure       |  3 ---
 meson.build     |  1 +
 net/meson.build | 18 ++++++++++--------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/configure b/configure
index 017977f72b3..f3ffaca1878 100755
--- a/configure
+++ b/configure
@@ -1699,9 +1699,6 @@ if test "$targetos" = "darwin" ; then
   echo "CONFIG_DARWIN=y" >> $config_host_mak
 fi
 
-if test "$targetos" = "sunos" ; then
-  echo "CONFIG_SOLARIS=y" >> $config_host_mak
-fi
 echo "SRC_PATH=$source_path" >> $config_host_mak
 echo "TARGET_DIRS=$target_list" >> $config_host_mak
 
diff --git a/meson.build b/meson.build
index 9100e2a9794..f6d079f4cda 100644
--- a/meson.build
+++ b/meson.build
@@ -2126,6 +2126,7 @@ if seccomp.found()
   config_host_data.set('CONFIG_SECCOMP_SYSRAWRC', seccomp_has_sysrawrc)
 endif
 config_host_data.set('CONFIG_SNAPPY', snappy.found())
+config_host_data.set('CONFIG_SOLARIS', targetos == 'sunos')
 config_host_data.set('CONFIG_TPM', have_tpm)
 config_host_data.set('CONFIG_TSAN', get_option('tsan'))
 config_host_data.set('CONFIG_USB_LIBUSB', libusb.found())
diff --git a/net/meson.build b/net/meson.build
index bdf564a57b2..d2d70634e5e 100644
--- a/net/meson.build
+++ b/net/meson.build
@@ -41,15 +41,17 @@ if have_vhost_net_user
   system_ss.add(when: 'CONFIG_ALL', if_true: files('vhost-user-stub.c'))
 endif
 
-system_ss.add(when: 'CONFIG_LINUX', if_true: files('tap-linux.c'))
-system_ss.add(when: 'CONFIG_BSD', if_true: files('tap-bsd.c'))
-system_ss.add(when: 'CONFIG_SOLARIS', if_true: files('tap-solaris.c'))
-tap_posix = ['tap.c']
-if not config_host.has_key('CONFIG_LINUX') and not config_host.has_key('CONFIG_BSD') and not config_host.has_key('CONFIG_SOLARIS')
-  tap_posix += 'tap-stub.c'
+if targetos == 'windows'
+  system_ss.add(files('tap-win32.c'))
+elif targetos == 'linux'
+  system_ss.add(files('tap.c', 'tap-linux.c'))
+elif targetos in bsd_oses
+  system_ss.add(files('tap.c', 'tap-bsd.c'))
+elif targetos == 'solaris'
+  system_ss.add(files('tap.c', 'tap-solaris.c'))
+else
+  system_ss.add(files('tap.c', 'tap-stub.c'))
 endif
-system_ss.add(when: 'CONFIG_POSIX', if_true: files(tap_posix))
-system_ss.add(when: 'CONFIG_WIN32', if_true: files('tap-win32.c'))
 if have_vhost_net_vdpa
   system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost-vdpa.c'), if_false: files('vhost-vdpa-stub.c'))
   system_ss.add(when: 'CONFIG_ALL', if_true: files('vhost-vdpa-stub.c'))
-- 
2.41.0


