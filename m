Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5279D74D9FE
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 17:37:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIsvi-0005we-LM; Mon, 10 Jul 2023 11:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIsvW-0005ph-KC
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:35:50 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIsvG-0004ls-48
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:35:50 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fba8e2aa52so52003305e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 08:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689003331; x=1691595331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ydjjuLF1zit1BjbAeuBjGkyFl+6yYLQdGkw5bViFdwU=;
 b=fD0hnaXh2COPn2kr6AnQqYWkXVUFSuh5n6nxeoNsaXYX+hOoU9LitbfcgVIhd20Fpr
 hGcMAFPRVTanGVKk0H/qTyoF2t2PoJDd2XGF1g4+sAh6JuHwerlgUUBbE1SrdJ8WbQs2
 uzZ2vQnEGqunCqdU6kB+hO4BX7jO/yrAqYVjocx7f4/qe8IntB6u961WWPyV04yeYxQn
 zxfVbMy7pe98kS0khKQG+To8Rmgh1TgTEIL9/3AttAR6SbvHRRNRgpooYEeYBNu7IF8P
 i5qlFhZn5koF2m+YDecMsuQgQS08KDFc9By0nJ1A7dIOKA5uqEfXjRBrN2pwH5ohFyqv
 ehAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689003331; x=1691595331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ydjjuLF1zit1BjbAeuBjGkyFl+6yYLQdGkw5bViFdwU=;
 b=CllGdhFsUcxdUoVp4KzA2rR7VrpaRx6DwcoHep15hAKf8fZDPV/Gdb6P+EaYotjAvx
 4+QKRoU392wvDZrpz4/lwR3LN7ssR9TsaX3/SbCkZhQtJFOvMX/y4ZDKO4GdW9q/2tKO
 MAadHuBRDDgskwW8GD3CiLiuDs8OfFbdkab9ntSB5lq5IwFGHRcqkDl+xL6AhlXH+nca
 EO5kERQPLiy737VjChPVbVFTXPY5c0odPuI38alI4SA5Bvw+OTlp4zTEDqt+DeupHYEA
 vzlrWqEzjI/U7p52IG2h/j++dquRE+YCNsTKfo127+rsKgfTJb4jIK76rxMYlzQsw0tv
 KLYQ==
X-Gm-Message-State: ABy/qLYPyUWFXHnFXHPTQwFeGpk6UFcEeh4RV4ms61F3MBU89/2W1maw
 GLqqeKToclb0IaniiMrvnbQmIQ==
X-Google-Smtp-Source: APBJJlHDjZk4jwjhWljPy6AHuzg+kadCeitY5eh0UO7BAIl247+10TCcMIHYu2RusrxRmen3cgGmqw==
X-Received: by 2002:adf:ebc6:0:b0:313:f54a:a842 with SMTP id
 v6-20020adfebc6000000b00313f54aa842mr11805915wrn.63.1689003330902; 
 Mon, 10 Jul 2023 08:35:30 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z8-20020adfdf88000000b003143bb5ecd5sm12010850wrl.69.2023.07.10.08.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 08:35:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D78C41FFC1;
 Mon, 10 Jul 2023 16:35:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Erik Schilling <erik.schilling@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 06/20] include/hw/virtio: document some more usage of
 notifiers
Date: Mon, 10 Jul 2023 16:35:08 +0100
Message-Id: <20230710153522.3469097-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230710153522.3469097-1-alex.bennee@linaro.org>
References: <20230710153522.3469097-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Lets document some more of the core VirtIODevice structure.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/virtio/virtio.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 631490bda4..c8f72850bc 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -150,10 +150,18 @@ struct VirtIODevice
     VMChangeStateEntry *vmstate;
     char *bus_name;
     uint8_t device_endian;
+    /**
+     * @user_guest_notifier_mask: gate usage of ->guest_notifier_mask() callback.
+     * This is used to suppress the masking of guest updates for
+     * vhost-user devices which are asynchronous by design.
+     */
     bool use_guest_notifier_mask;
     AddressSpace *dma_as;
     QLIST_HEAD(, VirtQueue) *vector_queues;
     QTAILQ_ENTRY(VirtIODevice) next;
+    /**
+     * @config_notifier: the event notifier that handles config events
+     */
     EventNotifier config_notifier;
     bool device_iotlb_enabled;
 };
-- 
2.39.2


