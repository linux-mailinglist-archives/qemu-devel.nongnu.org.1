Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1E170E1DF
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:37:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1V03-00012N-4Z; Tue, 23 May 2023 12:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1V01-0000zD-9P
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:36:37 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1Uzw-0001eG-1N
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:36:37 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-30a892c45c4so2171409f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684859790; x=1687451790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V17lx77UXSYFaYQzaR+9S0XVX2qSAU+sO6hL7F9uBv4=;
 b=EfX64QvLK+EPw0S1IzOzzPtp1ebd7yJoOoLWs/iGkLh/xspE80UXCFujsm+SZoWlD+
 OQWjviOaDVOKHZmmgKAbGEZNizx18K+yvpfoRTHKeP5wtK0OdLfrnCxqTVsvO04nVYyk
 wvF9LAu2+m2BzhbKvXpWhNOup8YyUiuoiWLNYSU+aH2zN2uOJ0rwZM2MBr+cvAILlSJn
 JSHhoAp+APcAwSe9kcxxAMrf9leI2YLB1XtYqDolkzTlw94B9Cj2tmyXTyGiRk+maimT
 GjG3u2a/D1hPvJUwH/BBarx+HhGdXJdbfyTgEG8F3tQ9ZIKBGGaLiUFYWnk5kqFBt1aN
 4oCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684859790; x=1687451790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V17lx77UXSYFaYQzaR+9S0XVX2qSAU+sO6hL7F9uBv4=;
 b=hMfpUcb8C3Q7ukLfYlsCsH/XsoPYjJkRaQd5lr/vpX+eAxJWe0kYzdPKzxb+LTby6J
 wZs09dub7n2lm1gPP4+lMxleQuJfCQO9GA56R/j0VBw5ZANeXEoxqm7JD8OjrwBpwLN1
 CuHD1BqbYUj9i/lcYLtXagjbC+QSCVnptTmjlfWYBrKTeUquwAOd4eOyg0GjPHFpLO9o
 Len7LCrJyBfKCoAEBy8vQ/WdSAZlFLR9NpM7XyPrnDRyHgnJRlJVKRnHzdYWnbxZPs99
 YoA75kd+WQZzRTBwocp4sCpqLVpBMUlzRKndCHMRnmpdnoZdqBTgqBFawatJlUwMt7kL
 9nAg==
X-Gm-Message-State: AC+VfDy0eMdH8/brpCnSZKCckjdjfVE/UkoDaw1yqvIE6q0KauxQMpXP
 VtIKN4iMy/AdUuWQ/cSQmWE47An8GXKyKzeGmHo=
X-Google-Smtp-Source: ACHHUZ4erbpSOYhxHOMS7gzRmcxPBjmlEVNjDsgHDZhSN/4WC1oGdSRdEcR0AfBlSbIdw5t9dkJAvw==
X-Received: by 2002:adf:fa88:0:b0:2f8:e190:e719 with SMTP id
 h8-20020adffa88000000b002f8e190e719mr10839096wrr.65.1684859790372; 
 Tue, 23 May 2023 09:36:30 -0700 (PDT)
Received: from localhost.localdomain
 (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr. [176.184.48.94])
 by smtp.gmail.com with ESMTPSA id
 i7-20020a5d55c7000000b003079ed1f0a0sm11679598wrw.44.2023.05.23.09.36.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 May 2023 09:36:30 -0700 (PDT)
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
Subject: [PATCH 04/11] hw/scsi: Rename target-specific source set as
 'specific_virtio_scsi_ss'
Date: Tue, 23 May 2023 18:35:53 +0200
Message-Id: <20230523163600.83391-5-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230523163600.83391-1-philmd@linaro.org>
References: <20230523163600.83391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
---
 hw/scsi/meson.build | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/meson.build b/hw/scsi/meson.build
index f3206a4756..d88f7450e8 100644
--- a/hw/scsi/meson.build
+++ b/hw/scsi/meson.build
@@ -1,6 +1,6 @@
 scsi_ss = ss.source_set()
 specific_scsi_ss = ss.source_set()
-virtio_scsi_ss = ss.source_set()
+specific_virtio_scsi_ss = ss.source_set()
 
 scsi_ss.add(files(
   'emulation.c',
@@ -15,12 +15,13 @@ scsi_ss.add(when: 'CONFIG_MEGASAS_SCSI_PCI', if_true: files('megasas.c'))
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
+
 specific_scsi_ss.add(when: 'CONFIG_SPAPR_VSCSI', if_true: files('spapr_vscsi.c'))
-specific_scsi_ss.add_all(when: 'CONFIG_VIRTIO_SCSI', if_true: virtio_scsi_ss)
+specific_scsi_ss.add_all(when: 'CONFIG_VIRTIO_SCSI', if_true: specific_virtio_scsi_ss)
 
 softmmu_ss.add_all(when: 'CONFIG_SCSI', if_true: scsi_ss)
 specific_ss.add_all(when: 'CONFIG_SCSI', if_true: specific_scsi_ss)
-- 
2.38.1


