Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F205171801B
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 14:42:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4L7z-0008IB-04; Wed, 31 May 2023 08:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1q4L7v-0008HZ-B4; Wed, 31 May 2023 08:40:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1q4L7i-0004FB-EO; Wed, 31 May 2023 08:40:31 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34VCaF4s028643; Wed, 31 May 2023 12:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=h28m4HyIJyP7XQJbJxSIu9iLvFc6nuPK4pJSy0I+HPI=;
 b=Xh+CKrp+3hyzLpOpo439BTa910nhk1zud97OPPJf+nfBefYGXMssf/Bkdxx8IJs+4Y9L
 Vj5k3NsMhnp5Ugf+wstiVNs2jKBWAzqsp1elaFJnaz/cNDZaUOuX//9PZXCODQKtRlEw
 bV+a5ZAzBsDH+TRHviqYPV+yt5WruGGTFOD5LKNgUuUKIyWDYMbSS8lX5rr1I8Z923f0
 4Bx4uo1ZTDMNEvp+YO6fVxuVFeY9xtV62kQA0BkTVEty7l4e9LDHcK8fNGtvcW7gwbt3
 GyNF4RfFmvFeKZMGhu7vRhkhtCmVCTtjq8lgOQeHRAZyn+TPaEVIxz0cmtCOb3XbH+nw tw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qx653rfy2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 May 2023 12:40:15 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34VCaMrd030080;
 Wed, 31 May 2023 12:40:15 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qx653rfwc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 May 2023 12:40:15 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34VBUOhF009542;
 Wed, 31 May 2023 12:40:13 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
 by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3qu9g5un0y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 May 2023 12:40:13 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34VCeCNF59244846
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 May 2023 12:40:12 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 114A358059;
 Wed, 31 May 2023 12:40:12 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 42E3358043;
 Wed, 31 May 2023 12:40:11 +0000 (GMT)
Received: from [9.61.88.233] (unknown [9.61.88.233])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 31 May 2023 12:40:11 +0000 (GMT)
Message-ID: <24c0a1b0-4008-7f34-c33d-01e39721c1e4@linux.ibm.com>
Date: Wed, 31 May 2023 08:40:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/2] s390x/ap: fix hang when mdev attached to guest is
 removed
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, mjrosato@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, fiuczy@linux.ibm.com, thuth@redhat.com,
 farman@linux.ibm.com, borntraeger@linux.ibm.com
References: <20230530225544.280031-1-akrowiak@linux.ibm.com>
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20230530225544.280031-1-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SBU2Fh93mfYNMX_779tFgooFG3YHsdUP
X-Proofpoint-ORIG-GUID: ZqHVlTz07ggmOLLHb-Hn1heWUeZnSo-f
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_08,2023-05-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 impostorscore=0 adultscore=0 mlxscore=0 mlxlogscore=624
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310108
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091, SPF_HELO_NONE=0.001,
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

The required kernel changes associated with the patch are here:

https://lore.kernel.org/linux-s390/20230530223538.279198-1-akrowiak@linux.ibm.com/

On 5/30/23 6:55 PM, Tony Krowiak wrote:
> When a user attempts to remove a vfio-ap mediated device attached to a
> guest, the operation hangs until the mdev's fd is closed by the guest
> (i.e., the guest is shut down). This patch series provides userspace
> (i.e., qemu) code to handle device unplug requests for AP. When notified
> that the mdev is being removed, the handler will unplug the device, thus
> avoiding the hang condition.
> 
> Tony Krowiak (2):
>    linux-headers: Update with vfio_ap IRQ index mapping
>    s390x/ap: Wire up the device request notifier interface
> 
>   hw/vfio/ap.c               | 113 +++++++++++++++++++++++++++++++++++++
>   linux-headers/linux/vfio.h |   9 +++
>   2 files changed, 122 insertions(+)
> 

