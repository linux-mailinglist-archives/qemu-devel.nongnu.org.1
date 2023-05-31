Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0649C718166
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:23:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Llq-0000u2-LV; Wed, 31 May 2023 09:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1q4Llj-0000tB-Id; Wed, 31 May 2023 09:21:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1q4Lld-000401-3s; Wed, 31 May 2023 09:21:37 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34VCiDXd031052; Wed, 31 May 2023 13:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=lwd41rv865siONu2+ETpcfyX8ebf5aa2tsZh+zkXBGg=;
 b=H0gMRhpgfqhqBIlQyvt4+0mniJ3pNPpo1y/ofZc2DVcsBK9eCIsmUV49WooOlxOJszYh
 rPt5WGWE5scZeibKAsQKzNTyoc2DY+M8BRjL8ytZYJ+lubgs/HXz7zhJ2R4h/mLetmoN
 xRW9RJ2/0c1VWDPJTCAS9w24CcDZ81LG8rQvg6Okl4DIyHr2kocHHpCjuPqML0pz4guQ
 A94YjvGu4kYy4wxIYBcEdhpGQaQEKdow+2Wq4jVOjocCHryo7va6b2o1nFJsD78oryp6
 Ie1yeFrHNZSMuqMpOzkOhCqqG3ngs8qSOhDZWibU8ctbTLLYTx5Rzo6JIttXe1i39Al6 CA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qx6ggh8f2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 May 2023 13:21:31 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34VCiX58031717;
 Wed, 31 May 2023 13:21:30 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qx6ggh8ev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 May 2023 13:21:30 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34VBLt6R008119;
 Wed, 31 May 2023 13:21:30 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
 by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3qu9g8btr3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 May 2023 13:21:30 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34VDLS3E3801616
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 May 2023 13:21:28 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F2DF58055;
 Wed, 31 May 2023 13:21:28 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8BFF558043;
 Wed, 31 May 2023 13:21:27 +0000 (GMT)
Received: from [9.61.88.233] (unknown [9.61.88.233])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 31 May 2023 13:21:27 +0000 (GMT)
Message-ID: <cc329c28-2727-5a2e-8798-82d01a095c73@linux.ibm.com>
Date: Wed, 31 May 2023 09:21:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] linux-headers: Update with vfio_ap IRQ index mapping
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 fiuczy@linux.ibm.com, thuth@redhat.com, farman@linux.ibm.com,
 borntraeger@linux.ibm.com
References: <20230530225544.280031-1-akrowiak@linux.ibm.com>
 <20230530225544.280031-2-akrowiak@linux.ibm.com>
 <06630472-57c8-89dd-ad80-75fb4d0d7de9@linux.ibm.com>
 <76dd7f44-56a5-91fd-13c2-fb1579c588ab@linux.ibm.com>
 <87sfbck5sz.fsf@redhat.com>
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <87sfbck5sz.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TtLmr7xw0voHsR8ouwZCb5DnCfTQXCGl
X-Proofpoint-ORIG-GUID: _HOVu6umuq-NfjfP5nZ99U_8u5yidy6e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_08,2023-05-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 mlxscore=0 impostorscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310112
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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



On 5/31/23 9:07 AM, Cornelia Huck wrote:
> On Wed, May 31 2023, Anthony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
>> On 5/30/23 8:56 PM, Matthew Rosato wrote:
>>> On 5/30/23 6:55 PM, Tony Krowiak wrote:
>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>>> ---
>>>>    linux-headers/linux/vfio.h | 9 +++++++++
>>>>    1 file changed, 9 insertions(+)
>>>
>>> Worth nothing here that linux-headers patches should be generated using scripts/update-linux-headers.sh.
>>>
>>> Since this linux-headers update includes changes that aren't merged into the kernel yet, I would still use update-linux-headers.sh -- but also include in the commit message that this is a placeholder patch that includes unmerged uapi changes.  Then once the kernel changes merge you can just have a proper linux-headers update patch in a subsequent qemu series.
>>
>> I guess I do not understand the procedure here. I first determined the
>> latest kernel release in which the vfio.h file was updated with the
>> following command:
>> git log --oneline origin/master -- linux-headers/linux/vfio.h
>>
>> According to the git log, the vfio.h file was last updated in kernel
>> v6.3-rc5. I cloned that kernel from
>> git.kernel.org/pub/scm/linux/kernel/git/stable and checked out kernel
>> 6.3-rc5. I then made the changes to the linux-headers/linux/vfio.h file
>> and ran the update-linux-headers.sh script and created this patch from
>> that. Where did I go wrong?
> 
> I think your procedure is fine for changes that are local to a single
> header file. The one thing I'd recommend is to put an explicit "dummy
> patch, to be replaced by a proper headers update" note into the patch,
> so that it doesn't get merged by accident.
> 
> (For complex changes, headers update + explicit note might be better,
> but the simple approach works in most cases.)

Will do.

> 

