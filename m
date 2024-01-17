Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2910A83097E
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:16:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7e6-0003Ns-D1; Wed, 17 Jan 2024 10:16:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rQ7dn-0003Ib-Qg; Wed, 17 Jan 2024 10:15:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rQ7dl-0006Dj-Mw; Wed, 17 Jan 2024 10:15:43 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40HEqG7f008850; Wed, 17 Jan 2024 15:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=x24dAn+VjoOJ11mO82TTATuOvL1rFB2EBCgJwsBnwR8=;
 b=MKqbNcv/mNrnou0FKtOBRNCyFEy8Qi8p04F2q6zQL2dGwmVfaF94wBB0flK4Xgkmka6K
 BNBMQbipPC8hJMR+9fZcNuKOszKjn2c3YYZSAs7ihUbrlG1lZlcG2m4Y711AMTtcwnZq
 NqSN/ry0c5dA3TWLv8LRnUqddm7KdeNWrbMNwfree9KcAjCp6yWCed0MCzsE1D1DvpeW
 +nGZxZP9gUJGR8qAIY+uRHcAPHzP6FQ3h53SiB2T9mqjdpVkt0Q+m0HsHwpyN8+8qLdn
 LFXnMR3U7a2PLLg9QatGOG8r4yn9did1T7ZMHf6ASlKwxW5r6GQkCtrKk3ThOpGuliIw Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vph1k0mfu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 15:15:36 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40HFFTAk002948;
 Wed, 17 Jan 2024 15:15:29 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vph1k0keb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 15:15:28 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40HEOY51010889; Wed, 17 Jan 2024 15:11:33 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm57yp7hk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 15:11:33 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40HFBW0425625308
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jan 2024 15:11:32 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 455BA58056;
 Wed, 17 Jan 2024 15:11:32 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 73E2D5803F;
 Wed, 17 Jan 2024 15:11:31 +0000 (GMT)
Received: from [9.61.163.245] (unknown [9.61.163.245])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jan 2024 15:11:31 +0000 (GMT)
Message-ID: <0eacba30-338b-4eac-9986-e4e675c7b66b@linux.ibm.com>
Date: Wed, 17 Jan 2024 10:11:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] s390x/pci: avoid double enable/disable of aif
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, frankja@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org
References: <20240116223157.73752-1-mjrosato@linux.ibm.com>
 <20240116223157.73752-2-mjrosato@linux.ibm.com>
 <8a205b58-7efb-4d68-8f37-f7ac906d646a@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <8a205b58-7efb-4d68-8f37-f7ac906d646a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gzXLcAiq03SqxrM4vKcI4gVTn1Us2z5v
X-Proofpoint-ORIG-GUID: dKY_ukk1AAVljp8IxvspmhTVzzATsY-y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 mlxlogscore=350 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401170110
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 1/17/24 5:54 AM, Cédric Le Goater wrote:
> On 1/16/24 23:31, Matthew Rosato wrote:
>> Use a flag to keep track of whether AIF is currently enabled.  This can be
>> used to avoid enabling/disabling AIF multiple times as well as to determine
>> whether or not it should be disabled during reset processing.
> 
> Why don't we disable AIF always at reset ? Doesn't KVM handle multiple calls
> to KVM_S390_ZPCIOP_DEREG_AEN cleanly ? Just asking, I am no expert there.
>

This may be some amount of defensive programming on my part :) Really, we're more concerned about enabling AIF twice without disabling AIF in between, and if we attempt to do so we should fail immediately rather than try messing with the hostdev.

The kernel warning you were seeing was exactly because we got the guest ISC users count wrong due to a mismatch between the number of enables and disables; in a sense, that warning is the KVM cleanup handling things (by disabling the gisc that AIF was using but also spitting out the warning that we got the gisc usage count wrong).  

I suspect you're right in that there's room to improve the KVM code so that we can catch this earlier rather than continuing to increment/decrement the guest ISC count and waiting to catch it at the end of the VM lifecycle (the GISC count is per-VM, but we should only ever have 1 instance per-device but are allowing >1 per-device).  I'll have a look at that separately from this series but IMHO QEMU should also try and 'behave' and be aware of what it previously enabled/disabled; if QEMU is trying to enable AIF multiple times then QEMU is doing something wrong.

