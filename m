Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FAE725011
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 00:44:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6fOm-0004Jt-Nv; Tue, 06 Jun 2023 18:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1q6fOk-0004JA-RR
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 18:43:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1q6fOi-0008LM-Mi
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 18:43:30 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 356IYova005714; Tue, 6 Jun 2023 22:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=mBCNPwN18aMw3pGOTHiZyDydDZY91+Oyitp8pGNOvRM=;
 b=Z7lyWMliiK3HyEw3q2Z0pkAI6QAxSPrP8eruVn76cqk6hmZgkVJX8XP4Y3ndbLMugcTU
 U3hWpS8ogZWkPskZc2udag2OMCQ1Cwwe8gTp/AfSHpSsW1wkQ7GhEE7L84GQC7U84o4O
 ZVt61Js8oDZ1yqLpYgLB2ujJO0P7kOfkahVQWXnoNju+bpbbjNUkHzcchfR5WNRQjAxw
 Q+ouDhR4XXvx9+B1NW5BXHkHqbiCH7XQxQzh43Ahmt+hozruFDmyRY3xoR5LDyf3C383
 gj//3bVw4u2yv/OEcn6q/J67IgWd7G2GCG22HQHpPqWhK11N4v8sEG4srgCdkIeld68M SA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6pge9b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 06 Jun 2023 22:43:15 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 356KYkJr002953; Tue, 6 Jun 2023 22:43:14 GMT
Received: from [10.132.95.70] (dhcp-10-132-95-70.usdhcp.oraclecorp.com
 [10.132.95.70])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3r2a6jfgwu-1; Tue, 06 Jun 2023 22:43:14 +0000
Message-ID: <c59d2d67-d31a-b6e6-54c5-5b81c18d9547@oracle.com>
Date: Tue, 6 Jun 2023 15:44:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Reducing vdpa migration downtime because of memory pin / maps
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>
Cc: Jason Wang <jasowang@redhat.com>, Michael Tsirkin <mst@redhat.com>,
 Longpeng <longpeng2@huawei.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eli Cohen <elic@nvidia.com>, Parav Pandit <parav@nvidia.com>,
 Juan Quintela <quintela@redhat.com>, David Gilbert <dgilbert@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <CAJaqyWdV6pKP0SVZciMiu_HN86aJriZh0HBiwHNkO7+yErXnBA@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
In-Reply-To: <CAJaqyWdV6pKP0SVZciMiu_HN86aJriZh0HBiwHNkO7+yErXnBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_16,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306060190
X-Proofpoint-ORIG-GUID: W23fmTGXh-eAnBBhlLf1lZ5cy9pDkYhj
X-Proofpoint-GUID: W23fmTGXh-eAnBBhlLf1lZ5cy9pDkYhj
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.094, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
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

Sorry for reviving this old thread, I lost the best timing to follow up 
on this while I was on vacation. I have been working on this and found 
out some discrepancy, please see below.

On 4/5/23 04:37, Eugenio Perez Martin wrote:
> Hi!
>
> As mentioned in the last upstream virtio-networking meeting, one of
> the factors that adds more downtime to migration is the handling of
> the guest memory (pin, map, etc). At this moment this handling is
> bound to the virtio life cycle (DRIVER_OK, RESET). In that sense, the
> destination device waits until all the guest memory / state is
> migrated to start pinning all the memory.
>
> The proposal is to bind it to the char device life cycle (open vs
> close),

Hmmm, really? If it's the life cycle for char device, the next guest / 
qemu launch on the same vhost-vdpa device node won't make it work.


>   so all the guest memory can be pinned for all the guest / qemu
> lifecycle.

I think to tie pinning to guest / qemu process life cycle makes more 
sense. Essentially this pinning part needs to be decoupled from the 
iotlb mapping abstraction layer, and can / should work as a standalone 
uAPI. Such that QEMU at the destination may launch and pin all guest's 
memory as needed without having to start the device, while awaiting any 
incoming migration request. Though problem is, there's no existing vhost 
uAPI that could properly serve as the vehicle for that. SET_OWNER / 
SET_MEM_TABLE / RESET_OWNER seems a remote fit.. Any objection against 
introducing a new but clean vhost uAPI for pinning guest pages, subject 
to guest's life cycle?

Another concern is the use_va stuff, originally it tags to the device 
level and is made static at the time of device instantiation, which is 
fine. But others to come just find a new home at per-group level or 
per-vq level struct. Hard to tell whether or not pinning is actually 
needed for the latter use_va friends, as they are essentially tied to 
the virtio life cycle or feature negotiation. While guest / Qemu starts 
way earlier than that. Perhaps just ignore those sub-device level use_va 
usages? Presumably !use_va at the device level is sufficient to infer 
the need of pinning for device?

Regards,
-Siwei


>
> This has two main problems:
> * At this moment the reset semantics forces the vdpa device to unmap
> all the memory. So this change needs a vhost vdpa feature flag.
> * This may increase the initialization time. Maybe we can delay it if
> qemu is not the destination of a LM. Anyway I think this should be
> done as an optimization on top.
>
> Any ideas or comments in this regard?
>
> Thanks!
>

