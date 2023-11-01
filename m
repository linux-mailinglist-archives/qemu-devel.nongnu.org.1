Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 727C67DE164
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 14:17:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyB5Z-0000IU-P6; Wed, 01 Nov 2023 09:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qyB5I-0000HP-Ef
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 09:16:38 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qyB5F-0003dl-TK
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 09:16:35 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1ea82246069so4327607fac.3
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 06:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698844593; x=1699449393;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lFF+xz1moS0zKHI0k5mkW8skLO8foQZJd4bTPswPJb4=;
 b=v0xO01kQPc1YETflmiX9dyr/+2eH37vK04DYWpTgcuh/aWc4+zqS9yYVdMpOQgb2wj
 SjvyFGqi6ViJfq1nGADwwLt2pOuK56YCyEhvg/A3EyyEoE9YeVd8T7iKJaBcceI7VNuH
 Oh+QlZ2m7tFDrO1pM9wwopXJTSwxMAhYucsxll1Lsl/kmPlp96jXGjowsPSaIb9uN8xy
 xzwc2RQ4t+kkGcAHY6S2fHh7iIem6y5bxxg3w1rGb5rYymjEX0czTOCNwQCRYSlK31e+
 5/MzdG3ma/LXm4Cf5zsrK6ZksfVoHfOpeP7oiLg2+cG6mgsRbUWB/G/QDOZ3zAjRzFnp
 V9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698844593; x=1699449393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lFF+xz1moS0zKHI0k5mkW8skLO8foQZJd4bTPswPJb4=;
 b=rHno3A10K/bY19XIYxVAL78bObn0O7mVT8irN8V9gg8ZOwtRr3mANQ9SMXZaRVYRXk
 V27uJLRa0mbVLxQ4jOei/f0nSPwDf2YwzOW0BVhjHh997ZJbDHnFSqfJEDOPSV7gQhTA
 IsL7A/JGnrcmT3IcCT//2MLdsra1sMhwVMXh6Q9tmkrya3dHNSIk5gK/dfv1WZkEqJ/f
 jf4bsp1qlu5/w7zGPHanl3rUmpBJiKC0rjVCjMZKsiR1gsPJJaIOAX7ZRN2oY0EKp3gn
 Ei03XhvAz4777VW6JA2BhfsEucg9Vg99uoOyASqc9OSVJ7tcf5aFn+ddW4au+XKrDeG8
 8nag==
X-Gm-Message-State: AOJu0YyOs9HQFwvIHB41+N6Th7szu2rN7thMk7B4SFdqxUAq3fquLNYf
 vG8oS5Ouw+f3K0SYSo332+mT6A==
X-Google-Smtp-Source: AGHT+IGAEwmbBU+noDaEflmAuWhFDJ9kbaPWu1NsDUtoclcAcxDU1Z0Wg7ARq94m/WMDhlxJ0aps6w==
X-Received: by 2002:a05:6870:4202:b0:1ea:7bd1:c48d with SMTP id
 u2-20020a056870420200b001ea7bd1c48dmr21140574oac.49.1698844592343; 
 Wed, 01 Nov 2023 06:16:32 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 y6-20020a056870e3c600b001d4d8efa7f9sm238148oad.4.2023.11.01.06.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 06:16:32 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: stefanha@redhat.com, jag.raman@oracle.com, qemu-devel@nongnu.org,
 peterx@redhat.com
Cc: john.levon@nutanix.com, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v6 5/5] vfio-user: Fix config space access byte order
Date: Wed,  1 Nov 2023 06:16:11 -0700
Message-Id: <20231101131611.775299-6-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101131611.775299-1-mnissler@rivosinc.com>
References: <20231101131611.775299-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=mnissler@rivosinc.com; helo=mail-oa1-x35.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

PCI config space is little-endian, so on a big-endian host we need to
perform byte swaps for values as they are passed to and received from
the generic PCI config space access machinery.

Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
---
 hw/remote/vfio-user-obj.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index 9f5e385668..46a2036bd1 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -281,7 +281,7 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t *vfu_ctx, char * const buf,
     while (bytes > 0) {
         len = (bytes > pci_access_width) ? pci_access_width : bytes;
         if (is_write) {
-            memcpy(&val, ptr, len);
+            val = ldn_le_p(ptr, len);
             pci_host_config_write_common(o->pci_dev, offset,
                                          pci_config_size(o->pci_dev),
                                          val, len);
@@ -289,7 +289,7 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t *vfu_ctx, char * const buf,
         } else {
             val = pci_host_config_read_common(o->pci_dev, offset,
                                               pci_config_size(o->pci_dev), len);
-            memcpy(ptr, &val, len);
+            stn_le_p(ptr, len, val);
             trace_vfu_cfg_read(offset, val);
         }
         offset += len;
-- 
2.34.1


