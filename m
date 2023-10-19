Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A4D7D0319
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 22:21:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtZVU-0006pP-62; Thu, 19 Oct 2023 16:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qtZVR-0006nC-74; Thu, 19 Oct 2023 16:20:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qtZVP-0008LM-IO; Thu, 19 Oct 2023 16:20:32 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JKHIPv010550; Thu, 19 Oct 2023 20:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ztRYCBysnSriCmZVtZ2FhzbB0XgQY+Jj5Gzo1L0B3fU=;
 b=koD0R+bHxA2UXmPGp1qn/ljvoM8KbF2XjcdK1tm+6XYizp1wgWwpkL+FsoBK6eycBzoS
 okr9X0AU01oZxLITSgP/5OF78kzk2wgCBvVCtr11KIRvqL20TDKkO9KxDbL/HIQ8ExRZ
 BdiOGLkGnW9UNVh1h1q5r6WSt3KwsvzLlW9SBlvKljahZkr6GhNAM0P0g8rgVdDAJRzF
 sIllHtkv+q8jKOiZIivAKN6mfi2+6edoHUrI6gwgkehoETnUKZJUl3uoBBZZaQIL45pc
 Vxu2Pdb50y5K13WEuOgI81my6j3BgyIL4XK9NkXZPidZSI6qU7cBP/uM67L06kItvM9+ rw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tubc1g3gk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 20:20:14 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39JKHQsQ011668;
 Thu, 19 Oct 2023 20:20:13 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tubc1g3fn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 20:20:13 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JK13wA027154; Thu, 19 Oct 2023 20:20:11 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr6tku5je-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 20:20:11 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39JKKA7017695276
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 20:20:11 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F81158058;
 Thu, 19 Oct 2023 20:20:10 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 82A125805D;
 Thu, 19 Oct 2023 20:20:08 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 19 Oct 2023 20:20:08 +0000 (GMT)
Message-ID: <8eaa395b-3c42-ace3-9013-72ea80c2a1e8@linux.ibm.com>
Date: Thu, 19 Oct 2023 16:20:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 04/13] migration: Use vmstate_register_any() for ipmi-bt*
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, qemu-s390x@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Corey Minyard <minyard@acm.org>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Halil Pasic
 <pasic@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20231019190831.20363-1-quintela@redhat.com>
 <20231019190831.20363-5-quintela@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231019190831.20363-5-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MEjCY6TciJCsgIvapVqiRskCyNWz59yA
X-Proofpoint-GUID: N9tpfNFMKk6SV7gk5BVl8gsTMmbFNXfl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_20,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0
 malwarescore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190173
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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


On 10/19/23 15:08, Juan Quintela wrote:
> Otherwise device-introspection-test fails.
>
> $ ./tests/qtest/device-introspect-test
> ...
> Broken pipe
> ../../../../../mnt/code/qemu/full/tests/qtest/libqtest.c:195: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
> Aborted (core dumped)
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>   hw/ipmi/ipmi_bmc_extern.c | 2 +-
>   hw/ipmi/ipmi_bmc_sim.c    | 2 +-
>   hw/ipmi/isa_ipmi_bt.c     | 2 +-
>   hw/ipmi/isa_ipmi_kcs.c    | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
> index e232d35ba2..324a2c8835 100644
> --- a/hw/ipmi/ipmi_bmc_extern.c
> +++ b/hw/ipmi/ipmi_bmc_extern.c
> @@ -504,7 +504,7 @@ static void ipmi_bmc_extern_init(Object *obj)
>       IPMIBmcExtern *ibe = IPMI_BMC_EXTERN(obj);
>
>       ibe->extern_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, extern_timeout, ibe);
> -    vmstate_register(NULL, 0, &vmstate_ipmi_bmc_extern, ibe);
> +    vmstate_register_any(NULL, &vmstate_ipmi_bmc_extern, ibe);
>   }
>
>   static void ipmi_bmc_extern_finalize(Object *obj)
> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> index 905e091094..404db5d5bc 100644
> --- a/hw/ipmi/ipmi_bmc_sim.c
> +++ b/hw/ipmi/ipmi_bmc_sim.c
> @@ -2188,7 +2188,7 @@ static void ipmi_sim_realize(DeviceState *dev, Error **errp)
>
>       ibs->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, ipmi_timeout, ibs);
>
> -    vmstate_register(NULL, 0, &vmstate_ipmi_sim, ibs);
> +    vmstate_register_any(NULL, &vmstate_ipmi_sim, ibs);
>   }
>
>   static Property ipmi_sim_properties[] = {
> diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
> index a83e7243d6..afb76b548a 100644
> --- a/hw/ipmi/isa_ipmi_bt.c
> +++ b/hw/ipmi/isa_ipmi_bt.c
> @@ -125,7 +125,7 @@ static void isa_ipmi_bt_init(Object *obj)
>
>       ipmi_bmc_find_and_link(obj, (Object **) &iib->bt.bmc);
>
> -    vmstate_register(NULL, 0, &vmstate_ISAIPMIBTDevice, iib);
> +    vmstate_register_any(NULL, &vmstate_ISAIPMIBTDevice, iib);
>   }
>
>   static void *isa_ipmi_bt_get_backend_data(IPMIInterface *ii)
> diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
> index b2ed70b9da..5ab63b2fcf 100644
> --- a/hw/ipmi/isa_ipmi_kcs.c
> +++ b/hw/ipmi/isa_ipmi_kcs.c
> @@ -132,7 +132,7 @@ static void isa_ipmi_kcs_init(Object *obj)
>        * IPMI device, so receive it, but transmit a different
>        * version.
>        */
> -    vmstate_register(NULL, 0, &vmstate_ISAIPMIKCSDevice, iik);
> +    vmstate_register_any(NULL, &vmstate_ISAIPMIKCSDevice, iik);
>   }
>
>   static void *isa_ipmi_kcs_get_backend_data(IPMIInterface *ii)

