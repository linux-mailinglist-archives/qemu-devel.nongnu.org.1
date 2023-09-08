Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F66B798EFA
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 21:22:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeh2d-0005gc-K8; Fri, 08 Sep 2023 15:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qeh2a-0005g1-Qa; Fri, 08 Sep 2023 15:21:16 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qeh2U-0004oz-1p; Fri, 08 Sep 2023 15:21:12 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 5EC73756A30;
 Fri,  8 Sep 2023 21:21:03 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DEB07756201; Fri,  8 Sep 2023 21:21:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DCCFB7456A7;
 Fri,  8 Sep 2023 21:21:02 +0200 (CEST)
Date: Fri, 8 Sep 2023 21:21:02 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Michael Tokarev <mjt@tls.msk.ru>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Guenter Roeck <linux@roeck-us.net>, qemu-ppc <qemu-ppc@nongnu.org>
Subject: Re: [PULL 24/51] meson: compile bundled device trees
In-Reply-To: <8cab2217-b989-2be2-421c-c495e19dab87@tls.msk.ru>
Message-ID: <a95e38d6-d968-9799-9c86-fa592b0feda7@eik.bme.hu>
References: <20230907130004.500601-1-pbonzini@redhat.com>
 <20230907130004.500601-25-pbonzini@redhat.com>
 <fee31724-3b75-95d6-f4d6-2e7b8f17bf96@linaro.org>
 <8cab2217-b989-2be2-421c-c495e19dab87@tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-2118146007-1694200693=:47252"
Content-ID: <c6df82dc-722d-7b30-c1c0-34ee61bda515@eik.bme.hu>
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

--3866299591-2118146007-1694200693=:47252
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <947c621e-4fcd-3b62-6583-9b72bbe62781@eik.bme.hu>

On Fri, 8 Sep 2023, Michael Tokarev wrote:
> 08.09.2023 19:27, Philippe Mathieu-Daudé:
>> On 7/9/23 14:59, Paolo Bonzini wrote:
>>> If dtc is available, compile the .dts files in the pc-bios directory
>>> instead of using the precompiled binaries.
>>> 
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>   pc-bios/Makefile    | 19 -------------------
>>>   pc-bios/meson.build | 25 +++++++++++++++++++++----
>>>   2 files changed, 21 insertions(+), 23 deletions(-)
>>>   delete mode 100644 pc-bios/Makefile
>> 
>> FWIW I'm getting:
>> 
>> [50/1419] Generating pc-bios/bamboo.dts with a custom command
>> ../../pc-bios/bamboo.dts:45.9-48.4: Warning (unit_address_vs_reg): /memory: 
>> node has a reg or ranges property, but no unit name
>> ../../pc-bios/bamboo.dts:87.13-154.5: Warning (unit_address_vs_reg): 
>> /plb/opb: node has a reg or ranges property, but no unit name
>> ../../pc-bios/bamboo.dts:198.3-50: Warning (chosen_node_stdout_path): 
>> /chosen:linux,stdout-path: Use 'stdout-path' instead
>> ../../pc-bios/bamboo.dts:87.13-154.5: Warning (interrupts_property): 
>> /plb/opb: Missing interrupt-parent
>> ../../pc-bios/bamboo.dts:100.14-108.6: Warning (interrupts_property): 
>> /plb/opb/ebc: Missing interrupt-parent
>> [51/1419] Generating pc-bios/canyonlands.dts with a custom command
>> ../../pc-bios/canyonlands.dts:47.9-50.4: Warning (unit_address_vs_reg): 
>> /memory: node has a reg or ranges property, but no unit name
>> ../../pc-bios/canyonlands.dts:210.13-429.5: Warning (unit_address_vs_reg): 
>> /plb/opb: node has a reg or ranges property, but no unit name
>> ../../pc-bios/canyonlands.dts:464.26-504.5: Warning (pci_bridge): 
>> /plb/pciex@d00000000: node name is not "pci" or "pcie"
>> ../../pc-bios/canyonlands.dts:506.26-546.5: Warning (pci_bridge): 
>> /plb/pciex@d20000000: node name is not "pci" or "pcie"
>> pc-bios/canyonlands.dtb: Warning (unit_address_format): Failed prerequisite 
>> 'pci_bridge'
>> pc-bios/canyonlands.dtb: Warning (pci_device_reg): Failed prerequisite 
>> 'pci_bridge'
>> pc-bios/canyonlands.dtb: Warning (pci_device_bus_num): Failed prerequisite 
>> 'pci_bridge'
>> ../../pc-bios/canyonlands.dts:268.14-289.7: Warning 
>> (avoid_unnecessary_addr_size): /plb/opb/ebc/ndfc@3,0: unnecessary 
>> #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg" 
>> property
>
> This smells like something which has been here forever and no one noticed
> because the compile only happens when updating these files, ie, almost
> never.
>
> So, "don't blame the messenger" :)

I was about to ask, since when but probably nobody knows then. AFAIR I had 
no such errors for the canyonlands one when I've added it but that was 
quite some years ago and things in dtc for example could have changed so 
it now gives these warnings.

The dts files come from Linux so maybe it's fixed there but not sure if 
updating these would generate different dtb that the guests might not like 
as both these machines and guests running on them are quite old. So maybe 
it's safer to ignore the warnings? On the other hand, maybe this dtb is 
only used when booting Linux with -kernel, otherwise the u-boot firmware 
will generate it so updating it may not affect most guests anyway. I think 
Guenter Roeck (cc'd) used this for testing Linux kernels so maybe he has 
some more info or insight. This may not help much but that's all I can add 
to this.

Regards,
BALATON Zoltan
--3866299591-2118146007-1694200693=:47252--

