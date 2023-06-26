Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA08B73E103
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:50:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDmbD-00031w-Ha; Mon, 26 Jun 2023 09:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDmb9-00031F-4j
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:49:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDmb7-0005EX-C0
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687787380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hSAWhaXGHZUMqmvsg+NtYt2jfS7W2nSwZSW7fiof4Xg=;
 b=QlHo0ti5frD5y8yBna3U2+zTdmp/hur7x2Z5HGiaHYJ3NQ9DlJXn8EQfDNIafjhNsRFRdF
 ydaSRIiNlzXwm5TActLRDgODSNWhDFuzmS2KXQwteqFFiWyIzxw9+GC1vJznOnTdvi1Wfd
 +K2ixgTl5X//TQ4A/LdgOYOfv0ooGzM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-ad2fVkTrNOOOJ0ybspojeQ-1; Mon, 26 Jun 2023 09:49:39 -0400
X-MC-Unique: ad2fVkTrNOOOJ0ybspojeQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f9bd5c7fdfso19043305e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 06:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687787378; x=1690379378;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hSAWhaXGHZUMqmvsg+NtYt2jfS7W2nSwZSW7fiof4Xg=;
 b=C0R8sfhECqmSAlk8xeRm7IXh9yHZXJDCaIkY+FZ49292L45BQcZn+TTNJBfjPXf14w
 d0IZ/7r37K1xNAz/CH82QUNJfbzJ7SN6WkTgYar4AzVWdM0nrR4JX4RGtD9TiR0ADLX3
 WIV2ydPhqP56Oh5DzKJThQezbbXXz4zAmhRm0O84maP5OC98f4eQP3QzrK0GR9SuNEJP
 EWkzJgmfVn0KwgGiP2+cAlx0tdbDa8meqAGvUTVYOOMI4k/Ibv7d1zRDEiHb7j6oTfuD
 oaK22FnoNGJiwvyxmzE6Hwg3yBY0/GVFadGnltECgX5/XWDAga4Y9KVeX7F7+fbu3EqW
 DKsg==
X-Gm-Message-State: AC+VfDz5eUdzHkSyYBoq7nu+cXliRuyFydXEpB/h0UR45xFPhFAmA/Vs
 zu6agk1ASVbfBpBiry46N1Sowm5cMtTwa/LgkV832sphBf0uysa+rSUX/YR3HoFyYVW/0Ircqku
 w85F9tTOANCMLbLI=
X-Received: by 2002:adf:f6d1:0:b0:30a:df2d:dff5 with SMTP id
 y17-20020adff6d1000000b0030adf2ddff5mr20519529wrp.55.1687787378388; 
 Mon, 26 Jun 2023 06:49:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4v9QQCobxxwq1qtjzw7uJgovszWDLGDir1JpNYT9ZexEVunvWMWHqFBmR4p3KnELGTPz+3mg==
X-Received: by 2002:adf:f6d1:0:b0:30a:df2d:dff5 with SMTP id
 y17-20020adff6d1000000b0030adf2ddff5mr20519519wrp.55.1687787378076; 
 Mon, 26 Jun 2023 06:49:38 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 v1-20020adfe281000000b00311299df211sm7480933wri.77.2023.06.26.06.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 06:49:37 -0700 (PDT)
Date: Mon, 26 Jun 2023 09:49:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PULL 30/53] hw/acpi: Fix PM control register access
Message-ID: <20230626094900-mutt-send-email-mst@kernel.org>
References: <cover.1687782442.git.mst@redhat.com>
 <3d563fc68732179b86eff2b87f2d7dbef150315f.1687782442.git.mst@redhat.com>
 <20230626152009.13c7b66a@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626152009.13c7b66a@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jun 26, 2023 at 03:20:09PM +0200, Igor Mammedov wrote:
> On Mon, 26 Jun 2023 08:29:19 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > From: BALATON Zoltan <balaton@eik.bme.hu>
> > 
> > On pegasos2 which has ACPI as part of VT8231 south bridge the board
> > firmware writes PM control register by accessing the second byte so
> > addr will be 1. This wasn't handled correctly and the write went to
> > addr 0 instead. Remove the acpi_pm1_cnt_write() function which is used
> > only once and does not take addr into account and handle non-zero
> > address in acpi_pm_cnt_{read|write}. This fixes ACPI shutdown with
> > pegasos2 firmware.
> > 
> > The issue below is possibly related to the same memory core bug.
> > 
> > Link: https://gitlab.com/qemu-project/qemu/-/issues/360
> > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > Message-Id: <20230607200125.A9988746377@zero.eik.bme.hu>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Somewhere you lost mine
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

You are right, sorry. fixed now.


> > ---
> >  hw/acpi/core.c | 56 +++++++++++++++++++++++++-------------------------
> >  1 file changed, 28 insertions(+), 28 deletions(-)
> > 
> > diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> > index 6da275c599..00b1e79a30 100644
> > --- a/hw/acpi/core.c
> > +++ b/hw/acpi/core.c
> > @@ -551,8 +551,35 @@ void acpi_pm_tmr_reset(ACPIREGS *ar)
> >  }
> >  
> >  /* ACPI PM1aCNT */
> > -static void acpi_pm1_cnt_write(ACPIREGS *ar, uint16_t val)
> > +void acpi_pm1_cnt_update(ACPIREGS *ar,
> > +                         bool sci_enable, bool sci_disable)
> >  {
> > +    /* ACPI specs 3.0, 4.7.2.5 */
> > +    if (ar->pm1.cnt.acpi_only) {
> > +        return;
> > +    }
> > +
> > +    if (sci_enable) {
> > +        ar->pm1.cnt.cnt |= ACPI_BITMASK_SCI_ENABLE;
> > +    } else if (sci_disable) {
> > +        ar->pm1.cnt.cnt &= ~ACPI_BITMASK_SCI_ENABLE;
> > +    }
> > +}
> > +
> > +static uint64_t acpi_pm_cnt_read(void *opaque, hwaddr addr, unsigned width)
> > +{
> > +    ACPIREGS *ar = opaque;
> > +    return ar->pm1.cnt.cnt >> addr * 8;
> > +}
> > +
> > +static void acpi_pm_cnt_write(void *opaque, hwaddr addr, uint64_t val,
> > +                              unsigned width)
> > +{
> > +    ACPIREGS *ar = opaque;
> > +
> > +    if (addr == 1) {
> > +        val = val << 8 | (ar->pm1.cnt.cnt & 0xff);
> > +    }
> >      ar->pm1.cnt.cnt = val & ~(ACPI_BITMASK_SLEEP_ENABLE);
> >  
> >      if (val & ACPI_BITMASK_SLEEP_ENABLE) {
> > @@ -575,33 +602,6 @@ static void acpi_pm1_cnt_write(ACPIREGS *ar, uint16_t val)
> >      }
> >  }
> >  
> > -void acpi_pm1_cnt_update(ACPIREGS *ar,
> > -                         bool sci_enable, bool sci_disable)
> > -{
> > -    /* ACPI specs 3.0, 4.7.2.5 */
> > -    if (ar->pm1.cnt.acpi_only) {
> > -        return;
> > -    }
> > -
> > -    if (sci_enable) {
> > -        ar->pm1.cnt.cnt |= ACPI_BITMASK_SCI_ENABLE;
> > -    } else if (sci_disable) {
> > -        ar->pm1.cnt.cnt &= ~ACPI_BITMASK_SCI_ENABLE;
> > -    }
> > -}
> > -
> > -static uint64_t acpi_pm_cnt_read(void *opaque, hwaddr addr, unsigned width)
> > -{
> > -    ACPIREGS *ar = opaque;
> > -    return ar->pm1.cnt.cnt;
> > -}
> > -
> > -static void acpi_pm_cnt_write(void *opaque, hwaddr addr, uint64_t val,
> > -                              unsigned width)
> > -{
> > -    acpi_pm1_cnt_write(opaque, val);
> > -}
> > -
> >  static const MemoryRegionOps acpi_pm_cnt_ops = {
> >      .read = acpi_pm_cnt_read,
> >      .write = acpi_pm_cnt_write,


