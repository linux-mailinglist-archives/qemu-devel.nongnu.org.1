Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8687F9883
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 06:06:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7Tno-0007pF-LU; Mon, 27 Nov 2023 00:05:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1r7Tnl-0007oh-Vu; Mon, 27 Nov 2023 00:04:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1r7Tnj-0005Ts-WB; Mon, 27 Nov 2023 00:04:57 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AR1AhDU008334; Mon, 27 Nov 2023 05:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=IohTfhf1ACIwzMUEOmJ/CU4tQEaUzAMEI0KbzZk2YLw=;
 b=oKujm7RNQIjBDgvDDSMVnMrgdkDzyg/Ywd5k7d3gYdYZJkeeTDqC5kfYV0zJ23RWS+Z2
 x4jntwDH9CkVspn4W2t4dE7kWHasr3KKGIb8kDsDb72AVMdTAgsMkxjF7i3dxHM06/B/
 pffHDt33DRqZx50ZPFd1MgmZ5yGcCC4XkvR7Rl1iBPJl2od94Qk3je6soJr+/tdQeT2e
 c2WbCp8qHZxl7vA4QJX4tbPG3KnkS9qfm+/eMjNgcVUszCSCDmxG47mw7gKBBJe2PcQC
 3LSW1hUZvrKSLR5xFT8QD/lulu+bpWR6zE7subJT9eqQfZTRzGGscniu8y+/mmN6yc8T Pg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umgaq4tqs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 05:04:07 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AR4oHgn022883;
 Mon, 27 Nov 2023 05:04:07 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umgaq4tpk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 05:04:07 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AR44OTu029880; Mon, 27 Nov 2023 05:04:05 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukumy6kr0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 05:04:05 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AR544qV26018370
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Nov 2023 05:04:04 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 593E458060;
 Mon, 27 Nov 2023 05:04:04 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DFDD15805C;
 Mon, 27 Nov 2023 05:03:52 +0000 (GMT)
Received: from [9.43.20.5] (unknown [9.43.20.5])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Nov 2023 05:03:52 +0000 (GMT)
Message-ID: <652f5196-b4fc-8d67-3933-f44751c01122@linux.ibm.com>
Date: Mon, 27 Nov 2023 10:33:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH-for-9.0 v2 1/8] hw/ppc/spapr_cpu_core: Access QDev
 properties with proper API
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>, Joel Stanley <joel@jms.id.au>, 
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 Hao Wu <wuhaotsh@google.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20231123143813.42632-1-philmd@linaro.org>
 <20231123143813.42632-2-philmd@linaro.org>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20231123143813.42632-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QD_BCtNgMcWBdEJGnzrmj44oWtX9Ym6j
X-Proofpoint-ORIG-GUID: I_Q-iQS0GbVTGEAYuvX0qCvdDxY8bL7z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_02,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 mlxlogscore=753 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 clxscore=1011 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311270035
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.477,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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



On 11/23/23 20:08, Philippe Mathieu-Daudé wrote:
> CPUState::start_powered_off field is part of the internal
> implementation of a QDev CPU. It is exposed as the QDev
> "start-powered-off" property. External components should
> use the qdev properties API to access it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   hw/ppc/spapr_cpu_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 91fae56573..24f759ba26 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -306,7 +306,7 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **errp)
>        * All CPUs start halted. CPU0 is unhalted from the machine level reset code
>        * and the rest are explicitly started up by the guest using an RTAS call.
>        */
> -    cs->start_powered_off = true;
> +    qdev_prop_set_bit(DEVICE(obj), "start-powered-off", true);
>       cs->cpu_index = cc->core_id + i;
>       if (!spapr_set_vcpu_id(cpu, cs->cpu_index, errp)) {
>           return NULL;

