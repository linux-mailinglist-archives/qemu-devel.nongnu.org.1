Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 774CE78C515
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 15:22:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qayfS-0004Iv-B1; Tue, 29 Aug 2023 09:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qayfO-0004H8-An; Tue, 29 Aug 2023 09:21:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qayfL-0003KX-F5; Tue, 29 Aug 2023 09:21:57 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37TD6wQZ024159; Tue, 29 Aug 2023 13:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=if/UmBRbHks8AhQkajFRWvHYh/7FmeO9jsi7m060SvI=;
 b=fFdpa3+/OdaWJaYU4ScPrdtMqV/htABG9ii9564kIRj++Q5jeSzC+nlUFOwvp9/6+59l
 29aYdHZrZ+6vMgmdZDjHGQ/f6yJ+wakn4p1d07YSmO9AkeyGr6xhrQiccPKaWTZOS4Dh
 FADjAB/gMxKOR5YHqdbq50gLH5J0pnluJGm53pToPckxa7PbYrnbCXQafb6TkBSZFA24
 GjEHif3sv+KegHb9jy7HXvFd8RxfamBTQcpYAvY3OICkXBrvjGdJ1r9nHZMDeZWinbhY
 8NaSwYdLz/ZMuc7h8eWujCeqH4vuf0yl2RTjXO7bkJtwm2aW7tlsM8MEf1AS/rfjHtss kw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr7vywgy3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Aug 2023 13:21:36 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37TDFjwN008005;
 Tue, 29 Aug 2023 13:21:36 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr7vywgxh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Aug 2023 13:21:36 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37TBwIge020514; Tue, 29 Aug 2023 13:21:34 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqv3ybu3y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Aug 2023 13:21:34 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37TDLYAv4850210
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Aug 2023 13:21:34 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01BA65805C;
 Tue, 29 Aug 2023 13:21:34 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E59C58051;
 Tue, 29 Aug 2023 13:21:33 +0000 (GMT)
Received: from [9.61.30.201] (unknown [9.61.30.201])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Aug 2023 13:21:33 +0000 (GMT)
Message-ID: <bce207e1-8a79-431f-9f87-665d234eed70@linux.ibm.com>
Date: Tue, 29 Aug 2023 08:21:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/7] hw/fsi: Introduce IBM's scratchpad
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, clg@kaod.org,
 peter.maydell@linaro.org, andrew@aj.id.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 philmd@linaro.org
Cc: qemu-arm@nongnu.org
References: <20230825203046.3692467-1-ninad@linux.ibm.com>
 <20230825203046.3692467-3-ninad@linux.ibm.com>
 <6d153709-8099-7737-8fbd-3988a35af71a@redhat.com>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <6d153709-8099-7737-8fbd-3988a35af71a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: C1adgvMOD0_mAp78b_n-0d65gA-G7bTJ
X-Proofpoint-GUID: b0adT_c0eyEuzCrzSqPoUbSX-j8mIvDn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_10,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=576
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308290113
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

Hello Thomas,

On 8/28/23 20:52, Thomas Huth wrote:
> On 25/08/2023 22.30, Ninad Palsule wrote:
>> This is a part of patchset where IBM's Flexible Service Interface is
>> introduced.
>>
>> The LBUS device is embeded inside the scratchpad. The scratchpad
>> provides a non-functional registers. There is a 1-1 relation between
>> scratchpad and LBUS devices. Each LBUS device has 1K memory mapped in
>> the LBUS.
>>
>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>>   hw/fsi/Kconfig                     |   4 ++
>>   hw/fsi/engine-scratchpad.c         | 100 +++++++++++++++++++++++++++++
>>   hw/fsi/meson.build                 |   1 +
>>   include/hw/fsi/engine-scratchpad.h |  32 +++++++++
>>   4 files changed, 137 insertions(+)
>>   create mode 100644 hw/fsi/engine-scratchpad.c
>>   create mode 100644 include/hw/fsi/engine-scratchpad.h
>>
>> diff --git a/hw/fsi/Kconfig b/hw/fsi/Kconfig
>> index 687449e14e..2a9c49f2c9 100644
>> --- a/hw/fsi/Kconfig
>> +++ b/hw/fsi/Kconfig
>> @@ -1,2 +1,6 @@
>> +config SCRATCHPAD
>> +    bool
>> +    select LBUS
>> +
>>   config LBUS
>>       bool
>
> The config names sound pretty generic ... could you maybe name them 
> FSI_SCRATCHPAD and FSI_LBUS instead?

OK, I fixed it by adding the FSI prefix.

Thank you for the review.

Ninad

>
>  Thomas
>
>

