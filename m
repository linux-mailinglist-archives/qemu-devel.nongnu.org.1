Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCDC831242
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 06:04:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQKYn-0007Lr-GR; Thu, 18 Jan 2024 00:03:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rQKYh-0007LT-GX; Thu, 18 Jan 2024 00:03:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rQKYe-0004HC-Vf; Thu, 18 Jan 2024 00:03:18 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40I41jYF023593; Thu, 18 Jan 2024 05:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HbbNsiCUGDHaa7k9/4oRr5O6sBnlbjcm09ZTtIREsRo=;
 b=FFbeFzgD1uLt2KITBhr16RFjXWDtkfpsIqFAn0c9SPs8+unSluI9EA+JyravPv55ixaI
 JDRSNB+2Z7DaXNalvr4cDXIwjUMlJoxoOeHbwsUGX9EuVIdu3KV29A5+oK5YRP1Kfa9j
 vrE51DtnQCOiWwg3P5gc54aWXLEO71Esulw81A5gyMiAgx/EFcL1LzLRYN60EVP2Fsiv
 kIh/hsc/ej8LR3nkH3NTlJHo4kqYG80gT8yeHapIhQe1LGZFxV2Pi2RgwPJ+4aVYuyJS
 753/TG00b61e+XZPCCugkH3GKc7SYiSNZLAlLfhHwbIcJbajbNwIYYdjkNGzBDcgpn5y bg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vptjck9x8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 05:02:58 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40I4e7eb006232;
 Thu, 18 Jan 2024 05:02:57 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vptjck9wy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 05:02:57 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40I3P96x006836; Thu, 18 Jan 2024 05:02:56 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm7j20wru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 05:02:56 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40I52u3p62390742
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jan 2024 05:02:56 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C5F6858061;
 Thu, 18 Jan 2024 05:02:55 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD4265806C;
 Thu, 18 Jan 2024 05:02:52 +0000 (GMT)
Received: from [9.109.243.35] (unknown [9.109.243.35])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Jan 2024 05:02:52 +0000 (GMT)
Message-ID: <36491191-6b6c-4c7e-bfdd-ea58bcd38789@linux.ibm.com>
Date: Thu, 18 Jan 2024 10:32:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/ppc/cpu-models: Rename power5+ and power7+
 for new QOM naming rules
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20240117141054.73841-1-thuth@redhat.com>
 <20240117141054.73841-2-thuth@redhat.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240117141054.73841-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1rgZIQvrW99yYct4xF8vRxxeWTMhA1oe
X-Proofpoint-GUID: 9mncWrAps-EYQT6z2AfuH-Tqy79rb4na
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_01,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401180031
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 1/17/24 19:40, Thomas Huth wrote:
> The character "+" is now forbidden in QOM device names (see commit
> b447378e1217 - "Limit type names to alphanumerical and some few special
> characters"). For the "power5+" and "power7+" CPU names, there is
> currently a hack in type_name_is_valid() to still allow them for
> compatibility reasons. However, there is a much nicer solution for this:
> Simply use aliases! This way we can still support the old names without
> the need for the ugly hack in type_name_is_valid().
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   hw/ppc/spapr_cpu_core.c |  4 ++--
>   qom/object.c            |  4 ----
>   target/ppc/cpu-models.c | 10 ++++++----
>   3 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 5aa1ed474a..0c0fb3f1b0 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -389,9 +389,9 @@ static const TypeInfo spapr_cpu_core_type_infos[] = {
>       DEFINE_SPAPR_CPU_CORE_TYPE("970_v2.2"),
>       DEFINE_SPAPR_CPU_CORE_TYPE("970mp_v1.0"),
>       DEFINE_SPAPR_CPU_CORE_TYPE("970mp_v1.1"),
> -    DEFINE_SPAPR_CPU_CORE_TYPE("power5+_v2.1"),
> +    DEFINE_SPAPR_CPU_CORE_TYPE("power5p_v2.1"),
>       DEFINE_SPAPR_CPU_CORE_TYPE("power7_v2.3"),
> -    DEFINE_SPAPR_CPU_CORE_TYPE("power7+_v2.1"),
> +    DEFINE_SPAPR_CPU_CORE_TYPE("power7p_v2.1"),
>       DEFINE_SPAPR_CPU_CORE_TYPE("power8_v2.0"),
>       DEFINE_SPAPR_CPU_CORE_TYPE("power8e_v2.1"),
>       DEFINE_SPAPR_CPU_CORE_TYPE("power8nvl_v1.0"),
> diff --git a/qom/object.c b/qom/object.c
> index 654e1afaf2..2c4c64d2b6 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -160,10 +160,6 @@ static bool type_name_is_valid(const char *name)
>   
>       /* Allow some legacy names with '+' in it for compatibility reasons */
>       if (name[plen] == '+') {
> -        if (plen == 6 && g_str_has_prefix(name, "power")) {
> -            /* Allow "power5+" and "power7+" CPU names*/
> -            return true;
> -        }
>           if (plen >= 17 && g_str_has_prefix(name, "Sun-UltraSparc-I")) {
>               /* Allow "Sun-UltraSparc-IV+" and "Sun-UltraSparc-IIIi+" */
>               return true;
> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> index 7dbb47de64..36e465b390 100644
> --- a/target/ppc/cpu-models.c
> +++ b/target/ppc/cpu-models.c
> @@ -716,11 +716,11 @@
>                   "PowerPC 970MP v1.0")
>       POWERPC_DEF("970mp_v1.1",    CPU_POWERPC_970MP_v11,              970,
>                   "PowerPC 970MP v1.1")
> -    POWERPC_DEF("power5+_v2.1",  CPU_POWERPC_POWER5P_v21,            POWER5P,
> +    POWERPC_DEF("power5p_v2.1",  CPU_POWERPC_POWER5P_v21,            POWER5P,
>                   "POWER5+ v2.1")
>       POWERPC_DEF("power7_v2.3",   CPU_POWERPC_POWER7_v23,             POWER7,
>                   "POWER7 v2.3")
> -    POWERPC_DEF("power7+_v2.1",  CPU_POWERPC_POWER7P_v21,            POWER7,
> +    POWERPC_DEF("power7p_v2.1",  CPU_POWERPC_POWER7P_v21,            POWER7,
>                   "POWER7+ v2.1")
>       POWERPC_DEF("power8e_v2.1",  CPU_POWERPC_POWER8E_v21,            POWER8,
>                   "POWER8E v2.1")
> @@ -902,10 +902,12 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
>       { "970", "970_v2.2" },
>       { "970fx", "970fx_v3.1" },
>       { "970mp", "970mp_v1.1" },
> -    { "power5+", "power5+_v2.1" },
> +    { "power5+", "power5p_v2.1" },
> +    { "power5+_v2.1", "power5p_v2.1" },
>       { "power5gs", "power5+_v2.1" },
>       { "power7", "power7_v2.3" },
> -    { "power7+", "power7+_v2.1" },
> +    { "power7+", "power7p_v2.1" },
> +    { "power7+_v2.1", "power7p_v2.1" },
>       { "power8e", "power8e_v2.1" },
>       { "power8", "power8_v2.0" },
>       { "power8nvl", "power8nvl_v1.0" },

