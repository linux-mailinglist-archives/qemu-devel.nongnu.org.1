Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAAAA5BB86
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Mar 2025 10:01:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trvRa-0006O1-LU; Tue, 11 Mar 2025 04:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trvRX-0006HG-71
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:58:31 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trvRT-0001MY-KH
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:58:30 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso16262535e9.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 01:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741683505; x=1742288305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3wzRgEsGaXRZwRoJYmbO3pLRuFrdPRdwQX8ON5xd3gU=;
 b=fp9oY7GjGVoKymyCtJUeK/geZIrq2SgOq1F1jY/QTX6TYm8ICdw1bnCJS186mw8dVc
 VGu5y0tQJGtxEIDRfERN7PnUSUY2KefZbEpKEj8g/MsCRRWtn5hpK7qveHiNvmLBcbZ9
 g+tOlVjzDDhM3T+qhp1th6jI7XvcfcABdXN8ZeUzRZ8lOGEwPaz+4xCmg8njbP79CniM
 DkrOY5stEOi/cQwAQU5iFY8I7gLTZZP8pdMJ9zTkOIrPacdyOHpjWVCYhoZQX7DDID1P
 hOe8Fu3OPlp2IUEMkMDVPmXEgg12qYArkWuXcYSbNQy4CqtobNNpr1QhYuctdoOPht65
 RYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741683505; x=1742288305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3wzRgEsGaXRZwRoJYmbO3pLRuFrdPRdwQX8ON5xd3gU=;
 b=EDYH0LPto44J1ifHBd+mQKizUaQqtoF14R+zYow3YO0s0QLhBmXqsf5DQIdBroQZIO
 qBs+l3Jt4s4tftbZPOzPlmRrq6ja3ogSe9T00HNmKk7StHWwutdIfeJGuA2R5C0q/OJM
 wnip0CUz9rosJ9bgzUigkqdVFifWjjR7MxTERCcskCRcwlzkyRO/cc4IYRT4ceccG8PQ
 LTuN7YqGZqhy9Qjc/T8epcm1lwC0Sw9L8AtYe019AF3Es8kfXvA1bJJNmIU6anEPhQDy
 aoPHQUI20iU34CZY4F2loWYPUdras3GAx8BUEohVDUQPdQzqPUUOiI8GzzpI33EEgPW3
 yOpQ==
X-Gm-Message-State: AOJu0YyHNhHT+BiBG0hg7OM4O69Fm+FTG3wzZ5WuRF07rAe2Wm6whwrc
 O0x2Xm4IzmNLV8P6Xngm0VnfNysNfnMjBDVC0aAyPtehwvP7uYDamB1Of1qStasM7YOFe+Kh+p2
 t91A=
X-Gm-Gg: ASbGncvU/Eaq618vnHPnGTsKgl9jsMRK4N1lksokABou2yaL1v2XF6RwaX/AFFM91bz
 PhsXIHMBpPLjxct9GBncij+bunQq1fNetuuAr+Hb6HNViorjQzoI0yiWborFAYmMtiW680zuWnk
 Dp+hdMltRs7ra0ws4XV2E9zGHdqnvlhYUu+xVZxmqUdfQ/ygTUDig7JO+NPqqmLcyD8Kw54bwGU
 JjS4ySNdcFZ1g6odRm6XSkNx3i7/xqvKwVKes2RtpaYsLeDjotwpGTnEDImSr4NcdZJ0KeKYEd4
 ebM+NxHw+K8YIV9XsNaVq0Ww9sOd5w1FwKA0OwWel1Xcz8brRY9UpAoXYbai7Ypkf73zhIBKQ6X
 toq/k9zCyxJWLin0DEUs=
X-Google-Smtp-Source: AGHT+IEEEnVJarcGGjUK/21VA5TSdLNOgqq7tbfGncK0sjNzc+6qaDn022tJvzSrCZfe2Fv7eBB66Q==
X-Received: by 2002:a05:6000:1885:b0:390:fbdd:994d with SMTP id
 ffacd0b85a97d-39264694d6bmr3391332f8f.27.1741683505006; 
 Tue, 11 Mar 2025 01:58:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d03dfeef6sm16463615e9.8.2025.03.11.01.58.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Mar 2025 01:58:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PATCH-for-10.0 v3 7/8] hw/vfio: Compile iommufd.c once
Date: Tue, 11 Mar 2025 09:57:42 +0100
Message-ID: <20250311085743.21724-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311085743.21724-1-philmd@linaro.org>
References: <20250311085743.21724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Removing unused "exec/ram_addr.h" header allow to compile
iommufd.c once for all targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20250308230917.18907-6-philmd@linaro.org>
---
 hw/vfio/iommufd.c   | 1 -
 hw/vfio/meson.build | 6 +++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index df61edffc08..42c8412bbf5 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -25,7 +25,6 @@
 #include "qemu/cutils.h"
 #include "qemu/chardev_open.h"
 #include "pci.h"
-#include "exec/ram_addr.h"
 
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly)
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 784eae4b559..5c9ec7e8971 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -4,9 +4,6 @@ vfio_ss.add(files(
   'container.c',
 ))
 vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
-vfio_ss.add(when: 'CONFIG_IOMMUFD', if_true: files(
-  'iommufd.c',
-))
 vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'display.c',
   'pci-quirks.c',
@@ -28,3 +25,6 @@ system_ss.add(when: 'CONFIG_VFIO', if_true: files(
   'migration-multifd.c',
   'cpr.c',
 ))
+system_ss.add(when: ['CONFIG_VFIO', 'CONFIG_IOMMUFD'], if_true: files(
+  'iommufd.c',
+))
-- 
2.47.1


