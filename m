Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA4982F5C9
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 20:45:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPpMA-00016Q-Be; Tue, 16 Jan 2024 14:44:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rPpM8-00015r-Gs; Tue, 16 Jan 2024 14:44:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rPpM6-0002Yy-Ob; Tue, 16 Jan 2024 14:44:16 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40GJb9U4025946; Tue, 16 Jan 2024 19:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=KjmSLcCXwUJSr7jviLnzM7LFNWe+BgYhIXpN7fszjng=;
 b=QV5HkfdCcJsf8ATLmv4j+ovMNS7bckdP4RHvFwvnB4OxG9ebuEpOvgJwTpgXXz/JeLFr
 xtTmAv92/HV0uzt0MgnN6zJ4y4NTsOcnXzod8m4LtcApV+JEaHmigUTYUn5w08xlVrel
 HAnYYI144DSpzP5hoXLtfTroUzML2HI6CqZR/1CHGY4dBXYJf4xCgFDn1tfoZD3H7Xwi
 8qfo+yJvSucnyuP5d+UAG187/MBJV094488vstI9vKdyohz5HpT/Jzi30iAO/gAbd8FI
 49tqhBdXtKM3PfGhptMzAOuEt2cEFARkIWw3UKNn7nJ9UrX0wVAp0ODuHvgKV7jLYpR4 wg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vp042r7hf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 19:43:56 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40GJbfLJ028196;
 Tue, 16 Jan 2024 19:43:55 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vp042r7gt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 19:43:55 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40GJ16gU008541; Tue, 16 Jan 2024 19:43:54 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm5ungqrj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 19:43:54 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40GJhrAm52888148
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jan 2024 19:43:53 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8B885805A;
 Tue, 16 Jan 2024 19:43:53 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B55D58056;
 Tue, 16 Jan 2024 19:43:53 +0000 (GMT)
Received: from [9.24.12.86] (unknown [9.24.12.86])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jan 2024 19:43:53 +0000 (GMT)
Message-ID: <b062de94-d0df-43da-bac6-162ebb44485a@linux.ibm.com>
Date: Tue, 16 Jan 2024 13:43:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/9] hw/fsi: Introduce IBM's FSI master
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
References: <20240110231537.1654478-1-ninad@linux.ibm.com>
 <20240110231537.1654478-5-ninad@linux.ibm.com>
 <ea878161-a0cc-41ee-bece-3c2dc61eac21@kaod.org>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <ea878161-a0cc-41ee-bece-3c2dc61eac21@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hg5x8DNkQexRjY_JNbkCJXgoIfg3N69v
X-Proofpoint-ORIG-GUID: YXtlcFNLnfhIXzoF_PrGcdk0tD9-RwT8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_12,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 adultscore=0 mlxlogscore=706 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401160155
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ninad@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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


>>
>> [ clg: - move FSICFAMState object under FSIMasterState
>>         - introduced fsi_master_init()
>>         - reworked fsi_master_realize()
>>         - dropped FSIBus definition ]
>
> Move the list down before my S-o-b.
Done.
>
>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>
> I think you can drop Joel's reviews, the code has changed a lot.
Removed Joel's review tag.
>
>> +static void fsi_master_reset(DeviceState *dev)
>> +{
>> +    FSIMasterState *s = FSI_MASTER(dev);
>> +    int i;
>> +
>> +    /* Initialize registers */
>> +    for (i = 0; i < FSI_MASTER_NR_REGS; i++) {
>> +        s->regs[i] = 0;
>> +    }
>
> memset(s->regs, 0, sizeof(s->regs));

Replaced for loop with memset.

Thanks for the review.

Regards,

Ninad



