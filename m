Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 207E37ADA00
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 16:24:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkmV3-0000zA-Jn; Mon, 25 Sep 2023 10:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qkmV1-0000ym-Fg
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:23:47 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qkmV0-0003Yq-0X
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:23:47 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6bd04558784so4243077a34.3
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 07:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695651825; x=1696256625; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Oc9i2IHNPTyelsfivsQcNaK/emdo37fE9GlFdslZFxM=;
 b=benyyscUlwfGC5qs5hsYwerMn7u9+/YHyZCon3RxBhIEUrKEdTq6UrV4b60Ndf12hx
 2L0phNnGGLz5EiSaa3UPVEcxke8eNFkHUiLF88wSCK+Rp0p3PUswFFENQeYJomisDYxt
 5kPidzRyE9CRGXkjdU6cVaKYiKjg+4u+qqUr1yQKtqYMspRi1LdtL6BdRXPiAK8pw4R/
 a5yp+LdT7pgqnxs/PqZIfNSLZUu+K9CmfF9QJOUPtLPsus6FrgoLY2Y32YQ4y6PAPhrL
 OvjbpLJF9by3FaYbnZBpFHKaZkToX6L7qOEq8HtT1ODBIaT085uMjxNbBVGm+P+2GQ6W
 R5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695651825; x=1696256625;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Oc9i2IHNPTyelsfivsQcNaK/emdo37fE9GlFdslZFxM=;
 b=d6+42TmwATnCfDCVhjp+nZSCZ13k3Wai3Jac+r1H2UE2efkqtPyHYYDaPGhaYVRo9/
 K2/GmsY3o2A/7MG1wGj/1JQDeoawFQPeJEG+6/wq4ppoRyD607RBY6Pd3oREqJqVsL8x
 idrFY3jW6x78K7KGpN8FtDAlsF+iTxtKcdgrg1rhOVC4Rxg+BedM0KPo0zkdGTmGGOIq
 /n9WVN4Y57tLZdpPpUaWKi+RX+nfQWps7SQGnPHOvtCgpCe2GRiM/yGoaivEwLvQEMOg
 /bRHXHAmbJX/9++PNhXZlvmiquCyOzmEoCS6VTY2o0v6PAhcU7jNQ7JlJWTXcav5qVbh
 Mk/Q==
X-Gm-Message-State: AOJu0YynLh0GbBiq8ZpPafmNuie3SrR9LsgrSyy1ydE7Qf4ZbhkjOhrY
 PNQRcp4vpFSfo2lYZGTyuheOt7w0jS//3sOj06I=
X-Google-Smtp-Source: AGHT+IEWDH0h6XX1l4p5mU6qhmqzO6makgFAdR20xi/NXcme+hE5e9dAW1orFiF6C2D05IpXDgreYrcruijK4rJjXoI=
X-Received: by 2002:a05:6830:1da8:b0:6c0:9e24:6eab with SMTP id
 z8-20020a0568301da800b006c09e246eabmr7870546oti.33.1695651824803; Mon, 25 Sep
 2023 07:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230825170448.1953409-1-i.maximets@ovn.org>
In-Reply-To: <20230825170448.1953409-1-i.maximets@ovn.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 25 Sep 2023 10:23:33 -0400
Message-ID: <CAJSP0QW1Ck2+XG3c9cJM5+K05ypckXjEnxrJkGwx+PVt6m_3Lg@mail.gmail.com>
Subject: Re: [PATCH] virtio: use shadow_avail_idx while checking number of
 heads
To: Ilya Maximets <i.maximets@ovn.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, 25 Aug 2023 at 13:04, Ilya Maximets <i.maximets@ovn.org> wrote:
>
> We do not need the most up to date number of heads, we only want to
> know if there is at least one.
>
> Use shadow variable as long as it is not equal to the last available
> index checked.  This avoids expensive qatomic dereference of the
> RCU-protected memory region cache as well as the memory access itself
> and the subsequent memory barrier.
>
> The change improves performance of the af-xdp network backend by 2-3%.
>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
>  hw/virtio/virtio.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 309038fd46..04bf7cc977 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -999,7 +999,15 @@ void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
>  /* Called within rcu_read_lock().  */
>  static int virtqueue_num_heads(VirtQueue *vq, unsigned int idx)
>  {
> -    uint16_t num_heads = vring_avail_idx(vq) - idx;
> +    uint16_t num_heads;
> +
> +    if (vq->shadow_avail_idx != idx) {
> +        num_heads = vq->shadow_avail_idx - idx;
> +
> +        return num_heads;

This still needs to check num_heads > vq->vring.num and return -EINVAL
as is done below.

> +    }
> +
> +    num_heads = vring_avail_idx(vq) - idx;
>
>      /* Check it isn't doing very strange things with descriptor numbers. */
>      if (num_heads > vq->vring.num) {
> --
> 2.40.1
>
>

