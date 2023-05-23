Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C3770E292
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 19:05:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1VQR-0006hS-K3; Tue, 23 May 2023 13:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1q1VQO-0006SF-0c
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:03:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1q1VQL-0000Wf-VV
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:03:51 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34NGrKBa009654; Tue, 23 May 2023 17:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=GCb59Gv2D6NDGx4w0OeoBDNgEig7go3RwqXgqz0ePHY=;
 b=UwzknIah+gKDh98WRFjfwG8IerSTGP08xABx5BeXqqa7WxIhi3Ck7gvNFGQRu3mHeG3t
 D56KIJJSMfYDP/4budfQDX57Ha9E4ih7uvDcIzUhAAphHmw4LEuxRySCBClFs5LrdAwq
 LDg8hhkqsAsrt3nJCtJyVtJJJAT1aTvLSN9GWROA63ofZnQewEOGQF5uuvN5hNxU0Wvh
 u5apouiG/ep8MCl2Zefulz8maTOX+WqMMpXo7sPQktWWRxR7SYotUusKMguF+7fIrD0n
 cY4qU/ZwTEKHhHbiOLuC4UzkdgtrIqfuhJ8+KnTdSalYnyPZe+UZYPe7s2sX8GWJfrfy iw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qs1d806rt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 May 2023 17:03:45 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34NGrUQf010420;
 Tue, 23 May 2023 17:03:45 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qs1d805d1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 May 2023 17:03:42 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34NEZ4Zw031266;
 Tue, 23 May 2023 17:00:56 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
 by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3qppdpm24h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 May 2023 17:00:56 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34NH0thm26214940
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 May 2023 17:00:55 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5493B58056;
 Tue, 23 May 2023 17:00:55 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7939A58045;
 Tue, 23 May 2023 17:00:54 +0000 (GMT)
Received: from [9.61.92.8] (unknown [9.61.92.8])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 May 2023 17:00:54 +0000 (GMT)
Message-ID: <d3e51ee1-b943-07ef-35fa-8cac13705f59@linux.ibm.com>
Date: Tue, 23 May 2023 13:00:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] vfio/pci: Fix a use-after-free issue
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: minwoo.im@samsung.com, alex.williamson@redhat.com, clg@redhat.com,
 chao.p.peng@intel.com
References: <20230517024651.82248-1-zhenzhong.duan@intel.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20230517024651.82248-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eejVBO6s24-MOgSjqBYTmv6SousvfBDs
X-Proofpoint-GUID: YNcGEWu8Cp7yQswbTgYk1ISdZEs9Js2h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_10,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230136
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089, SPF_HELO_NONE=0.001,
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

On 5/16/23 10:46 PM, Zhenzhong Duan wrote:
> vbasedev->name is freed wrongly which leads to garbage VFIO trace log.
> Fix it by allocating a dup of vbasedev->name and then free the dup.
> 
> Fixes: 2dca1b37a7 ("vfio/pci: add support for VF token")
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

Also verified that this resolves an issue seen on s390, as we were seeing not just garbage logs but QEMU crashes in certain cases e.g. during device unplug.  Thanks!

> ---
> v2: "toke" -> "token", Cedric
>     Update with Alex suggested change
> 
>  hw/vfio/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index bf27a3990564..73874a94de12 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2994,7 +2994,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          qemu_uuid_unparse(&vdev->vf_token, uuid);
>          name = g_strdup_printf("%s vf_token=%s", vbasedev->name, uuid);
>      } else {
> -        name = vbasedev->name;
> +        name = g_strdup(vbasedev->name);
>      }
>  
>      ret = vfio_get_device(group, name, vbasedev, errp);


