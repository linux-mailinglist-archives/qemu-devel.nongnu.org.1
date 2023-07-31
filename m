Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7F4769FA6
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 19:44:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQWvb-0000ZW-Ey; Mon, 31 Jul 2023 13:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQWvU-0000ZD-L3
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 13:43:24 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQWvQ-00079Q-Bz
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 13:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690825397; x=1691430197; i=deller@gmx.de;
 bh=fyDLmH4UDGq6wbYWGGkkfJLXTU/rSHKOAyAMK8+uD8s=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=Wu9iYPXU7UXpswmlyVdBqCEzkdA8bS5n80g173TtwDtq74qq71Xhjvpw9FzjgrBy9rv9lye
 m6aqTDOeDOJb6+V4wQ3v1RIe5wvRqYZM8xvYy/nXxAZv2oxQfGXA52N9lmybpPRH7Skr+Vl+l
 nHSO6KWJjIeiAthOgLVoH3dBbftdJRtQHYfFNH1dBBa9bm2jICTyvQ1cE5LC9tzFjlwgeCNRN
 ISIy7SuOqFj7TXRYvQ/3diGJrisapUzSmCwFmmQWUI/FnTxvwyf2/boHRF8GguFpJcgJvxSOx
 3DmWZs8z4cR2a4gbTCPVwIGJi7jmS4Jc44RrKnJOc/fmwMht1zRw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.159.238]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M89Gj-1qU5QM05fH-005F6j; Mon, 31
 Jul 2023 19:43:17 +0200
Message-ID: <c3ed33f0-998d-5386-1880-22436af149b7@gmx.de>
Date: Mon, 31 Jul 2023 19:43:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/5] linux-user: brk/mmap fixes
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Joel Stanley <joel@jms.id.au>,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
References: <20230731080317.112658-1-akihiko.odaki@daynix.com>
 <3088d223-64fd-9aab-3c08-000f0924607c@tls.msk.ru>
 <CACPK8XfcOkn281JZNYc7+AhDAxP_N9__G4Snxtx=ZhXgVChXgg@mail.gmail.com>
 <0643c953-bfa8-45a9-5b07-714bc18c03a6@daynix.com>
 <57d9980d-b881-b16e-844a-e651d6d09de7@gmx.de>
In-Reply-To: <57d9980d-b881-b16e-844a-e651d6d09de7@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nYAXd0sAryRBLgglhlJYcZ5vboomwVPHUkN7+0is7YJvDldtcSq
 BFmo6L7fes66O0QtKzb/Vj49g+1N0oQGGTrI53oXPtF7r2lYImNP/J8fSvmPEWI8JBDOs14
 3qoO2pSa6vZ2zV39FfW7cfOSEqGpckH3XnsGv74FVs06OeXb/xfkQLYVfN7e8eeCHXJ+Y2e
 P/i7aWkbq0BvDO+83S9xg==
UI-OutboundReport: notjunk:1;M01:P0:MW14eKMHfpA=;5g1oWBKePIWulx/OyP6Hgr9O4Yh
 XMvz+Gmijr35FxkBTxAkKnNOhO3iBuU6+pFUBtF6e6whD0WatKF2vIh5Vz/JlUyaZ9ZFbvl72
 gk0DepN3xAy4Wnq+N5eoEmMPviUz+MTPotC+vuSTmY8y+KlzfSYgP9OlNgmQzFBiFZgXhkJ8t
 eqLlJNvz4Q/ZdTkhhnfqq5VAQeBkfzrymzL426KrxqDeiwGavJyetWasjRYpjeNqKRSXB9Lnv
 ytH5xeEclImtwcpeXhxTtcKFaynCX4U829wgeKIblOW58xlWkYcC1BtX6Mtvt6nc4ICeB5d9o
 tCen5tw1GkjwJmLjpEizd7rSfKRUhL1MwTS3xmw1wO+T36Np9xAga7x05YojMYPT0BzYnwvN2
 1J0JdQ+BnAmSDEp1sMrD2Q5zq3tmQWXF6HfIzmVItG5TWMZUgzeDi8oFp8rpDsyy61TJhqjqG
 NXvAAfX+sr1zoEY4cUKD/0XLRzuFN+04bMcLHtahzdtGtbXiPc7UqsbrFSjY2g8Kx8t1sYb9Q
 nzKx0iUfiydR3TDmWHycV9SchUyebOmy0tKk4teZuj0adYhPJePCEcvnS0QMQUCC1nYrDbZuF
 bqrtUcPSHR7ZC3Y9twbjx8ZdyKXu+/g8KKbvqXhJb0kvNA8EcDvYuun552XbP3EWc46BplFDo
 OFpd36V5X2ZTFqZvOOMtJyRZLfF/sfMsqhH3IzmeSNB3Yu9OhYADou//l2PEbVExtZYCGB+Sl
 53PHsdXFCe+KuV5Rmt7ubheuVZJRRJreFT8l5B+6dxKKYmm+e3aWBPDcJ8cftoKHOC3KsTIqe
 46zROY3k+MCcI1b5RYz6csf3h1mwzceU+1lH/hnniqM7JhIWT7/p4NXYVT0ZJ/KlUBY8YuR+m
 frw6sOC9CnHk68Pe56IZZfq0E3OGkrRbxz74zMvnx1jjBhhOCRPlBKubH6PHUo7rZDKh1cSNi
 guoe1CCDeDXhLGrpSAZBZvmGKVo=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

On 7/31/23 18:47, Helge Deller wrote:
> On 7/31/23 12:23, Akihiko Odaki wrote:
>> On 2023/07/31 19:17, Joel Stanley wrote:
>>> On Mon, 31 Jul 2023 at 09:31, Michael Tokarev <mjt@tls.msk.ru> wrote:
>>>>
>>>> 31.07.2023 11:03, Akihiko Odaki wrote:
>>>>> linux-user was failing on M2 MacBook Air. Digging into the details, =
I found
>>>>> several bugs in brk and mmap so here are fixes.
>>>>
>>>> There's another work in this area by Helge Deller, have you seen it?
>>>> ("linux-user: Fix and optimize target memory layout", a v5 already).
>>>
>>> Applying this series fixes the qemu-arm running the static armhf
>>> binary on my ppc64le host that I reported here[1].
>> >> [1] https://lore.kernel.org/qemu-devel/CACPK8XeyqcEDyyL3Jw2WYWs_gGdt=
TCf2=3DLy04CMgkshSMdj7RA@mail.gmail.com/
>>>
>>> Tested-by: Joel Stanley <joel@jms.id.au>
>>
>> Thanks for testing.
>>
>>>
>>> The changes conflict with Helge's patches, so it would be good to work
>>> out which of your changes should be combined with his.
>>
>> I suggest Helge to rebase his change to my series. The below is some
>> detailed explanation:
>
>> It is almost orthogonal to my series, but patch 2 will conflict with
>> my series since it changes how the initial brk is calculated.
>>
>> Unfortunately I think patch 2 has a bug. Without my patch, do_brk()
>> assumes the heap is aligned with the host page size, but the patch
>> does not consider the case that the host and target page sizes are
>> different.
> I've included your patches #2 (bugfix) and #3 (cleanup) to my latest
> patch series and published it at
> https://github.com/hdeller/qemu-hppa/tree/brk-fixes-akihiko
>
> Maybe you and Joel could try it out?

I re-read the thread again. As it seems Joel already tried the latest
version from me? Sadly I can't test myself on ppc64le (static binary
needs klibc-PupSAGgtpafMlSLXOLgje1kXFo8.so in /usr/lib which I can't
install on a debian porterbox).

I still believe we need to track host and target brk page, but I'll give
your patch a try.

Helge

