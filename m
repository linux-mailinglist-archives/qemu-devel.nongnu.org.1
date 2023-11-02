Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E827DF827
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 17:58:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyb0J-0000fY-NR; Thu, 02 Nov 2023 12:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qyb0D-0000f9-JG; Thu, 02 Nov 2023 12:57:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qyb0A-0002kW-QI; Thu, 02 Nov 2023 12:57:04 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A2GbLJS009675; Thu, 2 Nov 2023 16:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=7VApvm31EkEAnvQ9289OO3KoHRTnmOsqMQAncj5yW4U=;
 b=hknUg4r1e5y4ncGV0LuQHp859nvpiXmvz1rq2x2fQ33LA91pFNkVr8/KPnYWAMN4Dq2z
 EkJ1ZeksL1OP7NZ1ityU47ieY0v82PzOU1u8Dk1dTeWwZj20Mz2Wo3ZynXXNdDam/gMJ
 MzGZlxXu7OBFME7J6NgZSjcugbNC1L9dV07MRfk8emjAOLMTTSKawxTT1obQ8FrGRaUm
 S/QSxlvuvRXs/f+3WRf1A4yKaZ/tWAz6l7jg8L2KgbUB6561gPMOnK9lK/SXVlDhX+BF
 8GrQ6s5p2BxV1LoqMSBJawJqVepDyyzM2Kxrpr7LZnZDpw5DAHvxdTinYxq8R7tvtEKB KQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u4fesrd87-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Nov 2023 16:56:51 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A2GuDBE004202;
 Thu, 2 Nov 2023 16:56:50 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u4fesrd7q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Nov 2023 16:56:50 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A2FnAwE011608; Thu, 2 Nov 2023 16:56:49 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u1e4m7up8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Nov 2023 16:56:49 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A2GumY631326868
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Nov 2023 16:56:48 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6150E58058;
 Thu,  2 Nov 2023 16:56:48 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EBEFF58059;
 Thu,  2 Nov 2023 16:56:47 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Nov 2023 16:56:47 +0000 (GMT)
Message-ID: <6c3fe8555bab6c6268a3638d08990825affdb03d.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 RESEND] ppc/pnv: Fix number of I2C engines and ports
 for power9/10
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, fbarrat@linux.ibm.com
Date: Thu, 02 Nov 2023 11:56:42 -0500
In-Reply-To: <7f6df257-21d2-531a-3bdd-684336200698@linaro.org>
References: <20231024212944.34043-1-milesg@linux.vnet.ibm.com>
 <8400292d-0098-432a-a49b-ac658264c3ff@kaod.org>
 <7f6df257-21d2-531a-3bdd-684336200698@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9vnOxanH94P4mb1ycYU5tjJBk5GUYekI
X-Proofpoint-GUID: qRWla1n9lhkfd5LvpExyCdhCu8-z0TeD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_07,2023-11-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=954 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311020139
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On Fri, 2023-10-27 at 07:05 +0200, Philippe Mathieu-Daudé wrote:
> On 25/10/23 08:56, Cédric Le Goater wrote:
> > On 10/24/23 23:29, Glenn Miles wrote:
> > > Power9 is supposed to have 4 PIB-connected I2C engines with the
> > > following number of ports on each engine:
> > > 
> > >      0: 2
> > >      1: 13
> > >      2: 2
> > >      3: 2
> > > 
> > > Power10 also has 4 engines but has the following number of ports
> > > on each engine:
> > > 
> > >      0: 14
> > >      1: 14
> > >      2: 2
> > >      3: 16
> > > 
> > > Current code assumes that they all have the same (maximum)
> > > number.
> > > This can be a problem if software expects to see a certain number
> > > of ports present (Power Hypervisor seems to care).
> > > 
> > > Fixed this by adding separate tables for power9 and power10 that
> > > map the I2C controller number to the number of I2C buses that
> > > should
> > > be attached for that engine.
> > > 
> > > Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> > 
> > you could have kept :
> > 
> > Reviewed-by: Cédric Le Goater <clg@kaod.org>
> > 
> > one comment below,
> > 
> > > ---
> > > Based-on: <20231017221434.810363-1-milesg@linux.vnet.ibm.com>
> > > ([PATCH] ppc/pnv: Connect PNV I2C controller to powernv10)
> > > 
> > > Changes from v1:
> > >      - Added i2c_ports_per_engine to PnvChipClass
> > >      - replaced the word "ctlr" with "engine"
> > > 
> > >   hw/ppc/pnv.c              | 14 ++++++++++----
> > >   include/hw/ppc/pnv_chip.h |  6 ++----
> > >   2 files changed, 12 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > > index 2655b6e506..f6dc84b869 100644
> > > --- a/hw/ppc/pnv.c
> > > +++ b/hw/ppc/pnv.c
> > > @@ -1507,6 +1507,8 @@ static void
> > > pnv_chip_power9_pec_realize(PnvChip 
> > > *chip, Error **errp)
> > >       }
> > >   }
> > > +static int pnv_power9_i2c_ports_per_engine[PNV9_CHIP_MAX_I2C] =
> > > {2, 
> > > 13, 2, 2};
> > > +
> > 
> > Generally, these class constants are located close to the class
> > definitions
> > in the file.
> 
> Either keep them close by for comparison, or, since there
> is a single use, declare it in the function using it here 
> pnv_chip_power9_class_init().

Yeah, I agree.  Version 3 of this patch places the arrays inside the
functions that use them.

Thanks,

Glenn
> 
> > Thanks,
> > 
> > C.


