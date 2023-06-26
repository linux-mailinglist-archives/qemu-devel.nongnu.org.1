Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9123B73D71E
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 07:19:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDecH-0007Ov-FX; Mon, 26 Jun 2023 01:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.vnet.ibm.com>)
 id 1qDecE-0007Oh-UK; Mon, 26 Jun 2023 01:18:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.vnet.ibm.com>)
 id 1qDecC-0005Wz-8Q; Mon, 26 Jun 2023 01:18:18 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35Q5GxMu015553; Mon, 26 Jun 2023 05:18:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=e9rmNPARXczyJ4+4HaVxWHGjmN8/UzMOzNjCCnfQSiE=;
 b=MWGHCfKCxz4gYC1zwlHQK1m+vR+RNAZetD54cF42VP2Mh7zRKwUstZuPxpwrjq0DnJ6L
 P30x2h2QkHFb/1xZQraUdSDszH8BDbIeY1KYNDpmAbzebl5s2IWMFRTL32H6XK2MfGqa
 PX2lkTCA23nj70j65OBDJP9UzfshNQnB1BrJB2NBpMSdnIAcYLwpPQqqK0bFf6HH/VLQ
 zr3nJOPhoRfqd+WWZVuixJJGtOrbYhP2PdQbmAhwUvmE9OVEEL2LtKQOwYLK5A/cf7Rr
 77LPeRedVaYEBayRQl4crdnw+yOwivhbZi5I8oInrgUYng2KzLdxMuWexaHdYK2XAB8O +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rf4ctr0jy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jun 2023 05:18:03 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35Q5HaGW016942;
 Mon, 26 Jun 2023 05:18:02 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rf4ctr0jv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jun 2023 05:18:02 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35Q40QrQ023985;
 Mon, 26 Jun 2023 05:18:02 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
 by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3rdr45sabw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jun 2023 05:18:02 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35Q5I1pn56689028
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 05:18:01 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D1665805E;
 Mon, 26 Jun 2023 05:18:01 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6AC558056;
 Mon, 26 Jun 2023 05:17:58 +0000 (GMT)
Received: from [9.109.244.180] (unknown [9.109.244.180])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 26 Jun 2023 05:17:58 +0000 (GMT)
Message-ID: <2bfdaf0e-4da6-00a4-aa2b-4615b05179be@linux.vnet.ibm.com>
Date: Mon, 26 Jun 2023 10:47:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: qemu-system-ppc64 option -smp 2 broken with commit
 20b6643324a79860dcdfe811ffe4a79942bca21e
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nicholas Piggin <npiggin@gmail.com>, harshpb@linux.ibm.com,
 richard.henderson@linaro.org, alex.bennee@linaro.org
References: <8780abd9-59ef-c452-bfee-c3bfbf275e51@linux.vnet.ibm.com>
 <a474146f-cd1d-b91a-eefd-596a1d08f772@kaod.org>
From: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
In-Reply-To: <a474146f-cd1d-b91a-eefd-596a1d08f772@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xnq7vmbKPiMTKXe758mZMh6SH3yqLXfV
X-Proofpoint-ORIG-GUID: XRv779C--n6v1WOCY8D-zwLEkxx8XjKz
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_02,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 malwarescore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 clxscore=1011 phishscore=0 priorityscore=1501 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260045
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=anushree.mathur@linux.vnet.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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


On 6/23/23 19:16, Cédric Le Goater wrote:
> Hello Anushree,
>
> On 6/23/23 13:09, Anushree Mathur wrote:
>> Hi everyone,
>>
>> I was trying to boot rhel9.3 image with upstream qemu-system-ppc64 
>> -smp 2 option and observed a segfault (qemu crash).
>>
>> qemu command line used:
>>
>> qemu-system-ppc64 -name Rhel9.3.ppc64le -smp 2 -m 16G -vga none 
>> -nographic -machine pseries -cpu POWER10 -accel tcg -device 
>> virtio-scsi-pci -drive 
>> file=/home/rh93.qcow2,if=none,format=qcow2,id=hd0 -device 
>> scsi-hd,drive=hd0 -boot c
>>
>> After doing a git bisect, I found the first bad commit which 
>> introduced this issue is below:
>
> Could you please open a gitlab issue on QEMU project ?
>
>  https://gitlab.com/qemu-project/qemu/-/issues
>
> Thanks,
>
> C.
>
>> [qemu]# git bisect good
>> 20b6643324a79860dcdfe811ffe4a79942bca21e is the first bad commit
>> commit 20b6643324a79860dcdfe811ffe4a79942bca21e
>> Author: Richard Henderson <richard.henderson@linaro.org>
>> Date:   Mon Dec 5 17:45:02 2022 -0600
>>
>>      tcg/ppc: Reorg goto_tb implementation
>>
>>      The old ppc64 implementation replaces 2 or 4 insns, which leaves 
>> a race
>>      condition in which a thread could be stopped at a PC in the 
>> middle of
>>      the sequence, and when restarted does not see the complete address
>>      computation and branches to nowhere.
>>
>>      The new implemetation replaces only one insn, swapping between
>>
>>              b       <dest>
>>      and
>>              mtctr   r31
>>
>>      falling through to a general-case indirect branch.
>>
>>      Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>>      Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>
>>   tcg/ppc/tcg-target.c.inc | 152 
>> +++++++++++++----------------------------------
>>   tcg/ppc/tcg-target.h     |   3 +-
>>   2 files changed, 41 insertions(+), 114 deletions(-)
>> [qemu]#
>>
>> Can someone please take a look and suggest a fix to resolve this issue?
>>
>> Thanks in advance.
>> Regards,
>> Anushree-Mathur
>>
>>
Hello Cedric,
> As per your mail, I have created the gitlab issue 
> https://gitlab.com/qemu-project/qemu/-/issues/1726.

Thanks & Regards,

Anushree-Mathur

>

