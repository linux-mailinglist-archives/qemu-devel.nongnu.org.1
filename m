Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED31746E55
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 12:13:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGd1s-0002zU-FN; Tue, 04 Jul 2023 06:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qGd1j-0002si-LZ; Tue, 04 Jul 2023 06:12:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qGd1h-0007Te-G2; Tue, 04 Jul 2023 06:12:54 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 364A2NAR003506; Tue, 4 Jul 2023 10:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=g00hAQbycoXhy9HbQYLSeWkNGrTtzx6Y38jw4fL+cU0=;
 b=fl1eUJNMHgIE92kTEQewWCcSE5Wro937eVeMorxzfAupcrHHJmHx0QQMWCFZqJXDZd+5
 I0mX0uHzTwVRYpCIWImVkh8clEGKv0DRmWzca5sqJVsAz3zy15Q4POzVkzQjgvYHvHja
 sJGH33y0lyOF1nbsWoF1GUcsVCUVWvMz/ABwY3g/p/pa7H+WGR9vgi/ULVM5eGuBYodB
 VEb7mJIHjMzcPtqfr1CV89H8FTX6yYgrqHD9cq0ZbAxmid8aaEpkHCQF3lnJuUqpK9Kb
 7UMw3IdMuXawvGCv/8z4PY09In4M7kDF/VNWXYKR6MC2qTVDE843iYTEnnFS6wiPxt/J RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmhaj89ew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 10:12:42 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 364A2PTU003782;
 Tue, 4 Jul 2023 10:12:41 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmhaj89e0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 10:12:41 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3647R5Lk025232;
 Tue, 4 Jul 2023 10:12:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3rjbs4sdt0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 10:12:38 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 364ACa0x24838560
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Jul 2023 10:12:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4066C2006C;
 Tue,  4 Jul 2023 10:12:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DCB7A2006E;
 Tue,  4 Jul 2023 10:12:35 +0000 (GMT)
Received: from [9.179.4.4] (unknown [9.179.4.4])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Jul 2023 10:12:35 +0000 (GMT)
Message-ID: <980d9ed4-f3bd-2d1b-9a1b-f9f4f244c280@linux.ibm.com>
Date: Tue, 4 Jul 2023 12:12:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 5/5] ppc/pnv: Return zero for core thread state xscom
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20230704054204.168547-1-joel@jms.id.au>
 <20230704054204.168547-6-joel@jms.id.au>
From: Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <20230704054204.168547-6-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: l9K6qVA_awRTqrN_HCTF3iGbfbPU0KBT
X-Proofpoint-ORIG-GUID: KTVkqkq24DuGns_qKlv6eK1mF_P4GDcO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_06,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 clxscore=1015 mlxlogscore=999 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040083
Received-SPF: pass client-ip=148.163.158.5; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 04/07/2023 07:42, Joel Stanley wrote:
> Firmware now warns if booting in LPAR per core mode (PPC bit 62). So
> this warning doesn't trigger, report the core thread state is 0.
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---


Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>

   Fred

>   hw/ppc/pnv_core.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 1eec28c88c41..b7223bb44597 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -116,6 +116,8 @@ static const MemoryRegionOps pnv_core_power8_xscom_ops = {
>   #define PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_HYP 0xf010d
>   #define PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_OTR 0xf010a
>   
> +#define PNV9_XSCOM_EC_CORE_THREAD_STATE    0x10ab3
> +
>   static uint64_t pnv_core_power9_xscom_read(void *opaque, hwaddr addr,
>                                              unsigned int width)
>   {
> @@ -134,6 +136,9 @@ static uint64_t pnv_core_power9_xscom_read(void *opaque, hwaddr addr,
>       case PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_OTR:
>           val = 0x0;
>           break;
> +    case PNV9_XSCOM_EC_CORE_THREAD_STATE:
> +        val = 0;
> +        break;
>       default:
>           qemu_log_mask(LOG_UNIMP, "Warning: reading reg=0x%" HWADDR_PRIx "\n",
>                     addr);
> @@ -171,6 +176,8 @@ static const MemoryRegionOps pnv_core_power9_xscom_ops = {
>    * POWER10 core controls
>    */
>   
> +#define PNV10_XSCOM_EC_CORE_THREAD_STATE    0x412
> +
>   static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
>                                              unsigned int width)
>   {
> @@ -178,6 +185,9 @@ static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
>       uint64_t val = 0;
>   
>       switch (offset) {
> +    case PNV10_XSCOM_EC_CORE_THREAD_STATE:
> +        val = 0;
> +        break;
>       default:
>           qemu_log_mask(LOG_UNIMP, "Warning: reading reg=0x%" HWADDR_PRIx "\n",
>                     addr);

