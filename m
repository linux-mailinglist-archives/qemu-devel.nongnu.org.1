Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6421970F317
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:38:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kwq-0005wn-O0; Wed, 24 May 2023 05:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1kwn-0005sT-9j
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:38:21 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1kwk-0006qI-Pj
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:38:21 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3095557dd99so532252f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 02:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684921097; x=1687513097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F64YgIxEgVdDKFKSPKxj4a8a5AWO26EEsIqp9A+2/F4=;
 b=NZ9jIWAtS2nS/bGVVaEE/gxWMRfc0ChqxVhLh6QeZPwgSvKSAPkyI8CopQfviUKl8a
 0PlzbYBBo8ciaQhOXGf+wTF0Zf7IPQwUMAhHB2r3AtnQqXvNVoWSfVp7a9Bmprv0SH5C
 lwBVQ0bpINRAvPRUP/CLR5it5b220cGb/Cc7Kt9sjia6gk3QtyBv8KwysyTzkAzpZk9c
 NAN+MuD27AqvZ6dwPWmGKjGHVYbBlaOYnU0v91/q9waevijSfdVRZGcghdBs0doJhGR3
 G766jZYwdFZ00ojqssoDDtq2EnyT/zDZ4TRi2kZX7/uugbA98lQyBqyWFBfXelTScFLp
 SDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684921097; x=1687513097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F64YgIxEgVdDKFKSPKxj4a8a5AWO26EEsIqp9A+2/F4=;
 b=fiHM5LRYHYlVnE8Kbp/yrIkb28NTANVQPMHumXPWzkC8si7jo4ZyqHmzGZR7MxkgMc
 fwfE6EwwdVoZV2HyWlsdPDDUGLl15QNMB+mC8e8o5hV3bW6l2bnheZSzoYdow0q2i+QV
 ++4aSInlHOJm3mBOIiAODk9D+ie0x1StfTQ5+eUWlRSLWRptXuC78M36fTR7Np35d6XA
 lWJtWryRt5sfZ8J1MEtZsbA3EknADbtJ4szNd3jQ2cefekq8zvzd4Gfd483FL5BvePy5
 BRMkG9NKZYalYuZGryE1Sl7dcephcT8XTnMG5qz43AnF69E9+DNAJxG8NsJKy6ps6K/s
 vfag==
X-Gm-Message-State: AC+VfDx9H6tjNNRWTEQzE4SXssyTAAM0VZnRFiIXN9VZwkZRZWObF23m
 2FUW9RJfr5avv88ny70tPvNoVgmN+j9xNcetYKoBrA==
X-Google-Smtp-Source: ACHHUZ6QFUORH3vZejjJK4zwk83xvBP40cLwYNUzj7rChzOW/yOnrqt70YtcoHQlnaP/PKrU1+D+YQ==
X-Received: by 2002:adf:f74d:0:b0:306:2b2b:8c56 with SMTP id
 z13-20020adff74d000000b003062b2b8c56mr11979140wrp.37.1684921096852; 
 Wed, 24 May 2023 02:38:16 -0700 (PDT)
Received: from localhost.localdomain
 (fac34-h02-176-184-31-246.dsl.sta.abo.bbox.fr. [176.184.31.246])
 by smtp.gmail.com with ESMTPSA id
 o2-20020a056000010200b002ca864b807csm14155965wrx.0.2023.05.24.02.38.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 May 2023 02:38:16 -0700 (PDT)
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
Subject: [PATCH v2 04/10] hw/scsi: Rename target-specific source set as
 'specific_virtio_scsi_ss'
Date: Wed, 24 May 2023 11:37:38 +0200
Message-Id: <20230524093744.88442-5-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524093744.88442-1-philmd@linaro.org>
References: <20230524093744.88442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Following the SCSI variable named '[specific_]scsi_ss', rename the
target-specific VirtIO/SCSI set prefixed with 'specific_'. This will
help when adding target-agnostic VirtIO/SCSI set in few commits.

No logical change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/scsi/meson.build | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/meson.build b/hw/scsi/meson.build
index f2da0bc5ae..bde72df19c 100644
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
2.38.1


