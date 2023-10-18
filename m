Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A10FD7CD683
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:30:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1uw-0001nj-5n; Wed, 18 Oct 2023 04:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uu-0001n2-1m
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1us-0003fv-Ft
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMEGfJX5yEubPkar1DYtNMZdMeXfWKJZ/edTNcXbgHQ=;
 b=XLk59ahugnxF8gPZahmNlBJyWU/Xk+NzvxJJmC6XbXT66o4wwEKLbWyIE24n6sXU8IWAST
 ez2ngGLDn2IjubvPzF75PEMdD+bNjUhFpMpo0O66ulOuxpGlw4cGpPg7DIDYvczPtoudhI
 lcqgRI2YwDD+qQonwumV18OwRIei/Lc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-i7Kr-3PjMPquvvFdTE1v5Q-1; Wed, 18 Oct 2023 04:28:32 -0400
X-MC-Unique: i7Kr-3PjMPquvvFdTE1v5Q-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9be8013f2d1so292916666b.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617710; x=1698222510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gMEGfJX5yEubPkar1DYtNMZdMeXfWKJZ/edTNcXbgHQ=;
 b=VYP88xiH1+AiYCYl6J8aQUF+uykXsTMQ4SMsE6Nz7lVYaFSuuxpU/fNBkOsNzXZlaH
 IuKqyMb1OXXnFt7efuid/5JED8031PiHa+7Rle56hvhrx2sITbE0c1RXzkxGqE2FPTVm
 ZfsaEaoALDvETsmn4q+bnAD4pA8HcZT3CUEYiOm4zXkDWKInYfYxK82MD7yP2mEqABbu
 sG2gwTeoA3G35dWxVGPmTWNe2uS9xzXh05B1t+2zgxVSb0i7PpqJ4LB/jb8kMPnGsYwj
 9LeeP0uA3Wrq2w7Cd8S+hLBQE3OVvXW1GBcX7CfCnLJSJXXY408oayE/pEwW57p+NxRK
 MvxQ==
X-Gm-Message-State: AOJu0YxChfzXLbSy0SANvpIYTufWJ54htNxgZwuDtp9xGO9wO7FGGDtd
 E35b8FmOlD2VaMkKzGEwSIKQcTTyzhAF5CgBdI/I1I1HfiOSWDFHXatWTHPEd4W4tP+bqx7jbGE
 pDQpdGhlEXbDHofI3m33h/c1QiK5z9ffKujjjJGpur5rWAIm4MyhY0ErN0Nu114Zw8Ah9fDHCxW
 M=
X-Received: by 2002:a17:907:9348:b0:9ba:321b:80e1 with SMTP id
 bv8-20020a170907934800b009ba321b80e1mr3700628ejc.0.1697617710507; 
 Wed, 18 Oct 2023 01:28:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgsvshjrABH1NowfhNzEL8PtltCeDBYjwcl4eouTaNWN43Sj+gfXmk77fkJW99XChCCL4gyQ==
X-Received: by 2002:a17:907:9348:b0:9ba:321b:80e1 with SMTP id
 bv8-20020a170907934800b009ba321b80e1mr3700614ejc.0.1697617710215; 
 Wed, 18 Oct 2023 01:28:30 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 ck3-20020a170906c44300b009bf7a4d591dsm1197143ejb.32.2023.10.18.01.28.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:28:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/32] hw/xen: cleanup sourcesets
Date: Wed, 18 Oct 2023 10:27:39 +0200
Message-ID: <20231018082752.322306-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018082752.322306-1-pbonzini@redhat.com>
References: <20231018082752.322306-1-pbonzini@redhat.com>
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


