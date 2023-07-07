Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6C674B536
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 18:46:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHoZk-0008Iy-KQ; Fri, 07 Jul 2023 12:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qHoZi-0008Il-MN; Fri, 07 Jul 2023 12:44:54 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qHoZf-0000rU-1y; Fri, 07 Jul 2023 12:44:54 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1b852785a65so14794895ad.0; 
 Fri, 07 Jul 2023 09:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688748289; x=1691340289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=05JQK1z/GncChjgC3vGRphwJwPvCnhJ2bpd/VwqOm9U=;
 b=fMdVPGfBBuJEfSVoiNK0ap4tE0IairZuFW1BIDqPEbqnP/9u7MwGjeKATjXOxEV1N/
 f4G/qyUdkOZqnTbKiPe0M82qdHK99JGcjvOx+WmRx+0FJNKXAcviZi6/ijkvF0PYsLQP
 hZ6XKG5XKPnOYcRt9ejfkJBV5BWIC3AasU1WT0ZcO/kePTMJr459O/AJ8VueR9MhEHe1
 sc28ACIgP2PgmmLyA41xsr6hnLlE1+LhS9pew5ePNp2VnNcr0VWDlKj88ylIvkfbifEs
 Z72O6qB/GpmjwFjAGJoOaYhH3krnUEJGhqLHQ9BfuD6C0v1Qk4N0Phx6be3fJkZb17Am
 WnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688748289; x=1691340289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=05JQK1z/GncChjgC3vGRphwJwPvCnhJ2bpd/VwqOm9U=;
 b=Ftqiz9BS3kaveEji4dtIVvWRSrYqJ5cep9Xk0R9vOazHvwjRjjLm2D8SY5eijdJbJo
 6Ieizh8iBFxQSFT9s+6leQtxGnS3P6wYMY7RgRpXOtzXgBk37zByuJIXDcazIKUIpXHB
 dIurUkjSrvDsIIa2HSA3pXtMeFN3RoFoC8XM75SSV69mtUUKy4zAyFQ0QMBW64Lb18C+
 2M5qmcthDUk0KfLs96ffGEpeyie5lt1kN2HyC2KGZ+s9G/yI9Nv+sdIFIP1s0uzxCIAf
 IcADoD3O17ieKGC9JJ7ApIL34EsDzsRyVrDiJ1bWVYbhEHGXG94WTw9FDFRVfyNfQCc6
 b0Qg==
X-Gm-Message-State: ABy/qLYHT3AtjiHEXxVcV/REVTXcvPnj6bES+nKDrim0a0y0/WA8iTMc
 sd01Trv0/iV1d9loT+AMiZQ=
X-Google-Smtp-Source: APBJJlG+xRG0FU1ZP2fTMjulA0AUgzBzfaSdpS5EGAZs9Gmo96hjgHJHgreOzDnfAuz38rSiphVD/Q==
X-Received: by 2002:a17:902:d4ca:b0:1b8:936f:c346 with SMTP id
 o10-20020a170902d4ca00b001b8936fc346mr13687103plg.30.1688748289015; 
 Fri, 07 Jul 2023 09:44:49 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 h8-20020a170902704800b001b8896cd57bsm3470175plt.269.2023.07.07.09.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 09:44:48 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org, yin31149@gmail.com,
 18801353760@163.com
Subject: [PATCH 1/1] vdpa: Fix possible use-after-free for VirtQueueElement
Date: Sat,  8 Jul 2023 00:44:42 +0800
Message-Id: <e3f2d7db477734afe5c6a5ab3fa8b8317514ea34.1688746840.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688746840.git.yin31149@gmail.com>
References: <cover.1688746840.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x632.google.com
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

QEMU uses vhost_handle_guest_kick() to forward guest's available
buffers to the vdpa device in SVQ avail ring.

In vhost_handle_guest_kick(), a `g_autofree` `elem` is used to
iterate through the available VirtQueueElements. This `elem` is
then passed to `svq->ops->avail_handler`, specifically to the
vhost_vdpa_net_handle_ctrl_avail(). If this handler fails to
process the CVQ command, vhost_handle_guest_kick() regains
ownership of the `elem`, and either frees it or requeues it.

Yet the problem is that, vhost_vdpa_net_handle_ctrl_avail()
mistakenly frees the `elem`, even if it fails to forward the
CVQ command to vdpa device. This can result in a use-after-free
for the `elem` in vhost_handle_guest_kick().

This patch solves this problem by refactoring
vhost_vdpa_net_handle_ctrl_avail() to only freeing the `elem` if
it owns it.

Fixes: bd907ae4b0 ("vdpa: manual forward CVQ buffers")
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 net/vhost-vdpa.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 373609216f..d8f37694ac 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -825,7 +825,16 @@ out:
         error_report("Bad device CVQ written length");
     }
     vhost_svq_push_elem(svq, elem, MIN(in_len, sizeof(status)));
-    g_free(elem);
+    /*
+     * `elem` belongs to vhost_vdpa_net_handle_ctrl_avail() only when
+     * the function successfully forwards the CVQ command, indicated
+     * by a non-negative value of `dev_written`. Otherwise, it still
+     * belongs to SVQ.
+     * This function should only free the `elem` when it owns.
+     */
+    if (dev_written >= 0) {
+        g_free(elem);
+    }
     return dev_written < 0 ? dev_written : 0;
 }
 
-- 
2.25.1


