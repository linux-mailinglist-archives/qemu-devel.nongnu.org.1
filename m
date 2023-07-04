Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 871AE7467F9
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 05:36:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGWoV-0001Bk-Ge; Mon, 03 Jul 2023 23:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qGWoT-0001Ap-4I; Mon, 03 Jul 2023 23:34:49 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qGWoR-00032u-GO; Mon, 03 Jul 2023 23:34:48 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1b89b75dc1cso9089995ad.1; 
 Mon, 03 Jul 2023 20:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688441686; x=1691033686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d4hybVCX0OeK0QstPXvMpIqBFqBkok82Ipoq0R1xsO8=;
 b=SsYFuYZDy5rNK8kyTX9O6TscQZWHne1yMaxCRTucBhdgp26xSB+cn+s9TbsnpXPgaM
 Yb7/VTP7oE1r7I+MFvQVsTw+LLSkBOzZQlBoeUpkTPQUSoAUme5fW1Bag0n1zXsxd1K+
 KOPYDS4RXEbuxDzxynq1j4Jjc2fd3NrmhDR/m8qsq+B+LmNb0AMT90hZg4/RIw44olVk
 kC0rG5vLX5PTjN8KyfQ59kxgATN3bjoVr61BqQanI6QFMMgJS9/ueZLzXeaXKF8m9oqf
 8/bUb/DfYDPyLjhgZSahawVdrXqDUAAkYGBspJdhzi8mgZiUInyzCCebL+S9D9P4//qd
 m1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688441686; x=1691033686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d4hybVCX0OeK0QstPXvMpIqBFqBkok82Ipoq0R1xsO8=;
 b=VbLwizdeSTOFlcHZp91Hp+gm46lKIengfg2hVVzUjAnCg3vRFHlTX3M0wBYJyFGv+l
 fIQu3xIg8T7rCiMTcLOmCU3bdd5XLQtlWLPG4T4t2N4Vrk4ZUyZ0kqjRLL4fMzYf0wxF
 BpHKEWgNFTFOE6undBHsgFUxPPQ3PmdfUuy7YIW55aN5PWgaYvSaiUG+1VPaXvSAltB0
 memikpoF2ekrp6E0dXv7WO8SkFRo9P8zpUunbjFEv3HlLA4q2ez+rGWZDbsk6JryKTZf
 hsCJF+4UNLD2Sg0bdFmEa53T+Yh+pm8NywdnEBZ2Y+pAaEB9X1vgL9nM/3rFd800U//9
 ezFQ==
X-Gm-Message-State: AC+VfDwdbZiSRNJ6rOj/KIupUvO4r64NNTvhzbgvO/0OFtNpHdoj3YRB
 QdBFQBg4JPaPavrN9j1vSD8=
X-Google-Smtp-Source: ACHHUZ6Av3yZrd2mhIJ5ZfB21+j+pRFKdNlRx4USdtsJKf+bURpHPfR0A0jr7R0hCU5bXO6leoRpHw==
X-Received: by 2002:a17:902:e84e:b0:1b7:de50:7d9c with SMTP id
 t14-20020a170902e84e00b001b7de507d9cmr27482692plg.15.1688441685551; 
 Mon, 03 Jul 2023 20:34:45 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 i7-20020a170902c94700b001b8707b70d1sm6338993pla.214.2023.07.03.20.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 20:34:45 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org, yin31149@gmail.com,
 18801353760@163.com
Subject: [PATCH v3 2/3] vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in
 _load_mq()
Date: Tue,  4 Jul 2023 11:34:34 +0800
Message-Id: <ec515ebb0b4f56368751b9e318e245a5d994fa72.1688438055.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688438055.git.yin31149@gmail.com>
References: <cover.1688438055.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

According to VirtIO standard, "The class, command and
command-specific-data are set by the driver,
and the device sets the ack byte.
There is little it can do except issue a diagnostic
if ack is not VIRTIO_NET_OK."

Therefore, QEMU should stop sending the queued SVQ commands and
cancel the device startup if the device's ack is not VIRTIO_NET_OK.

Yet the problem is that, vhost_vdpa_net_load_mq() returns 1 based on
`*s->status != VIRTIO_NET_OK` when the device's ack is VIRTIO_NET_ERR.
As a result, net->nc->info->load() also returns 1, this makes
vhost_net_start_one() incorrectly assume the device state is
successfully loaded by vhost_vdpa_net_load() and return 0, instead of
goto `fail` label to cancel the device startup, as vhost_net_start_one()
only cancels the device startup when net->nc->info->load() returns a
negative value.

This patch fixes this problem by returning -EIO when the device's
ack is not VIRTIO_NET_OK.

Fixes: f64c7cda69 ("vdpa: Add vhost_vdpa_net_load_mq")
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
---
v3:
 - split the fixes suggested by Eugenio
 - return -EIO suggested by Michael

v2: https://lore.kernel.org/all/69010e9ebb5e3729aef595ed92840f43e48e53e5.1687875592.git.yin31149@gmail.com/
 - fix the same bug in vhost_vdpa_net_load_offloads()

v1: https://lore.kernel.org/all/07a1133d6c989394b342e35d8202257771e76769.1686746406.git.yin31149@gmail.com/

 net/vhost-vdpa.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index ee273c40ca..03d87e85c8 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -671,8 +671,11 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
     if (unlikely(dev_written < 0)) {
         return dev_written;
     }
+    if (*s->status != VIRTIO_NET_OK) {
+        return -EIO;
+    }
 
-    return *s->status != VIRTIO_NET_OK;
+    return 0;
 }
 
 static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
-- 
2.25.1


