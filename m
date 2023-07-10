Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FD774E1DE
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:07:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzwf-0003aQ-I3; Mon, 10 Jul 2023 19:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwM-0002Vr-T1
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwI-0004Zn-E2
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=prlM+cemIKIm3D7j/eroL0Z9oyt7v5VUTSaZUNi0Drw=;
 b=b9H9wE5GLw7VqI6BoVuhOnVC+1C22/bqt7zfBrFq4Eg2o+bwiwOOkoJgOP0iCpMRx8nYY+
 StWbEB21lEcRvl7VNlUzcXxCU5rJ1wxYUxWsZ6UpT1h1pJcaiRinyn8aWbFENkA+ayJVVR
 YY+36Y7pzXRZYN2HK+VQXroTFGYpSbo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-vgrldHLJORiGWaWblacVQw-1; Mon, 10 Jul 2023 19:04:50 -0400
X-MC-Unique: vgrldHLJORiGWaWblacVQw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fa9a282fffso29962645e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030289; x=1691622289;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=prlM+cemIKIm3D7j/eroL0Z9oyt7v5VUTSaZUNi0Drw=;
 b=BirTxgP8bq+ChTFgWCRZyPsBRTg4TUvJdgowyRK34beD5KylBMbY7TuSHAAx/1dtB9
 m+QQwANmGYxaRLwBlS8okMjSU3Jaberx/QCvLW6lL7y/GihXf22sMiI2v1Ic6Knh1NGV
 zO2MItFlPGwIvOfuFHrcA2JtILwhy4wHBHL7iMIzERm0zJSX4CyAwCrP0JmE5GZX1ENc
 SgqFxIBhZTSAdZMlal/M1kKOfgtUga+HDsLvo/LIRZOrQdeIbSvjT5yA3/RN2dcSytWE
 ShOrB7IuLnioLP6HZpB/rwNBGBfg1hDRAMCTHcb0MHp5pxiAmDdEA/MehazEjRVHQgPU
 fA8A==
X-Gm-Message-State: ABy/qLZOB1uZC68KQfNNvFVGU/d+L0zwfKRA0a+Rxld5L/0LIkIZTq4X
 16r/+/TNHVpWOe5wavmUvAYG2swGSPJaGWYsIXeHUAbtfdd50NcHpaH2PGRsb6UNKT41cakteH9
 lpUzeyO0Oos6JJDZzM8tasUWSmvEQHloAtxaor9psSCe7Xxln5JJJZvdJ9oIHxjxsIm99
X-Received: by 2002:a1c:4b19:0:b0:3f8:f382:8e1f with SMTP id
 y25-20020a1c4b19000000b003f8f3828e1fmr11101428wma.24.1689030289070; 
 Mon, 10 Jul 2023 16:04:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE7pK4HwH9VcQUu7MupZ4/y7peVFwUDpvI5MeoZC7IYAiempWv1Ic9CAW53V0vg0+WzUTb5GA==
X-Received: by 2002:a1c:4b19:0:b0:3f8:f382:8e1f with SMTP id
 y25-20020a1c4b19000000b003f8f3828e1fmr11101412wma.24.1689030288837; 
 Mon, 10 Jul 2023 16:04:48 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 l4-20020a1ced04000000b003fbe561f6a3sm11449505wmh.37.2023.07.10.16.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:04:48 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:04:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 49/66] vdpa: Fix possible use-after-free for VirtQueueElement
Message-ID: <031b1abacbdb3f4e016b6b926f7e7876c05339bb.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Hawkins Jiawei <yin31149@gmail.com>

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
Message-Id: <e3f2d7db477734afe5c6a5ab3fa8b8317514ea34.1688746840.git.yin31149@gmail.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 679ef4bed0..5542b47a8f 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -831,7 +831,16 @@ out:
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
MST


