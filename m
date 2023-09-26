Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ACD7AEE0E
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 15:45:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql8Ng-0001lw-S9; Tue, 26 Sep 2023 09:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ql8NX-0001fb-OL
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 09:45:36 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ql8NV-0008Km-Pt
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 09:45:31 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-57bce354d94so1648330eaf.2
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 06:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695735924; x=1696340724; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Sl8mxLVJiK7NolGEP1+tCC/GK2Su/8aOOxdot58kbLM=;
 b=N09YANTnaNpvS7kbdYSTWHKLAnpg1uU5vfRnfF0q3OsZDUY6Mz+RQps4fv4qljOvck
 Kac7W1U/ytffXOW27y3Znuhr3/1AnMab5LW9xMqtymchWxljtRDXYnMStvYDSy/ZWb5g
 wZVWdy8FPLbOnvWpz9xCX2PTx2PTaisW03lOyBzIWRo+QVOxwXFSc3a16tygBRKUjUwu
 yAkwoulna8V2AGVeLJ4htVSFcbmnHHGcRxWFyKX4M2inTzBO+x5n1GW4CxQPimv491Xn
 EBzYwdOC0v+OnPPAh1q40L0AVgL5RT8Pp4tPt3zLQ53jBrvheeH00qpa9Cog5GD4FDI1
 NBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695735924; x=1696340724;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Sl8mxLVJiK7NolGEP1+tCC/GK2Su/8aOOxdot58kbLM=;
 b=G3ubWthTtKlGvpXzjgH29RfxZCPnGL5KWEdDMX2WZDfWCKob+jvBLd4K1gTzDEbBdD
 wmfdMN4k0X9CUYonjLMYIKaGSdYZOn1jDA1brBlo8IJDgBbz80tj4+Epup7Nq8u+1xBM
 qW8TI5llZgD9nAI+WqJhzUIpODhwYo7O31rSkABgMYuqR/Wwiuzkn7As/k9Be2m0Jkzj
 pzluHiFOs5LWiCq04UZ8M4MuM1teEoJjRT7Lxoncp1pgu6LeIh4pMfSuhyuDi3Z3OfUs
 Z6YNWdZ9CwtxWze72PwmyG0As+oeEE3F8oBjGyqAIP7mz2vDxOMfjH6aIBTdnDhQAJN5
 1wKA==
X-Gm-Message-State: AOJu0YzDg5Z/bPQfCiMq2cdYJOGxIr34w3O62h2CwBrdV1qbKF/qKcgm
 NVKzy9Fc4ky7estnvNWroVZ9ig+dSE20SRTodnk=
X-Google-Smtp-Source: AGHT+IGbZQS8NcfdwgAk5Na9IoycGvKbbSZo1lWSM6PpA33WvSdrnCMysB55PWYMnqqhxgALhPuRU9qTg109lKGtpIU=
X-Received: by 2002:a4a:2a0e:0:b0:56c:c061:a9a8 with SMTP id
 k14-20020a4a2a0e000000b0056cc061a9a8mr7598601oof.0.1695735924452; Tue, 26 Sep
 2023 06:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230823085429.20519-1-mads@ynddal.dk>
 <20230823085429.20519-14-mads@ynddal.dk>
 <20230920203744.GM1094271@fedora>
 <FD495C81-077B-4428-8871-D4BE5A6BDBA4@ynddal.dk>
In-Reply-To: <FD495C81-077B-4428-8871-D4BE5A6BDBA4@ynddal.dk>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 26 Sep 2023 09:45:13 -0400
Message-ID: <CAJSP0QU+=KXK8J2-uCPniN7Kc8sKF4tpgCdWKPbijYmtRNPHYQ@mail.gmail.com>
Subject: Re: [PATCH v4 13/14] MAINTAINERS: add maintainer of simpletrace.py
To: Mads Ynddal <mads@ynddal.dk>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000068f57a06064349ce"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000068f57a06064349ce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023, 06:27 Mads Ynddal <mads@ynddal.dk> wrote:

>
> > You're welcome to be the maintainer. I haven't touched it in years.
> >
> > When you have reviewed future simpletrace.py patches you can either pos=
t
> > your Reviewed-by and I'll include them in my tracing pull requests, or
> > you could send pull requests to the qemu.git maintainer yourself
> > (requires publishing a GPG key and signing pull request tags).
> >
> > Please let me know which option you prefer.
>
> For future patches, I would like to send pull requests myself with a GPG
> key to
> get the practice. I can have Klaus Jensen <its@irrelevant.dk> sign my key
> to
> get started.
>

Sounds good.

Stefan



> =E2=80=94
> Mads Ynddal
>
>
>

--00000000000068f57a06064349ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Sep 26, 2023, 06:27 Mads Ynddal &lt;<a href=3D=
"mailto:mads@ynddal.dk">mads@ynddal.dk</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex"><br>
&gt; You&#39;re welcome to be the maintainer. I haven&#39;t touched it in y=
ears.<br>
&gt; <br>
&gt; When you have reviewed future simpletrace.py patches you can either po=
st<br>
&gt; your Reviewed-by and I&#39;ll include them in my tracing pull requests=
, or<br>
&gt; you could send pull requests to the qemu.git maintainer yourself<br>
&gt; (requires publishing a GPG key and signing pull request tags).<br>
&gt; <br>
&gt; Please let me know which option you prefer.<br>
<br>
For future patches, I would like to send pull requests myself with a GPG ke=
y to <br>
get the practice. I can have Klaus Jensen &lt;<a href=3D"mailto:its@irrelev=
ant.dk" target=3D"_blank" rel=3D"noreferrer">its@irrelevant.dk</a>&gt; sign=
 my key to<br>
get started.<br></blockquote></div></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">Sounds good.</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>Stefan</div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
=E2=80=94<br>
Mads Ynddal<br>
<br>
<br>
</blockquote></div></div></div>

--00000000000068f57a06064349ce--

