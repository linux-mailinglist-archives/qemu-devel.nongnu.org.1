Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E367BB698
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:39:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qojAZ-00079X-5Y; Fri, 06 Oct 2023 07:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qojAR-0006kW-7q; Fri, 06 Oct 2023 07:38:53 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qojAL-0000Y6-DF; Fri, 06 Oct 2023 07:38:49 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 89507757239;
 Fri,  6 Oct 2023 13:37:54 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 37076757234; Fri,  6 Oct 2023 13:37:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 342CA757233;
 Fri,  6 Oct 2023 13:37:54 +0200 (CEST)
Date: Fri, 6 Oct 2023 13:37:54 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clegoate@redhat.com>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org, 
 Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, 
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2] pc-bios/meson.build: Silent unuseful DTC warnings
In-Reply-To: <4db7073c-79e5-bb61-13d6-cc17401307b3@linaro.org>
Message-ID: <e26e8783-e10a-e872-f33e-d37d749bdc17@eik.bme.hu>
References: <20231006064750.33852-1-philmd@linaro.org>
 <9fb5e05e-1772-e21b-0f82-56b4e9135c3b@redhat.com>
 <a1dc7eca-a062-c045-a2a2-39c35e3ceaa2@linaro.org>
 <d256b67d-dcbe-6eda-7e58-eb9ed74283fc@redhat.com>
 <4db7073c-79e5-bb61-13d6-cc17401307b3@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1819958019-1696592274=:39939"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1819958019-1696592274=:39939
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 6 Oct 2023, Philippe Mathieu-Daudé wrote:
> On 6/10/23 10:32, Cédric Le Goater wrote:
>> On 10/6/23 10:18, Philippe Mathieu-Daudé wrote:
>>> On 6/10/23 10:13, Cédric Le Goater wrote:
>>>> On 10/6/23 08:47, Philippe Mathieu-Daudé wrote:
>>>>> QEMU consumes some device tree blobs, so these have been committed
>>>>> to the tree in as firmware, along with the device tree source used
>>>>> to generate them. We know the blobs are "good enough" to have QEMU
>>>>> boot a system, so we don't really maintain and rebuild the sources.
>>>>> 
>>>>> These blobs were generated with older 'dtc' binaries. We use the
>>>>> v1.6.1 version since 2021 (commit 962fde57b7 "dtc: Update to version
>>>>> 1.6.1").
>>>>> 
>>>>> Since commit 6e0dc9d2a8 ("meson: compile bundled device trees"),
>>>>> if dtc binary is available, it is directly used to compile the
>>>>> device tree sources. New versions of 'dtc' add checks which display
>>>>> warnings or errors. Our sources are a bit old, so dtc v1.6.1 now
>>>>> emit the following warnings on a fresh build:
>>>>> 
>>>>>    [163/3414] Generating pc-bios/canyonlands.dts with a custom command
>>>>>    pc-bios/canyonlands.dts:47.9-50.4: Warning (unit_address_vs_reg): 
>>>>> /memory: node has a reg or ranges property, but no unit name
>>> ...
>>> 
>>>>>  From QEMU perspective, these warnings are not really useful. It is
>>>>> the responsibility of developers adding DT source/blob to QEMU
>>>>> repository to check the source doesn't produce warnings, but as
>>>>> long as the blob is useful enough, QEMU can consume it. So these
>>>>> warnings don't add any value, instead they are noisy and might
>>>>> distract us to focus on important warnings. Better disable them.
>>>>> 
>>>>> 'dtc' provides the '--quiet' option for that:
>>>>> 
>>>>>    $ dtc --help
>>>>>    Usage: dtc [options] <input file>
>>>>> 
>>>>>    Options: -[qI:O:o:V:d:R:S:p:a:fb:i:H:sW:E:@AThv]
>>>>>      -q, --quiet
>>>>>            Quiet: -q suppress warnings, -qq errors, -qqq all
>>>>> 
>>>>> Update meson to disable these unuseful DTC warnings.
>>>> 
>>>> 
>>>> Why not try fixing the .dts instead ? These still exist under Linux :
>>>> 
>>>>    ./arch/powerpc/boot/dts/canyonlands.dts
>>>>    ./arch/powerpc/boot/dts/bamboo.dts
>>> 
>>> Because QEMU != Linux, and there isn't always overlap between
>>> communities?
>> 
>> sure but bamboo.dts came from Linux. So this should be safe to update.
>> Alex Graf did 10 years ago.
>> 
>> I can not tell for the sam460ex. It is probably safer to keep it as it is.

I also opted for leaving it alone and not updating it because the current 
one is known to work and apart from these warnings there's no reason to 
change it. Updating and changing the dtb potentially can break booting 
something with -kernel so ignoring the warning is the safer option that 
would cause less work in the future.

>> Sweeping dtc warnings under the rug for all .dts doesn't seem a good idea.
>> Should we get rid of the .dts and only keep the .dtb then ?
>
> I *think* QEMU should generate DT blob with the qemu_fdt API (see
> "sysemu/device_tree.h") with all the devices emulated, not forward
> a Linux one.

The pegasos2 machine does that for VOF but it's not nice to do it that 
way. If I did if for another machine I'd probably put the skeleton, static 
parts in a dtb and only edit the dynamic part (such as mem size, CPU infos 
and PCI devices) with qemu_fdt after loading it which seems to be easier 
(and what's the sam460ex is doing) than doing everything from C. The 
pegasos2 does not have much static info so it does not worth changing it 
now but half of pegasos2.c is the dtb creation so putting that somewhere 
else may have made it more readable but I've modeled it after spapr so did 
not consider using a dtb back then. If I ever try to add dtb creation to 
mac machines I'd try doing that with a dtb and adding to that instead.

Regards,
BALATON Zoltan
--3866299591-1819958019-1696592274=:39939--

