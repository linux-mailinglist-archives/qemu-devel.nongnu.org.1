Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A37573E230
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 16:33:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlMU-0005Vg-SC; Mon, 26 Jun 2023 08:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKn-00026N-Nb
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKl-0002xK-R1
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RypNFNxe8nuVR5tzX73KR4W5kbnIlhQSpngct70qAFo=;
 b=biWWlW97dchV583xq667ZwJ1qYIMofWu94MDqVItA64pzVFJ7IyXU7hnUxKzmIHcoRb7ta
 rvC7Ym4wkz60w+A/wz8EcN/2JwJtX8tSMDBJ6Y5m8kBPZYv9TGReTk59CKRyEU7yn1anUs
 yOAWXzNZkvc/mL2DcubM8p4ecOyfgWM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-aG9EiiGKP9SzvFANNdllow-1; Mon, 26 Jun 2023 08:28:41 -0400
X-MC-Unique: aG9EiiGKP9SzvFANNdllow-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-313f442806dso379612f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782520; x=1690374520;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RypNFNxe8nuVR5tzX73KR4W5kbnIlhQSpngct70qAFo=;
 b=CsWfHOpjmiYUiA2lvoghg0A6mzI9xx4j7YAjro3EoyXLMg+F5QL08zZMofSLgup/hY
 C7FmVaQukHHP6AtZNSs9ks3R6ysPphqE2zD4c5SPcf8YGyY/8DA+uUFurbtF+FCGpBU5
 yxHkIaBKItpf1EnSjTTS3aUuD5UcvfN2tcE1X+tJckJLHyGQpwOeOc0JfxhhugI1zRv4
 cOQAMHkP2W4+CNGSlEb67hOXRGbPXLdKPkY1ktWG+AXd7skqm/QjwXkrOiaNmb5KIIod
 fatBXAjkCv16KiBJGhGFfGglZ82oHjKnNI/0RSGU9l5y9VjJqVvMGyjTrpWkBide9WnZ
 IM/g==
X-Gm-Message-State: AC+VfDzsxW6YBibCwk6enADf7O+DGnBdwymYbSpOQdejEyu/dkLR6cMZ
 XJLv/pY7In7GRbnATMBdmQhjKD7mNfcVnlZXqi9xXuZFlZ7lUFfpWLvbCgqf6tQeLPNfxsDukeB
 JRr/FIZtIjzPKO7R8aTU/jE+kxj6Akw96MbwgrZVGcwYVmwc+pUZZLxXAxqy9XhnKjeur
X-Received: by 2002:adf:f643:0:b0:313:ee73:cc9a with SMTP id
 x3-20020adff643000000b00313ee73cc9amr3265752wrp.70.1687782520521; 
 Mon, 26 Jun 2023 05:28:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ZiF8jsexczalbz+I5rZ9hSU1kFVOX7wj2osxFf3Twwca69dUIWLNFAoMWew3Dhr9qWK08EQ==
X-Received: by 2002:adf:f643:0:b0:313:ee73:cc9a with SMTP id
 x3-20020adff643000000b00313ee73cc9amr3265735wrp.70.1687782520239; 
 Mon, 26 Jun 2023 05:28:40 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 v2-20020a5d6102000000b003127a21e986sm7151764wrt.104.2023.06.26.05.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:28:39 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:28:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PULL 16/53] hw/scsi: Rename target-specific source set as
 'specific_virtio_scsi_ss'
Message-ID: <5268f5f5224ed67de63e0b91b05e410a97dbb976.1687782442.git.mst@redhat.com>
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

Following the SCSI variable named '[specific_]scsi_ss', rename the
target-specific VirtIO/SCSI set prefixed with 'specific_'. This will
help when adding target-agnostic VirtIO/SCSI set in few commits.

No logical change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230524093744.88442-5-philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/scsi/meson.build | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/meson.build b/hw/scsi/meson.build
index d9b5673c14..43746700be 100644
--- a/hw/scsi/meson.build
+++ b/hw/scsi/meson.build
@@ -1,6 +1,6 @@
 scsi_ss = ss.source_set()
 specific_scsi_ss = ss.source_set()
-virtio_scsi_ss = ss.source_set()
+specific_virtio_scsi_ss = ss.source_set()
 
 scsi_ss.add(files(
   'emulation.c',
@@ -15,12 +15,12 @@ scsi_ss.add(when: 'CONFIG_MEGASAS_SCSI_PCI', if_true: files('megasas.c'))
 scsi_ss.add(when: 'CONFIG_MPTSAS_SCSI_PCI', if_true: files('mptsas.c', 'mptconfig.c', 'mptendian.c'))
 scsi_ss.add(when: 'CONFIG_VMW_PVSCSI_SCSI_PCI', if_true: files('vmw_pvscsi.c'))
 
-virtio_scsi_ss.add(files('virtio-scsi.c', 'virtio-scsi-dataplane.c'))
-virtio_scsi_ss.add(when: 'CONFIG_VHOST_SCSI_COMMON', if_true: files('vhost-scsi-common.c'))
-virtio_scsi_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi.c'))
-virtio_scsi_ss.add(when: 'CONFIG_VHOST_USER_SCSI', if_true: files('vhost-user-scsi.c'))
+specific_virtio_scsi_ss.add(files('virtio-scsi.c', 'virtio-scsi-dataplane.c'))
+specific_virtio_scsi_ss.add(when: 'CONFIG_VHOST_SCSI_COMMON', if_true: files('vhost-scsi-common.c'))
+specific_virtio_scsi_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi.c'))
+specific_virtio_scsi_ss.add(when: 'CONFIG_VHOST_USER_SCSI', if_true: files('vhost-user-scsi.c'))
 
-specific_scsi_ss.add_all(when: 'CONFIG_VIRTIO_SCSI', if_true: virtio_scsi_ss)
+specific_scsi_ss.add_all(when: 'CONFIG_VIRTIO_SCSI', if_true: specific_virtio_scsi_ss)
 
 specific_scsi_ss.add(when: 'CONFIG_SPAPR_VSCSI', if_true: files('spapr_vscsi.c'))
 
-- 
MST


