Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AED73E4D8
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 18:22:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoxO-0004eQ-Qq; Mon, 26 Jun 2023 12:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qDoxC-0004dp-IJ; Mon, 26 Jun 2023 12:20:39 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qDox9-0004eo-IH; Mon, 26 Jun 2023 12:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687796425; x=1688401225; i=deller@gmx.de;
 bh=axUvmXqAFzFtEYiETxwtsbsEwxQvo/stPZ3rdWq2ofQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=CGQ4qvKw5Tdj+HgEz3N12nz5yWL7JaT5Y592uboY6uaNKn4ZGnFXNGxq+TtVu9YZR0melyj
 06UXbpiJM5KGBYIZwsAhO6RTil8FZGlZeGRfTCyHbakxcF1aDIe98S+x/nhv+cWHUZawR36NU
 6x3SWrINqkN+H00IZLeMTVOn5ArP4bdBTRdFFNQT3gSS/tDXTJk2jC/vufk+BCzQa3/D+b4zd
 M7lkeJNxCN5CRzBafc7YivN4Ajjr05SPVsvBB96OQBXpWrAls5fJIiqw55HUxgRNviS6x4hUP
 3jQqtZcvTo0jU9+4iCz7LswU3dMdB3U+sc/9Ifbv8WnDbvXfMBqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.147.245]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMXUD-1qWrlu3Qzn-00JYQ1; Mon, 26
 Jun 2023 18:20:25 +0200
Message-ID: <a4fcdfa9-aeda-1c89-3c8e-7559626c929b@gmx.de>
Date: Mon, 26 Jun 2023 18:20:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL v2 1/3] target/hppa: Fix OS reboot issues
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-stable <qemu-stable@nongnu.org>, Michael Roth <michael.roth@amd.com>
References: <20230624115007.30332-1-deller@gmx.de>
 <20230624115007.30332-2-deller@gmx.de>
 <c2917053-e8df-c2bc-9565-6d5f257db901@tls.msk.ru>
 <6a7e29ed-3ce9-c228-2d29-96151a5f8ccb@gmx.de>
 <45215ee6-b36f-5c90-6937-9f45277598ea@gmx.de>
 <cec99847-86d5-40ed-6f87-b0e9106d403b@tls.msk.ru>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <cec99847-86d5-40ed-6f87-b0e9106d403b@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+ws2OGa3qOUZJXLJTxMt3oeONnHBhkT4YzhiGLujlSHBSswodZw
 RYI4n0dwjBf8BvjDOicI7CKqDyOcCRVi08x38hCZ3sI9USrZEhsO30ZMvJID1d12tqQM/op
 jzk4929GsjrGvGe5u82L/arX4VdiZMr95sjLn01Xj0P+QpXZey8JCPvSf8OTC4uylQlFR5H
 qyYpykCndG2pbS6pqmH1w==
UI-OutboundReport: notjunk:1;M01:P0:9Ar2BzBUU38=;B6e5Imqs+SIJsCusfRPeBapMTxs
 qnegJ7cl7KZncc74r+Tv8CPDIrona2m5XGUOl9b4wmwlYygFdgjLzkUBPy4kVm6AuyXzgHgC6
 EkbkAWkray75qHcI8xNytAUIiju5YL23pfC1kMJe2O/8wlHeezzkvzXiq28IMK+yz5GYNIqvl
 K4YaS2pNl0WKpWSVcnq1PjDaRjp8mJhUUK1zShVO2Xrf8VWPuqDVImBo+mvkc72UmwYwtixRP
 7kHcezQQG/y/kVB8puMW4C6viDD4IGaqOCsFfJumqbg9gGOBkKU0G0Xtqvp5UwM0d6UFrpj9T
 NQGQ4aEPXJFrzi15YWkXo91sF4/HKXqQyZhpdiEUbmnKJhQ1RGQWvUTvplELVX9ZLmTqAlEaM
 lXcwOz+YNHvcSlMoDljTN+v0F+Nesax5AKELxrhVX0HWe73vnCjDe810eDDVT6SGOaKqfJTzo
 M9axKXVjWR6YQs4zTso4RVDKHnvc3yJnEpzWaypBSX0U9cm7Uzm4hSZxzqR2ixVf3/p+KMfcC
 54XJ2TRw3Q18yiz7ME8aLccE4WFdL97AwoHjN6N3T8vQx3/w6snjNP6ZX6tgcMaMtfWHGxNQg
 xvfwyVqoeh3oDQxg/7lYyEV9qmx8AP1aWXpcngC6OmtJO+iz3GkF5rsRwYh/qpNP3t/E1Gab4
 BWyd041IJFyLdO/BiV3xiMHrg65yellvVsaoTXYCVYgR5Ao19q6g9l8eMvaRvorvQSeoT8TFo
 rjJ8x1H7rE73vCvEfRo5tcP6WCIoSw+71U4fp1x7blOAQwn90S8gnCa4M6agIyEu5EzGI/7sq
 6emUzI+d52PqQrYqIS0jB5weFqydDGkPgkJpcAnM2vNr71kt+/qm6vcYI5pzH7TXGZte2UmcZ
 +SK16o5X9ilhc73B9Izwu38VajzebFSGJWynRVOYq23Pp1OdjC+l9XDNkQ/MXDCeQUQby9Csz
 P/MAbzaaqDZ2QUyGxX18OPqSXQM=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/26/23 14:22, Michael Tokarev wrote:
> 25.06.2023 14:20, Helge Deller wrote:
>
>>>> Is this a -stable material?=C2=A0 It applies cleanly to 8.0 and 7.2.
>>>
>>> Yes, please.
>>> At least for 8.0 I think it should be added.
>>> I didn't tested 7.2, but can do and would prefer it if could be added =
there too.
>>
>> Just tested: The patches work nicely when applied to v7.2 as well.
>> Could you add them to -stable (or what is the process)?
>
> Hmm. Now I'm a bit confused.
>
> Initially I thought it's just this patch, 1/3, "target/hppa: Fix OS rebo=
ot issues",
> to which I replied, is the one which should perhaps go to -stable.=C2=A0=
 But now I see
> it is the whole series, all 3 changes, which are needed.
>
> And for 7.2, things are a bit more interesting in this context: seabios-=
hppa version
> in 7.2 is 6, it changed to version 7 in qemu 8.0, and changed further by=
 this patchset.
> There isn't much differences between seabios-hppa 6 and 7, so it's proba=
bly okay to
> have it of version 7 in qemu-7.2-stable too (esp. since the change in th=
ere is another
> bugfix, with debian 12 as a reproducer).
>
> So, just to confirm: do we update seabios-hppa to this commit 673d2595d4=
f773cc266cbf
> (version 8) in both stable-7.2 and stable-8.0? :)

Yes.

> The changes in there seems to be okay anyway, should be good to have in =
-stable.

Yes.

> Besides, I'm having sort of difficult time cherry-picking the commit whi=
ch updates
> seabios-hppa submodule and hppa-firmware.img file, - git tells me there'=
s a conflict
> (even when applying to stable-8.0 branch) but I see no changes to this a=
reas in-
> between (yes, a conflict when applying to 7.2 is expected).=C2=A0 So I e=
nded up in
> doing:

starting in both branches (staging-7.2 and staging-8.0) this works for me:

git cherry-pick bb9c998ca9343d445c76b69fa15dea9db692f526
git cherry-pick 50ba97e928b44ff5bc731c9ffe68d86acbe44639
git cherry-pick 069d296669448b9eef72c6332ae84af962d9582c
git cherry-pick 34ec3aea54368a92b62a55c656335885ba8c65ef

Helge

