Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C15F7CC9B8
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 19:20:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsnj1-0004Hl-He; Tue, 17 Oct 2023 13:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qsniz-0004HQ-VM
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 13:19:21 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qsniy-00046F-7G
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 13:19:21 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40839652b97so1479135e9.3
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 10:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697563158; x=1698167958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nYJAR0AMsb/6+NQUw/ZXkNRr+jbwIu4tVYQkOMbEmaw=;
 b=CpaZoUyyyA7+beCn8Oj7O2A3dDPfW0t8m37X/852Js2YpeQmhQ+NfdWXyy2wjua9Y9
 8UVZItElU+F9eJ5uao4h94uEGe6uXYPVCz9ar7wwFZCJKNNN0e5kwqk0aDcFSTnsfQFQ
 5B0DAoUehVTpIzzFj4QiFhf0/pwIUMqSXG+KhnteEkej/jD9qro/H7Ev02yhqplA9q3b
 AOGQhdHQVRz0tlCRdlMmfjvceRR7xtaEsjIMnRguMZy4L9wjhSuWud/efxb6UURs/ToN
 B9QHDE4TBm4fW9emYy80WXho/ej3/AF4QpXpwtzY1YGLOaeOCcZKK5LyZsjszKHO7cGb
 PCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697563158; x=1698167958;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nYJAR0AMsb/6+NQUw/ZXkNRr+jbwIu4tVYQkOMbEmaw=;
 b=d84S5ggmfPD4zXLa9QZ3oTkn+y3kfAROxP1QuJ6snAV0NHOBM2kGz1NtwVnZCWKU39
 Utv8+IopwhIbhkvaB7PH/xklMQ3X6UAL1ZjJJsl8HOuzSgNmJbopA/HaSzfKWQRUN9+T
 Njd2DeJDZFGRfHNvnW6Qv5tG4r6AIA+xAqAYfDWUN53LFGCPMvtUN0Mbc9SR9DwCAhZM
 QvpV9HdMxDFbUqDgT8KNp/PZzLi5zdos2xhn49Hj5CsB2ndT+KRv4DYZrtKMft7Ee9on
 nmKiHRS9NbaGseQIua5XBuq3N3PxVsV/qRZGS87fc+4bbGkKI6wUgW8H518v4UwbWGpT
 7NJQ==
X-Gm-Message-State: AOJu0YxRxteh6WzveAuMkKZ+8pKAWkVNDA8luCGA5AyA55kzOLrA/9Un
 3PacVsCzzX9FaPH4cpkeftcHmg==
X-Google-Smtp-Source: AGHT+IHJsYqstZwNH/iRkFO0R0iLtofkF8eG3srtw0EUzy3LmqHmC0sKSpbWYidfqgfCecJwNSEoNw==
X-Received: by 2002:a5d:6ac5:0:b0:32d:9a2b:4f83 with SMTP id
 u5-20020a5d6ac5000000b0032d9a2b4f83mr2644258wrw.33.1697563158158; 
 Tue, 17 Oct 2023 10:19:18 -0700 (PDT)
Received: from meli.delivery (adsl-165.37.6.1.tellas.gr. [37.6.1.165])
 by smtp.gmail.com with ESMTPSA id
 q18-20020a05600000d200b003233b554e6esm203897wrx.85.2023.10.17.10.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 10:19:17 -0700 (PDT)
Date: Tue, 17 Oct 2023 20:15:40 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-block@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Gerd Hoffmann <kraxel@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Subject: Re: [PATCH 2/7] hw/block/vhost-user-blk: Use DEVICE() /
 VIRTIO_DEVICE() macros
User-Agent: meli 0.8.2
References: <20231017140150.44995-1-philmd@linaro.org>
 <20231017140150.44995-3-philmd@linaro.org>
In-Reply-To: <20231017140150.44995-3-philmd@linaro.org>
Message-ID: <2oo43.ni0pj3wuvqqh@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 17 Oct 2023 17:01, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>Access QOM parent with the proper QOM [VIRTIO_]DEVICE() macros.
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---
> hw/block/vhost-user-blk.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>index eecf3f7a81..4b37e26120 100644
>--- a/hw/block/vhost-user-blk.c
>+++ b/hw/block/vhost-user-blk.c
>@@ -405,7 +405,7 @@ static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
> 
> static int vhost_user_blk_realize_connect(VHostUserBlk *s, Error **errp)
> {
>-    DeviceState *dev = &s->parent_obj.parent_obj;
>+    DeviceState *dev = DEVICE(s);
>     int ret;
> 
>     s->connected = false;
>@@ -423,7 +423,7 @@ static int vhost_user_blk_realize_connect(VHostUserBlk *s, Error **errp)
>     assert(s->connected);
> 
>     ret = vhost_dev_get_config(&s->dev, (uint8_t *)&s->blkcfg,
>-                               s->parent_obj.config_len, errp);
>+                               VIRTIO_DEVICE(s)->config_len, errp);
>     if (ret < 0) {
>         qemu_chr_fe_disconnect(&s->chardev);
>         vhost_dev_cleanup(&s->dev);
>-- 
>2.41.0
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

