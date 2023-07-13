Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59870752932
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 18:55:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJza3-0002Z7-Fy; Thu, 13 Jul 2023 12:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qJzZw-0002XJ-Ke
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 12:54:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qJzZt-0007nb-SO
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 12:54:08 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DGknaD029717; Thu, 13 Jul 2023 16:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Qvzusqe3VQX7yCid3bH6ZPsmZY4KvwDVsj65CLB6o2Y=;
 b=GinBU7vlq0QxA+qZGTL+EFSx4Pjdo/8KmVI2Ank5AQi3FWSfOzhxS0Rwnoc2iyVuwBIW
 1g9JjQSWZ2pb4GGhYPK07CfHS3SX9kj+qGeBYMKe6lcAlLrjKa6CXhfhEuZO9r4QSXBG
 YXVl2LQ9vHTSbiCgz9ur4YCG9tibTUX8Im1Xwl1C2EWr7dYErHMw+qhIj1xcsmd6vOwc
 +ILuHXffmTN9sAwtgSoB1uOGw+TVwym0tw8rYZyLrmDxcTbbdc67aSMYDf3SSi3fMK9t
 y4TXS4/zU01qtjSOTQkb7EpoR5FNNY2ORWv6VBiTZ9JhwDyFLlKWlRf7lEm0NhX94PUl EA== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rtm73sv4a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 16:54:01 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DDwphY014894; Thu, 13 Jul 2023 16:54:00 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rqjgxgbuy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 16:54:00 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36DGrxhD2425380
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jul 2023 16:53:59 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C6CEC58060;
 Thu, 13 Jul 2023 16:53:59 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 612405804E;
 Thu, 13 Jul 2023 16:53:59 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Jul 2023 16:53:59 +0000 (GMT)
Message-ID: <afb324e8-d65a-12b3-e591-65133087689b@linux.ibm.com>
Date: Thu, 13 Jul 2023 12:53:58 -0400
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
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAFEAcA-WtwcckNO=kDP8HbY53qV3mTtYysH2Lw8FSJsrWO2tdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6YZ2v05FZCeknrYjfkt9Y6WScf7xCnEl
X-Proofpoint-ORIG-GUID: 6YZ2v05FZCeknrYjfkt9Y6WScf7xCnEl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130146
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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



On 7/13/23 11:55, Peter Maydell wrote:
> On Thu, 13 Jul 2023 at 16:46, Stefan Berger <stefanb@linux.ibm.com> wrote:
>> On 7/13/23 11:34, Peter Maydell wrote:
>>> On Thu, 13 Jul 2023 at 16:28, Stefan Berger <stefanb@linux.ibm.com> wrote:
>>>> On 7/13/23 10:50, Peter Maydell wrote:
>>>>> I'm not a super-fan of hacking around the fact that LDP
>>>>> to hardware registers isn't supported in specific device
>>>>> models, though...
>>>>
>>>> What does this mean for this effort here?
>>>
>>> Usually we say "fix the guest to not try to access hardware
>>> registers with silly load/store instruction types". The other
>>> option would be "put in a large amount of effort to support
>>> emulating those instructions in QEMU userspace when KVM/HVF/etc
>>> trap and punt them to us". For the last decade or so we have
>>> taken the first of these approaches :-)
>>
>> Is Microsoft likely to react to use telling them "fix the guest"?
> 
> They have on occasion in the past, yes.
> 
> The other outstanding question here is if this TPM device
> should be a sysbus one at all (i.e. not i2c), which might
> render this part moot.

Does the aarch64 virt VM support an i2c bus? Would it support the aspeed i2c bus? Does Windows then accept this i2c bus? Maybe the faster answer comes via this device that Joelle presumably has working on AARCH64 Windows.


    Stefan
> 
> thanks
> -- PMM

