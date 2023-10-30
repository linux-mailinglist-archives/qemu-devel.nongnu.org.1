Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB267DBE74
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 18:03:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxVeV-0008Ep-R1; Mon, 30 Oct 2023 13:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qxVeT-0008Ed-3T
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 13:02:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qxVeP-0000V7-Pf
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 13:02:07 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39UGe9fr015309; Mon, 30 Oct 2023 17:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=VVIWU49Mty54DRqf0tSQ9Pia2esWS9T8d1BTjTOJR1M=;
 b=Mn3zaVHVc0ZN4Vcwco7S7eneE4gto43c8s4uiWGVyBgy94+ox4qEEykp8kfwx05UdrET
 bU5UCcsla0fsTifjEF77sB1KCQNzTxVfefhEH3nmxN5wtuKz4wTHsXZ87/l2tjYjnqug
 iDSCLLi1WQRAaPSKsQDNt1ULjrQZslUXWdzi6npj5bbKuy+WBdqUDni1Fk87HyvFo/GA
 Z6vYygI+XrofUzF4P/V+FMQsYZu7OiqIF1fmK8vrVOPKqSdvKNrHhgkSvoJgOHst2RVl
 s4OCBbyIosjsqYPKYChDgFsRlHqfmFbBaci8e9i2hNMDf8BS+R+DoFNA/HLUffuyzX2Q vA== 
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2g7191cu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Oct 2023 17:02:03 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39UGN36S000597; Mon, 30 Oct 2023 17:02:02 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1cmsttqa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Oct 2023 17:02:02 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39UH21oW9503416
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Oct 2023 17:02:01 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D933558065;
 Mon, 30 Oct 2023 17:02:00 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A68C45805D;
 Mon, 30 Oct 2023 17:02:00 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 30 Oct 2023 17:02:00 +0000 (GMT)
Message-ID: <848ea63a-69f2-4f47-a849-5c81019e5115@linux.ibm.com>
Date: Mon, 30 Oct 2023 13:01:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/14] tpm-sysbus: add plug handler for TPM on SysBus
Content-Language: en-US
To: Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20231029060404.71196-1-j@getutm.app>
 <20231029060404.71196-7-j@getutm.app>
 <998ed878-6cf2-42e3-a764-a2d222bf914c@linux.ibm.com>
 <CA+E+eSDTNt2SQGoGkQVOfcVWswhOqio95vSROGj1JH6Y0M0EaQ@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CA+E+eSDTNt2SQGoGkQVOfcVWswhOqio95vSROGj1JH6Y0M0EaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gA0j_xUDMNgzGCiWcsavLNxj_UiZD4OP
X-Proofpoint-GUID: gA0j_xUDMNgzGCiWcsavLNxj_UiZD4OP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300133
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


On 10/30/23 12:55, Joelle van Dyne wrote:
> I was debating what to add. I couldn't find a project-wide template
> for what the header should be and I couldn't copy/paste from where I
> copied the code from (virt.c) because it names a specific author that
> I'm not sure wrote this code... Any advice?

I would follow the files in hw/tpm/*.c and use those as templates with

- name of file and short description

- Copyright

- Author(s)

- 2 sentences about the license

- Maybe a longer description.


>
> On Mon, Oct 30, 2023 at 9:52 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>> On 10/29/23 02:03, Joelle van Dyne wrote:
>>> TPM needs to know its own base address in order to generate its DSDT
>>> device entry.
>>>
>>> Signed-off-by: Joelle van Dyne <j@getutm.app>
>>> ---
>>>    include/sysemu/tpm.h |  4 ++++
>>>    hw/tpm/tpm-sysbus.c  | 33 +++++++++++++++++++++++++++++++++
>>>    hw/tpm/meson.build   |  1 +
>>>    3 files changed, 38 insertions(+)
>>>    create mode 100644 hw/tpm/tpm-sysbus.c
>>>
>>> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
>>> index 1ee568b3b6..ffd300e607 100644
>>> --- a/include/sysemu/tpm.h
>>> +++ b/include/sysemu/tpm.h
>>> @@ -12,6 +12,8 @@
>>>    #ifndef QEMU_TPM_H
>>>    #define QEMU_TPM_H
>>>
>>> +#include "qemu/osdep.h"
>>> +#include "exec/hwaddr.h"
>>>    #include "qapi/qapi-types-tpm.h"
>>>    #include "qom/object.h"
>>>
>>> @@ -78,6 +80,8 @@ static inline TPMVersion tpm_get_version(TPMIf *ti)
>>>        return TPM_IF_GET_CLASS(ti)->get_version(ti);
>>>    }
>>>
>>> +void tpm_sysbus_plug(TPMIf *tpmif, Object *pbus, hwaddr pbus_base);
>>> +
>>>    #else /* CONFIG_TPM */
>>>
>>>    #define tpm_init()  (0)
>>> diff --git a/hw/tpm/tpm-sysbus.c b/hw/tpm/tpm-sysbus.c
>>> new file mode 100644
>>> index 0000000000..ef0592b837
>>> --- /dev/null
>>> +++ b/hw/tpm/tpm-sysbus.c
>>> @@ -0,0 +1,33 @@
>> A header in this new file would be good. Otherwise LGTM.
>>
>>     Stefan
>>
>>> +#include "sysemu/tpm.h"
>>> +#include "hw/platform-bus.h"
>>> +#include "hw/sysbus.h"
>>> +#include "qapi/error.h"
>>
>>

