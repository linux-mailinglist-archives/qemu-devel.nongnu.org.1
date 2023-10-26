Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBC57D8612
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 17:34:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw2M2-000483-35; Thu, 26 Oct 2023 11:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qw2Lu-000462-Es; Thu, 26 Oct 2023 11:32:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qw2Lr-0002Mo-9C; Thu, 26 Oct 2023 11:32:54 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39QFUoq3016091; Thu, 26 Oct 2023 15:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=xvmOqf33Fjz2zBBHiGE4jSm8QNZQBVzV3eOXw+mLncw=;
 b=JaO5TKRFuBfLKbfqaIxkHIcsGMwJKKm6fVy9ghLKJ/vsaxJIKLINrmqn0fSHX/Qj4ICx
 SFl0NFXkS/PUImtrr3uYlESGhrpOfrdJ9tZCAoWmJiBhm+4yU9S9awgC5jAD5GZv3j5d
 h6DtmUOnqNISPQ3PX/6yD5WKwuuJvKBGQyCJvZ1OfhnW2tgoY2aaeQ3LV4wPffsBdym6
 5s4M7tlWZ7M6A1WE2KBHaz5EwENXhtPCM+2k0XIUpt/91rIfV2PExLNugPs+4iM1hNNY
 5q2gVsLsS/Wvbtxidgv/Xs0bOr5y4j3HI3r4cZyV929iNXkxRR/SzUzuOJlDQFOTnZXF vA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tyt699ars-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Oct 2023 15:32:34 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39QFVHrY019329;
 Thu, 26 Oct 2023 15:32:34 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tyt699are-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Oct 2023 15:32:34 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39QEbIfb026847; Thu, 26 Oct 2023 15:32:33 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvsyp6yhb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Oct 2023 15:32:33 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39QFWWYa56426790
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 15:32:32 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BDCE58061;
 Thu, 26 Oct 2023 15:32:32 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DE5C258069;
 Thu, 26 Oct 2023 15:32:31 +0000 (GMT)
Received: from [9.24.12.86] (unknown [9.24.12.86])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 26 Oct 2023 15:32:31 +0000 (GMT)
Message-ID: <fd4ca25e-a1b2-4ce1-828f-efbc88d00f3c@linux.ibm.com>
Date: Thu, 26 Oct 2023 10:32:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/10] hw/fsi: Added FSI documentation
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org
References: <20231021211720.3571082-1-ninad@linux.ibm.com>
 <20231021211720.3571082-10-ninad@linux.ibm.com>
 <ee85f3d0-7ec8-47d5-b157-60d103553502@kaod.org>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <ee85f3d0-7ec8-47d5-b157-60d103553502@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tg8_4xYFlZewRot2fjEe1SAwlbpJzJpz
X-Proofpoint-ORIG-GUID: _Beyb2p0vNS0rpD44sfdO7Fh4S_Jsqj0
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_13,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 malwarescore=0 mlxlogscore=974 mlxscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310260134
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ninad@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hello Cedric,


On 10/24/23 02:37, Cédric Le Goater wrote:
> On 10/21/23 23:17, Ninad Palsule wrote:
>> Documentation for IBM FSI model.
>>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>> v4:
>>    - Added separate commit for documentation
>> ---
>>   docs/specs/fsi.rst | 141 +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 141 insertions(+)
>>   create mode 100644 docs/specs/fsi.rst
>
>
> Documentation build is broken.
>
> a 'fsi" entry should be added in docs/specs/index.rst. More below.
Sorry about that. Added entry in the index.rst
>
>
>
>> diff --git a/docs/specs/fsi.rst b/docs/specs/fsi.rst
>> new file mode 100644
>> index 0000000000..73b082afe1
>> --- /dev/null
>> +++ b/docs/specs/fsi.rst
>> @@ -0,0 +1,141 @@
>> +======================================
>> +IBM's Flexible Service Interface (FSI)
>> +======================================
>> +
>> +The QEMU FSI emulation implements hardware interfaces between ASPEED 
>> SOC, FSI
>> +master/slave and the end engine.
>> +
>> +FSI is a point-to-point two wire interface which is capable of 
>> supporting
>> +distances of up to 4 meters. FSI interfaces have been used 
>> successfully for
>> +many years in IBM servers to attach IBM Flexible Support 
>> Processors(FSP) to
>> +CPUs and IBM ASICs.
>> +
>> +FSI allows a service processor access to the internal buses of a 
>> host POWER
>> +processor to perform configuration or debugging. FSI has long 
>> existed in POWER
>> +processes and so comes with some baggage, including how it has been 
>> integrated
>> +into the ASPEED SoC.
>> +
>> +Working backwards from the POWER processor, the fundamental pieces 
>> of interest
>> +for the implementation are:
>> +
>> +1. The Common FRU Access Macro (CFAM), an address space containing 
>> various
>> +   "engines" that drive accesses on buses internal and external to 
>> the POWER
>> +   chip. Examples include the SBEFIFO and I2C masters. The engines 
>> hang off of
>> +   an internal Local Bus (LBUS) which is described by the CFAM 
>> configuration
>> +   block.
>> +
>> +2. The FSI slave: The slave is the terminal point of the FSI bus for 
>> FSI
>> +   symbols addressed to it. Slaves can be cascaded off of one 
>> another. The
>> +   slave's configuration registers appear in address space of the 
>> CFAM to
>> +   which it is attached.
>> +
>> +3. The FSI master: A controller in the platform service processor 
>> (e.g. BMC)
>> +   driving CFAM engine accesses into the POWER chip. At the hardware 
>> level
>> +   FSI is a bit-based protocol supporting synchronous and DMA-driven 
>> accesses
>> +   of engines in a CFAM.
>> +
>> +4. The On-Chip Peripheral Bus (OPB): A low-speed bus typically found 
>> in POWER
>> +   processors. This now makes an appearance in the ASPEED SoC due to 
>> tight
>> +   integration of the FSI master IP with the OPB, mainly the 
>> existence of an
>> +   MMIO-mapping of the CFAM address straight onto a sub-region of 
>> the OPB
>> +   address space.
>> +
>> +5. An APB-to-OPB bridge enabling access to the OPB from the ARM core 
>> in the
>> +   AST2600. Hardware limitations prevent the OPB from being directly 
>> mapped
>> +   into APB, so all accesses are indirect through the bridge.
>> +
>> +The LBUS is modelled to maintain the qdev bus hierarchy and to take 
>> advantages
>> +of the object model to automatically generate the CFAM configuration 
>> block.
>> +The configuration block presents engines in the order they are 
>> attached to the
>> +CFAM's LBUS. Engine implementations should subclass the LBusDevice 
>> and set the
>> +'config' member of LBusDeviceClass to match the engine's type.
>> +
>> +CFAM designs offer a lot of flexibility, for instance it is possible 
>> for a
>> +CFAM to be simultaneously driven from multiple FSI links. The 
>> modeling is not
>> +so complete; it's assumed that each CFAM is attached to a single FSI 
>> slave (as
>> +a consequence the CFAM subclasses the FSI slave).
>> +
>> +As for FSI, its symbols and wire-protocol are not modelled at all. 
>> This is not
>> +necessary to get FSI off the ground thanks to the mapping of the 
>> CFAM address
>> +space onto the OPB address space - the models follow this directly 
>> and map the
>> +CFAM memory region into the OPB's memory region.
>> +
>> +QEMU files related to FSI interface:
>> + - ``hw/fsi/aspeed-apb2opb.c``
>> + - ``include/hw/fsi/aspeed-apb2opb.h``
>> + - ``hw/fsi/opb.c``
>> + - ``include/hw/fsi/opb.h``
>> + - ``hw/fsi/fsi.c``
>> + - ``include/hw/fsi/fsi.h``
>> + - ``hw/fsi/fsi-master.c``
>> + - ``include/hw/fsi/fsi-master.h``
>> + - ``hw/fsi/fsi-slave.c``
>> + - ``include/hw/fsi/fsi-slave.h``
>> + - ``hw/fsi/cfam.c``
>> + - ``include/hw/fsi/cfam.h``
>> + - ``hw/fsi/engine-scratchpad.c``
>> + - ``include/hw/fsi/engine-scratchpad.h``
>> + - ``include/hw/fsi/lbus.h``
>> +
>> +The following commands start the rainier machine with built-in FSI 
>> model.
>> +There are no model specific arguments.
>> +
>> +.. code-block:: console
>> +
>> +  qemu-system-arm -M rainier-bmc -nographic \
>> +  -kernel fitImage-linux.bin \
>> +  -dtb aspeed-bmc-ibm-rainier.dtb \
>> +  -initrd obmc-phosphor-initramfs.rootfs.cpio.xz \
>> +  -drive file=obmc-phosphor-image.rootfs.wic.qcow2,if=sd,index=2 \
>> +  -append "rootwait console=ttyS4,115200n8 root=PARTLABEL=rofs-a"
>> +
>> +The implementation appears as following in the qemu device tree:
>> +
>> +.. code-block:: console
>> +
>> +  (qemu) info qtree
>> +  bus: main-system-bus
>> +    type System
>> +    ...
>> +    dev: aspeed.apb2opb, id ""
>> +      gpio-out "sysbus-irq" 1
>> +      mmio 000000001e79b000/0000000000001000
>> +      bus: opb.1
>> +        type opb
>> +        dev: fsi.master, id ""
>> +          bus: fsi.bus.1
>> +            type fsi.bus
>> +            dev: cfam.config, id ""
>> +            dev: cfam, id ""
>> +              bus: lbus.1
>> +                type lbus
>> +                dev: scratchpad, id ""
>> +                  address = 0 (0x0)
>> +      bus: opb.0
>> +        type opb
>> +        dev: fsi.master, id ""
>> +          bus: fsi.bus.0
>> +            type fsi.bus
>> +            dev: cfam.config, id ""
>> +            dev: cfam, id ""
>> +              bus: lbus.0
>> +                type lbus
>> +                dev: scratchpad, id ""
>> +                  address = 0 (0x0)
>> +
>> +pdbg is a simple application to allow debugging of the host POWER 
>> processors
>> +from the BMC. (see the `pdbg source repository` for more details)
>
> + from the BMC. (see the  ``pdbg source repository`` for more details)
>
> Please check before sending.

Sorry about that. Fixed it. Checked it using "rstcheck" tool and also 
through web browser.

Thanks for the review.

Regards,

Ninad

>
> Thanks,
>
> C.
>
>
>> +
>> +.. code-block:: console
>> +
>> +  root@p10bmc:~# pdbg -a getcfam 0x0
>> +  p0: 0x0 = 0xc0022d15
>> +
>> +Refer following documents for more details.
>> +
>> +.. _FSI specification:
>> +   https://openpowerfoundation.org/specifications/fsi/
>> + https://wiki.raptorcs.com/w/images/9/97/OpenFSI-spec-20161212.pdf
>> +
>> +.. _pdbg source repository:
>> +   https://github.com/open-power/pdbg
>

