Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8042D728667
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 19:33:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7JTp-0007Fw-1i; Thu, 08 Jun 2023 13:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q7JTj-0007E8-N2
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 13:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q7JTh-0003eI-Nt
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 13:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686245476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xm1ZGux0xxQNd4n7xR1nCtsGv5Ir0b+FATH8+N0HU68=;
 b=hXTPFKCnp9t2+XKS9bHLKuo1EhiCUEwdeoSgCv1hGaH/7yfYSlEX7w1mDPCCcq4aBjdBL1
 xo67nNVZtfMi1umI7+5hmu8HRoT6/7COMNHlZXwW9kZrtZEBBf3/KQGeRHrCr5A3U9fcm9
 RVo/QCphOJp0jpE9FqKV6Q0d80Ixy7Q=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-tARylQ7oOnKKcTpbVJt1-w-1; Thu, 08 Jun 2023 13:31:14 -0400
X-MC-Unique: tARylQ7oOnKKcTpbVJt1-w-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-25669acf204so784635a91.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 10:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686245473; x=1688837473;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xm1ZGux0xxQNd4n7xR1nCtsGv5Ir0b+FATH8+N0HU68=;
 b=DrrYxj3ka02F6mo8EHPV3Ryz6EzLcZOPSEp43zbG/9R1pFywCrHu5R5pPwqNaq4e9n
 +YCZyBPaAXjQG7aA02E4rBkVsRpIjJAZJvdpzx528X5wrNERdoicjvGXihmQTeriw59U
 kbi3fsjVyUoJsBhCpf+3Tu/Faaq/KeT54POLMr/tbk4E7N1+IPOaKlw88oUDO2xJs0Wv
 cWd3Mdcd+voNj7rHk02M//w8Qz3gpk/48MrjKLLQRm2NOq/Ab6/sn26wCas56Qg4Fs8B
 MwydyVrMeMgJAMLZuHbdbJ2KZDkQuolUcoKs1s+a6diDTR+uFtu6Dw/hKQLjhmONFk+k
 DzZw==
X-Gm-Message-State: AC+VfDyY/2KY75crpJeoz1wVPA2j7707KK+uwooEFsuBrALPYyzqmgBH
 tOUu186ZBBKTY/JSF1zAx5SQGRqPax5/aw/0DK/A+jATciOqT6Eiw+hm5r2NwfOM2driqPmyGf6
 J+ZGwFq5MXQ0u1pg4i6fe7rUKH2YKFfo=
X-Received: by 2002:a17:90b:110e:b0:258:b43d:bdcc with SMTP id
 gi14-20020a17090b110e00b00258b43dbdccmr8348614pjb.8.1686245473118; 
 Thu, 08 Jun 2023 10:31:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6FIP7IN3SJK8Nbj8gdqlF3PWj90cNC6ucCHEOnXCq9+H0ToVHaiUXj9spbirBPzFHwM/KZJANwxCx5MRxKcXY=
X-Received: by 2002:a17:90b:110e:b0:258:b43d:bdcc with SMTP id
 gi14-20020a17090b110e00b00258b43dbdccmr8348588pjb.8.1686245472733; Thu, 08
 Jun 2023 10:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230608151528.143950-1-nks@flawful.org>
In-Reply-To: <20230608151528.143950-1-nks@flawful.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 8 Jun 2023 13:31:01 -0400
Message-ID: <CAFn=p-b_TuV5yQgSbV7Pu6mwWc5U2aFAxpa7Vj35Rw167tmz6g@mail.gmail.com>
Subject: Re: [PATCH 0/5] improve ahci test suite
To: Niklas Cassel <nks@flawful.org>
Cc: Qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
Content-Type: multipart/alternative; boundary="00000000000068241105fda19e65"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--00000000000068241105fda19e65
Content-Type: text/plain; charset="UTF-8"

On Thu, Jun 8, 2023, 11:16 AM Niklas Cassel <nks@flawful.org> wrote:

> From: Niklas Cassel <niklas.cassel@wdc.com>
>
> Hello John,
>
> This series should be applied on top of the series called:
> "[PATCH v2 0/8] misc AHCI cleanups"
> which can be found here:
> https://lists.nongnu.org/archive/html/qemu-block/2023-06/msg00038.html
>
> This series improves the ahci test suite to be in line with
> the AHCI specification when it comes to taskfile errors.
>
> Theoretically these commits could be squashed with the corresponding
> patch for the QEMU model, however, that would lose the commit log for
> the test patches, so I prefer to keep them separate.
>
> Please review.
>

We need to squash them, because we can't have any regressions that might
appear during git bisect.

Will test and review shortly.


>
> Kind regards,
> Niklas
>
> Niklas Cassel (5):
>   libqos/ahci: fix ahci_command_wait()
>   libqos/ahci: fix ahci_port_check_nonbusy()
>   libqos/ahci: simplify ahci_port_check_error()
>   libqos/ahci: improve ahci_port_check_error()
>   libqos/ahci: perform mandatory error recovery on error
>
>  tests/qtest/libqos/ahci.c | 106 ++++++++++++++++++++++++++++----------
>  tests/qtest/libqos/ahci.h |   8 ++-
>  2 files changed, 83 insertions(+), 31 deletions(-)
>
> --
> 2.40.1
>
>

--00000000000068241105fda19e65
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Jun 8, 2023, 11:16 AM Niklas Cassel &lt;<a hre=
f=3D"mailto:nks@flawful.org">nks@flawful.org</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">From: Niklas Cassel &lt;<a href=3D"mailto:niklas.c=
assel@wdc.com" target=3D"_blank" rel=3D"noreferrer">niklas.cassel@wdc.com</=
a>&gt;<br>
<br>
Hello John,<br>
<br>
This series should be applied on top of the series called:<br>
&quot;[PATCH v2 0/8] misc AHCI cleanups&quot;<br>
which can be found here:<br>
<a href=3D"https://lists.nongnu.org/archive/html/qemu-block/2023-06/msg0003=
8.html" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.nongn=
u.org/archive/html/qemu-block/2023-06/msg00038.html</a><br>
<br>
This series improves the ahci test suite to be in line with<br>
the AHCI specification when it comes to taskfile errors.<br>
<br>
Theoretically these commits could be squashed with the corresponding<br>
patch for the QEMU model, however, that would lose the commit log for<br>
the test patches, so I prefer to keep them separate.<br>
<br>
Please review.<br></blockquote></div></div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">We need to squash them, because we can&#39;t have any regress=
ions that might appear during git bisect.</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">Will test and review shortly.</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">
<br>
<br>
Kind regards,<br>
Niklas<br>
<br>
Niklas Cassel (5):<br>
=C2=A0 libqos/ahci: fix ahci_command_wait()<br>
=C2=A0 libqos/ahci: fix ahci_port_check_nonbusy()<br>
=C2=A0 libqos/ahci: simplify ahci_port_check_error()<br>
=C2=A0 libqos/ahci: improve ahci_port_check_error()<br>
=C2=A0 libqos/ahci: perform mandatory error recovery on error<br>
<br>
=C2=A0tests/qtest/libqos/ahci.c | 106 ++++++++++++++++++++++++++++---------=
-<br>
=C2=A0tests/qtest/libqos/ahci.h |=C2=A0 =C2=A08 ++-<br>
=C2=A02 files changed, 83 insertions(+), 31 deletions(-)<br>
<br>
-- <br>
2.40.1<br>
<br>
</blockquote></div></div></div>

--00000000000068241105fda19e65--


