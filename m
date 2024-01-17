Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BC5830993
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:18:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7fk-0005G2-MB; Wed, 17 Jan 2024 10:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rQ7fi-0005CX-BW; Wed, 17 Jan 2024 10:17:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rQ7fg-0006f1-76; Wed, 17 Jan 2024 10:17:42 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40HENF0f012420; Wed, 17 Jan 2024 15:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=YcbVM0sW23Nuw37XWyQJEqvu2n4u51Vw0eC+kgGN6yo=;
 b=W9ywDGEmFF9KHwexVd9+0HpP/yZwT+HPDjsWkb38tSgh8TPqeTSRQXDOubRyg/Cz008C
 Awd0BYmxqM+GWH9FH2r/yQKpDDU//amJ8UlBxiL8NpcbOm2ko73uqUzFQY2EEO12LYWF
 4+wOXekEaiYUck4ZbBPYo3Fv6tnJv/ByBpARMLnDWLiwv0S5/+RRSyaj+lUuVAKd1MC4
 6DWQU/1xZc47bVORH0Fpb4PyqSWldIH0pfd4n6Vyb3bj32kMoFQzlF0iUVRWfz1Lwcmr
 twSox0fx3ulvebaCj3zxrTLS1nrWONI9xJ7WdIsjJk2oRQwNs1ShNokMdGBnGsnaFGw4 Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vpgkthuhs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 15:17:38 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40HF14uN007756;
 Wed, 17 Jan 2024 15:17:37 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vpgkthuhc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 15:17:37 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40HELpb7010969; Wed, 17 Jan 2024 15:17:37 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm57yp8rc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 15:17:37 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40HFHaEU23462622
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jan 2024 15:17:36 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A92F58056;
 Wed, 17 Jan 2024 15:17:36 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3774C5803F;
 Wed, 17 Jan 2024 15:17:35 +0000 (GMT)
Received: from [9.61.163.245] (unknown [9.61.163.245])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jan 2024 15:17:35 +0000 (GMT)
Message-ID: <1c8ff2bf-ec92-4c54-8fa6-6432acdfc644@linux.ibm.com>
Date: Wed, 17 Jan 2024 10:17:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] s390x/pci: refresh fh before disabling aif
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, frankja@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org
References: <20240116223157.73752-1-mjrosato@linux.ibm.com>
 <20240116223157.73752-3-mjrosato@linux.ibm.com>
 <2c8ce63b-f8b1-4b98-97e5-4416d4d622cf@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <2c8ce63b-f8b1-4b98-97e5-4416d4d622cf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0FjJEnoHjJ4fGA1MrECFy6fz-WGJY5JT
X-Proofpoint-ORIG-GUID: HR_-cLCIKY6jd_yprqgGegNtzsjFKuOr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0 spamscore=0
 mlxscore=0 clxscore=1015 phishscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401170110
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

On 1/17/24 5:40 AM, Cédric Le Goater wrote:
> On 1/16/24 23:31, Matthew Rosato wrote:
>> Typically we refresh the host fh during CLP enable, however it's possible
>> that the device goes through multiple reset events before the guest
>> performs another CLP enable.  Let's handle this for now by refreshing the
>> host handle from vfio before disabling aif.
>>
>> Fixes: 03451953c7 ("s390x/pci: reset ISM passthrough devices on shutdown and system reset")
>> Reported-by: Cédric Le Goater <clg@redhat.com>
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
>>   hw/s390x/s390-pci-kvm.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/s390x/s390-pci-kvm.c b/hw/s390x/s390-pci-kvm.c
>> index f7e10cfa72..9eef4fc3ec 100644
>> --- a/hw/s390x/s390-pci-kvm.c
>> +++ b/hw/s390x/s390-pci-kvm.c
>> @@ -18,6 +18,7 @@
>>   #include "hw/s390x/s390-pci-bus.h"
>>   #include "hw/s390x/s390-pci-kvm.h"
>>   #include "hw/s390x/s390-pci-inst.h"
>> +#include "hw/s390x/s390-pci-vfio.h"
>>   #include "cpu_models.h"
>>     bool s390_pci_kvm_interp_allowed(void)
>> @@ -64,9 +65,17 @@ int s390_pci_kvm_aif_disable(S390PCIBusDevice *pbdev)
>>           return -EINVAL;
>>       }
>>   +    /*
>> +     * The device may have already been reset but we still want to relinquish
>> +     * the guest ISC, so always be sure to use an up-to-date host fh.
>> +     */
>> +    if (!s390_pci_get_host_fh(pbdev, &args.fh)) {
>> +        return -EPERM;
>> +    }
> 
> The callers of s390_pci_kvm_aif_disable() all test the original host
> function with :
> 
>    if (pbdev->interp && (pbdev->fh & FH_MASK_ENABLE))
> 
> This change possibly fetches a new one. Shouldn't we move the test
> also in s390_pci_kvm_aif_disable() ?
> 
> 

Those codepaths are actually testing the enablement bit of the guest-visible function handle, not the host function handle.  Basically asking "was the guest using this device".  These handles (host and guest) are sync'd during guest CLP enable (necessary for interpretation to work) but will become disjoint once we reset the device until the next guest CLP ENABLE.  They can also become disjoint once the guest does a CLP DISABLE.
What this change is doing is basically making sure we disable AIF on the hostdev, but does NOT replace pbdev->fh.  The guest-visible function handle will get sync'd again when the guest does a new CLP ENABLE after reset.


