Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D607D591D
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:48:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKa8-0000Yo-12; Tue, 24 Oct 2023 12:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qvKa1-0000YV-Ru; Tue, 24 Oct 2023 12:48:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qvKZy-0008TB-Gh; Tue, 24 Oct 2023 12:48:31 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OGKJZH011342; Tue, 24 Oct 2023 16:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=gN3K+XCQl2fI8uXwENAhWbhUMg0JJzfzVmdUmWnYSYs=;
 b=sRX0WNDNTzMCh96ZzWMFB/ncgBckRUSses1NQ6lOIq1JxWloRt5u3Iz4fbrOT4pQDv+3
 M+GPa20K8eJZ/BUcqDjTd9m9wUgtVoKFQanWwJpKeonKUK828JYcOvg1AfQ7GGWsAEN8
 xRVHFmJ0ItLdQFY1Qn1ERfDXEqHflParigBnV7HJY0VcVfneFTgVNyKr5P+fwwhL8z3/
 y0j5Mx1Dl3bKRKAYKJRsFVYfgjMeCHeuYQ1Y4aS+W6HhYN8f31rDpZx4DgTd+8yEF7sP
 rHY5BG5qa0a42B2rwfmSZpJU1pHaR5peT4+pWpvY3puI6RflZb68thxEDuBiNGXTicgu 3w== 
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txhbs15da-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 16:48:14 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OFLljS012387; Tue, 24 Oct 2023 16:48:13 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tvup1rd0a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 16:48:13 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39OGmCeo33489424
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Oct 2023 16:48:13 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 91D9F58054;
 Tue, 24 Oct 2023 16:48:12 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B7A45805D;
 Tue, 24 Oct 2023 16:48:12 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Oct 2023 16:48:12 +0000 (GMT)
Message-ID: <84497c0ac05f830879745ab4916cb5357a31a09d.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 3/3] misc/pca9552: Only update output GPIOs if state
 changed
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, philmd@linaro.org
Date: Tue, 24 Oct 2023 11:48:11 -0500
In-Reply-To: <7ba3d0298be8edbfbbc16882aa17fa38e70662be.camel@codeconstruct.com.au>
References: <20231020182321.163109-1-milesg@linux.vnet.ibm.com>
 <20231020182321.163109-4-milesg@linux.vnet.ibm.com>
 <7ba3d0298be8edbfbbc16882aa17fa38e70662be.camel@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nTOuCaBGCp7zXXFL3GhYJKdtVB8AZpIM
X-Proofpoint-GUID: nTOuCaBGCp7zXXFL3GhYJKdtVB8AZpIM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_16,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 mlxscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310240144
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

On Tue, 2023-10-24 at 10:13 +1030, Andrew Jeffery wrote:
> On Fri, 2023-10-20 at 13:23 -0500, Glenn Miles wrote:
> > The pca9552 code was updating output GPIO states whenever
> > the pin state was updated even if the state did not change.
> > This commit adds a check so that we only update the GPIO
> > output when the pin state actually changes.
> 
> Given this is intertwined with patch 2/3 that adds the input mode
> capability, I think they should be squashed together?
> 

Sure, no problem.

> > Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> > ---
> > 
> > New commit in v2
> > 
> >  hw/misc/pca9552.c | 25 ++++++++++++++++++-------
> >  1 file changed, 18 insertions(+), 7 deletions(-)
> > 
> > diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
> > index ed814d1f98..4ed6903404 100644
> > --- a/hw/misc/pca9552.c
> > +++ b/hw/misc/pca9552.c
> > @@ -112,14 +112,15 @@ static void
> > pca955x_update_pin_input(PCA955xState *s)
> >  
> >      for (i = 0; i < k->pin_count; i++) {
> >          uint8_t input_reg = PCA9552_INPUT0 + (i / 8);
> > -        uint8_t input_shift = (i % 8);
> > +        uint8_t bit_mask = 1 << (i % 8);
> >          uint8_t config = pca955x_pin_get_config(s, i);
> > +        uint8_t old_value = s->regs[input_reg] & bit_mask;
> > +        uint8_t new_value;
> >  
> >          switch (config) {
> >          case PCA9552_LED_ON:
> >              /* Pin is set to 0V to turn on LED */
> > -            qemu_set_irq(s->gpio_out[i], 0);
> > -            s->regs[input_reg] &= ~(1 << input_shift);
> > +            s->regs[input_reg] &= ~bit_mask;
> >              break;
> >          case PCA9552_LED_OFF:
> >              /*
> > @@ -128,11 +129,9 @@ static void
> > pca955x_update_pin_input(PCA955xState *s)
> >               * external device drives it low.
> >               */
> >              if (s->ext_state[i] == PCA9552_PIN_LOW) {
> > -                qemu_set_irq(s->gpio_out[i], 0);
> > -                s->regs[input_reg] &= ~(1 << input_shift);
> > +                s->regs[input_reg] &= ~bit_mask;
> >              } else {
> > -                qemu_set_irq(s->gpio_out[i], 1);
> > -                s->regs[input_reg] |= 1 << input_shift;
> > +                s->regs[input_reg] |=  bit_mask;
> >              }
> >              break;
> >          case PCA9552_LED_PWM0:
> > @@ -141,6 +140,18 @@ static void
> > pca955x_update_pin_input(PCA955xState *s)
> >          default:
> >              break;
> >          }
> > +
> > +        /* update irq state only if pin state changed */
> > +        new_value = s->regs[input_reg] & bit_mask;
> > +        if (new_value != old_value) {
> > +            if (new_value) {
> > +                /* changed from 0 to 1 */
> > +                qemu_set_irq(s->gpio_out[i], 1);
> > +            } else {
> > +                /* changed from 1 to 0 */
> > +                qemu_set_irq(s->gpio_out[i], 0);
> > +            }
> 
> Slightly code-golf-y, but the inner if-else here may be compressed
> to:
> 
>     qemu_set_irq(s->gpio_out[i], !!new_value);
> 
> Andrew

I like it!

Glenn


