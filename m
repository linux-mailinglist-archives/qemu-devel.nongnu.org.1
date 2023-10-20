Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D71BF7D0F9C
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 14:25:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtoXz-0004Jd-I7; Fri, 20 Oct 2023 08:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qtoXt-0004Eg-Vd; Fri, 20 Oct 2023 08:24:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qtoXr-0000dL-F8; Fri, 20 Oct 2023 08:24:05 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39KCCLVG023996; Fri, 20 Oct 2023 12:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=zjDyuZC1ZuzAGuT/gza9xvDcqT79Mx7wDsEBQE0fS3w=;
 b=nUQjXkL1BMsal4up55i0zx/QT3Ov0JORcgwYSxz0Fq/MOOkIo67oePqkSec4pZ+SqDYJ
 +gZfAu0Vui5LIQMuB25rjP3H1J1brlzWX9SB1qyWQvWA+5nIMTnc21QejxQbJ9wCZifw
 erQ2324PC0xqcSdwl7ft3c0kNQ5b3UyRj8RtJUtDdq97VyFi9Iz0JZvh5bHxj79mt90y
 oMaZdxFZMWLUUFIFTsORvQJG5w0/XoyYxjY53TBS5Dqck0wwfnKmqZUnBBuod6C0CsYE
 ucTVREUyAsnRf9kfh1/sqz1CwgP1vJpqMVJgSeAAX3mP4CjikrXA0i8Fwv3qjal0cVu5 JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tusbjgdfu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Oct 2023 12:23:37 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39KCCR40024627;
 Fri, 20 Oct 2023 12:23:33 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tusbjgd9s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Oct 2023 12:23:33 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39KCEDGi019377; Fri, 20 Oct 2023 12:22:40 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tuc454enu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Oct 2023 12:22:40 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39KCMc8b24052434
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Oct 2023 12:22:39 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C066658057;
 Fri, 20 Oct 2023 12:22:38 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D47D358061;
 Fri, 20 Oct 2023 12:22:36 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 20 Oct 2023 12:22:36 +0000 (GMT)
Message-ID: <3b898f46-cb88-15cb-43e6-06ccde6295c9@linux.ibm.com>
Date: Fri, 20 Oct 2023 08:22:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 10/13] migration: Improve example and documentation of
 vmstate_register()
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Eric Farman <farman@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Gibson <david@gibson.dropbear.id.au>,
 Corey Minyard <cminyard@mvista.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Corey Minyard <minyard@acm.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Leonardo Bras <leobras@redhat.com>,
 John Snow <jsnow@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goat?= =?UTF-8?Q?er?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Stefan Weil <sw@weilnetz.de>
References: <20231020090731.28701-1-quintela@redhat.com>
 <20231020090731.28701-11-quintela@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231020090731.28701-11-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oOZL2AWOXPhZT7lT-gjxbXXS-v30HLMu
X-Proofpoint-GUID: edyELfx3TsWmz_jtHwcjN9zNLisljS8n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310200102
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


On 10/20/23 05:07, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   docs/devel/migration.rst | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
> index c3e1400c0c..bfd8710c95 100644
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
> +3, and there are 4 uint8_t fields in the KBDState structure.  We
> +registered this ``VMSTATEDescription`` with one of the following
> +functions.  The first one will generate a device ``instance_id``
> +different for each registration.  Use the second one if you already
> +have an id that is different for each instance of the device:
>
>   .. code:: c
>
> -    vmstate_register(NULL, 0, &vmstate_kbd, s);
> +    vmstate_register_any(NULL, &vmstate_kbd, s);
> +    vmstate_register(NULL, instance_id, &vmstate_kbd, s);
>
>   For devices that are ``qdev`` based, we can register the device in the class
>   init function:

