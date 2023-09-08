Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80672799247
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 00:31:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qek09-000416-23; Fri, 08 Sep 2023 18:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qek01-0003pB-2W; Fri, 08 Sep 2023 18:30:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qejzy-0003qU-Ne; Fri, 08 Sep 2023 18:30:48 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 388MRoDq028908; Fri, 8 Sep 2023 22:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=IbtAPsVahdjhhCp0W9wHvFHU6Xe+uMZ08u23WLjdhcU=;
 b=M+A0dUV0zfzMqzvzwuzTW0sEFPxYMHaHp+76Qtvp6pVEG9kgR02OQBlPFikscqD5k6Yo
 pMYZWvpmkwM45i1lBTSAeBtN5HCKyBbxvKc6Ehn56kQfrSbP8PpFeUwwUMlEydt6skMn
 6v4fr+nOIkwF4aSpMgw8mgJ+i4lALwEQ76qkhaeXwxE+3NDWYIXOfRd+7vrF94S7cM5D
 gfQbLb5BzrWYvqoSVyV+SmT6eWqVED13k2n8M+wX2Gb6Lpsj1Q3J9c9eJBj9luDgrMLY
 0omzU8TWlnSrp0h0Rnpo5oJydnyf9WNmjpOrdniGd2c0Iy9EnHS7ob18wA+8oivmfaP5 Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t0cdxg0yk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Sep 2023 22:30:33 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 388MUXkT001848;
 Fri, 8 Sep 2023 22:30:33 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t0cdxg0yd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Sep 2023 22:30:33 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 388KLHGD006611; Fri, 8 Sep 2023 22:30:32 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgvm717s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Sep 2023 22:30:32 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 388MUVDs4260520
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Sep 2023 22:30:32 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A53C358068;
 Fri,  8 Sep 2023 22:30:31 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B0AD58066;
 Fri,  8 Sep 2023 22:30:30 +0000 (GMT)
Received: from [9.61.102.160] (unknown [9.61.102.160])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Sep 2023 22:30:30 +0000 (GMT)
Message-ID: <ed6974cd-2406-4295-910c-7e445977b22c@linux.ibm.com>
Date: Fri, 8 Sep 2023 17:30:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] hw/fsi: Documentation and testing
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, clg@kaod.org,
 peter.maydell@linaro.org, andrew@aj.id.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org
References: <20230830022638.4183766-1-ninad@linux.ibm.com>
 <20230830022638.4183766-9-ninad@linux.ibm.com>
 <0cdc9d0c-b146-e55f-cd2d-81e6827e64e4@redhat.com>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <0cdc9d0c-b146-e55f-cd2d-81e6827e64e4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aRvFi3fsrRElli26TUL61eVSyE7vOw5h
X-Proofpoint-ORIG-GUID: pup27NJQ2853y0_6nD-PuBwyPuGJEev9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_18,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=704 clxscore=1015 suspectscore=0
 adultscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080201
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

Hello Thomas,

On 8/30/23 02:05, Thomas Huth wrote:
> On 30/08/2023 04.26, Ninad Palsule wrote:
>> Added FSI document
>> Added basic qtests for FSI model.
>> Added MAINITAINER for FSI
>> Replaced some qemu logs to traces.
>
> Sorry, that's not how we rework patch series in the QEMU development 
> process. Please squash the log traces changes into the patches that 
> introduced the original code, and please put the MAINTAINERS update, 
> documentation and qtests into separate patches.

Fix the rework issue and added separate patches for MAINTAINER, doc and 
qtests.

Thanks for the review.

~Ninad



>
>  Thanks,
>   Thomas
>
>

