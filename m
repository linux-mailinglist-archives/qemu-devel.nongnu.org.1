Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8375CA6A844
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Mar 2025 15:20:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvGji-000301-I1; Thu, 20 Mar 2025 10:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tvGje-0002zF-Mc
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 10:19:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tvGjc-0007el-Il
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 10:19:02 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KCT1iD000712;
 Thu, 20 Mar 2025 14:18:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=sl6kH0
 SSfBAjy4CT8Ll1+kk9x/d6VScYonQDymdO4No=; b=j3BXy24g0DnPW5LvCxkEV4
 PFEC+UFQ3ri2dTRJQ6RzYl0sJt4ij4PWMYUJRbuUYXzrITPnuGyvFZ45Y10F+aCE
 kmUWIDbTpJ3ZW0dMzmHJYqPugLvfXDhxQxoC5lzlyVHxPBV15SX2GTeskCZX4H0H
 X2w5DRBhqhEqM6Xvxnd2BwaGLiGjM5rIOEqtC53EDb8JXYd9LzaWQ2LtF5QFXV+0
 Msh70KP4tx3Jrd94O5nhVXoBtj9fM61KBSlRnQubnNjAjBQEh3XZawKr+MbIDsRq
 jJTTc9IUF68XeRydsnbtRMq+z+L6Fy/27NUSBnPhh9TJ4CPQn1Riw6Hy3A+tFxcw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45gk21rk1a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Mar 2025 14:18:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52KDombn005631;
 Thu, 20 Mar 2025 14:18:56 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dm908gvh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Mar 2025 14:18:56 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52KEIuec30278380
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Mar 2025 14:18:56 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28F9558055;
 Thu, 20 Mar 2025 14:18:56 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF8E358043;
 Thu, 20 Mar 2025 14:18:55 +0000 (GMT)
Received: from [9.41.104.243] (unknown [9.41.104.243])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Mar 2025 14:18:55 +0000 (GMT)
Message-ID: <2aa3381f-cf89-4634-aac8-3ed5491f0ee8@linux.ibm.com>
Date: Thu, 20 Mar 2025 09:18:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: VDPA MAC address problem
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, dtatulea@nvidia.com, Cindy Lu <lulu@redhat.com>,
 eperezma <eperezma@redhat.com>
References: <553b11b5-4cc4-4e59-9211-74c8cce51a96@linux.ibm.com>
 <CACGkMEvrOx=jN9iULQ_svJdqKt3guJuZNEOan9-eeLirLk7_=g@mail.gmail.com>
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <CACGkMEvrOx=jN9iULQ_svJdqKt3guJuZNEOan9-eeLirLk7_=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VA3i5A_TEUl2Wub35Y8Ibo1Y4SaYer41
X-Proofpoint-GUID: VA3i5A_TEUl2Wub35Y8Ibo1Y4SaYer41
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015
 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200087
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 3/19/2025 19:58, Jason Wang wrote:
> Adding Cindy and Eugenio
> 
> On Thu, Mar 20, 2025 at 12:34 AM Konstantin Shkolnyy <kshk@linux.ibm.com> wrote:
>>
>> I’m observing a problem while testing VDPA with Nvidia ConnectX-6 (mlx5)
>> on s390.
>>
>> Upon start, virtio_net_device_realize() tries to set a new MAC address
>> by VHOST_VDPA_SET_CONFIG which doesn’t do anything.
>>
>> Later, the VM gets started and learns about the old address from
>> virtio_net_get_config() which returns whatever VHOST_VDPA_GET_CONFIG
>> returns, unless it's "6 zero bytes", in which case it instead returns
>> the desired new address (and the problem is avoided).
>>
>> Then QEMU again tries to set the new address from vhost_net_start(), now
>> by calling vhost_vdpa_net_load_cmd(...,VIRTIO_NET_CTRL_MAC,
>> VIRTIO_NET_CTRL_MAC_ADDR_SET, ...). This time the new address is
>> successfully programmed into the NIC, but the VM doesn't know about it.
> 
> Have you enabled shadow virtqueue? If yes, does it work if you don't do that?

I only run it in the default configuration, which has SVQ enabled.

>> As it is, the only VDPA scenario that's working for me is:
>> 1) Avoid specifying the MAC address in the "vdpa dev add" command (which
>> will create the "6 zero bytes" condition on the first launch).
>> 2) Keep using the same MAC address for every subsequent VM launch on the
>> same NIC "virtual function" (so that the old and new addresses are the
>> same).
> 
> This is the way we currently use it. Is there any limitation of this?

To be honest, I don't know how severe this limitation is, because I'm 
not a sysadmin. The problem is that I was searching www for info on how 
to setup VDPA and ended up hitting this bug and investigating it. 
Because the found info sources are variable and some show the address 
specified in "vdpa dev add".

