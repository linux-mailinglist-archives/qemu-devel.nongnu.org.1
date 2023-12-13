Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CBB810B6E
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 08:25:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDJbB-0005tz-Ln; Wed, 13 Dec 2023 02:24:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rDJb4-0005tj-Qy
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 02:23:59 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rDJb2-0002e3-ML
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 02:23:58 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c9f9db9567so75715341fa.3
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 23:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702452234; x=1703057034;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=21Zgw8NGfGrgkRqgfq4N6gO1yc/J7hpG5JqHFsc0b7I=;
 b=PWfLWTbx5aWp8Yq2haDDhDrRDL7BfZjroaEFoPcJVh7cgWcQwPsDfHlhIT78u12fzL
 Reus1YcQvTjEr9rFMzdxOqYOdGwyjZaepCXjgmmx1JHQc05d2HmLLnP/5plyoEJ3oDfi
 Gksar8V2KfwN9ezZqRcmoLYGXjEPBk/B6kLFiACxx7FX77djpLBC8aTUs83f7hMfrQah
 L3B+jBztSRRqYihdJK1FmkDc7qR79TotKx+wHnQ9cg1LvuTqYK8CEZVQ5rIPLJ8JLgrD
 MyxJlv5kck79Ft2fqBqzO3jm88yEDNWdK/vmCF2j17X4IBPpR2j8tKqbD3HQBjHVHX96
 oFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702452234; x=1703057034;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=21Zgw8NGfGrgkRqgfq4N6gO1yc/J7hpG5JqHFsc0b7I=;
 b=uU4UwYH5XE6Xntcnx9ZwOd6+VXIT1EGChlawA+11eMMlP7fpLUnh7VD9xe08RofOgJ
 l1yJEHAggS77tyd1iOy3EyxSNC/xpmeW+W8KUphdWvLjzhN0Oo37TiusVG1RHkg2VOhF
 5Sw2s4PmOzwdliUw8p4Ekjq9Wxum4OKaFqPxT2VxDfSKJzGv7iSGPMZDFTM3mNVcyR57
 pINJHezbUMXaMESetcOxYCJuy0GiAnXfvNrAboEeMVmK0H98wQBRCa5R8ounQGO3QBfs
 v6Mr2+oQ8MQV81wnCzEV6IU42CDtnZHh+hrwbrLaCfqSIT4HM1gjKu0e066IDoJXZaoI
 VvcA==
X-Gm-Message-State: AOJu0Yxf/m6iEV/hidyVS+u365dvb5vHw6yDYxe9d+lVba0JtPzi590P
 /JuSVwaRI8wDlelL9uPYsE57F3QzqOe3Srs1HOJWzw==
X-Google-Smtp-Source: AGHT+IEbFTdFra0jRpcK1AJ9nqS3dUb0QLatNDgW89s5JYoKCWz8xGX46+0LJCZxYCbw/mTYK1RIt5q6HQ9HVAglHgo=
X-Received: by 2002:a2e:a783:0:b0:2cb:2b39:8646 with SMTP id
 c3-20020a2ea783000000b002cb2b398646mr3570651ljf.16.1702452234182; Tue, 12 Dec
 2023 23:23:54 -0800 (PST)
MIME-Version: 1.0
References: <20230831065140.496485-1-andrew@daynix.com>
 <20230831065140.496485-6-andrew@daynix.com>
 <CABcq3pHyiO4AWSzxwWKfUnULfqPGQs1g12MCn14Ms4FqupZAzg@mail.gmail.com>
 <CACGkMEvBEdV1+uxE00hbXuFWmT2+nqgT9JxBezLXBwEX0b9Vbw@mail.gmail.com>
 <CAOEp5OcMo+eZ=k4m7ZKvSLWfngzzaZ6eHMLaiTmZ3CQ_yE2aKw@mail.gmail.com>
 <CACGkMEtFKJovdfi6690uoqH_qJ3mP6K8KDFcOamvC1yOow-Drg@mail.gmail.com>
In-Reply-To: <CACGkMEtFKJovdfi6690uoqH_qJ3mP6K8KDFcOamvC1yOow-Drg@mail.gmail.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Wed, 13 Dec 2023 09:23:42 +0200
Message-ID: <CAOEp5OfrsExfBF4QvxtP7KCVS9tGQMNxZq5kh4j9bwxqYQmjBw@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] ebpf: Updated eBPF program and skeleton.
To: Jason Wang <jasowang@redhat.com>
Cc: Andrew Melnichenko <andrew@daynix.com>, mst@redhat.com, armbru@redhat.com,
 eblake@redhat.com, 
 qemu-devel@nongnu.org, berrange@redhat.com, yan@daynix.com
Content-Type: multipart/alternative; boundary="000000000000aa747f060c5f0c53"
Received-SPF: none client-ip=2a00:1450:4864:20::230;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-lj1-x230.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

--000000000000aa747f060c5f0c53
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 5:33=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:

> On Mon, Dec 11, 2023 at 7:51=E2=80=AFPM Yuri Benditovich
> <yuri.benditovich@daynix.com> wrote:
> >
> > Hello Jason,
> > Can you please let us know what happens with this series?
>
> It should be my bad, it is in V1 of the pull request but missed
> accidentally in V2 of the pull.
>
> I've merged it here,
>
> https://gitlab.com/jasowang/qemu.git


Yes, the merged tree is OK. I see you changed the target version to 8.3
 It looks like no more changes required for the PULL,
 Please let us know if something is needed.

Thanks,
Yuri



>
> Please check if it's correct.
>
> Thanks
>
> >
> > Thanks
> > Yuri
> >
> > On Fri, Sep 8, 2023 at 9:43=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> >>
> >> On Mon, Sep 4, 2023 at 7:23=E2=80=AFPM Andrew Melnichenko <andrew@dayn=
ix.com>
> wrote:
> >> >
> >> > Hi Jason,
> >> > According to our previous conversation, I've added checks to the
> meson script.
> >> > Please confirm that everything is correct
> >>
> >> I've queued this series.
> >>
> >> Thanks
> >>
>
>

--000000000000aa747f060c5f0c53
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 12, 2023 at 5:33=E2=80=AFAM J=
ason Wang &lt;<a href=3D"mailto:jasowang@redhat.com" target=3D"_blank">jaso=
wang@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">On Mon, Dec 11, 2023 at 7:51=E2=80=AFPM Yuri Benditovich<br>
&lt;<a href=3D"mailto:yuri.benditovich@daynix.com" target=3D"_blank">yuri.b=
enditovich@daynix.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hello Jason,<br>
&gt; Can you please let us know what happens with this series?<br>
<br>
It should be my bad, it is in V1 of the pull request but missed<br>
accidentally in V2 of the pull.<br>
<br>
I&#39;ve merged it here,<br>
<br>
<a href=3D"https://gitlab.com/jasowang/qemu.git" rel=3D"noreferrer" target=
=3D"_blank">https://gitlab.com/jasowang/qemu.git</a></blockquote><div><br><=
/div><div>Yes, the merged tree is OK. I see you changed the target version =
to 8.3</div><div>=C2=A0It looks like no more changes required for the PULL,=
</div><div>=C2=A0Please let us know if something is needed.</div><div><br><=
/div><div>Thanks,</div><div>Yuri</div><div><br></div><div><br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex"><br>
<br>
Please check if it&#39;s correct.<br>
<br>
Thanks<br>
<br>
&gt;<br>
&gt; Thanks<br>
&gt; Yuri<br>
&gt;<br>
&gt; On Fri, Sep 8, 2023 at 9:43=E2=80=AFAM Jason Wang &lt;<a href=3D"mailt=
o:jasowang@redhat.com" target=3D"_blank">jasowang@redhat.com</a>&gt; wrote:=
<br>
&gt;&gt;<br>
&gt;&gt; On Mon, Sep 4, 2023 at 7:23=E2=80=AFPM Andrew Melnichenko &lt;<a h=
ref=3D"mailto:andrew@daynix.com" target=3D"_blank">andrew@daynix.com</a>&gt=
; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Hi Jason,<br>
&gt;&gt; &gt; According to our previous conversation, I&#39;ve added checks=
 to the meson script.<br>
&gt;&gt; &gt; Please confirm that everything is correct<br>
&gt;&gt;<br>
&gt;&gt; I&#39;ve queued this series.<br>
&gt;&gt;<br>
&gt;&gt; Thanks<br>
&gt;&gt;<br>
<br>
</blockquote></div></div>

--000000000000aa747f060c5f0c53--

