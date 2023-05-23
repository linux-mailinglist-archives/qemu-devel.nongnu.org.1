Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4228F70E1EE
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:38:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Uzv-0000fR-SH; Tue, 23 May 2023 12:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1Uzs-0000T6-Ri
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:36:29 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1Uzk-0001bZ-H4
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:36:26 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f6077660c6so792025e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684859777; x=1687451777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Gn+HBFJ064NVzM7YmEXvqcvjJjkdoC6PwfC7PPhyMY=;
 b=SSqzoM0Q/DaDxV78ankhptGCeuezA4AZlLMlhIpKL0OlSZ5n+k8djkali1bO5Nt8rk
 uqZiG9gXa6mpA7KTCxflsp4VF+tFbojRkhycldXEU0gCrnigaqRNkPqBGW8xbVgw/UwP
 EC7FwUUgdm4INPzQLoNSb52uM1v3pn900OztBmLnaSd/URgSCVVfYknMld5UEUzBFfBS
 bo3VZPiJ3wRGyxD+I764aN+5nTkimi6Wf0+x+qS+yHkYIrDYJR4U8VMW5Dhwwo6I4rrb
 3E6fdoBH9FzvNgznYby/K2aOWwAZ9Wd8cpTpYJTAJHZoo/MQ657ykBpwsmBLK0UCd39S
 hG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684859777; x=1687451777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Gn+HBFJ064NVzM7YmEXvqcvjJjkdoC6PwfC7PPhyMY=;
 b=lcN/HGYwzpq1wIMfj8OGjfRDDnSstM4yqn6/JT5nCsZ0XPraJ9c438ijDgXc44HPAR
 j58scE+2/xwjsH1BKeoBPt2Cwr4PYxShEyMO4HFTI0y4Lo4KVLIOgqR3w1NcRhndAYY0
 VQXFG0RVW42UXT1SfEzPbkm+4uuL3KJUxzRwojqFUmueMIGHJB/8YklE6OSq66oJX0ys
 cgOtOkiYhQ/A7aG4O+CNPOARrBTZzYb2A66i8g93Q3jGG8TQ9dz8x1uuvc6MGecmw8V6
 3vs1hKMZr88FHybOa6gzcxWuuIw8ORkMoIZCHD+ONPsVyySGVgbvEtvO1H5WvQItpim8
 D3mQ==
X-Gm-Message-State: AC+VfDxQVVuDB/GS0CWqH3DNPS1ha5VmVLmIHUdfHwsbaTjmy83aPLiN
 XRRJNKKbFehnXHGmidT/a1nOK6vzKf19lObQd7g=
X-Google-Smtp-Source: ACHHUZ4j+9tz+X7tqPwMzajs8Vabw9JDETD32VA4MNx9VnKii8n0epbBkq4oJ01C8Ps0TQ8qoNN40g==
X-Received: by 2002:a7b:cd01:0:b0:3f4:2327:53c2 with SMTP id
 f1-20020a7bcd01000000b003f4232753c2mr11349659wmj.19.1684859777178; 
 Tue, 23 May 2023 09:36:17 -0700 (PDT)
Received: from localhost.localdomain
 (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr. [176.184.48.94])
 by smtp.gmail.com with ESMTPSA id
 v16-20020a1cf710000000b003f4fe09aa43sm15572466wmh.8.2023.05.23.09.36.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 May 2023 09:36:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Farman <farman@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: [PATCH 02/11] hw/scsi: Introduce VHOST_SCSI_COMMON symbol in Kconfig
Date: Tue, 23 May 2023 18:35:51 +0200
Message-Id: <20230523163600.83391-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230523163600.83391-1-philmd@linaro.org>
References: <20230523163600.83391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Instead of adding 'vhost-scsi-common.c' twice (for VHOST_SCSI and
VHOST_USER_SCSI), have it depend on VHOST_SCSI_COMMON, selected by
both symbols.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 923a34f344..fa9198e69f 100644
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
2.38.1


