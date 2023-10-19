Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1307D00A2
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 19:33:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtWtO-0001Dh-Da; Thu, 19 Oct 2023 13:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qtWtL-0001DD-8a; Thu, 19 Oct 2023 13:33:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qtWtI-0008Og-Ud; Thu, 19 Oct 2023 13:33:03 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JHWMJx021432; Thu, 19 Oct 2023 17:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=o4797rM2y04/gx5ueCctKYcAheQnPm/+5yq/T523kwE=;
 b=W3l5IItrowkQIO6H2hNqRhqm7A2oKUbqH1xU69uno1M6US7A4/vx40ekTtBUN5WWoVsN
 NQC1V2wjULQlxgC10EjALX7UXM2mWeAch7Bphlcvxr2xqKH18KzLMnUTam8l9udUaj6m
 zUAEENUPpjII8rErNupspFTtaVEp7+WFku1/cc1+jAsWWjHUqMHNFQ0xhrLd77uOj+P/
 cxRyLOCu8gbcejvTYVyUycPKXIMWDdsNmsW9vm2ar/85odtwxc9fzXwku4kW6VERyxsY
 SDL3Z3Ps48VWChM8ms0XrvECcPkE1PwekHrl97CqE3O+f/0vxlJVQTGWAW3WtqPl/eUh rw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu8xmr0nx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 17:32:42 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39JHWXmL022724;
 Thu, 19 Oct 2023 17:32:42 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu8xmr0mx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 17:32:41 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JExVDU031142; Thu, 19 Oct 2023 17:32:41 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr7hk224g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 17:32:41 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39JHWePO14746180
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 17:32:40 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27A3D5805C;
 Thu, 19 Oct 2023 17:32:40 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A23585805A;
 Thu, 19 Oct 2023 17:32:39 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Oct 2023 17:32:39 +0000 (GMT)
Message-ID: <d5a7d9e8d01f2f1bf44df347017de884317e86d4.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] misc/pca9552: Fix for pca9552 not getting reset
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clegoate@redhat.com>, Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, clg@kaod.org, andrew@codeconstruct.com.au,
 joel@jms.id.au
Date: Thu, 19 Oct 2023 12:32:39 -0500
In-Reply-To: <4a6e370f-f966-8905-a4ec-338ea42da980@redhat.com>
References: <20231010195209.264757-1-milesg@linux.vnet.ibm.com>
 <57112a6f-2624-4bd5-b301-cd28cb197771@ilande.co.uk>
 <1fcb9e1820b2ca5c5e6b84d7186c328c1df426e8.camel@linux.vnet.ibm.com>
 <4a6e370f-f966-8905-a4ec-338ea42da980@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YeZXJ2Wz-kb65eO-YkROuGzc4oaqs0a-
X-Proofpoint-GUID: Ak7a1orneAw3g5f8sZhRsibYORRtsgHz
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_17,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190149
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

On Tue, 2023-10-10 at 22:41 +0200, Cédric Le Goater wrote:
> On 10/10/23 22:35, Miles Glenn wrote:
> > On Tue, 2023-10-10 at 21:31 +0100, Mark Cave-Ayland wrote:
> > > On 10/10/2023 20:52, Glenn Miles wrote:
> > > 
> > > > Testing of the pca9552 device on the powernv platform
> > > > showed that the reset method was not being called when
> > > > an instance of the device was realized.  This was causing
> > > > the INPUT0/INPUT1 POR values to be incorrect.
> > > > 
> > > > Fixed by overriding the parent pca955x_realize method with a
> > > > new pca9552_realize method which first calls
> > > > the parent pca955x_realize method followed by the
> > > > pca9552_reset function.
> > > > 
> > > > Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> > > > ---
> > > >    hw/misc/pca9552.c | 7 +++++++
> > > >    1 file changed, 7 insertions(+)
> > > > 
> > > > diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
> > > > index fff19e369a..4e183cc554 100644
> > > > --- a/hw/misc/pca9552.c
> > > > +++ b/hw/misc/pca9552.c
> > > > @@ -384,6 +384,12 @@ static void pca955x_realize(DeviceState
> > > > *dev,
> > > > Error **errp)
> > > >        qdev_init_gpio_out(dev, s->gpio, k->pin_count);
> > > >    }
> > > >    
> > > > +static void pca9552_realize(DeviceState *dev, Error **errp)
> > > > +{
> > > > +    pca955x_realize(dev, errp);
> > > > +    pca9552_reset(dev);
> > > > +}
> > > > +
> > > >    static Property pca955x_properties[] = {
> > > >        DEFINE_PROP_STRING("description", PCA955xState,
> > > > description),
> > > >        DEFINE_PROP_END_OF_LIST(),
> > > > @@ -417,6 +423,7 @@ static void pca9552_class_init(ObjectClass
> > > > *oc,
> > > > void *data)
> > > >        PCA955xClass *pc = PCA955X_CLASS(oc);
> > > >    
> > > >        dc->reset = pca9552_reset;
> > > > +    dc->realize = pca9552_realize;
> > > >        dc->vmsd = &pca9552_vmstate;
> > > >        pc->max_reg = PCA9552_LS3;
> > > >        pc->pin_count = 16;
> > > 
> > > The reason that the reset function isn't being called here is
> > > because
> > > TYPE_I2C_SLAVE
> > > is derived from TYPE_DEVICE, and for various historical reasons
> > > the
> > > DeviceClass reset
> > > function is only called for devices that inherit from
> > > TYPE_SYS_BUS_DEVICE.
> > > 
> > > Probably the best way to make this work instead of mixing up the
> > > reset and realize
> > > parts of the object lifecycle is to convert pca9552_reset() to
> > > use
> > > the new Resettable
> > > interface for TYPE_PCA9552: take a look at commit d43e967f69
> > > ("q800-
> > > glue.c: convert
> > > to Resettable interface") as an example, along with the
> > > documentation
> > > at
> > > https://www.qemu.org/docs/master/devel/reset.html.
> > > 
> > 
> > Ahh, that's very helpful.  Thanks, Mark!
> 
> yes. My bad, I didn't look close enough. Thanks Mark
> 
> C.
> 

Sorry, for the delay...

It's now looking like the problem was not in the pca9552 code, but in
some new pnv_i2c controller code.  I made the changes suggested above
and the pca9552 reset function still was not being called when
connected to a bus off of the pnv_i2c controller.  Howerver, I found
that when I start up an arm machine that uses the pca9552, the
pca9552_reset function (without any changes) is getting called.  If I
start up a ppc64 machine that uses the pca9552, through the pnv_i2c
controller, then the pca9552_reset function does not get called.  Also,
the buses connected to the pnv_i2c controller are not getting reset
either.  So, I'm thinking we're probably missing something in the
pnv_i2c code or one of the parent objects.  I'll drop this change and
start looking there.

Thanks,

Glenn


