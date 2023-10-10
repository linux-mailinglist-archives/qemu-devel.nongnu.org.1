Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0327D7C4154
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 22:36:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqJSJ-0006XQ-1G; Tue, 10 Oct 2023 16:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qqJSH-0006Wt-1C; Tue, 10 Oct 2023 16:35:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qqJSD-0005TY-Uk; Tue, 10 Oct 2023 16:35:48 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39AKZ0oa026027; Tue, 10 Oct 2023 20:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=qjfj0t9qeQ9Ux8rmIPqzvJVhFeongM+ztnhWQ98ZezQ=;
 b=lbVMmrZKnPfYzlzuPu2lwkC6vNnSzY/dqzPbuGRNNywrEIzvGjHlckSDGsbjDi369Ymk
 OJoWT994xehUq4O9TmlFXwQ0L0WaUkrIPMZLLvFydgXG381HrIjNgazAIcwO/MoTNpCp
 lfaZy3dOqM+2duf0n1Yh4HPckOMTw0fcpgb9W8bW1e8WABXG3FQH8cleNFm1vhmjAa/t
 Vq6T6icPxR8OmmsBTar2M+u16QI91q6htl+BA/l1pCwZ6QYKZcxGe/OGOU4YbmWjGZ8C
 ApQDvAmhwbcZzjaXlXQzzV2Ebd19TYnH9SKvhHxH51IUtSqJQOhw8tMzPsbT4jfeA/yf Ug== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tnds9g055-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Oct 2023 20:35:31 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39AKZURi027176;
 Tue, 10 Oct 2023 20:35:30 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tnds9g04v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Oct 2023 20:35:30 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39AIqrTf023106; Tue, 10 Oct 2023 20:35:29 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkmc1jeg3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Oct 2023 20:35:29 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39AKZTHR20251186
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Oct 2023 20:35:29 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 64E1358058;
 Tue, 10 Oct 2023 20:35:29 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 276A058059;
 Tue, 10 Oct 2023 20:35:29 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Oct 2023 20:35:29 +0000 (GMT)
Message-ID: <1fcb9e1820b2ca5c5e6b84d7186c328c1df426e8.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] misc/pca9552: Fix for pca9552 not getting reset
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, clg@kaod.org, clegoate@redhat.com,
 andrew@codeconstruct.com.au, joel@jms.id.au
Date: Tue, 10 Oct 2023 15:35:28 -0500
In-Reply-To: <57112a6f-2624-4bd5-b301-cd28cb197771@ilande.co.uk>
References: <20231010195209.264757-1-milesg@linux.vnet.ibm.com>
 <57112a6f-2624-4bd5-b301-cd28cb197771@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: t0FAbxnPc_S46NKpP7Fp0gSa1muG_4yd
X-Proofpoint-GUID: EqZEx2RV4WKdO_HvovzTJyBYo1fcNr7H
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_16,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310100159
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

On Tue, 2023-10-10 at 21:31 +0100, Mark Cave-Ayland wrote:
> On 10/10/2023 20:52, Glenn Miles wrote:
> 
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
> 
> The reason that the reset function isn't being called here is because
> TYPE_I2C_SLAVE 
> is derived from TYPE_DEVICE, and for various historical reasons the
> DeviceClass reset 
> function is only called for devices that inherit from
> TYPE_SYS_BUS_DEVICE.
> 
> Probably the best way to make this work instead of mixing up the
> reset and realize 
> parts of the object lifecycle is to convert pca9552_reset() to use
> the new Resettable 
> interface for TYPE_PCA9552: take a look at commit d43e967f69 ("q800-
> glue.c: convert 
> to Resettable interface") as an example, along with the documentation
> at 
> https://www.qemu.org/docs/master/devel/reset.html.
> 

Ahh, that's very helpful.  Thanks, Mark!

-Glenn

> 
> ATB,
> 
> Mark.
> 


