Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 015E6AA9A18
	for <lists+qemu-devel@lfdr.de>; Mon,  5 May 2025 19:06:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBzF5-0005gy-8H; Mon, 05 May 2025 13:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uBzDy-0005IP-No
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:03:37 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uBzDw-0003XQ-UR
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:03:26 -0400
Received: by mail-pj1-x1042.google.com with SMTP id
 98e67ed59e1d1-2ff64550991so3475209a91.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 10:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746464603; x=1747069403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=939kVvIFxgaahLg5gfBOdgC+WyLmCdm19fFHEFWyZSY=;
 b=iy3O/c1qDQMxGf2oPPGpgeMWcuSV841supan85RvFS6dpeWs7as6xRfsHXQqAsH3AK
 p10fd+hrZ07xYzTaoanbwe9eJ8osRbA1lr1FOPjRL1CMMsWLioOi4FvHcbSI6D37OLJZ
 f+kBEv7u1MvvVu4d/AFkh7X4M64ulxSY1gN4dU4pHdKxwqJHbPEJ2Sxmx+Ma44m7sVz/
 K6TlTKE4zbBkrC3C/UCGNX6TeAZWLTeYudDuK0fSfJXNv3/Gu1esx0o1TJbO85XkOVUz
 i5PR0kcGqnAZClXw7nZ6VIdm2gPXBL1rR+pOLWRHT56gtYVLREMkgpKdcebBHbjBChtk
 ZdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746464603; x=1747069403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=939kVvIFxgaahLg5gfBOdgC+WyLmCdm19fFHEFWyZSY=;
 b=VoC+xFFQmDos3zX6WnrjLRE2qwJQsGibdl3fXAC7qYQS4HGIyXQjF9eNdeJdZ1IXTI
 2L1hKNNl+wOPclsxAdzlLB4BIW8c18VbQjgkx6XHUq958nQQSyH4BmepNCswoip3PX06
 324RTOK/iZB5y0oQLh5QZ5eQpm2tDotp5fE19ebkfJKEaBbCcYzPKNSRWQF4143P9cIA
 p58NwOi+93NfFVUN8axs7MrKXP3pyQWg+P8O8DSKbiDK4u0wvfzG2PulFuQg4YId8m85
 iO8ukUY8Zjn4pffEdJKKqN9eCDCtCRTZq7sADJnOpWl9JKM/PyKXJ3tLEWoAYSFEqWGr
 pPPw==
X-Gm-Message-State: AOJu0YwZjcQKDwYv6RufHBFuwPjMhvYeVc3UA9BNDrIwnh/sfgqpZyxe
 NbLxDfgw2jnaAqkfbxPbhTi8sWgy1xe6icOxJkIEXDgbB6Cdu/0=
X-Gm-Gg: ASbGncu6KRvriAVkWSll2ntRkUqAsj9p/ecSVMzm7Iim8qZVFAeydEyjWQqbMYkV7zf
 8Y8s+w+jeQNKbRfhVYv9SACChmN1SXmbtk+0nUSknJT8QKmltohQsit0JIHZgpDvSDT6/jm2VfC
 cE3qv/qTqHMCok5QuLzl72JW2IUngt+SBs828Lv/OaKyG0Nv2FANje1W67kf2o6icaOOAhKENf3
 fjW1JPywklDkeJl8UDrGtCYS4MRSgu2lgeqPI9fevA7IymGhfQe34g3kpjKde5/5lC2+2VYyi8W
 PaKcg2FgDqK3FdyTOxayH9yKOHBzaRAoB/n/QoObA2WBslOfbBgRp2Bl
X-Google-Smtp-Source: AGHT+IG2rBubRkzvXZIIcTCnrSEqTaJyeLiicaGdi7lLZYw+XI/rOJNlIH/ySAiRzenEpbkP6QAB6w==
X-Received: by 2002:a17:90a:e70b:b0:2ff:618c:a1e0 with SMTP id
 98e67ed59e1d1-30a61a44bedmr12362073a91.29.1746464603391; 
 Mon, 05 May 2025 10:03:23 -0700 (PDT)
Received: from localhost.localdomain ([139.227.182.131])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151e9e9dsm57335135ad.83.2025.05.05.10.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 10:03:22 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH v3 2/9] vfio/igd: Always emulate ASLS (OpRegion) register
Date: Tue,  6 May 2025 01:02:58 +0800
Message-ID: <20250505170305.23622-3-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505170305.23622-1-tomitamoeko@gmail.com>
References: <20250505170305.23622-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj1-x1042.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ASLS register represents the base address of OpRegion, and it is
programmed with HPA. In IGD passthrough scenario, it needs to be
reprogrammed with GPA by guest firmware. To prevent guest accessing
wrong memory range, ASLS should always be emulated and cleared.

In GVT-g scenario, emulating ASLS is unnecessary as access is handled
by kvmgt backend [1].

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/i915/gvt/cfg_space.c?h=v6.14#n295

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index e06484c911..b1fce76f72 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -182,10 +182,6 @@ static bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
 
     trace_vfio_pci_igd_opregion_enabled(vdev->vbasedev.name);
 
-    pci_set_long(vdev->pdev.config + IGD_ASLS, 0);
-    pci_set_long(vdev->pdev.wmask + IGD_ASLS, ~0);
-    pci_set_long(vdev->emulated_config_bits + IGD_ASLS, ~0);
-
     return true;
 }
 
@@ -584,7 +580,15 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
     if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_LPC) &&
         !vfio_pci_igd_setup_lpc_bridge(vdev, errp)) {
         goto error;
-     }
+    }
+
+    /*
+     * ASLS (OpRegion address) is read-only, emulated
+     * It contains HPA, guest firmware need to reprogram it with GPA.
+     */
+    pci_set_long(vdev->pdev.config + IGD_ASLS, 0);
+    pci_set_long(vdev->pdev.wmask + IGD_ASLS, ~0);
+    pci_set_long(vdev->emulated_config_bits + IGD_ASLS, ~0);
 
     /*
      * Allow user to override dsm size using x-igd-gms option, in multiples of
-- 
2.47.2


