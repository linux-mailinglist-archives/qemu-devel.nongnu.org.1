Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D85B769D24
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 18:49:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQW4D-0007WA-Lh; Mon, 31 Jul 2023 12:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQW3y-0007TL-0Z
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:48:09 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQW3v-0004pU-D2
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690822075; x=1691426875; i=deller@gmx.de;
 bh=SCZi6LzFidRwlTPvwcksxd2bfB+ef0qrS45hSgMyNUM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=WamBSGXKNlhnQ7nMN1GfhkAs1dEGWtqp42+ma/myQyYZ0FTII5WJgG/1s6gon70vAef3zzP
 xtAqYs8EMqpuC7RxCIOKqGrO8Rws4Vlfx+RMnrc5k10oUPmdums9hq2fCOFmyDzW1nSBYfNVG
 UUH+kVZvc9nCTcGiGgUa5Itg1VO3lO5tQU4TgmpFbVmqfDrPimgbFEb3Zw7Ez1Ta+XlJ609k8
 JvsVji82fkltJFbQaMmnu/dZqKcVE4qNkFaNtyuiUkfZ9QeMIbB+x5pwMLjv+koxoprNjgLt2
 K7Q0ugwvt3isKa3LghjtvLjBXoSc/zFEckxNMsJeBqkEhZK1oWLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.159.238]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlf0K-1pzOhd1Mkk-00iiQY; Mon, 31
 Jul 2023 18:47:55 +0200
Message-ID: <57d9980d-b881-b16e-844a-e651d6d09de7@gmx.de>
Date: Mon, 31 Jul 2023 18:47:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/5] linux-user: brk/mmap fixes
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Joel Stanley <joel@jms.id.au>,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
References: <20230731080317.112658-1-akihiko.odaki@daynix.com>
 <3088d223-64fd-9aab-3c08-000f0924607c@tls.msk.ru>
 <CACPK8XfcOkn281JZNYc7+AhDAxP_N9__G4Snxtx=ZhXgVChXgg@mail.gmail.com>
 <0643c953-bfa8-45a9-5b07-714bc18c03a6@daynix.com>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <0643c953-bfa8-45a9-5b07-714bc18c03a6@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3JycbAlLSnB51EOY1U5YIMG2RRN2hvEwM9xr8ff7telIjU90IcI
 4alYQSuRDXF4iDNvU5yLSh+oIZ/EIDMCjB4uisbaexoGTzPXBLcCG7dVLS3AiIzCjjcoQ/6
 gCZ1GEUtGyBMhfE9yjxANTEBuP2hCt5kcvxLqkyCKiIiYOrkQAflCw3DsJlhdplgwNcfj8S
 1xfR9rRYTpXcqnV4nPHzg==
UI-OutboundReport: notjunk:1;M01:P0:ldUIAaCLz7E=;VkiChSJDFcSXtXYYkk+jSk46Bs9
 RvE/V45j1P1pmF2lgEPmea9obbWHqzQ7KSR42q1WtZJ0zRYiP0HbKjX7VulbbuDUjZg/lpV3F
 pjzRWOTqBgSAzlAeVn2WlHcWEliCpJtF3hk5+TbMic89axdEEqLSGbla1XPsdUXwDsqk5CQl1
 lJda3MWYPeUDyVi/9UwqnyQpBBpB785FkndyBEDk2IM38QduxGikLC+uVrQ9Ieo1c5SUNSKuf
 BagVDVuZoASLYMD6CemafgCUCoAvgXrc4jJzjSUb4YMCiJ9xcU/tKlxmeRlkKux1bzon52OhW
 YbI2YFuppum33tAxtbzaM0hqXYPVewbeByoU1MbQa8rE0KRSQwyCxj8GSFA5lK3j4EZ4xCwtf
 aa2zGlsTp8sGtzlQYdcmcIYmlKSIu49hCoitdn27loYN6UxZ8VyG5e5E1PGa6oV/UuhyPdOre
 pAoqWzzKFObPjX1X+Lk8k5E5J/W0c1bzmcCa5zGxaqsfdT7zbEQ9qSVEWZAHVp2a9moUWQnBx
 lrBmZatsdIu5p2YV1BL7EIVpNVvgrqumfFpG05b6r2Mm+Z/CtQ6/Ck/vXnmqgKcevEbd/JhHS
 Mxr1Kx7Axjb48Tvmc13EMA0sD9CMLWoistouroU2VxK2OG9PaEbGQyJm9i/WDrIwH8r7slDn5
 GowoSpdg8wqVOaj2rD01KQIlcn4j1OeZQRVg4TBroE3z7kpk9eqicY75ubtowyb2FNeCbTOx5
 cRPVm+IOsfHETuYtAPKEfjRRAiYfbFuiXR5YMbgpKvJUXKxrVtn4/smEaltCjUnRRJjVMedgM
 irwncpUGxnp3BpoqWI3oHt3uDscjCDUAhB31q7Dw6fPgh6sLB7XHwPu0sSZDI+ZkOf7RtWB5k
 2syWy6mvm1ei8Wm2Pvc6C+RvIaCMwBg1p5oe2x97oFN0DfwSijeY2sDCrvAofZPcEm/L6VyGf
 uf57Mo/vUXSlXqwYwAdWWa574c4=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
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

On 7/31/23 12:23, Akihiko Odaki wrote:
> On 2023/07/31 19:17, Joel Stanley wrote:
>> On Mon, 31 Jul 2023 at 09:31, Michael Tokarev <mjt@tls.msk.ru> wrote:
>>>
>>> 31.07.2023 11:03, Akihiko Odaki wrote:
>>>> linux-user was failing on M2 MacBook Air. Digging into the details, I=
 found
>>>> several bugs in brk and mmap so here are fixes.
>>>
>>> There's another work in this area by Helge Deller, have you seen it?
>>> ("linux-user: Fix and optimize target memory layout", a v5 already).
>>
>> Applying this series fixes the qemu-arm running the static armhf
>> binary on my ppc64le host that I reported here[1].
> >> [1] https://lore.kernel.org/qemu-devel/CACPK8XeyqcEDyyL3Jw2WYWs_gGdtT=
Cf2=3DLy04CMgkshSMdj7RA@mail.gmail.com/
>>
>> Tested-by: Joel Stanley <joel@jms.id.au>
>
> Thanks for testing.
>
>>
>> The changes conflict with Helge's patches, so it would be good to work
>> out which of your changes should be combined with his.
>
> I suggest Helge to rebase his change to my series. The below is some
> detailed explanation:

> It is almost orthogonal to my series, but patch 2 will conflict with
> my series since it changes how the initial brk is calculated.
>
> Unfortunately I think patch 2 has a bug. Without my patch, do_brk()
> assumes the heap is aligned with the host page size, but the patch
> does not consider the case that the host and target page sizes are
> different.
I've included your patches #2 (bugfix) and #3 (cleanup) to my latest
patch series and published it at
https://github.com/hdeller/qemu-hppa/tree/brk-fixes-akihiko

Maybe you and Joel could try it out?

Helge

