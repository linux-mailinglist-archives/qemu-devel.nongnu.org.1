Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 725B9719096
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 04:39:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4YCf-0003K7-LK; Wed, 31 May 2023 22:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenbaozi@phytium.com.cn>)
 id 1q4YCc-0003Jt-T0; Wed, 31 May 2023 22:38:14 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenbaozi@phytium.com.cn>)
 id 1q4YCa-0003mS-Cg; Wed, 31 May 2023 22:38:14 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBX09iCBXhk55w3AQ--.47009S2;
 Thu, 01 Jun 2023 10:42:10 +0800 (CST)
Received: from smtpclient.apple (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwAnVV6CBHhkeF4AAA--.424S3;
 Thu, 01 Jun 2023 10:37:55 +0800 (CST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: use XHCI to replace EHCI
From: Chen Baozi <chenbaozi@phytium.com.cn>
In-Reply-To: <b663fb55-dc8e-9fd8-9d82-7e693c3c4ad3@quicinc.com>
Date: Thu, 1 Jun 2023 10:37:44 +0800
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Graeme Gregory <graeme@xora.org.uk>, wangyuquan1236@phytium.com.cn,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F9D991CE-BC05-483E-8289-93BE111CC7D6@phytium.com.cn>
References: <20230531070229.334124-1-wangyuquan1236@phytium.com.cn>
 <20230531070229.334124-2-wangyuquan1236@phytium.com.cn>
 <lfcmvvqjp64wngrdk33bvkb3k7op53l24lcoslah2evsyh3esc@at7jnsnrto7h>
 <CAFEAcA8h9-YWUYsvuERttmsEK3xi+K+xasFdoWmnFm26S6npNw@mail.gmail.com>
 <b663fb55-dc8e-9fd8-9d82-7e693c3c4ad3@quicinc.com>
To: Leif Lindholm <quic_llindhol@quicinc.com>
X-Mailer: Apple Mail (2.3731.600.7)
X-CM-TRANSID: AQAAfwAnVV6CBHhkeF4AAA--.424S3
X-CM-SenderInfo: hfkh0updr2xqxsk13x1xpou0fpof0/1tbiAQAREWR3nCkBUQAAs3
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=chenbaozi@
 phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7KF13Kw48AF4UGF4kAw1UWrg_yoW8KFWUpF
 W5Ja47Kr4vka1Syrsavw1YvF43Aa1xZFy5Jr15Jry8AFZxJ34a9rWfKw15ua9xZw1fA34j
 qrWYq34fC3W3ZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=chenbaozi@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Leif,

> On Jun 1, 2023, at 00:36, Leif Lindholm <quic_llindhol@quicinc.com> =
wrote:
>=20
> On 2023-05-31 16:27, Peter Maydell wrote:
>> On Wed, 31 May 2023 at 15:58, Graeme Gregory <graeme@xora.org.uk> =
wrote:
>>>> The current sbsa-ref cannot use EHCI controller which is only
>>>> able to do 32-bit DMA, since sbsa-ref doesn't have RAM above 4GB.
>>>> Hence, this uses XHCI to provide a usb controller with 64-bit
>>>> DMA capablity instead of EHCI.
>>>=20
>>> Should this be below 4G?
>> It would be pretty disruptive to try to rearrange the memory
>> map to put RAM below 4GB at this point, though in theory it's
>> possible I guess. (I have a vague recollection that there was
>> some reason the RAM was all put above 4GB, but can't find
>> anything about that in my email archives. Perhaps Leif remembers?)
>=20
> I think Graeme was just pointing out a typo in Marcin's email.
>=20
> Yeah, we're not changing the DRAM base at this stage.
> I think the reason we put no RAM below 4GB was simply that we had =
several real-world platforms where that was true, and given the intended =
use-case for the platform, we explicitly wanted to trigger issues those =
platforms might encounter.
>=20
>>> Also has EHCI never worked, or has it worked in some modes and so =
this
>>> change should be versioned?
>> AIUI, EHCI has never worked and can never have worked, because
>> this board's RAM is all above 4G and the QEMU EHCI controller
>> implementation only allows DMA descriptors with 32-bit addresses.
>> Looking back at the archives, it seems we discussed XHCI vs
>> EHCI when the sbsa-ref board went in, and the conclusion was
>> that XHCI would be better. But there wasn't a sysbus XHCI device
>> at that point, so we ended up committing the sbsa-ref board
>> with EHCI and a plan to switch to XHCI when the sysbus-xhci
>> device was done, which we then forgot about:
>> https://mail.gnu.org/archive/html/qemu-arm/2018-11/msg00638.html
>=20
> Ah, thanks! That explains why we did the thing that made no sense :)
>=20
> To skip the migration hazard, my prefernece is we just leave the EHCI =
device in for now, and add a separate XHCI on PCIe. We can drop the
> EHCI device at some point in the future.

What about introducing another SMMU for all the platform devices on =
sbsa-ref? I was thinking over this solution for some time. If that can =
be feasible, we then also have a prototype of IOMMU for platform device.

Regards,

Baozi.=


