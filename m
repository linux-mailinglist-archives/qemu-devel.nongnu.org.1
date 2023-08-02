Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0537376CAFC
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 12:37:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR9Ct-00027T-LX; Wed, 02 Aug 2023 06:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qR9Cr-00026x-JP
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 06:35:53 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qR9Cp-0004YC-RD
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 06:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690972545; x=1691577345; i=deller@gmx.de;
 bh=WwLtvyuOJLlUdlHdN5jJaI3FN88JOZ6iUWfOaM84jWM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Y0oQT3gt4pkuimKZaEHtpaidQtUiZsNruQlqclen/w0JhDjSebNPP1boNu2IzpytJA+Ex7z
 77zUl+L6cJtkeUryAPShz9p94Fv7lOeSBujuWv5/Pi0g+h4ei0LnKIGOmN7yxtSoZiFQdhb+Y
 AeMYJD/Kbj3YF84cmq2Gi5E4a6mBZeUpuJ9rbtSarFE83+gTkAo85I8Os9aQDJFIblU7wvunD
 aWOhGERxmr5Pdh0ziEr84HXu8oolVPJ/L5BkfC3pNDqJKV7kjzmJIi795NvskVhxfgPDb/Z+v
 0A8JY/aPwNKqi7vjEw+eeBAwAjIc7UIHTl0TDzu3Pamjolu+HHgg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.146.69]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6lpM-1qTtZH3KG6-008Ld2; Wed, 02
 Aug 2023 12:35:45 +0200
Message-ID: <cd2f661a-19bc-d6af-24f8-954ec7b68f13@gmx.de>
Date: Wed, 2 Aug 2023 12:35:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 8/8] linux-user: Load pie executables at upper memory
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>
References: <20230801232745.4125-1-deller@gmx.de>
 <20230801232745.4125-9-deller@gmx.de>
 <6126807c-2390-27d9-315d-de67c31a8f60@daynix.com>
 <c1e68eb1-6d26-22fd-8c51-c1ba1e472187@gmx.de>
 <6f73b04e-7c85-0dfb-c3cc-7a43b4663593@daynix.com>
 <69247c58-52c4-65c2-8d08-c553adda0d9d@gmx.de>
 <bb3d5dea-5c64-862b-b3b1-6d18c9fba5b4@daynix.com>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <bb3d5dea-5c64-862b-b3b1-6d18c9fba5b4@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gB8JquA/nl5brfacYIyZBlS1ubqDAgoYgWbFZ4a8YjetpIaUpr3
 JHAbiDMNKWqGRn0/NUFz7f2h0WIOCQwYudwQ9fu6G2RCRRz35JJb3+Jo1Rc73W+zWNqUYyq
 O4+8mLcJKRXwpI6j5Jgfvybnq8CW5h+qkBaMiRliy7j3r+4pX0V4CXBAwRC656Sr3TKy/xA
 GSkkQJ04OhXaNduplpaXw==
UI-OutboundReport: notjunk:1;M01:P0:kCs98fp2OPQ=;E1h+hnnV7kePP2UdHHQymkEY6OJ
 WlHyFF6wBn5r5TnPZi6gUxXO6nMwVz1h0nFPNpgyo1VfiuCDVhJUSKR/SqR3k2v0sDd3innAA
 xLe3H89+AxZofSnffyEh2YiGoZvnLNdl/Sx4ripdCMdjIMFlJ5j/enSBg+YbTwt9cUsSYqHcD
 qFPxsHEQdKFUx1Mdur69qY/dZOSKMteVSo02m3snfs0W4J1d0+VHypO71Xpn/zDkEdTEDkut+
 fYIzXUDgmZpttI3BS4TnYZtG6s663U5YRFRRI5HpbrDk5Y5sUi1CJcXRRSIUxIrhDdkVU5rsz
 Xmj2/ZKGdosdD6Lk/dbjfsERHhlP97D0K9ftmuu0muAFIIbtoy/t7A+Qgt+zvKRct1PGo3mnR
 DpFMAko93nJyy55IwJ2Lk50qLD1+KQ+B7ZVcDQDL7bXRU/AQvmIOIjVPLezlglK9Fw5BGvTDu
 2oVzkm/Ww8bGOW4BD9WgkUAHF/DpJHKHol+veBLEPl69KcEgjm0KtQXNiUtdlK53RURfQRwpq
 drG02I4dk4A2B87mwfvnA1vNTMmVSi2ZK6nrikCxP39rG3DP6QEhQKDxMOnd29jdeebMWOZpJ
 9+IK4wyE6OnZfCJMtyqhcA303UA/DK+SsD/0hpBI71/rxPCLzIfPZk3BslorhsrEiG9lzencM
 pZvMCOdKwXh0od4TAWbUG8Vck2lBlPudrJstCR9dC3EvOQDgboVEKueL5Nepj1k4oDNi2RYme
 yi4IiIZPLG2dkmvCqZQWzB34XFaXk0Qb94QxF2fQ7Koe4MJeOP0GXwZSGybj2vHHoJAkZBBNl
 HHQwIAjSL8VJVynKDPoudswFQoUP723OiFh6i5MT4hBbNBnZjx6t/ZSFRdcWKjUr2aUXmVyra
 2k6hc3vHHwwL/GtA0ZZwc+6mp0g29fjWjSsSsr+2Irkdl6ojSRv1cn8k1U4jbaXSiX6a3In+x
 QqmHt7NVD4euDHTaWeOFuEDaHrA=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.092, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

On 8/2/23 11:58, Akihiko Odaki wrote:
> On 2023/08/02 18:34, Helge Deller wrote:
>> On 8/2/23 10:44, Akihiko Odaki wrote:
>>> On 2023/08/02 17:42, Helge Deller wrote:
>>>> On 8/2/23 09:49, Akihiko Odaki wrote:
>>>>> On 2023/08/02 8:27, Helge Deller wrote:
>>>>>> Fix the elf loader to calculate a valid TASK_UNMAPPED_BASE address =
for all
>>>>>> 32-bit architectures, based on the GUEST_ADDR_MAX constant.
>>>>>>
>>>>>> Additionally modify the elf loader to load dynamic pie executables =
at
>>>>>> around:
>>>>>> ~ 0x5500000000=C2=A0 for 64-bit guest binaries on 64-bit host,
>>>>>> - 0x00300000=C2=A0=C2=A0=C2=A0 for 32-bit guest binaries on 64-bit =
host, and
>>>>>> - 0x00000000=C2=A0=C2=A0=C2=A0 for 32-bit guest binaries on 32-bit =
host.
>>>>>
>>>>> Why do you change guest addresses depending on the host?
>>>>
>>>> The addresses are guest-addresses.
>>>> A 32-bit guest PIE can't be loaded at e.g. 0x5500000000,
>>>> while a 64-bit guest PIE needs to be loaded at 0x5500000000.
>>>
>>> I mean, why do you use address 0x00000000 for 32-bit guest binaries on=
 32-bit host while you use address 0x00300000 on 64-bit host?
>>
>> To keep the memory pressure for the 32-bit qemu binary minimal.
>> On 64-bit host we have the full 32-bit address space for the guest.
>>
>> Helge
>>
>
> That makes sense. I'm worried that using 0x00000000 may break NULL check=
s on the guest though.

probably not, because 0 means to search any free space.
It's not fixed, it will be searched from there.

Helge

