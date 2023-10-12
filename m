Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAB87C79E6
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 00:41:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr4Ly-0001yP-Cc; Thu, 12 Oct 2023 18:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qr4Lw-0001xe-5V; Thu, 12 Oct 2023 18:40:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qr4Lt-00031J-N3; Thu, 12 Oct 2023 18:40:23 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CMbBhX012946; Thu, 12 Oct 2023 22:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=LFPDFB5uPtSrttVTtWne73CHAzHshQWzP3SnEmOqltI=;
 b=VEj69mDf30FVk2xGxnCP5ZmGyT0+rzW2pBvRnVMl4ARKC0HWYMHavQbHQTIyOvECslgX
 vybC0yT8E+A4LOnCS+Xb/s71ur5JuFacJbtayCyTZOnuGZubjG37R+3tVGp5zE2B9/+4
 BhcKWQKVcs7bUqktzSyjXLf8DCfnkE0Kwp3R4ycotKtA38gsVxWFHfHS9aq6o0TZByp8
 hnsBJQFig+cBg8Flz5vyFfy/pGGuubhmJIbQSbMIpCSfnK0umbRg6tzyoA4aHDtx4Rde
 kX7LQrdLJMvRCzQBhnYseXf8V4kAZNm/ANhS/Iu7nFZEmjFkr0qaUqEuDERXtWKT/R5Y wA== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpsm0899u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 22:40:05 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CLDsfm001239; Thu, 12 Oct 2023 22:40:04 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkkvkagef-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 22:40:04 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39CMe3MJ16843506
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Oct 2023 22:40:03 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BCE9A58062;
 Thu, 12 Oct 2023 22:40:03 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D96658052;
 Thu, 12 Oct 2023 22:40:03 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Oct 2023 22:40:03 +0000 (GMT)
Message-ID: <ff880c8ff240fc37e6af1f00e33fb7a60125ce45.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] misc/pca9552: Let external devices set pca9552 inputs
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: Joel Stanley <joel@jms.id.au>, =?ISO-8859-1?Q?C=E9dric?= Le Goater
 <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, andrew@codeconstruct.com.au
Date: Thu, 12 Oct 2023 17:40:03 -0500
In-Reply-To: <CACPK8XfLSBGJvV340SN3V442YgRNS3rHXSDGFeGAyx5r1wE-9A@mail.gmail.com>
References: <20231005204129.3522685-1-milesg@linux.vnet.ibm.com>
 <CACPK8XfLSBGJvV340SN3V442YgRNS3rHXSDGFeGAyx5r1wE-9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5i19c-eRuKwABkGvnaNMFETBybMNA6j6
X-Proofpoint-ORIG-GUID: 5i19c-eRuKwABkGvnaNMFETBybMNA6j6
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_14,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120190
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

On Tue, 2023-10-10 at 23:02 +1030, Joel Stanley wrote:
> On Fri, 6 Oct 2023 at 07:23, Glenn Miles <milesg@linux.vnet.ibm.com>
> wrote:
> > Allow external devices to drive pca9552 input pins by adding
> > input GPIO's to the model.  This allows a device to connect
> > its output GPIO's to the pca9552 input GPIO's.
> > 
> > In order for an external device to set the state of a pca9552
> > pin, the pin must first be configured for high impedance (LED
> > is off).  If the pca9552 pin is configured to drive the pin low
> > (LED is on), then external input will be ignored.
> 
> Does this let us use qom-set from the monitor, and have the guest see
> the state change?

Yes, as long as no other device is attached to the input gpio of the
device, it will behave the same as it did before this change.  The
behavior of the device only changes when an external device attaches
its output gpio to one of the pca9552's input gpio's and drives a
low voltage.  In that case, regardless of what is written to the LS0-
LS3 registers, the INPUT* bit for that pin will read as '0'.  This is
because (physically) pca9552 devices don't actually drive the voltage
high.  Instead, they set the output to "high impedance" and allow the
pin voltage to go wherever some external component (usually a pullup
resistor) takes it.  

> 
> An example in the commit message, or even better would be a test.
> 

I'm definitely open to providing a test.  Maybe the existing tests can
be added to?  I'm not sure if that environment allows for hooking up
some of the output gpio's of the pca9552 to some of the input gpios,
but I can look into it.

My testing so far has been more of an integrated test that has an I2C
master connected to an I2C bus with a couple of pca9552 devices hanging
off of that, but it's very specific to the powernv platform.

 
> Some other comments below.
> 
> > Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> > ---
> > Based-on: <20230927203221.3286895-1-milesg@linux.vnet.ibm.com>
> > ([PATCH] misc/pca9552: Fix inverted input status)
> >  hw/misc/pca9552.c         | 39 ++++++++++++++++++++++++++++++++++-
> > ----
> >  include/hw/misc/pca9552.h |  3 ++-
> >  2 files changed, 36 insertions(+), 6 deletions(-)
> > 
> > diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
> > index ad811fb249..f28b5ecd7e 100644
> > --- a/hw/misc/pca9552.c
> > +++ b/hw/misc/pca9552.c
> > @@ -113,16 +113,22 @@ static void
> > pca955x_update_pin_input(PCA955xState *s)
> >          switch (config) {
> >          case PCA9552_LED_ON:
> >              /* Pin is set to 0V to turn on LED */
> > -            qemu_set_irq(s->gpio[i], 0);
> > +            qemu_set_irq(s->gpio_out[i], 0);
> >              s->regs[input_reg] &= ~(1 << input_shift);
> >              break;
> >          case PCA9552_LED_OFF:
> >              /*
> >               * Pin is set to Hi-Z to turn off LED and
> > -             * pullup sets it to a logical 1.
> > +             * pullup sets it to a logical 1 unless
> > +             * external device drives it low.
> >               */
> > -            qemu_set_irq(s->gpio[i], 1);
> > -            s->regs[input_reg] |= 1 << input_shift;
> > +            if (s->ext_state[i] == 0) {
> > +                qemu_set_irq(s->gpio_out[i], 0);
> > +                s->regs[input_reg] &= ~(1 << input_shift);
> > +            } else {
> > +                qemu_set_irq(s->gpio_out[i], 1);
> > +                s->regs[input_reg] |= 1 << input_shift;
> > +            }
> >              break;
> >          case PCA9552_LED_PWM0:
> >          case PCA9552_LED_PWM1:
> > @@ -337,6 +343,7 @@ static const VMStateDescription pca9552_vmstate
> > = {
> >          VMSTATE_UINT8(len, PCA955xState),
> >          VMSTATE_UINT8(pointer, PCA955xState),
> >          VMSTATE_UINT8_ARRAY(regs, PCA955xState, PCA955X_NR_REGS),
> > +        VMSTATE_UINT8_ARRAY(ext_state, PCA955xState,
> > PCA955X_PIN_COUNT_MAX),
> >          VMSTATE_I2C_SLAVE(i2c, PCA955xState),
> >          VMSTATE_END_OF_LIST()
> >      }
> > @@ -355,6 +362,7 @@ static void pca9552_reset(DeviceState *dev)
> >      s->regs[PCA9552_LS2] = 0x55;
> >      s->regs[PCA9552_LS3] = 0x55;
> > 
> > +    memset(s->ext_state, 1, PCA955X_PIN_COUNT_MAX);
> >      pca955x_update_pin_input(s);
> > 
> >      s->pointer = 0xFF;
> > @@ -377,6 +385,26 @@ static void pca955x_initfn(Object *obj)
> >      }
> >  }
> > 
> > +static void pca955x_set_ext_state(PCA955xState *s, int pin, int
> > level)
> > +{
> > +    if (s->ext_state[pin] != level) {
> > +        uint16_t pins_status = pca955x_pins_get_status(s);
> > +        s->ext_state[pin] = level;
> > +        pca955x_update_pin_input(s);
> > +        pca955x_display_pins_status(s, pins_status);
> > +    }
> > +}
> > +
> > +static void pca955x_gpio_in_handler(void *opaque, int pin, int
> > level)
> > +{
> > +
> > +    PCA955xState *s = PCA955X(opaque);
> > +    PCA955xClass *k = PCA955X_GET_CLASS(s);
> > +
> > +    assert((pin >= 0) && (pin < k->pin_count));
> > +    pca955x_set_ext_state(s, pin, level);
> > +}
> > +
> >  static void pca955x_realize(DeviceState *dev, Error **errp)
> >  {
> >      PCA955xClass *k = PCA955X_GET_CLASS(dev);
> > @@ -386,7 +414,8 @@ static void pca955x_realize(DeviceState *dev,
> > Error **errp)
> >          s->description = g_strdup("pca-unspecified");
> >      }
> > 
> > -    qdev_init_gpio_out(dev, s->gpio, k->pin_count);
> > +    qdev_init_gpio_out(dev, s->gpio_out, k->pin_count);
> > +    qdev_init_gpio_in(dev, pca955x_gpio_in_handler, k->pin_count);
> >  }
> > 
> >  static Property pca955x_properties[] = {
> > diff --git a/include/hw/misc/pca9552.h b/include/hw/misc/pca9552.h
> > index b6f4e264fe..c36525f0c3 100644
> > --- a/include/hw/misc/pca9552.h
> > +++ b/include/hw/misc/pca9552.h
> > @@ -30,7 +30,8 @@ struct PCA955xState {
> >      uint8_t pointer;
> > 
> >      uint8_t regs[PCA955X_NR_REGS];
> > -    qemu_irq gpio[PCA955X_PIN_COUNT_MAX];
> > +    qemu_irq gpio_out[PCA955X_PIN_COUNT_MAX];
> 
> I wondered if the renaming of gpio to gpio_out could be a separate
> patch, but once I'd read the entire patch it made sense, so don't
> bother.
> 
> I think Cédric has some magic for sorting the header file changes at
> the start of the diff output. Here it is:
> 
> https://gitlab.com/qemu-project/qemu/-/blob/master/scripts/git.orderfile?ref_type=heads
> 
> We should add that to the tips and tricks part of
> docs/devel/submitting-a-patch.rst
> 

Ok, I'll try to remember this for future work.  Thanks!

> > +    uint8_t ext_state[PCA955X_PIN_COUNT_MAX];
> 
> State is 0 or 1, representing driving the pin low, or high impedance?
> I think some #defines or enums would make the states clearer.
> 

Ok, I can certainly do that.

Thanks for the review!

Glenn

> >      char *description; /* For debugging purpose only */
> >  };
> > 
> > --
> > 2.31.1
> > 
> > 


