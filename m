Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3A57A5AE7
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 09:29:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiVAP-0004XP-O8; Tue, 19 Sep 2023 03:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qiVAM-0004Ww-VN; Tue, 19 Sep 2023 03:29:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qiVAK-0004ob-V5; Tue, 19 Sep 2023 03:29:02 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38J6gMGX020219; Tue, 19 Sep 2023 07:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=SnB4gnDjTRb9Z/MRXzN3Bt/s3mWoxhQqRUgwJ1+hT2Q=;
 b=HXrg0uV8v/NWBjURuKUSGnZN67C7K8DVjZjkolpvy3ou7qe//4KV8ojWSPMgD+ZPCyhO
 VznndsDnjqcu0LdY0eMLux3U0zez+ZLtMZVnpCzoXf4o4pQfkLLkWyW9iC3dk5BYTRGQ
 EOJRbzwo7fiRNj2b8/RK7AlStRRmRLTeOqIO0s3SnVC1noo0Egb8KHWGoSxvVpXdGt+O
 9nAIpHlLxrB16uHhcqEHdpmPfo7jZTwkXGsacamNre72kQPCRZy7YHHjgXEqw6aSc5cx
 pNuVqJnQDydFUax+mtW3Aa7YXmC9AjlnAm+hnfe0DoFpf/QEi8XNrAIPX//JsVB0Saw3 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t76kws3uc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 07:28:47 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38J79Vre003630;
 Tue, 19 Sep 2023 07:28:47 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t76kws3u6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 07:28:47 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38J5Vclp016436; Tue, 19 Sep 2023 07:28:46 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5sd1sdxu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 07:28:46 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38J7SjLw3080832
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Sep 2023 07:28:45 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C0DB58059;
 Tue, 19 Sep 2023 07:28:45 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A34D158043;
 Tue, 19 Sep 2023 07:28:42 +0000 (GMT)
Received: from [9.109.242.129] (unknown [9.109.242.129])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 19 Sep 2023 07:28:42 +0000 (GMT)
Message-ID: <56a18122-ed29-ddc5-03f7-6e539a9f46f2@linux.ibm.com>
Date: Tue, 19 Sep 2023 12:58:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/8] spapr: Clean up local variable shadowing in
 spapr_dt_cpus()
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>
References: <20230918145850.241074-1-clg@kaod.org>
 <20230918145850.241074-4-clg@kaod.org>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20230918145850.241074-4-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1eZJFaQEiENxRH1JFKZ454joAY9yi3vD
X-Proofpoint-ORIG-GUID: vaJij-elbWp7sB5GWnJJH-oBGg2QvBcD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_01,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 spamscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=934 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190059
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
> Introduce a helper routine defining one CPU device node to fix this
> warning :
> 
>    ../hw/ppc/spapr.c: In function ‘spapr_dt_cpus’:
>    ../hw/ppc/spapr.c:812:19: warning: declaration of ‘cs’ shadows a previous local [-Wshadow=compatible-local]
>      812 |         CPUState *cs = rev[i];
>          |                   ^~
>    ../hw/ppc/spapr.c:786:15: note: shadowed declaration is here
>      786 |     CPUState *cs;
>          |               ^~
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/ppc/spapr.c | 36 +++++++++++++++++++++---------------
>   1 file changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index de3c616b4637..d89f0fd496b6 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -780,6 +780,26 @@ static void spapr_dt_cpu(CPUState *cs, void *fdt, int offset,
>                                 pcc->lrg_decr_bits)));
>   }
>   
> +static void spapr_dt_one_cpu(void *fdt, SpaprMachineState *spapr, CPUState *cs,
> +                             int cpus_offset)
> +{
> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
> +    int index = spapr_get_vcpu_id(cpu);
> +    DeviceClass *dc = DEVICE_GET_CLASS(cs);
> +    g_autofree char *nodename = NULL;
> +    int offset;
> +
> +    if (!spapr_is_thread0_in_vcore(spapr, cpu)) {
> +        return;
> +    }
> +
> +    nodename = g_strdup_printf("%s@%x", dc->fw_name, index);
> +    offset = fdt_add_subnode(fdt, cpus_offset, nodename);
> +    _FDT(offset);
> +    spapr_dt_cpu(cs, fdt, offset, spapr);
> +}
> +
> +
>   static void spapr_dt_cpus(void *fdt, SpaprMachineState *spapr)
>   {
>       CPUState **rev;
> @@ -809,21 +829,7 @@ static void spapr_dt_cpus(void *fdt, SpaprMachineState *spapr)
>       }
>   
>       for (i = n_cpus - 1; i >= 0; i--) {
> -        CPUState *cs = rev[i];
> -        PowerPCCPU *cpu = POWERPC_CPU(cs);
> -        int index = spapr_get_vcpu_id(cpu);
> -        DeviceClass *dc = DEVICE_GET_CLASS(cs);
> -        g_autofree char *nodename = NULL;
> -        int offset;
> -
> -        if (!spapr_is_thread0_in_vcore(spapr, cpu)) {
> -            continue;
> -        }
> -
> -        nodename = g_strdup_printf("%s@%x", dc->fw_name, index);
> -        offset = fdt_add_subnode(fdt, cpus_offset, nodename);
> -        _FDT(offset);
> -        spapr_dt_cpu(cs, fdt, offset, spapr);
> +        spapr_dt_one_cpu(fdt, spapr, rev[i], cpus_offset);

Do we want to replace the call to spapr_dt_cpu in
spapr_core_dt_populate() with the _one_ as well?
Not sure about the implication of additional instructions there.

Also, could this code insider wrapper become part of spapr_dt_cpu() itself?
If can't, do we want a better renaming of wrapper here?

Otherwise,
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

>       }
>   
>       g_free(rev);

