Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04684799056
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 21:41:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qehLN-00058P-FK; Fri, 08 Sep 2023 15:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qehL8-000586-CD; Fri, 08 Sep 2023 15:40:26 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qehL5-0003mZ-60; Fri, 08 Sep 2023 15:40:25 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 67A1620384;
 Fri,  8 Sep 2023 22:41:07 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6DFAC26C11;
 Fri,  8 Sep 2023 22:40:17 +0300 (MSK)
Message-ID: <9e9421ef-ecdb-5490-5c4f-3151e6ea23b3@tls.msk.ru>
Date: Fri, 8 Sep 2023 22:40:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PULL 24/51] meson: compile bundled device trees
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>, qemu-ppc <qemu-ppc@nongnu.org>
References: <20230907130004.500601-1-pbonzini@redhat.com>
 <20230907130004.500601-25-pbonzini@redhat.com>
 <fee31724-3b75-95d6-f4d6-2e7b8f17bf96@linaro.org>
 <8cab2217-b989-2be2-421c-c495e19dab87@tls.msk.ru>
 <a95e38d6-d968-9799-9c86-fa592b0feda7@eik.bme.hu>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <a95e38d6-d968-9799-9c86-fa592b0feda7@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

08.09.2023 22:21, BALATON Zoltan:
..
> I was about to ask, since when but probably nobody knows then. AFAIR I had no such errors for the canyonlands one when I've added it but that was 
> quite some years ago and things in dtc for example could have changed so it now gives these warnings.

I think it can be said based on debian build logs. Lemme see..

https://buildd.debian.org/status/logs.php?pkg=qemu&arch=all

The first log entry there is from 2018-12-12, for qemu 3.1, dtc 1.4.7.
It has:

dtc -o b/qemu/pc-bios/bamboo.dtb pc-bios/bamboo.dts
b/qemu/pc-bios/bamboo.dtb: Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
b/qemu/pc-bios/bamboo.dtb: Warning (unit_address_vs_reg): /plb/opb: node has a reg or ranges property, but no unit name
b/qemu/pc-bios/bamboo.dtb: Warning (chosen_node_stdout_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
b/qemu/pc-bios/bamboo.dtb: Warning (interrupts_property): /plb/opb: Missing interrupt-parent
b/qemu/pc-bios/bamboo.dtb: Warning (interrupts_property): /plb/opb/ebc: Missing interrupt-parent

next it was moved to one of the subpackages, and moved back to
arch-independent package in 6.2 (2022-01-09, dtc 1.6.0), which has:

dtc -o b/misc/bamboo.dtb pc-bios/bamboo.dts
pc-bios/bamboo.dts:45.9-48.4: Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
pc-bios/bamboo.dts:87.13-154.5: Warning (unit_address_vs_reg): /plb/opb: node has a reg or ranges property, but no unit name
pc-bios/bamboo.dts:198.3-50: Warning (chosen_node_stdout_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
pc-bios/bamboo.dts:87.13-154.5: Warning (interrupts_property): /plb/opb: Missing interrupt-parent
pc-bios/bamboo.dts:100.14-108.6: Warning (interrupts_property): /plb/opb/ebc: Missing interrupt-parent
dtc -o b/misc/canyonlands.dtb pc-bios/canyonlands.dts
pc-bios/canyonlands.dts:47.9-50.4: Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
pc-bios/canyonlands.dts:210.13-429.5: Warning (unit_address_vs_reg): /plb/opb: node has a reg or ranges property, but no unit name
pc-bios/canyonlands.dts:464.26-504.5: Warning (pci_bridge): /plb/pciex@d00000000: node name is not "pci" or "pcie"
pc-bios/canyonlands.dts:506.26-546.5: Warning (pci_bridge): /plb/pciex@d20000000: node name is not "pci" or "pcie"
b/misc/canyonlands.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
b/misc/canyonlands.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
b/misc/canyonlands.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
pc-bios/canyonlands.dts:268.14-289.7: Warning (avoid_unnecessary_addr_size): /plb/opb/ebc/ndfc@3,0: unnecessary #address-cells/#size-cells without 
"ranges" or child "reg" property

FWIW.

/mjt

