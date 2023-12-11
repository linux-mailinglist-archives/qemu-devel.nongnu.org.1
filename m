Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D72C80C884
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 12:52:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCeol-0004P0-6j; Mon, 11 Dec 2023 06:51:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rCeoa-0004Nv-IG
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 06:51:12 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rCeoX-0007Tc-VF
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 06:51:12 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50bce78f145so4905187e87.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 03:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702295466; x=1702900266;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+Vd11gBGtqciAP78sFvPF0wj9juuKSRq3ASYTlwTeIQ=;
 b=MBRejBnENSQg8yMPpDCzN5o1bu8F7OmBsWQp74kEwQxmDhFctQZ+UkT9qFzbLhHsB9
 PzxjOWcQG0+voUcSi7KqV9/0fV6kqjH1YpTnrPFmWc4ft3e/+hHKbv6cloPl9BPQi/jz
 bXpyBgiLfNEfHEF3kjgUpLYde9MWvMlOJ7gCuP1XmTSgvW7x9HHwZ+5UZA+rXjoZdpkQ
 B6KLqdZcnVDC4AxATFg67w1aWoyPkqJhKWaubXwEthEub6mhVORqBclf7oc0UVCQQiWi
 NGnzwsoXjxhVeexag63+ssgBr8j8YaZaGEnh5Xj9Yod3ijwWiqy3qqZm2wagjAMzA5yi
 FSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702295466; x=1702900266;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+Vd11gBGtqciAP78sFvPF0wj9juuKSRq3ASYTlwTeIQ=;
 b=iGRJ8Ap/8nt8LPSeEMAaNX/9YnyQUJon272I7YQJwT9Yh8yItXa7TKowlifOxfm/Q1
 bTy7Nr+duqmPo+yJFHSfXBknpFGir6Hl7iC7kNmH2cGlGPn4ZozMNnhQh4dQ2vD9FzoF
 W1mN+CY0FcqFNsLYhm6xcTn2m9RyLiTHcSBcQ3GiC5nT4cJeb4rw2wL8f5561+/YpJk8
 bjByU1nn4rn8WLxqOV8SUUFBiR8/zqr0Zb1J8mQ52OBvlK9Zpg1JXVjdG2TlSGTx9Rid
 0pH+mzF7mya/QDfaLrbaBX9ZASTf58veF/mjdi4XLUwozVUOrgpOW9aiQ5Re9zGDhjdQ
 QwZg==
X-Gm-Message-State: AOJu0YwGpcapHOp9edBChSn9c0vNzbdy2qAsbpuMMBIsnv6W8WLX3jri
 1+FY+YJkWMDyBDnr6yNjyLYXCbdeY0u7ATSiR6qD9w==
X-Google-Smtp-Source: AGHT+IEo+oaDnE1ewJ6dX/T32V+SBPUbf4L5btB6EosjZDusO1wYt8Ztjw4iMPwo5wGwTAByHQYSSSsub9Z0jFP0iUk=
X-Received: by 2002:a05:6512:b22:b0:500:b2f6:592 with SMTP id
 w34-20020a0565120b2200b00500b2f60592mr819576lfu.50.1702295465927; Mon, 11 Dec
 2023 03:51:05 -0800 (PST)
MIME-Version: 1.0
References: <20230831065140.496485-1-andrew@daynix.com>
 <20230831065140.496485-6-andrew@daynix.com>
 <CABcq3pHyiO4AWSzxwWKfUnULfqPGQs1g12MCn14Ms4FqupZAzg@mail.gmail.com>
 <CACGkMEvBEdV1+uxE00hbXuFWmT2+nqgT9JxBezLXBwEX0b9Vbw@mail.gmail.com>
In-Reply-To: <CACGkMEvBEdV1+uxE00hbXuFWmT2+nqgT9JxBezLXBwEX0b9Vbw@mail.gmail.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 11 Dec 2023 13:50:53 +0200
Message-ID: <CAOEp5OcMo+eZ=k4m7ZKvSLWfngzzaZ6eHMLaiTmZ3CQ_yE2aKw@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] ebpf: Updated eBPF program and skeleton.
To: Jason Wang <jasowang@redhat.com>
Cc: Andrew Melnichenko <andrew@daynix.com>, mst@redhat.com, armbru@redhat.com,
 eblake@redhat.com, 
 qemu-devel@nongnu.org, berrange@redhat.com, yan@daynix.com
Content-Type: multipart/alternative; boundary="0000000000008cbb1d060c3a8c3d"
Received-SPF: none client-ip=2a00:1450:4864:20::12b;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-lf1-x12b.google.com
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

--0000000000008cbb1d060c3a8c3d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jason,
Can you please let us know what happens with this series?

Thanks
Yuri

On Fri, Sep 8, 2023 at 9:43=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:

> On Mon, Sep 4, 2023 at 7:23=E2=80=AFPM Andrew Melnichenko <andrew@daynix.=
com>
> wrote:
> >
> > Hi Jason,
> > According to our previous conversation, I've added checks to the meson
> script.
> > Please confirm that everything is correct
>
> I've queued this series.
>
> Thanks
>
>

--0000000000008cbb1d060c3a8c3d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Jason,<div>Can you please let us know what happens w=
ith this series?</div><div><br></div><div>Thanks</div><div>Yuri</div></div>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri=
, Sep 8, 2023 at 9:43=E2=80=AFAM Jason Wang &lt;<a href=3D"mailto:jasowang@=
redhat.com">jasowang@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Mon, Sep 4, 2023 at 7:23=E2=80=AFPM And=
rew Melnichenko &lt;<a href=3D"mailto:andrew@daynix.com" target=3D"_blank">=
andrew@daynix.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi Jason,<br>
&gt; According to our previous conversation, I&#39;ve added checks to the m=
eson script.<br>
&gt; Please confirm that everything is correct<br>
<br>
I&#39;ve queued this series.<br>
<br>
Thanks<br>
<br>
</blockquote></div>

--0000000000008cbb1d060c3a8c3d--

