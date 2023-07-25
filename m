Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A91C761C4B
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:55:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOJQd-0000T0-3k; Tue, 25 Jul 2023 10:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmaglion@redhat.com>)
 id 1qOJQb-0000Rf-Mg
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:54:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmaglion@redhat.com>)
 id 1qOJQa-0008Dj-78
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690296859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ls2uIMV6BbKhTKq3JAogp9Y2Or4jbt1ps4iSzNIeyY0=;
 b=bj+BuXasZb1dAIJgcj5hjgjUKS9JQiRlMOBClvctdKo8W1sMp9j4r5PMdILR0mBoT+a039
 Jfvpuk1GIUwBUy3zEWa1GTE1vl6F+i+7LIxDkKnnhg1T0UhliMaQyEajgI/tGP3I9egzSn
 cAwNa2mqR2aWWflhkrwzfOlKLVVx1lQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-kV54zvGDMPK5P3LlOjcmKw-1; Tue, 25 Jul 2023 10:54:18 -0400
X-MC-Unique: kV54zvGDMPK5P3LlOjcmKw-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-56997e97d08so6845187b3.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 07:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690296857; x=1690901657;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ls2uIMV6BbKhTKq3JAogp9Y2Or4jbt1ps4iSzNIeyY0=;
 b=g51YFfwhg/G9UCqLOzXFJ4g/kiJ/vwm9nfnRlfFvLzg8NDuxN5dDfWAzMD8STmlooL
 l8zIvI/FI50hQZNUTNlIqvth3G/tONTUDypDXnZJh3feJkCKV/FIqQbZBF/i9hmQDTZK
 GJYic39VI1N7fTjD//gO5uDg2uGvEruprYbKJAdyPhKAZXq4M4mjAj3K/WpAwkWAgyxa
 HxyOoOSxQh2sTjvW+VWbEouiMOIi4oKDnK+nr6LUJ4TnXsa5ULNyH44KqFbdBUQ/Hf+E
 If021FMfSZqAhdxfOE7Ijo/G2N0i5EvDHqsffu7t5l2ItLE2s3Ndl++bogTn38h+gOnE
 CT5g==
X-Gm-Message-State: ABy/qLZNSfKn6tsCRkBQpys3Q2X+jsfCVGw2MZx9QxVrB0BeH4UZS5Nf
 Gg6QpUtDKhp7L1i9SYvwigbzkaDg+U7s8iZtSBpeNcOoRvLmSR4FxLBNqtdcKtJ9pvq8/QbGVEF
 ngrm/8j4rt7G+wE+S6VC3qNT6MPC4Vgs=
X-Received: by 2002:a25:c50a:0:b0:d0b:9a92:a560 with SMTP id
 v10-20020a25c50a000000b00d0b9a92a560mr5050404ybe.6.1690296857542; 
 Tue, 25 Jul 2023 07:54:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGuCoCHRQh5A4e5DOUx63Q3llH4W5xDlXz4g8bRiMwv4HP+IPJ0dwBKac0U3a5eyFYwOdNVFHTOHXFn7rNFznI=
X-Received: by 2002:a25:c50a:0:b0:d0b:9a92:a560 with SMTP id
 v10-20020a25c50a000000b00d0b9a92a560mr5050370ybe.6.1690296856623; Tue, 25 Jul
 2023 07:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230721134945.26967-1-hreitz@redhat.com>
In-Reply-To: <20230721134945.26967-1-hreitz@redhat.com>
From: German Maglione <gmaglione@redhat.com>
Date: Tue, 25 Jul 2023 16:53:40 +0200
Message-ID: <CAJh=p+6D1wPw1mdWZUTpufgZyENFH3GZTtEVHDMG_OGDfDAaNg@mail.gmail.com>
Subject: Re: [PATCH] virtio: Fix packed virtqueue used_idx mask
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gmaglion@redhat.com;
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

On Fri, Jul 21, 2023 at 3:51=E2=80=AFPM Hanna Czenczek <hreitz@redhat.com> =
wrote:
>
> virtio_queue_packed_set_last_avail_idx() is used by vhost devices to set
> the internal queue indices to what has been reported by the vhost
> back-end through GET_VRING_BASE.  For packed virtqueues, this
> 32-bit value is expected to contain both the device's internal avail and
> used indices, as well as their respective wrap counters.
>
> To get the used index, we shift the 32-bit value right by 16, and then
> apply a mask of 0x7ffff.  That seems to be a typo, because it should be
> 0x7fff; first of all, the virtio specification says that the maximum
> queue size for packed virt queues is 2^15, so the indices cannot exceed
> 2^15 - 1 anyway, making 0x7fff the correct mask.  Second, the mask
> clearly is wrong from context, too, given that (A) `idx & 0x70000` must
> be 0 at this point (`idx` is 32 bit and was shifted to the right by 16
> already), (B) `idx & 0x8000` is the used_wrap_counter, so should not be
> part of the used index, and (C) `vq->used_idx` is a `uint16_t`, so
> cannot fit the 0x70000 part of the mask anyway.
>
> This most likely never produced any guest-visible bugs, though, because
> for a vhost device, qemu will probably not evaluate the used index
> outside of virtio_queue_packed_get_last_avail_idx(), where we
> reconstruct the 32-bit value from avail and used indices and their wrap
> counters again.  There, it does not matter whether the highest bit of
> the used_idx is the used index wrap counter, because we put the wrap
> counter exactly in that position anyway.
>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  hw/virtio/virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 295a603e58..309038fd46 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3321,7 +3321,7 @@ static void virtio_queue_packed_set_last_avail_idx(=
VirtIODevice *vdev,
>      vq->last_avail_wrap_counter =3D
>          vq->shadow_avail_wrap_counter =3D !!(idx & 0x8000);
>      idx >>=3D 16;
> -    vq->used_idx =3D idx & 0x7ffff;
> +    vq->used_idx =3D idx & 0x7fff;
>      vq->used_wrap_counter =3D !!(idx & 0x8000);
>  }
>
> --
> 2.41.0
>
>

Reviewed-by: German Maglione <gmaglione@redhat.com>

--=20
German


