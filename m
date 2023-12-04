Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E23802CC2
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 09:09:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA40s-0000sQ-Tm; Mon, 04 Dec 2023 03:09:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rA40q-0000rx-Ux
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 03:09:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rA40p-0005pr-Fh
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 03:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701677346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IrUrm3fGmHFS5Zfcc2JM6IsmwZGZqDCt0B19P7J8MkQ=;
 b=KDA8UAVXTJUBdtD3z/0xJknGvYL7ZhVVcjdNsJ1tFdyOue2PisqVIKZSi8cATYYt+BIMCI
 GIaGWMc68Co6p15sD1W8EMAyWxpJwMAhyrVRHlnzDezjH/ANf+Ry3XR+ZolCJwNhFXMXqA
 aoDG65dlquMjZ7ZbgDbuxo5u4LyvLW8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-MOk4SLGuPxW9r-6fVet-Gw-1; Mon, 04 Dec 2023 03:09:05 -0500
X-MC-Unique: MOk4SLGuPxW9r-6fVet-Gw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2D52185A780;
 Mon,  4 Dec 2023 08:09:04 +0000 (UTC)
Received: from localhost (unknown [10.39.208.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 36D945028;
 Mon,  4 Dec 2023 08:09:03 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: [PULL 3/3] hw/audio/virtio-sound: mark the device as unmigratable
Date: Mon,  4 Dec 2023 12:08:50 +0400
Message-ID: <20231204080850.4068242-4-marcandre.lureau@redhat.com>
In-Reply-To: <20231204080850.4068242-1-marcandre.lureau@redhat.com>
References: <20231204080850.4068242-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Volker Rümelin <vr_qemu@t-online.de>

The virtio-sound device is currently not migratable. QEMU crashes
on the source machine at some point during the migration with a
segmentation fault.

Even with this bug fixed, the virtio-sound device doesn't migrate
the state of the audio streams. For example, running streams leave
the device on the destination machine in a broken condition.

Mark the device as unmigratable until these issues have been fixed.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20231204072837.6058-1-vr_qemu@t-online.de>
---
 hw/audio/virtio-snd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 2fe966e311..b10fad1228 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -68,6 +68,7 @@ static const VMStateDescription vmstate_virtio_snd_device = {
 
 static const VMStateDescription vmstate_virtio_snd = {
     .name = TYPE_VIRTIO_SND,
+    .unmigratable = 1,
     .minimum_version_id = VIRTIO_SOUND_VM_VERSION,
     .version_id = VIRTIO_SOUND_VM_VERSION,
     .fields = (VMStateField[]) {
-- 
2.43.0


