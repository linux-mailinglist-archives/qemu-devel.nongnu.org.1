Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E0E7E976F
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 09:16:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2S5U-000367-SU; Mon, 13 Nov 2023 03:14:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hoo.linux@gmail.com>)
 id 1r2S5P-00035o-6u
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 03:14:23 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.hoo.linux@gmail.com>)
 id 1r2S5N-0006AP-0W
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 03:14:22 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6b2018a11efso4298326b3a.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 00:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699863259; x=1700468059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7sDyBD7rH4imidPUCNruzWQgHEdAelj0Aw5AXncKUKQ=;
 b=gHGnO/iNjMlSvYa7AWIletEbcg4G8C7xRjkHmoyicVylG1URPFbnePkgYmY3LW+SPX
 0lrm6LvFAPB8X1fImMAQPnn8jHe5J7bsgylVYDz4CfY5FOO+HGdfiuRuJAZ4Gl84ecGb
 2suCrRLN7zxqD5zssxdNmjuQv2AV7qK64jLX4TXEjpN//ziMs0nL0WJRpZlH8Y6E2d1S
 oGW/ytbq2W9J2FsRLVZE/Hvl9eWAmCJARkT4c7xuB6fsQy6X+0vetko6Onf0nNTyF54F
 f6BYDeZZYEAYZLE0mVgwzWkia0TQInUnPaWrw5jeprtE/YvlwJxHb7KXxzVlICrDQ4el
 C5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699863259; x=1700468059;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7sDyBD7rH4imidPUCNruzWQgHEdAelj0Aw5AXncKUKQ=;
 b=PH2vU7z+X86Nvl9v1k43J6hAUrsjzRpfXWrxev0lVgjFiDwv5cVE7KxS1kadWNDbu0
 7G+GLGc/aabgQHm1VlI1Ui4CuzczSqtxvviyWxhy05YYVxiA3lp/WVuNhxpi8+kHa7Py
 CtPh1Dz+54kosd/HK3+Rd/fT/njr1X5EeY5PrXYPQpndhBP604X4lQAr4zv7f3xcaymu
 NUFhmhkplqcbt5sfTRcQKTrUwYWcEJdvGdi1zuuNOtz1AL0y1BY0UCrLihXkZ0nP9Ry3
 dR3tP+CV8zJF1fFHlZpid02JHJgy2NFqipiBuk5ytkcydIrWKvJBPh0ilJsvxUSHh1dL
 oMhQ==
X-Gm-Message-State: AOJu0Yy8m8KNUK8qWSfyi15O4A/MY2OPCnutdPHNx2EYyIt+b5K1k52b
 kEVdNon7j9dDm2+pwYytMC7BLxGIRsk=
X-Google-Smtp-Source: AGHT+IG2rnfmRBDZ81HFP89B4ERGwbD30UqDMiS+pCL/ixUn8Mgw/F6VicU5I57B5sM7tEpqKk186g==
X-Received: by 2002:a05:6a20:3d0f:b0:186:5265:ed3a with SMTP id
 y15-20020a056a203d0f00b001865265ed3amr4344442pzi.57.1699863258929; 
 Mon, 13 Nov 2023 00:14:18 -0800 (PST)
Received: from localhost.localdomain
 (ec2-16-163-40-128.ap-east-1.compute.amazonaws.com. [16.163.40.128])
 by smtp.gmail.com with ESMTPSA id
 ey8-20020a056a0038c800b006c2fcb25c15sm3414692pfb.162.2023.11.13.00.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 00:14:18 -0800 (PST)
From: Robert Hoo <robert.hoo.linux@gmail.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com
Cc: Robert Hoo <robert.hoo.linux@gmail.com>
Subject: [PATCH] msix: unset PCIDevice::msix_vector_poll_notifier in rollback
Date: Mon, 13 Nov 2023 16:13:49 +0800
Message-Id: <20231113081349.1307-1-robert.hoo.linux@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=robert.hoo.linux@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

In the rollback in msix_set_vector_notifiers(), original patch forgot to
undo msix_vector_poll_notifier pointer.

Fixes: bbef882cc193 ("msi: add API to get notified about pending bit poll")
Signed-off-by: Robert Hoo <robert.hoo.linux@gmail.com>
---
 hw/pci/msix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index ab8869d9d0..cd817f4ca8 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -648,6 +648,7 @@ undo:
     }
     dev->msix_vector_use_notifier = NULL;
     dev->msix_vector_release_notifier = NULL;
+    dev->msix_vector_poll_notifier = NULL;
     return ret;
 }
 
-- 
2.39.3


