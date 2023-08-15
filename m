Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F210677D556
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 23:43:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW1oB-0000z6-35; Tue, 15 Aug 2023 17:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qW1o9-0000yy-Ii
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 17:42:33 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qW1o6-0007Cr-Pu
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 17:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692135745; x=1692740545; i=deller@gmx.de;
 bh=i9wqeGQNpMhovH1K2/s5+E9EAPaixU87ZvqLEWqRDVs=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Lvo5/JYITWsMZuMKi4a3487aMmZ3xvo5LphX9itazhxDiNWkFsXPtDYgB1M4d14mExSWAUK
 5PvWIi/gsHcLu5NiudViS2Osf7fG1HWlUQt2MWOjdffdXhv0xuFoPDcsrUj1fl0CB1gxe1zn5
 3gNEiBESfC8XOSBcALPWwD6pyHhkRGoUroXjd2rCUbSQJalzuIXpQGybWDi3U37EkzXwkzlbk
 ygzdwMw8K2wfhfdLt8MfGUJV0qjxNkuIkWIF3w0syr5aiVGPHB/yDTRd9E2LGre/yZuV7YaqY
 Z9ssmCapq8ZKsjsxxPxvWsgmr2sIAjmfQlgRI0rhye1yW1grRedg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.159.222]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0oBr-1pbR9I0W9d-00woYo; Tue, 15
 Aug 2023 23:42:25 +0200
Message-ID: <6d7e7c36-b892-abd2-0d5c-9e9882f1acf5@gmx.de>
Date: Tue, 15 Aug 2023 23:42:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 00/14] linux-user image mapping fixes
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20230808210856.95568-1-richard.henderson@linaro.org>
 <35fa0e0c-ca69-a84a-02a0-4edcac65adb6@tls.msk.ru>
 <59d8d261-be68-dd60-f3d2-547b4e8dca94@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <59d8d261-be68-dd60-f3d2-547b4e8dca94@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7i1KBbPnKUeHLHI20avvj2JiKTzJakLE90i3DElh9E+I3J5Ni21
 kEmXNNxn3JCJVNrZgYYgoTXAb4p66H20mHXncQUZCVR9qYuBd61PzacwHHttwzpSA+XJ1uE
 qtgeBe81GaVn82xxjIut8iUcF03kEDNe2y0UQnUXMn3x44gWrHR4XZJdCdDOiNC1Is+8ybd
 P4yxpBxc6xJ/4KwbMUQsw==
UI-OutboundReport: notjunk:1;M01:P0:Lk7QqXJBTWs=;J1E3nIqzHhNU+R2IBAaX7hFyosB
 gE4QLQZuY4JVOfwFBzL2UMA+6Q+gn3R2rO+eIlKx8epxItXfj+osnxxIpz2WdlnYrMnh5vc7i
 XeY0Jw2V4QErzEwsWn8IsuXi017f303tqQzFF+8KHy9uY9kZK9HqggLiyLFuiQZRkJ0lptT2P
 2jDiJTwDXRsdcCrGhkkSgl7nEzyGOHEQodJj8k0ta2D6BdqodUA8L+S3l6YYbJU84RMRHVhIV
 AEiCT26uLCaNM0H546gvJAUv+Gh8j/+G/akgMjPrsLpJDZlnmwDgrksYQ5vWeIo/Xvy5cZzYI
 Mh2VK1at3MNWUL0GHp9+CmuvibEWpxkkXLJTQRUIgrXX8B4Xxt4gE44OoWihlqBonhQXK1FZJ
 nuSRf/kICme0ottLokfAJ8JxSEvjp3Dy2sc8fn9DyR1LfFrgDXHdBImZkeocJ9UzJmGNZz5pv
 aVkDe4rWiMOr+swnxv51SYexeh/kazw83P5pMfA19o3igf+5hidEI5U/a9IbPtB6ErXGX3ycy
 A25WbugnyLCw2noIefE+fqjZuLmQnkOMFeUJ1hdISr9dxmmhOiQvFpAVe+RNlbB2+/fEQ4Ajl
 FdTyTZtOueO2gE7gmsUH9QW+S0ye53kahuP+VaQOBxohA0e+Q69BgK3llhXyvmZbOozyB9d+c
 4fajTIj/jZ2PqPnRVz1VGSNuB0pRjjiTHXNCRZ/Q56ZgpOkOvqFok4AWgNAdMKeOyb93ZydOM
 IrdAe2bH6c2joEqBuGAd9PzIZdertbtzxubMgTXBAHBemAx1l1L70USh7rc3UVxAskn67pIoI
 uP11IBB7jJNOVsylG8U7QTjW8afUk+OLL4R0xAvM5a29Qq5UNc2maqip1kUdAPzIFQAwf3eSM
 +AcCz6YjBWB2wlmuEwnhL0cPCN09zts+NSXpLlO1fELJfbYOr+N8Vfga07NWD8F2/Ef6IDHVH
 cQCRFnuIbK4jNpk2zIAoz7Pk0tE=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-1.045, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/15/23 23:09, Richard Henderson wrote:
> On 8/15/23 06:51, Michael Tokarev wrote:
>> 09.08.2023 00:08, Richard Henderson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> The following changes since commit 0450cf08976f9036feaded438031b4cba94=
f6452:
>>>
>>> =C2=A0=C2=A0 Merge tag 'fixes-pull-request' of https://gitlab.com/marc=
andre.lureau/qemu into staging (2023-08-07 13:55:00 -0700)
>>>
>>> are available in the Git repository at:
>>>
>>> =C2=A0=C2=A0 https://gitlab.com/rth7680/qemu.git tags/pull-lu-20230808
>>>
>>> for you to fetch changes up to dd55885516f42f718d0d121c59a5f7be5fdae3e=
6:
>>>
>>> =C2=A0=C2=A0 linux-user: Rewrite non-fixed probe_guest_base (2023-08-0=
8 13:41:55 -0700)
>>>
>>> ----------------------------------------------------------------
>>> linux-user: Adjust guest image layout vs reserved_va
>>> linux-user: Do not adjust image mapping for host page size
>>> linux-user: Adjust initial brk when interpreter is close to executable
>>> util/selfmap: Rewrite using qemu/interval-tree.h
>>> linux-user: Rewrite probe_guest_base
>>>
>>> ----------------------------------------------------------------
>>> Helge Deller (1):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux-user: Adjust initial brk wh=
en interpreter is close to executable
>>>
>>> Richard Henderson (13):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux-user: Adjust task_unmapped_=
base for reserved_va
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux-user: Define TASK_UNMAPPED_=
BASE in $guest/target_mman.h
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux-user: Define ELF_ET_DYN_BAS=
E in $guest/target_mman.h
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux-user: Use MAP_FIXED_NOREPLA=
CE for initial image mmap
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux-user: Use elf_et_dyn_base f=
or ET_DYN with interpreter
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux-user: Do not adjust image m=
apping for host page size
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux-user: Do not adjust zero_bs=
s for host page size
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux-user: Use zero_bss for PT_L=
OAD with no file contents too
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 util/selfmap: Rewrite using qemu/=
interval-tree.h
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux-user: Remove duplicate CPU_=
LOG_PAGE from probe_guest_base
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux-user: Consolidate guest bou=
nds check in probe_guest_base
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux-user: Rewrite fixed probe_g=
uest_base
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux-user: Rewrite non-fixed pro=
be_guest_base
>>
>> Is there anything in there and in other linux-user late fixes which are=
 applicable to 8.0?
>> Or should we declare 8.0 as semi-broken and be done with it?
>
> Let's wait a bit and see if we're not just exchanging one set of bugs fo=
r another.

Yes, and I think 8.0 isn't in that bad shape?

Helge

