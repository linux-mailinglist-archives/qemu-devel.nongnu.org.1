Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D852765719
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 17:13:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP2IS-0007ea-2M; Thu, 27 Jul 2023 10:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qP2IM-0007eQ-V0
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 10:48:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qP2IK-0004h9-Fz
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 10:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690469326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tjvLWj5Df0gei6C/oFm2OBfyPp3/2c60N7P7mUNXKCg=;
 b=hJNZZv78L2xsv9nCu5D5uXqhWwmyVdDt+sb7WnWiIQr+3tKxFpoAyFZpLA6vHmYRBBCNVT
 oGMoufuR1+8sTRJ9yMNBn5cGpvlnS/wi9yrFM+Hv/aB9G7wM8KtsEnBfCUL8cTYj8fUqK+
 SWiZ5qOBlgOk4hWyEIfcSjDtG5f6+ww=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-W1V-c18iNdaJvL7_J1XqKQ-1; Thu, 27 Jul 2023 10:48:42 -0400
X-MC-Unique: W1V-c18iNdaJvL7_J1XqKQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-267f18688efso912702a91.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 07:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690469322; x=1691074122;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tjvLWj5Df0gei6C/oFm2OBfyPp3/2c60N7P7mUNXKCg=;
 b=bhKbvGZ2XK+i1kCTC7C6WW57OOXZC7aad37nl29UT/5mckUceaYZEtymnK3nme81c6
 Io0P2ynbQKQhCbtCcsBJc20R7CQjJElsMcmZnF/7eZt7wMbggv8pzvpn/aHrI0CXcFdV
 5/m9MkwrzseL0NuFOKg6+N3hhrGzP29ymHvBTZtxGK8sZ9OjJYwTLm64mhRjoFmQgvIy
 I29rsEE3xNVlgfyJEXEWsy8naBTBObOPXQ+VKIQiM8tWmYDYmsdMlvGc9gqUspaTs2rl
 qZt0EC4RJZLLkEDZ21u7OFcGL5QQXbjkv7HgGnW7Mjk3Jn08YOLMzuyT+NM/qEgRGEF6
 POPg==
X-Gm-Message-State: ABy/qLa+gWED53eSV9a+XQ0VfEmfcWYPgKl3GGk78DrZL6z6qF0OTR3E
 AKlOriB7xqugTMtzkaX1VFfZlUyWYlFLjMzz4nzmVCZfW6ZS5flXMIr/veJMmdyHpJWjfsOnBlx
 EGCU1OBuG57A0vT4TPUojCA3b5UaodGc=
X-Received: by 2002:a17:90b:2394:b0:262:fe45:860b with SMTP id
 mr20-20020a17090b239400b00262fe45860bmr5280118pjb.0.1690469321676; 
 Thu, 27 Jul 2023 07:48:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEwME5oup10zhtyMJDZE6tVQyQYMIwC6yURZMFoniT9GKWR8A421oAjvhp96Eo7VQ1ov7m24ZPGDEayrP7Rl0I=
X-Received: by 2002:a17:90b:2394:b0:262:fe45:860b with SMTP id
 mr20-20020a17090b239400b00262fe45860bmr5280095pjb.0.1690469321264; Thu, 27
 Jul 2023 07:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230626073426.285659-1-aesteve@redhat.com>
 <20230626073426.285659-4-aesteve@redhat.com>
 <20230710150030-mutt-send-email-mst@kernel.org>
 <CADSE00+MYYeTto5CCROpynB2p+FjcCASp6azyxb2FVRm7VhBrw@mail.gmail.com>
 <20230717100739-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230717100739-mutt-send-email-mst@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 27 Jul 2023 16:48:30 +0200
Message-ID: <CADSE00Jm45pbhvWgN8uQGjqZkEZr2UEHV2ARuqWheT-pXL-85Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] vhost-user: add shared_object msg
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, cohuck@redhat.com, 
 Fam Zheng <fam@euphon.net>, kraxel@redhat.com
Content-Type: multipart/alternative; boundary="00000000000065e9330601790f16"
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

--00000000000065e9330601790f16
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2023 at 4:11=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:

>
>
>
>
> On Mon, Jul 17, 2023 at 01:42:02PM +0200, Albert Esteve wrote:
> > Hi Michael,
> >
> > True. It may be a good idea to impose a limit in the number of entries
> that can
> > be added to the table.
> > And fail to add new entries once it reaches the limit.
> >
> > Not sure what would be a good limit though. For example,
> https://www.kernel.org
> > /doc/html/v4.9/media/uapi/v4l/vidioc-reqbufs.html#c.v4l2_requestbuffers
> > does not limit the number of buffers that can be allocated
> simultaneously, it
> > is an unsigned 32-bits value.
> > However, I guess 16-bits (65535) would suffice to cover the vast
> majority of
> > usecases. Or even lower, and
> > can be adjusted later, as this API gets (more) used.
> >
> > Does that make sense?
> >
> > Thanks.
> > BR,
> > Albert
>
> let's not top-post please.
>
> Maybe. Another concern is qemu running out of FDs with a bad backend.
>
> Question: why does qemu have to maintain these UUIDs in its memory?
>
> Can't it query the backend with UUID and get the fd back?
>

In the end, we have one backend sharing an object with other backends.
From the importer POV, it does not know who the exporter is, so it cannot
go pocking other backends until it finds the one that is holding a resource
with
the same UUID, it relies on qemu providing this information.

If we do not want qemu to hold the fds, we could, for instance, store
references to
backends that act as exporters. And then, once an importer requests for a
specific
object with its UUID, we ask for the fd to the exporter(s), hoping to find
it.

But the current solution sounds better fit to the shared objects virtio
feature.
I would be more keen to look into something like what Gerd suggested,
limiting
the memory that we use.

Nonetheless, in qemu we are storing fds, and not mmaping the dmabufs.
So I think limiting the number of entries should suffice, to ensure
that we do not run out of FDs, and memory.


>
> And then, the hash table in QEMU becomes just a cache
> to speed up lookups.
>
> --
> MST
>
>

--00000000000065e9330601790f16
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 17, 2023 at 4:11=
=E2=80=AFPM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@re=
dhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><br>
<br>
<br>
<br>
On Mon, Jul 17, 2023 at 01:42:02PM +0200, Albert Esteve wrote:<br>
&gt; Hi Michael,<br>
&gt; <br>
&gt; True. It may be a good idea to impose a limit in the number of entries=
 that can<br>
&gt; be added to the table.<br>
&gt; And fail to add new entries once it reaches the limit.<br>
&gt; <br>
&gt; Not sure what would be a good limit though. For example,=C2=A0<a href=
=3D"https://www.kernel.org" rel=3D"noreferrer" target=3D"_blank">https://ww=
w.kernel.org</a><br>
&gt; /doc/html/v4.9/media/uapi/v4l/vidioc-reqbufs.html#c.v4l2_requestbuffer=
s<br>
&gt; does not limit the number of buffers that can be allocated simultaneou=
sly, it<br>
&gt; is an unsigned 32-bits value.<br>
&gt; However, I guess 16-bits (65535) would suffice to cover the vast major=
ity of<br>
&gt; usecases. Or even lower, and<br>
&gt; can be adjusted later, as this API gets (more) used.<br>
&gt; <br>
&gt; Does that make sense?<br>
&gt; <br>
&gt; Thanks.<br>
&gt; BR,<br>
&gt; Albert<br>
<br>
let&#39;s not top-post please.<br>
<br>
Maybe. Another concern is qemu running out of FDs with a bad backend.<br>
<br>
Question: why does qemu have to maintain these UUIDs in its memory?<br>
<br>
Can&#39;t it query the backend with UUID and get the fd back?<br></blockquo=
te><div><br></div><div>In the end, we have one backend sharing an object wi=
th other backends.</div><div>From the importer POV, it does not know who th=
e exporter is, so it cannot</div><div>go pocking other backends until it fi=
nds the one that is holding a resource with</div><div>the same UUID, it rel=
ies on qemu providing this information.</div><div><br></div><div>If we do n=
ot want qemu to hold the fds, we could, for instance, store references to</=
div><div>backends that act as exporters. And then, once an importer request=
s for a specific</div><div>object with its UUID, we ask for the fd to the e=
xporter(s), hoping to find it.</div><div><br></div><div>But the current sol=
ution sounds better fit to the shared objects virtio feature.</div><div>I w=
ould be more keen to look into something like what Gerd suggested, limiting=
</div><div>the memory that we use.=C2=A0</div><div><br></div><div>Nonethele=
ss, in qemu we are storing fds, and not mmaping the dmabufs.</div><div>So I=
 think limiting the number of entries should suffice, to ensure</div><div>t=
hat we do not run out of FDs, and memory.</div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
<br>
And then, the hash table in QEMU becomes just a cache<br>
to speed up lookups.<br>
<br>
-- <br>
MST<br>
<br>
</blockquote></div></div>

--00000000000065e9330601790f16--


