Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 739E47C4140
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 22:30:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqJMp-0004Dq-Ni; Tue, 10 Oct 2023 16:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qqJMn-0004D2-Hj; Tue, 10 Oct 2023 16:30:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qqJMj-0004Dj-OI; Tue, 10 Oct 2023 16:30:08 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39AKRQ2I021909; Tue, 10 Oct 2023 20:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=8hZ4Vn3vv8h30bpdJC4Seb8RnBeknzoTOfHirRo2qLI=;
 b=ShVAr6zElkONq5HxWizlfjJ2ke4mA/HxDGT4TYlhBx0Mw6nzqsvfvKWJzhrrf4QiyYC9
 uaj4idl99cRvBYjsbbJQjw2MLblBDDcwOOSW9vax0XaXH0x0MksJdgf2ZtyuoqBuz0ta
 QPAzKKWZyBIzVNC9ZWj9MCrMMQO1glPSPbYdAcJIa5tOEAH7AD/w9hLQxIqZu71aTNHV
 K+X2pZ3w3D9wfj1my96fL5XM+Fc3u4qtagO0CmFClil/vKT1ssGpzZdgl6O5tCazO7dR
 n3pWxakBec+L/LjSbS6TaxT2H0RROeOt4SRJAikUfq1J+zfmWwMSuS+1xgFD0rIU/wNg 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tndnkr55t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Oct 2023 20:29:54 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39AKS0UF024284;
 Tue, 10 Oct 2023 20:29:54 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tndnkr4me-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Oct 2023 20:29:46 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39AIqrPf023106; Tue, 10 Oct 2023 20:29:37 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkmc1jcpm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Oct 2023 20:29:37 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39AKTaeX23986806
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Oct 2023 20:29:36 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C95258050;
 Tue, 10 Oct 2023 20:29:36 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D711C58054;
 Tue, 10 Oct 2023 20:29:35 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Oct 2023 20:29:35 +0000 (GMT)
Message-ID: <31534e6ca58ac8dca18bd33e3bc65b378ca77c85.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] misc/pca9552: Fix for pca9552 not getting reset
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clegoate@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, clg@kaod.org, andrew@codeconstruct.com.au,
 joel@jms.id.au
Date: Tue, 10 Oct 2023 15:29:35 -0500
In-Reply-To: <6c98452a-f46e-2f93-aae7-b060ed4f400b@redhat.com>
References: <20231010195209.264757-1-milesg@linux.vnet.ibm.com>
 <6c98452a-f46e-2f93-aae7-b060ed4f400b@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: T-eCFZiNPnP_mF7UGxiUm3GstE_rDTCH
X-Proofpoint-GUID: FnPkTgFnZtHoYu4V7qV7cQxSYQQKU1Mg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_16,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 adultscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100159
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

On Tue, 2023-10-10 at 21:58 +0200, Cédric Le Goater wrote:
> On 10/10/23 21:52, Glenn Miles wrote:
> > Testing of the pca9552 device on the powernv platform
> > showed that the reset method was not being called when
> > an instance of the device was realized.  This was causing
> > the INPUT0/INPUT1 POR values to be incorrect.
> > 
> > Fixed by overriding the parent pca955x_realize method with a
> > new pca9552_realize method which first calls
> > the parent pca955x_realize method followed by the
> > pca9552_reset function.
> > 
> > Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> > ---
> 
> It is good practice to include a changelog after '---'

Ok, thanks.  I'll remember that for next time!

> 
> 
> >   hw/misc/pca9552.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> > 
> > diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
> > index fff19e369a..4e183cc554 100644
> > --- a/hw/misc/pca9552.c
> > +++ b/hw/misc/pca9552.c
> > @@ -384,6 +384,12 @@ static void pca955x_realize(DeviceState *dev,
> > Error **errp)
> >       qdev_init_gpio_out(dev, s->gpio, k->pin_count);
> >   }
> >   
> > +static void pca9552_realize(DeviceState *dev, Error **errp)
> > +{
> > +    pca955x_realize(dev, errp);
> > +    pca9552_reset(dev);
> > +}
> 
> I don't see any change from v2.

The change from v2 can be seen below here where I added back the
line for setting the dc->reset method, which was removed in v2.

Perhaps I misunderstood what you meant by "You need both handlers, a
realize and a reset"?  You can see below that both the reset and the
realize methods are being initialized.  Are you taking issue with the
realize function calling the reset function?  I did this because in
my testing I noticed that reset was not getting called at any point.
Is the reset function supposed to get called automatically during
device realization?  It does not seem to be happening.

Thanks,

Glenn


> 
> Thanks,
> 
> C.
> 
> > +
> >   static Property pca955x_properties[] = {
> >       DEFINE_PROP_STRING("description", PCA955xState, description),
> >       DEFINE_PROP_END_OF_LIST(),
> > @@ -417,6 +423,7 @@ static void pca9552_class_init(ObjectClass *oc,
> > void *data)
> >       PCA955xClass *pc = PCA955X_CLASS(oc);
> >   
> >       dc->reset = pca9552_reset;
> > +    dc->realize = pca9552_realize;
> >       dc->vmsd = &pca9552_vmstate;
> >       pc->max_reg = PCA9552_LS3;
> >       pc->pin_count = 16;


