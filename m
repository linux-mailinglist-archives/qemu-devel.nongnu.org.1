Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCF67ADB15
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 17:13:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qknGr-0005F4-Cr; Mon, 25 Sep 2023 11:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qknGn-0005AL-OD
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:13:10 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qknGl-0005b5-8b
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:13:09 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-57b9cb05fa3so1798400eaf.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 08:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695654786; x=1696259586; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i5NqAcemD3LhhWmNzHjw2v19CMD8L0TDJP8pGENDkSU=;
 b=OhqLFubuJ9NMlkh+ZB+YT4VejhK0lUGFV3AlxFUTmlaVmSEFHD8IfNY3k/g7wWMF40
 0Nieh2ro3GQeWsCJ3UPa2YRhTRACcrN6ZKICU0Bze125QPfkyGAmKzMjFurZB/xerNSJ
 YoZ5PEw9/53Kv9SLjrKBpiINHt37VhNxeKLeDJOZaguF+ctklTokMEkQ+q5Im9PGNcNx
 XzwGZ00jZnZCVBrg6As3tMlenjhsQp10kTQlc39MayxZQTrMRaxPHkHWJYd7Wq9mbBXd
 RW3QStDMSxWzPquKKECuUBqAFblCqMXFXT/jeA55foyuJVGkpty7vGyIPbTs0GCV4aFk
 GmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695654786; x=1696259586;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i5NqAcemD3LhhWmNzHjw2v19CMD8L0TDJP8pGENDkSU=;
 b=WCrtgQ7VkbkTp0YRkXSgrdD5KTh2ObjYcJyXLdCJTa2imeynKeqbhqR35jUnOZl+OS
 IJTiQ9H1JqSUF92Q7EW8j/HTEfxK1fxrB/2TPEgl3CKP7iwROAj255cg1USChkRoFYl+
 iduvS+5gK3eZZQwwcMiMmg8hNc4SXUIFjOUUVDUoRjhIZRAiiedfs9PdKdK7zI2eoi5z
 ZrXmOwYW0/BgIc9Ab++4KbJhyQj887vlpdwuCm8ZLSmMM9kUafsBNlwW0L5GNzosgczz
 axd0D+KmA7zqlMpyMFNuXZMSJ7PID/6Zaom1yUwwpGygSLEgxaWUsDlbo8f4x/gXap8I
 iPPw==
X-Gm-Message-State: AOJu0YzfbiQTXkupkpln4hwvn5QFek5d+xc7kKoYg1xderp7Mz6X/bQo
 g8OE6uzUEtVKF6bRaGPpDaTrU6ROLguy2jwffRI=
X-Google-Smtp-Source: AGHT+IGTF7AVumsgmX81PfO3I6TlxP2LZqodbBvkSV9Yn7od7++k2elghSVpwBzTBBtt5Sg5HBj3467VTc9N02dZHp8=
X-Received: by 2002:a4a:301b:0:b0:571:1c44:c9c0 with SMTP id
 q27-20020a4a301b000000b005711c44c9c0mr4722004oof.1.1695654785983; Mon, 25 Sep
 2023 08:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230825170448.1953409-1-i.maximets@ovn.org>
 <CAJSP0QW1Ck2+XG3c9cJM5+K05ypckXjEnxrJkGwx+PVt6m_3Lg@mail.gmail.com>
 <213042b9-5ccd-bbde-2be0-ff1d32b9c52e@ovn.org>
In-Reply-To: <213042b9-5ccd-bbde-2be0-ff1d32b9c52e@ovn.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 25 Sep 2023 11:12:53 -0400
Message-ID: <CAJSP0QVf_=LgSTMDL8uyjWtHmJyPQZ-Mt6aPGvHQbRH_v9ZREw@mail.gmail.com>
Subject: Re: [PATCH] virtio: use shadow_avail_idx while checking number of
 heads
To: Ilya Maximets <i.maximets@ovn.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc33.google.com
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

On Mon, 25 Sept 2023 at 11:02, Ilya Maximets <i.maximets@ovn.org> wrote:
>
> On 9/25/23 16:23, Stefan Hajnoczi wrote:
> > On Fri, 25 Aug 2023 at 13:04, Ilya Maximets <i.maximets@ovn.org> wrote:
> >>
> >> We do not need the most up to date number of heads, we only want to
> >> know if there is at least one.
> >>
> >> Use shadow variable as long as it is not equal to the last available
> >> index checked.  This avoids expensive qatomic dereference of the
> >> RCU-protected memory region cache as well as the memory access itself
> >> and the subsequent memory barrier.
> >>
> >> The change improves performance of the af-xdp network backend by 2-3%.
> >>
> >> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> >> ---
> >>  hw/virtio/virtio.c | 10 +++++++++-
> >>  1 file changed, 9 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >> index 309038fd46..04bf7cc977 100644
> >> --- a/hw/virtio/virtio.c
> >> +++ b/hw/virtio/virtio.c
> >> @@ -999,7 +999,15 @@ void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
> >>  /* Called within rcu_read_lock().  */
> >>  static int virtqueue_num_heads(VirtQueue *vq, unsigned int idx)
> >>  {
> >> -    uint16_t num_heads = vring_avail_idx(vq) - idx;
> >> +    uint16_t num_heads;
> >> +
> >> +    if (vq->shadow_avail_idx != idx) {
> >> +        num_heads = vq->shadow_avail_idx - idx;
> >> +
> >> +        return num_heads;
> >
> > This still needs to check num_heads > vq->vring.num and return -EINVAL
> > as is done below.
>
> Hmm, yeas, you're right.  If the value was incorrect initially, the shadow
> will be incorrect.  However, I think we should just not return here in this
> case and let vring_avail_idx() to grab an actual new value below.  Otherwise
> we may never break out of this error.
>
> Does that make sense?

No, because virtio_error() marks the device as broken. The device
requires a reset in order to function again. Fetching
vring_avail_idx() again won't help.

>
> >
> >> +    }
> >> +
> >> +    num_heads = vring_avail_idx(vq) - idx;
> >>
> >>      /* Check it isn't doing very strange things with descriptor numbers. */
> >>      if (num_heads > vq->vring.num) {
> >> --
> >> 2.40.1
> >>
> >>
>

