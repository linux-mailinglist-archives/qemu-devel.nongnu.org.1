Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1F17CFE0B
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 17:37:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtV50-0000zC-5q; Thu, 19 Oct 2023 11:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qtV4v-0000wU-Lg; Thu, 19 Oct 2023 11:36:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qtV4n-00087M-1y; Thu, 19 Oct 2023 11:36:53 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JFYhsF006647; Thu, 19 Oct 2023 15:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Y5wimt/DeUYct0S5G0hRl39Bjq4opHbHk6vFRUwabkw=;
 b=K/FVqnfF45b6WTYqDH60gytWnnH4fcch+iqcE0PKWlfg+GKeEzq4fvKzVlOXB417LCcO
 HPeWsWRGbxU6LHgF5mi9kmvWn8cV5LMC9WOnvT+WwZ1SFiyh1FzsxkiJrIt+pE5cGfXq
 dbqcRv+4hQEklfQVTQNChfI+E8DWev3EphKSgmHjEzVzMXrvThisEbh6iQD8EenLz7em
 TBIJ9AxtYsK3X83Oabb8Wpx97zAu5bfLcW1UZpl2ypZEWxqGhPNOHCD5XraxeejPf8vo
 1N5JWaoiu3qG1ZwBciu3T1RKgzyO5ESs3wUxNdc/DV3cwdvRqEu9qnVHJvoS4Y/+bCmU Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu77fg1ur-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 15:35:18 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39JFYoBQ007525;
 Thu, 19 Oct 2023 15:35:05 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu77fg196-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 15:35:05 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JClWQe030723; Thu, 19 Oct 2023 15:34:53 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr7hk1bpm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 15:34:53 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39JFYrJx20382322
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 15:34:53 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6DA15805A;
 Thu, 19 Oct 2023 15:34:52 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 76C8D58051;
 Thu, 19 Oct 2023 15:34:52 +0000 (GMT)
Received: from [9.61.49.215] (unknown [9.61.49.215])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Oct 2023 15:34:52 +0000 (GMT)
Message-ID: <1159f076-385b-491c-974e-fe72f850f341@linux.ibm.com>
Date: Thu, 19 Oct 2023 10:34:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10] hw/fsi: Introduce IBM's Local bus
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@aj.id.au, joel@jms.id.au, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, thuth@redhat.com, philmd@linaro.org,
 lvivier@redhat.com, qemu-arm@nongnu.org
References: <20231011151339.2782132-1-ninad@linux.ibm.com>
 <20231011151339.2782132-2-ninad@linux.ibm.com> <ZTDlf2jfj5tYGuSM@redhat.com>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <ZTDlf2jfj5tYGuSM@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IydVEeR57KAM3kJcXTrAHc-DPkjkJ3cV
X-Proofpoint-GUID: VflfnrjgSy8DELWtGfdf57y-UfEIb4nf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_15,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 mlxlogscore=967 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310190131
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

Hello Daniel,

On 10/19/23 03:14, Daniel P. Berrangé wrote:
> On Wed, Oct 11, 2023 at 10:13:30AM -0500, Ninad Palsule wrote:
>> This is a part of patchset where IBM's Flexible Service Interface is
>> introduced.
>>
>> The LBUS is modelled to maintain the qdev bus hierarchy and to take
>> advantage of the object model to automatically generate the CFAM
>> configuration block. The configuration block presents engines in the
>> order they are attached to the CFAM's LBUS. Engine implementations
>> should subclass the LBusDevice and set the 'config' member of
>> LBusDeviceClass to match the engine's type.
>>
>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>> v2:
>> - Incorporated Joel's review comments.
>> v5:
>> - Incorporated review comments by Cedric.
>> ---
>>   include/hw/fsi/lbus.h | 51 +++++++++++++++++++++++++
>>   include/qemu/bitops.h |  6 +++
>>   hw/fsi/lbus.c         | 87 +++++++++++++++++++++++++++++++++++++++++++
>>   hw/Kconfig            |  1 +
>>   hw/fsi/Kconfig        |  2 +
>>   hw/fsi/meson.build    |  1 +
>>   hw/meson.build        |  1 +
>>   7 files changed, 149 insertions(+)
>>   create mode 100644 include/hw/fsi/lbus.h
>>   create mode 100644 hw/fsi/lbus.c
>>   create mode 100644 hw/fsi/Kconfig
>>   create mode 100644 hw/fsi/meson.build
>> +DeviceState *lbus_create_device(FSILBus *bus, const char *type, uint32_t addr)
>> +{
>> +    DeviceState *dev;
>> +    FSILBusNode *node;
>> +    BusState *state = BUS(bus);
>> +
>> +    dev = qdev_new(type);
>> +    qdev_prop_set_uint8(dev, "address", addr);
>> +    qdev_realize_and_unref(dev, state, &error_fatal);
>> +
>> +    /* Move to post_load */
>> +    node = g_malloc(sizeof(struct FSILBusNode));
> This allocation pattern is discouraged in favour of:
>
>      node = g_new0(FSILBusNode, 1);

I am using g_malloc() because I want program to terminate. I don't think 
g_new0 provide this functionality. Please let me know.

Thanks for the review!

~Ninad

>> +    node->ldev = FSI_LBUS_DEVICE(dev);
>> +    QLIST_INSERT_HEAD(&bus->devices, node, next);
>> +
>> +    return dev;
>> +}
> With regards,
> Daniel

