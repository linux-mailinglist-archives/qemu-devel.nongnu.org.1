Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBBB7D0377
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:05:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaBe-0002t4-Qt; Thu, 19 Oct 2023 17:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qtaBL-0002p4-PN; Thu, 19 Oct 2023 17:03:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qtaBJ-0001QS-Oc; Thu, 19 Oct 2023 17:03:51 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JL0WLv029786; Thu, 19 Oct 2023 21:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=R/3h87s0xeLqmjIb7mURZ4HmMkSUJrD+xg+924aPtlM=;
 b=orkHFEMnVgZ96qNwvJ+KDBNZixIFKRUwqoXIFMJ5V7R6KqQcMNDs4R6rLi97lN/s9gOp
 2X6mKv/DSV/esk6xeOrOdw2CF+5AELdz75FJjkc3zKn6gbORJ69evZkCsP192nKYrSh7
 zig0MeH0DDQaUlMhiAQozG0KmJDaEby4DT6+BO5BHxacVW2vbKtgkQZVxLD+TxtArz+C
 4KnAimIA/eTgI58gMtRJjx/R1dOGSXrrvY/jWNWBEbvonSKjLvZ8jo9+CzkHblXd5HNj
 ON11BeyAH6jFOqyRMtdbce266npln3SQh32Eljz38sj2eTVSKmNRQgnW6fFzqMdA38q2 jA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tuc058ab7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 21:03:32 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39JL0fRE030363;
 Thu, 19 Oct 2023 21:03:20 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tuc0589aa-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 21:03:20 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JJhi2D027130; Thu, 19 Oct 2023 20:38:20 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr6tku8k9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 20:38:20 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39JKcJQK48496988
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 20:38:19 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88E9358059;
 Thu, 19 Oct 2023 20:38:19 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7EFF058057;
 Thu, 19 Oct 2023 20:38:16 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 19 Oct 2023 20:38:16 +0000 (GMT)
Message-ID: <8b7a67bf-6d45-374c-13ee-fbb85b4b21bc@linux.ibm.com>
Date: Thu, 19 Oct 2023 16:38:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 10/13] migration: Improve example and documentation of
 vmstate_register()
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
 <20231019190831.20363-11-quintela@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231019190831.20363-11-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AFRDLxnl0cnlKe5z7up_F34GBaDdsUSv
X-Proofpoint-ORIG-GUID: 37p4IB-0PDqTaExATMDl8XywRTb2HTuY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_21,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=994 lowpriorityscore=0
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310190177
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>   docs/devel/migration.rst | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
> index c3e1400c0c..a9fde75862 100644
> --- a/docs/devel/migration.rst
> +++ b/docs/devel/migration.rst
> @@ -165,13 +165,17 @@ An example (from hw/input/pckbd.c)
>         }
>     };
>
> -We are declaring the state with name "pckbd".
> -The ``version_id`` is 3, and the fields are 4 uint8_t in a KBDState structure.
> -We registered this with:
> +We are declaring the state with name "pckbd".  The ``version_id`` is
> +3, and the fields are 4 uint8_t in a KBDState structure.  We

and there are 4  uint8_t fields in the KBDState structure.


> +registered this with one of those.  The first one will generate a

I am not sure what this means 'We registered this with one of those'. 
What is 'one of those'?

Maybe you mean: We register the KBDState with one of the following 
functions.

> +device ``instance_id`` different for each registration.  Use the
> +second one if you already have an id different for each instance of
> +the device:
... have an id that is is different for each ...
>
>   .. code:: c
>
> -    vmstate_register(NULL, 0, &vmstate_kbd, s);
> +    vmstate_register_any(NULL, &vmstate_kbd, s);
> +    vmstate_register(NULL, instance_id, &vmstate_kbd, s);
>
>   For devices that are ``qdev`` based, we can register the device in the class
>   init function:

