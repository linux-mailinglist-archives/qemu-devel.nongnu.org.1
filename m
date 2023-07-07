Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D585274B450
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 17:29:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHnNF-0000Zw-W6; Fri, 07 Jul 2023 11:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qHnND-0000ZA-5V
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:27:55 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qHnNB-000772-PC
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:27:54 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-668704a5b5bso1614685b3a.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 08:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688743672; x=1691335672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nFa9rQT44WA30NH3vvqWrQuzSfmrrJsKVNx4k6zk1B0=;
 b=HFPzCIEV1IRcQYk8BCB9HzTcMvsFtRkTrXo1yNQ/vs9+Y3wlfUO1zKsvMkqQHnISMP
 AZCHux9PiRJ6pqEefJ83P2jLbk0fy+fEgcbf3OaIIbEhu2kzVaW0/ULGo90Qk/TDZugb
 g/JrwLxiYxqUN31ExWZ8jfRZw5pNefgmcnnGUkPxQiIW/4jLe7GXNqB2d6w4ju9HL6nU
 ERHYnXCqrnwBq3iwMkTZIEGerKA6mzr50gODAt+qie8k/JcVUIBxbNhZx0Suh94fC6+R
 eIbtWzRpcUipIlvH1B91yw3lflHKMq08puY+sSBYNMtOLoy7Jp5/kcEEBTalGJoiXGLM
 keWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688743672; x=1691335672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nFa9rQT44WA30NH3vvqWrQuzSfmrrJsKVNx4k6zk1B0=;
 b=WJqEcBqCLZZ4fZNRVqFNFeyf3iw2u7f/is+f//hylnqtnjA9bCpifl/QaoqxcJjtCn
 eVmG6Y7A07PZAjGztF8nOjPzOqkU5BtLaxVL2DvtvkDxuwm8zYs1huCY3MoarrOwloqF
 i7M8DgWMkfHc8rOnEJO3clvd/OD59gTaCF0Yl44vUbLEZlrJVQl5FCWCbwbbupXSCKHa
 6V0EI89foxAeN/a9MsD9vNX11RCS9/x8PBZavV4ejelvpfdhs7fKx4k6PQ0c8VtQNroC
 umdrBkUGRsezid0TIm+5STQeJ8AXrF6+EWV0ofn0RE3RBYjfOdZrdg4HvSSA1LJsA/d2
 S/Ag==
X-Gm-Message-State: ABy/qLaduRD+h+wfzKpgSOp6cHGkszS5+zpM9wQgnTl3RvxAhCOLm0Xe
 Q5KEISup71zxWKbOlbNKPfU=
X-Google-Smtp-Source: APBJJlG4HTcxe9VIaFAZjNNacVaoI/sGL7/scjF8pG3PEf0o3UgjFkDn7xqqr750iu9BUOzcIWSkxQ==
X-Received: by 2002:a05:6a00:2d84:b0:677:cda3:2222 with SMTP id
 fb4-20020a056a002d8400b00677cda32222mr6007781pfb.14.1688743672290; 
 Fri, 07 Jul 2023 08:27:52 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 fm15-20020a056a002f8f00b00666b6dc10desm3040525pfb.56.2023.07.07.08.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 08:27:52 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 5/7] vdpa: Accessing CVQ header through its structure
Date: Fri,  7 Jul 2023 23:27:32 +0800
Message-Id: <cd522e06a4371e9d6b8a1c1a86f90a92401d56e8.1688743107.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688743107.git.yin31149@gmail.com>
References: <cover.1688743107.git.yin31149@gmail.com>
MIME-Version: 1.0
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

We can access the CVQ header through `struct virtio_net_ctrl_hdr`,
instead of accessing it through a `uint8_t` pointer,
which improves the code's readability and maintainability.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 net/vhost-vdpa.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index e80d4b4ef3..a84eb088a0 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -928,6 +928,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
 {
     VhostVDPAState *s = opaque;
     size_t in_len;
+    const struct virtio_net_ctrl_hdr *ctrl;
     virtio_net_ctrl_ack status = VIRTIO_NET_ERR;
     /* Out buffer sent to both the vdpa device and the device model */
     struct iovec out = {
@@ -943,7 +944,9 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
     out.iov_len = iov_to_buf(elem->out_sg, elem->out_num, 0,
                              s->cvq_cmd_out_buffer,
                              vhost_vdpa_net_cvq_cmd_len());
-    if (*(uint8_t *)s->cvq_cmd_out_buffer == VIRTIO_NET_CTRL_ANNOUNCE) {
+
+    ctrl = s->cvq_cmd_out_buffer;
+    if (ctrl->class == VIRTIO_NET_CTRL_ANNOUNCE) {
         /*
          * Guest announce capability is emulated by qemu, so don't forward to
          * the device.
-- 
2.25.1


