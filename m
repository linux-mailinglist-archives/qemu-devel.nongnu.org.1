Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E54E08309CE
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:32:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7sY-0006EJ-FO; Wed, 17 Jan 2024 10:30:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rQ7sV-0006Dk-GS; Wed, 17 Jan 2024 10:30:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rQ7sT-00017t-5l; Wed, 17 Jan 2024 10:30:55 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40HF77GB029980; Wed, 17 Jan 2024 15:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Wy6CmkQQQ1RspqtcD8BAf8uc0u5OOsiMctIykZg3p/k=;
 b=J2Ay+moTZg5HUqBzr+98OwZ0riF8F/2xa8qL0Bfj7kigCuOfOmR9Oa1awgNXNqRVlsGY
 1IjVMnBOmbz5Lxpja9iEUcuj7IyZFr0GCqhICem9L9Pk0OTrfSbOITKd0TOreiKCKOex
 1UkPK6zg00WfweYWNvkgIbEZOQ8bQ9JwX/VXjvTHcI7sgM5vkdFKEydY/Ow+BBq/3Y61
 htxABB/lIleTatUFk2pPOK9K2gvsZ6bIwJzf2rIv3BCz+zjJWByltaQTrK7uphuuF75p
 LRYPzGfavH1NgU+4XQyxaypJz9S7xn8NfyHh6DZgDHPx6MMsvJHAydiksOwS/nh8QEqH mg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vph8k0vtb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 15:30:48 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40HF7mp4032440;
 Wed, 17 Jan 2024 15:30:48 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vph8k0v90-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 15:30:47 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40HENVlT023511; Wed, 17 Jan 2024 15:07:37 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm6bknvjj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 15:07:37 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40HF7aDB12518008
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jan 2024 15:07:36 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 070335803F;
 Wed, 17 Jan 2024 15:07:36 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3756A58060;
 Wed, 17 Jan 2024 15:07:35 +0000 (GMT)
Received: from [9.61.163.245] (unknown [9.61.163.245])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jan 2024 15:07:35 +0000 (GMT)
Message-ID: <65ad4cbf-92a9-48e4-a684-766bc87dbe23@linux.ibm.com>
Date: Wed, 17 Jan 2024 10:07:35 -0500
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
 <3016e7dd-197d-45a6-abb6-ce3f9ad31f42@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <3016e7dd-197d-45a6-abb6-ce3f9ad31f42@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N1C_AMhREYRVdNncO2KIMJXsQjPr3txt
X-Proofpoint-ORIG-GUID: 35wS9849lDNGhPzsidXKK9I3G5RF36CL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_09,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401170112
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 1/17/24 5:31 AM, Cédric Le Goater wrote:
> Hello Matthew,
> 
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
>> +
>>       rc = kvm_vm_ioctl(kvm_state, KVM_S390_ZPCI_OP, &args);
>>       if (rc == 0) {
>> -        pbev->aif = false;
>> +        pbdev->aif = false;
>>       }
> 
> This belongs to patch 1.
> 
> 

Thanks for pointing that out, will fix.


