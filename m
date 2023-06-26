Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9D773DF6E
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:40:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlLu-00038p-18; Mon, 26 Jun 2023 08:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKh-00020q-OR
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKf-0002rS-RH
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I0c/2TSZTwjPfy5oknVtffw6zqqXBeJNU6cIu4XphFk=;
 b=LN2U5uoDyu53/ZTHfEwNxecoAb/BzWGjx6XN3nUnIcr+l1A0jDwJoHU+a47fkVFX/Vlq05
 XPMdzC3Owc9/UNeDnsjtdEyPf/T59bPmA3u7qbv+JxAFGrsBSr627G1KxA91oBXUDPZvNQ
 KUiFqMMK1le2fuA+2t5781/Q74FYQns=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-cuMu1rp3PcO9JrAuNzkiSA-1; Mon, 26 Jun 2023 08:28:35 -0400
X-MC-Unique: cuMu1rp3PcO9JrAuNzkiSA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f9d7ff4b6aso19857675e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782514; x=1690374514;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I0c/2TSZTwjPfy5oknVtffw6zqqXBeJNU6cIu4XphFk=;
 b=WNHyolQgWOtmlQZB5AhzyHtN7+Q89daom90kfHWB2ubnaX1eOKS1QhXS/tfiyOizX/
 1+UrKPo5CP/GN9BY1IiklrBaIy2dYfR19g4XZvQiDpfx/lrVWasf3MXUlZW8kblWsety
 PGN2TQIEIsoNYHO+B3IjEe5191iVlsaE2HRniM+wxWNf6AeuoFPldn8hCfuckGliX9HH
 8tJuRnmDzzGG+31H6F7AnWCvuyoSR8xum4mNey4QRgpBXnQj1IW8v2xapMg02iKp3uva
 dmTYNnPQCNbJ6LYh6uURdSOoiMPpEv8kmKaGSYH+rmSxCyZIngKjSGT/txzvNDTxeqts
 oqkA==
X-Gm-Message-State: AC+VfDxgQmE27fmyXLCkpnVqh/YCGKkR13Qk4edj4xbn3J4y08g6pIyi
 1OPoogr/dLlczJg8KiH/O7j1eD/gyHcnklJeT/TN+JddQE8/xm9an5BUukXVvfwaG2B7ZoJAYst
 MDeY4vJkOaoGNr6hXgdZRHwTal2E+fXZlXgiH5bHw3ktlY1ieeJLEcN312U3SsLgWf4OY
X-Received: by 2002:a1c:f70d:0:b0:3f7:3685:1e10 with SMTP id
 v13-20020a1cf70d000000b003f736851e10mr22378325wmh.40.1687782514372; 
 Mon, 26 Jun 2023 05:28:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ658bWNkubd5ISDcHjNYxMp2YimZXxTgdBfkawPhYJ+L2Wj/lh7QHqB4kii5x0BuGxk1wxtJg==
X-Received: by 2002:a1c:f70d:0:b0:3f7:3685:1e10 with SMTP id
 v13-20020a1cf70d000000b003f736851e10mr22378313wmh.40.1687782514119; 
 Mon, 26 Jun 2023 05:28:34 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 d11-20020a05600c3acb00b003f7f475c3bcsm11415769wms.1.2023.06.26.05.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:28:33 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:28:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL 14/53] hw/scsi: Introduce VHOST_SCSI_COMMON symbol in Kconfig
Message-ID: <8f691f1cb76f0591874e91eb18569a150bb3cfe0.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

Instead of adding 'vhost-scsi-common.c' twice (for VHOST_SCSI and
VHOST_USER_SCSI), have it depend on VHOST_SCSI_COMMON, selected by
both symbols.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230524093744.88442-3-philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/scsi/Kconfig     | 6 ++++++
 hw/scsi/meson.build | 6 ++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/Kconfig b/hw/scsi/Kconfig
index e7b34dc8e2..1feab84c4c 100644
--- a/hw/scsi/Kconfig
+++ b/hw/scsi/Kconfig
@@ -48,13 +48,19 @@ config VIRTIO_SCSI
     depends on VIRTIO
     select SCSI
 
+config VHOST_SCSI_COMMON
+    bool
+    depends on VIRTIO
+
 config VHOST_SCSI
     bool
     default y
+    select VHOST_SCSI_COMMON
     depends on VIRTIO && VHOST_KERNEL
 
 config VHOST_USER_SCSI
     bool
     # Only PCI devices are provided for now
     default y if VIRTIO_PCI
+    select VHOST_SCSI_COMMON
     depends on VIRTIO && VHOST_USER && LINUX
diff --git a/hw/scsi/meson.build b/hw/scsi/meson.build
index 7a1e7f13f0..2a005420d2 100644
--- a/hw/scsi/meson.build
+++ b/hw/scsi/meson.build
@@ -17,8 +17,10 @@ specific_scsi_ss = ss.source_set()
 
 virtio_scsi_ss = ss.source_set()
 virtio_scsi_ss.add(files('virtio-scsi.c', 'virtio-scsi-dataplane.c'))
-virtio_scsi_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi-common.c', 'vhost-scsi.c'))
-virtio_scsi_ss.add(when: 'CONFIG_VHOST_USER_SCSI', if_true: files('vhost-scsi-common.c', 'vhost-user-scsi.c'))
+
+virtio_scsi_ss.add(when: 'CONFIG_VHOST_SCSI_COMMON', if_true: files('vhost-scsi-common.c'))
+virtio_scsi_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi.c'))
+virtio_scsi_ss.add(when: 'CONFIG_VHOST_USER_SCSI', if_true: files('vhost-user-scsi.c'))
 specific_scsi_ss.add_all(when: 'CONFIG_VIRTIO_SCSI', if_true: virtio_scsi_ss)
 
 specific_scsi_ss.add(when: 'CONFIG_SPAPR_VSCSI', if_true: files('spapr_vscsi.c'))
-- 
MST


