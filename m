Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DF5779127
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 15:59:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUSet-0005Zv-2e; Fri, 11 Aug 2023 09:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qUSer-0005ZG-2w
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 09:58:29 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qUSep-0004hY-3f
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 09:58:28 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1c10bb168faso941564fac.3
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 06:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691762305; x=1692367105;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k2e+sy7nb+aToz8asQLy/e6dkBqEPfwDqd5R+KaLOrA=;
 b=WZBaugWf1VU3C17ks/868kkkzYq0i0hJBcGoARnoSQi3xsgG+ifR5vWC+uLxm6kzdP
 3TNnNRVDN/Y9LhWuo0U18iObyIs7CVtGwIh1G7oWmCInJa8ugDRnJ3Xy/HqjcbAsoVR7
 GyWWPxWWCcJd0WMiMl7aHFkDKsI809rzKcdP3WFltiYmSPuo65JDY/h8XfjEn9aeTfRx
 wT36SRFZQG5P5hXPeQFZHrjqttizkRqQFS+MJvbmU6BTb+opf+blcHakLXcFcA0Vgee2
 ckeatfNTeB3hPKX89YbRHHuCmh4iPOX9OxprOczFLjVc5MWbVx4Mdtpn8h4dByU4WRPh
 2qhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691762305; x=1692367105;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k2e+sy7nb+aToz8asQLy/e6dkBqEPfwDqd5R+KaLOrA=;
 b=WrmJXmZGorjXdWWtWteA7L6uY89Yq7pYsbnROj1V3gRhGDPnJomySVEkauRXKrBviy
 2b9JCKQrDN25VN8nxOCrHCasbQ21OveZ0reM+6uiCdVNcnwEpGgkv5CA6mkYrV4e4D0z
 6kxdQxdEXvSTcoOap+MOAwNq2vMeBOMXpQnFJsA/Tvm+2hdrycKLepAHPat8MUSdJ7tN
 KJiq1P2U09R8AbGRusYVFhnC8HHjmaAXsHe2/4VHzQd9BDCJwNd+RjWbTonfftAMRfVg
 AYZvY0jSU2LVvi3twPwklU4U1yfbrg6bWKehswEotBpb2+0wFoVpXSWDzj0VrpMEgMWC
 ezSg==
X-Gm-Message-State: AOJu0YzSvW4qE8lyXnGqOYC2T2Mldg8BfIPpSUjPkzIQEo32/U60b/4D
 hFPK9pKsGrew1SUjpwdtUrfIx7iRedTK05XtRgY=
X-Google-Smtp-Source: AGHT+IGa05WQus0G1f15an1oHXVxNSngwUrxy88U57Rff5Y+8KjSpZBQCpOJx84e7moxYad7oW/fcv8ZfzsdKdcQsKk=
X-Received: by 2002:a05:6870:45a8:b0:1bb:8cc2:8c3e with SMTP id
 y40-20020a05687045a800b001bb8cc28c3emr1817765oao.15.1691762305660; Fri, 11
 Aug 2023 06:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230807222847.2837393-1-i.maximets@ovn.org>
 <20230810155048.GI2931656@fedora>
 <3479fe54-66c5-4c17-8972-2c5d22028bdd@ovn.org>
In-Reply-To: <3479fe54-66c5-4c17-8972-2c5d22028bdd@ovn.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 11 Aug 2023 09:58:14 -0400
Message-ID: <CAJSP0QXi9PKShUgtVf6DVsNOEW3-AT8+rbdFU1GHgmD0J-G8MQ@mail.gmail.com>
Subject: Re: [PATCH] virtio: don't zero out memory region cache for indirect
 descriptors
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000045fc520602a61bc8"
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000045fc520602a61bc8
Content-Type: text/plain; charset="UTF-8"

On Fri, Aug 11, 2023, 08:50 Ilya Maximets <i.maximets@ovn.org> wrote:

> On 8/10/23 17:50, Stefan Hajnoczi wrote:
> > On Tue, Aug 08, 2023 at 12:28:47AM +0200, Ilya Maximets wrote:
> >> Lots of virtio functions that are on a hot path in data transmission
> >> are initializing indirect descriptor cache at the point of stack
> >> allocation.  It's a 112 byte structure that is getting zeroed out on
> >> each call adding unnecessary overhead.  It's going to be correctly
> >> initialized later via special init function.  The only reason to
> >> actually initialize right away is the ability to safely destruct it.
> >> However, we only need to destruct it when it was used, i.e. when a
> >> desc_cache points to it.
> >>
> >> Removing these unnecessary stack initializations improves throughput
> >> of virtio-net devices in terms of 64B packets per second by 6-14 %
> >> depending on the case.  Tested with a proposed af-xdp network backend
> >> and a dpdk testpmd application in the guest, but should be beneficial
> >> for other virtio devices as well.
> >>
> >> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> >> ---
> >>  hw/virtio/virtio.c | 42 +++++++++++++++++++++++++++---------------
> >>  1 file changed, 27 insertions(+), 15 deletions(-)
> >
> > Another option is to create an address_space_cache_init_invalid()
> > function that only assigns mrs.mr = NULL instead of touching all bytes
> > of the struct like = MEMORY_REGION_CACHE_INVALID. There would be less
> > code and the existing mrs.mr check in address_space_cache_destroy()
> > would serve the same function as the desc_cache == &indirect_desc_cache
> > check added by this patch.
>
> It does look simpler this way, indeed.  Though I'm not sure about
> a function name.  We have address_space_cache_invalidate() that
> does a completely different thing and the invalidated cache can
> still be used, while the cache initialized with the newly proposed
> address_space_cache_init_invalid() can not be safely used.
>
> I suppose, the problem is not new, since the macro was named similarly,
> but making it a function seems to make the issue worse.
>
> Maybe address_space_cache_init_empty() will be a better name?
> E.g.:
>
> **
>  * address_space_cache_init_empty: Initialize empty #MemoryRegionCache
>  *
>  * @cache: The #MemoryRegionCache to operate on.
>  *
>  * Initializes #MemoryRegionCache structure without memory region attached.
>  * Cache initialized this way can only be safely destroyed, but not used.
>  */
> static inline void address_space_cache_init_empty(MemoryRegionCache *cache)
> {
>     cache->mrs.mr = NULL;
> }
>
> What do you think?
>

init_empty() is good.

Stefan

>

--00000000000045fc520602a61bc8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Aug 11, 2023, 08:50 Ilya Maximets &lt;<a href=
=3D"mailto:i.maximets@ovn.org">i.maximets@ovn.org</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">On 8/10/23 17:50, Stefan Hajnoczi wrote:<br>
&gt; On Tue, Aug 08, 2023 at 12:28:47AM +0200, Ilya Maximets wrote:<br>
&gt;&gt; Lots of virtio functions that are on a hot path in data transmissi=
on<br>
&gt;&gt; are initializing indirect descriptor cache at the point of stack<b=
r>
&gt;&gt; allocation.=C2=A0 It&#39;s a 112 byte structure that is getting ze=
roed out on<br>
&gt;&gt; each call adding unnecessary overhead.=C2=A0 It&#39;s going to be =
correctly<br>
&gt;&gt; initialized later via special init function.=C2=A0 The only reason=
 to<br>
&gt;&gt; actually initialize right away is the ability to safely destruct i=
t.<br>
&gt;&gt; However, we only need to destruct it when it was used, i.e. when a=
<br>
&gt;&gt; desc_cache points to it.<br>
&gt;&gt;<br>
&gt;&gt; Removing these unnecessary stack initializations improves throughp=
ut<br>
&gt;&gt; of virtio-net devices in terms of 64B packets per second by 6-14 %=
<br>
&gt;&gt; depending on the case.=C2=A0 Tested with a proposed af-xdp network=
 backend<br>
&gt;&gt; and a dpdk testpmd application in the guest, but should be benefic=
ial<br>
&gt;&gt; for other virtio devices as well.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Ilya Maximets &lt;<a href=3D"mailto:i.maximets@ovn.=
org" target=3D"_blank" rel=3D"noreferrer">i.maximets@ovn.org</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 hw/virtio/virtio.c | 42 +++++++++++++++++++++++++++---------=
------<br>
&gt;&gt;=C2=A0 1 file changed, 27 insertions(+), 15 deletions(-)<br>
&gt; <br>
&gt; Another option is to create an address_space_cache_init_invalid()<br>
&gt; function that only assigns <a href=3D"http://mrs.mr" rel=3D"noreferrer=
 noreferrer" target=3D"_blank">mrs.mr</a> =3D NULL instead of touching all =
bytes<br>
&gt; of the struct like =3D MEMORY_REGION_CACHE_INVALID. There would be les=
s<br>
&gt; code and the existing <a href=3D"http://mrs.mr" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">mrs.mr</a> check in address_space_cache_destroy()=
<br>
&gt; would serve the same function as the desc_cache =3D=3D &amp;indirect_d=
esc_cache<br>
&gt; check added by this patch.<br>
<br>
It does look simpler this way, indeed.=C2=A0 Though I&#39;m not sure about<=
br>
a function name.=C2=A0 We have address_space_cache_invalidate() that<br>
does a completely different thing and the invalidated cache can<br>
still be used, while the cache initialized with the newly proposed<br>
address_space_cache_init_invalid() can not be safely used.<br>
<br>
I suppose, the problem is not new, since the macro was named similarly,<br>
but making it a function seems to make the issue worse.<br>
<br>
Maybe address_space_cache_init_empty() will be a better name?<br>
E.g.:<br>
<br>
**<br>
=C2=A0* address_space_cache_init_empty: Initialize empty #MemoryRegionCache=
<br>
=C2=A0*<br>
=C2=A0* @cache: The #MemoryRegionCache to operate on.<br>
=C2=A0*<br>
=C2=A0* Initializes #MemoryRegionCache structure without memory region atta=
ched.<br>
=C2=A0* Cache initialized this way can only be safely destroyed, but not us=
ed.<br>
=C2=A0*/<br>
static inline void address_space_cache_init_empty(MemoryRegionCache *cache)=
<br>
{<br>
=C2=A0 =C2=A0 cache-&gt;<a href=3D"http://mrs.mr" rel=3D"noreferrer norefer=
rer" target=3D"_blank">mrs.mr</a> =3D NULL;<br>
}<br>
<br>
What do you think?<br></blockquote></div></div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">init_empty() is good.</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Stefan</div><div dir=3D"auto"><div class=3D"gmail_quote"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--00000000000045fc520602a61bc8--

