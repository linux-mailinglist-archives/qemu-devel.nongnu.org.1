Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE343825E4E
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 06:42:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLzR1-0000bM-KL; Sat, 06 Jan 2024 00:41:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rLzQz-0000b9-6l
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 00:41:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rLzQx-0004Nh-Dj
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 00:41:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704519681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sQhKI3hnzb8SO/2gRLcl/elm6x27D5pUzpA2FYAQZE0=;
 b=dwo6TqjVNe+d/Up40V4QCi2ebx5zR8InB145qvftqU7i5VeqGvNl/7OM9xgKSP45ttXWCv
 h1HiTeTnQosDA0MIqEcggK5cCssBfncwgAZ92i4ybGTsPzA5TdnxOCTu1WtSmVdf6a96Jz
 Tx5zi2NkR8YIcuChB+ClvrU1RL6boH8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-ftxEiOCmMm25pqU7KGtN9g-1; Sat, 06 Jan 2024 00:41:19 -0500
X-MC-Unique: ftxEiOCmMm25pqU7KGtN9g-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a28fbc49006so25467766b.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 21:41:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704519678; x=1705124478;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sQhKI3hnzb8SO/2gRLcl/elm6x27D5pUzpA2FYAQZE0=;
 b=E376RCouN/q+en+KyYhH45wh6Tk67aU0+XK0TQ94LwXJD2vKO1czglMdD1+zaLlmmB
 ZlaJL+rzArytAuaJxknf4xKxyzu7V4Wa3zAFPD1rWswYiFGsRFe8p6uFd8VcWkStT/q4
 ybaJ6fphXGPePjhlFBcnhVRnOsLRZP6upHm+o12zRGmlDrKY1vgS+6Wr2Tg22UfcjwrY
 m01jG1mwyyj4BdLuRydrYCQjTGGQyUmZgscJFHa5EQEFFdm4QljEvJ4B39WaHvpif3WQ
 LGt+TH1aGsY2ElMDKcDl2kmu5SWNe8A/yF3IqThsb2qU6t/f6K5rz87i4Azp77hHc9kx
 QA4g==
X-Gm-Message-State: AOJu0Yy8VZ1zhD2Dez/fI9nyrQ9UfCq+tGgLkZH/qGl+6+OuZQezzy/g
 SK2jOu5fJTQC07y7hosYf9WhRrDX5XsHrTJEvwQlw/JxnThI0r7hIrftOqnxm0r2QOkbE++I0sd
 Nei4kHH2e124pEFTUi7887Xy4JqQA0ZmHuCNkbkI=
X-Received: by 2002:a17:906:229a:b0:a28:aef6:2677 with SMTP id
 p26-20020a170906229a00b00a28aef62677mr453746eja.63.1704519678626; 
 Fri, 05 Jan 2024 21:41:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOubIZPHUiRy1nwXBvp0fnIUYQw8mY1cYeMu/FpsBulDQ9iVRnhJdxP0GWfNeHVr+vNmcz4rajNz6KkIJsLnM=
X-Received: by 2002:a17:906:229a:b0:a28:aef6:2677 with SMTP id
 p26-20020a170906229a00b00a28aef62677mr453744eja.63.1704519678336; Fri, 05 Jan
 2024 21:41:18 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA_TGYZP2eV1C4Yn5a6vnAO-_1r98rY1Teahy_Pb1ocvjw@mail.gmail.com>
 <CAK3XEhM75DW+eUFrx=73xPycKvxccdT-Tg5mfFyuW_hAMJJ3+w@mail.gmail.com>
In-Reply-To: <CAK3XEhM75DW+eUFrx=73xPycKvxccdT-Tg5mfFyuW_hAMJJ3+w@mail.gmail.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Sat, 6 Jan 2024 11:11:07 +0530
Message-ID: <CAK3XEhNe4TO4oBavsuqJwP5e1nzB6+xpdWa-D0NEq_-rqXincw@mail.gmail.com>
Subject: Re: acpiBitsTest.test_acpi_smbios_bits test intermittently times out
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Beraldo Leal <bleal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.679,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Jan 6, 2024 at 10:05=E2=80=AFAM Ani Sinha <anisinha@redhat.com> wro=
te:
>
> On Sat, Jan 6, 2024 at 12:11=E2=80=AFAM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > The avocado test acpiBitsTest.test_acpi_smbios_bits seems to be
> > flaky in CI -- sometimes it appears to time out.
> >
> > https://gitlab.com/qemu-project/qemu/-/issues/2077
> > has the details (including links to jobs etc).
>
> Do you have more data points in terms of the jobs that failed?

I just noticed that you attached three examples of failed tests. In
all of them the test seems to be stuck at the ami latency test.

The one
> you point to seems to be stuck in SMI latency tests:
>
> =3D=3D=3D=3D SMI latency test =3D=3D=3D=3D
> 16:45:49 DEBUG|
> Warning: touching the keyboard can affect the results of this test.
> 16:45:50 DEBUG|
> Starting test. Wait here, I will be back in 15 seconds.
>
> If this is consistently timing out here, we can disable the smi
> latency test. This test was a little problematic from the get go.
>
> Meanwhile I have assigned
> https://gitlab.com/qemu-project/qemu/-/issues/2077 to myself and will
> take a look.
>
> > As far as I can
> > see, the test is still running when after about a minute it
> > gets timed out. (Though the python tracebacks in the logs are
> > not easy for me to interpret, so I might be wrong). This I find
> > a bit confusing, because tests/avocado/acpi-bits.py sets
> > "timeout =3D 200". So maybe that isn't taking effect properly?
> >
> > Does anybody have time to investigate this? If not, we can disable
> > the test as flaky until somebody does have the time.
> >
> > thanks
> > -- PMM
> >


