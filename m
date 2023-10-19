Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3C07D0545
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 01:09:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtc7X-0004Eq-Vt; Thu, 19 Oct 2023 19:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qtc7V-0004Ec-Ug
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 19:08:01 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qtc7T-0008N0-5t
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 19:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697756872; x=1698361672; i=deller@gmx.de;
 bh=k+6xcvZBb1qXxEUezr/6feMoj8pNIgl7zuh1ehxMjHM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=LVrw5OoUqt6rtP2ks7UwX1QbfnGsPdMwFGGsJCnve8PtkdnaywLM0tsg+RnDMQVh
 Kb3nX6gWREYWYukmVf9zAg0IF8ITKk2gnM8l4plHchgxeOw94SY5yATU8vQ+eWn9A
 UrwnoM0G6w3+2WoyARgtj2Auz37F652bSTihXtut0CDiXDm6h02br6C8NFYWIYgiD
 jjG5ce5uyqdYk0AQpy1aMRlobAQUPz2btoauMwqWDOyTgeXo7FkpsT5aoSAAe5goY
 nRsdjuQnFFwh/f5yXY+E+DEeueEtAMCRCRxzSXzPjbBVnGmFp3BdDdQdlLnv4rPPG
 Lr2K5Q/QgGK9mreSwg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.148.149]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiJVG-1rPts60To6-00fTO2; Fri, 20
 Oct 2023 01:07:52 +0200
Message-ID: <7ffde548-75a8-46ba-afec-50ba10bfce1a@gmx.de>
Date: Fri, 20 Oct 2023 01:07:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/11] C3700 patches
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>, deller@kernel.org
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
References: <20231018204030.391572-1-deller@kernel.org>
 <CAJSP0QUyROvzRR-Wenc36zr2H5r7npO5nzRDpZCQFLdW9=xJXA@mail.gmail.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAJSP0QUyROvzRR-Wenc36zr2H5r7npO5nzRDpZCQFLdW9=xJXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:epGYnC5Px6qpiGUCHSwXtg3xD1MYOL2YtjEJkp6yzXLU8ZRNXbO
 0obMuQCmvOfmfYBh09uQiMg1lWbLKeqn9QUPPMSarYKPRNRf5FiauzI2GRZ3re9QgMhJQln
 U3uVVQxVUMrUyTjlYM90Kc8hrjE3lciPJMoBkUXPBX1YkJLR1OckcXRZ+zSIHIsUIS1Ohms
 vmjH6GXPhlsOg3IYyhTTg==
UI-OutboundReport: notjunk:1;M01:P0:GazTf/g4ouc=;HtpaGt4CBvcJF/n6lyRapzBuSsB
 W9t3D4k31j9Woc4SZU7saFqw2AdljfTsOgxGeYV9Sy2XB/TqDHuufyc9Ar6EheAEEDh27PqhT
 /YGar6M4RhMmoB26DIOTl+KPL2Cnkk/6TD8Q8gqfG73wWMp4yQRdd+odRgDNLDPZp0c+19gLU
 4AJ2P8kGNSddra6e/I9vVbF8gvA/gxwu1mmHhSxSe5X/e/8XhM40j9d09Z2vQFi+NlUH6XXOE
 nxS8N8fus+9TAbbWd5NGsXWBhptDLVUZEiglrYoRy3yaVOo7pZ0fOwrkubtt3Ny6FN/UOdOAl
 +/Aacyc2A8XYYXVXh2pLgDxNXIYPqkLy7dZGrIvp2cpMCewfSbiBoXVe6qjLv00yVovAqyH1l
 xfDa+x50a7PpNZlS9d2hR0COAZ8739jG1Gd4WKKOyxuqT0lYn/odPS7QojJq2s/MCQ9EJGeg8
 f2+mlCcOLQ1744jrTMaV8j+QZy85dvg1DdDBozm1XpRPXi5J93xXM/0Oi5bsza7UTQunaC34j
 Iwv7jM9O0/u2oyS3gszvD+xIpYajxYeJy+ipQRcRB1qW19XG6bglTgNiBSWYIlnCynjCDgTRU
 0uwiQVYM1jpsKxcBAOPfVPu74SMD/pylHDFrNQXH5bGhFL9gf2NXB5LvzrEWE5t/QBs8r38EY
 ba2vEU4tx4YzMoUWRMZCg3UX9mm0OH9Gk3NNyXbcJB14d7x2hcmKLPX08EEiiZNnBuYH2rOYY
 JuMOmyXNFpr05wqCjCSR+yhoPQVNsRrwZTy0DpmXT3L4RVL2Q/bchpWcewTa2ZbPqheTKRrlR
 OOI0FG9tOfsJ/9tbnBU+d6Q8TtLnUZCWMjS8PKvoRioVh39LWLQgdrfT5Z0fMXHJ7efcB86X8
 1h3tmGwWq86ilXUUHoYugxxROTHwKmRdJlK2tEBhCv/sMb/N/t5ImEfrSQQ/iVrdPfM4wVPu0
 H90KcokIWXBdOls3tRQNAN6dlaQ=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
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

On 10/19/23 19:19, Stefan Hajnoczi wrote:
> On Wed, 18 Oct 2023 at 13:42, <deller@kernel.org> wrote:
>>
>> From: Helge Deller <deller@gmx.de>
>>
>> The following changes since commit 63011373ad22c794a013da69663c03f1297a=
5c56:
>>
>>    Merge tag 'pull-riscv-to-apply-20231012-1' of https://github.com/ali=
stair23/qemu into staging (2023-10-12 10:24:44 -0400)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/hdeller/qemu-hppa.git tags/C3700-pull-request
>>
>> for you to fetch changes up to 6120e493c9c5b7d2b122f2501ea1c2cc2b64d1e3=
:
>>
>>    hw/hppa: Add new HP C3700 machine (2023-10-17 23:13:19 +0200)
>
> Please take a look at the following CI failure:
>
> 266/841 ERROR:../tests/qtest/device-introspect-test.c:262:test_device_in=
tro_concrete:
> assertion failed (qom_tree_start =3D=3D qom_tree_end): ("/machine
> (none-machine)\r\n /peripheral (container)\r\n /peripheral-anon
....

Oh, yes!
I missed to split up the creation of astro into a realize function.
It's now fixed in the new pull request I just sent out and the
test suite now passes for me.
Can you please recheck?

Thanks!
Helge

