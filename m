Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 968E6812CC1
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 11:18:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDinL-0003Us-9r; Thu, 14 Dec 2023 05:18:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rDinJ-0003T4-Cz
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 05:18:17 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rDin8-0002qE-Mq
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 05:18:17 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c9f559b82cso91169881fa.0
 for <qemu-devel@nongnu.org>; Thu, 14 Dec 2023 02:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702549084; x=1703153884;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YXuVJ8iopwawqaabjGPgfitOuptt5U0TaeiTThyJmmM=;
 b=1JVRmaLULTYGkohXR5eAhtuggjlpr6uQgJuYKN8/K6H5jw04n+DRPOHiDpV9PXFwkY
 FVYQiESHvFkQ2zhSlzMyNyrlENER4OfQemK/zo+2vq+PsuGRUb7ylsQWEWCFrBuQap12
 a+ORXvj443+MOEFglBiMB8wP09C2YCGec+q7Rl45vXNOtsJ6AqAnvFj4I6hVMJAuoZTj
 ay766OCVX2QESCZf6Z5NsW8kecbFewdkb/yXu+IAfz6iZeoJDpLTCQ1owbNbw8Fygu9Z
 ODr9P0KZiu6lSs2w9CKmISIghiSKO6oOICwJ/+aNrSw3Pg7toOVR/2Srj0omFdh1T4rU
 BFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702549084; x=1703153884;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YXuVJ8iopwawqaabjGPgfitOuptt5U0TaeiTThyJmmM=;
 b=oHdzV1ey3Xa3IUzNW49qI0/5D+634ACn30wRvI8wraMEfh57nwWuFmwPHcbfqu6DyT
 8xDMk9kK1Kw5LyMKh3kFhCh5+fDPru3MQukEvLsHkTO7KtzzthRtIve79Fi8n4+A9Bck
 MKDF+zXfyvbrlau3hmy3f4EKbGoy0zx7rKYAF22tTkBFSYrAU4ECrYaMHbk5c1NoiLJP
 JLSkA4TR2H2CjrwNwQXepJ5H+9Lt/THMon3AmbiUsZTJkfb4CIV4y6qfeYKYiQqyWylW
 oZbJYJ/TEmdoBmrDIOhPIMEZiyrWndfGma9uiGt1sXAegLOh9e9xAu+8DpZyV48EWL2E
 9bHg==
X-Gm-Message-State: AOJu0YyzUu5wjK+U2PWMrUWT7BIdPVWSRFLuYFChfVM1V/jmTCVAqVGm
 CBpxnX39DUYIaw+EMYOJGLWNDaQt9FyujB1m7izC4A==
X-Google-Smtp-Source: AGHT+IHjR3OnAG6N+ry7jc/txUvO8qBmivWfNV/iW4WEiFsIzPFDA0tfNL3hxeNxGyhpZQMKN9TxJ5C9H8Uet09wGkc=
X-Received: by 2002:a05:651c:211a:b0:2cb:2bb4:fd4f with SMTP id
 a26-20020a05651c211a00b002cb2bb4fd4fmr3955935ljq.23.1702549083780; Thu, 14
 Dec 2023 02:18:03 -0800 (PST)
MIME-Version: 1.0
References: <20230831065140.496485-1-andrew@daynix.com>
 <20230831065140.496485-6-andrew@daynix.com>
 <CABcq3pHyiO4AWSzxwWKfUnULfqPGQs1g12MCn14Ms4FqupZAzg@mail.gmail.com>
 <CACGkMEvBEdV1+uxE00hbXuFWmT2+nqgT9JxBezLXBwEX0b9Vbw@mail.gmail.com>
 <CAOEp5OcMo+eZ=k4m7ZKvSLWfngzzaZ6eHMLaiTmZ3CQ_yE2aKw@mail.gmail.com>
 <CACGkMEtFKJovdfi6690uoqH_qJ3mP6K8KDFcOamvC1yOow-Drg@mail.gmail.com>
 <CAOEp5OfrsExfBF4QvxtP7KCVS9tGQMNxZq5kh4j9bwxqYQmjBw@mail.gmail.com>
In-Reply-To: <CAOEp5OfrsExfBF4QvxtP7KCVS9tGQMNxZq5kh4j9bwxqYQmjBw@mail.gmail.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 14 Dec 2023 12:17:52 +0200
Message-ID: <CAOEp5OchOVu7YSeHG2Au_S4HHf0U0H8Jdit-U+X_VcAP0z=7GA@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] ebpf: Updated eBPF program and skeleton.
To: Jason Wang <jasowang@redhat.com>
Cc: Andrew Melnichenko <andrew@daynix.com>, mst@redhat.com, armbru@redhat.com,
 eblake@redhat.com, 
 qemu-devel@nongnu.org, berrange@redhat.com, yan@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: multipart/alternative; boundary="0000000000005a0a3f060c7599f7"
Received-SPF: none client-ip=2a00:1450:4864:20::233;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-lj1-x233.google.com
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

--0000000000005a0a3f060c7599f7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jason,
As we anyway missed the timeframe of 8.2 please remove this v7 series from
the pull, we will send v8 in which we want to take in account most of
Akihiko comments (especially DEFINE_PROP_ARRAY and naming of the
properties).

Thank you very much

Yuri

On Wed, Dec 13, 2023 at 9:23=E2=80=AFAM Yuri Benditovich <
yuri.benditovich@daynix.com> wrote:

>
> On Tue, Dec 12, 2023 at 5:33=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
>
>> On Mon, Dec 11, 2023 at 7:51=E2=80=AFPM Yuri Benditovich
>> <yuri.benditovich@daynix.com> wrote:
>> >
>> > Hello Jason,
>> > Can you please let us know what happens with this series?
>>
>> It should be my bad, it is in V1 of the pull request but missed
>> accidentally in V2 of the pull.
>>
>> I've merged it here,
>>
>> https://gitlab.com/jasowang/qemu.git
>
>
> Yes, the merged tree is OK. I see you changed the target version to 8.3
>  It looks like no more changes required for the PULL,
>  Please let us know if something is needed.
>
> Thanks,
> Yuri
>
>
>
>>
>> Please check if it's correct.
>>
>> Thanks
>>
>> >
>> > Thanks
>> > Yuri
>> >
>> > On Fri, Sep 8, 2023 at 9:43=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
>> >>
>> >> On Mon, Sep 4, 2023 at 7:23=E2=80=AFPM Andrew Melnichenko <andrew@day=
nix.com>
>> wrote:
>> >> >
>> >> > Hi Jason,
>> >> > According to our previous conversation, I've added checks to the
>> meson script.
>> >> > Please confirm that everything is correct
>> >>
>> >> I've queued this series.
>> >>
>> >> Thanks
>> >>
>>
>>

--0000000000005a0a3f060c7599f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jason,<div>As we anyway missed the timeframe=C2=A0of 8.=
2 please remove this v7 series from the pull, we will send v8 in which we w=
ant to take in account most of Akihiko comments (especially DEFINE_PROP_ARR=
AY and naming of the properties).</div><div><br></div><div>Thank you very m=
uch</div><div><br></div><div>Yuri</div></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 13, 2023 at 9:23=E2=80=
=AFAM Yuri Benditovich &lt;<a href=3D"mailto:yuri.benditovich@daynix.com" t=
arget=3D"_blank">yuri.benditovich@daynix.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"lt=
r"></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_att=
r">On Tue, Dec 12, 2023 at 5:33=E2=80=AFAM Jason Wang &lt;<a href=3D"mailto=
:jasowang@redhat.com" target=3D"_blank">jasowang@redhat.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, Dec 11, =
2023 at 7:51=E2=80=AFPM Yuri Benditovich<br>
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
</blockquote></div>

--0000000000005a0a3f060c7599f7--

