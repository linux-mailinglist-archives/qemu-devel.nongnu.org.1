Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DE579E6ED
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 13:36:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgO92-0005zx-Ld; Wed, 13 Sep 2023 07:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qgO8z-0005zn-3t
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 07:34:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qgO8v-0005u4-Lv
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 07:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694604888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zMskR6cu9i22y34XL44NEQPqeIL9khl3qtNSgvRoqCA=;
 b=UEdbPOl9ki3vIpYwgQz3MUW1y34grgy0FcSW2jH49t/ICsnwZmDvdIHj/BfV2p8V7FBsQo
 aztSwu/clhVEOZ8XbUWcg2qKrOZvs3dhpRYKunGdNHk0lSlCO8Tv6sqKxy1hqCd7wxuDvg
 8jYSVYhMqixk9q7AxRtpdEnJDkby7nA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-Veg6Qre4M7m01Oc_xWAmVA-1; Wed, 13 Sep 2023 07:34:47 -0400
X-MC-Unique: Veg6Qre4M7m01Oc_xWAmVA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-27372e336b2so810513a91.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 04:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694604886; x=1695209686;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zMskR6cu9i22y34XL44NEQPqeIL9khl3qtNSgvRoqCA=;
 b=KiI0Lc3uqlBBTULWTMgIVVHwsQ1fWuH8f+cmM4I9THfRWl202f9hU9HcL93k+M6nAU
 OA9KJS3mpBYAQXddibj0yN1zvtOMSZgj8FeIgDnueUNHZkBO+z/v/L1zBY3f3EW1xImi
 qk+X9ooxh7BlJtPYyeXonNuht21i6MUjDuYAM6HGbCj+5QStVijZ3NRlQWh7ESFaP8hg
 wXh3YBdy31yOH9L5azIZW6eMunNzRK5qOX1wHTYqmh5nXmKgQtKXBuXDyddHiee+Juub
 A1NitifPYLAoPAUV25fwFv4tBh5Ueg+TEhdAsLAcdgLmYy4Iep55Slvex+ItsN4MD97M
 X8Kg==
X-Gm-Message-State: AOJu0YwtCN0RE6y4/d6r6BSW341AWLmSAnw7XNJxA7ZosXRy3YLQ3uIf
 63gp6o7nw6OKc4Km1MxZaqzkBmd2BZVrmrQc9n+aOmH3ED6STdWxI5kbFug9CCsl9j96DVuWeRM
 QiGUPAgCab0vsrJogAlfmkxBfatZyLcM=
X-Received: by 2002:a17:90b:4b82:b0:26d:689f:4253 with SMTP id
 lr2-20020a17090b4b8200b0026d689f4253mr7447242pjb.6.1694604885616; 
 Wed, 13 Sep 2023 04:34:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJWBwNCbFL7Jyu5Boq2Q8xMqbev4t/zbOs3GqV/MXKXOUFx1M1LMxGo4WIMdWApSj5iZlPgc9WjXu2ERG7xSA=
X-Received: by 2002:a17:90b:4b82:b0:26d:689f:4253 with SMTP id
 lr2-20020a17090b4b8200b0026d689f4253mr7447190pjb.6.1694604885258; Wed, 13 Sep
 2023 04:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230831093252.2461282-1-ray.huang@amd.com>
 <20230831093252.2461282-11-ray.huang@amd.com>
 <58a4e81f-b0ce-49db-8a6a-f6b5bdc3d2d6@daynix.com> <ZPw2UjxogIULU722@amd.com>
 <11c227e8-a464-41ce-a435-82c570746388@daynix.com>
 <CADSE00Kc1Jza7sbERRndWbXgoF1s2V-FNxEOWJ6WgvomzgvMPA@mail.gmail.com>
 <cf99ac00-6f48-4778-b319-6079a931ba5d@daynix.com>
In-Reply-To: <cf99ac00-6f48-4778-b319-6079a931ba5d@daynix.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 13 Sep 2023 13:34:34 +0200
Message-ID: <CADSE00+6zcT7iKR0JW1Bk8es6HtBpzAKa9JW6u5yyjDoLPw2KQ@mail.gmail.com>
Subject: Re: [QEMU PATCH v4 10/13] virtio-gpu: Resource UUID
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Huang Rui <ray.huang@amd.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony.perard@citrix.com>, 
 Antonio Caggiano <antonio.caggiano@collabora.com>, 
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, 
 Gurchetan Singh <gurchetansingh@chromium.org>,
 "ernunes@redhat.com" <ernunes@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, 
 "Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>, 
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>, 
 "Huang, Honglei1" <Honglei1.Huang@amd.com>, "Zhang,
 Julia" <Julia.Zhang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Content-Type: multipart/alternative; boundary="000000000000388aee06053bf2d0"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--000000000000388aee06053bf2d0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 12:34=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayni=
x.com>
wrote:

> On 2023/09/13 16:55, Albert Esteve wrote:
> > Hi Antonio,
> >
> > If I'm not mistaken, this patch is related with:
> > https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01853.html
> > <https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01853.html>
> > IMHO, ideally, virtio-gpu and vhost-user-gpu both, would use the
> > infrastructure from the patch I linked to store the
> > virtio objects, so that they can be later shared with other devices.
>
> I don't think such sharing is possible because the resources are
> identified by IDs that are local to the device. That also complicates
> migration.
>
> Regards,
> Akihiko Odaki
>
> Hi Akihiko,

As far as I understand, the feature to export dma-bufs from the
virtgpu was introduced as part of the virtio cross-device sharing
proposal [1]. Thus, it shall be posible. When virtgpu ASSING_UUID,
it exports and identifies the dmabuf resource, so that when the dmabuf gets
shared inside the guest (e.g., with virtio-video), we can use the assigned
UUID to find the dmabuf in the host (using the patch that I linked above),
and import it.

[1] - https://lwn.net/Articles/828988/

--000000000000388aee06053bf2d0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 13, 2023 at 12:34=E2=80=
=AFPM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com" target=
=3D"_blank">akihiko.odaki@daynix.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On 2023/09/13 16:55, Albert Esteve wrot=
e:<br>
&gt; Hi Antonio,<br>
&gt; <br>
&gt; If I&#39;m not mistaken, this patch is related with: <br>
&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01=
853.html" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/archiv=
e/html/qemu-devel/2023-09/msg01853.html</a> <br>
&gt; &lt;<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2023-09/m=
sg01853.html" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/ar=
chive/html/qemu-devel/2023-09/msg01853.html</a>&gt;<br>
&gt; IMHO, ideally, virtio-gpu and vhost-user-gpu both, would use the <br>
&gt; infrastructure from the patch I linked to store the<br>
&gt; virtio objects, so that they can be later shared with other devices.<b=
r>
<br>
I don&#39;t think such sharing is possible because the resources are <br>
identified by IDs that are local to the device. That also complicates <br>
migration.<br>
<br>
Regards,<br>
Akihiko Odaki<br>
<br></blockquote><div>Hi Akihiko,</div><div><br></div><div>As far as I unde=
rstand, the feature to export dma-bufs=C2=A0from the</div><div>virtgpu was =
introduced as part of the virtio cross-device sharing</div><div>proposal [1=
]. Thus, it shall be posible. When virtgpu=C2=A0ASSING_UUID,</div><div>it e=
xports and identifies the dmabuf resource, so that when the dmabuf gets</di=
v><div>shared inside the guest (e.g., with virtio-video), we can use the as=
signed</div><div>UUID to find the dmabuf in the host (using the patch that =
I linked above),</div><div>and import it.</div><div><br></div><div>[1] -=C2=
=A0<a href=3D"https://lwn.net/Articles/828988/" target=3D"_blank">https://l=
wn.net/Articles/828988/</a></div></div></div>

--000000000000388aee06053bf2d0--


