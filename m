Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D60BA825E36
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 05:37:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLyP7-0006ZB-Nx; Fri, 05 Jan 2024 23:35:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rLyP6-0006Yz-If
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 23:35:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rLyP4-00036V-OF
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 23:35:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704515721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ivfVJuSKtdsfagwOvYRryhucYhjgmIBxxboWsqZT4/s=;
 b=DWswCw3zdTtX1CrQ2vS35xpiG7T5CAUYszncfDKKQU7Wpcw4/YJD/KjMrDlU5wZdDd7VG8
 /zA0nvolgyoKksbjKrhrRFY8iUmp1ovcKJwCQlguX7rBRo0r1MRoaEPSs8Y7TVy+0bCnn3
 sD4dAb+31O+lIyvIECMDHSDffeTGFJ8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-qSMlc97FOo2TkEtYJM6e2g-1; Fri, 05 Jan 2024 23:35:17 -0500
X-MC-Unique: qSMlc97FOo2TkEtYJM6e2g-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a29494078faso6460266b.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 20:35:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704515716; x=1705120516;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ivfVJuSKtdsfagwOvYRryhucYhjgmIBxxboWsqZT4/s=;
 b=hn2rsAcySW56fltzZnxw/Pw9x+r6dMgdTycV13GKoheWTKmW8su70muVzqsacYL501
 84WwVSPlDBfJIjNne+CoyjQ+nMHi6w0oXhGK6sh78c6gTyR2pKY5DRQKYDBczEu2DaRr
 mmcIrDl4Vqyt7fJm9oEkA/f0sRhbilRcGl5a0Mdd0nfsd4RioR+44ONgmt0nYVv/bw6e
 OxaZEtEZkj/MzSoLYOf52DeGw3aLCtgzhwDZtypaYAGFpg5YsoVxyAfO+GIBFt5QqBXQ
 e60rtqYyzt3bDUPqqeBJO90ZegNL06IoHZ+bWZRQjIOVveouMUsfFlLgumPhk9KBItKU
 Fr9w==
X-Gm-Message-State: AOJu0YwyKFTm4NkaAzRJ+aOvK6G+xa3UUBmtiV/JhfLcpssMA5K7YTln
 6qPIFOVvU+A+l34rBnzOz+7s1iomm/+fYDP5hCMCFjiC6vQixpeGeC/Wn3QKlX+PusjKez1ps7b
 7V4bTDdJw2ELA8zohOxFp/MCc5QUqE0s8HreZHtQ=
X-Received: by 2002:a17:907:9408:b0:a28:c289:7bd2 with SMTP id
 dk8-20020a170907940800b00a28c2897bd2mr194741ejc.37.1704515716395; 
 Fri, 05 Jan 2024 20:35:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHE0oo6jl9+kSC+B/+2ljH6qKJQlL89hBn+Oh/6oiF+fCJ/Og6m2xuRezYXEhykTUnaikGluzqrpVo5n1mPc0M=
X-Received: by 2002:a17:907:9408:b0:a28:c289:7bd2 with SMTP id
 dk8-20020a170907940800b00a28c2897bd2mr194734ejc.37.1704515716077; Fri, 05 Jan
 2024 20:35:16 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA_TGYZP2eV1C4Yn5a6vnAO-_1r98rY1Teahy_Pb1ocvjw@mail.gmail.com>
In-Reply-To: <CAFEAcA_TGYZP2eV1C4Yn5a6vnAO-_1r98rY1Teahy_Pb1ocvjw@mail.gmail.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Sat, 6 Jan 2024 10:05:04 +0530
Message-ID: <CAK3XEhM75DW+eUFrx=73xPycKvxccdT-Tg5mfFyuW_hAMJJ3+w@mail.gmail.com>
Subject: Re: acpiBitsTest.test_acpi_smbios_bits test intermittently times out
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Beraldo Leal <bleal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.679,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Sat, Jan 6, 2024 at 12:11=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> The avocado test acpiBitsTest.test_acpi_smbios_bits seems to be
> flaky in CI -- sometimes it appears to time out.
>
> https://gitlab.com/qemu-project/qemu/-/issues/2077
> has the details (including links to jobs etc).

Do you have more data points in terms of the jobs that failed? The one
you point to seems to be stuck in SMI latency tests:

=3D=3D=3D=3D SMI latency test =3D=3D=3D=3D
16:45:49 DEBUG|
Warning: touching the keyboard can affect the results of this test.
16:45:50 DEBUG|
Starting test. Wait here, I will be back in 15 seconds.

If this is consistently timing out here, we can disable the smi
latency test. This test was a little problematic from the get go.

Meanwhile I have assigned
https://gitlab.com/qemu-project/qemu/-/issues/2077 to myself and will
take a look.

> As far as I can
> see, the test is still running when after about a minute it
> gets timed out. (Though the python tracebacks in the logs are
> not easy for me to interpret, so I might be wrong). This I find
> a bit confusing, because tests/avocado/acpi-bits.py sets
> "timeout =3D 200". So maybe that isn't taking effect properly?
>
> Does anybody have time to investigate this? If not, we can disable
> the test as flaky until somebody does have the time.
>
> thanks
> -- PMM
>


