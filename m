Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B647E7DC31E
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 00:26:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxbdR-0001yu-OV; Mon, 30 Oct 2023 19:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qxbdQ-0001yd-45
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 19:25:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qxbdO-0004l5-KG
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 19:25:27 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39UN3beX003788; Mon, 30 Oct 2023 23:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=h49iDw5NqyfrS/v+bm4hqZbuDEkAsS36ycjAApHRxQ0=;
 b=G4R2C1MC0AN3lzLoHcF0sks+B4IRVMr+O9IR+AxRZmj1PJyVHQFDXkloHhpKSWskto4m
 rujdCx0d3JMUY+L7LdmiBG03/EIm268stHa7mxrwLYN/bPkeqW1xJt0Xzs8R9uOiIvO+
 mMHhhUVI8wVSCag3RAaZ0guYQ2ILyPnnLeyEgw1TCjtU+gqBv3wMohUIGy1PEKWvn9uV
 /9WHZDID6+pjRq5Ig+TPkqLUfNg6d48p1JAgNdOm6SpykceEF6yjNyWV76i6lFEmGUSY
 lExDWxfR2wrqYQlIBl7YBQE6V0SrDl1mkkckLfQGwyKGJcYuLiLAHFM4QpXOrwgW7YVn 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2nj68pm1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Oct 2023 23:25:19 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39UNOeT3029761;
 Mon, 30 Oct 2023 23:25:18 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2nj68pkr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Oct 2023 23:25:18 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39UMxmfV011608; Mon, 30 Oct 2023 23:25:18 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u1e4kmaqd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Oct 2023 23:25:18 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39UNPHlJ13894364
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Oct 2023 23:25:17 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B183B58054;
 Mon, 30 Oct 2023 23:25:17 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D9F85805A;
 Mon, 30 Oct 2023 23:25:17 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 30 Oct 2023 23:25:17 +0000 (GMT)
Message-ID: <deb8583c-4506-4fa2-8621-c079c6684f57@linux.ibm.com>
Date: Mon, 30 Oct 2023 19:25:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/14] hw/loongarch/virt: connect TPM to platform bus
Content-Language: en-US
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>
References: <20231029060404.71196-1-j@getutm.app>
 <20231029060404.71196-9-j@getutm.app>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231029060404.71196-9-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MI_dVKLAbBLTWcX7FqWOr_w93BE4wjF3
X-Proofpoint-ORIG-GUID: q-aoiM5o4Vu_oolj0e85qpPrl3H8cM5P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300183
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 10/29/23 02:03, Joelle van Dyne wrote:
> Signed-off-by: Joelle van Dyne <j@getutm.app>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>   hw/loongarch/virt.c  | 7 +++++++
>   hw/loongarch/Kconfig | 1 +
>   2 files changed, 8 insertions(+)
>
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 4b7dc67a2d..feed0f8bbf 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -1004,6 +1004,13 @@ static void loongarch_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>       } else if (memhp_type_supported(dev)) {
>           virt_mem_plug(hotplug_dev, dev, errp);
>       }
> +
> +#ifdef CONFIG_TPM
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_TPM_IF)) {
> +        tpm_sysbus_plug(TPM_IF(dev), OBJECT(lams->platform_bus_dev),
> +                        VIRT_PLATFORM_BUS_BASEADDRESS);
> +    }
> +#endif
>   }
>
>   static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
> diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
> index 5727efed6d..25da190ffc 100644
> --- a/hw/loongarch/Kconfig
> +++ b/hw/loongarch/Kconfig
> @@ -5,6 +5,7 @@ config LOONGARCH_VIRT
>       imply VIRTIO_VGA
>       imply PCI_DEVICES
>       imply NVDIMM
> +    imply TPM_TIS_SYSBUS
>       select SERIAL
>       select VIRTIO_PCI
>       select PLATFORM_BUS

