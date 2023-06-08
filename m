Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04483728B2D
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:41:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OI7-0000cy-Sw; Thu, 08 Jun 2023 18:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1q7OI5-0000cN-AM
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:39:37 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1q7OI3-00026u-77
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:39:37 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 358Io9SH030578; Thu, 8 Jun 2023 22:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=KH3tFbLQpo0kIYLIpmQfRuwx0O9+onEoWaeub7TWDgE=;
 b=md8mlOH3hviLWJQQgzK1XHgTmKpemp73ZhEshRldUHel+8BYd1P2XNjJn3QdNwI6xsbe
 WNRtO4CiQIeGNLBPVl/aFtrgRfteOsYCWb7UOC6NcDAMvXNe4HV+sjJIL5FtqO1KBNjb
 GyOZKkbTeIKSiuQ5bazoDfXAsCZCDKBxzTBdJdYNaqAsEVPSISGNdQy/6BmEmwQuW9j4
 mHSI4c7UMpqBAye9j/UGnCBvRR+4N+PiVrKxxeNHe4v/U8ENrEzXyus5LmCQmVeBI065
 CL78SohoMsysW/HqXhsUPUjMtGJ3/hsREvqg1buJ/TfQKZHLEcwSypwyjUk2WRh25Qfr 5A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6rnau0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 08 Jun 2023 22:39:24 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 358Kxuem003133; Thu, 8 Jun 2023 22:39:23 GMT
Received: from [10.132.95.70] (dhcp-10-132-95-70.usdhcp.oraclecorp.com
 [10.132.95.70])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3r2a6n81xb-1; Thu, 08 Jun 2023 22:39:23 +0000
Message-ID: <bff286b8-0103-1698-c77d-736417396405@oracle.com>
Date: Thu, 8 Jun 2023 15:40:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Reducing vdpa migration downtime because of memory pin / maps
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-level <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 Michael Tsirkin <mst@redhat.com>, Longpeng <longpeng2@huawei.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eli Cohen <elic@nvidia.com>, Parav Pandit <parav@nvidia.com>,
 Juan Quintela <quintela@redhat.com>, David Gilbert <dgilbert@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <CAJaqyWdV6pKP0SVZciMiu_HN86aJriZh0HBiwHNkO7+yErXnBA@mail.gmail.com>
 <c59d2d67-d31a-b6e6-54c5-5b81c18d9547@oracle.com>
 <CAJaqyWegsVHEVZt2_mf4wA8MuF7UXmU=UbHJfwyzURDRxfRgmg@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
In-Reply-To: <CAJaqyWegsVHEVZt2_mf4wA8MuF7UXmU=UbHJfwyzURDRxfRgmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_16,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080195
X-Proofpoint-ORIG-GUID: cDr0ivWeqkf-hr0bSPPakVoOWR5nkGf6
X-Proofpoint-GUID: cDr0ivWeqkf-hr0bSPPakVoOWR5nkGf6
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
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


On 6/7/23 01:08, Eugenio Perez Martin wrote:
> On Wed, Jun 7, 2023 at 12:43 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>> Sorry for reviving this old thread, I lost the best timing to follow up
>> on this while I was on vacation. I have been working on this and found
>> out some discrepancy, please see below.
>>
>> On 4/5/23 04:37, Eugenio Perez Martin wrote:
>>> Hi!
>>>
>>> As mentioned in the last upstream virtio-networking meeting, one of
>>> the factors that adds more downtime to migration is the handling of
>>> the guest memory (pin, map, etc). At this moment this handling is
>>> bound to the virtio life cycle (DRIVER_OK, RESET). In that sense, the
>>> destination device waits until all the guest memory / state is
>>> migrated to start pinning all the memory.
>>>
>>> The proposal is to bind it to the char device life cycle (open vs
>>> close),
>> Hmmm, really? If it's the life cycle for char device, the next guest /
>> qemu launch on the same vhost-vdpa device node won't make it work.
>>
> Maybe my sentence was not accurate, but I think we're on the same page here.
>
> Two qemu instances opening the same char device at the same time are
> not allowed, and vhost_vdpa_release clean all the maps. So the next
> qemu that opens the char device should see a clean device anyway.

I mean the pin can't be done at the time of char device open, where the 
user address space is not known/bound yet. The earliest point possible 
for pinning would be until the vhost_attach_mm() call from SET_OWNER is 
done. Actually I think the counterpart vhost_detach_mm() only gets 
handled in vhost_vdpa_release() at device close time is a resulting 
artifact and amiss of today's vhost protocol - the opposite RESET_OWNER 
call is not made mandatory hence only seen implemented in vhost-net 
device today. One qemu instance could well exec(3) another new qemu 
instance to live upgrade itself while keeping all emulated devices and 
guest alive. The current vhost design simply prohibits this from happening.


>
>>>    so all the guest memory can be pinned for all the guest / qemu
>>> lifecycle.
>> I think to tie pinning to guest / qemu process life cycle makes more
>> sense. Essentially this pinning part needs to be decoupled from the
>> iotlb mapping abstraction layer, and can / should work as a standalone
>> uAPI. Such that QEMU at the destination may launch and pin all guest's
>> memory as needed without having to start the device, while awaiting any
>> incoming migration request. Though problem is, there's no existing vhost
>> uAPI that could properly serve as the vehicle for that. SET_OWNER /
>> SET_MEM_TABLE / RESET_OWNER seems a remote fit.. Any objection against
>> introducing a new but clean vhost uAPI for pinning guest pages, subject
>> to guest's life cycle?
>>
> I think that to pin or not pin memory maps should be a kernel
> decision, not to be driven by qemu.

It's kernel decision for sure. I am with this part.

> I'm not against it if needed, but
> let me know if the current "clean at close" address your concerns.

To better facilitate QEMU exec (live update) case, I propose we add new 
vhost uAPI pair for explicit pinning request - which would live with 
user mm's, or more precisely qemu instance's lifecycle.

>
>> Another concern is the use_va stuff, originally it tags to the device
>> level and is made static at the time of device instantiation, which is
>> fine. But others to come just find a new home at per-group level or
>> per-vq level struct. Hard to tell whether or not pinning is actually
>> needed for the latter use_va friends, as they are essentially tied to
>> the virtio life cycle or feature negotiation. While guest / Qemu starts
>> way earlier than that. Perhaps just ignore those sub-device level use_va
>> usages? Presumably !use_va at the device level is sufficient to infer
>> the need of pinning for device?
>>
> I don't follow this. But I have the feeling that the subject of my
> original mail is way more accurate if I would have said just "memory
> maps".

I think the iotlb layer in vhost-vdpa just provides the abstraction for 
mapping, not pinning. Although in some case mapping implicitly relies on 
pinning for DMA purpose, it doesn't have to tie to that in uAPI 
semantics. We can do explicit on-demand pinning for cases for e.g. 
warming up device at live migration destination.


>
> I still consider the way to fix it is to actually delegate that to the
> kernel vdpa, so it can choose if a particular ASID needs the pin or
> not. But let me know if I missed something.

You can disregard this for now. I will discuss that further with you 
guys while bind_mm and per-group use_va stuffs are landed.

Thanks!
-Siwei



>
> Thanks!
>
>> Regards,
>> -Siwei
>>
>>
>>> This has two main problems:
>>> * At this moment the reset semantics forces the vdpa device to unmap
>>> all the memory. So this change needs a vhost vdpa feature flag.
>>> * This may increase the initialization time. Maybe we can delay it if
>>> qemu is not the destination of a LM. Anyway I think this should be
>>> done as an optimization on top.
>>>
>>> Any ideas or comments in this regard?
>>>
>>> Thanks!
>>>

