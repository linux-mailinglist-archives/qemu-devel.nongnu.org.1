Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 069CB7B6F3F
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:07:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnir9-0005F6-3l; Tue, 03 Oct 2023 13:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qniqw-0005DF-87
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:06:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qniqd-0002Q6-1B
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696352772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jR0hFI249lrWQKKqipgoaUdSfR3gpsSHL33Rfe4lKOc=;
 b=IbatT5EtyF3kGmd68WI/xJU2KWm/uF4umz1L9x9wMwgI3qrfZWOliVUQH9hn1AEdhuY0y6
 CbwIZHfbbDBYdzgTMzn8DRlnQGrnhwBWPVGUmNBjtzFbidd6+OqtU3Xz8YhU1gRn/VlpBz
 ijp+tKCEtQJDRcQxOLI++LyyhPBgE9g=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-tbV1hcfONl273yo0fTcXRQ-1; Tue, 03 Oct 2023 13:06:00 -0400
X-MC-Unique: tbV1hcfONl273yo0fTcXRQ-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3af5fca6527so1716364b6e.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:06:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696352759; x=1696957559;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jR0hFI249lrWQKKqipgoaUdSfR3gpsSHL33Rfe4lKOc=;
 b=lZHc6iVxsCiNsXqV9dwgPdeEOSgahQctfifN5HdNFt8gYqWaMiHO/Ci5ZWkK8raMr5
 rqBSBsR7RT/rZQ5IQmj+OlvKFSNM/ifW8GDwzzhNQY07loU03olXDOoMTwdUnvrVNArT
 nRJe7nWXsGbPmqQYQpOaPY5sqrW33sSIef80In73pkCI4BwK253YgwEYYoV0j7/PckZd
 k8rMZ8ZJtGLU9Ok5Zemiy0bBztuQ/7WADFcxfs4b+fCR2Cq6NSaawDv+Px2OW6BPv8Mz
 Khb7z+3MyvxdDPSNpxLmjDrpJWWHmhKu60TNzUdkMfjLs1M2sRtp3apL6cbhStRA/y2k
 luYQ==
X-Gm-Message-State: AOJu0YwsZ6DHp0QGPOFbYxP3DooXUMHQX4kdDhAT/5hJcsdyy5xn+IXE
 mh8uqUnOrCDVIGgwLeJ1OUOhfYONyH8mN9gHyv4JJL5OMna2LUB/B7JSgLrxH97xw+ORPJIuf+W
 54PBARjw71iolDTzJhvArUiZXxXZyCx8=
X-Received: by 2002:a05:6808:1913:b0:3a7:1e3e:7f97 with SMTP id
 bf19-20020a056808191300b003a71e3e7f97mr270715oib.4.1696352759566; 
 Tue, 03 Oct 2023 10:05:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMaQ+K6JLvcW6rhJ7nq9cTSHLeYShtvzwcJtTH9divn3M5WJ0rMbx9DWAupkLYZxFNPTXYFEyhMZf57OIG/GY=
X-Received: by 2002:a05:6808:1913:b0:3a7:1e3e:7f97 with SMTP id
 bf19-20020a056808191300b003a71e3e7f97mr270698oib.4.1696352759332; Tue, 03 Oct
 2023 10:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230921160712.99521-1-simon.rowe@nutanix.com>
 <20230921160712.99521-2-simon.rowe@nutanix.com>
 <CAFn=p-YL_hmnrFY9hhuMgMkV4hL3dojMMWUdG9=DBGYuxi_TUw@mail.gmail.com>
 <ZRwf3rInMRkzD/sq@x1-carbon>
In-Reply-To: <ZRwf3rInMRkzD/sq@x1-carbon>
From: John Snow <jsnow@redhat.com>
Date: Tue, 3 Oct 2023 13:05:47 -0400
Message-ID: <CAFn=p-bmMxJmVj8v31NsRpQd3bHd5zeeRbxQj6bDxUC8Tqh4CQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/ide/core: terminate in-flight DMA on IDE bus reset
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, 
 Fiona Ebner <f.ebner@proxmox.com>, Simon Rowe <simon.rowe@nutanix.com>, 
 Felipe Franciosi <felipe@nutanix.com>
Content-Type: multipart/alternative; boundary="000000000000a25b930606d2e72b"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000a25b930606d2e72b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 3, 2023, 10:07 AM Niklas Cassel <Niklas.Cassel@wdc.com> wrote:

> On Mon, Sep 25, 2023 at 03:53:23PM -0400, John Snow wrote:
> > Niklas, I'm sorry to lean on you here a little bit - You've been
> > working on the SATA side of this a bit more often, can you let me know
> > if you think this patch is safe?
>
> FWIW, I prefer Fiona's patch series which calls blk_aio_cancel() before
> calling ide_reset():
>
> https://lore.kernel.org/qemu-devel/20230906130922.142845-1-f.ebner@proxmo=
x.com/T/#u
>
> Patch 2/2 also adds a qtest which fails before patch 1/2, and passes afte=
r
> patch 1/2.
>

I think I also prefer Fiona's patch. Simon makes a good point (I think)
that it feels correct to dump the DMA as fast as possible, but Fiona's
patch seems more justifiably and obviously correct.

I think my preference is for Fiona's patches first, and if we want to
optimize cancellation thereafter we can attempt to do so.


>
> >
> > I'm not immediately sure what the impact of applying it is, but I have
> > some questions about it:
> >
> > (1) When does ide_dma_cb get invoked when DRQ_STAT is set but the
> > return code we were passed is not < 0, and
> >
> > (2) what's the impact of just *not* executing the end-of-transfer
> > block here; what happens to the state machine?
> >
> > On Thu, Sep 21, 2023 at 12:07=E2=80=AFPM Simon Rowe <simon.rowe@nutanix=
.com>
> wrote:
> > >
> > > When an IDE controller is reset, its internal state is being cleared
> > > before any outstanding I/O is cancelled. If a response to DMA is
> > > received in this window, the aio callback will incorrectly continue
> > > with the next part of the transfer (now using sector 0 from
> > > the cleared controller state).
> >
> > Eugh, yikes. It feels like we should fix the cancellation ... I'm
> > worried that if we've reset the state machine and we need to bail on a
> > DMA callback that the heuristics we use for that will eventually be
> > wrong, unless I am mistaken and this is totally safe and reliable for
> > a reason I don't intuitively see right away.
> >
> > Thoughts?
>
> Since Simon has a reliable reproducer, and has offered to test Fiona's
> patch,
> perhaps we should simply take him up on that offer :)
>

Yes! I just wanted to understand the differences between the two approaches
since it looked like it was going to be my job to decide between them =F0=
=9F=98=85

Simon, can you confirm that Fiona's patches are appropriate for your
reproducer? In the meantime I'll do my own audit for the problem as you
described it (thank you very much for that) and see if there's anything
else that needs to be addressed.


>
> Kind regards,
> Niklas


Thank you everyone.

--js

--000000000000a25b930606d2e72b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Oct 3, 2023, 10:07 AM Niklas Cassel &lt;<a hre=
f=3D"mailto:Niklas.Cassel@wdc.com">Niklas.Cassel@wdc.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">On Mon, Sep 25, 2023 at 03:53:23PM -04=
00, John Snow wrote:<br>
&gt; Niklas, I&#39;m sorry to lean on you here a little bit - You&#39;ve be=
en<br>
&gt; working on the SATA side of this a bit more often, can you let me know=
<br>
&gt; if you think this patch is safe?<br>
<br>
FWIW, I prefer Fiona&#39;s patch series which calls blk_aio_cancel() before=
<br>
calling ide_reset():<br>
<a href=3D"https://lore.kernel.org/qemu-devel/20230906130922.142845-1-f.ebn=
er@proxmox.com/T/#u" rel=3D"noreferrer noreferrer" target=3D"_blank">https:=
//lore.kernel.org/qemu-devel/20230906130922.142845-1-f.ebner@proxmox.com/T/=
#u</a><br>
<br>
Patch 2/2 also adds a qtest which fails before patch 1/2, and passes after<=
br>
patch 1/2.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">I think I also prefer Fiona&#39;s patch. Simon makes a good point=
 (I think) that it feels correct to dump the DMA as fast as possible, but F=
iona&#39;s patch seems more justifiably and obviously correct.</div><div di=
r=3D"auto"><br></div><div dir=3D"auto">I think my preference is for Fiona&#=
39;s patches first, and if we want to optimize cancellation thereafter we c=
an attempt to do so.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><di=
v class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
<br>
&gt; <br>
&gt; I&#39;m not immediately sure what the impact of applying it is, but I =
have<br>
&gt; some questions about it:<br>
&gt; <br>
&gt; (1) When does ide_dma_cb get invoked when DRQ_STAT is set but the<br>
&gt; return code we were passed is not &lt; 0, and<br>
&gt; <br>
&gt; (2) what&#39;s the impact of just *not* executing the end-of-transfer<=
br>
&gt; block here; what happens to the state machine?<br>
&gt; <br>
&gt; On Thu, Sep 21, 2023 at 12:07=E2=80=AFPM Simon Rowe &lt;<a href=3D"mai=
lto:simon.rowe@nutanix.com" target=3D"_blank" rel=3D"noreferrer">simon.rowe=
@nutanix.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; When an IDE controller is reset, its internal state is being clea=
red<br>
&gt; &gt; before any outstanding I/O is cancelled. If a response to DMA is<=
br>
&gt; &gt; received in this window, the aio callback will incorrectly contin=
ue<br>
&gt; &gt; with the next part of the transfer (now using sector 0 from<br>
&gt; &gt; the cleared controller state).<br>
&gt; <br>
&gt; Eugh, yikes. It feels like we should fix the cancellation ... I&#39;m<=
br>
&gt; worried that if we&#39;ve reset the state machine and we need to bail =
on a<br>
&gt; DMA callback that the heuristics we use for that will eventually be<br=
>
&gt; wrong, unless I am mistaken and this is totally safe and reliable for<=
br>
&gt; a reason I don&#39;t intuitively see right away.<br>
&gt; <br>
&gt; Thoughts?<br>
<br>
Since Simon has a reliable reproducer, and has offered to test Fiona&#39;s =
patch,<br>
perhaps we should simply take him up on that offer :)<br></blockquote></div=
></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes! I just wanted to =
understand the differences between the two approaches since it looked like =
it was going to be my job to decide between them =F0=9F=98=85</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Simon, can you confirm that Fiona&#39=
;s patches are appropriate for your reproducer? In the meantime I&#39;ll do=
 my own audit for the problem as you described it (thank you very much for =
that) and see if there&#39;s anything else that needs to be addressed.</div=
><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
<br>
<br>
Kind regards,<br>
Niklas</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto=
">Thank you everyone.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">--js</div><div dir=3D"auto"></div></div>

--000000000000a25b930606d2e72b--


