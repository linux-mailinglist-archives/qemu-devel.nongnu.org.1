Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C46D70E1E5
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:37:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1V02-0000zh-Gc; Tue, 23 May 2023 12:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1V00-0000z1-Te
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:36:36 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1Uzp-0001ct-QY
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:36:36 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3090d3e9c92so7578246f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684859784; x=1687451784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yhObE3lO9NW7n22ou/6MvOVRIrPs/DPwiwLTQULI9M4=;
 b=W3Hwxp3S/l+jWxTCqJu/rKV65EhkJH+fbFCdLCDpwR2zyZWgke+JXkQdtFbWH0NkhI
 XhQXolyll7VhQQlDJtX+XBHKwI2HOicNPQHAfZrKiNamOK/3rwyXRukivBytBrH/U86o
 r0SstjElRjaQte7kSvCGvqaxXmP99aPO+LYbDoP1+DdsRKbb1f398ac7SMUKXpQECPu8
 AwttZaCoHcPB/I+mRgez+YynqozocifqUNeab1u7XIZDA8uocj4u7A/l7riiiStRjU5r
 VoZjRaRvYO3F9Z+rlW7hPhuncMrY9Ywsa84tlXwG1mrNCbHerhaJ6XWIx8EgZD28q2gj
 UTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684859784; x=1687451784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yhObE3lO9NW7n22ou/6MvOVRIrPs/DPwiwLTQULI9M4=;
 b=j4u+YhISabpvY9RXoUprNuCEkaokGPPMamwpykBNT9aQdCrATlOtfDWT06typac1Mm
 9BkbmrCs0QFCz9OvFZ0ejFiXe/6D01iOxMCD/h8CpdblSEBA+8RJPze+9X6wu6F3EyQA
 CHXj5S2oT4wIEpNHwZksxUcY3jwXDJEZeuN/U6j/VQQYR+2mQeUsdj87knOYe6SuNWAn
 Qxdli1J5onP2KdjTmZwTN5q/o8a+I4NHfuHy1sl6iQXi5YaZbEl2G0Vnc6Taz3GQDEth
 zQGywWxcFB9hBr5NZy4GwA3NLiJuAoxzc9GNsEptVSaNPLw/5ry0l0t0syRZyBTp5p/g
 jc4g==
X-Gm-Message-State: AC+VfDxT/cZcieYF+ygBczyn+/1Lzw70Fw98pcCLDYHLvEhTQk3uPqgy
 kPSIkmQ2qgAkh8sVAYJgbpFdfj/yKm3ynB2M4Oc=
X-Google-Smtp-Source: ACHHUZ7Gklq4Pcu8EVPidwbsmCbaJfuKwGFtnIWuxEOllUUZGwoR5tZCd2ICMTESmN1mjxpXiZ6i/A==
X-Received: by 2002:adf:f711:0:b0:306:35d2:c33a with SMTP id
 r17-20020adff711000000b0030635d2c33amr11309900wrp.50.1684859783945; 
 Tue, 23 May 2023 09:36:23 -0700 (PDT)
Received: from localhost.localdomain
 (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr. [176.184.48.94])
 by smtp.gmail.com with ESMTPSA id
 d6-20020a5d6446000000b00307a83ea722sm11642193wrw.58.2023.05.23.09.36.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 May 2023 09:36:23 -0700 (PDT)
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
Subject: [PATCH 03/11] hw/scsi: Rearrange meson.build
Date: Tue, 23 May 2023 18:35:52 +0200
Message-Id: <20230523163600.83391-4-philmd@linaro.org>
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/meson.build | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/scsi/meson.build b/hw/scsi/meson.build
index fa9198e69f..f3206a4756 100644
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
@@ -11,18 +14,13 @@ scsi_ss.add(when: 'CONFIG_LSI_SCSI_PCI', if_true: files('lsi53c895a.c'))
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
+specific_scsi_ss.add(when: 'CONFIG_SPAPR_VSCSI', if_true: files('spapr_vscsi.c'))
 specific_scsi_ss.add_all(when: 'CONFIG_VIRTIO_SCSI', if_true: virtio_scsi_ss)
 
-specific_scsi_ss.add(when: 'CONFIG_SPAPR_VSCSI', if_true: files('spapr_vscsi.c'))
-
+softmmu_ss.add_all(when: 'CONFIG_SCSI', if_true: scsi_ss)
 specific_ss.add_all(when: 'CONFIG_SCSI', if_true: specific_scsi_ss)
-- 
2.38.1


