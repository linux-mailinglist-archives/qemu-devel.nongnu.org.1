Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D24B7D1F99
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 22:38:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quIjK-0004Qf-Gr; Sat, 21 Oct 2023 16:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1quIjF-0004HK-Kh; Sat, 21 Oct 2023 16:37:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1quIjB-0005C9-Cr; Sat, 21 Oct 2023 16:37:49 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39LKA4HP017072; Sat, 21 Oct 2023 20:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=1FWxuKyDzHU3x3G0c2ZyRu5gCf4FjpXtkeRGbOBEmkM=;
 b=QEV1kVtXG+Z26P7yENwxDKrLd7sl193trT7g1A+qcdsMOAjtfRfzxTzvWaR6hkl+KlP/
 vUnTpCG1ZNe3rY6tT1lTY722JTXasPv8KIS2iDNLQ6qLDHLNVxYQ15qxaorOZeTyEzwF
 XW9JFDdGIQjGbcuQxQad39bqjfauG4KkgxjQFbhj1QKvf/Kcmwfu9ZIrQIJmqOOJlDst
 qZfIJ7HAFo7HoW3//hwp2+DGsvPcgPtUGu9SIkgE63QwnfruvPerhomgxCFgKOoSS1Du
 vAMYvkXtLIo8sQk70gOPr09qn4UgywBcFq+4jEY3SrbIacAvgl0M+70JO7J+L1jYPQOx 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tvnefrd4n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Oct 2023 20:37:30 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39LKaM4n006122;
 Sat, 21 Oct 2023 20:37:30 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tvnefrd4e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Oct 2023 20:37:30 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39LKV2vc024179; Sat, 21 Oct 2023 20:37:29 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tuc29d7tc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Oct 2023 20:37:29 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39LKbSCj40764038
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 21 Oct 2023 20:37:29 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A65CF58055;
 Sat, 21 Oct 2023 20:37:28 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D8C358043;
 Sat, 21 Oct 2023 20:37:27 +0000 (GMT)
Received: from [9.67.95.215] (unknown [9.67.95.215])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 21 Oct 2023 20:37:27 +0000 (GMT)
Message-ID: <9db3f46c-05a0-4b22-a688-2e9b64fab4bb@linux.ibm.com>
Date: Sat, 21 Oct 2023 15:37:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/10] hw/fsi: Introduce IBM's FSI
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@aj.id.au, joel@jms.id.au, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, thuth@redhat.com, philmd@linaro.org,
 lvivier@redhat.com, qemu-arm@nongnu.org
References: <20231011151339.2782132-1-ninad@linux.ibm.com>
 <20231011151339.2782132-5-ninad@linux.ibm.com> <ZTDopoa6j+rD9pIp@redhat.com>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <ZTDopoa6j+rD9pIp@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MJNYTBTtbFuKEnE4mUhpYpc_QLobozCs
X-Proofpoint-GUID: 4c-0a9noDPz_Lxh_SvhACixE6DmblCuN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-21_12,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0
 mlxscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=876 adultscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310210189
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ninad@linux.ibm.com;
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

Hello Daniel,

On 10/19/23 03:28, Daniel P. Berrangé wrote:
> On Wed, Oct 11, 2023 at 10:13:33AM -0500, Ninad Palsule wrote:
>> This is a part of patchset where IBM's Flexible Service Interface is
>> introduced.
>>
>> This commit models the FSI bus. CFAM is hanging out of FSI bus. The bus
>> is model such a way that it is embedded inside the FSI master which is a
>> bus controller.
>>
>> The FSI master: A controller in the platform service processor (e.g.
>> BMC) driving CFAM engine accesses into the POWER chip. At the
>> hardware level FSI is a bit-based protocol supporting synchronous and
>> DMA-driven accesses of engines in a CFAM.
>>
>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>> ---
>> v2:
>> - Incorporated review comments by Joel
>> v5:
>> - Incorporated review comments by Cedric.
>> ---
>>   include/hw/fsi/fsi-master.h |  30 ++++++
>>   include/hw/fsi/fsi.h        |  37 +++++++
>>   hw/fsi/cfam.c               |   2 +-
>>   hw/fsi/fsi-master.c         | 199 ++++++++++++++++++++++++++++++++++++
>>   hw/fsi/fsi.c                |  54 ++++++++++
>>   hw/fsi/meson.build          |   2 +-
>>   hw/fsi/trace-events         |   2 +
>>   7 files changed, 324 insertions(+), 2 deletions(-)
>>   create mode 100644 include/hw/fsi/fsi-master.h
>>   create mode 100644 include/hw/fsi/fsi.h
>>   create mode 100644 hw/fsi/fsi-master.c
>>   create mode 100644 hw/fsi/fsi.c
>>
>> +static void fsi_master_realize(DeviceState *dev, Error **errp)
>> +{
>> +    FSIMasterState *s = FSI_MASTER(dev);
>> +    Error *err = NULL;
>> +
>> +    qbus_init(&s->bus, sizeof(s->bus), TYPE_FSI_BUS, DEVICE(s), NULL);
>> +
>> +    memory_region_init_io(&s->iomem, OBJECT(s), &fsi_master_ops, s,
>> +                          TYPE_FSI_MASTER, 0x10000000);
>> +    memory_region_init(&s->opb2fsi, OBJECT(s), "fsi.opb2fsi", 0x10000000);
>> +
>> +    object_property_set_bool(OBJECT(&s->bus), "realized", true, &err);
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
> Redundant Error object, just check return value of set_bool
Fixed.
>
>> +
>> +    memory_region_add_subregion(&s->opb2fsi, 0, &s->bus.slave.mr);
>> +}
>> +static void fsi_bus_realize(BusState *bus, Error **errp)
>> +{
>> +    FSIBus *s = FSI_BUS(bus);
>> +    Error *err = NULL;
>> +
>> +    /* Note: Move it elsewhere when we add more CFAMs. */
>> +    object_property_set_bool(OBJECT(&s->slave), "realized", true, &err);
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +    }
> Likewise.

Fixed.

Thanks for the review.

Regards,

Ninad

>> +}
>> +
> With regards,
> Daniel

