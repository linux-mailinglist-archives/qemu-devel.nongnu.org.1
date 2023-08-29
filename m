Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3A978C04B
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 10:31:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qau7A-0002w1-90; Tue, 29 Aug 2023 04:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qau6n-0002lP-D9
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:29:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qau6i-0008VI-Q3
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693297792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XPVxqiEmiMLgfe3jw2Do1706ez5s3pKp/sILgykcROs=;
 b=i4F9c1kncE7j3SJ+/kpyJCQ+Z00fPYVHHpWkNKNQuK/bunhn8odzUsuQ0quTY6XOPGWI93
 q44oNFagmnzGCTqiPsG+xW3IMv5yIUfF3ptfYFX/s6mKlxXpI1XJgZPUFm/kndaVJhXbRl
 0yBOLa6wcUqtAHnUoamDf7oRoQCQKo4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-nLik_-EdOVycqIn6Cmid-g-1; Tue, 29 Aug 2023 04:29:50 -0400
X-MC-Unique: nLik_-EdOVycqIn6Cmid-g-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-317d5b38194so2102099f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 01:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693297788; x=1693902588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XPVxqiEmiMLgfe3jw2Do1706ez5s3pKp/sILgykcROs=;
 b=cPfXIsMFPnfxWZDzXLPJa6nxWtlv7QyXv8Onelt09dRz9fTZAwcd8XN9orihSfITl3
 OTvR/CDLldWLm0iptXC+tcToCk5Kyk7YlNrLS34KnQHMugbgJ8hFmIUl7fEIpHS5EJvK
 loWzjdHg5T3aKncw1UOYhRZeLc+OdAVkEcNJb70J1InyDgSX4Y4wDxSJTSxvDAZDRHS4
 GiA2XawBtNG8efZrqiSgNFQT6GQDG7CFKj6VLtpGu8NOt0WZTsDzAHKJk2he1+BI5hyi
 Y7mYyI+XUlcjLCRlWpKO8kqSVH2yepWzTfycnkVj01PGlmhk18Z9sd653a/ExK+8F8D8
 UW1Q==
X-Gm-Message-State: AOJu0YxH9LkpMwMTwNwgwmdeDwL5vbTGErkgyq/U5J/kRbdQZoEMqNY/
 tUWxet8hlClufeBRgva47jRxYBYzrsRHqpIzBo/doU/hcdkMvec6E18//TtQkxN7lrdyLuV8Us6
 fRdd9pAID+pxhDAUIGc5Il8mmMo0JPsXXuBojT526U/kLTDL152mgRy9otrrWNPAveLaaDkEesp
 k=
X-Received: by 2002:a5d:4f0c:0:b0:317:a499:72c8 with SMTP id
 c12-20020a5d4f0c000000b00317a49972c8mr1388507wru.1.1693297788694; 
 Tue, 29 Aug 2023 01:29:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFlgVfSPPwtYGenPVz5Ke9uTraZ1mmKJisAfPvr0OAdfi0uKnxNxbJ/48HWdeq9xgnsn/wiQ==
X-Received: by 2002:a5d:4f0c:0:b0:317:a499:72c8 with SMTP id
 c12-20020a5d4f0c000000b00317a49972c8mr1388494wru.1.1693297788450; 
 Tue, 29 Aug 2023 01:29:48 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4205000000b00317ddccb0d1sm12987438wrq.24.2023.08.29.01.29.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 01:29:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/10] configure, meson: move simple OS definitions to meson
Date: Tue, 29 Aug 2023 10:29:29 +0200
Message-ID: <20230829082931.67601-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829082931.67601-1-pbonzini@redhat.com>
References: <20230829082931.67601-1-pbonzini@redhat.com>
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

CONFIG_DARWIN and CONFIG_SOLARIS are only used in C sources.
Move them to config_host_data.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure           | 12 ------------
 hw/9pfs/meson.build |  4 +++-
 meson.build         |  2 ++
 3 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/configure b/configure
index 4a7e7afb996..eba5befa2cf 100755
--- a/configure
+++ b/configure
@@ -377,7 +377,6 @@ fi
 mingw32="no"
 bsd="no"
 linux="no"
-solaris="no"
 case $targetos in
 windows)
   mingw32="yes"
@@ -402,10 +401,6 @@ openbsd)
 ;;
 darwin)
   bsd="yes"
-  darwin="yes"
-;;
-sunos)
-  solaris="yes"
 ;;
 haiku)
   pie="no"
@@ -1726,13 +1721,6 @@ if test "$linux" = "yes" ; then
   echo "CONFIG_LINUX=y" >> $config_host_mak
 fi
 
-if test "$darwin" = "yes" ; then
-  echo "CONFIG_DARWIN=y" >> $config_host_mak
-fi
-
-if test "$solaris" = "yes" ; then
-  echo "CONFIG_SOLARIS=y" >> $config_host_mak
-fi
 echo "SRC_PATH=$source_path" >> $config_host_mak
 echo "TARGET_DIRS=$target_list" >> $config_host_mak
 
diff --git a/hw/9pfs/meson.build b/hw/9pfs/meson.build
index 2944ea63c38..c6a2ccfcc85 100644
--- a/hw/9pfs/meson.build
+++ b/hw/9pfs/meson.build
@@ -14,7 +14,9 @@ fs_ss.add(files(
   'coxattr.c',
 ))
 fs_ss.add(when: 'CONFIG_LINUX', if_true: files('9p-util-linux.c'))
-fs_ss.add(when: 'CONFIG_DARWIN', if_true: files('9p-util-darwin.c'))
+if targetos == 'darwin'
+  fs_ss.add(files('9p-util-darwin.c'))
+endif
 fs_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xen-9p-backend.c'))
 system_ss.add_all(when: 'CONFIG_FSDEV_9P', if_true: fs_ss)
 
diff --git a/meson.build b/meson.build
index 02b035a3808..d3d10140c57 100644
--- a/meson.build
+++ b/meson.build
@@ -2070,6 +2070,7 @@ config_host_data.set('CONFIG_ATTR', libattr.found())
 config_host_data.set('CONFIG_BDRV_WHITELIST_TOOLS', get_option('block_drv_whitelist_in_tools'))
 config_host_data.set('CONFIG_BRLAPI', brlapi.found())
 config_host_data.set('CONFIG_COCOA', cocoa.found())
+config_host_data.set('CONFIG_DARWIN', targetos == 'darwin')
 config_host_data.set('CONFIG_FUZZ', get_option('fuzzing'))
 config_host_data.set('CONFIG_GCOV', get_option('b_coverage'))
 config_host_data.set('CONFIG_LIBUDEV', libudev.found())
@@ -2125,6 +2126,7 @@ if seccomp.found()
   config_host_data.set('CONFIG_SECCOMP_SYSRAWRC', seccomp_has_sysrawrc)
 endif
 config_host_data.set('CONFIG_SNAPPY', snappy.found())
+config_host_data.set('CONFIG_SOLARIS', targetos == 'sunos')
 config_host_data.set('CONFIG_TPM', have_tpm)
 config_host_data.set('CONFIG_TSAN', get_option('tsan'))
 config_host_data.set('CONFIG_USB_LIBUSB', libusb.found())
-- 
2.41.0


