Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AA47D591A
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:48:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKYx-0006q3-DE; Tue, 24 Oct 2023 12:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qvKYj-0006nO-2U; Tue, 24 Oct 2023 12:47:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qvKYg-00080D-4L; Tue, 24 Oct 2023 12:47:12 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OGeMU3022688; Tue, 24 Oct 2023 16:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=NSj/QeiNo4qnjm2oE/QWi0dd3BcRGz/97G7DCdUR5fg=;
 b=A0U061/YwkxU051ohkS7GDY3kDil+BjZ22fHtSjl951s0UY1AgxhWFJyl0lqCLR7dSRq
 C1n497yTFPhlNtjAsYB7vTNmw1HwQaSl61SRQDQmYqljXGCyPvQwXp2GdxKal9ZPVVS0
 GdvhtN/q6Y4xkEhPnToKgICq7bzbXlROvROhKDLbXvV0fBEejVsBrXmid6VGfWaF1dXh
 bLiw+SsvyQaWnG4w4hBiEGTVJTk0D76ZSDyFDYNQJ9SJtsPyMQ/dQP4IoGaXLAk6Ig8Y
 7g69IZrVR5zEOxHOND9ugGCAz5shDsPGPdp5kuLPBVNZN4jceec/DdjnH1RXsVPCg5Yw XA== 
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txhn3r955-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 16:46:47 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OFq10t023782; Tue, 24 Oct 2023 16:46:41 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tvryt14ts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 16:46:40 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39OGke5A27591416
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Oct 2023 16:46:40 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 417C65805B;
 Tue, 24 Oct 2023 16:46:40 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA89358055;
 Tue, 24 Oct 2023 16:46:39 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Oct 2023 16:46:39 +0000 (GMT)
Message-ID: <9175c6f7b980ec1790f297a1f81a8c184c70b1aa.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] misc/pca9552: Fix inverted input status
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, f4bug@amsat.org
Date: Tue, 24 Oct 2023 11:46:39 -0500
In-Reply-To: <47ec73eb44a8b5f5cd894f97d1e88677845cbd7a.camel@codeconstruct.com.au>
References: <20231019204011.3174115-1-milesg@linux.vnet.ibm.com>
 <20231019204011.3174115-2-milesg@linux.vnet.ibm.com>
 <e0f36ef6336df26d5c123c5861d6a779c94e3eb9.camel@codeconstruct.com.au>
 <01edf713-6bec-adec-5fa5-5195b5dd4273@linaro.org>
 <53fccc103ab72cfd93e98fd28bd0a869a43b6a83.camel@linux.vnet.ibm.com>
 <47ec73eb44a8b5f5cd894f97d1e88677845cbd7a.camel@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KDgOv5s4gu3YxqVuIMcDrUROpx15kNi9
X-Proofpoint-GUID: KDgOv5s4gu3YxqVuIMcDrUROpx15kNi9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_16,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
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

On Tue, 2023-10-24 at 10:04 +1030, Andrew Jeffery wrote:
> On Fri, 2023-10-20 at 11:32 -0500, Miles Glenn wrote:
> > On Fri, 2023-10-20 at 11:42 +0200, Philippe Mathieu-Daudé wrote:
> > > On 20/10/23 04:51, Andrew Jeffery wrote:
> > > > On Thu, 2023-10-19 at 15:40 -0500, Glenn Miles wrote:
> > > > > > The pca9552 INPUT0 and INPUT1 registers are supposed to
> > > > > > hold the logical values of the LED pins.  A logical 0
> > > > > > should be seen in the INPUT0/1 registers for a pin when
> > > > > > its corresponding LSn bits are set to 0, which is also
> > > > > > the state needed for turning on an LED in a typical
> > > > > > usage scenario.  Existing code was doing the opposite
> > > > > > and setting INPUT0/1 bit to a 1 when the LSn bit was
> > > > > > set to 0, so this commit fixes that.
> > > > > > 
> > > > > > Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> > > > > > ---
> > > > > > 
> > > > > > Changes from prior version:
> > > > > >      - Added comment regarding pca953X
> > > > > >      - Added cover letter
> > > > > > 
> > > > > >   hw/misc/pca9552.c          | 18 +++++++++++++-----
> > > > > >   tests/qtest/pca9552-test.c |  6 +++---
> > > > > >   2 files changed, 16 insertions(+), 8 deletions(-)
> > > > > > 
> > > > > > diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
> > > > > > index fff19e369a..445f56a9e8 100644
> > > > > > --- a/hw/misc/pca9552.c
> > > > > > +++ b/hw/misc/pca9552.c
> > > > > > @@ -36,7 +36,10 @@ typedef struct PCA955xClass
> > > > > > PCA955xClass;
> > > > > >   
> > > > > >   DECLARE_CLASS_CHECKERS(PCA955xClass, PCA955X,
> > > > > >                          TYPE_PCA955X)
> > > > > > -
> > > > > > +/*
> > > > > > + * Note:  The LED_ON and LED_OFF configuration values for
> > > > > > the
> > > > > > PCA955X
> > > > > > + *        chips are the reverse of the PCA953X family of
> > > > > > chips.
> > > > > > + */
> > > > > >   #define PCA9552_LED_ON   0x0
> > > > > >   #define PCA9552_LED_OFF  0x1
> > > > > >   #define PCA9552_LED_PWM0 0x2
> > > > > > @@ -112,13 +115,18 @@ static void
> > > > > > pca955x_update_pin_input(PCA955xState *s)
> > > > > >   
> > > > > >           switch (config) {
> > > > > >           case PCA9552_LED_ON:
> > > > > > -            qemu_set_irq(s->gpio[i], 1);
> > > > > > -            s->regs[input_reg] |= 1 << input_shift;
> > > > > > -            break;
> > > > > > -        case PCA9552_LED_OFF:
> > > > > > +            /* Pin is set to 0V to turn on LED */
> > > > > >               qemu_set_irq(s->gpio[i], 0);
> > > > > >               s->regs[input_reg] &= ~(1 << input_shift);
> > > > > >               break;
> > > > > > +        case PCA9552_LED_OFF:
> > > > > > +            /*
> > > > > > +             * Pin is set to Hi-Z to turn off LED and
> > > > > > +             * pullup sets it to a logical 1.
> > > > > > +             */
> > > > > > +            qemu_set_irq(s->gpio[i], 1);
> > > > > > +            s->regs[input_reg] |= 1 << input_shift;
> > > > > > +            break;
> > > > 
> > > > So the witherspoon-bmc machine was a user of the PCA9552
> > > > outputs as
> > > > LEDs. I guess its LEDs were in the wrong state the whole time?
> > > > That
> > > > looks like the only user though, and shouldn't be negatively
> > > > affected.
> > > 
> > > Usually GPIO polarity is a machine/board property, not a device
> > > one.
> > > 
> > > We could use the LED API (hw/misc/led.h) which initialize each
> > > output with GpioPolarity.
> > > 
> > 
> > Thanks for your comments!   This piqued my curiosity so I decided
> > to
> > run a test with the witherspoon-bmc machine.  Without my changes, I
> > ran
> > the following command to turn off LED13 on the pca9552 which I had
> > previously set to "on":
> > 
> >   qom-set /machine/unattached/device[18] led13 off
> > 
> > I had GDB connected at the time with a breakpoint set on
> > led_set_state() so that I could see what was happening.  Due to the
> > inversion bug, I expected the pca9552 code to set the pin low and
> > also
> > set the irq low, which it did.  The connected LED's on this pca9552
> > were all configured as GPIO_POLARITY_ACTIVE_LOW, so I expected that
> > setting the irq state low would actually turn on the LED.  Instead
> > it
> > turned off the LED.
> > 
> > Reviewing the LED code, I believe the problem lies here:
> > 
> > static void led_set_state_gpio_handler(void *opaque, int line, int
> > new_state)
> > {
> >     LEDState *s = LED(opaque);
> > 
> >     assert(line == 0);
> >     led_set_state(s, !!new_state != s->gpio_active_high);
> > }
> > 
> > 
> > In my test, new_state was 0 and gpio_active_high was 0, resulting
> > in
> > the boolean expression of ( 0 != 0 ) which is false and results in
> > turning off the LED.  So, this looks like a bug to me.
> > 
> > For another simpler example, if the LED polarity was set to
> > GPIO_POLARITY_ACTIVE_HIGH, then s->gpio_active_high would be
> > 1.  Then,
> > if we set the irq line to 1, wouldn't we expect the LED to turn
> > on? 
> > However, as the code stands, it would actually turn the LED
> > off.  So, I
> > think we can remove one of the "!"'s from in front of
> > new_state.  Then,
> > if the LED is active high and the irq line is set high, it would
> > turn
> > on the LED.  Correct?
> 
> Seems reasonable to me. Looks like Philippe added the LED behaviour
> in
> Fddb67f6402b8 ("hw/misc/led: Allow connecting from GPIO output"), so
> his input would be helpful. Perhaps send a fix for review?
> 
> Andrew

Sounds good.  I'll do that.

Glenn


