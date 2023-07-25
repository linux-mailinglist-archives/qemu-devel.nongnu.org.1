Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CABFE761AF2
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:08:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOIgW-0001pa-Pd; Tue, 25 Jul 2023 10:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmaglion@redhat.com>)
 id 1qOIgT-0001pK-Rl
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:06:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmaglion@redhat.com>)
 id 1qOIgR-0006f9-VS
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690293979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bzx4yUm32LJI4Gx+oon9+WUcKcmuXrAqNxxis3UxoOQ=;
 b=BK+Us6ZbkdJqCAxFNPPZ69GRq98Eo/rAxSnoYcAxiXZLINm2/IFQXfi52gzmOKL10w8JLh
 dQtF+r3wpAObJWzRIf0VpunZpoI2KcpknUlksZERq5h5nBrJX9bCN8zqcz493oNwhmy8Hm
 sRZd4fkk03Qio5/KZ4bRQ6f67bshHBA=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-3fZkLMAmOsyyKKZhCyH4EA-1; Tue, 25 Jul 2023 10:05:07 -0400
X-MC-Unique: 3fZkLMAmOsyyKKZhCyH4EA-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-d0497189714so414741276.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 07:05:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690293907; x=1690898707;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bzx4yUm32LJI4Gx+oon9+WUcKcmuXrAqNxxis3UxoOQ=;
 b=EcyOtjmmYQ/Xo2HRt4W6RrIwuZ05K6B9gXqF9sh7Abpalv5rjtKfRp6ij+IUzog96p
 uOHtgv1Lvsu25vQ0VR5hGr7yOYQYyzBY/XVRXovSRzqHjO5pGgH5zPiY3WEAmPN8d3yj
 lpS/bvqjOHn5uf3BylXUnZmWlrNlS1FsmxeIOUNLNNt1sHE0CRol+VvMyGOgpR7WNbmd
 DlbdykUp4SLlFpQD80MafV3YCcIyfXp0Hlpcc1GBde95WQ9gbWyz3DmSYOoTx1oo9Yp0
 P59eUi/qwxrKb91KM6YpIxNpAhshB2NE+E5EtlbXSegXs/e1/VnUtE40dXdItcnJ573L
 54YA==
X-Gm-Message-State: ABy/qLYqoTNTgIZJPbErNtryZQq9Y6sfnyNKtmrgFpDBYKXSQJ6JGu5u
 ZaPYWgs/8U/b40N5jztMHMuE3J4Qvb9yzIhLmKxvViRPS4PO6kXcfZEtomf44buM0Xu2Xzt0E41
 jY36pI2srYury99F+vijplikdgOSamXI=
X-Received: by 2002:a25:ad07:0:b0:d0f:a9b7:e7d1 with SMTP id
 y7-20020a25ad07000000b00d0fa9b7e7d1mr3396097ybi.5.1690293906917; 
 Tue, 25 Jul 2023 07:05:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG4IAvdb0Gj6p1cSa4+wEAT9n/NkvV1AWZdZN7C+604p0uDwpK5lb2DgWTaPR2vcfb3dAqbMzlRHhD3+I+NO7Q=
X-Received: by 2002:a25:ad07:0:b0:d0f:a9b7:e7d1 with SMTP id
 y7-20020a25ad07000000b00d0fa9b7e7d1mr3396083ybi.5.1690293906669; Tue, 25 Jul
 2023 07:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230721134945.26967-1-hreitz@redhat.com>
In-Reply-To: <20230721134945.26967-1-hreitz@redhat.com>
From: German Maglione <gmaglione@redhat.com>
Date: Tue, 25 Jul 2023 16:04:30 +0200
Message-ID: <CAJh=p+5sTOVPmSm-LeV1SJxTQW0dOuL_Lz2GTcdCK6MY6V7LxQ@mail.gmail.com>
Subject: Re: [PATCH] virtio: Fix packed virtqueue used_idx mask
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000df95050601503798"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gmaglion@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000df95050601503798
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2023 at 3:51=E2=80=AFPM Hanna Czenczek <hreitz@redhat.com> =
wrote:

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
> @@ -3321,7 +3321,7 @@ static void
> virtio_queue_packed_set_last_avail_idx(VirtIODevice *vdev,
>      vq->last_avail_wrap_counter =3D
>          vq->shadow_avail_wrap_counter =3D !!(idx & 0x8000);
>      idx >>=3D 16;
> -    vq->used_idx =3D idx & 0x7ffff;
> +    vq->used_idx =3D idx & 0x7fff;
>

isn't there a macro with this value?
or a macro that convert a number of bits in a mask?, something like:
#define BIT_MASK(n) (~(~0 << n))



>      vq->used_wrap_counter =3D !!(idx & 0x8000);
>  }
>
> --
> 2.41.0
>
>
>


--=20
German

--000000000000df95050601503798
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 21, 2023 at 3:51=E2=80=AF=
PM Hanna Czenczek &lt;<a href=3D"mailto:hreitz@redhat.com">hreitz@redhat.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>virtio_queue_packed_set_last_avail_idx() is used by vhost devices to set<b=
r>
the internal queue indices to what has been reported by the vhost<br>
back-end through GET_VRING_BASE.=C2=A0 For packed virtqueues, this<br>
32-bit value is expected to contain both the device&#39;s internal avail an=
d<br>
used indices, as well as their respective wrap counters.<br>
<br>
To get the used index, we shift the 32-bit value right by 16, and then<br>
apply a mask of 0x7ffff.=C2=A0 That seems to be a typo, because it should b=
e<br>
0x7fff; first of all, the virtio specification says that the maximum<br>
queue size for packed virt queues is 2^15, so the indices cannot exceed<br>
2^15 - 1 anyway, making 0x7fff the correct mask.=C2=A0 Second, the mask<br>
clearly is wrong from context, too, given that (A) `idx &amp; 0x70000` must=
<br>
be 0 at this point (`idx` is 32 bit and was shifted to the right by 16<br>
already), (B) `idx &amp; 0x8000` is the used_wrap_counter, so should not be=
<br>
part of the used index, and (C) `vq-&gt;used_idx` is a `uint16_t`, so<br>
cannot fit the 0x70000 part of the mask anyway.<br>
<br>
This most likely never produced any guest-visible bugs, though, because<br>
for a vhost device, qemu will probably not evaluate the used index<br>
outside of virtio_queue_packed_get_last_avail_idx(), where we<br>
reconstruct the 32-bit value from avail and used indices and their wrap<br>
counters again.=C2=A0 There, it does not matter whether the highest bit of<=
br>
the used_idx is the used index wrap counter, because we put the wrap<br>
counter exactly in that position anyway.<br>
<br>
Signed-off-by: Hanna Czenczek &lt;<a href=3D"mailto:hreitz@redhat.com" targ=
et=3D"_blank">hreitz@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/virtio/virtio.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c<br>
index 295a603e58..309038fd46 100644<br>
--- a/hw/virtio/virtio.c<br>
+++ b/hw/virtio/virtio.c<br>
@@ -3321,7 +3321,7 @@ static void virtio_queue_packed_set_last_avail_idx(Vi=
rtIODevice *vdev,<br>
=C2=A0 =C2=A0 =C2=A0vq-&gt;last_avail_wrap_counter =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vq-&gt;shadow_avail_wrap_counter =3D !!(i=
dx &amp; 0x8000);<br>
=C2=A0 =C2=A0 =C2=A0idx &gt;&gt;=3D 16;<br>
-=C2=A0 =C2=A0 vq-&gt;used_idx =3D idx &amp; 0x7ffff;<br>
+=C2=A0 =C2=A0 vq-&gt;used_idx =3D idx &amp; 0x7fff;<br></blockquote><div><=
br></div><div>isn&#39;t there a macro with this value?<br>or a macro that c=
onvert a number of bits in a mask?, something like:<br></div><div>#define B=
IT_MASK(n) (~(~0 &lt;&lt; n))<br></div><div><br></div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0vq-&gt;used_wrap_counter =3D !!(idx &amp; 0x8000);<br>
=C2=A0}<br>
<br>
-- <br>
2.41.0<br>
<br>
<br>
</blockquote></div><div><br></div><div><br></div><br><span class=3D"gmail_s=
ignature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><=
div dir=3D"ltr">German<br></div></div></div>

--000000000000df95050601503798--


