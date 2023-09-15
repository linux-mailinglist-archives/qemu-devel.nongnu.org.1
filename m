Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AF17A208A
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:12:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh9WX-0002al-0A; Fri, 15 Sep 2023 10:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qh9WO-0002Zl-UM; Fri, 15 Sep 2023 10:10:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qh9WJ-0007Ox-LC; Fri, 15 Sep 2023 10:10:09 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38FE85A1008413; Fri, 15 Sep 2023 14:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=j2q77u//MYjHd7cR/skD7qX5Xmcctg5Hn9/EGalsodA=;
 b=SeekE8NBQiPm3L3f6XWt8oUXC22YmMTlRZS818Rlk3VY8PBaMm3y2KbD93utFwCwCc0Q
 uU+AvmzLedJSbyA9FM5heBzji9F9lwvRMj29+rzlmoHJpYxPGzE8I4Z+i6KwfPqMoylG
 MivZL5BxqS1v1wfDo0ZNvD9SyTLFsaa5RGfYhqvH1eGhJQXOxyk1Q00a43Im82u3BGrz
 iUn217BVLHU3nN1rBvO/ux5NraxuLkJmDJ6mKdt+PHX43r9F7GX3ICADb7q3/iEq4QVH
 idH8t0fMzemuPSEWJ6tngVDz1uztq6FJuWKHxXayDn1eFKuy5nJN9yKJEynwCNBP1oeF bA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t4qxnskpp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Sep 2023 14:09:49 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38FE8UkY011644;
 Fri, 15 Sep 2023 14:08:56 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t4qxnshr1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Sep 2023 14:08:55 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38FCkBw9012064; Fri, 15 Sep 2023 14:03:29 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t13e0cbv3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Sep 2023 14:03:29 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38FE3SMJ25952830
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Sep 2023 14:03:28 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 34A095804B;
 Fri, 15 Sep 2023 14:03:28 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1DAB258055;
 Fri, 15 Sep 2023 14:03:24 +0000 (GMT)
Received: from [9.195.38.120] (unknown [9.195.38.120])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 15 Sep 2023 14:03:23 +0000 (GMT)
Message-ID: <fdcb3e3a-027b-fdc3-7853-a6e9d02ebb6b@linux.ibm.com>
Date: Fri, 15 Sep 2023 19:33:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] MAINTAINERS: Nick Piggin PPC maintainer, other PPC changes
Content-Language: en-US
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, groug@kaod.org,
 npiggin@gmail.com, aik@ozlabs.ru, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>
References: <20230915110507.194762-1-danielhb413@gmail.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20230915110507.194762-1-danielhb413@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IaayR3UUmJsX8loUYE4sX2MnomYp6QIQ
X-Proofpoint-ORIG-GUID: nEdlGxuoy1kszsGTxyfriYuLxJPxthB7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_11,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1011 suspectscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150126
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



On 9/15/23 16:35, Daniel Henrique Barboza wrote:
> Update all relevant PowerPC entries as follows:
> 
> - Nick Piggin is promoted to Maintainer in all qemu-ppc subsystems.
>    Nick has  been a solid contributor for the last couple of years and
>    has the required knowledge and motivation to drive the boat.
> 
> - Greg Kurz is being removed from all qemu-ppc entries. Greg has moved
>    to other areas of interest and will retire from qemu-ppc.  Thanks Mr
>    Kurz for all the years of service.
> 
> - David Gibson was removed as 'Reviewer' from PowerPC TCG CPUs and PPC
>    KVM CPUs. Change done per his request.
> 
> - Daniel Barboza downgraded from 'Maintainer' to 'Reviewer' in sPAPR and
>    PPC KVM CPUs. It has been a long since I last touched those areas and
>    it's not justified to be kept as maintainer in them.
> 
> - Cedric Le Goater and Daniel Barboza removed as 'Reviewer' in VOF. We
>    don't have the required knowledge to justify it.
> 

Thanks all for your contributions and support so far. Welcome Nick !
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> - VOF support downgraded from 'Maintained' to 'Odd Fixes' since it
>    better reflects the current state of the subsystem.
> 
> Acked-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>   MAINTAINERS | 20 +++++++-------------
>   1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 00562f924f..c4aa1c1c9f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -298,11 +298,9 @@ F: hw/openrisc/
>   F: tests/tcg/openrisc/
>   
>   PowerPC TCG CPUs
> +M: Nicholas Piggin <npiggin@gmail.com>
>   M: Daniel Henrique Barboza <danielhb413@gmail.com>
>   R: Cédric Le Goater <clg@kaod.org>
> -R: David Gibson <david@gibson.dropbear.id.au>
> -R: Greg Kurz <groug@kaod.org>
> -R: Nicholas Piggin <npiggin@gmail.com>
>   L: qemu-ppc@nongnu.org
>   S: Odd Fixes
>   F: target/ppc/
> @@ -438,10 +436,9 @@ F: target/mips/kvm*
>   F: target/mips/sysemu/
>   
>   PPC KVM CPUs
> -M: Daniel Henrique Barboza <danielhb413@gmail.com>
> +M: Nicholas Piggin <npiggin@gmail.com>
> +R: Daniel Henrique Barboza <danielhb413@gmail.com>
>   R: Cédric Le Goater <clg@kaod.org>
> -R: David Gibson <david@gibson.dropbear.id.au>
> -R: Greg Kurz <groug@kaod.org>
>   S: Odd Fixes
>   F: target/ppc/kvm.c
>   
> @@ -1430,10 +1427,10 @@ F: include/hw/rtc/m48t59.h
>   F: tests/avocado/ppc_prep_40p.py
>   
>   sPAPR (pseries)
> -M: Daniel Henrique Barboza <danielhb413@gmail.com>
> +M: Nicholas Piggin <npiggin@gmail.com>
> +R: Daniel Henrique Barboza <danielhb413@gmail.com>
>   R: Cédric Le Goater <clg@kaod.org>
>   R: David Gibson <david@gibson.dropbear.id.au>
> -R: Greg Kurz <groug@kaod.org>
>   R: Harsh Prateek Bora <harshpb@linux.ibm.com>
>   L: qemu-ppc@nongnu.org
>   S: Odd Fixes
> @@ -1452,8 +1449,8 @@ F: tests/avocado/ppc_pseries.py
>   
>   PowerNV (Non-Virtualized)
>   M: Cédric Le Goater <clg@kaod.org>
> +M: Nicholas Piggin <npiggin@gmail.com>
>   R: Frédéric Barrat <fbarrat@linux.ibm.com>
> -R: Nicholas Piggin <npiggin@gmail.com>
>   L: qemu-ppc@nongnu.org
>   S: Odd Fixes
>   F: docs/system/ppc/powernv.rst
> @@ -1497,12 +1494,9 @@ F: include/hw/pci-host/mv64361.h
>   
>   Virtual Open Firmware (VOF)
>   M: Alexey Kardashevskiy <aik@ozlabs.ru>
> -R: Cédric Le Goater <clg@kaod.org>
> -R: Daniel Henrique Barboza <danielhb413@gmail.com>
>   R: David Gibson <david@gibson.dropbear.id.au>
> -R: Greg Kurz <groug@kaod.org>
>   L: qemu-ppc@nongnu.org
> -S: Maintained
> +S: Odd Fixes
>   F: hw/ppc/spapr_vof*
>   F: hw/ppc/vof*
>   F: include/hw/ppc/vof*

