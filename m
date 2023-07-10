Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD4D74E1B7
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:03:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzuE-0003Ih-Lr; Mon, 10 Jul 2023 19:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzuC-0003EJ-Hb
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:02:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzu8-00048V-Ix
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nb6A6Tfn52akOK7CEow1SEE448JU/iA9KQYIu4Ch9Y4=;
 b=IlKY+9kch5Ux6lhyll47OOI2JvWg4651qomYnqOkltdr7w4+9eHjOgHOjaxgbCoreRaBe6
 xvtyweI8pGlkvdjcP0IlyXMnesxJyhzitPvIp3DtTd9Dq38ZlUWzVrFLEeT/llz86sYEep
 4Q8rQHoXnlcq0Vlgqnl1JUYyvN/WxMA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-mKfRZHl3PSGtLqM12i8iEw-1; Mon, 10 Jul 2023 19:02:50 -0400
X-MC-Unique: mKfRZHl3PSGtLqM12i8iEw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-315926005c9so1351001f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030168; x=1691622168;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nb6A6Tfn52akOK7CEow1SEE448JU/iA9KQYIu4Ch9Y4=;
 b=Ezpqlqtho6ZIatS/QaeGS3PNwoqei98IjGjtOGwoxgRYuGGA+uVmXkzqNjhgt4QD/D
 npuHrwSHPEYFS8KJnH66sb2DmANiKecROinE1EKYT8AUPBU+onAXNUiGmS7auTsbz/l8
 dNsxLxJcQswZezftYPWQytoFWNO8SSZwZTXLROq6vFhkcyo9lvt+eOdfPW15lgHvC1ri
 lDndZhG/YXCYwk2SQMmb+93Q05T+bajN7C4uMbdMhly8vOtdiN8xnWO6sxgypDiPCg9i
 7m1Ei+9C84MQwO3bbDHUClcIY+cDZBwdrjDepdaupq/Jiya951lENDvCx+DGKE/uYJOK
 6k/g==
X-Gm-Message-State: ABy/qLZEicfQYdlVbKXad+Jxrg3z1fuMHe/59XOqR++9Dme4C45508gx
 /UPJZQ7rAOloLHUoW2zKWCuTmNOkm88qh2LN/EGm2FNP79f04nYpBGuqMMtPfbekjOAZZBNjwf7
 o4Y/PxctoGNSIsKnsclsL3eEpBHFlYSEk8ZEpW5SInScJsEtLDpueMTV2wvplZH1IKqNN
X-Received: by 2002:a05:6000:1106:b0:315:a1f9:8667 with SMTP id
 z6-20020a056000110600b00315a1f98667mr1629369wrw.23.1689030168535; 
 Mon, 10 Jul 2023 16:02:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF69jdgfhfU9drK42HR4CwHmai1MM71ZceVhNsAGcuYmn+cPRuLH9q21+DXyp3VagyFNdpUbw==
X-Received: by 2002:a05:6000:1106:b0:315:a1f9:8667 with SMTP id
 z6-20020a056000110600b00315a1f98667mr1629353wrw.23.1689030168239; 
 Mon, 10 Jul 2023 16:02:48 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 o7-20020a5d6707000000b002c70ce264bfsm576055wru.76.2023.07.10.16.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:02:47 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:02:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Erico Nunes <ernunes@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 07/66] vhost-user-gpu: implement get_edid frontend feature
Message-ID: <31f137e3d6c596883ecd572ff3c53eb03b0e87c7.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: Erico Nunes <ernunes@redhat.com>

Implement the frontend side of the get_edid feature in the qemu
vhost-user-gpu frontend device.

Signed-off-by: Erico Nunes <ernunes@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230626164708.1163239-5-ernunes@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/display/vhost-user-gpu.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 15f9d99d09..543ea92721 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -31,6 +31,7 @@ typedef enum VhostUserGpuRequest {
     VHOST_USER_GPU_UPDATE,
     VHOST_USER_GPU_DMABUF_SCANOUT,
     VHOST_USER_GPU_DMABUF_UPDATE,
+    VHOST_USER_GPU_GET_EDID,
 } VhostUserGpuRequest;
 
 typedef struct VhostUserGpuDisplayInfoReply {
@@ -78,6 +79,10 @@ typedef struct VhostUserGpuDMABUFScanout {
     int fd_drm_fourcc;
 } QEMU_PACKED VhostUserGpuDMABUFScanout;
 
+typedef struct VhostUserGpuEdidRequest {
+    uint32_t scanout_id;
+} QEMU_PACKED VhostUserGpuEdidRequest;
+
 typedef struct VhostUserGpuMsg {
     uint32_t request; /* VhostUserGpuRequest */
     uint32_t flags;
@@ -88,6 +93,8 @@ typedef struct VhostUserGpuMsg {
         VhostUserGpuScanout scanout;
         VhostUserGpuUpdate update;
         VhostUserGpuDMABUFScanout dmabuf_scanout;
+        VhostUserGpuEdidRequest edid_req;
+        struct virtio_gpu_resp_edid resp_edid;
         struct virtio_gpu_resp_display_info display_info;
         uint64_t u64;
     } payload;
@@ -99,6 +106,8 @@ static VhostUserGpuMsg m __attribute__ ((unused));
 
 #define VHOST_USER_GPU_MSG_FLAG_REPLY 0x4
 
+#define VHOST_USER_GPU_PROTOCOL_F_EDID 0
+
 static void vhost_user_gpu_update_blocked(VhostUserGPU *g, bool blocked);
 
 static void
@@ -161,6 +170,9 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
             .request = msg->request,
             .flags = VHOST_USER_GPU_MSG_FLAG_REPLY,
             .size = sizeof(uint64_t),
+            .payload = {
+                .u64 = (1 << VHOST_USER_GPU_PROTOCOL_F_EDID)
+            }
         };
 
         vhost_user_gpu_send_msg(g, &reply);
@@ -184,6 +196,26 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
         vhost_user_gpu_send_msg(g, &reply);
         break;
     }
+    case VHOST_USER_GPU_GET_EDID: {
+        VhostUserGpuEdidRequest *m = &msg->payload.edid_req;
+        struct virtio_gpu_resp_edid resp = { {} };
+        VhostUserGpuMsg reply = {
+            .request = msg->request,
+            .flags = VHOST_USER_GPU_MSG_FLAG_REPLY,
+            .size = sizeof(reply.payload.resp_edid),
+        };
+
+        if (m->scanout_id >= g->parent_obj.conf.max_outputs) {
+            error_report("invalid scanout: %d", m->scanout_id);
+            break;
+        }
+
+        resp.hdr.type = VIRTIO_GPU_RESP_OK_EDID;
+        virtio_gpu_base_generate_edid(VIRTIO_GPU_BASE(g), m->scanout_id, &resp);
+        memcpy(&reply.payload.resp_edid, &resp, sizeof(resp));
+        vhost_user_gpu_send_msg(g, &reply);
+        break;
+    }
     case VHOST_USER_GPU_SCANOUT: {
         VhostUserGpuScanout *m = &msg->payload.scanout;
 
-- 
MST


