Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3A87972A4
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:10:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEdl-0003vH-77; Thu, 07 Sep 2023 09:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdT-0003Q5-06
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdP-0007PE-6W
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HIGgWzpKuQbbtZbqgfwIEtAoUiE/HvOom3y/uVV9Yyk=;
 b=L93b491+qypGWQ+wKlgZ7DeE4ZuhXGp+RpyNqVT3P8XOaqRWCLR1OwxDHg2msunsxqeXDH
 XvAGry7TkjZHzytjgjNOm5LulzTfh7/WLMksyK0Y/vdbKvQ8a2c+azB9rCS1o5RgbGNQ9N
 BvUSM9usyYb0h2XzS/ummnDqqhQPKQY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-Z0kOli0rMlqkRVqomD_7Lw-1; Thu, 07 Sep 2023 09:01:19 -0400
X-MC-Unique: Z0kOli0rMlqkRVqomD_7Lw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31f3cfe7269so569777f8f.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091677; x=1694696477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HIGgWzpKuQbbtZbqgfwIEtAoUiE/HvOom3y/uVV9Yyk=;
 b=O8bErp7b7C3Zu7r6LNW/urAvNjsL7SuDZ0+stx9aFCxDZkPyJAftLz8LGHPzErm/0D
 GFcrQPBTslvEJtiOqAgL04sQyMSCSJrJAdcUtmCo9hKnBnFzr/XsSPPY2Q/7gQo64cZY
 D9MSVlHimFNdLTLgEQi9el0ULp+DyyRhSGOlGqzc+yA6PshNfx6Co5tRvyPUomkGktGZ
 tqw1rHtHzBIEPfLx2LQY5IhPBIi3TEj8QzOBDKh0uphxuayW2f28rx00W7pyYSSCyrvn
 Kix+947y3RqNrVafk3ibVSr6iBqKBmQQFleDgeNduysH/6Oy/CJTziHMkBjgUVeScLOC
 +wRw==
X-Gm-Message-State: AOJu0YzI3+3psNEWIeycllw9aII7EjzrrkEX/Q6PYzNMZsp42bzciMWI
 khIiQxpdugZG42e3JmSem204C6Xj1pVsvmww9PjEzuNdj0wNbVFDAUmQU8imGU/2vTxmlQ7ECmu
 Z0qBfzckKdwN+azMVHXb7Vf6Z10JVdKwuKtwiNDc5T+NvOkuQ1VEjKGH87FzdpjuSq9tBNV2odo
 M=
X-Received: by 2002:a05:6000:14c:b0:314:1ad7:2ea8 with SMTP id
 r12-20020a056000014c00b003141ad72ea8mr4386710wrx.54.1694091676958; 
 Thu, 07 Sep 2023 06:01:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf/JUadJbK9GICKLH9otYhJk2rtCrOO6GC5HB9RuhNl2I8hGNTjf3CqLi9OBAFaG4MFgilQA==
X-Received: by 2002:a05:6000:14c:b0:314:1ad7:2ea8 with SMTP id
 r12-20020a056000014c00b003141ad72ea8mr4386695wrx.54.1694091676692; 
 Thu, 07 Sep 2023 06:01:16 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 l4-20020adffe84000000b003176eab8868sm23331851wrr.82.2023.09.07.06.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:01:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 30/51] configure,
 meson: remove CONFIG_SOLARIS from config-host.mak
Date: Thu,  7 Sep 2023 14:59:39 +0200
Message-ID: <20230907130004.500601-31-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
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
index 6b1019ba59c..a76bdd78623 100755
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
index a1021fe2a78..a7470b57081 100644
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


