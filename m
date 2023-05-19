Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA58709AFF
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 17:15:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01oP-0007Qr-6E; Fri, 19 May 2023 11:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q01oM-0007QM-JA
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:14:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q01oL-0003xo-0Q
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684509267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZWMkU5juv4oby49hkLsz8iDMPdYF1OCBIjB3O9rd9/k=;
 b=deVs9oVM0C/pCKAnE1My6fwFzT9AGXWB2MFU91J8urLocUShikk2HgAlLgGYGm8Bqd2CGW
 jxGbCOCP6oDphPivYuXAl+Mke16luOFr78fuFpA+G+5bP/oTy7swvmfRKSFpkRdjMzPary
 Ff+T/ghI/nHQgnPKQ70WqvfuNx3kvtY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-G6HaxhyxOXqMMVC6du25tQ-1; Fri, 19 May 2023 11:14:24 -0400
X-MC-Unique: G6HaxhyxOXqMMVC6du25tQ-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1ae735bd214so17081005ad.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 08:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684509263; x=1687101263;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZWMkU5juv4oby49hkLsz8iDMPdYF1OCBIjB3O9rd9/k=;
 b=SgYlASW0EmNKTHLpFuKHWjmYnHtTY47SErxPi1Sca2zvue0dxU/PhKl9kgrrLaLaGS
 dYW8wnguKJz7nERVdmAj7V2P+wUJjG6WEqO6GZcpeubHMs+rD7nbnKtrHlu3nuIsgvNR
 ZpjDymxnIgkup4fcSRto/xFujKrT2KGrxmL5c0o6RD8cHhRuFpx+jhaNWLj7Rv/1/04e
 et1UFVdNaaoLui3QTgjz9n5/evXIeTZFY4g18tP7jqVgM4p2vzgmDGSzFB6SxuPfakZM
 0+S4YPj7ne7bkx8bqylt/SiWzL7ss9qbzVRUxtrZ1H7mvV8LYch80c8LrMoGsHA+2B7r
 XlXA==
X-Gm-Message-State: AC+VfDy5GHeSGHN1cSeFtSYiYsArMed4aT0ahh2sRduy37t4geanN4nx
 e/VoI6Ic+LksUGVuliQjqon6ixesMNBRC9+u0btLhfAdi4Dd3Nx7HoAkK+p4Nh2JcvpJoK9Soyd
 yG2STzhiDoy2829E=
X-Received: by 2002:a17:903:124a:b0:1ad:e198:c4f2 with SMTP id
 u10-20020a170903124a00b001ade198c4f2mr3736624plh.18.1684509263253; 
 Fri, 19 May 2023 08:14:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4MtQmvQ3nKIZCBB6gkPhTK1KD5hMA1c7kUDgbX4pmnvSe506iC3hYzvEnsdV2W2WWHdGK7vA==
X-Received: by 2002:a17:903:124a:b0:1ad:e198:c4f2 with SMTP id
 u10-20020a170903124a00b001ade198c4f2mr3736604plh.18.1684509262892; 
 Fri, 19 May 2023 08:14:22 -0700 (PDT)
Received: from smtpclient.apple ([116.73.133.89])
 by smtp.gmail.com with ESMTPSA id
 ju19-20020a170903429300b001a64c4023aesm3600450plb.36.2023.05.19.08.14.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 May 2023 08:14:22 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH] acpi/tests/avocado/bits: enable bios bits avocado tests
 on gitlab CI pipeline
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230517065357.5614-1-anisinha@redhat.com>
Date: Fri, 19 May 2023 20:44:18 +0530
Cc: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <501EE8C0-D6C2-4FDE-9747-90932F70EB77@redhat.com>
References: <20230517065357.5614-1-anisinha@redhat.com>
To: Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



> On 17-May-2023, at 12:23 PM, Ani Sinha <anisinha@redhat.com> wrote:
>=20
> Biosbits avocado tests on gitlab has thus far been disabled because =
some
> packages needed by this test was missing in the container images used =
by gitlab
> CI. These packages have now been added with the commit:
>=20
> da9000784c90d ("tests/lcitool: Add mtools and xorriso and remove =
genisoimage as dependencies")
>=20
> Therefore, this change enables bits avocado test on gitlab.
> At the same time, the bits cleanup code has also been made more robust =
with
> this change.
>=20
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Michael, did you forget to queue this?

> ---
> tests/avocado/acpi-bits.py | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> Pipeline is green:
> https://gitlab.com/anisinha/qemu/-/pipelines/869670000
> bios bits tests passing:
> https://gitlab.com/anisinha/qemu/-/jobs/4298116787#L189
>=20
> diff --git a/tests/avocado/acpi-bits.py b/tests/avocado/acpi-bits.py
> index 14038fa3c4..3ed286dcbd 100644
> --- a/tests/avocado/acpi-bits.py
> +++ b/tests/avocado/acpi-bits.py
> @@ -123,9 +123,9 @@ def base_args(self):
>         """return the base argument to QEMU binary"""
>         return self._base_args
>=20
> -@skipIf(not supported_platform() or missing_deps() or =
os.getenv('GITLAB_CI'),
> -        'incorrect platform or dependencies (%s) not installed ' \
> -        'or running on GitLab' % ','.join(deps))
> +@skipIf(not supported_platform() or missing_deps(),
> +        'unsupported platform or dependencies (%s) not installed' \
> +        % ','.join(deps))
> class AcpiBitsTest(QemuBaseTest): #pylint: =
disable=3Dtoo-many-instance-attributes
>     """
>     ACPI and SMBIOS tests using biosbits.
> @@ -356,7 +356,7 @@ def tearDown(self):
>         """
>         if self._vm:
>             self.assertFalse(not self._vm.is_running)
> -        if not os.getenv('BITS_DEBUG'):
> +        if not os.getenv('BITS_DEBUG') and self._workDir:
>             self.logger.info('removing the work directory %s', =
self._workDir)
>             shutil.rmtree(self._workDir)
>         else:
> --=20
> 2.39.1
>=20


