Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B23E37A5A39
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 08:54:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiUbs-0000uk-TN; Tue, 19 Sep 2023 02:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qiUbr-0000uS-2h; Tue, 19 Sep 2023 02:53:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qiUbp-0005qA-JS; Tue, 19 Sep 2023 02:53:22 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38J6bdIO027431; Tue, 19 Sep 2023 06:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=MFrvARBeTU1tgfROBtjbYRrIQ0EfL2oNa7yNBhaYB3U=;
 b=abSuOe+f8aIYsslC+7E4p1NtWviicbKilLYhXt2U2/ujKSDP1rL/Fqd/rOXumvIw86qJ
 0EKUatfNRtDxkvFsLO3drivk0qrUUzDpFhWyhqTERtHBHMevXNDWrmLwfcHa/P6sTgTE
 mnbhBeEiRqV+yM61QBdds0c1rgT8gpdH9GAevU75xinCB2LUtzntMpkznkbQiMapyzy1
 HpyOqwM10tYJknLA/XJEo2o3ZsKqUQGhqahjvATMP7d73eqDTG8uHsUkMGGmVUw48Yvy
 FuPkMt3CsOpX8iHh8ggtgJsr2o9TQC5ZNrJZOW93yyNw5z/9ZWburdvVWB1C8EOhKsAU CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t75hs1dbf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 06:53:09 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38J6bsLC029883;
 Tue, 19 Sep 2023 06:53:09 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t75hs1db3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 06:53:09 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38J5jBLK016463; Tue, 19 Sep 2023 06:53:08 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5sd1s62n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 06:53:08 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38J6r83I66322870
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Sep 2023 06:53:08 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3CA4C58043;
 Tue, 19 Sep 2023 06:53:08 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F33A458055;
 Tue, 19 Sep 2023 06:53:05 +0000 (GMT)
Received: from [9.109.242.129] (unknown [9.109.242.129])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 19 Sep 2023 06:53:05 +0000 (GMT)
Message-ID: <cf9297ae-38c2-0954-006d-62ae44b3883c@linux.ibm.com>
Date: Tue, 19 Sep 2023 12:23:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/8] hw/ppc: Clean up local variable shadowing in _FDT
 helper routine
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>
References: <20230918145850.241074-1-clg@kaod.org>
 <20230918145850.241074-2-clg@kaod.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20230918145850.241074-2-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ki9icIOjEDoZo6QXkzVFeDZg7mFJemUS
X-Proofpoint-ORIG-GUID: tLUWWTCRjIUyDJDpeP8tdFe057P00S-s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_11,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0
 clxscore=1015 spamscore=0 mlxlogscore=664 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309190054
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
> this fixes numerous warnings of this type :
> 
>    In file included from ../hw/ppc/spapr_pci.c:43:
>    ../hw/ppc/spapr_pci.c: In function ‘spapr_dt_phb’:
>    ../include/hw/ppc/fdt.h:18:13: warning: declaration of ‘ret’ shadows a previous local [-Wshadow=compatible-local]
>       18 |         int ret = (exp);                                           \
>          |             ^~~
>    ../hw/ppc/spapr_pci.c:2355:5: note: in expansion of macro ‘_FDT’
>     2355 |     _FDT(bus_off = fdt_add_subnode(fdt, 0, phb->dtbusname));
>          |     ^~~~
>    ../hw/ppc/spapr_pci.c:2311:24: note: shadowed declaration is here
>     2311 |     int bus_off, i, j, ret;
>          |                        ^~~
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   include/hw/ppc/fdt.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/ppc/fdt.h b/include/hw/ppc/fdt.h
> index a8cd85069fe0..b56ac2a8cbb5 100644
> --- a/include/hw/ppc/fdt.h
> +++ b/include/hw/ppc/fdt.h
> @@ -15,10 +15,10 @@
>   
>   #define _FDT(exp)                                                  \
>       do {                                                           \
> -        int ret = (exp);                                           \
> -        if (ret < 0) {                                             \
> -            error_report("error creating device tree: %s: %s",   \
> -                    #exp, fdt_strerror(ret));                      \
> +        int _ret = (exp);                                          \
> +        if (_ret < 0) {                                            \
> +            error_report("error creating device tree: %s: %s",     \
> +                    #exp, fdt_strerror(_ret));                     \
>               exit(1);                                               \
>           }                                                          \
>       } while (0)

