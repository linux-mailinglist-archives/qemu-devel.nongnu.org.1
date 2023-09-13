Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BA479E143
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 09:57:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgKjB-0004zQ-Tj; Wed, 13 Sep 2023 03:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qgKj9-0004z2-3m
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:55:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qgKj6-0000yd-R5
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694591755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e+T78EfLbD3W1gVbFVQtm2/Wf6HsuIT6BGfT58aZwZw=;
 b=JgmBUUlOS0nKgCnKnJeCIOWOa4ePRCoNhfD7gY5KD5WpccWaK6vt4qSvEHU/Vpf/IneNag
 unEdKL6XuQDHucK3CdU+E8UKB4UWj4LMA2du8YT3KUBjHkKInnEHe4dqVxUqx5fZOTLG5p
 ZkRi/yFo0EpKAWQHvA9X9iRASJf5HC8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-WntRzEu3PRan1bvrIUtD_A-1; Wed, 13 Sep 2023 03:55:52 -0400
X-MC-Unique: WntRzEu3PRan1bvrIUtD_A-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-26d63b60934so8484230a91.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 00:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694591751; x=1695196551;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e+T78EfLbD3W1gVbFVQtm2/Wf6HsuIT6BGfT58aZwZw=;
 b=LiVx8GtLK5Ad3w1Ngj2rGsP5Adj+T0dYAIPqRuNHMn/zwUUp4+kWRNuCO1P09/haKp
 yZZWUD5+uAPh8ZPZzH1v2m1qNUBrN81OYojhOnMaX+WmO1edrqyWXfrNedH1XYuRIh8v
 qYp78NCD79HBh3x8bvqkyMUdT4K7OBYp3ZTC7lpOP+vkd1HcN1db6Cyig1WRsxZPfj8K
 kP/E4TN/VAma2Z3EvAJC68792inYBE4BFezlNNI4LFgvdp40A6tOYtHSqt9W3QeOAFft
 iMP3nOMV3xrNW6/L1uPln1AzLR33Rp/Q9VaRg2FxPL/81hasvM9a7vwnSRVCGc9GEK1/
 XiJg==
X-Gm-Message-State: AOJu0YwGYul2VJUWLjQPqTGV8Na91aWWKWjYsPKHEIbRXzPZ7CyxqBmQ
 DOd9O4Lbtfh7MAeUzrBHWbhTIP7GXRVZFn1QlOnAd44hSWvcam4yXA94lFxRWPk3nz+mbL4feku
 e1n/Rvk0M0JHfXg5lVowq+TOxF3rdO2c=
X-Received: by 2002:a17:90a:8b08:b0:26d:19bb:8638 with SMTP id
 y8-20020a17090a8b0800b0026d19bb8638mr1496802pjn.10.1694591751109; 
 Wed, 13 Sep 2023 00:55:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQDoMVGHdXgv2xWZ7r2lD7d0hK7dARmCmw/01FsyS8gPxJf+i2yGrB7deHiK5PDvY06n/0dOktVZqMDRxiiEs=
X-Received: by 2002:a17:90a:8b08:b0:26d:19bb:8638 with SMTP id
 y8-20020a17090a8b0800b0026d19bb8638mr1496776pjn.10.1694591750673; Wed, 13 Sep
 2023 00:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230831093252.2461282-1-ray.huang@amd.com>
 <20230831093252.2461282-11-ray.huang@amd.com>
 <58a4e81f-b0ce-49db-8a6a-f6b5bdc3d2d6@daynix.com> <ZPw2UjxogIULU722@amd.com>
 <11c227e8-a464-41ce-a435-82c570746388@daynix.com>
In-Reply-To: <11c227e8-a464-41ce-a435-82c570746388@daynix.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 13 Sep 2023 09:55:39 +0200
Message-ID: <CADSE00Kc1Jza7sbERRndWbXgoF1s2V-FNxEOWJ6WgvomzgvMPA@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="00000000000056af01060538e319"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

--00000000000056af01060538e319
Content-Type: text/plain; charset="UTF-8"

Hi Antonio,

If I'm not mistaken, this patch is related with:
https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01853.html
IMHO, ideally, virtio-gpu and vhost-user-gpu both, would use the
infrastructure from the patch I linked to store the
virtio objects, so that they can be later shared with other devices.

Which, in terms of code, would mean changing:
g_hash_table_insert(g->resource_uuids,
GUINT_TO_POINTER(assign.resource_id), uuid);
by:
virtio_add_dmabuf(uuid, assign.resource_id);

...and simplify part of the infrastructure.

Let me know what you think.

Regard,
Albert

--00000000000056af01060538e319
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>Hi Antonio,</div><div><br>=
</div><div>If I&#39;m not mistaken, this patch is related with:=C2=A0<a hre=
f=3D"https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01853.html">h=
ttps://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01853.html</a></div=
><div>IMHO, ideally, virtio-gpu and vhost-user-gpu both, would use the infr=
astructure from the patch I linked to store the<br></div><div>virtio object=
s, so that they can be later shared with other devices.</div><div><br></div=
><div>Which, in terms of code, would mean changing:</div><div>g_hash_table_=
insert(g-&gt;resource_uuids, GUINT_TO_POINTER(assign.resource_id), uuid);<b=
r></div><div>by:</div><div>virtio_add_dmabuf(uuid, assign.resource_id);</di=
v><div><br></div><div>...and simplify part of the infrastructure.</div><div=
><br></div><div>Let me know what you think.</div><div><br></div><div>Regard=
,</div><div>Albert</div></div></div>

--00000000000056af01060538e319--


