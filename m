Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CF37EDBF1
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:27:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3WmY-0005ZW-9O; Thu, 16 Nov 2023 02:27:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r3WmK-0005Yy-NW
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:27:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r3WmH-0003da-Iz
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:27:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700119624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rD+SVF1LQzFDb9rlYbL6d/DOVjNqfwPhA5Nqawa6W30=;
 b=DwmLxLjiryBFIQKdikqM84H6hxbgK7UXNFisPlwxwtTpx6WiQcN/6/ZNfChRttxIyvHNMH
 fWMoY1urtZ66cKhQ/pXT4etQ2S1WWJN5YKxDdk4pxa351y5mGs/updFaskPkxQPkQureTw
 MscAhxJrsWfvjlEcD4jo0t56hJN3qgE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-y9emHziLMSS8I2sXuaTbpQ-1; Thu, 16 Nov 2023 02:27:03 -0500
X-MC-Unique: y9emHziLMSS8I2sXuaTbpQ-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1cc323b2aa3so6652125ad.3
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 23:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700119622; x=1700724422;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rD+SVF1LQzFDb9rlYbL6d/DOVjNqfwPhA5Nqawa6W30=;
 b=dPnrHt/iUKOIwoB0ayWz3z/j/O6wF4l60lwx2pTkku8ms3PiZf1eVM4XBy4++yIVOM
 0/YJyAYnABu7Otfhvq9kUZg0NPs1W71Gmfl/lQMy0iSaxEJ9vZNkIKdGonkowYaKH4kY
 izOqoIflWP+pu6vuhXSosZm7r27+OP97Os26d+1ZHm3hylf3MkQdB96Bj4UXOPUfswfD
 E/YEfD23quCl8eOt/BwAvhgVkCBb1y7+aerfx4f9BxoZtGUHxrA1SriTUVzlwEN2n87B
 MhuSz8SwWo4JEV4x01J2QAmakx8Ux5ecK5bfdWzNfBhegr9WnAMwg1yw7eNrUTt971zD
 aoaQ==
X-Gm-Message-State: AOJu0YytEmM3nGPRMeqTYd7nxd/07ZpYgVtSanOIEMTKGYcjq6frXD6I
 KT933yCSFITzQuRnKJkXemL+A5w2jXiwU/01TTJWtCHtJrE6R8MJ4G/Jj6/vygGrzT30mPMHpzt
 4XlZd66/dx20PNdc=
X-Received: by 2002:a17:902:a407:b0:1cc:3829:8355 with SMTP id
 p7-20020a170902a40700b001cc38298355mr7464012plq.12.1700119622008; 
 Wed, 15 Nov 2023 23:27:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4cp/2wxnSIbwePJDv3JvnOwlAxs9NJwwpy7GBgj+YIGW5Ztz/nHgHVUcAd21y0CCXgK2/RQ==
X-Received: by 2002:a17:902:a407:b0:1cc:3829:8355 with SMTP id
 p7-20020a170902a40700b001cc38298355mr7463999plq.12.1700119621659; 
 Wed, 15 Nov 2023 23:27:01 -0800 (PST)
Received: from smtpclient.apple ([203.212.246.21])
 by smtp.gmail.com with ESMTPSA id
 i2-20020a17090332c200b001cc311ef152sm8414439plr.286.2023.11.15.23.26.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Nov 2023 23:27:01 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH] tests/avocado/mem-addr-space-check: Replace
 assertEquals() for Python 3.12
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20231116061956.14676-1-thuth@redhat.com>
Date: Thu, 16 Nov 2023 12:56:47 +0530
Cc: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <93A00AAF-40C0-409E-A652-6C752AE63791@redhat.com>
References: <20231116061956.14676-1-thuth@redhat.com>
To: Thomas Huth <thuth@redhat.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



> On 16-Nov-2023, at 11:49=E2=80=AFAM, Thomas Huth <thuth@redhat.com> =
wrote:
>=20
> assertEquals() has been removed in Python 3.12 and should be replaced =
by
> assertEqual(). See: =
https://docs.python.org/3.12/whatsnew/3.12.html#id3
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Ani Sinha <anisinha@redhat.com <mailto:anisinha@redhat.com>>

> ---
> Note: The test has just been merged, that's why I missed this file in
> my earlier patch that replaces the assertEquals()
>=20
> tests/avocado/mem-addr-space-check.py | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/tests/avocado/mem-addr-space-check.py =
b/tests/avocado/mem-addr-space-check.py
> index be949222a4..363c3f12a6 100644
> --- a/tests/avocado/mem-addr-space-check.py
> +++ b/tests/avocado/mem-addr-space-check.py
> @@ -49,7 +49,7 @@ def test_phybits_low_pse36(self):
>         self.vm.set_qmp_monitor(enabled=3DFalse)
>         self.vm.launch()
>         self.vm.wait()
> -        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
> +        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
>         self.assertRegex(self.vm.get_log(), r'phys-bits too low')
>=20
>     def test_phybits_low_pae(self):
> @@ -69,7 +69,7 @@ def test_phybits_low_pae(self):
>         self.vm.set_qmp_monitor(enabled=3DFalse)
>         self.vm.launch()
>         self.vm.wait()
> -        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
> +        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
>         self.assertRegex(self.vm.get_log(), r'phys-bits too low')
>=20
>     def test_phybits_ok_pentium_pse36(self):
> @@ -149,7 +149,7 @@ def test_phybits_low_nonpse36(self):
>         self.vm.set_qmp_monitor(enabled=3DFalse)
>         self.vm.launch()
>         self.vm.wait()
> -        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
> +        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
>         self.assertRegex(self.vm.get_log(), r'phys-bits too low')
>=20
>     # now lets test some 64-bit CPU cases.
> @@ -179,7 +179,7 @@ def test_phybits_low_tcg_q35_70_amd(self):
>         self.vm.set_qmp_monitor(enabled=3DFalse)
>         self.vm.launch()
>         self.vm.wait()
> -        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
> +        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
>         self.assertRegex(self.vm.get_log(), r'phys-bits too low')
>=20
>     def test_phybits_low_tcg_q35_71_amd(self):
> @@ -202,7 +202,7 @@ def test_phybits_low_tcg_q35_71_amd(self):
>         self.vm.set_qmp_monitor(enabled=3DFalse)
>         self.vm.launch()
>         self.vm.wait()
> -        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
> +        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
>         self.assertRegex(self.vm.get_log(), r'phys-bits too low')
>=20
>     def test_phybits_ok_tcg_q35_70_amd(self):
> @@ -288,7 +288,7 @@ def test_phybits_low_tcg_q35_71_amd_41bits(self):
>         self.vm.set_qmp_monitor(enabled=3DFalse)
>         self.vm.launch()
>         self.vm.wait()
> -        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
> +        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
>         self.assertRegex(self.vm.get_log(), r'phys-bits too low')
>=20
>     def test_phybits_ok_tcg_q35_71_amd_41bits(self):
> @@ -332,7 +332,7 @@ def test_phybits_low_tcg_q35_intel_cxl(self):
>         self.vm.set_qmp_monitor(enabled=3DFalse)
>         self.vm.launch()
>         self.vm.wait()
> -        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
> +        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
>         self.assertRegex(self.vm.get_log(), r'phys-bits too low')
>=20
>     def test_phybits_ok_tcg_q35_intel_cxl(self):
> --=20
> 2.41.0
>=20


