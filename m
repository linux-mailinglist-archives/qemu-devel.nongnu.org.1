Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EAD72E1A7
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 13:27:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q91s3-0004j4-4C; Tue, 13 Jun 2023 07:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q91s1-0004iu-58
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 07:07:29 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q91rz-0002yR-1Z
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 07:07:28 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 366B774633D;
 Tue, 13 Jun 2023 13:07:18 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id F189374632B; Tue, 13 Jun 2023 13:07:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F0548746335;
 Tue, 13 Jun 2023 13:07:17 +0200 (CEST)
Date: Tue, 13 Jun 2023 13:07:17 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: "Michael S. Tsirkin" <mst@redhat.com>
cc: Bernhard Beschow <shentey@gmail.com>, Igor Mammedov <imammedo@redhat.com>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 02/15] hw/pci-host/q35: Fix double, contradicting
 .endianness assignment
In-Reply-To: <20230613044810-mutt-send-email-mst@kernel.org>
Message-ID: <0ff30d22-25f9-750e-3ec1-f0988eee5668@eik.bme.hu>
References: <20230611103412.12109-1-shentey@gmail.com>
 <20230611103412.12109-3-shentey@gmail.com>
 <20230612150154.438d842f@imammedo.users.ipa.redhat.com>
 <CAG4p6K6yR+iJmjnYOkJFd=GbxPU+QpkzTSEfW1VuUwM95o5_iQ@mail.gmail.com>
 <20230613044810-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1303320310-1686654437=:98157"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1303320310-1686654437=:98157
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 13 Jun 2023, Michael S. Tsirkin wrote:
> On Tue, Jun 13, 2023 at 09:46:53AM +0200, Bernhard Beschow wrote:
>> On Mon, Jun 12, 2023 at 3:01 PM Igor Mammedov <imammedo@redhat.com> wrote:
>>
>>     On Sun, 11 Jun 2023 12:33:59 +0200
>>     Bernhard Beschow <shentey@gmail.com> wrote:
>>
>>    > Fixes the following clangd warning (-Winitializer-overrides):
>>    >
>>    >   q35.c:297:19: Initializer overrides prior initialization of this
>>     subobject
>>    >   q35.c:292:19: previous initialization is here
>>    >
>>    > Settle on native endian which causes the least overhead.
>>     indeed it doesn't matter which way we read all ones, so that should work.
>>     but does it really matter (I mean the overhead/what workload)?
>>     If not, I'd prefer explicit LE as it's now to be consistent
>>     the the rest of memops on Q35.
>>
>>
>> I got a comment from Michael about this in [1], so I've changed it. I don't
>> mind changing it either way.
>>
>> Best regards,
>> Bernhard
>>
>> [1] https://patchew.org/QEMU/20230214131441.101760-1-shentey@gmail.com/
>> 20230214131441.101760-3-shentey@gmail.com/#
>> 20230301164339-mutt-send-email-mst@kernel.org
>
> Hmm it's not terribly important, and the optimization is trivial,
> but yes people tend to copy code, good point. Maybe add a comment?
> /*
> * Note: don't copy this!  normally use DEVICE_LITTLE_ENDIAN. This only
> * works because we don't allow writes and always read all-ones.
> */

Why don't you leave DEVICE_LITTLE_ENDIAN and remove DEVICE_NATIVE_ENDIAN 
instead? If this only returns all 1s then it does not matter and also 
DEVICE_LITTLE_ENDIAN was the last assignment so likely that was effective 
so far anyway.

Regards,
BALATON Zoltan

>>
>>    >
>>    > Fixes: bafc90bdc594 ("q35: implement TSEG")
>>    > Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>>    > ---
>>    >  hw/pci-host/q35.c | 1 -
>>    >  1 file changed, 1 deletion(-)
>>    >
>>    > diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
>>    > index fd18920e7f..859c197f25 100644
>>    > --- a/hw/pci-host/q35.c
>>    > +++ b/hw/pci-host/q35.c
>>    > @@ -290,7 +290,6 @@ static const MemoryRegionOps blackhole_ops = {
>>    >      .valid.max_access_size = 4,
>>    >      .impl.min_access_size = 4,
>>    >      .impl.max_access_size = 4,
>>    > -    .endianness = DEVICE_LITTLE_ENDIAN,
>>    >  };
>>    > 
>>    >  /* PCIe MMCFG */
>>
>>
>
>
>
--3866299591-1303320310-1686654437=:98157--

