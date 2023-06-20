Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FA0736D5B
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 15:28:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBbOn-0008Ft-5E; Tue, 20 Jun 2023 09:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qBbOU-0008A9-EQ
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 09:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qBbOS-0004ZM-LK
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 09:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687267654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C8Ij+HkW/GZRCSCj9HXfBsGFl742i2Hi41Ktjb65h/4=;
 b=VbMsKNHChS0m4Kj/BLQOnh5//CenoRTTKuKEeq0K0qK2frolRAUoOTnFeXhNT1TNT1yb+S
 os9EzdYkf1klyCtp8jWBDWspwXHvitfeKIAqBTyH3FWPeusyvlAt1XUjGUr1bL01ROOHvx
 7gpPXSk5mJUToTrYGbaq1sIKMJPJrtA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-nEW6OiJ0PiqKX0QgL9XCzQ-1; Tue, 20 Jun 2023 09:27:32 -0400
X-MC-Unique: nEW6OiJ0PiqKX0QgL9XCzQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-311292a0fe9so2214545f8f.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 06:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687267650; x=1689859650;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C8Ij+HkW/GZRCSCj9HXfBsGFl742i2Hi41Ktjb65h/4=;
 b=Voo72HcPPxfpdGWkbfb3+HLW3oB3WvaDWETg7ike5zj65z3PJnyGR/k50PTM+ZWuh6
 jkvDfHcHJgBXJeryigD7g3+YKOjPE7mVqKzhbIB/wypiMhK6IcsFxhoMqKHmYsIfz0Qb
 zX9jm9K3FgetTxCdNtodHWx1MAKtwh1sNHrcSl5DJbeqkbJPd9p1rXQzTsqx4JnIM+Ut
 glG2dFoTpLJEEjyXCPVgEvlfjW97/kLQftTBHMM2G5XO4jHMsgFV5NfPA7ur5E1EdaVa
 Q2uat669HBWxFl6nghYyOE5xMSZbejRWGc4xvYkp7mQj9Ph0knAMuu4Gg4nY3MO9+VOE
 p0tQ==
X-Gm-Message-State: AC+VfDzTHegK6kAd4jlJOAtNRRuoFPnhK43Mz1t4ToBhcWxBj3OVwXZZ
 boWA6x5FE9wdLSMIrHntdO853jBhcCZu7QA1gN/Lj/Yo/Dd2zwIEiQZ1rUG4SzwmWDtg6YLr9wn
 gDCe4lchfKQKNGkTsQwHKB9J8rg==
X-Received: by 2002:a5d:5608:0:b0:30e:3f55:ebc9 with SMTP id
 l8-20020a5d5608000000b0030e3f55ebc9mr11103542wrv.13.1687267650456; 
 Tue, 20 Jun 2023 06:27:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5lCNbOP8H0vmrbdDS19L/auusG6pNjnpQnpZ7KffDx/p3uwznOyacEWylXofp/1RqWDQM+Ug==
X-Received: by 2002:a5d:5608:0:b0:30e:3f55:ebc9 with SMTP id
 l8-20020a5d5608000000b0030e3f55ebc9mr11103528wrv.13.1687267650126; 
 Tue, 20 Jun 2023 06:27:30 -0700 (PDT)
Received: from redhat.com ([2.52.15.156]) by smtp.gmail.com with ESMTPSA id
 y7-20020a1c4b07000000b003f17848673fsm2343715wma.27.2023.06.20.06.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 06:27:29 -0700 (PDT)
Date: Tue, 20 Jun 2023 09:27:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] hw/acpi: Fix PM control register access
Message-ID: <20230620092639-mutt-send-email-mst@kernel.org>
References: <20230607200125.A9988746377@zero.eik.bme.hu>
 <c080f8f6-b1d4-4ffb-7fcb-f29c7ddaf980@ilande.co.uk>
 <20230608111241-mutt-send-email-mst@kernel.org>
 <a37ca4bf-ad22-9086-b3a8-3c0d4f55da27@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a37ca4bf-ad22-9086-b3a8-3c0d4f55da27@eik.bme.hu>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jun 08, 2023 at 05:20:37PM +0200, BALATON Zoltan wrote:
> On Thu, 8 Jun 2023, Michael S. Tsirkin wrote:
> > On Thu, Jun 08, 2023 at 12:37:08PM +0100, Mark Cave-Ayland wrote:
> > > On 07/06/2023 21:01, BALATON Zoltan wrote:
> > > 
> > > > On pegasos2 which has ACPI as part of VT8231 south bridge the board
> > > > firmware writes PM control register by accessing the second byte so
> > > > addr will be 1. This wasn't handled correctly and the write went to
> > > > addr 0 instead. Remove the acpi_pm1_cnt_write() function which is used
> > > > only once and does not take addr into account and handle non-zero
> > > > address in acpi_pm_cnt_{read|write}. This fixes ACPI shutdown with
> > > > pegasos2 firmware.
> > > > 
> > > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > > > ---
> > > >   hw/acpi/core.c | 52 +++++++++++++++++++++++++-------------------------
> > > >   1 file changed, 26 insertions(+), 26 deletions(-)
> > > > 
> > > > diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> > > > index 6da275c599..00b1e79a30 100644
> > > > --- a/hw/acpi/core.c
> > > > +++ b/hw/acpi/core.c
> > > > @@ -551,30 +551,6 @@ void acpi_pm_tmr_reset(ACPIREGS *ar)
> > > >   }
> > > >   /* ACPI PM1aCNT */
> > > > -static void acpi_pm1_cnt_write(ACPIREGS *ar, uint16_t val)
> > > > -{
> > > > -    ar->pm1.cnt.cnt = val & ~(ACPI_BITMASK_SLEEP_ENABLE);
> > > > -
> > > > -    if (val & ACPI_BITMASK_SLEEP_ENABLE) {
> > > > -        /* change suspend type */
> > > > -        uint16_t sus_typ = (val >> 10) & 7;
> > > > -        switch (sus_typ) {
> > > > -        case 0: /* soft power off */
> > > > -            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> > > > -            break;
> > > > -        case 1:
> > > > -            qemu_system_suspend_request();
> > > > -            break;
> > > > -        default:
> > > > -            if (sus_typ == ar->pm1.cnt.s4_val) { /* S4 request */
> > > > -                qapi_event_send_suspend_disk();
> > > > -                qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> > > > -            }
> > > > -            break;
> > > > -        }
> > > > -    }
> > > > -}
> > > > -
> > > >   void acpi_pm1_cnt_update(ACPIREGS *ar,
> > > >                            bool sci_enable, bool sci_disable)
> > > >   {
> > > > @@ -593,13 +569,37 @@ void acpi_pm1_cnt_update(ACPIREGS *ar,
> > > >   static uint64_t acpi_pm_cnt_read(void *opaque, hwaddr addr, unsigned width)
> > > >   {
> > > >       ACPIREGS *ar = opaque;
> > > > -    return ar->pm1.cnt.cnt;
> > > > +    return ar->pm1.cnt.cnt >> addr * 8;
> > > 
> > > This shift here...
> > > 
> > > >   }
> > > >   static void acpi_pm_cnt_write(void *opaque, hwaddr addr, uint64_t val,
> > > >                                 unsigned width)
> > > >   {
> > > > -    acpi_pm1_cnt_write(opaque, val);
> > > > +    ACPIREGS *ar = opaque;
> > > > +
> > > > +    if (addr == 1) {
> > > > +        val = val << 8 | (ar->pm1.cnt.cnt & 0xff);
> > > > +    }
> > > 
> > > and this shift here look similar to my workaround in https://patchew.org/QEMU/20230524211104.686087-1-mark.cave-ayland@ilande.co.uk/20230524211104.686087-31-mark.cave-ayland@ilande.co.uk/
> > > which is a symptom of https://gitlab.com/qemu-project/qemu/-/issues/360.
> > > 
> > > Whilst there is no imminent fix for the above issue, it may be worth a few
> > > mins to determine if this is the same issue and if so document it with
> > > comments accordingly as I did so that the workaround can be removed at a
> > > later date.
> > 
> > So I will add
> > this triggers a but in memory core,
> > (see
> > https://gitlab.com/qemu-project/qemu/-/issues/360 for more detail)
> > 
> > ?
> 
> Apart from the typo but -> bug I'm not sure this is related to that issue
> but in any case this does not trigger but works around some possible bug so
> maybe "This work around may be related to issue URL" or something like that
> maybe? I'm also not sure what comment to add where so I'd appreciate if you
> can handle this on merging.
> 
> Regards,
> BALATON Zoltan

I'll merge, just got back from travel.


> > > > +    ar->pm1.cnt.cnt = val & ~(ACPI_BITMASK_SLEEP_ENABLE);
> > > > +
> > > > +    if (val & ACPI_BITMASK_SLEEP_ENABLE) {
> > > > +        /* change suspend type */
> > > > +        uint16_t sus_typ = (val >> 10) & 7;
> > > > +        switch (sus_typ) {
> > > > +        case 0: /* soft power off */
> > > > +            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> > > > +            break;
> > > > +        case 1:
> > > > +            qemu_system_suspend_request();
> > > > +            break;
> > > > +        default:
> > > > +            if (sus_typ == ar->pm1.cnt.s4_val) { /* S4 request */
> > > > +                qapi_event_send_suspend_disk();
> > > > +                qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> > > > +            }
> > > > +            break;
> > > > +        }
> > > > +    }
> > > >   }
> > > >   static const MemoryRegionOps acpi_pm_cnt_ops = {
> > > 
> > > 
> > > ATB,
> > > 
> > > Mark.
> > 
> > 


