Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC65379D9DC
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 22:01:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg9Z0-0002aL-Um; Tue, 12 Sep 2023 16:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qg9Yj-0002Wy-Uq; Tue, 12 Sep 2023 16:00:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qg9Yh-0008Qd-Na; Tue, 12 Sep 2023 16:00:29 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38CJkPYF017857; Tue, 12 Sep 2023 20:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=mime-version : date :
 from : to : cc : subject : in-reply-to : references : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=c1hhHY4k3zmF9xlfGFxAzurSx6vjBqxLbrnA5eQA8Mw=;
 b=oCMX7U7GWNgR4wYLleVZm/Gf2a2RPB4u/ML2UFSk1pkH5HeGquDnQeP06uiYqQHkOqwg
 /FXCLSVigyb6tSC2HxepFDXyK3rg1poVLp+lGMOq4qP4i3illS89iFtu1F6cI9o4bl8X
 4APQbpp8l1CTS3GUvr/hLBFPuVgucbCtGpLh/1likrcFKcBvNGmrzlfK7wMDht8mATwW
 SuEu6y8p2pQnmPO7KxmSl+vhRRw2mx2cKsUtE5YbULAyRDJXjxv+z7iPPXDoFDlDbW6Y
 XiEBWzDaj8pO9sn4v2zVO9pT6x52d9bStAypW1GdADAte+B75r1tjqgomsxrwgrEb5rW Dw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2xeg8a2n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Sep 2023 20:00:18 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38CJmSx7024856;
 Tue, 12 Sep 2023 20:00:18 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2xeg8a29-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Sep 2023 20:00:18 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38CIqC3N002410; Tue, 12 Sep 2023 20:00:17 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t158k5e0x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Sep 2023 20:00:17 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38CK0HGF5767820
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Sep 2023 20:00:17 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 07ABF58056;
 Tue, 12 Sep 2023 20:00:17 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 497E75805F;
 Tue, 12 Sep 2023 20:00:16 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Sep 2023 20:00:16 +0000 (GMT)
MIME-Version: 1.0
Date: Tue, 12 Sep 2023 15:00:15 -0500
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: Glenn Miles <milesg@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, David Gibson
 <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Nicholas Piggin
 <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH 1/4] target/ppc: Add new hflags to support BHRB
In-Reply-To: <20230911212340.2260383-2-milesg@linux.vnet.ibm.com>
References: <20230911212340.2260383-1-milesg@linux.vnet.ibm.com>
 <20230911212340.2260383-2-milesg@linux.vnet.ibm.com>
Message-ID: <9d8164edf63540f2935a02cc31f40c8b@imap.linux.ibm.com>
X-Sender: milesg@linux.vnet.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ee3Bq1GKqlNA1yigxYy27lgv3U9HB58Z
X-Proofpoint-ORIG-GUID: eEfPtJI3R1B2SRR8Pg77Vg9ptLnTTW6d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_19,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=482
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120165
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Sorry, this is my first attempt at sending out a patch and it looks like 
only part of the patch made it.  Until I can figure out what I did 
wrong, please ignore this patch.

Thanks,
Glenn Miles

