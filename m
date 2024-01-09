Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20845828E66
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 21:14:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNITH-00086E-MH; Tue, 09 Jan 2024 15:13:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rNITF-00085d-2H; Tue, 09 Jan 2024 15:13:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rNITC-0001ef-GU; Tue, 09 Jan 2024 15:13:08 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 409K9MvP009109; Tue, 9 Jan 2024 20:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hQobJXS470AUt6WV/Ml7lzPENshqDCjYYPWvlk/Wqgs=;
 b=Pkgm3Euu80iyMf/FEbCnx/6G3X5uAtUrpvIiShzsrI4M2bJHnId7y6McWB/prip8PZVj
 +9Tf2Ew7Z/ssysxZzsadjqDz3zvFPYJ3XwJeQCmTAude8bS16yrzqkPu/i6F3QD0ZOjs
 eYKxAUvx5/UaxR1suUhaN/7QHz6GD9hUzzqhogX5Mshrw3Ih4VHb/Rg10id8j8LSo+M/
 iG4UzUIbDruKIKzVnWJC3i1r5mbmWezjzUdLzdJXjlF1K+5wb9XOxl4mHethrdyww2xW
 +XchStTERe0BOgPUDk6RqAL+TQsJ2apoMFLYKI3oMk8UTuFKwa9iLiEbXCu33lPjU64D Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vhasgu40h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 20:12:47 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 409KADCX011323;
 Tue, 9 Jan 2024 20:12:47 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vhasgu408-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 20:12:47 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 409JswnQ004384; Tue, 9 Jan 2024 20:12:46 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfjpkrt7b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 20:12:46 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 409KCjgs16908968
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jan 2024 20:12:46 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95E2558059;
 Tue,  9 Jan 2024 20:12:45 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ECAC958055;
 Tue,  9 Jan 2024 20:12:44 +0000 (GMT)
Received: from [9.61.145.235] (unknown [9.61.145.235])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  9 Jan 2024 20:12:44 +0000 (GMT)
Message-ID: <fe4f8273-743c-4ea1-a13e-265d7d451b43@linux.ibm.com>
Date: Tue, 9 Jan 2024 14:12:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/10] hw/fsi: Introduce IBM's FSI master
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
References: <20231128235700.599584-1-ninad@linux.ibm.com>
 <20231128235700.599584-6-ninad@linux.ibm.com>
 <4b0a1cea-5a51-46aa-83ff-144b498a7556@kaod.org>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <4b0a1cea-5a51-46aa-83ff-144b498a7556@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SNY8yJvkEsOth5Mn79O0MgNuMLV6J2Af
X-Proofpoint-GUID: dJMz4TK6pmAORiQiXqSOPpRz1Utduh_q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_10,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 mlxlogscore=676 suspectscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401090162
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ninad@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Hello Cedric,


>> +static uint64_t fsi_master_read(void *opaque, hwaddr addr, unsigned 
>> size)
>> +{
>> +    FSIMasterState *s = FSI_MASTER(opaque);
>> +
>> +    trace_fsi_master_read(addr, size);
>> +
>> +    if (addr + size > sizeof(s->regs)) {
>
> See comment on patch 3
I fixed it.
>
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: Out of bounds read: 0x%"HWADDR_PRIx" for 
>> %u\n",
>> +                      __func__, addr, size);
>> +        return 0;
>> +    }
>> +
>> +    return s->regs[TO_REG(addr)];
>> +}
>> +
>> +static void fsi_master_write(void *opaque, hwaddr addr, uint64_t data,
>> +                             unsigned size)
>> +{
>> +    FSIMasterState *s = FSI_MASTER(opaque);
>> +
>> +    trace_fsi_master_write(addr, size, data);
>> +
>> +    if (addr + size > sizeof(s->regs)) {
I fixed it.
>>
>> +
>> +    /* address ? */
>> +    memory_region_add_subregion(&s->opb2fsi, 0, &s->cfam.mr);
>> +}
>> +
>> +static void fsi_master_reset(DeviceState *dev)
>> +{
>> +    FSIMasterState *s = FSI_MASTER(dev);
>
> Don't we want to set all values to some default ?
Initialize all other registers to 0 as FSI spec expect them to be zero 
except MVER and MLEVP0. I don't have reset value for MLEVP0 for ast2600. 
This is related to HOT plug detection so setting it to 0 for now.

Thanks for the review.

Regards,

Ninad


