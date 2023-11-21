Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D59407F35FC
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 19:32:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5VX7-000066-NZ; Tue, 21 Nov 2023 13:31:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r5VWw-000056-NE; Tue, 21 Nov 2023 13:31:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r5VWr-00045A-9O; Tue, 21 Nov 2023 13:31:25 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ALIIqOH029871; Tue, 21 Nov 2023 18:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=kNJj3wZh9y/EfJ79p+8CRnKOKl3ngOsq59DOYgmXHQ8=;
 b=WA+tv49Ob0suz30sD75pPC5nJKZJWSLI0aGb8d/jKmFVk4CZk+Icn2m/QyLa1KviQoQ3
 bd2qZBzYBqwdGHEHlqwvOZutHVfI568Gn3RAgUMhN25VJ4YNvyavYQRcXsS2zSzhbWJw
 q7pTviVxPuzoka5qRs9+pLR8TegzY5MOjuzOANqQcYc02wZjuLtXs5Hqj784HxBu+Or/
 UM75d2o+/QeppY3oVrqrRdf9R6foLTNg93zh0xMeI6tCYT060SUCbUoKs4PuyhOKgxp5
 JERj/cpytX7gusecQ3mLO3jrQ3uI+qDh6V7n7cXXCn9ymPtu9q41FpFZb29W4S53Nwrz PA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh1q98afc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 18:31:18 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ALIImOe029798;
 Tue, 21 Nov 2023 18:31:17 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh1q98af0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 18:31:17 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ALIPQVw010313; Tue, 21 Nov 2023 18:31:17 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf9tkaa2n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 18:31:17 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3ALIVGJB20513402
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Nov 2023 18:31:16 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D18F5805E;
 Tue, 21 Nov 2023 18:31:16 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6815E58056;
 Tue, 21 Nov 2023 18:31:16 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Nov 2023 18:31:16 +0000 (GMT)
Message-ID: <e84a56ac411148563f3738ff44af0843de430012.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 03/11] ppc/pnv: New powernv10-rainier machine type
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Nicholas Piggin
 <npiggin@gmail.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat <fbarrat@linux.ibm.com>
Date: Tue, 21 Nov 2023 12:31:16 -0600
In-Reply-To: <915bf0d2-4600-4666-95a5-752fbb9f034f@kaod.org>
References: <20231120235112.1951342-1-milesg@linux.vnet.ibm.com>
 <20231120235112.1951342-4-milesg@linux.vnet.ibm.com>
 <CX43Q4CXT43G.16NTWUAWGGXCB@wheely>
 <31af40b3-a6c8-467c-8ef0-63e370465a9a@kaod.org>
 <2e0854faea5c520512f903420f91f153e3287532.camel@linux.vnet.ibm.com>
 <915bf0d2-4600-4666-95a5-752fbb9f034f@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZFT_wlMNob9GaWjoBaA9-uR5UYlPUgOQ
X-Proofpoint-ORIG-GUID: Nd3nbEg15pAZCR1K1D5QMGDWcrEqvmG6
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_10,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=558 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311210145
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

On Tue, 2023-11-21 at 19:26 +0100, Cédric Le Goater wrote:
> On 11/21/23 17:36, Miles Glenn wrote:
> > On Tue, 2023-11-21 at 08:29 +0100, Cédric Le Goater wrote:
> > > On 11/21/23 02:33, Nicholas Piggin wrote:
> > > > On Tue Nov 21, 2023 at 9:51 AM AEST, Glenn Miles wrote:
> > > > > Create a new powernv machine type, powernv10-rainier, that
> > > > > will contain rainier-specific devices.
> > > > 
> > > > Is the plan to have a base powernv10 common to all and then
> > > > powernv10-rainier looks like a Rainier? Or would powernv10
> > > > just be a rainier?
> > > > 
> > > > It's fine to structure code this way, I'm just wondering about
> > > > the machine types available to user. Is a base powernv10
> > > > machine
> > > > useful to run?
> > > 
> > > There are multiple P10 boards defined in Linux :
> > > 
> > >     aspeed-bmc-ibm-bonnell.dts
> > >     aspeed-bmc-ibm-everest.dts
> > >     aspeed-bmc-ibm-rainier-1s4u.dts
> > >     aspeed-bmc-ibm-rainier-4u.dts
> > >     aspeed-bmc-ibm-rainier.dts
> > > 
> > > and we could model the machines above with a fixed number of
> > > sockets.
> > > The "powernv10" would be the generic system that can be
> > > customized
> > > at will on the command line, even I2C devices. There is also the
> > > P10 Denali which is FSP based. This QEMU machine would certainly
> > > be
> > > very different. I thought of doing the same for P9 with a -zaius
> > > and include NPU2 models for it. I lacked time and the interest
> > > was
> > > small at the time of OpenPOWER.
> > > 
> > > Anyhow, adding a new machine makes sense and it prepares ground
> > > for
> > > possible new ones. I am OK with or without. As primary users, you
> > > are
> > > the ones that can tell if there will be a second machine.
> > >    
> > > Thanks,
> > > 
> > > C.
> > > 
> > 
> > I am not sure what the powernv10 machine would be used for.  The
> > only reason I kept it was because I didn't want to break anyone out
> > there that might be using it.
> (previous email sent to fast)
> 
> You would need to go through the deprecation process [1] if you want
> to remove the machine. I suggest keeping it for now since it is two
> lines of type definition.
> 

Yes, I agree.

> > My preference would have been to just make powernv10-rainier an
> > alias of the powernv10 machine, but only one alias name per machine
> > is supported and there is already a plan to make "powernv" an
> > alias for the powernv10 machine.
> 
> yes. It might be time now for PowerNV and pSeries to update the
> default processor. Let's address that in the QEMU 9.0 cycle.
> 
> Thanks,
> 
> C.
> 
> [1] https://qemu.readthedocs.io/en/v8.1.0/about/deprecated.html
> 

Sounds good, thanks!

Glenn


