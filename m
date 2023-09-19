Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B99A7A5CE3
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 10:49:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiWP9-0006zq-Qa; Tue, 19 Sep 2023 04:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qiWP3-0006jw-Kr; Tue, 19 Sep 2023 04:48:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qiWP1-0008GE-3y; Tue, 19 Sep 2023 04:48:17 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38J8jPxK025306; Tue, 19 Sep 2023 08:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=THuKjfx8nW0qHyMrtzpzOu3WW3OpOJuHqzJQboIHuXQ=;
 b=PFhrZ138VsC0U+QwTupQsYuTcm4gesnNfrgw3GOHj67D8kPLMZUSevhmiVjgKTN+IrE+
 /UtO8ekCpLbTNUwnDuGuSsjf6NSWJy3rb4pna0Rf5xV6/Ftxqd1vURmrArS8++CERSms
 1tF+ixBmgpZj2pBiyDdQqu3c7fQtO4xEHLWBNXTtv8gU7XTKcDuWWNBaPW5mP8mbD8tH
 nbtzREF6XjK4XCsqULxhqKVNTsJ8GB5KLJ6C5o3V7i7uoLbQz4Ovv93Ft7Eo2NZNfURF
 wFbho6v/DIk3G9rARUH7hV+0lHgaAUrlUSlwqwyT39orvc94apdWc+NbdCQTrV/9Ucxc XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t71wnrdbn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 08:48:08 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38J8aeZd014419;
 Tue, 19 Sep 2023 08:48:07 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t71wnrdaw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 08:48:07 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38J8QLnc011677; Tue, 19 Sep 2023 08:48:06 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t5qpnam5p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 08:48:06 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38J8m5Kw38928778
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Sep 2023 08:48:05 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D4275805D;
 Tue, 19 Sep 2023 08:48:05 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3026B58043;
 Tue, 19 Sep 2023 08:48:03 +0000 (GMT)
Received: from [9.109.242.129] (unknown [9.109.242.129])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 19 Sep 2023 08:48:02 +0000 (GMT)
Message-ID: <660b5c89-d219-1e20-9fa5-1b7c390a2f1b@linux.ibm.com>
Date: Tue, 19 Sep 2023 14:18:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 8/8] spapr/drc: Clean up local variable shadowing in
 prop_get_fdt()
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>
References: <20230918145850.241074-1-clg@kaod.org>
 <20230918145850.241074-9-clg@kaod.org>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20230918145850.241074-9-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vFxio3EmDT7bhYACjwphjnD3Lo5uhQvN
X-Proofpoint-ORIG-GUID: mR9381VzNqnMFj-EpTJX_mh445-REYwd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_03,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0
 mlxlogscore=907 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190071
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
> Rename 'name' variable to avoid this warning :
> 
>    ../hw/ppc/spapr_drc.c: In function ‘prop_get_fdt’:
>    ../hw/ppc/spapr_drc.c:344:21: warning: declaration of ‘name’ shadows a parameter [-Wshadow=compatible-local]
>      344 |         const char *name = NULL;
>          |                     ^~~~
>    ../hw/ppc/spapr_drc.c:325:63: note: shadowed declaration is here
>      325 | static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
>          |                                                   ~~~~~~~~~~~~^~~~
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/ppc/spapr_drc.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 843e318312d3..2b99d3b4b1a6 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -341,7 +341,7 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
>       fdt_depth = 0;
>   
>       do {
> -        const char *name = NULL;
> +        const char *dt_name = NULL;

I guess you wanted to use the input arg "name" here without 
re-declaration. I do not see "name" being used elsewhere in this routine.

regards,
Harsh
>           const struct fdt_property *prop = NULL;
>           int prop_len = 0, name_len = 0;
>           uint32_t tag;
> @@ -351,8 +351,8 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
>           switch (tag) {
>           case FDT_BEGIN_NODE:
>               fdt_depth++;
> -            name = fdt_get_name(fdt, fdt_offset, &name_len);
> -            if (!visit_start_struct(v, name, NULL, 0, errp)) {
> +            dt_name = fdt_get_name(fdt, fdt_offset, &name_len);
> +            if (!visit_start_struct(v, dt_name, NULL, 0, errp)) {
>                   return;
>               }
>               break;
> @@ -369,8 +369,8 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
>           case FDT_PROP: {
>               int i;
>               prop = fdt_get_property_by_offset(fdt, fdt_offset, &prop_len);
> -            name = fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
> -            if (!visit_start_list(v, name, NULL, 0, errp)) {
> +            dt_name = fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
> +            if (!visit_start_list(v, dt_name, NULL, 0, errp)) {
>                   return;
>               }
>               for (i = 0; i < prop_len; i++) {

