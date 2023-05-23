Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FEC70E277
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:51:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1VEF-00073l-3l; Tue, 23 May 2023 12:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1q1VE9-00072f-5X
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:51:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1q1VE7-0005aC-31
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:51:12 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34NGlK9k004979; Tue, 23 May 2023 16:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Z522nFOQD5Hbu7BppD2x/vr5epWAxcnPTulNUdsPLMA=;
 b=noe8rkEFhaT3DFAFq3GnTJUsWPlBdQgV+vq7R9z5m1HiR8rv0lLNUEOmuqUMCxt07X0Y
 06SDwGgVcBTksgpRRNCmHrYIRenHOLcpZQDp3cTDQRpdWowA/UzVCFKtppBcsH6NrWlz
 41G3PegtM3EdyfNSwQbY/096iMwxh82+3eo80SxErzT0hRsBo+nX3mknmhWSD+Vw/q2r
 qV7+ouyBZFTCymeu2TCUbeUchQwqgFaQA/Fq5Wluv/6ZKn/900OoYDjZsbsrJBAQgNZb
 7lLL1SEx2eCoQuDFqpyaCEn7BzRezI4smUI0EDRlBt1xTkeiT2guC3gbUcOmHWfxd3zK WQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qs0u18qs5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 May 2023 16:51:08 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34NGeIBp010649;
 Tue, 23 May 2023 16:51:07 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qs0u18qrw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 May 2023 16:51:07 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34NEj6UB014210;
 Tue, 23 May 2023 16:51:07 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
 by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3qppbsm15c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 May 2023 16:51:07 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34NGp5SC1245828
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 May 2023 16:51:05 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB21A58054;
 Tue, 23 May 2023 16:51:05 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 08A8258045;
 Tue, 23 May 2023 16:51:05 +0000 (GMT)
Received: from [9.61.92.8] (unknown [9.61.92.8])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 May 2023 16:51:04 +0000 (GMT)
Message-ID: <f7134011-27df-416d-699c-33d41f82c307@linux.ibm.com>
Date: Tue, 23 May 2023 12:51:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 1/3] vfio/pci: add support for VF token
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: Minwoo Im <minwoo.im@samsung.com>, Klaus Jensen <k.jensen@samsung.com>
References: <20230509215923.3186420-1-alex.williamson@redhat.com>
 <20230509215923.3186420-2-alex.williamson@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20230509215923.3186420-2-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: toMm20dir-rzZ2lZ0ftQW8PcmleyyXai
X-Proofpoint-ORIG-GUID: 3NKBUq4E6ZYoqpLc6x1owNKDZrUcpEdd
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_10,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 mlxlogscore=999
 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230132
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/9/23 5:59 PM, Alex Williamson wrote:
> From: Minwoo Im <minwoo.im@samsung.com>
> 
> VF token was introduced [1] to kernel vfio-pci along with SR-IOV
> support [2].  This patch adds support VF token among PF and VF(s). To
> passthu PCIe VF to a VM, kernel >= v5.7 needs this.
> 
> It can be configured with UUID like:
> 
>   -device vfio-pci,host=DDDD:BB:DD:F,vf-token=<uuid>,...
> 
> [1] https://lore.kernel.org/linux-pci/158396393244.5601.10297430724964025753.stgit@gimli.home/
> [2] https://lore.kernel.org/linux-pci/158396044753.5601.14804870681174789709.stgit@gimli.home/
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
> Link: https://lore.kernel.org/r/20230320073522epcms2p48f682ecdb73e0ae1a4850ad0712fd780@epcms2p4
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Hi Minwoo, Alex,

I'm seeing a regression in vfio-pci on s390 and bisect points to this commit.  I don't believe it's specific to s390 though, but rather when not using this new vf-token, see below...

> ---
>  hw/vfio/pci.c | 13 ++++++++++++-
>  hw/vfio/pci.h |  1 +
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index ec9a854361ac..cf27f28936cb 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2856,6 +2856,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>      int groupid;
>      int i, ret;
>      bool is_mdev;
> +    char uuid[UUID_FMT_LEN];
> +    char *name;
>  
>      if (!vbasedev->sysfsdev) {
>          if (!(~vdev->host.domain || ~vdev->host.bus ||
> @@ -2936,7 +2938,15 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          goto error;
>      }
>  
> -    ret = vfio_get_device(group, vbasedev->name, vbasedev, errp);
> +    if (!qemu_uuid_is_null(&vdev->vf_token)) {
> +        qemu_uuid_unparse(&vdev->vf_token, uuid);
> +        name = g_strdup_printf("%s vf_token=%s", vbasedev->name, uuid);
> +    } else {
> +        name = vbasedev->name;

^ here we copy the pointer when a vf-token was not specified.

> +    }
> +
> +    ret = vfio_get_device(group, name, vbasedev, errp);
> +    g_free(name);

^ and then free it regardless.  But I don't think we meant to free what vbasedev->name points to, this was meant to free a duplicate string.  I'm subsequently seeing qemu crashes later on e.g. during device unplug.

I think doing a strdup in either case would fix the issue OR skipping the g_free when qemu_uuid_is_null(&vdev->vf_token).

FWIW, I tried the following and it resolved the issue for me:

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index bf27a39905..73874a94de 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2994,7 +2994,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         qemu_uuid_unparse(&vdev->vf_token, uuid);
         name = g_strdup_printf("%s vf_token=%s", vbasedev->name, uuid);
     } else {
-        name = vbasedev->name;
+        name = g_strdup(vbasedev->name);
     }
 
     ret = vfio_get_device(group, name, vbasedev, errp);




