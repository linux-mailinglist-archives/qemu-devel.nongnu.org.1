Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 919B3828E90
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 21:38:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNIq8-00026T-Ut; Tue, 09 Jan 2024 15:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rNIq4-000266-4F; Tue, 09 Jan 2024 15:36:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rNIq2-0004K9-1X; Tue, 09 Jan 2024 15:36:43 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 409JQoEl028378; Tue, 9 Jan 2024 20:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=nTImzp0pTnmAT5IeJRugicRBVxPnDDTOLcc8+ad6pCA=;
 b=i3SpWgj6sRGwMC4VE/eoPVweLSxg0uwPRiG5g9/FpQOdrAtczKC/JwHbTeoaIl1mRzpp
 AIBcuS2JmE2Wg32Xi3twIAareZ25SZXMqCX4btD1FIqqyEFwI8Tfq6Tn/IntLSUNJezO
 jkKK2MZ3Kq3nHa0qm85pAm1fvgYAqKiRsOAaKIjEMUeHOGE3pt6Ohm0dMF5IDsZw1dAa
 nJvtOzEqiP6D3w/TsRkSy+ko5VldCCC4hv7FIy4A0QaazOPX1I58kMNGW3FqvHUAhkZC
 P0OssMK7FOzQakQ5VoJHMuRk85Ge6PXHtgVfaasYLbYKWBuqvYFrEg25dAz1wI5pdONI 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vhcachdh6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 20:31:14 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 409Ju8PV014633;
 Tue, 9 Jan 2024 20:31:13 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vhcachdbg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 20:31:13 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 409Jg2GX004407; Tue, 9 Jan 2024 20:30:54 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfjpkrvmk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 20:30:54 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 409KUrio17498714
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jan 2024 20:30:53 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5FDFC58043;
 Tue,  9 Jan 2024 20:30:53 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 095A85805D;
 Tue,  9 Jan 2024 20:30:53 +0000 (GMT)
Received: from [9.61.145.235] (unknown [9.61.145.235])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  9 Jan 2024 20:30:52 +0000 (GMT)
Message-ID: <d5fc4e81-cb00-4bbf-986c-2541fda61742@linux.ibm.com>
Date: Tue, 9 Jan 2024 14:30:52 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/10] hw/fsi: Aspeed APB2OPB interface
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
References: <20231128235700.599584-1-ninad@linux.ibm.com>
 <20231128235700.599584-7-ninad@linux.ibm.com>
 <9139c58e-4a76-4b13-a1da-c1aafc37fad2@kaod.org>
 <c617be9c-c923-4228-81f6-bc492cc3edfe@linux.ibm.com>
 <e09b5baa-8147-4450-a899-e015a9fd0f35@kaod.org>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <e09b5baa-8147-4450-a899-e015a9fd0f35@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Sj99jSBGb7Y10adyl8Yst6YtTqiwAPNW
X-Proofpoint-GUID: aCZvejtut8WN2FxuwrBDuuCLropi-eH6
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_10,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxlogscore=536 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401090165
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


>>>> +    for (i = 0; i < ASPEED_FSI_NUM; i++) {
>>>> +        if (!qdev_realize_and_unref(DEVICE(&s->fsi[i]), 
>>>> BUS(&s->opb[i]),
>>>
>>>
>>> s->fsi[i] is not allocated. We should use qdev_realize instead.
>>
>> I am not sure I understood this. FSIMasterState fsi[ASPEED_FSI_NUM]; 
>> is inside structure AspeedAPB2OPBState so it must be allocated, right?
>
> See the documentation :
>
> https://www.qemu.org/docs/master/devel/qdev-api.html#c.qdev_realize_and_unref

Fixed it. Thanks for the review.

Regards,

Ninad


