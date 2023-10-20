Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 488207D0BC3
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 11:32:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtlr9-0002rf-Ao; Fri, 20 Oct 2023 05:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1qtlr6-0002lh-1i; Fri, 20 Oct 2023 05:31:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1qtlr4-0004jN-8y; Fri, 20 Oct 2023 05:31:43 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39K9TuB9012798; Fri, 20 Oct 2023 09:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rhdmphXT+qaQIUNTfEAde9/TRP8L8jw30EQetEWNgWQ=;
 b=d02Iwizi8Q9HMugGRUXjDvxyA/rWpQjDOeW4Dn0RHVK9urGYJBKDkd23YHxQbYJ1eB2K
 3vt0MACndCjrN5P0iO07IxG4cB+aOz5bDhIvHGwU89Z8NRaOPafT/5RIewExK2g58pB0
 K2vHtLd3/LafIaZ7MCv8yGRvurEMKhHmHeOWVkl9yNPaiExQ/ItcXYHU5XN9wmgcDL1+
 6b1OLyFUDAoCjZ9Hq0OaN2wGU/eQE/3AU6SBF/RuGcfuMpJCSGHUBz42E/ykuS0RPIZ1
 DPxEM++8KjH/AlQRs/faeCEB89nnHhcqY8FK0hPK3yxGFh21PA6WqpySFeFbA104f5V/ ew== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tupydg1uj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Oct 2023 09:31:19 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39K9TvPI012884;
 Fri, 20 Oct 2023 09:31:19 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tupydg1u1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Oct 2023 09:31:18 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39K8wNCq007096; Fri, 20 Oct 2023 09:26:18 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tuc27km84-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Oct 2023 09:26:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39K9QFwF21496330
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Oct 2023 09:26:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E28F020082;
 Fri, 20 Oct 2023 09:26:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 31E3F2004D;
 Fri, 20 Oct 2023 09:26:14 +0000 (GMT)
Received: from [9.152.224.53] (unknown [9.152.224.53])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Oct 2023 09:26:14 +0000 (GMT)
Message-ID: <b8b79cb0-1537-b0bb-5c30-1ac2582034cb@linux.ibm.com>
Date: Fri, 20 Oct 2023 11:26:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 06/13] migration: Use VMSTATE_INSTANCE_ID_ANY for s390
 devices
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
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goat?= =?UTF-8?Q?er?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, Stefan Weil
 <sw@weilnetz.de>, Stefan Berger <stefanb@linux.ibm.com>
References: <20231020090731.28701-1-quintela@redhat.com>
 <20231020090731.28701-7-quintela@redhat.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20231020090731.28701-7-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: V9XCoXXPTdxN3aNMKeYBIQhl1nHbxCy0
X-Proofpoint-GUID: 0wIf8dn7SK5aUfwwVubvV3r0SFS8G_7R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_07,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 spamscore=0 clxscore=1011 mlxlogscore=999 phishscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310200078
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Am 20.10.23 um 11:07 schrieb Juan Quintela:
> Just with make check I can see that we can have more than one of this
> devices, so use ANY.
> 
> ok 5 /s390x/device/introspect/abstract-interfaces
> ...
> Broken pipe
> ../../../../../mnt/code/qemu/full/tests/qtest/libqtest.c:195: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
> Aborted (core dumped)
> 
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>   hw/s390x/s390-skeys.c    | 3 ++-
>   hw/s390x/s390-stattrib.c | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)

Actually both devices should be theŕe only once - I think.

> 
> diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
> index 5024faf411..ef089e1967 100644
> --- a/hw/s390x/s390-skeys.c
> +++ b/hw/s390x/s390-skeys.c
> @@ -22,6 +22,7 @@
>   #include "sysemu/kvm.h"
>   #include "migration/qemu-file-types.h"
>   #include "migration/register.h"
> +#include "migration/vmstate.h"
>   
>   #define S390_SKEYS_BUFFER_SIZE (128 * KiB)  /* Room for 128k storage keys */
>   #define S390_SKEYS_SAVE_FLAG_EOS 0x01
> @@ -457,7 +458,7 @@ static inline void s390_skeys_set_migration_enabled(Object *obj, bool value,
>       ss->migration_enabled = value;
>   
>       if (ss->migration_enabled) {
> -        register_savevm_live(TYPE_S390_SKEYS, 0, 1,
> +        register_savevm_live(TYPE_S390_SKEYS, VMSTATE_INSTANCE_ID_ANY, 1,
>                                &savevm_s390_storage_keys, ss);
>       } else {
>           unregister_savevm(VMSTATE_IF(ss), TYPE_S390_SKEYS, ss);
> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index 220e845d12..055d382c3c 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -13,6 +13,7 @@
>   #include "qemu/units.h"
>   #include "migration/qemu-file.h"
>   #include "migration/register.h"
> +#include "migration/vmstate.h"
>   #include "hw/s390x/storage-attributes.h"
>   #include "qemu/error-report.h"
>   #include "exec/ram_addr.h"
> @@ -380,7 +381,7 @@ static void s390_stattrib_instance_init(Object *obj)
>   {
>       S390StAttribState *sas = S390_STATTRIB(obj);
>   
> -    register_savevm_live(TYPE_S390_STATTRIB, 0, 0,
> +    register_savevm_live(TYPE_S390_STATTRIB, VMSTATE_INSTANCE_ID_ANY, 0,
>                            &savevm_s390_stattrib_handlers, sas);
>   
>       object_property_add_bool(obj, "migration-enabled",

