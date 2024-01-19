Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D302833015
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 22:09:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQw5k-0002x5-3B; Fri, 19 Jan 2024 16:07:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1rQw5h-0002pS-Th; Fri, 19 Jan 2024 16:07:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1rQw5f-0006jh-NC; Fri, 19 Jan 2024 16:07:53 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40JK26iE012230; Fri, 19 Jan 2024 21:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=zpcLgHwOmSZdP54mgjuNpifae+z/iCv/TYkAJAMpR3U=;
 b=fgOcCBvaon7eUZxv+vv9j7FYQfq7uaYTgzAch+sGN06sV4qp1dm28lCKudX8P4sTaxmc
 CQfDLBoasxq7CNKwNg2occWergjoo0sxkheqAOt7sypVLGi+npCx4PaD69XmuT9smhnM
 JMB1S3v85y3fEUUpj5aOKbQ1lINyh2rVlhKKzAiy5j6aDwAgqtiOAVhvmElD4Z9S9Lm0
 kEgAr5K6pM9uDc+HyU2Zm6jsqXGJsfEe413XEwYFJTfQHBq1xRX0StlFvukCOzBM156E
 8P6m1XZwArHmYogJZbQP68eoMVTlU+6uFI2MykS+WTqJQdG8tcwRAIqyY+5YdNInVL0E Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vqyrt1hvs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jan 2024 21:07:46 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40JKJ61s029344;
 Fri, 19 Jan 2024 21:07:46 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vqyrt1hvc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jan 2024 21:07:46 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40JHmduK030441; Fri, 19 Jan 2024 21:07:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm72kkcsh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jan 2024 21:07:45 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40JL7g3D27525760
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jan 2024 21:07:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FACD2004B;
 Fri, 19 Jan 2024 21:07:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47A1C20040;
 Fri, 19 Jan 2024 21:07:41 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.179.31.192])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
 Fri, 19 Jan 2024 21:07:41 +0000 (GMT)
Date: Fri, 19 Jan 2024 22:07:39 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, farman@linux.ibm.com, thuth@redhat.com,
 clg@redhat.com, frankja@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org, Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 3/3] s390x/pci: drive ISM reset from subsystem reset
Message-ID: <20240119220739.0f5739b3.pasic@linux.ibm.com>
In-Reply-To: <20240118185151.265329-4-mjrosato@linux.ibm.com>
References: <20240118185151.265329-1-mjrosato@linux.ibm.com>
 <20240118185151.265329-4-mjrosato@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 52MgXaMiLHEyxCliT04c7s5M3vV7LAFa
X-Proofpoint-GUID: 1ckJqL22NwhRwSRu9BxSNBD-SklCSXwl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_12,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0 clxscore=1011
 bulkscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401190127
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Thu, 18 Jan 2024 13:51:51 -0500
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index eaf61d3640..c99682b07d 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -118,6 +118,14 @@ static void subsystem_reset(void)
>      DeviceState *dev;
>      int i;
>  
> +    /*
> +     * ISM firmware is sensitive to unexpected changes to the IOMMU, which can
> +     * occur during reset of the vfio-pci device (unmap of entire aperture).
> +     * Ensure any passthrough ISM devices are reset now, while CPUs are paused
> +     * but before vfio-pci cleanup occurs.
> +     */
> +    s390_pci_ism_reset();

Hm I'm not sure about special casing ISM in here. In my opinion the loop
below shall take care of all the reset.

For TYPE_AP_BRIDGE and TYPE_VIRTUAL_CSS_BRIDGE AFAIU a
device_cold_reset() on all objects of those types results in the resets
of objects that hang below these buses.

I guess this also happens for the S390PCIBusDevices, but not for the
actual PCI devices.

My understanding is that the entire PCI subsystem is to be reset when
a subsystem reset is performed.

I'm not familiar enough with our PCI emulation to know if a reset
to the TYPE_S390_PCI_HOST_BRIDGE is supposed to be sufficient to
accomplish that.

I have the feeling, I am missing something... Can you help me understand
this please?


> +
>      for (i = 0; i < ARRAY_SIZE(reset_dev_types); i++) {
>          dev = DEVICE(object_resolve_path_type("", reset_dev_types[i], NULL));
>          if (dev) 

