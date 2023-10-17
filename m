Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DFF7CCECA
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 22:53:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsr3d-0003E1-8N; Tue, 17 Oct 2023 16:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qsr3b-0003D1-2s; Tue, 17 Oct 2023 16:52:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qsr3Y-00062d-Da; Tue, 17 Oct 2023 16:52:50 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39HKh4nM012532; Tue, 17 Oct 2023 20:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=uUfFOgnK62rUbLUs588AGihprNGR6WraJCqwbvBlL7Q=;
 b=kKtZWZ8U9KMTAIJiArbozj/+LT/ZU72xIU5lQK6Ie5kvHhV/Yh2VqqLBq1pokgToJFGG
 bNjhAY7NOh7R58LxKFFuGw7p558Vtvk21wt59qIplfHl5yYu1P4O1N3Q9RjSbyJ9OFxq
 QjHU7i3memJhjSXVdBLx82NCEQ0infD+KpHKAD8aAMgJMltF6MTF2SsQDlXLjdbF3ACS
 WyA1XTZqJDJCJh7f2iwiT7OpUHCS0EBSxqCmwAh5nSe6LvqR6+21UXDgDxWh11Pp6CfO
 5A7Og0aOmznVLveQtPCdEUbfX0PZkyYZi/JP2NWpS6REvXcNN0MMVDYVhFhOyd7KDXM+ uA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tt15216k9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Oct 2023 20:52:37 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39HKh2of012251;
 Tue, 17 Oct 2023 20:52:36 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tt15216jy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Oct 2023 20:52:36 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39HKebw8027385; Tue, 17 Oct 2023 20:52:36 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr5asc0nt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Oct 2023 20:52:36 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39HKqZtr48955974
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Oct 2023 20:52:35 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A950258058;
 Tue, 17 Oct 2023 20:52:35 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 746F158057;
 Tue, 17 Oct 2023 20:52:35 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 17 Oct 2023 20:52:35 +0000 (GMT)
Message-ID: <6d1553ab505f13ab7553a6e1f4c45f965994bdca.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 0/2] Add PowerNV I2C Controller Model
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, fbarrat@linux.ibm.com,
 philmd@linaro.org
Date: Tue, 17 Oct 2023 15:52:35 -0500
In-Reply-To: <80d1a481-10bb-4d6c-82a5-418dff62880a@kaod.org>
References: <20231016222013.3739530-1-milesg@linux.vnet.ibm.com>
 <80d1a481-10bb-4d6c-82a5-418dff62880a@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cxmJ7TeE15lxD0bZ4ZYImSGBcbrspXuQ
X-Proofpoint-ORIG-GUID: sqQDN2252-DUU9AZPQfOBqAlzAYuAgWg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_03,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 adultscore=0 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=653 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170175
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

On Tue, 2023-10-17 at 09:01 +0200, Cédric Le Goater wrote:
> On 10/17/23 00:20, Glenn Miles wrote:
> > Upstreams the PowerNV I2C controller model originally
> > authored by Cédric Le Goater with minor changes by
> > myself to split the actual addition of the model from
> > wiring it up to a power processor model.
> > 
> > This series only attaches the controller to the powernv9
> > chip model, but is expected to eventually also be attached
> > to the powernv10 chip model.
> > 
> > Cédric Le Goater (2):
> >    ppc/pnv: Add an I2C controller model
> >    ppc/pnv: Connect I2C controller model to powernv9 chip
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> 
> Thanks for taking care of upstreaming Glenn. Waiting for the P10 part
> now !
> 
> C.

No problem!  Thanks for all of your help as well.

Glenn

> 
> 
> >   hw/ppc/meson.build         |   1 +
> >   hw/ppc/pnv.c               |  28 ++
> >   hw/ppc/pnv_i2c.c           | 697
> > +++++++++++++++++++++++++++++++++++++
> >   include/hw/ppc/pnv_chip.h  |   8 +
> >   include/hw/ppc/pnv_i2c.h   |  38 ++
> >   include/hw/ppc/pnv_xscom.h |   3 +
> >   6 files changed, 775 insertions(+)
> >   create mode 100644 hw/ppc/pnv_i2c.c
> >   create mode 100644 include/hw/ppc/pnv_i2c.h
> > 


