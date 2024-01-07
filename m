Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A4282662D
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 22:42:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMat8-00014X-Vb; Sun, 07 Jan 2024 16:40:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1rMasw-00013w-1V; Sun, 07 Jan 2024 16:40:46 -0500
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1rMasu-0007ln-4A; Sun, 07 Jan 2024 16:40:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1704663636; x=1705268436; i=deller@gmx.de;
 bh=mE1pKONsWd8dbTaqj1+lzoWanFnELldum79KID7+GG4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=jphdKN41tj9Ntx8vPPTOFxrvvkEignf88gCeEfwv9E4r8Xc2OE0F3kPJjEaGJpMn
 kQzg+XYpwVZt9IEX+SG+21RYXSJ1trmBtseTTnU8jqaXHhITWHKuJ2ccbFO9OnUSq
 7gXhsl6NShtBmzYaVtSdboa6m9HIYkYLpQ2MIBpIZ27EWg9Hp4L5hBlETbiz4hbgu
 yziml41sF42PYutBQ0a+XjzORzGcRfrk6zqPtsVeg2Xa1lhKtjfOZFIvVSIiUsIUe
 2l5xDKpg1oJtFSbFgv2/4LzKccAhoM8ErpZfMH4aeVER8Zs8SzKUnHWM3muO/qCYb
 rpwDqERqUvWvZAawrQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.148.157]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZktj-1rixMJ38MR-00WqQU; Sun, 07
 Jan 2024 22:40:36 +0100
Message-ID: <7df97a8e-6bb2-482c-86cf-a9dbf2bd2e53@gmx.de>
Date: Sun, 7 Jan 2024 22:40:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/tci: Fix TCI on hppa host and update TCI test matrix
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@kernel.org>
Cc: Laurent Vivier <laurent@vivier.eu>, Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <ZZpQZ77s2t81mXIT@p100>
 <CAFEAcA9K4GVcYNe2YvtDxiXC-HBvAXEZzNMA-z9xkpNY4Qf2EQ@mail.gmail.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAFEAcA9K4GVcYNe2YvtDxiXC-HBvAXEZzNMA-z9xkpNY4Qf2EQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MtwcpbhUh0IA837yjH8U9s5WofhB9MykmYc6CCaeQ9Mh+lS9lu5
 epY7P7Nyur6Z+VgUmkHmxZsKxzK9M41FvDgQNya+ZNZU0RWTgFeYuJLXtmnOivVxgb5RhGa
 BcaLX8OIkRf3/T45umWORSPUXAiu6n+xcfKUhZULLP251fltBXHCe2wAp7dPuc1FwLXZO+W
 InAGxBmLv/JZ7xOvq/1CA==
UI-OutboundReport: notjunk:1;M01:P0:UQhgH6lP57I=;XCNV0ASIrBtRKicH7Qdz5fpEDbP
 2OxUOdL8OcRsM5W0DgQhkTrXeuKd/y0OHF+PH81EUyLB8Iz2pT96Tx5SYuzNe/XpdJUGCLTGy
 4Z/EE5+nk7dIrXKUjq5iJbHyY4khq4Lk/LzJwXqgaUTebjk+PF0Lc1O7kMi9Naf2WsCM6mTTF
 /1gfG1LKiZfNifmBCFiYTn9Y7QyQk+/F8rAebN7Gsr1I1PIx8SFE3inKgjBRPDTVVabjPgINa
 GSSNSJrJtEHl3J2rp/e8QZmxtLSEO8/UK9WigWBtrOHyy2pg2zqG516fr1772d5grHOQ7P/Wf
 gXdh4ras4DRpWDgra8kHk+0VUsvpURwlxwTp/Kaa2xCjgzHp9wLD5QcEOIg7v2qkiUfCvI/YE
 kZk5D6ADJkaHtEaJVuurrUzKZWMkrb8V9AcNCWDNO58oQfiqxBShdos0eV/Vya1tQFUqoMdTD
 AegU7UIOWKsJAxkWmTVfhiyrTDSNJl2JqKBOiDZYjGKKNrPg6cp8OrxWfLblMkG1AumLDY3Ds
 rp3XDLZW9e4/PYVWauxO4yEhXAh6NNPuON5pWFKRg3sH1KRANDuEBQFFaojaZar8jelghoxgW
 hhOeAvZMY9kRx7Oy7+atZOsgXobCibhsqkrtzrdxHcznvIR8lQSFi2oyYsTxFEbDQTeNHyL17
 binwijkskWeMupGugNafumIMvf7C+ZXzf/hXuMAU62cl73SbYHqs/DLy9cy1U0lGtvRE+eTyW
 jXJtScB+olzmMA0y75Mt1gbihF+5ucwQD4OfnvrB2rpKD1z3KoNKNI80Ik2qKHkAnMtpfQZtE
 Ofg3YN0bTkAwtsKpRrpCh/Qjx+TQLdqe87KL5WIIvpCfe+ODky53TI62uFSn7Sr0cXcjtmRfU
 ywS4XymEp1F2IFPxPUojIb6ABa4ju/KicShv5RAkou5I9xhKMSShV6bYTU02SY2D0bwWpUEwo
 awRFUHyZVeBJ3KFbkJmJo//61wc=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 1/7/24 16:22, Peter Maydell wrote:
> On Sun, 7 Jan 2024 at 07:20, Helge Deller <deller@kernel.org> wrote:
>>
>> Update the TCI interpreter test matrix for big-endian hosts with
>> big- (hppa, hppa64) and little-endian (x86,x96-64) targets.
>> I used native ppc64 and hppa hosts for those tests.
>>
>> Starting TCI on a hppa host crashed immediately, because hppa is
>> the only archive left where the stack grows upwards.
>> Write-protecting the stack guard page at the top of the stack
>> fixes the crash.
>
> We deliberately dropped support for HPPA hosts, under
> commit a1eaa6281f8b and commit b1cef6d02f84bd8.
> Do we really care enough about trying to run on these
> ancient host CPUs to want to bring it back?
>
> My personal rule of thumb is that if a host CPU is supported
> only by TCI then we are better off saying it is entirely
> unsupported -- in practice the performance will be so
> terrible as to not be something anybody will want to use,
> especially for older architectures which are slow to
> start with.

I can see your point (and the performance is really horrible).
It's not my intention to make hppa a supported TCI platform,
but for me it's a good candidate to at least test TCI on
a big-endian machine, mostly because I have access to some of
such machines.
And, this patch is all what's needed and it's pretty trivial, so
it would be great if it could be accepted.

Helge

