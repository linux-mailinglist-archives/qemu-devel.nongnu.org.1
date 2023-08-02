Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4848E76C98A
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 11:35:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR8Fv-0005jt-BF; Wed, 02 Aug 2023 05:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qR8Ft-0005jg-9M
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 05:34:57 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qR8Fr-0004i2-LJ
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 05:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690968889; x=1691573689; i=deller@gmx.de;
 bh=tdgs4KW+xkbZJbGwQY7aQabzJnhlfj3zKjPHnL8Nmqo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=F99IeZsmoCIp3n9Klpzh9lXYm1m9nV3R3LK9so29uQkVMZdi9+z09tal7Z9qRrripKf5UF9
 f88fdal+ZZLwIUoyYILgKRwieEZPvpiBmMJGN/1z9FAf0TSCxpNwrkR71ui+JuyVTLU1blCza
 drzLlZOlYDocc9CL3cestwqoQq3OhVXbY/UfP7FTz44tkMZPrlwGK2Qd4QegQi4xnBqFjurVX
 azclLTPX9etiDXhrCmUj0tZMX3VqXa3ugUgMqTHqIyJKSWNf4Afkzh/C5Es2ck180tKZB2rsW
 Z9gyZUDLKL8Samu5u8yjAflnR4bh7Jxz06PsfOkBhJ3t2xS+8xWw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.146.69]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Hdw-1qOOA73FG6-002oA5; Wed, 02
 Aug 2023 11:34:49 +0200
Message-ID: <69247c58-52c4-65c2-8d08-c553adda0d9d@gmx.de>
Date: Wed, 2 Aug 2023 11:34:43 +0200
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
From: Helge Deller <deller@gmx.de>
In-Reply-To: <6f73b04e-7c85-0dfb-c3cc-7a43b4663593@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4sdAVNYuHNeDKi/2H157HOVH3ARSnMqWTGmRyaLi36NvfscAdYP
 JzcrqS0iK/fMNFwDhIM+hyRD39ef3ApKleBSufWzWdzJZ97YzLK6/3zjhJVm5ASW04zQ8Ar
 9trR+XNd0SEfXoEpNPsfQSRCzKWHpjWM4kJjfK12691ETDvjfLXft4wm2u75eh6MyWrZJ0X
 yxmgJTmkrtI0oUDz53MOA==
UI-OutboundReport: notjunk:1;M01:P0:tjSQbtzsAQM=;/GjugZ5Or2f/jVBLJO7NrZi+c6B
 5ZHh0qctQomhNbdKslUgHQldDKx0EhDrpQMc6wOyzcYDvG1UvY9UMF4oen5dqU9MCXkN/sjWh
 aDjCO7ejGzj0Xc+A1FlPTIDJdGx03iQ92DkAQKxfqTjH/vD98CgWhnQOXBWkj+1atUzdZWTUs
 2PNAhoUzcMsjk3PZGdCjN4K8i3r61GLufDM4z6irJRXd5t8u22uDsjECK/6KIGjPaAG3ZOt6Y
 7m2rHVT3P7OMt1q8KI7nargzOc1V2uoWLZvrRgs8QnKkSDf9XqSbWgp82TJ+V5o/eAfXAtBoS
 6RrMHRQSvmRyNppxVwNuaLNFDyQhFA2zdr2xSaSim2sCR14dlidNHnhovbMJcs4WP95ijfsZk
 7pCBDyLEjv1IEdtgjaejVsLABhq6b72pmJnd09kC/iPT/DtmgjdW2uNWM+6fjOaSKufYs41Wk
 S8I9q/eptPoY7pVZZdacRMiFlfPc+OYhAmVCx+Vcgyk7OOOurHPwwf/ZLCCjP5xL3xdFCTz2C
 xS6E8MalhYYEtB4pa/39xgIW2NSpDHKr7owJRDmRO9WgU7bCnl9nK7bnANr+3iKRmc8E0v6R6
 hYtmcpECVYZq2HYSgcssUTNBZ3adm1QvaPrwDPDo9BIDLSkzRGDphKHMWqZD2cqVwP577NTo0
 riyM9duV4HOL8vRSyk5PgA+oIq7POErSXwflhboIMNW2WYEz3gecHt8YwuI0Jxj1lWmFIveri
 csMRjytoaMl+xkqZ+r9NhqQ3Nj38jmOa4pSuWZP9MiSUvz9n6yMX0565G9WIxJJd2lZilxuVw
 IRNFh0qLLsSB1cvBoqdEB/Rz6YyjLRiXO+qs0GA3QxnuFEKleuaLFYjaLxiPpWAdf5rFfgNdS
 VXEFUmCGYWmxSUCMUfcBoy+P+kIwoJyCbljz1j57xKZLosXFhdTYwgKoHeDLwfqMhLZIWpFxf
 dCrMkqprhw5PufEzd3leSikeFbc=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
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

On 8/2/23 10:44, Akihiko Odaki wrote:
> On 2023/08/02 17:42, Helge Deller wrote:
>> On 8/2/23 09:49, Akihiko Odaki wrote:
>>> On 2023/08/02 8:27, Helge Deller wrote:
>>>> Fix the elf loader to calculate a valid TASK_UNMAPPED_BASE address fo=
r all
>>>> 32-bit architectures, based on the GUEST_ADDR_MAX constant.
>>>>
>>>> Additionally modify the elf loader to load dynamic pie executables at
>>>> around:
>>>> ~ 0x5500000000=C2=A0 for 64-bit guest binaries on 64-bit host,
>>>> - 0x00300000=C2=A0=C2=A0=C2=A0 for 32-bit guest binaries on 64-bit ho=
st, and
>>>> - 0x00000000=C2=A0=C2=A0=C2=A0 for 32-bit guest binaries on 32-bit ho=
st.
>>>
>>> Why do you change guest addresses depending on the host?
>>
>> The addresses are guest-addresses.
>> A 32-bit guest PIE can't be loaded at e.g. 0x5500000000,
>> while a 64-bit guest PIE needs to be loaded at 0x5500000000.
>
> I mean, why do you use address 0x00000000 for 32-bit guest binaries on 3=
2-bit host while you use address 0x00300000 on 64-bit host?

To keep the memory pressure for the 32-bit qemu binary minimal.
On 64-bit host we have the full 32-bit address space for the guest.

Helge


