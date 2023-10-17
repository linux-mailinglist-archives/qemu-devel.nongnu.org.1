Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1087CC60E
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 16:40:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qslDn-0001bH-Ca; Tue, 17 Oct 2023 10:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qslDl-0001Zo-At
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:38:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qslDj-0004gS-CD
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697553534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jz76M+k1ox5P1ztphH/C89c5JUS+TH8+qkS2UvJ8dps=;
 b=ccUxHU/fDcrmXf9R/294Lml1KGP/kzjszWv678pTyaICOKrTBa350Z5VI6lOVRGxEI4dLw
 ruXiZrghGQkz3ngJKUAitdGiLvDUkvb0Y66rpnyh7sAnnDeEZcG0KLPWGxRnDv2zFMVq+I
 Zj/DSLpktDa3SwamNa1LRjZ5671gBa8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-rMvWZkkOPLSz7WI61t0WKQ-1; Tue, 17 Oct 2023 10:38:41 -0400
X-MC-Unique: rMvWZkkOPLSz7WI61t0WKQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-27d1f57bda4so3833660a91.3
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 07:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697553521; x=1698158321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jz76M+k1ox5P1ztphH/C89c5JUS+TH8+qkS2UvJ8dps=;
 b=Vph39Ee4O39s4cu/c320PjHc8paPliwQIlGWVr2Nr2QOB3WQTnzFY3AG+65eQxPWWV
 S6xTedrOwqWcX4TIcI1tCNm/Sw2zuYAY2vYEvFS7jYtUT5ZPO9n0/tGBJliwsIac9lrf
 r0kl948qhjlHj9IY7Gt2saMFg8SAKrHbyNm4pu8xLo5bSjDCVHYI3c6WE7O/zgXXiTm+
 x6OupR6BWr59RvlnxGrYo0IO/sfORTaHJ3nc8T+ZsDbeYhY/pGVJv9RAf22qGNbVoonO
 BOfLIDW549ef6DbEIAWI1AQx7F/RlNmED1KvQoeJ3p2Q1Tws7oxZqDA0sHsxmtGVKV/1
 oZwA==
X-Gm-Message-State: AOJu0Yyk06lhHzfx9Hqyg+OBlosPVGDwyydUnhlh0/5rtwOGqgiOMx/n
 QxOaev9AdxFDEX/4Ld+eanGdiaHZEAgs5vuX9fn8TuhTABmj+GiH1hxt9ngqNgnc2Yr4jV98E5x
 7NyS3fFhlDle2W0EC7yupOUD1chlksPE=
X-Received: by 2002:a17:90a:fa11:b0:27d:3fa4:9d9a with SMTP id
 cm17-20020a17090afa1100b0027d3fa49d9amr2168486pjb.29.1697553520758; 
 Tue, 17 Oct 2023 07:38:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhOdcU3pOYThlytJ16MfWCekYSDNVx6iZF+J/HLoVp6sjhpwgY9eF/YFYX0pqR8HcYmWvgZTF3SdiPlw0LahU=
X-Received: by 2002:a17:90a:fa11:b0:27d:3fa4:9d9a with SMTP id
 cm17-20020a17090afa1100b0027d3fa49d9amr2168462pjb.29.1697553520369; Tue, 17
 Oct 2023 07:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231016083201.23736-1-hreitz@redhat.com>
 <2m60m.9e9wlnnm01vd@linaro.org>
 <20231016103254.7xrnptmwrjnsr3uc@vireshk-i7> <87lec2dc7r.fsf@linaro.org>
 <20231017053638.hhs57axmwqtzbpp6@vireshk-i7>
 <ceeaa1f3-c0ad-65c1-80d1-ec869f976146@redhat.com>
 <20231017075352.2l3htkj46gunyjrm@vireshk-i7>
 <CADSE00JkwkyruO-rhiN7p_T_2efAed8B2Uzp01jVj=YH7Wixmw@mail.gmail.com>
 <CAJSP0QUhc5Ov=gG626gCMq+4V7rpsS2b-8VKzM3bz3VNaZ_3Xg@mail.gmail.com>
In-Reply-To: <CAJSP0QUhc5Ov=gG626gCMq+4V7rpsS2b-8VKzM3bz3VNaZ_3Xg@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 17 Oct 2023 16:38:28 +0200
Message-ID: <CADSE00LuFD9TxdVTBrPYqS0G_r_9fdht=BJf_2rG=F4sR-1fYA@mail.gmail.com>
Subject: Re: [PATCH] vhost-user: Fix protocol feature bit conflict
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Hanna Czenczek <hreitz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org, 
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Garhwal, Vikram" <vikram.garhwal@amd.com>
Content-Type: multipart/alternative; boundary="00000000000091be040607ea7acd"
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

--00000000000091be040607ea7acd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 12:57=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:

> On Tue, 17 Oct 2023 at 04:26, Albert Esteve <aesteve@redhat.com> wrote:
> >
> > Hi!
> >
> > Thanks for the patch, and sorry for not noticing the flag had already
> been assigned. The patch looks good to me!
>
> Hi Albert,
> I looked at the shared object code for the first time:
> - There are memory leaks in virtio_add_dmabuf() and
> virtio_add_vhost_device() when the UUID was added previously.
>

There is a patch already for fixing the leak:
https://patchew.org/QEMU/c61c13f9a0c67dec473bdbfc8789c29ef26c900b.169662473=
4.git.quic._5Fmathbern@quicinc.com/


> - The hash table is global and there is no spoofing protection, so
> vhost-user devices can hijack known UUIDs. Is it possible to associate
> a vhost_dev owner with each shared object and only allow the owner to
> remove it?
>

True, it is unprotected from another backend to remove an entry without
ownership.
It sounds like a nice addition, I will post a patch. Thanks!


> - Is there cleanup code that removes shared objects from the hash
> table when a vhost_dev is destroyed? Otherwise TYPE_VHOST_DEV shared
> objects are leaked and their stale vhost_dev pointers could be
> dereferenced.
>

There is not. In a first thought, I assumed that the backends will be in
charge
of cleaning their entries from the shared hash table when they are destroye=
d
(prematurely or no). I will look into occurrences of vhost_dev getting
destroyed
that may need explicit handling of the leftover entries.


> - virtio-dmabuf.h API naming suggests this is a core VirtIODevice API:
> virtio_free_resources(), virtio_add_vhost_device(), etc rather than an
> API for VirtioSharedObject. Can the names be made more specific:
> virtio_dmabuf_*() or virtio_shobj_*() so it's clear these APIs are
> related to the dmabufs/shared objects?
>

Improving the names with what you suggested sounds good to me.
I guess I'll go with virtio_dmabuf_*, for consistency with the file
name. But `shobj` would be ok too.


>
> Thanks,
> Stefan
>
>

--00000000000091be040607ea7acd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><p style=3D"color:rgb(0,0,0);font-family:RedHatText=
,sans-serif;font-weight:bold;margin:0px;padding:0px;font-size:14px"><br></p=
></div></div></div><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr=
" class=3D"gmail_attr">On Tue, Oct 17, 2023 at 12:57=E2=80=AFPM Stefan Hajn=
oczi &lt;<a href=3D"mailto:stefanha@gmail.com">stefanha@gmail.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, 17=
 Oct 2023 at 04:26, Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com"=
 target=3D"_blank">aesteve@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi!<br>
&gt;<br>
&gt; Thanks for the patch, and sorry for not noticing the flag had already =
been assigned. The patch looks good to me!<br>
<br>
Hi Albert,<br>
I looked at the shared object code for the first time:<br>
- There are memory leaks in virtio_add_dmabuf() and<br>
virtio_add_vhost_device() when the UUID was added previously.<br></blockquo=
te><div><br></div><div>There is a patch already for fixing the leak:</div><=
div><a href=3D"https://patchew.org/QEMU/c61c13f9a0c67dec473bdbfc8789c29ef26=
c900b.1696624734.git.quic._5Fmathbern@quicinc.com/">https://patchew.org/QEM=
U/c61c13f9a0c67dec473bdbfc8789c29ef26c900b.1696624734.git.quic._5Fmathbern@=
quicinc.com/</a></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
- The hash table is global and there is no spoofing protection, so<br>
vhost-user devices can hijack known UUIDs. Is it possible to associate<br>
a vhost_dev owner with each shared object and only allow the owner to<br>
remove it?<br></blockquote><div><br></div><div>True, it is unprotected from=
 another backend to remove an entry without ownership.</div><div>It sounds =
like a nice addition, I will post a patch. Thanks!</div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
- Is there cleanup code that removes shared objects from the hash<br>
table when a vhost_dev is destroyed? Otherwise TYPE_VHOST_DEV shared<br>
objects are leaked and their stale vhost_dev pointers could be<br>
dereferenced.<br></blockquote><div><br></div><div>There is not. In a first =
thought, I assumed that the backends will be in charge</div><div>of cleanin=
g their entries from the shared hash table when they are destroyed</div><di=
v>(prematurely or no). I will look into occurrences of vhost_dev getting de=
stroyed</div><div>that may need explicit handling of the leftover entries.<=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
- virtio-dmabuf.h API naming suggests this is a core VirtIODevice API:<br>
virtio_free_resources(), virtio_add_vhost_device(), etc rather than an<br>
API for VirtioSharedObject. Can the names be made more specific:<br>
virtio_dmabuf_*() or virtio_shobj_*() so it&#39;s clear these APIs are<br>
related to the dmabufs/shared objects?<br></blockquote><div><br></div><div>=
Improving the names with what you suggested sounds good to me.</div><div>I =
guess I&#39;ll go with virtio_dmabuf_*, for consistency with the file</div>=
<div>name. But `shobj` would be ok too.</div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
<br>
Thanks,<br>
Stefan<br>
<br>
</blockquote></div></div>

--00000000000091be040607ea7acd--


