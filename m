Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C8E78C04C
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 10:31:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qau78-0002vJ-CD; Tue, 29 Aug 2023 04:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qau6j-0002kM-Da
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:29:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qau6g-0008Tk-9t
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693297789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eSilZNN6uj3wE/WzxkcCaM21pA6e5Kt5kHbPfdJ/n44=;
 b=OMZsR3uhEV3kgRAXDHvYL7uGHSL6wQCb6H6a3wQTIOfQNvMQnUqilTp0lUfV+wPtr1cpOg
 OJ2NbcfeYOgKzlvbpoRfx9aaYb8Lh+CKVwuQqhXOiSWJx8meJDHXZKk4qCTsxC8V2nL/32
 kS7Yj2sJtctSN2VThWoc9n6hxS3LE50=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-Mk2XbxmfNCyBcHWZNPoQDA-1; Tue, 29 Aug 2023 04:29:47 -0400
X-MC-Unique: Mk2XbxmfNCyBcHWZNPoQDA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fee703462dso31861635e9.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 01:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693297786; x=1693902586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eSilZNN6uj3wE/WzxkcCaM21pA6e5Kt5kHbPfdJ/n44=;
 b=io3yEytONS66Xi6P1u+oTqcgJ3D5l2V7TjuaLtZbg4AvHwjgsn2A8eW16NYEpezhTu
 nrSYPp2MmiVwFDl5fUpARFj7w1etud4bNMV8sGNs91BAX1Fa5MB07Q2A1HOCNcvNjWIc
 39Efc0LJ1N9Tun+pGFVXo2fyjec+XGaJ6dAGvwqkr7dX4z8iH6KY0aIB+n7I9tLyTDyx
 HDwYnKTY9czAJnaBHg7EHQW/f5Y3F9LFZuxgRsXL2CpxnaiaIxhShyQpHE+L1NyRIPs2
 2fZa/2lrL3VGt+QHEOzuGuVYR82cxSHPsSgX4+b1tUSU3C4a3TEsUmhCbNuLGQHPs1DP
 Pi7Q==
X-Gm-Message-State: AOJu0Yzb5YNPoQkJ0WXYYUTOmHuehqbIhQ55DzoNnQHCOpJES3ErSlpD
 +COVrgkkuPrzlRJYbUvT0phV1EeNNRBARZrcYNpziyy0wIPg2Q/rkI8OMMkH0vhFKSyT+zVMrWO
 yuM6n1nQSM3Hq2xnLTfOnSSoyEUm8c3T0LEIL6S6Cn8oQb6mvQSRP0wiBRB1s6VrdtlOBr/5BVZ
 I=
X-Received: by 2002:a1c:7302:0:b0:3fe:c7fe:206e with SMTP id
 d2-20020a1c7302000000b003fec7fe206emr21094133wmb.16.1693297785890; 
 Tue, 29 Aug 2023 01:29:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERnp9Q8TnSzfYmV2yDL1jeeDLexLR6ugT/mo/T19iJQp9ajjK6JvxpO2BvCTnjG0oPgqZP/A==
X-Received: by 2002:a1c:7302:0:b0:3fe:c7fe:206e with SMTP id
 d2-20020a1c7302000000b003fec7fe206emr21094110wmb.16.1693297785519; 
 Tue, 29 Aug 2023 01:29:45 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 t16-20020a7bc3d0000000b00401c9228bf7sm6705964wmj.18.2023.08.29.01.29.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 01:29:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/10] meson: do not use config_host to pick tap
 implementations
Date: Tue, 29 Aug 2023 10:29:28 +0200
Message-ID: <20230829082931.67601-8-pbonzini@redhat.com>
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

The target OS is invariant and does not depend on the configuration, so move
away from config_host and just use unconditional rules in softmmu_ss.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 net/meson.build | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

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


