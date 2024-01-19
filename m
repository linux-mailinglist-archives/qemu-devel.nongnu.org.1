Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60563832456
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 06:48:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQhis-0001Lg-OZ; Fri, 19 Jan 2024 00:47:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rQhig-0001LT-8J; Fri, 19 Jan 2024 00:47:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rQhie-0007UB-A2; Fri, 19 Jan 2024 00:47:09 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40J5T9Cm010838; Fri, 19 Jan 2024 05:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=unIuEq/pBRgD1zCJp0SyTibU/47vANTYUJ42rO3yyvY=;
 b=DjfDP81KgpF86zG7/9AYJ2kySV7DvvRahK/39dMq9PhwdBnS+7/Z9pqWZQhXS/cexBVG
 GxXsIv4JFiMsV1jet8aXNXV9ADtgLpvuNwu5YooeafBiMT5qvqK8DUvNCBE/hcsDnI4u
 Hzq4YVyv1nA5QvJQLF8DSKFuhnvQoaOzshHfx3IoQ3aoPmdcc8TYls2CNFlSG85CewFc
 XYWyATms9xjQ29U1Mg4Nb3FzDeDXKbO1lu9KrVEcuqCwHrsVS5eHMttDpggibr/ZGFZj
 fiSGQjpwOnXz5sI4u3UtfjS+lpB7afaACgvWlLnrcIjFHfIIDmqq5wZ1tI/3jQ0d/Q7C /g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vqjnh8pt7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jan 2024 05:46:59 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40J5OdRI030311;
 Fri, 19 Jan 2024 05:46:58 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vqjnh8psk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jan 2024 05:46:58 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40J2xqNr005785; Fri, 19 Jan 2024 05:46:56 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm6bkyqd1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jan 2024 05:46:56 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40J5ktDn19202596
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jan 2024 05:46:56 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A91B058059;
 Fri, 19 Jan 2024 05:46:55 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E80E58058;
 Fri, 19 Jan 2024 05:46:53 +0000 (GMT)
Received: from [9.171.37.90] (unknown [9.171.37.90])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 19 Jan 2024 05:46:52 +0000 (GMT)
Message-ID: <2c2dd750-b4b9-4c83-ba5b-f7e81cd2b179@linux.ibm.com>
Date: Fri, 19 Jan 2024 11:16:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ppc/spapr: change pseries machine default to POWER10
 CPU
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org
References: <20240118141418.165107-1-npiggin@gmail.com>
 <20240118141418.165107-2-npiggin@gmail.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240118141418.165107-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2Adr6jo_XkI1cyZhdYkcyJ4kZlCiS5j-
X-Proofpoint-GUID: 07_bLHWxulfDG86k5xyGkd8FaFcyulGW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_02,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401190012
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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



On 1/18/24 19:44, Nicholas Piggin wrote:
> POWER10 is the latest pseries CPU.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   hw/ppc/spapr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e8dabc8614..021b1a00e1 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4675,7 +4675,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>   
>       smc->dr_lmb_enabled = true;
>       smc->update_dt_enabled = true;
> -    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.2");
> +    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
>       mc->has_hotpluggable_cpus = true;
>       mc->nvdimm_supported = true;
>       smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;

