Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 061797CCA57
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 20:06:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsoRj-0003Ad-UG; Tue, 17 Oct 2023 14:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qsoRf-00038m-Fh
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:05:31 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qsoRd-0005S5-EH
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697565926; x=1698170726; i=deller@gmx.de;
 bh=0OoZrDGX0kn508RbJVXSvCEZMkYLDpnpK2C7BQumK1k=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=KdRRE/4ZFy26wERcWF6KiP4UPPKc6riCMTNDG8yq766nLV1N97Gf7bDIA99BuGZKKrxgYbq7h+O
 CtggjKm9WL4wJaaNL9iId8eVIQFodMVyd6tOBIHWWxfGqmwt/yYPk6VeA5YyYVQqFmTJXdaaNi9YE
 cJzjzyeZREae6MwJgysDnT9a+T5d3iu32MdtdytwOmdKsrBrmHAgEGHOal13smaCGdc2Pg09+x3w2
 FIt90XQZ+YF6uPiBB0QgogpbI9D/Ky0Dzs+HUCAzS6jFDulfBACnPmBPTYTp3C+Oo6zzu8Nn+oiHP
 25kcsGACq6QSjQOpL6CsYbxAb8IkDRcIAOJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.144.254]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7sDg-1qwgKa0S2c-0050KZ; Tue, 17
 Oct 2023 20:05:26 +0200
Message-ID: <e6dbd713-36ee-417e-93ff-026edd4e5592@gmx.de>
Date: Tue, 17 Oct 2023 20:05:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] MAINTAINERS: Add Astro PCI host for hppa machines
To: BALATON Zoltan <balaton@eik.bme.hu>, deller@kernel.org
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
References: <20231017154645.95844-1-deller@kernel.org>
 <20231017154645.95844-5-deller@kernel.org>
 <9a52309d-d5af-d572-aea0-e5315b301e3e@eik.bme.hu>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <9a52309d-d5af-d572-aea0-e5315b301e3e@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lvNrtgd5Qbh44YJIriaXTtlmbwfk4tXsePv7m96sVj2fjcqD+7B
 mJLilcXu+8eEkRyE6BWH9hjz5ZuKnihz9HRRadX40ynslpegCbmpfVuf++21Rq2gIzVFR8b
 sfHF9mngHT+mclFO+Md9pQShsRvZNcMSQNE9j3YvN2xwrjT1hsFSt1j12nbizXMtnhslfcF
 8kTALges6tfzvgfhWO+nQ==
UI-OutboundReport: notjunk:1;M01:P0:LelnzLma1eI=;lDIPAv/vxleMnLIuJcEn4aZTLD7
 TWBmGJTaJInMi2m3yTXEYwjkVbdHqd5PfPxKvnA8oDiUgGFpDZJonaRpfZCuJ+kA301TMbjky
 2dpX2iXAkTxxiUDvK1/TJkTr6GCgLGnhV10+qhLV4XCa1LYh1AnHXGwc2lZyfjd7nhaIKRcsH
 cf8t0FwnHRwo+sRFAM8WBcZEpPXLrRz5p1g4EFyOstqLuPcWBSWDaJTkJcEt0XbCnuC9FfTz2
 fuBTSJkGJc0P2XbzeFp6+Ed1gmuKKgOruxStuBcXcEzwxAcKZzyir2h2CpZITvpLXU+Csvzvb
 aEK5Wt9muV2UAHaEXNgxyOdwEVbx09i1UQP5js3xPW3ikyqLlouu1XglP6qu6HAm4xSSLxclq
 wheiIAgWTLgZ9JZ79e+VWGnmMl8r2yG1Dh9HVm1vWGiWMmCsJYiXf+U3pmRVmVBObNFMcy20j
 hZEIL3dGQ5iFhXFLb0NpmGGJwxCx4vAg1wpWrNFe0nCTDacFxG3SXuWngzgXVCuy093UEuvlz
 Iisrj0i28RC9l7z3Nlm5jtwy6o1QxP9VJADF691g9pHjYQtovPCqVPtqTZlwg++2Ai6sSEZCG
 T31bZrrnv/x4fYu2BWjMStPcUuaNhbdB5PbuUZEUuYK8GHKJ+K3XTUGUganRHOtTQpGrBnWMf
 qq9hRijBhFeFfJTBjP88rqPNdHDc7ooJiqctYAmoBrg83PQE30ZBXrNGArbDpFKLxTRt91GoD
 kfr+YLWO7lgzm7lwaajcNW/SxqoTQ/VQk04/TuRnNcJSJ8AuUIoIwx75wKK1Rb+Sb9/khYp/b
 ZZUiSwS6GgqDe+ct0vbaYj8F/uhG78IsNvDPgfQkZBSNIwX1xrgCaTGBh1ffHE2pMRZVEDQCK
 EXJpU/dtQb1G0InSWkDB/NVGCjNNzx0ubZCAcsmRHq8RwU85p3sDg0zQGLyO4b0+2jB+4/Mro
 5EB+/IiUtvsI3eiI95Ct/EieYKg=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/17/23 18:19, BALATON Zoltan wrote:
> On Tue, 17 Oct 2023, deller@kernel.org wrote:
>> From: Helge Deller <deller@gmx.de>
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> ---
>> MAINTAINERS | 5 ++++-
>> 1 file changed, 4 insertions(+), 1 deletion(-)
>
> Is this better squashed in the previous patch adding this device?

MAINTAINERS is updated by various patches/people, so keeping
this change seperate makes handling and bisecting easier.

> Then checkpatch won't complain about that

It's just a warning, IMHO similiar to a reminder to update it.

> and splitting out just this does not make the previous patch simpler > s=
o not sure it should be separate patch.

I disagree.

> The last line adding seabios is not mentioned in commit message.
> Is that related ot just a fixup while you're there.

Yes, I noticed that this directory was missing.
So, I added it while updating the entries.
IMHO this additional change is so trivial that I don't think it needs to b=
e
mentioned.

Helge

> Regards,
> BALATON Zoltan
>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ceea4c2bf2..68d086a0f3 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1174,7 +1174,7 @@ F: hw/*/etraxfs_*.c
>>
>> HP-PARISC Machines
>> ------------------
>> -HP B160L
>> +HP B160L, HP C3700
>> M: Richard Henderson <richard.henderson@linaro.org>
>> R: Helge Deller <deller@gmx.de>
>> S: Odd Fixes
>> @@ -1182,11 +1182,14 @@ F: configs/devices/hppa-softmmu/default.mak
>> F: hw/hppa/
>> F: hw/net/*i82596*
>> F: hw/misc/lasi.c
>> +F: hw/pci-host/astro.c
>> F: hw/pci-host/dino.c
>> F: include/hw/misc/lasi.h
>> F: include/hw/net/lasi_82596.h
>> +F: include/hw/pci-host/astro.h
>> F: include/hw/pci-host/dino.h
>> F: pc-bios/hppa-firmware.img
>> +F: roms/seabios-hppa/
>>
>> LoongArch Machines
>> ------------------
>>
>


