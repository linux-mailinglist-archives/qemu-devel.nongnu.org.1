Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B7C70F31D
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:39:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kwd-00059T-RI; Wed, 24 May 2023 05:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1kwZ-00056c-Tr
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:38:07 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1kwY-0006o1-4u
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:38:07 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f623adec61so3116945e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 02:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684921083; x=1687513083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lnZlj3i7pDAPQ4/SoUu9ZpheF+HMfcfUHEdU+g8AbV4=;
 b=OZZU2QTSCg/8tbuBctWLi/qUL4Fm9Hohcz2y6Mbv4cs32moaLIIlCOjFuwD/5rJJLX
 Tjeam4+GQEI/FoZRcVOXjTKvB/bJReZn73SIO398kXdcDvQh6pHEg9s1pjQgYLjOjhf2
 xZzbh/zE6LUxJc+iP7yElzmW5UA3z7ZU1cdx8rrvMSBvShTLkXG48gXD+QafVLh5BG6G
 MO5XzYcCqEnA1CADu2L17JhrDU5uDOyILDfulZOk6OKjEMA6HLvdalAXFxZV74JND08d
 k4bt8BAgFABG0Z2z1T+7PLiG5lkjJ1lN74/6Ex5WLE/MWHESHgWRMuifPRAUHkCv6/h7
 TO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684921083; x=1687513083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lnZlj3i7pDAPQ4/SoUu9ZpheF+HMfcfUHEdU+g8AbV4=;
 b=GAkdbwwztj2SvBAoIAh1854eg7dPF/qDdQh76ZpmHY8ipMpytpfnBkgNz9BsMcUGQj
 U+5RiikWvGJT8SfNaTZp55WgkAB1+7sSxg0S+xiiT9tX8jw4oAHNp1AABgADQANJhY6F
 nJ8W0ppm5E2tRAv0FSoac/JLhB82wmvNl+iYJCsGj7YFrOqhqQ5w7G6r4Ari6ERu6F2R
 eLJIhNoDs2YSLMkqR83MP9qSllc1TgABD9TBEm8jyyEte1wXK0n3f+2QpAPjZlv8ToxP
 FG/Fi15jEDzEyEBAOeHVQ7m8EUcAvYeWO4D8W7ufosj4eMIL7MYGSEmNLmJ5Bevb4k8m
 6oFw==
X-Gm-Message-State: AC+VfDyrgeMms4B6lLhBReQhTe+kdjbhEbDSKhs7pqf5AzKK+kmVNDQs
 MxOFNqUMzcauUMZqyUD4XSaa3cB4Rf/Rxpp+i1dyuA==
X-Google-Smtp-Source: ACHHUZ4hqzJfIXuj4E6k+El0K6W9ffO351mLM9orpTMPhzVXhkIIPudCWNaT/TNPO2gT+zbtj+mDiQ==
X-Received: by 2002:a05:600c:2185:b0:3f6:459:eba3 with SMTP id
 e5-20020a05600c218500b003f60459eba3mr6773029wme.0.1684921083386; 
 Wed, 24 May 2023 02:38:03 -0700 (PDT)
Received: from localhost.localdomain
 (fac34-h02-176-184-31-246.dsl.sta.abo.bbox.fr. [176.184.31.246])
 by smtp.gmail.com with ESMTPSA id
 2-20020a05600c028200b003f42cc3262asm1652892wmk.34.2023.05.24.02.38.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 May 2023 02:38:02 -0700 (PDT)
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
Subject: [PATCH v2 02/10] hw/scsi: Introduce VHOST_SCSI_COMMON symbol in
 Kconfig
Date: Wed, 24 May 2023 11:37:36 +0200
Message-Id: <20230524093744.88442-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524093744.88442-1-philmd@linaro.org>
References: <20230524093744.88442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Instead of adding 'vhost-scsi-common.c' twice (for VHOST_SCSI and
VHOST_USER_SCSI), have it depend on VHOST_SCSI_COMMON, selected by
both symbols.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


