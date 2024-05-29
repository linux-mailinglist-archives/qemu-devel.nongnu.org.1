Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF628D39A4
	for <lists+qemu-devel@lfdr.de>; Wed, 29 May 2024 16:46:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCKZM-0007V1-Rw; Wed, 29 May 2024 10:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <namcao@linutronix.de>)
 id 1sCKZI-0007QH-R2
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:46:20 -0400
Received: from galois.linutronix.de ([193.142.43.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <namcao@linutronix.de>)
 id 1sCKZG-0003qZ-LN
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:46:20 -0400
Date: Wed, 29 May 2024 16:46:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1716993974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UdJryuivT7oBQG28J345Baw446DorrrrG8E6W5weLxM=;
 b=4ccrn2oPs0CR8EOP61g5rrg6ttGt+5KAWbDWDJFdq7rp2G17oI4xoU7OoQchMuGqcQ4xCz
 z49dj/rAAADq94gWp9zPGCDbHLr7gQd8E95Bz5swUrAPC2tfEYY+DT2VdZKYQro/w0YE78
 fsd/ndxQz8qaT/4aBq25lJl8mUsXA5X+UOGtUw0ORa8eTbjH39XoayHAAJenwhvOXXzvSq
 /buVN6GcEgkOhuMT/tIlWW01wIMkt4WgfsCOAeSG/kM3/8Yjp3qwuiaEMYJ3Z4cQ7HsIBg
 ceblc7dYHTtV4s20WCjXbR24nZvjnmuwRKfA1ICJcIyu4Ma2WYJaDq4xJnT5zQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1716993974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UdJryuivT7oBQG28J345Baw446DorrrrG8E6W5weLxM=;
 b=sZ6W9ZrzzB9aA9fYRkTQoIWzs1C92n7I2vL/kRMY9+VaSwQYmueVQE0TK3Fqt6jBurYb2s
 z0KCLyOIbtKAk9BQ==
From: Nam Cao <namcao@linutronix.de>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] pci-bridge/xio3130_downstream: fix invalid link speed
 and link width
Message-ID: <20240529144609.sg5p-ssg@linutronix.de>
References: <20240529132125.106790-1-namcao@linutronix.de>
 <fc0338d2-9a4d-4770-8a9c-c9e077415b29@linaro.org>
 <20240529141657.cGpjgEmN@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240529141657.cGpjgEmN@linutronix.de>
Received-SPF: pass client-ip=193.142.43.55; envelope-from=namcao@linutronix.de;
 helo=galois.linutronix.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, May 29, 2024 at 04:17:04PM +0200, Nam Cao wrote:
> On Wed, May 29, 2024 at 03:50:14PM +0200, Philippe Mathieu-Daud� wrote:
> > On 29/5/24 15:21, Nam Cao wrote:
> > > Set link width to x1 and link speed to 2.5 Gb/s as specified by the
> > > datasheet. Without this, these fields in the link status register read
> > > zero, which is incorrect.
> > > 
> > > This problem appeared since 3d67447fe7c2 ("pcie: Fill PCIESlot link fields
> > > to support higher speeds and widths"), which allows PCIe slot to set link
> > > width and link speed. However, if PCIe slot does not explicitly set these
> > > properties, they will be zero. Before this commit, the width and speed
> > > default to x1 and 2.5 Gb/s.
> > > 
> > > Fixes: 3d67447fe7c2 ("pcie: Fill PCIESlot link fields to support higher speeds and widths")
> > > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > > ---
> > >   hw/pci-bridge/xio3130_downstream.c | 8 ++++++++
> > >   1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
> > > index 38a2361fa2..d949431191 100644
> > > --- a/hw/pci-bridge/xio3130_downstream.c
> > > +++ b/hw/pci-bridge/xio3130_downstream.c
> > > @@ -172,10 +172,18 @@ static void xio3130_downstream_class_init(ObjectClass *klass, void *data)
> > >       device_class_set_props(dc, xio3130_downstream_props);
> > >   }
> > > +static void xio3130_downstream_instance_post_init(Object *obj)
> > > +{
> > > +    PCIESlot *s = PCIE_SLOT(obj);
> > > +    s->speed = QEMU_PCI_EXP_LNK_2_5GT;
> > > +    s->width = QEMU_PCI_EXP_LNK_X1;
> > 
> > - You ignore previous value and overwrite
> > - You don't warn the user about missing config value
> 
> Users cannot set speed/width for this device. At the moment, only PCI root
> port supports that.
> 
> It wouldn't make sense for users to set these properties nonetheless, these
> properties are fixed according to datasheet.
> 
> > Is post_init() the correct way to deal with that? Usually
> > this is done in realize(), where you can set *errp to
> > notify the user of invalid values.
> 
> I stole this from hw/pci-bridge/cxl_downstream.c and
> hw/pci-bridge/pcie_root_port.c. So I think it's correct.

Ah wait, now I read those files again, I think those devices do it this way
because they want to have default values.

For this case, I think you are right that realize() is the more suitable
place because I am not setting the default, I am setting the fixed values.

I can send a v2 with that change, unless you have other comments?

Best regards,
Nam

> I am new to QEMU code, so please tell me if you think this is not the best
> approach.
> 
> Best regards,
> Nam
> 

