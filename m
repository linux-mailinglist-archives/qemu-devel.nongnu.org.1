Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E98417EDD00
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 09:40:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Xut-0007xi-G9; Thu, 16 Nov 2023 03:40:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r3Xuo-0007xS-Fj
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 03:39:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r3Xul-0007FL-RB
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 03:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700123994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GC+9Eqff3/u7vLkLT3eK8qGzH9gHz0C3DnuxrbBf/g4=;
 b=jO6aWDFqk13oMXVZ1IpcaBiYs5CIxd1ENWtHLTG+LaDBUKdyl+b+QADFHAhNwCiDyaTtuT
 1gNwZWdNtUBQkhXkcyocCnrczTybhm51KB0vZ1chm48GENy2yzOk9+sxPdkRbGc4ol9Olm
 uNpyyv3vqAdzBjyQb/u0bB867iaLR58=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-ysaNz1vhMc2ejgUlcETpUA-1; Thu, 16 Nov 2023 03:39:52 -0500
X-MC-Unique: ysaNz1vhMc2ejgUlcETpUA-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-da03390793fso709995276.3
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 00:39:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700123992; x=1700728792;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GC+9Eqff3/u7vLkLT3eK8qGzH9gHz0C3DnuxrbBf/g4=;
 b=iuZCp0QkEpiYUYXw6qfrumlE2Jo54iyzM5DfMNJnNhgn8qozEitNDy+qro/kCYEKGc
 cExD0efYUZZgswWm9WlAirEmqYmOUtvF9uOB5xJaAZmaMiaXCkpcjH8PZz1PEolfPzqW
 OKs3WGA+GCC3+OnEj9M+u0YOzkmFAVuwrMiU+/2WEps+XdxiQ5TIA9THmiK3VQQhw7mi
 IRqGxuSoIB3rJJkde7X/EMud/UpIaQMaycIAKIkLehztE3YhDQJrKDM6HjwbJFMxm6mK
 wd9ze3k+Cwzfb1zgRs3F1z8+vG0zPQQ9SA20Z7clTTKGVj16AAX1A0YPUx7bNkZDVhKH
 KXzw==
X-Gm-Message-State: AOJu0Yx+fRFUMg7fKJeEoZxPHSbueY0j139ImpJ6vVHE0C2sSJo6mCRu
 atiTbogeHp9bvuN1jLCtXeCGvbNWzfewTWJeuLLhpn0tY+4Kn2qj9fr+7QDgyF26S+UpsKlGETd
 kZs4/OgPTMEJ9S1Y=
X-Received: by 2002:a25:df46:0:b0:d9a:c218:817c with SMTP id
 w67-20020a25df46000000b00d9ac218817cmr14393520ybg.4.1700123992295; 
 Thu, 16 Nov 2023 00:39:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIcLGiU1cIKgBBQKgiud8i99BHa2874DS+pf0y0tSqsyvS4xfxptCl0OFQQmcaINAGDD+30Q==
X-Received: by 2002:a25:df46:0:b0:d9a:c218:817c with SMTP id
 w67-20020a25df46000000b00d9ac218817cmr14393503ybg.4.1700123991996; 
 Thu, 16 Nov 2023 00:39:51 -0800 (PST)
Received: from smtpclient.apple ([203.212.246.21])
 by smtp.gmail.com with ESMTPSA id
 h18-20020a631212000000b00584aff3060dsm2389887pgl.59.2023.11.16.00.39.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 16 Nov 2023 00:39:51 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH] tests/avocado/mem-addr-space-check: Replace
 assertEquals() for Python 3.12
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <93A00AAF-40C0-409E-A652-6C752AE63791@redhat.com>
Date: Thu, 16 Nov 2023 14:09:37 +0530
Cc: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <85D49122-890D-4F9E-88C9-B50BBE4FBE8B@redhat.com>
References: <20231116061956.14676-1-thuth@redhat.com>
 <93A00AAF-40C0-409E-A652-6C752AE63791@redhat.com>
To: Thomas Huth <thuth@redhat.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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



> On 16-Nov-2023, at 12:56=E2=80=AFPM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
>=20
>=20
>> On 16-Nov-2023, at 11:49=E2=80=AFAM, Thomas Huth <thuth@redhat.com> =
wrote:
>>=20
>> assertEquals() has been removed in Python 3.12 and should be replaced =
by
>> assertEqual(). See: =
https://docs.python.org/3.12/whatsnew/3.12.html#id3
>>=20
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>=20
> Acked-by: Ani Sinha <anisinha@redhat.com <mailto:anisinha@redhat.com>>

Acked-by: Ani Sinha <anisinha@redhat.com>

>=20
>> ---
>> Note: The test has just been merged, that's why I missed this file in
>> my earlier patch that replaces the assertEquals()
>>=20
>> tests/avocado/mem-addr-space-check.py | 14 +++++++-------
>> 1 file changed, 7 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/tests/avocado/mem-addr-space-check.py =
b/tests/avocado/mem-addr-space-check.py
>> index be949222a4..363c3f12a6 100644
>> --- a/tests/avocado/mem-addr-space-check.py
>> +++ b/tests/avocado/mem-addr-space-check.py
>> @@ -49,7 +49,7 @@ def test_phybits_low_pse36(self):
>>        self.vm.set_qmp_monitor(enabled=3DFalse)
>>        self.vm.launch()
>>        self.vm.wait()
>> -        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
>> +        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
>>        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
>>=20
>>    def test_phybits_low_pae(self):
>> @@ -69,7 +69,7 @@ def test_phybits_low_pae(self):
>>        self.vm.set_qmp_monitor(enabled=3DFalse)
>>        self.vm.launch()
>>        self.vm.wait()
>> -        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
>> +        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
>>        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
>>=20
>>    def test_phybits_ok_pentium_pse36(self):
>> @@ -149,7 +149,7 @@ def test_phybits_low_nonpse36(self):
>>        self.vm.set_qmp_monitor(enabled=3DFalse)
>>        self.vm.launch()
>>        self.vm.wait()
>> -        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
>> +        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
>>        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
>>=20
>>    # now lets test some 64-bit CPU cases.
>> @@ -179,7 +179,7 @@ def test_phybits_low_tcg_q35_70_amd(self):
>>        self.vm.set_qmp_monitor(enabled=3DFalse)
>>        self.vm.launch()
>>        self.vm.wait()
>> -        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
>> +        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
>>        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
>>=20
>>    def test_phybits_low_tcg_q35_71_amd(self):
>> @@ -202,7 +202,7 @@ def test_phybits_low_tcg_q35_71_amd(self):
>>        self.vm.set_qmp_monitor(enabled=3DFalse)
>>        self.vm.launch()
>>        self.vm.wait()
>> -        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
>> +        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
>>        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
>>=20
>>    def test_phybits_ok_tcg_q35_70_amd(self):
>> @@ -288,7 +288,7 @@ def test_phybits_low_tcg_q35_71_amd_41bits(self):
>>        self.vm.set_qmp_monitor(enabled=3DFalse)
>>        self.vm.launch()
>>        self.vm.wait()
>> -        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
>> +        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
>>        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
>>=20
>>    def test_phybits_ok_tcg_q35_71_amd_41bits(self):
>> @@ -332,7 +332,7 @@ def test_phybits_low_tcg_q35_intel_cxl(self):
>>        self.vm.set_qmp_monitor(enabled=3DFalse)
>>        self.vm.launch()
>>        self.vm.wait()
>> -        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
>> +        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
>>        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
>>=20
>>    def test_phybits_ok_tcg_q35_intel_cxl(self):
>> --=20
>> 2.41.0
>>=20
>=20


