Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 883447668B3
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 11:23:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPJQN-0000wX-8L; Fri, 28 Jul 2023 05:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qPJQC-0000ta-BN
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 05:06:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qPJQ6-0006eO-E5
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 05:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690535157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AGWS6q6vYaIA9wZ092+QED3mBjscQd0r1GZzgvOuVzo=;
 b=DOrNc5OeCQ0DRF9ZySeWq96xib5Ss+KIJJPPqmM6dE/vx/yuS+BrXhWzQwx1+Da3q9wMr5
 L+byjoATJujnc+i4YsMK820aaeT6ITVT1DFSZCo4MLUPk+a+aNNWqdmZfmVt8KUPp15SkM
 Si49MB0JMnA2xeGkxE0XGum1kAlerxs=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-hE3O4QN-MV20YwMttBh9KQ-1; Fri, 28 Jul 2023 05:05:55 -0400
X-MC-Unique: hE3O4QN-MV20YwMttBh9KQ-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3a1e58db5caso3888401b6e.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 02:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690535155; x=1691139955;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AGWS6q6vYaIA9wZ092+QED3mBjscQd0r1GZzgvOuVzo=;
 b=lrYaesREpfTIFYMVJF6SgHE1q0sCkviKl4b9WBP/PV0nJqEoYN05FthBtK12M7WG2L
 psomdnoH5UmjKCQ2gHu5ZM7sz6QYtjD7uzOTsJyAAeuoJsA5RFgOoCn+n82mG/J0vM5V
 YThuC1ztRNViCfxSiSJhrQSUrWbJZqqN6WnWkyWLlZZUiMTFt7Csb7QnN9ySDIsEiUze
 0uvBVE/3RZ5+Gr6yTuzzxqK9eK5GBTnKNTxhXM0X5GwApHeHbIS2ZdQHZvytxd07k6PH
 HyLmME1fFz2uVK1KMVwaaCIk7R718B/Oltx01moDlf3ntE7bcTmK7JEhHu0sbWCr+UkA
 Nw0g==
X-Gm-Message-State: ABy/qLb6Cufm9lddXW6g9NExZlPU5wE+cy33S7kccWNG4fToMhz+zZOE
 k1eH5mquovpJJZ5gcoyxqUwP+t07Vk2tzd9QVKLgVdQ/Cu+9NhPIrsNsB0sFe7c9BgUy63aFUR5
 aG99unot4Y6fx4lB8hdKvd3SPCCsoWSs=
X-Received: by 2002:a05:6808:1153:b0:3a3:b058:6c80 with SMTP id
 u19-20020a056808115300b003a3b0586c80mr2959646oiu.0.1690535154627; 
 Fri, 28 Jul 2023 02:05:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFtjo4IRUffpMCoON2BT7qiy1KpgDzpBub8EIIsH7z8DEQXW8oZLf2Nls+2hKtbDr0SHeiq3azZe1P0Xlf4VJ4=
X-Received: by 2002:a05:6808:1153:b0:3a3:b058:6c80 with SMTP id
 u19-20020a056808115300b003a3b0586c80mr2959627oiu.0.1690535154376; Fri, 28 Jul
 2023 02:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230626073426.285659-1-aesteve@redhat.com>
 <20230626073426.285659-4-aesteve@redhat.com>
 <20230710150030-mutt-send-email-mst@kernel.org>
 <CADSE00+MYYeTto5CCROpynB2p+FjcCASp6azyxb2FVRm7VhBrw@mail.gmail.com>
 <20230717100739-mutt-send-email-mst@kernel.org>
 <CADSE00Jm45pbhvWgN8uQGjqZkEZr2UEHV2ARuqWheT-pXL-85Q@mail.gmail.com>
 <20230727105523-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230727105523-mutt-send-email-mst@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 28 Jul 2023 11:05:43 +0200
Message-ID: <CADSE00LXn4-dupxjW_v+BeWKWPeiBmPGof=XBuPNGYij0+t4sA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] vhost-user: add shared_object msg
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, cohuck@redhat.com, 
 Fam Zheng <fam@euphon.net>, kraxel@redhat.com
Content-Type: multipart/alternative; boundary="0000000000005b759706018863b8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
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

--0000000000005b759706018863b8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 4:57=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:

> On Thu, Jul 27, 2023 at 04:48:30PM +0200, Albert Esteve wrote:
> >
> >
> > On Mon, Jul 17, 2023 at 4:11=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com>
> wrote:
> >
> >
> >
> >
> >
> >     On Mon, Jul 17, 2023 at 01:42:02PM +0200, Albert Esteve wrote:
> >     > Hi Michael,
> >     >
> >     > True. It may be a good idea to impose a limit in the number of
> entries
> >     that can
> >     > be added to the table.
> >     > And fail to add new entries once it reaches the limit.
> >     >
> >     > Not sure what would be a good limit though. For example, https://
> >     www.kernel.org
> >     >
> /doc/html/v4.9/media/uapi/v4l/vidioc-reqbufs.html#c.v4l2_requestbuffers
> >     > does not limit the number of buffers that can be allocated
> >     simultaneously, it
> >     > is an unsigned 32-bits value.
> >     > However, I guess 16-bits (65535) would suffice to cover the vast
> majority
> >     of
> >     > usecases. Or even lower, and
> >     > can be adjusted later, as this API gets (more) used.
> >     >
> >     > Does that make sense?
> >     >
> >     > Thanks.
> >     > BR,
> >     > Albert
> >
> >     let's not top-post please.
> >
> >     Maybe. Another concern is qemu running out of FDs with a bad backen=
d.
> >
> >     Question: why does qemu have to maintain these UUIDs in its memory?
> >
> >     Can't it query the backend with UUID and get the fd back?
> >
> >
> > In the end, we have one backend sharing an object with other backends.
> > From the importer POV, it does not know who the exporter is, so it cann=
ot
> > go pocking other backends until it finds the one that is holding a
> resource
> > with
> > the same UUID, it relies on qemu providing this information.
> >
> > If we do not want qemu to hold the fds, we could, for instance, store
> > references to
> > backends that act as exporters. And then, once an importer requests for=
 a
> > specific
> > object with its UUID, we ask for the fd to the exporter(s), hoping to
> find it.
>
>
> right. I'd do this. and then the existing table can be regarded
> as a cache.
>

It is true that it is not easy to find a limit that fits all usecases,
and the cache proposal could result in a more maintanable
solution in the long term.

I'll explore this and post a proposal for the next version
of the patch. It will mean having a bigger changeset, so
I'll try to push something as clean as possible.

BR,
Albert


>
> > But the current solution sounds better fit to the shared objects virtio
> > feature.
> > I would be more keen to look into something like what Gerd suggested,
> limiting
> > the memory that we use.
> >
> > Nonetheless, in qemu we are storing fds, and not mmaping the dmabufs.
> > So I think limiting the number of entries should suffice, to ensure
> > that we do not run out of FDs, and memory.
>
> my point is you really don't know how much to limit it.
> if there's ability to drop the entries then you
> can do this, and cache things in memory.
>
>
> >
> >
> >     And then, the hash table in QEMU becomes just a cache
> >     to speed up lookups.
> >
> >     --
> >     MST
> >
> >
>
>

--0000000000005b759706018863b8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br clear=3D"all"><div><div dir=3D"ltr" c=
lass=3D"gmail_signature"><div dir=3D"ltr"><p style=3D"color:rgb(0,0,0);font=
-family:RedHatText,sans-serif;font-weight:bold;margin:0px;padding:0px;font-=
size:14px"><br></p></div></div></div></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 27, 2023 at 4:57=E2=80=AFP=
M Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 Thu, Jul 27, 2023 at 04:48:30PM +0200, Albert Esteve wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Mon, Jul 17, 2023 at 4:11=E2=80=AFPM Michael S. Tsirkin &lt;<a href=
=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wrote:<=
br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Mon, Jul 17, 2023 at 01:42:02PM +0200, Albert Es=
teve wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Hi Michael,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; True. It may be a good idea to impose a limit =
in the number of entries<br>
&gt;=C2=A0 =C2=A0 =C2=A0that can<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; be added to the table.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; And fail to add new entries once it reaches th=
e limit.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Not sure what would be a good limit though. Fo=
r example,=C2=A0https://<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"http://www.kernel.org" rel=3D"noreferrer=
" target=3D"_blank">www.kernel.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; /doc/html/v4.9/media/uapi/v4l/vidioc-reqbufs.h=
tml#c.v4l2_requestbuffers<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; does not limit the number of buffers that can =
be allocated<br>
&gt;=C2=A0 =C2=A0 =C2=A0simultaneously, it<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; is an unsigned 32-bits value.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; However, I guess 16-bits (65535) would suffice=
 to cover the vast majority<br>
&gt;=C2=A0 =C2=A0 =C2=A0of<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; usecases. Or even lower, and<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; can be adjusted later, as this API gets (more)=
 used.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Does that make sense?<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Thanks.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; BR,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Albert<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0let&#39;s not top-post please.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Maybe. Another concern is qemu running out of FDs w=
ith a bad backend.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Question: why does qemu have to maintain these UUID=
s in its memory?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Can&#39;t it query the backend with UUID and get th=
e fd back?<br>
&gt; <br>
&gt; <br>
&gt; In the end, we have one backend sharing an object with other backends.=
<br>
&gt; From the importer POV, it does not know who the exporter is, so it can=
not<br>
&gt; go pocking other backends until it finds the one that is holding a res=
ource<br>
&gt; with<br>
&gt; the same UUID, it relies on qemu providing this information.<br>
&gt; <br>
&gt; If we do not want qemu to hold the fds, we could, for instance, store<=
br>
&gt; references to<br>
&gt; backends that act as exporters. And then, once an importer requests fo=
r a<br>
&gt; specific<br>
&gt; object with its UUID, we ask for the fd to the exporter(s), hoping to =
find it.<br>
<br>
<br>
right. I&#39;d do this. and then the existing table can be regarded<br>
as a cache.<br></blockquote><div><br></div><div>It is true that it is not e=
asy to find a limit that fits all usecases,</div><div>and the cache proposa=
l could result in a more maintanable</div><div>solution in the long term.</=
div><div><br></div><div>I&#39;ll explore this and post a proposal for the n=
ext version</div><div>of the patch. It will mean having a bigger changeset,=
 so</div><div>I&#39;ll try to push something as clean as possible.</div><di=
v><br></div><div>BR,</div><div>Albert</div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
<br>
&gt; But the current solution sounds better fit to the shared objects virti=
o<br>
&gt; feature.<br>
&gt; I would be more keen to look into something like what Gerd suggested, =
limiting<br>
&gt; the memory that we use.=C2=A0<br>
&gt; <br>
&gt; Nonetheless, in qemu we are storing fds, and not mmaping the dmabufs.<=
br>
&gt; So I think limiting the number of entries should suffice, to ensure<br=
>
&gt; that we do not run out of FDs, and memory.<br>
<br>
my point is you really don&#39;t know how much to limit it.<br>
if there&#39;s ability to drop the entries then you<br>
can do this, and cache things in memory.<br>
<br>
<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0And then, the hash table in QEMU becomes just a cac=
he<br>
&gt;=C2=A0 =C2=A0 =C2=A0to speed up lookups.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0--<br>
&gt;=C2=A0 =C2=A0 =C2=A0MST<br>
&gt; <br>
&gt; <br>
<br>
</blockquote></div></div>

--0000000000005b759706018863b8--


