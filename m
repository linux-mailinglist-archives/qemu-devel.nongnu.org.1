Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C0C826516
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 17:28:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMVz3-0005U2-AV; Sun, 07 Jan 2024 11:26:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rMVz1-0005Ta-1z
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 11:26:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rMVyz-0001IQ-EF
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 11:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704644799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pvYni3pstLgyqkRraVn+4IF3RdanKKT8Pi01amZKuzg=;
 b=TxKfcEr2gMRTehMLb2AMlx5fuGY50UgOI6nrWROhD2CNEVe5hATYwgRPCuS9qjHuexRdL/
 YlO4KBCoSbWTOzNINfCa2h89tmic+oVGH5p60XoHaw2bzKF9TfvvNac4NYADSTh52udu2g
 +2abkSr7SRiXwj/kXTyHT6T85YsBJps=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-xpuwkEb-Oi-E8_KuTcggKQ-1; Sun, 07 Jan 2024 11:26:37 -0500
X-MC-Unique: xpuwkEb-Oi-E8_KuTcggKQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a28b9b87013so193846666b.0
 for <qemu-devel@nongnu.org>; Sun, 07 Jan 2024 08:26:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704644796; x=1705249596;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pvYni3pstLgyqkRraVn+4IF3RdanKKT8Pi01amZKuzg=;
 b=mYdM5elgbgiFDnTmk1RRZBbkttcIuDHMrlgrUnwDDtwSokmYCJXzoKBoQdP3h88K3p
 TOEypnv1+tn24LHTiMGW20qlFoGV7nvHJQgY6SDPfnzmSWNpgvzFPRRD8C/ZkU6els8d
 WHlfm2G9fKFytHFVT0Qj81/H5ZmA2py0hbFjrSFnT/PD9f+/czEE1gb4sZEjCKenAUJQ
 4it5nNGIFhOl5Y32sRI8sqc7dtIPwZ8s3NW1akuCSENMd7rHyctsST8dGIOouyasB06p
 tECo6OrzXGAwH/5yh2iQwksiG+VZfpBNK4c39xRVL1rxRqKRPylYfx8ZaQ5nVhxH+utB
 x+fQ==
X-Gm-Message-State: AOJu0YziUeMj9l15ISIzJvO7hIhJNDPn16xdgdFGlNCFpZpXRLjzHqkC
 MB+DjGKVS3UJ3cxCt8288PH4JkOf1Q4mg662Mvkat66xS9lll3BD6/PwCKBzSm5qsLClbZZDC7P
 4LDf+OzYo7aXse8yFLyAlljdFHWGXtsXXc62F03Y=
X-Received: by 2002:a17:906:ad88:b0:a2a:360d:5af5 with SMTP id
 la8-20020a170906ad8800b00a2a360d5af5mr1417489ejb.42.1704644796339; 
 Sun, 07 Jan 2024 08:26:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKLL+DulUa9D/1rKC0kZZKcG9y2jR4JWAKzKRnvFy7ON/JtDzO5thPdg0s28FVKr2wVKCMCFyobi7TqIka8bU=
X-Received: by 2002:a17:906:ad88:b0:a2a:360d:5af5 with SMTP id
 la8-20020a170906ad8800b00a2a360d5af5mr1417480ejb.42.1704644796000; Sun, 07
 Jan 2024 08:26:36 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA_TGYZP2eV1C4Yn5a6vnAO-_1r98rY1Teahy_Pb1ocvjw@mail.gmail.com>
 <CAK3XEhM75DW+eUFrx=73xPycKvxccdT-Tg5mfFyuW_hAMJJ3+w@mail.gmail.com>
 <CAK3XEhNe4TO4oBavsuqJwP5e1nzB6+xpdWa-D0NEq_-rqXincw@mail.gmail.com>
 <CAFEAcA-fjZw9x2RC+Czo8dQUuux1WUD6fDWCMJ-1xHdGevNWAw@mail.gmail.com>
In-Reply-To: <CAFEAcA-fjZw9x2RC+Czo8dQUuux1WUD6fDWCMJ-1xHdGevNWAw@mail.gmail.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Sun, 7 Jan 2024 21:56:24 +0530
Message-ID: <CAK3XEhM5BtPtFE5fmsxf8aC+gHo4QEkyhboCcfpsQg=bJOfsjQ@mail.gmail.com>
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
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.098,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sat, Jan 6, 2024 at 5:39=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Sat, 6 Jan 2024 at 05:41, Ani Sinha <anisinha@redhat.com> wrote:
> >
> > On Sat, Jan 6, 2024 at 10:05=E2=80=AFAM Ani Sinha <anisinha@redhat.com>=
 wrote:
> > >
> > > On Sat, Jan 6, 2024 at 12:11=E2=80=AFAM Peter Maydell <peter.maydell@=
linaro.org> wrote:
> > > >
> > > > The avocado test acpiBitsTest.test_acpi_smbios_bits seems to be
> > > > flaky in CI -- sometimes it appears to time out.
> > > >
> > > > https://gitlab.com/qemu-project/qemu/-/issues/2077
> > > > has the details (including links to jobs etc).
> > >
> > > Do you have more data points in terms of the jobs that failed?
> >
> > I just noticed that you attached three examples of failed tests. In
> > all of them the test seems to be stuck at the ami latency test.
>
> OK, if you think that subtest is suspicious, could you send a
> patch that disables just that subpart, and we'll see if it helps?

I pushed the patches here:
https://gitlab.com/anisinha/qemu/-/commits/disable-smilatency
and ran the pipeline. It passed
https://gitlab.com/anisinha/qemu/-/jobs/5878585312

and the smilatency test was not run:
https://anisinha.gitlab.io/-/qemu/-/jobs/5878585312/artifacts/build/tests/r=
esults/latest/test-results/01-tests_avocado_acpi-bits.py_AcpiBitsTest.test_=
acpi_smbios_bits/debug.log

Not sure what we can do to have some confidence that disabling the
test got rid of the flakiness. I can send out those two patches in the
list.


