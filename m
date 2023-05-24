Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8C670F319
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:38:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kwh-0005IO-SH; Wed, 24 May 2023 05:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1kwe-0005C3-Rq
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:38:12 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1kwd-0006lC-7u
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:38:12 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3078cc99232so543053f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 02:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684921090; x=1687513090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mwQD6JYFIZC5qczhg65V50jxbUCRyR+PfLPe0OmMdzU=;
 b=TPpxTlxeGhpTurw1nq/ZP/IRQ59dn1cbib5105WbXOHl2kAjHI8DSJoSR4ViDX+6IA
 ePCszzVAF8TR/GgPD13fwdmFUuN1jpAIwXeIF6BpFGM6KMTWMCAW4FGEtytizfFRM5W0
 NNiUJYULWuBbVkN82ca7Nt36J1ETvPRB0uJl/Eqph7JTHRQrp56Uk5Twmm2Fmij+Dg5d
 f0ral41h9m43kQxyiWqrBcnl9s5FVUfJV5VXNDN1TzWdwzyQgCuRKaqtAbUTSbYUdJcP
 RRzw+NzM1lj2ZybY1Ge6inNi+xjNnZWFR2/NI6pIXFOqoTaNuSrl1p8wpnRsRsVPB9+s
 Mlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684921090; x=1687513090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mwQD6JYFIZC5qczhg65V50jxbUCRyR+PfLPe0OmMdzU=;
 b=Enu9mNviqHRTHOJjfwqM/AgZXxRgWgpX+MtmCKEMpUQpoZ3+qlV/6tEkeTACcUZoPg
 WWL9eHe1GR2qkMIJNDjuxKAXWvOsMUqZeSGi2zZ0S4tadAjvkW5ggHHQl7ahdNgTJBuw
 oSaGFhGEybm0d3PBmlGt8peOPDdy95X2NM2RrejHkrp88TgKWxbbxbtkRYwwzKVYwgyy
 QJYjtrzW+A5MT5An0L4KkrAhRm0fozpYRsLLtJEZRL8wxdvYQtbjWdDzqILApTsUGAMz
 zWJ31qnSfs384IRSjJUJywYXYUqW7f8x4jlLnzTmPPmilqQZGu/vbswS5nU6qP1A0rlM
 97Qg==
X-Gm-Message-State: AC+VfDwNTXWSSQ26NHEUkORvTP0SYvbw52R+zgD46CT7KzxgXt2VnaTP
 bNQj3f7M89FtNKh9vtfuWxMx0pR495ImoPkdUmZ52w==
X-Google-Smtp-Source: ACHHUZ5hz6IlMu9MCZrGCtSrrF2zQLXtkmChS4pTamf2DCZSzAdsK2C+8vt/osNLugk20BFzfNC51g==
X-Received: by 2002:adf:fc47:0:b0:307:7fa4:527d with SMTP id
 e7-20020adffc47000000b003077fa4527dmr12093289wrs.58.1684921090123; 
 Wed, 24 May 2023 02:38:10 -0700 (PDT)
Received: from localhost.localdomain
 (fac34-h02-176-184-31-246.dsl.sta.abo.bbox.fr. [176.184.31.246])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a056000100200b0030903d44dbcsm13881751wrx.33.2023.05.24.02.38.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 May 2023 02:38:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 03/10] hw/scsi: Rearrange meson.build
Date: Wed, 24 May 2023 11:37:37 +0200
Message-Id: <20230524093744.88442-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524093744.88442-1-philmd@linaro.org>
References: <20230524093744.88442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We will modify this file shortly. Re-arrange it slightly first,
declaring source sets first.

No logical change.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/meson.build | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/meson.build b/hw/scsi/meson.build
index fa9198e69f..f2da0bc5ae 100644
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
-softmmu_ss.add_all(when: 'CONFIG_SCSI', if_true: scsi_ss)
 
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
 
+softmmu_ss.add_all(when: 'CONFIG_SCSI', if_true: scsi_ss)
 specific_ss.add_all(when: 'CONFIG_SCSI', if_true: specific_scsi_ss)
-- 
2.38.1


