Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E0B82B1CE
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 16:28:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNwxa-00083y-7v; Thu, 11 Jan 2024 10:27:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rNwxW-00083V-AK
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:27:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rNwxS-0008MY-Qk
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:27:05 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40BENMEa004237
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 15:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=VNwSk41f7IXajPaHiM2ywzOc9GBWBz33rVT4YQGM70U=;
 b=szwUJcpmsdZaKBemkI4f3EeegVcsYp/CVBbWPg7b5pKDu5yXqQzqpvVKHmPAHDv2LSz8
 z/zGmVxvevX+ZnAiM37Iy7nhKTAJoQzwTVUF3c7u8JHpquhiC1ID8u8sesBpsCnj72Pr
 spjuQZLZhrfQTp07k1+SdIpOfIBldAdSYwcZh6n7uPS63jc8LjMOAxQ7FvWOg4zkc4Fa
 S2vrbC21U5+ZrFvUQN3dVEOx3vTs7nBRrJzY+qGITyZk7i+FOQO5HuXYRpE0cF0W8tAd
 7Lb8c5RHx8wyBLPpeIpIdeO62MwKld3PJFHPYHGWA5VPuX2By8EhDksBTbmWYp1iQMoE pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjj21swty-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 15:27:01 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40BFPutQ032342
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 15:27:00 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjj21swts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jan 2024 15:27:00 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40BEqrDR022845; Thu, 11 Jan 2024 15:27:00 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfhjyvcvw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jan 2024 15:27:00 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40BFQxjM8782426
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jan 2024 15:26:59 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E79765805D;
 Thu, 11 Jan 2024 15:26:58 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44CEC58059;
 Thu, 11 Jan 2024 15:26:58 +0000 (GMT)
Received: from [9.61.0.193] (unknown [9.61.0.193])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 11 Jan 2024 15:26:58 +0000 (GMT)
Message-ID: <7f5be600-b4e8-4ceb-a3e2-c5a470ba54d8@linux.ibm.com>
Date: Thu, 11 Jan 2024 10:26:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/7] s390x: do a subsystem reset before the unprotect on
 reboot
Content-Language: en-US
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Michael Mueller <mimu@linux.ibm.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
References: <20230912114112.296428-1-thuth@redhat.com>
 <20230912114112.296428-3-thuth@redhat.com>
 <6aec238b-b983-4b24-9bd9-a90f840d060c@redhat.com>
 <287dbe42-5a10-4667-b3fa-111270242b1d@linux.ibm.com>
 <e22ebb27-26d0-4e1d-86ab-ab9feb44d645@redhat.com>
 <16605225-77ca-4086-9446-329805a1bf90@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <16605225-77ca-4086-9446-329805a1bf90@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nfd0TDcV2Gc1v-GkGnxotRkDEunXtKLg
X-Proofpoint-GUID: ob77HqSPDlcz6X-iJZ9tejH15-PCXTWc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_07,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=581
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401110120
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 1/11/24 5:18 AM, Christian Borntraeger wrote:
> 
> 
> Am 11.01.24 um 10:43 schrieb Cédric Le Goater:
> [...]
>>
>>
>> On a side note, I am also seeing :
> 
> Michael?
> 

Hmm, it looks like this warning is tripping because we have a path in PCI passthrough where we don't unregister the gisc.  This warning notices that at the time we destroy the VM (it believes that are still consumers of the guest ISC so the bit in the alert mask is still on) -- after cutting the warning the code forces the alerts off at least.

Not sure yet if that is directly related to the device going into error condition or if it is an independent issue, will have a look.

>>
>> [   73.989688] ------------[ cut here ]------------
>> [   73.989696] unexpected non zero alert.mask 0x20
>> [   73.989748] WARNING: CPU: 9 PID: 4503 at arch/s390/kvm/interrupt.c:3214 kvm_s390_gisa_destroy+0xd4/0xe8 [kvm]
>> [   73.989791] Modules linked in: vfio_pci vfio_pci_core irqbypass vhost_net vhost vhost_iotlb tap tun xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 nft_compat nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink 8021q garp mrp rfkill sunrpc ext4 mbcache jbd2 vfio_ap zcrypt_cex4 vfio_ccw mdev vfio_iommu_type1 vfio drm fuse i2c_core drm_panel_orientation_quirks xfs libcrc32c dm_service_time mlx5_core sd_mod t10_pi ghash_s390 sg prng des_s390 libdes sha3_512_s390 sha3_256_s390 mlxfw tls scm_block psample eadm_sch qeth_l2 bridge stp llc dasd_eckd_mod zfcp qeth dasd_mod scsi_transport_fc ccwgroup qdio dm_multipath dm_mirror dm_region_hash dm_log dm_mod pkey zcrypt kvm aes_s390
>> [   73.989825] CPU: 9 PID: 4503 Comm: worker Kdump: loaded Not tainted 6.7.0-clg-dirty #52
>> [   73.989827] Hardware name: IBM 3931 LA1 400 (LPAR)
>> [   73.989829] Krnl PSW : 0704c00180000000 000003ff7fcd2198 (kvm_s390_gisa_destroy+0xd8/0xe8 [kvm])
>> [   73.989845]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
>> [   73.989847] Krnl GPRS: c0000000fffeffff 0000000700000027 0000000000000023 00000007df4249c8
>> [   73.989849]            000003800649b858 000003800649b850 00000007fcb9db00 0000000000000000
>> [   73.989851]            000000008ebae8c8 0000000083a8c4f0 0000000000b69900 000000008ebac000
>> [   73.989853]            000003ff903aef68 000003800649bd98 000003ff7fcd2194 000003800649b9f8
>> [   73.989859] Krnl Code: 000003ff7fcd2188: c02000024f88    larl    %r2,000003ff7fd1c098
>>                            000003ff7fcd218e: c0e5fffea360    brasl    %r14,000003ff7fca684e
>>                           #000003ff7fcd2194: af000000        mc    0,0
>>                           >000003ff7fcd2198: e310b7680204    lg    %r1,10088(%r11)
>>                            000003ff7fcd219e: a7f4ffae        brc    15,000003ff7fcd20fa
>>                            000003ff7fcd21a2: 0707        bcr    0,%r7
>>                            000003ff7fcd21a4: 0707        bcr    0,%r7
>>                            000003ff7fcd21a6: 0707        bcr    0,%r7
>> [   73.989929] Call Trace:
>> [   73.989931]  [<000003ff7fcd2198>] kvm_s390_gisa_destroy+0xd8/0xe8 [kvm]
>> [   73.989946] ([<000003ff7fcd2194>] kvm_s390_gisa_destroy+0xd4/0xe8 [kvm])
>> [   73.989960]  [<000003ff7fcc1578>] kvm_arch_destroy_vm+0x50/0x118 [kvm]
>> [   73.989974]  [<000003ff7fcb00a2>] kvm_destroy_vm+0x15a/0x260 [kvm]
>> [   73.989985]  [<000003ff7fcb021e>] kvm_vm_release+0x36/0x48 [kvm]
>> [   73.989996]  [<00000007de4f830c>] __fput+0x94/0x2d0
>> [   73.990009]  [<00000007de20d838>] task_work_run+0x88/0xe8
>> [   73.990013]  [<00000007de1e75e0>] do_exit+0x2e0/0x4e0
>> [   73.990016]  [<00000007de1e79c0>] do_group_exit+0x40/0xb8
>> [   73.990017]  [<00000007de1f96e8>] send_sig_info+0x0/0xa8
>> [   73.990021]  [<00000007de194b26>] arch_do_signal_or_restart+0x56/0x318
>> [   73.990025]  [<00000007de28bf12>] exit_to_user_mode_prepare+0x10a/0x1a0
>> [   73.990028]  [<00000007deb607d2>] __do_syscall+0x152/0x1f8
>> [   73.990032]  [<00000007deb70ac8>] system_call+0x70/0x98
>> [   73.990036] Last Breaking-Event-Address:
>> [   73.990037]  [<00000007de1e0c58>] __warn_printk+0x78/0xe8
>>
>>


