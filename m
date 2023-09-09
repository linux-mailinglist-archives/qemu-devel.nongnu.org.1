Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADA97996B7
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 09:20:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qesEq-0000eG-Aq; Sat, 09 Sep 2023 03:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qesEe-0000dz-Hj
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 03:18:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qesEV-0003As-Fq
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 03:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694243898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HAvgtyv/sTqakl8Ns2rRNwy+i9Zch4V4puqiXJ+E2E0=;
 b=EN3mF5qdgdEv8KK9BjztY33otiUbfrc3kF+ydIScQqNmUHsxy8OpTNPmA0P0pmfKBmo3Ak
 eeKrHlcgs6sJ5ey9oeG/M+C+CK2oO/lxk71aIejB+78YH99UkkTjTfIAtLmHuGh9qWdFVb
 ToQSdZuRtFml/AOy0haNTNSQ+RbvZRI=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-idBCioiKPv6HThKv0Y1yPw-1; Sat, 09 Sep 2023 03:18:16 -0400
X-MC-Unique: idBCioiKPv6HThKv0Y1yPw-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-7a7bd80e2dfso998365241.1
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 00:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694243896; x=1694848696;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HAvgtyv/sTqakl8Ns2rRNwy+i9Zch4V4puqiXJ+E2E0=;
 b=l2vzunFITvveIZnLhrUCSmkJmz8LliKXfJR5+yTywx3OyRjLETZMBzNAGyCncdcHfb
 JiYwoqYIGIniPil3hdyigNJi7DFmo0MPRsErRPzK/AhuGO8FCf55NBx5jeQAZfydO4W3
 w+v51bwCXS2fbeBWBGJcf+W+3KEeX2uWnv/d8Fcyqcmwz3iXXGA5oTOvwkJtj2ddCMuo
 vH70VIjwWnyGi92+fj9HxIr3K5LCDHQUKK04ftKcb7Z4DIYgqKsmWvjqYX7kFritqkc3
 7NPCZDiiDzOqSb7U5tVY0pJ24nF+Ghqi2WY1rsVLLgViloWgrpcwCoVLNQZ7NjRYpCf7
 /aUA==
X-Gm-Message-State: AOJu0Yxa7jDjoPhGzs5GTp9laybCxOG+kN/FhWRAvDUGCzS4MXSBjVJy
 eGMxqMPYI5cbTI7QpJn6csJ8BqxUb3xYVeWFh54NWC1wn3w81ZQuHedE6w4FLtoKmXX8FXTAYTW
 fPPPkiUddJDpEWyZDkIO7B1HJ5qCiXpo=
X-Received: by 2002:a67:f94d:0:b0:44e:a348:9e55 with SMTP id
 u13-20020a67f94d000000b0044ea3489e55mr4134726vsq.17.1694243895825; 
 Sat, 09 Sep 2023 00:18:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIaW7XhvpskRgoAKC+627qvwZpFi/Kyj6MHfXstBaoEet0xz/L1I9VVHvVOa0nJhK4uWR53Wt3wB3MK7GYdM0=
X-Received: by 2002:a67:f94d:0:b0:44e:a348:9e55 with SMTP id
 u13-20020a67f94d000000b0044ea3489e55mr4134724vsq.17.1694243895566; Sat, 09
 Sep 2023 00:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230908033129.694-1-zhiwei._5Fliu@linux.alibaba.com>
 <20230908102912.535248-1-pbonzini@redhat.com>
 <CAOnJCUJexy3PhmGnGNgOk3a5LWLw6ZvFkwYRXTCErGnhn_A9uA@mail.gmail.com>
In-Reply-To: <CAOnJCUJexy3PhmGnGNgOk3a5LWLw6ZvFkwYRXTCErGnhn_A9uA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 9 Sep 2023 09:18:02 +0200
Message-ID: <CABgObfa9EehjW=p3mA-qiC8_tmkoYCT4SwF5Vtf+710OvSEw3g@mail.gmail.com>
Subject: Re: [RESEND] qemu/timer: Add host ticks function for RISC-V
To: Atish Patra <atishp@atishpatra.org>
Cc: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-devel <qemu-devel@nongnu.org>, 
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 LIU Zhiwei <lzw194868@alibaba-inc.com>
Content-Type: multipart/alternative; boundary="0000000000008efb250604e7e5d5"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

--0000000000008efb250604e7e5d5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il sab 9 set 2023, 03:35 Atish Patra <atishp@atishpatra.org> ha scritto:

> On Fri, Sep 8, 2023 at 3:29=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
> >
> > Queued, thanks.
> >
>
> I didn't realize it was already queued. Gmail threads failed me this time=
.
> @Paolo Bonzini : Can you please drop this one as this will break as
> soon as the host riscv system
> has the latest kernel ? I have provided more details in the original
> thread.
>
> https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01941.html


If you have dynamic clock adjustment, does rdcycle increase with a fixed
frequency or does it provide the raw number of clock cycles? If the latter,
I agree that it should be provided by perf; but if the frequency is fixed
then it would be the same as rdtsc on Intel.

Paolo


>
> > Paolo
> >
> >
>
>
> --
> Regards,
> Atish
>
>

--0000000000008efb250604e7e5d5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il sab 9 set 2023, 03:35 Atish Patra &lt;<a href=3D"ma=
ilto:atishp@atishpatra.org">atishp@atishpatra.org</a>&gt; ha scritto:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">On Fri, Sep 8, 2023 at 3:29=E2=80=AFAM P=
aolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank" r=
el=3D"noreferrer">pbonzini@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Queued, thanks.<br>
&gt;<br>
<br>
I didn&#39;t realize it was already queued. Gmail threads failed me this ti=
me.<br>
@Paolo Bonzini : Can you please drop this one as this will break as<br>
soon as the host riscv system<br>
has the latest kernel ? I have provided more details in the original thread=
.<br>
<br>
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01941.h=
tml" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.gnu.org/=
archive/html/qemu-devel/2023-09/msg01941.html</a></blockquote></div></div><=
div dir=3D"auto"><br></div><div dir=3D"auto">If you have dynamic clock adju=
stment, does rdcycle increase with a fixed frequency or does it provide the=
 raw number of clock cycles? If the latter, I agree that it should be provi=
ded by perf; but if the frequency is fixed then it would be the same as rdt=
sc on Intel.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex"><br>
<br>
&gt; Paolo<br>
&gt;<br>
&gt;<br>
<br>
<br>
-- <br>
Regards,<br>
Atish<br>
<br>
</blockquote></div></div></div>

--0000000000008efb250604e7e5d5--


