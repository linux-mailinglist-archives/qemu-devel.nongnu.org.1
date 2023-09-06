Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9082E79387D
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 11:40:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdp0V-0001ZG-JG; Wed, 06 Sep 2023 05:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qdp0Q-0001UU-KS
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:39:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qdp0O-00020R-5c
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693993162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sFvvF3kxrlURkIX/sYTTEmWgywT5VGmuhY+QMQ/4sfM=;
 b=ToKHmWSfuCzfBrq9RB4VZ50C02Xt1Kgli/5PEGImNtnvPMHk3ZQeA8ww8BVbx6DetT/bMl
 DwF6IIBfFY8BrT/HVqCBoC6mA5tvGFiEkJZbm6VxqJ/YunIR2r4hPg87RdoTttg6OPav0J
 EttZ5/VrNIHApy+4zLLgLDIwKhm+w28=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-wnGTZk45Px2WlEjjGGTL6w-1; Wed, 06 Sep 2023 05:39:20 -0400
X-MC-Unique: wnGTZk45Px2WlEjjGGTL6w-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-570096f51acso861224a12.0
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 02:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693993159; x=1694597959;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sFvvF3kxrlURkIX/sYTTEmWgywT5VGmuhY+QMQ/4sfM=;
 b=E8GcqNUUJNquwgPeY9qB9NbYGKY1zu7cdkjrmoeFLNfQgdPaNWHiEcNcnP48xeNx36
 Ls6NB6Vg6L794Qe7xFN/J8uVUuPN/tppaKHcieSl0qGn6I2F1zDSDLT0oTmjlsHW8NCA
 6OUNocnlRl8P+EK4abL82qZbnjw/77r+86W4XAxPrF0T6V+zBeAnl3D+DsQEtGdzqXuD
 ZywCKltwxQUF0OC/Jq3QSxPbKVRrtMXoWgxrYpMytZPYda9I5dLZQYMJvhiixqDpYCmX
 HOJmgwDAef6E4wnYduOnCE4sduc0/rjvfnRaKVraPMOO1JxVrMujy+KL//CbbnOkwogO
 e5MQ==
X-Gm-Message-State: AOJu0YyaikolWNNdZyHWPtxlz0s6vZw8oVEBl1nP8IGL6Nn1GHCBprtU
 VtuG+DGfuDRa0DKfW77xve+0yUHhjUFN0YhA8yMJpgtJt9q6zT0a+hQ7XmVNLVwEPNvoW/qqjPm
 Qvi04FSWkVnKsIz48wFEufVPv++6caeI=
X-Received: by 2002:a05:6a20:dd88:b0:14c:7b5d:1fe0 with SMTP id
 kw8-20020a056a20dd8800b0014c7b5d1fe0mr15539797pzb.3.1693993159357; 
 Wed, 06 Sep 2023 02:39:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQxWtZw182ibMvxIOyq1a+SrmUm6kO0zJHCcGKt2xXmhWygLHe7GT9+JT3BQESaupAG4JgEGO0N87A2syEUqs=
X-Received: by 2002:a05:6a20:dd88:b0:14c:7b5d:1fe0 with SMTP id
 kw8-20020a056a20dd8800b0014c7b5d1fe0mr15539777pzb.3.1693993159012; Wed, 06
 Sep 2023 02:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230802090824.91688-1-aesteve@redhat.com>
 <CADSE00JRMvQ6Ye445xon0GoCDSsp7oAY_B--rABooabMTraoaQ@mail.gmail.com>
 <20230905164451-mutt-send-email-mst@kernel.org>
 <2b6df154-de47-ab4c-d315-a541935d1276@linaro.org>
In-Reply-To: <2b6df154-de47-ab4c-d315-a541935d1276@linaro.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 6 Sep 2023 11:39:07 +0200
Message-ID: <CADSE00LRBomBNM9tKRgaRH_T7Xj6p9_Nz2y1mNFF_AZ8ivQbfA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Virtio shared dma-buf
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 marcandre.lureau@gmail.com, 
 kraxel@redhat.com, cohuck@redhat.com, Fam Zheng <fam@euphon.net>
Content-Type: multipart/alternative; boundary="0000000000007ecb730604ad84be"
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

--0000000000007ecb730604ad84be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 6, 2023 at 8:13=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> Hi Michael,
>
> On 5/9/23 22:45, Michael S. Tsirkin wrote:
> > I was hoping for some acks from Gerd or anyone else with a clue
> > about graphics, but as that doesn't seem to happen I'll merge.
> > Thanks!
>
> I made few late comments. Patch #3 doesn't build (thus
> break git-bisections). I also have some concern about locking.
> I'd rather see a v6, do you mind dropping v5 from your queue?
>
> Thanks,
>
> Phil.
>

I have the v6 ready. I will wait for Michael response and post it,
to ensure that I do not step on his toes.
Thank you both!


>
> > On Mon, Aug 21, 2023 at 02:37:56PM +0200, Albert Esteve wrote:
> >> Hi all,
> >>
> >> A little bump for this patch, sorry for the extra noise.
> >>
> >> Regards,
> >> Albert
>
>

--0000000000007ecb730604ad84be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 6, 2023 at 8:13=
=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro=
.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">Hi Michael,<br>
<br>
On 5/9/23 22:45, Michael S. Tsirkin wrote:<br>
&gt; I was hoping for some acks from Gerd or anyone else with a clue<br>
&gt; about graphics, but as that doesn&#39;t seem to happen I&#39;ll merge.=
<br>
&gt; Thanks!<br>
<br>
I made few late comments. Patch #3 doesn&#39;t build (thus<br>
break git-bisections). I also have some concern about locking.<br>
I&#39;d rather see a v6, do you mind dropping v5 from your queue?<br>
<br>
Thanks,<br>
<br>
Phil.<br></blockquote><div><br></div><div>I have the v6 ready. I will wait =
for Michael response and post it,</div><div>to ensure that I do not step on=
 his toes.</div><div>Thank=C2=A0you both!</div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
<br>
&gt; On Mon, Aug 21, 2023 at 02:37:56PM +0200, Albert Esteve wrote:<br>
&gt;&gt; Hi all,<br>
&gt;&gt;<br>
&gt;&gt; A little bump for this patch, sorry for the extra noise.<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Albert<br>
<br>
</blockquote></div></div>

--0000000000007ecb730604ad84be--


