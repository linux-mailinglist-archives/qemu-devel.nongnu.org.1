Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DA974A620
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 23:48:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHWp3-0005BA-8W; Thu, 06 Jul 2023 17:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1qHWp1-0005Ax-8u
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 17:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1qHWoz-0007jJ-Bi
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 17:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688680045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ld/CWNzn999knNZnqKlT+U0bCvGioDPxcN/px9mCspw=;
 b=FRLKcW+VcLe25OlZlXzuTbeHJPbB2Z1Ab2wTIX7t+9uaDI3YGCtGd6CYhrXj05UUsakoeS
 m5Xu8sPxXUCzYwSa+MILeORlBzq4nwnWbH34gBoU+zLFMAtGEXoz2KwIWDhg807DCKvYCz
 ckbjqTDeSYOZHzq3c+PSoZrURvOA67c=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-xOSXtDxEPF6B0ia03_dPYQ-1; Thu, 06 Jul 2023 17:47:24 -0400
X-MC-Unique: xOSXtDxEPF6B0ia03_dPYQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-767564705f5so148405585a.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 14:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688680043; x=1691272043;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ld/CWNzn999knNZnqKlT+U0bCvGioDPxcN/px9mCspw=;
 b=avHgjBhycd8OcrgCh19HnrkLxYe+EkClwT+xXtG6LiPXrK+sEmpxGVJ7G+nF7hjgRn
 YqTcaC68spbgoWR4m3X2lWLKILqwDpHG2QaI0piqLmed3wQGi58tSp84nTlOqL86bvMj
 /OvLtHdTYLQu3fe1+JqwntBeQzyqz51aJ+gUdds5knWYjU3soe6x5zG40z1aKXxn+t/E
 P4R8dY3u80kAv2fYeyILnJzNWagt6HSfvhlL37KhUVYNQIF+5Y8LvLDbv2RwitpX9Fmf
 OOHQ7SoBJZKgInyxf+Pn+E7LHWQFwm0XN+8ye3G5cG0ZNyiANQF2orsIF+Z086UpRjEK
 wdMw==
X-Gm-Message-State: ABy/qLZhc4lyKZJpIdfUA/5Wf9nSPfRh1rtFnKFv83CEOKJ40jTHfWZB
 4mj47hkLIeHJVWpFXLlsBOJb/TxPYdjSFPSdgRfPlBC2cVGlmdi1Pwp+XCp3u9uZte1YlUI6F08
 X21Ix2UabPdNzGIW6N2Ts+Hp4NSG/wyo=
X-Received: by 2002:a05:622a:15d2:b0:400:aaed:592e with SMTP id
 d18-20020a05622a15d200b00400aaed592emr3512599qty.49.1688680043641; 
 Thu, 06 Jul 2023 14:47:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHmyt/hNp5coHr9JoSQoCvaT3HvKNLwhL+NuPijMbRS8jNbxeK6LhSGkfuZvRSW4qlCrOE9pxpK0WwGq5fuf10=
X-Received: by 2002:a05:622a:15d2:b0:400:aaed:592e with SMTP id
 d18-20020a05622a15d200b00400aaed592emr3512585qty.49.1688680043410; Thu, 06
 Jul 2023 14:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230706045546.593605-3-leobras@redhat.com> <ZKbRRt8ESGsMz+o7@x1n>
 <CAJ6HWG4iUX=+7FTCkXitFfc1zFNJ9aR5PzDRyPLSZVq1Kos8fA@mail.gmail.com>
 <ZKcEjfTDDgDZWu9Q@x1n>
In-Reply-To: <ZKcEjfTDDgDZWu9Q@x1n>
From: Leonardo Bras Soares Passos <leobras@redhat.com>
Date: Thu, 6 Jul 2023 18:47:12 -0300
Message-ID: <CAJ6HWG5OTPVv_-BB--Q0s=8PkEHZGDkdbjyx3fdpFJjn9yqoyQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] pcie: Add hotplug detect state register to cmask
To: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lsoaresp@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jul 6, 2023 at 3:24=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Jul 06, 2023 at 03:07:40PM -0300, Leonardo Bras Soares Passos wro=
te:
> > > I asked the same question, and I still keep confused: whether there's=
 a
> > > first bad commit?  Starting from when it fails?
> > >
> > > For example, is this broken on 6.0 binaries too with pc-q35-6.0?
> >
> > I tested for qemu 6.0, and it still reproduces, but have not pursued
> > this any further.
>
> I see, thanks!
>
> But then do you know why it's never hit before?  I assume it means this b=
ug
> has been there for a long time.

Even longer than expected:

I did some testing looking for the bug:

qemu v5.0.1 reproduces
qemu v4.0.1 reproduces
qemu v3.0.1 reproduces
qemu v2.12.1 reproduces

I decided to stop testing at this point, because it required python2
for building qemu, and it is far enough (5 years).

Seems to be a very old bug, that just hasn't bothered anyone until now.

>
> --
> Peter Xu
>

Thanks!
Leo


