Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D195671877A
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 18:35:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Omr-0005kh-0e; Wed, 31 May 2023 12:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1q4Omo-0005iI-2H
 for qemu-devel@nongnu.org; Wed, 31 May 2023 12:34:58 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1q4Omm-0007Cs-Fi
 for qemu-devel@nongnu.org; Wed, 31 May 2023 12:34:57 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-51400fa347dso39a12.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 09:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1685550894; x=1688142894;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pkEI4vhjpefRk8FxoscgzCRW2pYA9o/FAwLpnRatfFc=;
 b=v9/pO3calpRdIIUEcG7WEQAVi6HNfnIYh//3dFNjCsP8o85Wk2CNq6g1zS2BkZCr7E
 Ye9FcnsP3N/yS/2jeUOPiMR37doB3nQgzPcHzE6R/IukBeZZY0pVm1/F2CCor6v+u0JS
 qnZwd5XA0wj669nMi7mAr6huityxgklzvcnCj0KVJSwHKV2pIhQIqkEpq7XNg590g4qV
 ucshguwgsJzIQo83fl+7TxOCi6OdtqQ1fng+sDnpS8gqwS20c2XwvPzyF6WW3biVMKcm
 Eqq74GrAcKv/iP4EP6WfYHwFR7BlbSj/rRCNyHJTUNCTJfrsWV8bE2crXqrPsLyP/UmG
 qt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685550894; x=1688142894;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pkEI4vhjpefRk8FxoscgzCRW2pYA9o/FAwLpnRatfFc=;
 b=L6Kl5PhkbmmkpO0BiMGkCdyPp0wO6wBH1zdozW+i/bEBS4BxEa/uz8esd8qlI/IZu5
 Mnv4RUBZyHzDzfYOrO4+V22NNcZX/84Dxq2s9YBdSKrK1u/vr85o18FD0Kb9AlIiZOvX
 sZcCbcfKexRZUyoXtCyrkrOcQcxBqGGGnB+/q3pOhND60NTONgu/t1fNe4bpyMptnGgG
 OB8QCnefoUNgdnJ6Vt00jAvXN99nAJQ3hP8BnUoPwpN5PztFb/VllCegf40G0808cedv
 tWmbYET259d+V0qO4zivHzRBxeiGtZ2hWDZhYeXDJ0GtVz6B36qHzOfxEx4XtYredDg/
 Zz2Q==
X-Gm-Message-State: AC+VfDyh7CXxbltNcnfFUtl1Kdo574fK1Q/v45NuW1pk3dBnmpbwRkDs
 KICvz/1bK2xp7pQFiThFVSCF0qMsW+DcB4XflaNmfQ==
X-Google-Smtp-Source: ACHHUZ5m2iptu1N9mh057EpOtV7f1ehUv+r7J9zM28I7FkwEO7SX0chxYivU6hgGfHAhVbXBIcX4aE3Zfn2gHrZQ5Hk=
X-Received: by 2002:a50:9e2e:0:b0:514:92e4:ab9f with SMTP id
 z43-20020a509e2e000000b0051492e4ab9fmr127592ede.7.1685550894023; Wed, 31 May
 2023 09:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230322172136.48010-1-venture@google.com>
 <ZBtwxzc7xpazByqK@minyard.net>
 <434091cb-08d7-15f5-e4ff-5fa867abd3e8@linaro.org>
In-Reply-To: <434091cb-08d7-15f5-e4ff-5fa867abd3e8@linaro.org>
From: Patrick Venture <venture@google.com>
Date: Wed, 31 May 2023 09:34:42 -0700
Message-ID: <CAO=noty3aAas_vT_dvB8knPg498nWs72KsFfkcB7TX2L8bXxQQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] hw/i2c: Enable an id for the pca954x devices
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: cminyard@mvista.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, 
 Hao Wu <wuhaotsh@google.com>
Content-Type: multipart/alternative; boundary="0000000000004aba0f05fcffe61c"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=venture@google.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--0000000000004aba0f05fcffe61c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2023 at 2:40=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> On 22/3/23 22:19, Corey Minyard wrote:
> > On Wed, Mar 22, 2023 at 10:21:36AM -0700, Patrick Venture wrote:
> >> This allows the devices to be more readily found and specified.
> >> Without setting the name field, they can only be found by device type
> >> name, which doesn't let you specify the second of the same device type
> >> behind a bus.
> >>
> >> Tested: Verified that by default the device was findable with the name
> >> 'pca954x[77]', for an instance attached at that address.
> >
> > This looks good to me.
> >
> > Acked-by: Corey Minyard <cminyard@mvista.com>
> >
> > if you are taking this in through another tree.  Or do you want me to
> > take this?
>
> Since I have to send a MIPS PR, I'll take this one;
> to alleviate you and the CI minutes.
>

I don't see this patch yet, did it got lost in the shuffle?

thanks,
Patrick

--0000000000004aba0f05fcffe61c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 22, 2023 at 2:40=E2=80=AF=
PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">phi=
lmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On 22/3/23 22:19, Corey Minyard wrote:<br>
&gt; On Wed, Mar 22, 2023 at 10:21:36AM -0700, Patrick Venture wrote:<br>
&gt;&gt; This allows the devices to be more readily found and specified.<br=
>
&gt;&gt; Without setting the name field, they can only be found by device t=
ype<br>
&gt;&gt; name, which doesn&#39;t let you specify the second of the same dev=
ice type<br>
&gt;&gt; behind a bus.<br>
&gt;&gt;<br>
&gt;&gt; Tested: Verified that by default the device was findable with the =
name<br>
&gt;&gt; &#39;pca954x[77]&#39;, for an instance attached at that address.<b=
r>
&gt; <br>
&gt; This looks good to me.<br>
&gt; <br>
&gt; Acked-by: Corey Minyard &lt;<a href=3D"mailto:cminyard@mvista.com" tar=
get=3D"_blank">cminyard@mvista.com</a>&gt;<br>
&gt; <br>
&gt; if you are taking this in through another tree.=C2=A0 Or do you want m=
e to<br>
&gt; take this?<br>
<br>
Since I have to send a MIPS PR, I&#39;ll take this one;<br>
to alleviate you and the CI minutes.<br></blockquote><div><br></div><div>I =
don&#39;t see this patch yet, did it got lost in the shuffle?</div><div><br=
></div><div>thanks,</div><div>Patrick</div><div>=C2=A0</div></div></div>

--0000000000004aba0f05fcffe61c--

