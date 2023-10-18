Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1267CE26B
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:12:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8xl-0003AB-99; Wed, 18 Oct 2023 12:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qt8xM-0002BP-Qd; Wed, 18 Oct 2023 11:59:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qt8xJ-0007lm-OG; Wed, 18 Oct 2023 11:59:36 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39IFgS32029092; Wed, 18 Oct 2023 15:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=0V83CKe6Sd7zhETMNUqpjPy8v8oq/BQbSFF0potQ20w=;
 b=fj05xqtWalwjeC4Yl85DFGs9Bjx+lOZzDce5BAIYuAMxDivFD7umcKRegKtiUgxYIpHg
 ohyIs4tqu+HrcFhHWyn1FUXE085KjN0WyCfnqo2xmevn84Peul6DY3fR9Q7D5gBpyGAb
 zr1bEFJiRE0Az8ge8hzuIg9z1TM/m6h65SVXg3NrG71/+QwJJpUOD+dVKRZosTfO0HKf
 21XRb36jrAr2FOp6ewgMiQWAwVsMFiEcHwVCmcqUt7r5ed7krErZL/ZiRqBGo9sahVax
 yx8UJYkdt8m11i0hl4qrekKQJv739OQII0Zw7J9n1vn5Ua+fPZbCdOrZzENvJAKdaJ/6 LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttj830scw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Oct 2023 15:59:26 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39IFgajc031376;
 Wed, 18 Oct 2023 15:59:25 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttj830sc5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Oct 2023 15:59:25 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39IE2Goo027385; Wed, 18 Oct 2023 15:59:24 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr5asj0uy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Oct 2023 15:59:24 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39IFxOIs37421326
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Oct 2023 15:59:24 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18C0A58055;
 Wed, 18 Oct 2023 15:59:24 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A34805804B;
 Wed, 18 Oct 2023 15:59:23 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 18 Oct 2023 15:59:23 +0000 (GMT)
Message-ID: <66558e7df3b0eadece637f452bfbf7add72955eb.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 0/4] Add BHRB Facility Support
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 18 Oct 2023 10:59:23 -0500
In-Reply-To: <CWBNQ9QDEYH8.3QL9E2V4ZF26G@wheely>
References: <20230925174351.617891-1-milesg@linux.vnet.ibm.com>
 <CWBNQ9QDEYH8.3QL9E2V4ZF26G@wheely>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IzlhHvNfW6EYm6oV5mQT4A4J_bWfmiAs
X-Proofpoint-GUID: aC6KqMqUERBnpQb0bhkCFhZeyh7LDKjg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_14,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1011 mlxscore=0
 impostorscore=0 spamscore=0 mlxlogscore=640 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180129
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On Thu, 2023-10-19 at 01:06 +1000, Nicholas Piggin wrote:
> On Tue Sep 26, 2023 at 3:43 AM AEST, Glenn Miles wrote:
> > This is a series of patches for adding support for the Branch
> > History
> > Rolling Buffer (BHRB) facility.  This was added to the Power ISA
> > starting with version 2.07.  Changes were subsequently made in
> > version
> > 3.1 to limit BHRB recording to instructions run in problem state
> > only
> > and to add a control bit to disable recording (MMCRA[BHRBRD]).
> > 
> > Version 3 of this series disables branch recording on P8 and P9 due
> > to a drop in performance caused by recording branches outside of
> > problem state.
> 
> Thanks for these, they all look good to me.
> 
> With P10 CPU, Linux perf branch recording appears to work with this
> series, and I confirmed that Linux does disable BHRB in MMCRA at
> boot, so it should not take the performance hit.
> 
> It had a couple of compile bugs, no matter I fixed them, but I often
> trip overppc32 and user-mode when working on TCG too, so building
> with --target-list including ppc64-softmmu,ppc-softmmu,
> ppc64-linux-user,ppc64le-linux-user,ppc-linux-user is good to catch
> those.
> 
> Thanks,
> Nick
> 

Thanks, Nick.  I'll have to remember that for next time!

Glenn

> > Glenn Miles (4):
> >   target/ppc: Add new hflags to support BHRB
> >   target/ppc: Add recording of taken branches to BHRB
> >   target/ppc: Add clrbhrb and mfbhrbe instructions
> >   target/ppc: Add migration support for BHRB
> > 
> >  target/ppc/cpu.h                       |  24 ++++++
> >  target/ppc/cpu_init.c                  |  39 +++++++++-
> >  target/ppc/helper.h                    |   5 ++
> >  target/ppc/helper_regs.c               |  35 +++++++++
> >  target/ppc/insn32.decode               |   8 ++
> >  target/ppc/machine.c                   |  23 +++++-
> >  target/ppc/misc_helper.c               |  46 +++++++++++
> >  target/ppc/power8-pmu-regs.c.inc       |   5 ++
> >  target/ppc/power8-pmu.c                |  48 +++++++++++-
> >  target/ppc/power8-pmu.h                |  11 ++-
> >  target/ppc/spr_common.h                |   1 +
> >  target/ppc/translate.c                 | 101
> > +++++++++++++++++++++++--
> >  target/ppc/translate/bhrb-impl.c.inc   |  43 +++++++++++
> >  target/ppc/translate/branch-impl.c.inc |   2 +-
> >  14 files changed, 374 insertions(+), 17 deletions(-)
> >  create mode 100644 target/ppc/translate/bhrb-impl.c.inc


