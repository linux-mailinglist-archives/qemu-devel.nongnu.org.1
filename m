Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AD380DB23
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 20:53:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCmKQ-0001jh-8t; Mon, 11 Dec 2023 14:52:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rCmKN-0001hk-JX
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 14:52:31 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rCmKL-0004Lb-T6
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 14:52:31 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c9f72176cfso60454281fa.2
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 11:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702324347; x=1702929147;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2zFIxvkP4hxs2GTNheY8VbxTVqweL8wZ1UJ5TyovCN0=;
 b=fjqWf4JXk9r7+T4SvCQolzxbBKXbcjwT8F0w7aSicd1G9p22zHKJdISWDAo/q9iO/Q
 PAM8UsemlrNFloseZx61vYnKDODcyK3v+CUCcNpRHP3xJL6KiXlSP233hX/h+A4q7vNJ
 kyn78gJ8En987IqHbo4Dtv+S7yljFhuWX97+Ef5vWgnqlcpiN6x4Rmh5ZZgBxcr8nIB4
 L6WdRm8mUUhJHiaP4h6uiv+p1ytOcTiX+3PMFPAYqhmBisXf+nPMhdCGxBHvDmRKnQyE
 +TJsfu38uijss+PmB/R+V1INX1gTZXRLxQcerhj9BkDX6iyQ9YGT/oX7zXU918MkuyOE
 lPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702324347; x=1702929147;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2zFIxvkP4hxs2GTNheY8VbxTVqweL8wZ1UJ5TyovCN0=;
 b=tetu/mrbsX4VUBkyTQNemsuwcDLQAA8LPvmggegL+PTXjdLkEf98ZeJx3Y0pf4VgOb
 PFaTu4QplfujaoeI6JJ6zoScyxSrQgOrkHhTwfob4H4lcXMMibbsfyIUrWzgfJEJ9anJ
 n0y+8nK8cUl+7Ku2YEaCdQHTwXeo4IaJYBTtEuuk86XsUNIsLMabjGCL506ys3VvQQ01
 1UKucXrpKbq/Q2Cr72VHVL5xfqaE2M0qsU/oRZhYtJ1VmWCK8b0fbvuERb/feR/e7ane
 tENLVvi08lZ8Os/hGJtoJPBK+LvizE0ln8Ne1rFLzZN4aXK9xy5CHWC/1isBZYMfgBhU
 FKJQ==
X-Gm-Message-State: AOJu0YyqsEOUlkY83d37NcbDWE/YrIijwvWhF1UvWd32//gBUA7LL+5P
 C2rK7Dd7H4zEmfS1D1G+cRx1Q0kjXIGi+6/QbRO8Sg==
X-Google-Smtp-Source: AGHT+IHifw7YAzsSR57/OT2WSpLxgQQ35KmXpVY/TSRBRTCqxIpyGpTiHDr33bhkt3U21v4t/i3/Xf2em/eh2lxpudA=
X-Received: by 2002:a2e:ab09:0:b0:2cc:1ea3:6855 with SMTP id
 ce9-20020a2eab09000000b002cc1ea36855mr966459ljb.75.1702324347092; Mon, 11 Dec
 2023 11:52:27 -0800 (PST)
MIME-Version: 1.0
References: <20231210-rss-v8-0-9553ee714d38@daynix.com>
 <CAOEp5Ofj+a2rqGWw=oLXBqrXqUj6XRc=Je3ScaE5sxZFzaAOdA@mail.gmail.com>
 <431e5902-970b-4fd5-8302-dcc9c4c76bd7@daynix.com>
 <CAOEp5OcW1xrr8EVeiRqQ5OnecxB6xtKJt6hLCqz6GgmSg7CctQ@mail.gmail.com>
 <20231211104224-mutt-send-email-mst@kernel.org>
 <CAOEp5OfKnE=qna1FRHqg4y=6Fc=J6U57J3pryV-JBB6TiC-6Hg@mail.gmail.com>
In-Reply-To: <CAOEp5OfKnE=qna1FRHqg4y=6Fc=J6U57J3pryV-JBB6TiC-6Hg@mail.gmail.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 11 Dec 2023 21:52:15 +0200
Message-ID: <CAOEp5Oe5sxCzn6XeWSdzYFQbKoh+ey88dA2iu=5DNZA-EZdOiA@mail.gmail.com>
Subject: Re: [PATCH v8 00/19] virtio-net RSS/hash report fixes and improvements
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Luigi Rizzo <rizzo@iet.unipi.it>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>, qemu-devel@nongnu.org, 
 "Zhang, Chen" <chen.zhang@intel.com>, Michael Tokarev <mjt@tls.msk.ru>
Content-Type: multipart/alternative; boundary="000000000000005616060c4146c7"
Received-SPF: none client-ip=2a00:1450:4864:20::22d;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-lj1-x22d.google.com
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

--000000000000005616060c4146c7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm adding also Yan

On Mon, Dec 11, 2023 at 9:51=E2=80=AFPM Yuri Benditovich <
yuri.benditovich@daynix.com> wrote:

> Hi Michael,
> Sure, I've reviewed that also, there was a fruitful discussion
> till the series r=D0=B5=D0=B0ched its final form.
> At the beginning of September we've got the response from Jason that the
> series is queued upstream so we were calm and switched to libvirt part ))
>
> Seems like a misunderstanding, let's wait for Jason response.
>
> Thanks,
> Yuri
>
>
>
>
> On Mon, Dec 11, 2023 at 5:43=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
>
>> On Mon, Dec 11, 2023 at 02:34:56PM +0200, Yuri Benditovich wrote:
>> > https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg05859.html
>>
>> It's from August, I think it's fair to say it's not going upstream
>> unless there's some activity. Yuri did you review that series then?
>> Care to ack?
>>
>> --
>> MST
>>
>>

--000000000000005616060c4146c7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;m adding also Yan</div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 11, 2023 at 9:51=E2=80=
=AFPM Yuri Benditovich &lt;<a href=3D"mailto:yuri.benditovich@daynix.com">y=
uri.benditovich@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex"><div dir=3D"ltr">Hi=C2=A0Michael,<div>Sure, I&#39=
;ve reviewed that also, there was a fruitful=C2=A0discussion till=C2=A0the=
=C2=A0series r=D0=B5=D0=B0ched its final form.</div><div>At the beginning o=
f September we&#39;ve got the response from Jason that the series is queued=
 upstream so we were calm and switched to libvirt part ))</div><div><br></d=
iv><div>Seems like a misunderstanding,=C2=A0let&#39;s wait for Jason respon=
se.</div><div><br></div><div>Thanks,</div><div>Yuri</div><div><br></div><di=
v><br></div><div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">On Mon, Dec 11, 2023 at 5:43=E2=80=AFPM Michael =
S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On Mon, Dec 11, 2023 at 02:34:56PM +0200, Yuri Benditovich wrote:<br>
&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg05=
859.html" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/archiv=
e/html/qemu-devel/2023-08/msg05859.html</a><br>
<br>
It&#39;s from August, I think it&#39;s fair to say it&#39;s not going upstr=
eam<br>
unless there&#39;s some activity. Yuri did you review that series then?<br>
Care to ack?<br>
<br>
-- <br>
MST<br>
<br>
</blockquote></div>
</blockquote></div>

--000000000000005616060c4146c7--

