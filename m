Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F297A5C6B
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 10:24:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiW1F-0004Bx-8H; Tue, 19 Sep 2023 04:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qiW19-0004BA-LS; Tue, 19 Sep 2023 04:23:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qiW17-0001NZ-NB; Tue, 19 Sep 2023 04:23:35 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38J88mnu021105; Tue, 19 Sep 2023 08:23:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=PNXPSkPbaCfwm8dByflCu5sky/b4W/hvE8H09K37Awg=;
 b=sGVGicKPRWZtF5IxEPaY3YNubCabSqZWCSR5mOkvU+QDEYJrO4fq7rPPOV3dLYxIKMpg
 +zNy9AarDj4jqXsCTkjYkDko29MockmHHfC/JmAjbbOwe6zDl1fDIRFpChAdUA2AeLRf
 9Bmse8u+kc/5yL3ZIcJEOXH5n3YkBUnethBbiC8CsaxMDRM7dz5l5WdB6xwpgP5WyPue
 EoCM0UCcK1jl6sgAcpFRxTZBxkmR4tPxzLrzEXA+UeNzUr/Cft/YzEZIUiCtSIQOXIxK
 CnnJglsUfuMbPZyVJaNq5wIg2GAC0Lxro/gd7x6th/slA2RmQaPLIoV3MiWQO8lRE4dO Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t6tywr1rw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 08:23:18 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38J8K6ed031757;
 Tue, 19 Sep 2023 08:23:18 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t6tywr1rg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 08:23:18 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38J6NJv2011722; Tue, 19 Sep 2023 08:23:16 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t5qpnad18-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 08:23:16 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38J8NG1t63963484
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Sep 2023 08:23:16 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0502858043;
 Tue, 19 Sep 2023 08:23:16 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8877D5805D;
 Tue, 19 Sep 2023 08:23:13 +0000 (GMT)
Received: from [9.109.242.129] (unknown [9.109.242.129])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 19 Sep 2023 08:23:13 +0000 (GMT)
Message-ID: <16ec9b62-9c83-68db-344b-050c9299bec1@linux.ibm.com>
Date: Tue, 19 Sep 2023 13:53:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 5/8] spapr: Clean up local variable shadowing in
 spapr_get_fw_dev_path()
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>
References: <20230918145850.241074-1-clg@kaod.org>
 <20230918145850.241074-6-clg@kaod.org>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20230918145850.241074-6-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AiAZCw8WLwwq97jAdAokxNCAqS_-BI6M
X-Proofpoint-ORIG-GUID: TnKCUL6hb89ezhTJtMrMuhuol5bH3zuu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_02,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=644 mlxscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190067
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 9/18/23 20:28, Cédric Le Goater wrote:
> Rename PCIDevice variable to avoid this warning :
> 
>    ../hw/ppc/spapr.c: In function ‘spapr_get_fw_dev_path’:
>    ../hw/ppc/spapr.c:3217:20: warning: declaration of ‘pcidev’ shadows a previous local [-Wshadow=compatible-local]
>     3217 |         PCIDevice *pcidev = CAST(PCIDevice, dev, TYPE_PCI_DEVICE);
>          |                    ^~~~~~
>    ../hw/ppc/spapr.c:3147:16: note: shadowed declaration is here
>     3147 |     PCIDevice *pcidev = CAST(PCIDevice, dev, TYPE_PCI_DEVICE);
>          |                ^~~~~~
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/ppc/spapr.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 41ce7de77c14..8090fb0302df 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3214,8 +3214,8 @@ static char *spapr_get_fw_dev_path(FWPathProvider *p, BusState *bus,
>   
>       if (g_str_equal("pci-bridge", qdev_fw_name(dev))) {
>           /* SLOF uses "pci" instead of "pci-bridge" for PCI bridges */
> -        PCIDevice *pcidev = CAST(PCIDevice, dev, TYPE_PCI_DEVICE);
> -        return g_strdup_printf("pci@%x", PCI_SLOT(pcidev->devfn));
> +        PCIDevice *pdev = CAST(PCIDevice, dev, TYPE_PCI_DEVICE);
> +        return g_strdup_printf("pci@%x", PCI_SLOT(pdev->devfn));

Instead of renaming, can't we use pcidev itself without re-declaring ?

>       }
>   
>       if (pcidev) {

