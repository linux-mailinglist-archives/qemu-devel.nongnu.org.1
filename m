Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EEF7978D5
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 18:56:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeIHA-0005dw-3R; Thu, 07 Sep 2023 12:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qeIH5-0005aW-HW
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:54:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qeIH3-0007ck-36
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694105671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4U/QIotFoPN15sH9xC0vF5U3GZM+wDPgGbQCn/V84zo=;
 b=RElzLm+o/Y6crOW68pzF6qZ1QTryOGnIZxWbq/LQ2ae9F/PksD7W7k/b9YlXMP6/8ijQ7T
 jONXZcaGXHfdJRusjXCXjo6hr4rxqOHvajiiIqZlSC/v6E5PmoplJ9Z0wiYv4EyuUjfGgl
 BnUhm1TibLbWR0cVTxqklMNfbJjiu8E=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-8bujmAxgPlKlp9XlXRwFZA-1; Thu, 07 Sep 2023 12:54:29 -0400
X-MC-Unique: 8bujmAxgPlKlp9XlXRwFZA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-26f97567cb8so2758266a91.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 09:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694105668; x=1694710468;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4U/QIotFoPN15sH9xC0vF5U3GZM+wDPgGbQCn/V84zo=;
 b=ZAKhlygo8t/F052pL3GqWvzVVYdKFIWElpWtd5Ti1VIRFwNvPZgOADdc9bOnxw24Pm
 qJ7Dp81RGu3xy5f4lVs2kzWnchr9PSkUSvATBGHfz2Kc8RxaHV9ID1N5wsH89kjxAyUa
 AlzYiYCWUIzKPjXcfbrWgLnxZ+Yo9B/LXg3bh30y2JXNcQXt5le7GiTiOVvr4zo8iXaj
 lnrVOQAMZzLtXUz26VtjG/i9+N3GuYyM+0rpQlcY2PxUjX+NVqqZRtDqUT8ec8Xtht9w
 dVvh+QTXRDWUWQzWQyDszyJNZpKvix3EUMpRiDA9F0NWwr27PoUpKUtm0QFUUU3DkHFX
 Ym8A==
X-Gm-Message-State: AOJu0YzxzLBdCCtuYXXlE2OxLM6DAmJHmBez/pMNu0HV5S+iK5rhyN0i
 HuBdCaiyxLsF7/9hVhNFlNLIJYdlq5IHdt0kQBf+BtEx07W4xo9pjSOs6v4Luz8j7mkA4mVepy8
 GZJ9siZUvdrDDSP62LwkdlgPp1qGu8JM=
X-Received: by 2002:a17:90a:5998:b0:26b:2d0f:56c6 with SMTP id
 l24-20020a17090a599800b0026b2d0f56c6mr4189104pji.18.1694105668057; 
 Thu, 07 Sep 2023 09:54:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGagGANqGS2xjWLmYYzLkQX5P+HSSJZlTCyV4m7di0zEjsy2snoLoyW6DYs+Pc/sgIwgQ43frncnbyi6KBrDw0=
X-Received: by 2002:a17:90a:5998:b0:26b:2d0f:56c6 with SMTP id
 l24-20020a17090a599800b0026b2d0f56c6mr4189082pji.18.1694105667608; Thu, 07
 Sep 2023 09:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230907034228.4054839-1-jsnow@redhat.com>
 <7ef011cd-09e7-c5f9-dc9d-173ff8f431c8@tls.msk.ru>
In-Reply-To: <7ef011cd-09e7-c5f9-dc9d-173ff8f431c8@tls.msk.ru>
From: John Snow <jsnow@redhat.com>
Date: Thu, 7 Sep 2023 12:54:16 -0400
Message-ID: <CAFn=p-aueHBXMFHgw=Y8XYyeaFZKFRc8vJHQ6PQ8gNSqPcii8Q@mail.gmail.com>
Subject: Re: [PULL for-6.2 0/7] Ide patches
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Qemu-block <qemu-block@nongnu.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000088f03d0604c7b679"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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

--00000000000088f03d0604c7b679
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 7, 2023, 12:49 PM Michael Tokarev <mjt@tls.msk.ru> wrote:

> 07.09.2023 06:42, John Snow wrote:
>
> > ----------------------------------------------------------------
> > IDE Pull request
> >
> > ----------------------------------------------------------------
> >
> > Niklas Cassel (7):
> >    hw/ide/core: set ERR_STAT in unsupported command completion
> >    hw/ide/ahci: write D2H FIS when processing NCQ command
> >    hw/ide/ahci: simplify and document PxCI handling
> >    hw/ide/ahci: PxSACT and PxCI is cleared when PxCMD.ST is cleared
> >    hw/ide/ahci: PxCI should not get cleared when ERR_STAT is set
> >    hw/ide/ahci: fix ahci_write_fis_sdb()
> >    hw/ide/ahci: fix broken SError handling
>
> Is anything here stable-worthy?
>
> /mjt
>

Yes, assuming it doesn't break anything.

I can't give IDE the testing it deserves anymore, but I trust Niklas. I
don't have good test suites for *inside* linux/windows guests so I am
admittedly relying on qtests and for people to bark if something regressed.

I'd say to tentatively add them to your list and if we find regressions
during this window, we can exclude them from a stable release.

>

--00000000000088f03d0604c7b679
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Sep 7, 2023, 12:49 PM Michael Tokarev &lt;<a h=
ref=3D"mailto:mjt@tls.msk.ru">mjt@tls.msk.ru</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">07.09.2023 06:42, John Snow wrote:<br>
<br>
&gt; ----------------------------------------------------------------<br>
&gt; IDE Pull request<br>
&gt; <br>
&gt; ----------------------------------------------------------------<br>
&gt; <br>
&gt; Niklas Cassel (7):<br>
&gt;=C2=A0 =C2=A0 hw/ide/core: set ERR_STAT in unsupported command completi=
on<br>
&gt;=C2=A0 =C2=A0 hw/ide/ahci: write D2H FIS when processing NCQ command<br=
>
&gt;=C2=A0 =C2=A0 hw/ide/ahci: simplify and document PxCI handling<br>
&gt;=C2=A0 =C2=A0 hw/ide/ahci: PxSACT and PxCI is cleared when PxCMD.ST is =
cleared<br>
&gt;=C2=A0 =C2=A0 hw/ide/ahci: PxCI should not get cleared when ERR_STAT is=
 set<br>
&gt;=C2=A0 =C2=A0 hw/ide/ahci: fix ahci_write_fis_sdb()<br>
&gt;=C2=A0 =C2=A0 hw/ide/ahci: fix broken SError handling<br>
<br>
Is anything here stable-worthy?<br>
<br>
/mjt<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"au=
to">Yes, assuming it doesn&#39;t break anything.</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">I can&#39;t give IDE the testing it deserves anymo=
re, but I trust Niklas. I don&#39;t have good test suites for *inside* linu=
x/windows guests so I am admittedly relying on qtests and for people to bar=
k if something regressed.</div><div dir=3D"auto"><br></div><div dir=3D"auto=
">I&#39;d say to tentatively add them to your list and if we find regressio=
ns during this window, we can exclude them from a stable release.</div><div=
 dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--00000000000088f03d0604c7b679--


