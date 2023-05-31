Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 919EC7172C4
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 02:57:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4A8l-0001Gb-Rl; Tue, 30 May 2023 20:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1q4A8i-0001Ed-T8; Tue, 30 May 2023 20:56:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1q4A8h-0001Kt-1Z; Tue, 30 May 2023 20:56:36 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34V0bIYN019547; Wed, 31 May 2023 00:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Oeb2uc10RqtSXSSyNVhM3tXQveqlecDptXlgjZRzerA=;
 b=JGh4E2uy1jHYWU2H/C+XwWoS4bu8HPZYJjp63NIouuaCU5dE9SVoemxxAuuK3uW1ZlxQ
 INc/iOKwO+NmYvC+km8dKtrvNmALsakNVv7OrMQov30l60qd9EjzUb6XoaUp7+nVEfi+
 X3rg/Wj83KT1PZqXlIqOgfkNary+S5Eq4vK2kcpycXQXrP9Jsgo/vAlGM7TCI8+VyJqY
 Sjn7mPPLbwZhqS0W8WIZfn41g4qnq5eD9I3515OnQiVEyMTtKy3Vaa+NWxrNuPKjz5xK
 3ZVsG1Id7A4OJ556hFeDB7wFa99lKC9Ei6tkeMg4yNHiLcMafdzm7sg/90ozBMCQwuVA YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwn3x1csj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 May 2023 00:56:31 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34V0rEbY028768;
 Wed, 31 May 2023 00:56:31 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwn3x1csd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 May 2023 00:56:31 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34V09M2v019378;
 Wed, 31 May 2023 00:56:30 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
 by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3qu9g6js8y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 May 2023 00:56:30 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34V0uSJ633030596
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 May 2023 00:56:28 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D25E5805E;
 Wed, 31 May 2023 00:56:28 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E73C58051;
 Wed, 31 May 2023 00:56:27 +0000 (GMT)
Received: from [9.61.34.174] (unknown [9.61.34.174])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 31 May 2023 00:56:27 +0000 (GMT)
Message-ID: <06630472-57c8-89dd-ad80-75fb4d0d7de9@linux.ibm.com>
Date: Tue, 30 May 2023 20:56:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] linux-headers: Update with vfio_ap IRQ index mapping
To: Tony Krowiak <akrowiak@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 fiuczy@linux.ibm.com, thuth@redhat.com, farman@linux.ibm.com,
 borntraeger@linux.ibm.com
References: <20230530225544.280031-1-akrowiak@linux.ibm.com>
 <20230530225544.280031-2-akrowiak@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20230530225544.280031-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fxTr0t6WP2rQqz_um8B_k1yorcRNQ-3F
X-Proofpoint-GUID: eK0XxF0MWKygOPBxaI-DZkqt0weoyZCM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_18,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 spamscore=0 mlxscore=0 bulkscore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1011 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310001
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 5/30/23 6:55 PM, Tony Krowiak wrote:
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  linux-headers/linux/vfio.h | 9 +++++++++
>  1 file changed, 9 insertions(+)

Worth nothing here that linux-headers patches should be generated using scripts/update-linux-headers.sh.

Since this linux-headers update includes changes that aren't merged into the kernel yet, I would still use update-linux-headers.sh -- but also include in the commit message that this is a placeholder patch that includes unmerged uapi changes.  Then once the kernel changes merge you can just have a proper linux-headers update patch in a subsequent qemu series.

> 
> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index 4a534edbdcba..2658fda219e8 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h
> @@ -646,6 +646,15 @@ enum {
>  	VFIO_CCW_NUM_IRQS
>  };
>  
> +/*
> + * The vfio-ap bus driver makes use of the following IRQ index mapping.
> + * Unimplemented IRQ types return a count of zero.
> + */
> +enum {
> +	VFIO_AP_REQ_IRQ_INDEX,
> +	VFIO_AP_NUM_IRQS
> +};
> +
>  /**
>   * VFIO_DEVICE_GET_PCI_HOT_RESET_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 12,
>   *					      struct vfio_pci_hot_reset_info)


