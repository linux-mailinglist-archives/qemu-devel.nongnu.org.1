Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4944F753A41
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:57:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKHQ4-00035C-4U; Fri, 14 Jul 2023 07:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qKHQ2-000350-Co
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 07:57:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qKHQ0-0003UJ-Pb
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 07:57:06 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36EBq5O9026989; Fri, 14 Jul 2023 11:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=awXvWYWI+S06OvIjkQWGz9oosptjTuCbxgJhm/BrDtY=;
 b=DSY8iATLXZI82bpGxFkQqhxddu6xfK9s9Fz4WP4jJV+qiNx86G/iiMQpINW5kAA4JvdY
 RliaUd0U9Gum1hrnaWlAsWzf44/3/FcSqtYjOk3GfsDv2Yy1UcZPuWK3e+XZdQWj4OGy
 nSJngnvLvzIhGjzlFnY3Y71elxSlFfKUcLZ9oRqcR3AcFqKF1fKXydU909Js3/SisOhA
 Wte9fTS7Bwy/uFEhUXyo8TcKf7rbofUbE6h/T6ahGw8ZH18DrYnyugmSbgZjdJV5y6bj
 30pBqYHY7gbnLv1Soeohss63Zb89ZHgGBOBrgmIWMIa0byOmpil3ZzWT2NbqpzZO/WaX 3g== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ru5dx8ned-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 11:57:00 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36EBKYDd008399;
 Fri, 14 Jul 2023 11:56:59 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
 by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3rtq33nevd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 11:56:59 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36EBuwhF1180184
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jul 2023 11:56:58 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9417158062;
 Fri, 14 Jul 2023 11:56:58 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3CE2F5805D;
 Fri, 14 Jul 2023 11:56:58 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Jul 2023 11:56:58 +0000 (GMT)
Message-ID: <ee0effff-341a-8a69-3cc8-6f615c4743fe@linux.ibm.com>
Date: Fri, 14 Jul 2023 07:56:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 04/11] tpm_crb: use a single read-as-mem/write-as-mmio
 mapping
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20230713035232.48406-1-j@getutm.app>
 <20230713035232.48406-5-j@getutm.app>
 <4a49285e-0d91-93a0-2f8e-e76c71ed89f8@linux.ibm.com>
 <CAFEAcA-r_VOc18-jm99asYQQk4TJMBW_7oJMzFQofEHqVdF50A@mail.gmail.com>
 <ab339186-1af7-171c-eb11-fe124f12b4a2@linux.ibm.com>
 <CAFEAcA9nad4H3MgitMyVsZjNZdY-n9d65Yz4Gtbz2wPYA4fbsg@mail.gmail.com>
 <e2340c41-1d77-3406-001c-4dcce544af74@linux.ibm.com>
 <CAFEAcA-WtwcckNO=kDP8HbY53qV3mTtYysH2Lw8FSJsrWO2tdQ@mail.gmail.com>
 <afb324e8-d65a-12b3-e591-65133087689b@linux.ibm.com>
 <CAFEAcA9Z5wHRuMmeogoyrN=C4OtoKObxNu58nQaOXdYwzq_gpw@mail.gmail.com>
 <c5b44af5-e737-d899-5ea1-3d7debe760a4@linux.ibm.com>
 <CAFEAcA-igpEHJOxw8mCV=em6FRUT8BuNRPCiVMvQ7moaasSmLw@mail.gmail.com>
 <de9befdf-82ea-6cff-e300-7a9edf3e867b@linux.ibm.com>
 <CAFEAcA8KgSsmiCFA51vrYAFrXg6p8x=0_qM0wrZ4yHOWrQKp2A@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAFEAcA8KgSsmiCFA51vrYAFrXg6p8x=0_qM0wrZ4yHOWrQKp2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nUlu8TopbaFx0KFFYTgyh8a0EVWzoyeS
X-Proofpoint-ORIG-GUID: nUlu8TopbaFx0KFFYTgyh8a0EVWzoyeS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0 mlxscore=0
 mlxlogscore=936 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307140104
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 7/14/23 06:05, Peter Maydell wrote:
> On Thu, 13 Jul 2023 at 19:43, Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>>
>>
>> On 7/13/23 13:18, Peter Maydell wrote:
>>> On Thu, 13 Jul 2023 at 18:16, Stefan Berger <stefanb@linux.ibm.com> wrote:
>>>> I guess the first point would be to decide whether to support an i2c bus on the virt board and then whether we can use the aspeed bus that we know that the tpm_tis_i2c device model works with but we don't know how Windows may react to it.
>>>>
>>>> It seems sysbus is already supported there so ... we may have a 'match'?
>>>
>>> You can use sysbus devices anywhere -- they're just
>>
>> 'anywhere' also includes aarch64 virt board I suppose.
> 
> Yes. Literally any machine can have memory mapped devices.
> 
>>> "this is a memory mapped device". The question is whether
>>> we should, or whether an i2c controller is more like
>>> what the real world uses (and if so, what i2c controller).
>>>
>>
>>> I don't want to accept changes to the virt board that are
>>> hard to live with in future, because changing virt in
>>> non-backward compatible ways is painful.
>>
>> Once we have the CRB sysbus device we would keep it around forever and it seems to
>> - not require any changes to the virt board (iiuc) since sysbus is already being used
>> - works already with Windows and probably also Linux
> 
> "Add a sysbus device to the virt board" is the kind of
> change I mean -- once you do that it's hard to take it
> out again, and if we decide in 6 months time that actually
> i2c would be the better option then we end up with two
> different ways to do the same thing and trying to
> deprecate the other one is a pain.


At least CRB is a standard interface and from this perspective we are fine. I am not sure what would drive the introduction of the i2c bus in 6 months. I suppose one could then still use sysbus CRB device or the i2c device. The sysbus CRB device should still work then. Anyway, I think we should continue with this series.

    Stefan

> 
> -- PMM

