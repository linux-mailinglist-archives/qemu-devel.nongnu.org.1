Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B1373AB78
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 23:19:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCRhA-0005lu-Ls; Thu, 22 Jun 2023 17:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qCRh7-0005lK-PQ
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:18:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qCRh6-00049o-6V
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687468699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WlWQb96270yc7z/9os5xbg5nTcLQHLSVsY3/M2EFFCc=;
 b=ITwRKnnDnCxz5jQBTiKRqDhYSSRi09DekKtBxVoQn9I6tN3rnYbH1bltzUxk7hDFNttUlT
 qaWCdCwi05Dew9ubErHAJQZh/KVaiMWvL6cNj/AQJxfpiVTcqfpgtsePlxnV/3unt6ZatS
 cl9tQxBF1Zh9p5RwYYTo4HnI3LTvaG4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-65ysSnktMDaQX0o7Urpq_g-1; Thu, 22 Jun 2023 17:18:17 -0400
X-MC-Unique: 65ysSnktMDaQX0o7Urpq_g-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-25eabbb5fc2so3922238a91.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 14:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687468696; x=1690060696;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WlWQb96270yc7z/9os5xbg5nTcLQHLSVsY3/M2EFFCc=;
 b=aLodQiwK2DqniDkX8Y6Ooa6qPnLFKWxEgdRLguKPVPiLGvk68ox831szN0LOEtQY4J
 PZqWjC3DVzPsG8y4PLDWtxypjBgcEfDRyAMM6i+v+e5T8d3XTdnXwUdJafl4salsLATk
 k0+YbufK6icuujf3bqLyWl2E2OnQCsy3eXvndcnmC8+yMXd/zmDRIe6rSXuKqJEcF8VG
 Iob6ed07jVBEa7eclVLfOQzgcatb0NZ2keMgjTmGyCUvR1JvyRb815o1aiXFhe+qqNUp
 RbTp+IdgGBi2OrhoOcIHxGwVIJI+y8Kzo+GL9i2L6IXbMSAuk4jIJ5rh9F143vWJblyb
 wr9w==
X-Gm-Message-State: AC+VfDzI4xXY1VWnQW1wJtDhoB7k5tr7z+5DNSeA45dVJ/tnLQs92aC0
 igkCVro/LMRxMtQP+G3i2nvMYsQrbIrpN7gBSfm+R+1ZrkXxvRdZHCgmjWNcBHex07WwLrhrNG8
 untX7Q6e9HRqBfDmArTkKPMaTMkahOlU=
X-Received: by 2002:a17:90a:6ac5:b0:25e:a4ac:8516 with SMTP id
 b5-20020a17090a6ac500b0025ea4ac8516mr14728845pjm.46.1687468696714; 
 Thu, 22 Jun 2023 14:18:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6yBlrR1rlYbsQp7NyEBKyub45c4TELSkXUOlvNqpcFH5QaEoWgffwvyaAyrPnbHjbpgRE23lqpOfqIwD4UG1A=
X-Received: by 2002:a17:90a:6ac5:b0:25e:a4ac:8516 with SMTP id
 b5-20020a17090a6ac500b0025ea4ac8516mr14728832pjm.46.1687468696465; Thu, 22
 Jun 2023 14:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230621002121.1609612-1-jsnow@redhat.com>
 <CABgObfahSN4eQ65nu9Dy_7bkWmxfERiJ-ZEM729futMFuGWwPw@mail.gmail.com>
 <CABgObfYKK+eU56iP2O+O7s=dcfWxmpXrB3EuNj=CkUw-XEjSnA@mail.gmail.com>
 <CAFn=p-a1Lz=FdrAYcB8Ua3AK=C5674Lyg5vRyxNjaybNXgvQ0w@mail.gmail.com>
 <CABgObfYo34ZOqAGdf9jEEQUtTztcwDUF+N9JGSsbBw8z1FOoWQ@mail.gmail.com>
 <CAFn=p-YnhA=FGPbPifY9vR=skpV=8dVvtmgdivJGw0cNjR6ouw@mail.gmail.com>
 <CABgObfbmjjB505_O4wg5sUKYkgVhcrdPnevV9Pv-uH+TCb=o-w@mail.gmail.com>
In-Reply-To: <CABgObfbmjjB505_O4wg5sUKYkgVhcrdPnevV9Pv-uH+TCb=o-w@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 22 Jun 2023 17:18:05 -0400
Message-ID: <CAFn=p-YsWb2V-pjB82iDU4g_Z9kdq58QajzP_acDq8kfyja8=A@mail.gmail.com>
Subject: Re: [PATCH RFC 0/6] Switch iotests to pyvenv
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, 
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Beraldo Leal <bleal@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 22, 2023 at 5:12=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On Thu, Jun 22, 2023 at 11:08=E2=80=AFPM John Snow <jsnow@redhat.com> wro=
te:
> >
> > On Thu, Jun 22, 2023 at 5:05=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.=
com> wrote:
> > >
> > > On Thu, Jun 22, 2023 at 11:03=E2=80=AFPM John Snow <jsnow@redhat.com>=
 wrote:
> > > > If we always install it in editable mode, and the path where it is
> > > > "installed" is what we expect it to be, it shouldn't have any probl=
ems
> > > > with being out of date.... I think. We could conceivably use the
> > > > "faux" package version the internal package has to signal when the
> > > > script needs to re-install it.
> > >
> > > Stupid question, why not treat it just like avocado?
> > >
> >
> > How do you mean? (i.e. installing it on-demand in reaction to "make
> > check-avocado"?)
>
> Yes, installing it on-demand the first time "make check-iotests" is
> run, using a "depend:" keyword argument in
> tests/qemu-iotests/meson.build.
>
> BTW,
>
> from distlib.scripts import ScriptMaker
> ScriptMaker('..', '.').make('foo.py')
>
> Seems to do the right thing as long as foo.py includes a shebang (I
> tested it inside a virtual environment).
>
> Paolo

That's possible, but it means that it will break if you run configure
and then immediately go to invoke iotests, unless we have a way to
have iotests bootstrap itself. Which I think can't be done through the
makefile, because we don't know which "make" to run in order to get
that to happen. (Or at least, I don't!)

Possibly I could teach mkvenv a new trick, like "mkvenv init iotests"
and have the mkvenv script DTRT at that point, whatever that is --
ideally exiting very quickly without doing anything.


