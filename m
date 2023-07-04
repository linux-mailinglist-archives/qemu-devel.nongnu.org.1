Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F25CC7467F6
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 05:36:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGWoY-0001CH-3p; Mon, 03 Jul 2023 23:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qGWoW-0001Bn-56; Mon, 03 Jul 2023 23:34:52 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qGWoU-00033S-Hw; Mon, 03 Jul 2023 23:34:51 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-67ef5af0ce8so4214006b3a.2; 
 Mon, 03 Jul 2023 20:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688441689; x=1691033689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UieVTM0ijH4N8thbVTg381kGlKgp/GZSBGu7R4hXdyI=;
 b=exvGYXYX83DV3z8u4ykn6T+NpWAjfZrrWrKl0+Bbriprcpgm8Lux96Zncj+ugjSP7x
 XLqvvOT5NBVus1VrAqKZ9T+XfrKwljb2AeAIIWyta1+tJ0UmscF0Zy4mf1ubXBdXa4+Z
 9X3ImglMlS/FTH++hvw73/oa+vEy8gUf6qy8GwXSvztQsBYTbPn8Jh2Y6POlduDPotQ2
 wftC5LTMajWEi9iVNjrB2GXxIafVGFG74GYWsUO1x/vvGChivGCDcwgFtOk/aXqCAWdo
 MEgGgidCD8YFDTI/Y365WeTRH4bRbye1UNCVnqMKtHyTlG2Vb3DkosYvOGx/p1TM8IGJ
 jJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688441689; x=1691033689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UieVTM0ijH4N8thbVTg381kGlKgp/GZSBGu7R4hXdyI=;
 b=MOpahKSh/ce3RqZsSjaHQEJcLMBLNqjbdDLT79TweF4ubALyPt8JYDvia5tQBo8BJi
 xGXpD3ehcxMJLWtb5xQTYR3v5jIDmjh6h+656/vjibEv9tGDzs5OnQnw8oSZ/zxsvOva
 fczE9hHBnkydUWsmyjVUR+0p7I5oR9YoLLkZZwXWJzUEoArRQLDSh/JHKLCcpXTOTLur
 MP7U1prfGx7Bzy/6WCaUrxczCFvfjNpkJYfkRWvMq2yOQnqxqXSBxZQRymUfr3imirJN
 oYtInaPQI2E8+ZelwmtHdghI+h//mNpf6ZhHIOfq8lD03wIBM1ra+qijoHKqNYiEuXud
 ZwpA==
X-Gm-Message-State: ABy/qLasXU79p8osOzmxSqKbCKgB1Kr0MxYY8vvHx4LvLLsEQKWn5pmg
 QzARPcW/wWrXZvHo9Xrk598=
X-Google-Smtp-Source: APBJJlF7O1pgV0bcuOIx6l2q0/fnlQUXcnVaa3LwE37FxNpfPnL5xSELub30o/g1PpERldwxF6g/qw==
X-Received: by 2002:a05:6a00:148b:b0:682:4c9f:aa0 with SMTP id
 v11-20020a056a00148b00b006824c9f0aa0mr16194594pfu.29.1688441688516; 
 Mon, 03 Jul 2023 20:34:48 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 141-20020a630293000000b00514256c05c2sm15591861pgc.7.2023.07.03.20.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 20:34:48 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org, yin31149@gmail.com,
 18801353760@163.com
Subject: [PATCH v3 3/3] vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in
 _load_offloads()
Date: Tue,  4 Jul 2023 11:34:35 +0800
Message-Id: <b0396b80e96322b86f1a0b10c098fc1edd947d72.1688438055.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688438055.git.yin31149@gmail.com>
References: <cover.1688438055.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x435.google.com
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

Yet the problem is that, vhost_vdpa_net_load_offloads() returns 1 based on
`*s->status != VIRTIO_NET_OK` when the device's ack is VIRTIO_NET_ERR.
As a result, net->nc->info->load() also returns 1, this makes
vhost_net_start_one() incorrectly assume the device state is
successfully loaded by vhost_vdpa_net_load() and return 0, instead of
goto `fail` label to cancel the device startup, as vhost_net_start_one()
only cancels the device startup when net->nc->info->load() returns a
negative value.

This patch fixes this problem by returning -EIO when the device's
ack is not VIRTIO_NET_OK.

Fixes: 0b58d3686a ("vdpa: Add vhost_vdpa_net_load_offloads()")
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
index 03d87e85c8..36aa2d7f8c 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -712,8 +712,11 @@ static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
     if (unlikely(dev_written < 0)) {
         return dev_written;
     }
+    if (*s->status != VIRTIO_NET_OK) {
+        return -EIO;
+    }
 
-    return *s->status != VIRTIO_NET_OK;
+    return 0;
 }
 
 static int vhost_vdpa_net_load(NetClientState *nc)
-- 
2.25.1


