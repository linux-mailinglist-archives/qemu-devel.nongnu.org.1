Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4547FAC14
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 21:53:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7iad-00031C-K8; Mon, 27 Nov 2023 15:52:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r7iaO-0002z9-Qk; Mon, 27 Nov 2023 15:52:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r7iaL-0008PN-Cn; Mon, 27 Nov 2023 15:52:08 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ARKcJAa010578; Mon, 27 Nov 2023 20:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=D76HzzKHJ0CUmepN8fmdby7z/Z1P7MuI+mmkBO9hsMA=;
 b=ZoSAdoIh582uDKSG5RzTHuP9WJHvp1M++z44k/LwHLyV2Yf9OVHq/sj5qmmSKaf7eZDT
 cHBPjBmxyVaJeawRSPmiFsT/BnBzQJexU13T2Cq8YHVYT+MQAeydMpe0sRD7TRUtyEyx
 s1RWV4BKSrogFbWEFjRXkcooJp3nieg9rSEzUmqOpdjxyJPINnXsut/VtjwZ8fyhUGvV
 m3nl4QY90NYgDAaCe8LuEf/Ii2HuR0F4yNrre53C99AXttdJ5jsTfesykYRUsOZIir7L
 I58fkeGhyhK1RkXyT7UFaMLGBmy2mrZMi1UJVzAs62v4YEdjFaJHtC2BuL80Jk5OTdlB 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3un2aq0c2d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 20:51:56 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ARKcWsu010928;
 Mon, 27 Nov 2023 20:51:56 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3un2aq0c20-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 20:51:56 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ARJSXRI025568; Mon, 27 Nov 2023 20:51:55 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukvrkb561-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 20:51:55 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3ARKpsR57340552
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Nov 2023 20:51:55 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E55F958051;
 Mon, 27 Nov 2023 20:51:54 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8FD85805C;
 Mon, 27 Nov 2023 20:51:54 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Nov 2023 20:51:54 +0000 (GMT)
Message-ID: <c39ad84ee405d3539b40db34f920dc2879a940b4.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 0/4] Add BHRB Facility Support
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 27 Nov 2023 14:51:54 -0600
In-Reply-To: <66558e7df3b0eadece637f452bfbf7add72955eb.camel@linux.vnet.ibm.com>
References: <20230925174351.617891-1-milesg@linux.vnet.ibm.com>
 <CWBNQ9QDEYH8.3QL9E2V4ZF26G@wheely>
 <66558e7df3b0eadece637f452bfbf7add72955eb.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aU2Sv0DWGZtgcUmF30Tct0QxWSSEZGfp
X-Proofpoint-ORIG-GUID: cZyPiwCfgn_PhMwu5VF3H_aveqYwGKs2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_19,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 clxscore=1011 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=681 spamscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270145
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 2023-10-18 at 10:59 -0500, Miles Glenn wrote:
> On Thu, 2023-10-19 at 01:06 +1000, Nicholas Piggin wrote:
> > On Tue Sep 26, 2023 at 3:43 AM AEST, Glenn Miles wrote:
> > > This is a series of patches for adding support for the Branch
> > > History
> > > Rolling Buffer (BHRB) facility.  This was added to the Power ISA
> > > starting with version 2.07.  Changes were subsequently made in
> > > version
> > > 3.1 to limit BHRB recording to instructions run in problem state
> > > only
> > > and to add a control bit to disable recording (MMCRA[BHRBRD]).
> > > 
> > > Version 3 of this series disables branch recording on P8 and P9
> > > due
> > > to a drop in performance caused by recording branches outside of
> > > problem state.
> > 
> > Thanks for these, they all look good to me.
> > 
> > With P10 CPU, Linux perf branch recording appears to work with this
> > series, and I confirmed that Linux does disable BHRB in MMCRA at
> > boot, so it should not take the performance hit.
> > 
> > It had a couple of compile bugs, no matter I fixed them, but I
> > often
> > trip overppc32 and user-mode when working on TCG too, so building
> > with --target-list including ppc64-softmmu,ppc-softmmu,
> > ppc64-linux-user,ppc64le-linux-user,ppc-linux-user is good to catch
> > those.
> > 
> > Thanks,
> > Nick
> > 
> 
> Thanks, Nick.  I'll have to remember that for next time!
> 
> Glenn
> 

Hi Nick,

Is there anything else you need me to do for this series to be merged?

Thanks,

Glenn

> > > Glenn Miles (4):
> > >   target/ppc: Add new hflags to support BHRB
> > >   target/ppc: Add recording of taken branches to BHRB
> > >   target/ppc: Add clrbhrb and mfbhrbe instructions
> > >   target/ppc: Add migration support for BHRB
> > > 
> > >  target/ppc/cpu.h                       |  24 ++++++
> > >  target/ppc/cpu_init.c                  |  39 +++++++++-
> > >  target/ppc/helper.h                    |   5 ++
> > >  target/ppc/helper_regs.c               |  35 +++++++++
> > >  target/ppc/insn32.decode               |   8 ++
> > >  target/ppc/machine.c                   |  23 +++++-
> > >  target/ppc/misc_helper.c               |  46 +++++++++++
> > >  target/ppc/power8-pmu-regs.c.inc       |   5 ++
> > >  target/ppc/power8-pmu.c                |  48 +++++++++++-
> > >  target/ppc/power8-pmu.h                |  11 ++-
> > >  target/ppc/spr_common.h                |   1 +
> > >  target/ppc/translate.c                 | 101
> > > +++++++++++++++++++++++--
> > >  target/ppc/translate/bhrb-impl.c.inc   |  43 +++++++++++
> > >  target/ppc/translate/branch-impl.c.inc |   2 +-
> > >  14 files changed, 374 insertions(+), 17 deletions(-)
> > >  create mode 100644 target/ppc/translate/bhrb-impl.c.inc


