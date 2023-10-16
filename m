Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A09207C9F98
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 08:32:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsH8k-0003tV-Lb; Mon, 16 Oct 2023 02:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH8j-0003tN-2D
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:31:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH8h-0005Rs-FR
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697437902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMEGfJX5yEubPkar1DYtNMZdMeXfWKJZ/edTNcXbgHQ=;
 b=K/y5YsqfrgQ5UIbHMJckb9piu8+WKJ5E+tzVLj06jzkB8oz1zs+vKOxSRjOZVSrI1r5uYv
 x5XvwI9l/C1UHgWGsW+8sx+S3WigFTJVVG9p6i+1jJOrh637KcoUOO1uPs0gMqmDjDij2R
 xkLoX3twyPMW2wNQC7JlBrj9ffNNTu4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-YJRvgtlBNEyg9fQPQouNXA-1; Mon, 16 Oct 2023 02:31:40 -0400
X-MC-Unique: YJRvgtlBNEyg9fQPQouNXA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-53e02a0ebfdso2966021a12.3
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 23:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697437899; x=1698042699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gMEGfJX5yEubPkar1DYtNMZdMeXfWKJZ/edTNcXbgHQ=;
 b=homjZ/OaPV940kf/jn8tH9N3nNPjys1zPkWQR3PbsE+gpei9dYzsgWOTEp0Vg+1JiE
 dwIXLRjJntMbhQ+uTplWSOU+VRuKerWgHckxLwzk2gfNaHF4nyCHLQtozaxDei7m7zlE
 /q7yXL1u855EY7MPTfJGoSwQw7Qz854NhY51EvHihijw3gE7g+YijSkrAiu87e1Xii8u
 8vt55q8mLv3fOuAXffCHJQbMIx6jktzUoaeJNzqaJPlUiQjwLZxtFnBzt5NTfQNXVCQV
 p3pZOO+ZzojTrFTLM+kOC/gZD8KCP8+SgSN2MOCafiZHmoKTdCMhHt8kxTDP/1+ExFge
 gW8g==
X-Gm-Message-State: AOJu0YwLVwFmDEsXYPc08eA4dF/7UUR7QzPmGC8EEi/nagqedU7Xb1x3
 3/tjJQq1xnzL+wPMf/zJXEiaOImELk5jHoi/QgSEgWXI6aPrPi0PYUf3C8AfA5vHC2Gh8pQKASx
 ajS+XJz+TANar1fUFwDkhVCqESh7xluP7ZCI8ovaaSH2jPMDS7knCkHiCztZ4FzGu/db9QkQL8W
 o=
X-Received: by 2002:a05:6402:550b:b0:53d:b59c:8f91 with SMTP id
 fi11-20020a056402550b00b0053db59c8f91mr12132728edb.27.1697437899084; 
 Sun, 15 Oct 2023 23:31:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjjjuOkB3ug5kw3HUyPRAchelMxPFvzGmR8xsSK6TgF/z8lEkwIngwyik6AZADHOgC39ZtMw==
X-Received: by 2002:a05:6402:550b:b0:53d:b59c:8f91 with SMTP id
 fi11-20020a056402550b00b0053db59c8f91mr12132721edb.27.1697437898832; 
 Sun, 15 Oct 2023 23:31:38 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 v3-20020a056402174300b0053e3839fc79sm4477594edx.96.2023.10.15.23.31.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 23:31:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/17] hw/xen: cleanup sourcesets
Date: Mon, 16 Oct 2023 08:31:15 +0200
Message-ID: <20231016063127.161204-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016063127.161204-1-pbonzini@redhat.com>
References: <20231016063127.161204-1-pbonzini@redhat.com>
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

xen_ss is added unconditionally to arm_ss and i386_ss (the only
targets that can have CONFIG_XEN enabled) and its contents are gated by
CONFIG_XEN; xen_specific_ss has no condition for its constituent files
but is gated on CONFIG_XEN when its added to specific_ss.

So xen_ss is a duplicate of xen_specific_ss, though defined in a
different way.  Merge the two by eliminating xen_ss.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/arm/meson.build  |  1 -
 hw/i386/meson.build |  1 -
 hw/xen/meson.build  | 11 ++++-------
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 11eb9112f88..a6feaf1af95 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -64,7 +64,6 @@ arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
 arm_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
 arm_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
 arm_ss.add(when: 'CONFIG_XEN', if_true: files('xen_arm.c'))
-arm_ss.add_all(xen_ss)
 
 system_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4_boards.c'))
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index ff879069c98..369c6bf823b 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -32,6 +32,5 @@ subdir('kvm')
 subdir('xen')
 
 i386_ss.add_all(xenpv_ss)
-i386_ss.add_all(xen_ss)
 
 hw_arch += {'i386': i386_ss}
diff --git a/hw/xen/meson.build b/hw/xen/meson.build
index 277f9f292b4..d887fa9ba43 100644
--- a/hw/xen/meson.build
+++ b/hw/xen/meson.build
@@ -12,6 +12,10 @@ system_ss.add(when: ['CONFIG_XEN', xen], if_true: files(
 ))
 
 xen_specific_ss = ss.source_set()
+xen_specific_ss.add(files(
+  'xen-mapcache.c',
+  'xen-hvm-common.c',
+))
 if have_xen_pci_passthrough
   xen_specific_ss.add(files(
     'xen-host-pci-device.c',
@@ -26,10 +30,3 @@ else
 endif
 
 specific_ss.add_all(when: ['CONFIG_XEN', xen], if_true: xen_specific_ss)
-
-xen_ss = ss.source_set()
-
-xen_ss.add(when: 'CONFIG_XEN', if_true: files(
-  'xen-mapcache.c',
-  'xen-hvm-common.c',
-))
-- 
2.41.0


