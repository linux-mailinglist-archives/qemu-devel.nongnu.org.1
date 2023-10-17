Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDFA7CC574
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 16:02:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qskeJ-000402-5v; Tue, 17 Oct 2023 10:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qskeD-0003yO-P6
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:02:16 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qske4-0008Ko-T8
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:02:13 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4056ce55e7eso54919655e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 07:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697551322; x=1698156122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jK9MnOkarN7NF0Qc/XLSYHaYAFfcVhsfbF2N1g/hNuw=;
 b=zSdT+W3RXlk8Y+3VgBCP3MsJ/OnvuuLZTZbf33m0UqBVFYinFzWm6xqx6vKB6VfhXd
 gG+KmKFbIUiNRNOdeQUutJzVOmjxZ7ba+ROV/s0htRUPb5NPdvbQ39sMMIODSIlu/5rW
 mTUwO+ntSr7ziwNfdqQNZcrLoHSnvWd6xQ4SDOdOTUinTj867TNy34HndKO7fx+oZkj4
 wSbFIDxlWYkl/ew3vhaPebKznJv45Hr17BeJ+6hH8v+fXa20RaHa9qF8L1WyhFGjWIww
 0tQKRHF40rF+C/QVRDtLqgNAJPgVkNAGXexNxl/dQTuSHPw+TxzBQavNWEI9RlFzGWvh
 EVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697551322; x=1698156122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jK9MnOkarN7NF0Qc/XLSYHaYAFfcVhsfbF2N1g/hNuw=;
 b=Rd32QW7bjr+qRstnaXcQbLDN1mRNVTkOWG2hjcdyG/sDu6LVNKKGckx3u7jiU8DaNS
 7LJohEBR2nHYaKV/CLWJ5QkEEXEWf0Grkty+t7Mn6bfQzp+1NH7zj01rhpkZInPf0CyN
 ROUiHGTYgd74BOk9JYH6kyu6lcmp59U7D2Qh/YwXaNV+bXIe1FDLVsLDQQ7rLzgvWKIW
 BX0I4amxEra3eP2MMSGmvFjN5bpHHOhRl1rTEYtu/dCMWmjtjzicBuLLeLdRiEIogrQy
 IbvVXOI9MrTNQS0W/uFanH/MONNN/Kjo+5nroG9Y1w/806GWoi7A+1G3f5HEFo0FPH16
 Qq2g==
X-Gm-Message-State: AOJu0Yz1uYVVmX/MtDABLbJ7JU3XHLuA2B88Kcq9lHOPwrut9gNIAbbe
 vFeWhfznRUBSWJiIebHtEhWkv1W8OeNNKwqL3LFhMw==
X-Google-Smtp-Source: AGHT+IG3Fi/Mf+GMzY7bX4gwdm9dKJt+y/MVWf9MrgDti6pOMo+hv2DO0QpvunsT6Z6CM906O8a/Cg==
X-Received: by 2002:a5d:6802:0:b0:32d:9a1b:5d79 with SMTP id
 w2-20020a5d6802000000b0032d9a1b5d79mr1705786wru.33.1697551321681; 
 Tue, 17 Oct 2023 07:02:01 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 x5-20020a5d60c5000000b0032179c4a46dsm1730095wrt.100.2023.10.17.07.01.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Oct 2023 07:02:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/7] hw/virtio/virtio-pmem: Replace impossible check by
 assertion
Date: Tue, 17 Oct 2023 16:01:44 +0200
Message-ID: <20231017140150.44995-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017140150.44995-1-philmd@linaro.org>
References: <20231017140150.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The get_memory_region() handler is used when (un)plugging the
device, which can only occur *after* it is realized.

virtio_pmem_realize() ensure the instance can not be realized
without 'memdev'. Remove the superfluous check, replacing it
by an assertion.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio-pmem.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index c3512c2dae..cc24812d2e 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -147,10 +147,7 @@ static void virtio_pmem_fill_device_info(const VirtIOPMEM *pmem,
 static MemoryRegion *virtio_pmem_get_memory_region(VirtIOPMEM *pmem,
                                                    Error **errp)
 {
-    if (!pmem->memdev) {
-        error_setg(errp, "'%s' property must be set", VIRTIO_PMEM_MEMDEV_PROP);
-        return NULL;
-    }
+    assert(pmem->memdev);
 
     return &pmem->memdev->mr;
 }
-- 
2.41.0


