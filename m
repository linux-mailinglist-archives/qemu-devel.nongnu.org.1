Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B931178BA09
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 23:15:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qajYS-0000pj-LT; Mon, 28 Aug 2023 17:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qajYO-0000pT-F5; Mon, 28 Aug 2023 17:13:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qajYL-000231-5d; Mon, 28 Aug 2023 17:13:43 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37SKf6oN002944; Mon, 28 Aug 2023 21:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4uDvgMJ/N99UKaSPnjFAAAGk+jQ2jq5R3+otKSouK+4=;
 b=AfL8RMpRDY2tC4poddsdgDmkvxpzcy7PdqJ3jzor0sJiEjv6YbyZZDyxX9UZgb1ZQ2XI
 TCCS7cOxv4f6TTQj2/qzxBnVHfPO7L/sHtUjTS54oN3AGCMfmPLg++FzCwotEd1cD4Ks
 RZ/5lZYVc6LrMMaXtF0sGtxBeafS7sED4vIvuAeBz7mECBqzP/QJHt5vqzg7WOW69/JD
 5SHweXJ3kYqTgN8g39dBJ+W8hGSdDOtnngxd+zggkg5t/5nIyEQLtaRh3TgX+/MiGWeA
 GbtvgixtDKCKqiWCqsolqIf7GRFTz7aO2PrEnPd0IRPcyNAZI7jrP4NP9lZcivecMU4F EA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr8q7gq8s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Aug 2023 21:13:24 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37SLBHAL007427;
 Mon, 28 Aug 2023 21:13:23 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr8q7gq76-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Aug 2023 21:13:23 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37SJAPFL014100; Mon, 28 Aug 2023 21:13:19 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sqwxjnwc4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Aug 2023 21:13:19 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37SLDIRB42402202
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Aug 2023 21:13:18 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E871E58051;
 Mon, 28 Aug 2023 21:13:17 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7456F5805C;
 Mon, 28 Aug 2023 21:13:17 +0000 (GMT)
Received: from [9.61.30.201] (unknown [9.61.30.201])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 28 Aug 2023 21:13:17 +0000 (GMT)
Message-ID: <b1de4d8b-a8c1-488e-9d7b-62417dd40d59@linux.ibm.com>
Date: Mon, 28 Aug 2023 16:13:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/7] Introduce model for IBM's FSP
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@aj.id.au, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 berrange@redhat.com, thuth@redhat.com, philmd@linaro.org,
 qemu-arm@nongnu.org
References: <20230825203046.3692467-1-ninad@linux.ibm.com>
 <CACPK8XeDo7USEw6_fMYHhcdpRJsKGzj1-N+cdMBMu1a2ub_PZQ@mail.gmail.com>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <CACPK8XeDo7USEw6_fMYHhcdpRJsKGzj1-N+cdMBMu1a2ub_PZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1jQ0oIZ6OBVei_N87-AThDJ1dxMay9YC
X-Proofpoint-ORIG-GUID: lTqYR89WUSHY4su1TzefUhNGyRDI8xNt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_18,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 mlxlogscore=410 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280181
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

Hi Joel,

On 8/28/23 23:25, Joel Stanley wrote:
> Hi Ninad,
>
> On Fri, 25 Aug 2023 at 20:51, Ninad Palsule <ninad@linux.ibm.com> wrote:
>> Hello,
>>
>> Please review the patch-set.
>>
>> This is a first step towards introducing model for IBM's Flexible
>> Service Interface. The full functionality will be implemented over the
>> time.
> You have a typo in the subject, I think you meant to write FSI instead of FSP.

Good catch. Fixed the typo.

Thank you for the review.

Ninad


