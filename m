Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 720957992B4
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 01:12:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qekdG-0000fK-Qp; Fri, 08 Sep 2023 19:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qekdC-0000eP-D9; Fri, 08 Sep 2023 19:11:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qekd8-0004ay-TJ; Fri, 08 Sep 2023 19:11:17 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 388N8oeH019864; Fri, 8 Sep 2023 23:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=RlduIYERzoOiZ8ividXrPLZe+NmFKjiq5SkE6uRROU8=;
 b=lTW6i55MQyzsOHNk7EbOia8gdWFebo8/mVgY8ZVducpd8nZKAYr0kdCiRMHf7zZbRP79
 NsnS1+D7/Qy7KUlJZYIKLCWKwPXc25jMq9qVcgkryKffXA5tbzDQ3s138Jya18s5eEjN
 saP5AC7n6ZJ3A9g1w6tkhA/YMhUtNVDfqoMhMwzv8Efrpx9KJDULPBKGy9C3V9h32QDA
 fIh/ctiYqK8EYpLQQMsTpJyUH37Zs1hV4XJ73jOTtwSqa7O8QRs2kPNxYU3jYZ9dyATx
 ySAnYnYRe2bGFQiRd/8gPle4cwQwkRXyaY0CHxhsKQP8B91NAsryA/fVXzxOwTbQtorL AQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t0cdd0pe1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Sep 2023 23:11:00 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 388NAJrx026850;
 Fri, 8 Sep 2023 23:10:59 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t0cdd0p9u-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Sep 2023 23:10:59 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 388LgCbX001667; Fri, 8 Sep 2023 22:31:39 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svfctfk4y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Sep 2023 22:31:39 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 388MVdQj25821932
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Sep 2023 22:31:39 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59AD75805D;
 Fri,  8 Sep 2023 22:31:39 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0948458059;
 Fri,  8 Sep 2023 22:31:38 +0000 (GMT)
Received: from [9.61.102.160] (unknown [9.61.102.160])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Sep 2023 22:31:37 +0000 (GMT)
Message-ID: <8539cf6a-fbe7-4d94-9ad2-1011f7d70fe8@linux.ibm.com>
Date: Fri, 8 Sep 2023 17:31:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] hw/fsi: Documentation and testing
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@aj.id.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org
References: <20230830022638.4183766-1-ninad@linux.ibm.com>
 <20230830022638.4183766-9-ninad@linux.ibm.com>
 <0cdc9d0c-b146-e55f-cd2d-81e6827e64e4@redhat.com>
 <c722f63e-697b-eeab-82f0-7155b2a4632b@kaod.org>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <c722f63e-697b-eeab-82f0-7155b2a4632b@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7MOwr9sYm3yJUsNwAfA35F5mfPCz3Wo5
X-Proofpoint-ORIG-GUID: Koa2p7Z30VDeCF90GdE5jpe7Q8Gqhnd0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_18,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=622 phishscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080211
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

On 8/30/23 02:13, Cédric Le Goater wrote:
> On 8/30/23 09:05, Thomas Huth wrote:
>> On 30/08/2023 04.26, Ninad Palsule wrote:
>>> Added FSI document
>>> Added basic qtests for FSI model.
>>> Added MAINITAINER for FSI
>>> Replaced some qemu logs to traces.
>>
>> Sorry, that's not how we rework patch series in the QEMU development 
>> process. Please squash the log traces changes into the patches that 
>> introduced the original code, and please put the MAINTAINERS update, 
>> documentation and qtests into separate patches.
>
> yes. This is true for some Kconfig changes also. On that topic, please
> make sure FSI is compiled only when ASPEED_SOC is selected. It could be
> useful for the PPC PowerNV machines one day but the models are not
> available yet.

Fixed the Kconfig rework and make sure that FSI is selected only with 
ASPEED_SOC.


Thanks for the review.

~Ninad

>
> I will try to go through the series this week. Wait a bit for the v4.
>
> Thanks,
>
> C.
>
>

