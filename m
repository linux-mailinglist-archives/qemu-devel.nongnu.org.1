Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8468EB04455
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Jul 2025 17:42:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubLJi-00030o-HT; Mon, 14 Jul 2025 11:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1ubJzK-0007oM-C5; Mon, 14 Jul 2025 10:17:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1ubJzH-0000D8-Dz; Mon, 14 Jul 2025 10:17:01 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E8KRlB014677;
 Mon, 14 Jul 2025 14:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/fnawL
 bQb+PXjZBgC2TuPEOK6bDpsfugctixtUEIsVE=; b=NvNGKG6udbIccXswUHJ/c5
 us8YH2t0e3iF//eY+xOsoVOhGExntMBaSFPD1hUZDiARZwNWOBaZ4lzq8H3iRnzm
 9u8NE4bgBki6z+SnIf09UMi4zx4Bs7hLHwcuJgJjA+vZmrDxM4yQKZHW1rcaGBfO
 kZY0dA7VAkfobtkAVPxKqSaSXBfdwDQ4exRYQRgixV4D05zVtgYuclSvv1nWuzSM
 JZcDyBr7wuTZehpB9vc2uNNIcyoG2H1DF29t1m7rlK47xTDaBNJXeELwmvN/f9Uy
 G+wmDvZj8z1ouqOCVzBP77bADpQOeqgdX1zmV77+3hSuE+jEwW68XwNB/Np5oGNQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4tsypq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Jul 2025 14:16:51 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56EEGp21013484;
 Mon, 14 Jul 2025 14:16:51 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4tsynt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Jul 2025 14:16:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56EAO9mc000890;
 Mon, 14 Jul 2025 14:16:39 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v48kwxyd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Jul 2025 14:16:39 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56EEGces10420910
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jul 2025 14:16:38 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E2135805B;
 Mon, 14 Jul 2025 14:16:38 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 038D558059;
 Mon, 14 Jul 2025 14:16:38 +0000 (GMT)
Received: from [9.61.243.238] (unknown [9.61.243.238])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Jul 2025 14:16:37 +0000 (GMT)
Message-ID: <e0d7a518-7736-4de1-814c-578f14e591f2@linux.ibm.com>
Date: Mon, 14 Jul 2025 09:16:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2] virtio-net: Fix VLAN filter table reset timing
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: yin31149@gmail.com, eperezma@redhat.com, mst@redhat.com,
 jasowang@redhat.com, virtualization@lists.linux.dev, qemu-stable@nongnu.org
References: <20250714-vlan-v2-1-2d589ba4dcd3@rsg.ci.i.u-tokyo.ac.jp>
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <20250714-vlan-v2-1-2d589ba4dcd3@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=baBrUPPB c=1 sm=1 tr=0 ts=68751153 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=zTvvzZXkgg2YcvmaeiIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: IcQvpBd0K6heh5JHYXw0CLJmsRLAFejt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA4NCBTYWx0ZWRfX6us/9Ep8psvq
 XmNb8LlKntk+i/WPSmaEnf0uHFPwofz4QUV19KsY5ppgTHiBfGYTkQbnQzHjJ9EEIOANhXOtwQh
 A4mJcxLQ8p0KPI2qgbWy4XTYI0USCTQSfO02im+hHNF3TRNXsNpsyWc1dOJXzAAlCNWu2QLeIzo
 BC9fhrHlvpiuCKHMTA+YMN3wssmDpYtFUXXD/uSD6bbh9tIS9upL8/1NSEa0fdXIUa4mxdoZXSq
 5vecXKRdJPrr4ZYw5R/0ZwEKASWYYgeVo4+UPIjrh4B0yymdcmslSBIs/sUcgDs/XaStiZGwEl/
 GMAbE6J/h8bqaWL9EuWUvhYLL0LrcUSP+ra+qV3aLGYGmfFUOE0lrHQZVfQUTTr6rP+SYu+6Pin
 qoR19TjgyH2F8dP5h4V74j6DSQu/gsO16mmnPx/AFDe7zpSIkatmWZEB1///M/BXyz3JvEt6
X-Proofpoint-ORIG-GUID: 2JsllPUEY_zbtj7GU-rpwZg30iJKfoYP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=857
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140084
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kshk@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 14-Jul-25 04:31, Akihiko Odaki wrote:
> Konstantin, I would also want you to test this new version. Please also
> give it Tested-by, and, if possible, Reviewed-by.

It works as expected during the boot. All bits in vlans[] remain set 
until virtio_pci_common_write(VIRTIO_PCI_GUEST_FEATURES) comes with 
VIRTIO_NET_F_CTRL_VLAN set, and clears vlans[]. Then I see 
virtio_net_set_status(0xb) and virtio_net_set_status(0xf).

I can't test migration because currently it's not supported on s390 for 
PCI devices.

Tested-by: Konstantin Shkolnyy <kshk@linux.ibm.com>


