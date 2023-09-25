Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8A07ADA26
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 16:34:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkmdZ-0004Wt-Q7; Mon, 25 Sep 2023 10:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qkmdY-0004Wi-L7
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:32:36 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qkmdX-0005bO-70
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:32:36 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6bf04263dc8so4072726a34.3
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 07:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695652353; x=1696257153; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=43S7IKj0igqH/orQ13McS2muY51A7jlSHkMaZULbnJU=;
 b=RQGU23KzYARZhlOjRkoGpieiblZrgmzz06Z9XzltO3sqKb7WwV3mZfgswWysjsqMPt
 /P7oFMD6t3KDuoZAoe0F5Jzik1g0gWBADPFwh7i/VbQSOpHzB+O21gd/6ceTnG+H7FCi
 WZg9b4bmvfo6VIlOAitY8QNuHqH6THhGQjAbVYt3lkUWmYdjxNWFytaCA1yE58wEuROo
 ud/LocnmQrqmzwK1p5SVoq7RKaILMEBfgwlE5i2/hscuIVZ0fHda8rqhkySIdK3kkW2p
 w1uFgsIKfhDyxuVX2nZSjFunrlUjCTfurzOQh2QYlDe447JpUY7W0rANe4dnXP9LHgW/
 2GxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695652353; x=1696257153;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=43S7IKj0igqH/orQ13McS2muY51A7jlSHkMaZULbnJU=;
 b=uWGrFz9x6Ee0PLMOCUxfhQ/vtYgDSxvNOcRxRUZ2XGsvAuK5wWJX6o9SiUYUp7xrCi
 Yki9x3dyhagHN4ZhH5Ukgc1SiJZARJka7Vmysr1XFkDzXzsg+RpgWg1wnrODpzmoQzul
 uECDWOAjsIuBh1nmYv0HU4V+brJdmFK1bSTNnRVKlPJWktwqCecTegASm8YC1yfAkfdk
 7+8FdRjAYTrqbeZMuwNLgxZnuFbmdhav+hedILftos9aaZVsIGNmmmKKDwu2wcpPxrDl
 GxX8wUFwvV8s5ZM6EitQzRRxy9UuZzmjoaYxxJnpsIhGMbWLf59n7ZVs+OPM9wluocDd
 ksig==
X-Gm-Message-State: AOJu0YwMjWckPHFchTB+iAYq8Bc6a7Qbyu3vuRue5POGSTtAg2DOmzlI
 5eDeUABAFPNeoXxrTauy3YSq3yBsQojBKUxDTDw=
X-Google-Smtp-Source: AGHT+IHVF41QQbe0FFe6DiKJa3Ip/SLm7nL/c2XhEvNbZzUOFwlK/uhctywHU55gZfXYC2/1C6vEIvWVi3gFzjLe9v4=
X-Received: by 2002:a05:6830:115a:b0:6c4:cda6:ff31 with SMTP id
 x26-20020a056830115a00b006c4cda6ff31mr7832117otq.15.1695652353744; Mon, 25
 Sep 2023 07:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230825170136.1953236-1-i.maximets@ovn.org>
In-Reply-To: <20230825170136.1953236-1-i.maximets@ovn.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 25 Sep 2023 10:32:22 -0400
Message-ID: <CAJSP0QW2LZQgHFSp=ajokFpAzaLWhDXBL0tP8Lj-vXTaMKJcqQ@mail.gmail.com>
Subject: Re: [PATCH] virtio: remove unnecessary thread fence while reading
 next descriptor
To: Ilya Maximets <i.maximets@ovn.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x32d.google.com
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

On Fri, 25 Aug 2023 at 13:02, Ilya Maximets <i.maximets@ovn.org> wrote:
>
> It was supposed to be a compiler barrier and it was a compiler barrier
> initially called 'wmb' (??) when virtio core support was introduced.
> Later all the instances of 'wmb' were switched to smp_wmb to fix memory
> ordering issues on non-x86 platforms.  However, this one doesn't need
> to be an actual barrier.  It's enough for it to stay a compiler barrier
> as its only purpose is to ensure that the value is not read twice.
>
> There is no counterpart read barrier in the drivers, AFAICT.  And even
> if we needed an actual barrier, it shouldn't have been a write barrier.
>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
>  hw/virtio/virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 309038fd46..6eb8586858 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1051,7 +1051,7 @@ static int virtqueue_split_read_next_desc(VirtIODevice *vdev, VRingDesc *desc,
>      /* Check they're not leading us off end of descriptors. */
>      *next = desc->next;

I don't see a caller that uses *next. Can the argument be eliminated?

>      /* Make sure compiler knows to grab that: we don't want it changing! */
> -    smp_wmb();
> +    barrier();

What is the purpose of this barrier? desc is not guest memory and
nothing modifies desc's fields while this function is executing. I
think the barrier can be removed.

>
>      if (*next >= max) {
>          virtio_error(vdev, "Desc next is %u", *next);
> --
> 2.40.1
>
>

