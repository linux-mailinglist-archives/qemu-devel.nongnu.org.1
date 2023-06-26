Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C12A73E26F
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 16:49:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlLr-0002Qk-5e; Mon, 26 Jun 2023 08:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKm-00023E-3a
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKk-0002un-5O
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nX2b6CW1d8Yj4PrNeXLgA95+PA1EOaqmbtd7Cf9aLUE=;
 b=ix+w/cOzD+XP/EUrH2jNGMfGuv8Ju8HxZr9i/5DBOtscd6pyTDvOnzoeGE2B3iXfPvziLp
 xsJDzUZV6sWRjsj2T2em6VRMo6CEwVG9V+tWgB67VuBtmpakC9bAM0YXrdBTWUoR9WifqO
 4DJ8oDsCb6MP/Vkk9nVP7jyEhNjJRYI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-CmsgN05rO1GrSKGSALltAA-1; Mon, 26 Jun 2023 08:28:39 -0400
X-MC-Unique: CmsgN05rO1GrSKGSALltAA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-313e6020882so681281f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782517; x=1690374517;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nX2b6CW1d8Yj4PrNeXLgA95+PA1EOaqmbtd7Cf9aLUE=;
 b=LX+ywspiq3q2J0LEHcjkCGNtUnX0zN9hvtr56C+OH7o2DoEab5F48sH75mnTC6E7Bb
 fgoORESq/KFIghz0HiEEidbBua2u583b+8ax/TNWSElOtvLJnqevYlyqquvK+twwvBFf
 xNO2NXxQzRiYiOriO1ln93WBvCxBXC5D9FXuxQDOhHjDGb2/4a2x5mF35F1eNKLpevTC
 zXiUDkYTyVMP/gfT6dmLlXdIVpjJg403WvfylFR/QSV4dLpVqMOl1iu9pw1153MEDad8
 BQHfnwV8PGv6n7V3X2n7/6Lee44jWuaTBktXS9LWTDpPVZIVPB5M+nX/slsNrjKy9D8F
 kyIQ==
X-Gm-Message-State: AC+VfDwsj/BQynuqPD3cYBo3E863SWYZSXyLSiNQto90d7WQikihbAJT
 jIBt/rzstUIiGOA1ea30bZuV6Nze8miHngFpWZO5Sk4CGLScNnKiN5fm5YDovvNSbKF4i6xfUka
 0wWHKUw7ME6K2PG1RaiDtMISeQECKB/eku0/f3lBCUdcQIM1yzOHEBJY7SpIl5e5Avhq3
X-Received: by 2002:adf:ef10:0:b0:311:ff2:87e4 with SMTP id
 e16-20020adfef10000000b003110ff287e4mr27024871wro.33.1687782517501; 
 Mon, 26 Jun 2023 05:28:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4/+Qwhi0GQnBM/L069lQHEH6MwmkzvfIjeh9+27IkJDTz5by3okw3b0ovDOFXiygffoDNI3g==
X-Received: by 2002:adf:ef10:0:b0:311:ff2:87e4 with SMTP id
 e16-20020adfef10000000b003110ff287e4mr27024859wro.33.1687782517301; 
 Mon, 26 Jun 2023 05:28:37 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 u14-20020adfed4e000000b00313f100c2aasm2900472wro.21.2023.06.26.05.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:28:36 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:28:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL 15/53] hw/scsi: Rearrange meson.build
Message-ID: <04ca164ad3fc5309732e482534410a36b4713b11.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We will modify this file shortly. Re-arrange it slightly first,
declaring source sets first.

No logical change.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230524093744.88442-4-philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/scsi/meson.build | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/meson.build b/hw/scsi/meson.build
index 2a005420d2..d9b5673c14 100644
--- a/hw/scsi/meson.build
+++ b/hw/scsi/meson.build
@@ -1,4 +1,7 @@
 scsi_ss = ss.source_set()
+specific_scsi_ss = ss.source_set()
+virtio_scsi_ss = ss.source_set()
+
 scsi_ss.add(files(
   'emulation.c',
   'scsi-bus.c',
@@ -11,18 +14,15 @@ scsi_ss.add(when: 'CONFIG_LSI_SCSI_PCI', if_true: files('lsi53c895a.c'))
 scsi_ss.add(when: 'CONFIG_MEGASAS_SCSI_PCI', if_true: files('megasas.c'))
 scsi_ss.add(when: 'CONFIG_MPTSAS_SCSI_PCI', if_true: files('mptsas.c', 'mptconfig.c', 'mptendian.c'))
 scsi_ss.add(when: 'CONFIG_VMW_PVSCSI_SCSI_PCI', if_true: files('vmw_pvscsi.c'))
-system_ss.add_all(when: 'CONFIG_SCSI', if_true: scsi_ss)
 
-specific_scsi_ss = ss.source_set()
-
-virtio_scsi_ss = ss.source_set()
 virtio_scsi_ss.add(files('virtio-scsi.c', 'virtio-scsi-dataplane.c'))
-
 virtio_scsi_ss.add(when: 'CONFIG_VHOST_SCSI_COMMON', if_true: files('vhost-scsi-common.c'))
 virtio_scsi_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi.c'))
 virtio_scsi_ss.add(when: 'CONFIG_VHOST_USER_SCSI', if_true: files('vhost-user-scsi.c'))
+
 specific_scsi_ss.add_all(when: 'CONFIG_VIRTIO_SCSI', if_true: virtio_scsi_ss)
 
 specific_scsi_ss.add(when: 'CONFIG_SPAPR_VSCSI', if_true: files('spapr_vscsi.c'))
 
+system_ss.add_all(when: 'CONFIG_SCSI', if_true: scsi_ss)
 specific_ss.add_all(when: 'CONFIG_SCSI', if_true: specific_scsi_ss)
-- 
MST


