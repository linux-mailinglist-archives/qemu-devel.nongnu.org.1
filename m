Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC1A74E202
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:09:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzvh-0000Uh-Fs; Mon, 10 Jul 2023 19:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzvd-0008LW-GV
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:04:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzvb-0004Ud-Re
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=amZrO0aYgcy6UzcFRq/TV5jwcN2L/fT0tqTPTXjBW+0=;
 b=AAV+xptVfsaF9DrgdbnhBBN4HTq4gM0cA/63OI/eFLv2foZQFZHNhfSs2clyBYnvvFRG8R
 Teb9XrT1jrV1bo5yYKwDRxwYzJa5s1se/C5/Zx6sAUdLLi5uIrt9C62gZ+YYSupkySbARi
 t5Phr1F9y6JzGy+O+NhsBAz+61aA3oc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-6A4W91V0OziBGZtuthQe-A-1; Mon, 10 Jul 2023 19:04:22 -0400
X-MC-Unique: 6A4W91V0OziBGZtuthQe-A-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30793c16c78so3534871f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030260; x=1691622260;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=amZrO0aYgcy6UzcFRq/TV5jwcN2L/fT0tqTPTXjBW+0=;
 b=lWqr0rteKWe4GrO9sZ7rL13dwNBsQAsNBf/nyyPyJPC9lFgSEFY1wr9VXirUm6SkIC
 GgNVe+JfpjlmzzVS9fhHsDUyUhgSj5GpD2i0++4UHnD8sXaJ3VfaYmSHC1ICpGkpSgof
 m0vAetUiMq1P73nbRaNaRJRpE48k5D6Q2OiXfo1inbzMtvgJRBpERQjQl0E4WPWgRpgC
 b1hNqUF8R7fMkRD4yY6jRbIFMjfkT71vaj81LbtylPVgC8v9W1fHMaF8qQeCnuiJI/GR
 JerfLxWGIEkS2DzczV10wyBv8uWewkXIaL8osptS1yGcAn/gs+y93KSQtXtO0zGu5/sl
 Lgfg==
X-Gm-Message-State: ABy/qLYzbEj3pwNHaivBY3A/DMqu6xVhv6OxomcLEB7ggSIWZYrxv07S
 rG3gfBUi73ISVsiiVLBsqraGkSGbOD2IVRlJljgf6clbkIPXwKB+0oKA8dQsIvi4qjKfFULrw6W
 Eh6h1TuZly65NcFND5SgPYegyPCYtc3Zsm/YEtOHUFSiq8AkqrZe/buHrevxPDzNPXr8r
X-Received: by 2002:a1c:7404:0:b0:3fb:424b:ef6e with SMTP id
 p4-20020a1c7404000000b003fb424bef6emr15884721wmc.23.1689030260695; 
 Mon, 10 Jul 2023 16:04:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF04OsIwVl2dIzNSwADap5A3fr8nFshIz260IRu3+lgBklurChPRnaWnx/CBKGdUdUawokPlQ==
X-Received: by 2002:a1c:7404:0:b0:3fb:424b:ef6e with SMTP id
 p4-20020a1c7404000000b003fb424bef6emr15884707wmc.23.1689030260422; 
 Mon, 10 Jul 2023 16:04:20 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 j8-20020adfe508000000b0031424950a99sm574625wrm.81.2023.07.10.16.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:04:19 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:04:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>
Subject: [PULL 39/66] vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in
 _load_offloads()
Message-ID: <6f34807116ffef7c449a656dbe2091d4f4da89c8.1689030052.git.mst@redhat.com>
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

From: Hawkins Jiawei <yin31149@gmail.com>

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
Message-Id: <b0396b80e96322b86f1a0b10c098fc1edd947d72.1688438055.git.yin31149@gmail.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 8477ed2579..679ef4bed0 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -718,8 +718,11 @@ static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
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
MST


