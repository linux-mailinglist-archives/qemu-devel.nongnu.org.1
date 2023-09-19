Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1487A5C8D
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 10:30:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiW6m-0005pa-Pf; Tue, 19 Sep 2023 04:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qiW6l-0005p4-0V; Tue, 19 Sep 2023 04:29:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qiW6j-0002sX-I0; Tue, 19 Sep 2023 04:29:22 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38J899MC032499; Tue, 19 Sep 2023 08:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=TUXw/rl+EIhvLCOProNVcfjFxFrO7w08qpZsgBgV6g0=;
 b=WiAEz0nP4CNq2TNWe4eKvdHfkJgl6nMk9HCquBQQ7oD0hqgrIc/AtazKRzR397d2l9DB
 WnOU0jSGnB+9RZLuE/Qn2eWL2DL3EBKBqZYPF0HhEp+ue8W5KAu9lEOQqtTxltdnjCY3
 tZkLBtNAU8vU42t/QvAWUgsrbAlZb1ufnlIyG70fGNmoE0ui3Bti6g57Ystk4hq2m7T9
 sISR3v5tW89mdZJrX2agD636jnSs02akeHMjJQ8Xokh83QkZAUHqz25ngNrxvqZh1XSR
 Tcu7Zv6eCMiZQzslFD83qJYNeUbdf/aTQkftBUDmGzCQKqGdlZ9+TlsNSQsJp5OF0kNr Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t7454nsc1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 08:29:09 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38J89i6F001990;
 Tue, 19 Sep 2023 08:29:09 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t7454nsbs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 08:29:09 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38J8BBhs005540; Tue, 19 Sep 2023 08:29:08 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t5q2yjnda-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 08:29:08 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38J8T81u3605048
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Sep 2023 08:29:08 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EEDA458059;
 Tue, 19 Sep 2023 08:29:07 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4BFDD58061;
 Tue, 19 Sep 2023 08:29:05 +0000 (GMT)
Received: from [9.109.242.129] (unknown [9.109.242.129])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 19 Sep 2023 08:29:04 +0000 (GMT)
Message-ID: <9e061471-931c-daf8-ab8f-567ce99f5057@linux.ibm.com>
Date: Tue, 19 Sep 2023 13:59:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 6/8] spapr/drc: Clean up local variable shadowing in
 rtas_ibm_configure_connector()
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>
References: <20230918145850.241074-1-clg@kaod.org>
 <20230918145850.241074-7-clg@kaod.org>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20230918145850.241074-7-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gBY7wuCG4FY231UnCjACL4EahHEisi17
X-Proofpoint-ORIG-GUID: FGiYzTM1xMTKfDIOkWKfJIiuz4wHGZ5Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_02,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxlogscore=875
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190067
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
> Remove extra 'drc_index' variable to avoid this warning :
> 
>    ../hw/ppc/spapr_drc.c: In function ‘rtas_ibm_configure_connector’:
>    ../hw/ppc/spapr_drc.c:1240:26: warning: declaration of ‘drc_index’ shadows a previous local [-Wshadow=compatible-local]
>     1240 |                 uint32_t drc_index = spapr_drc_index(drc);
>          |                          ^~~~~~~~~
>    ../hw/ppc/spapr_drc.c:1155:14: note: shadowed declaration is here
>     1155 |     uint32_t drc_index;
>          |              ^~~~~~~~~
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/ppc/spapr_drc.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index b5c400a94d1c..843e318312d3 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -1237,8 +1237,6 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
>           case FDT_END_NODE:
>               drc->ccs_depth--;
>               if (drc->ccs_depth == 0) {
> -                uint32_t drc_index = spapr_drc_index(drc);
> -
I guess you only wanted to remove re-declaration part. Assigning the 
value returned by this function doesnt seem to happen before.

>                   /* done sending the device tree, move to configured state */
>                   trace_spapr_drc_set_configured(drc_index);
>                   drc->state = drck->ready_state;

