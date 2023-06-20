Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A57736D52
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 15:27:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBbNF-0007Kl-4R; Tue, 20 Jun 2023 09:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qBbN9-0007JG-Iw
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 09:26:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qBbN7-0004IQ-ED
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 09:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687267571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x4Hzpc6VoabbftlyRRUh7dBR2zEATRGmNSWuTcvnlak=;
 b=iDzBCRnwbcl02C810mDTTYX+CZBir3pxWbNupkpDSR1t7/yZV525jAnXwu3Csvc+eZgx9n
 GbnWOFXBfPclhKyZ2MiEDIxRDKI7nicl3cIlIUQLcEcTQKPlUwsKDOZimEvm+B0C18bJ1G
 Mea76JEQwg7eOIwuk9ZKZ1yt39xe9wU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-WaioQBbSO3CJxBY4MrbUdg-1; Tue, 20 Jun 2023 09:26:09 -0400
X-MC-Unique: WaioQBbSO3CJxBY4MrbUdg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31114af5e45so2188827f8f.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 06:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687267568; x=1689859568;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x4Hzpc6VoabbftlyRRUh7dBR2zEATRGmNSWuTcvnlak=;
 b=UPekCbIUv3CKiMX0y83Q3jW6B5rZ4SDycOYqDtOPiZVS6Uygusk6QB4jopANcf8OGf
 m5mkMCSf9D5bVnngREDR2Ky5NxPHWJke5UOzTk6p6oxjpygifU/hx3sIF1ogoqDXA9wi
 F6QDckzjfV7QKX5BfE1oYe3QMXiHZ/QJIp2kDY1tz/ROEWhLZdfqqIbHdjMo+ey67CR3
 piRAg97OGn1bkZReD9yY4/hsSOzOZ2F8mKMOcI92XwNl18PbnmYaDy0zdivtZha+66cl
 esgZhMdu5k9C8662llRqwls+TcIdObqkr9bB2rikhnMt+HQ/Xv/Lr8cxjsr9SBztks8r
 fQuQ==
X-Gm-Message-State: AC+VfDx4oWIZZGekr/pB89Hu5YQKrSKoaBpHRpgIUV2f+aWB4T1VBsCf
 +v4xFG/+5I6UwiLUyeO/MREPO45BkwH3hMiOGtuo4B5K75ERUR+Z9BOCOxZhfi/uvutZJwQ0vmH
 rPXlVLMAiQDjh3d8=
X-Received: by 2002:adf:fe48:0:b0:311:10c0:85f0 with SMTP id
 m8-20020adffe48000000b0031110c085f0mr10235640wrs.14.1687267568328; 
 Tue, 20 Jun 2023 06:26:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ49/8BTEX3DMP4gTSjeseX9Qmy7e9ggUgCPi/V8X/QHiBq2WYASwR2U+dofxhRQ4BnRsylHJQ==
X-Received: by 2002:adf:fe48:0:b0:311:10c0:85f0 with SMTP id
 m8-20020adffe48000000b0031110c085f0mr10235621wrs.14.1687267567869; 
 Tue, 20 Jun 2023 06:26:07 -0700 (PDT)
Received: from redhat.com ([2.52.15.156]) by smtp.gmail.com with ESMTPSA id
 m9-20020a5d56c9000000b0030fb4b55c13sm1985464wrw.96.2023.06.20.06.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 06:26:07 -0700 (PDT)
Date: Tue, 20 Jun 2023 09:26:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] hw/acpi: Fix PM control register access
Message-ID: <20230620092546-mutt-send-email-mst@kernel.org>
References: <20230607200125.A9988746377@zero.eik.bme.hu>
 <c080f8f6-b1d4-4ffb-7fcb-f29c7ddaf980@ilande.co.uk>
 <20230608111241-mutt-send-email-mst@kernel.org>
 <a37ca4bf-ad22-9086-b3a8-3c0d4f55da27@eik.bme.hu>
 <alpine.LMD.2.03.2306200248390.24060@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LMD.2.03.2306200248390.24060@eik.bme.hu>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Tue, Jun 20, 2023 at 02:50:55AM +0200, BALATON Zoltan wrote:
> On Thu, 8 Jun 2023, BALATON Zoltan wrote:
> > On Thu, 8 Jun 2023, Michael S. Tsirkin wrote:
> > > On Thu, Jun 08, 2023 at 12:37:08PM +0100, Mark Cave-Ayland wrote:
> > > > On 07/06/2023 21:01, BALATON Zoltan wrote:
> > > > 
> > > > > On pegasos2 which has ACPI as part of VT8231 south bridge the board
> > > > > firmware writes PM control register by accessing the second byte so
> > > > > addr will be 1. This wasn't handled correctly and the write went to
> > > > > addr 0 instead. Remove the acpi_pm1_cnt_write() function which is used
> > > > > only once and does not take addr into account and handle non-zero
> > > > > address in acpi_pm_cnt_{read|write}. This fixes ACPI shutdown with
> > > > > pegasos2 firmware.
> > > > > 
> > > > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > > > > ---
> > > > >   hw/acpi/core.c | 52 +++++++++++++++++++++++++-------------------------
> > > > >   1 file changed, 26 insertions(+), 26 deletions(-)
> > > > > 
> > > > > diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> > > > > index 6da275c599..00b1e79a30 100644
> > > > > --- a/hw/acpi/core.c
> > > > > +++ b/hw/acpi/core.c
> > > > > @@ -551,30 +551,6 @@ void acpi_pm_tmr_reset(ACPIREGS *ar)
> > > > >   }
> > > > >   /* ACPI PM1aCNT */
> > > > > -static void acpi_pm1_cnt_write(ACPIREGS *ar, uint16_t val)
> > > > > -{
> > > > > -    ar->pm1.cnt.cnt = val & ~(ACPI_BITMASK_SLEEP_ENABLE);
> > > > > -
> > > > > -    if (val & ACPI_BITMASK_SLEEP_ENABLE) {
> > > > > -        /* change suspend type */
> > > > > -        uint16_t sus_typ = (val >> 10) & 7;
> > > > > -        switch (sus_typ) {
> > > > > -        case 0: /* soft power off */
> > > > > -            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> > > > > -            break;
> > > > > -        case 1:
> > > > > -            qemu_system_suspend_request();
> > > > > -            break;
> > > > > -        default:
> > > > > -            if (sus_typ == ar->pm1.cnt.s4_val) { /* S4 request */
> > > > > -                qapi_event_send_suspend_disk();
> > > > > -
> > > > > qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> > > > > -            }
> > > > > -            break;
> > > > > -        }
> > > > > -    }
> > > > > -}
> > > > > -
> > > > >   void acpi_pm1_cnt_update(ACPIREGS *ar,
> > > > >                            bool sci_enable, bool sci_disable)
> > > > >   {
> > > > > @@ -593,13 +569,37 @@ void acpi_pm1_cnt_update(ACPIREGS *ar,
> > > > >   static uint64_t acpi_pm_cnt_read(void *opaque, hwaddr
> > > > > addr, unsigned width)
> > > > >   {
> > > > >       ACPIREGS *ar = opaque;
> > > > > -    return ar->pm1.cnt.cnt;
> > > > > +    return ar->pm1.cnt.cnt >> addr * 8;
> > > > 
> > > > This shift here...
> > > > 
> > > > >   }
> > > > >   static void acpi_pm_cnt_write(void *opaque, hwaddr addr, uint64_t val,
> > > > >                                 unsigned width)
> > > > >   {
> > > > > -    acpi_pm1_cnt_write(opaque, val);
> > > > > +    ACPIREGS *ar = opaque;
> > > > > +
> > > > > +    if (addr == 1) {
> > > > > +        val = val << 8 | (ar->pm1.cnt.cnt & 0xff);
> > > > > +    }
> > > > 
> > > > and this shift here look similar to my workaround in https://patchew.org/QEMU/20230524211104.686087-1-mark.cave-ayland@ilande.co.uk/20230524211104.686087-31-mark.cave-ayland@ilande.co.uk/
> > > > which is a symptom of https://gitlab.com/qemu-project/qemu/-/issues/360.
> > > > 
> > > > Whilst there is no imminent fix for the above issue, it may be worth a few
> > > > mins to determine if this is the same issue and if so document it with
> > > > comments accordingly as I did so that the workaround can be removed at a
> > > > later date.
> > > 
> > > So I will add
> > > this triggers a but in memory core,
> > > (see
> > > https://gitlab.com/qemu-project/qemu/-/issues/360 for more detail)
> > > 
> > > ?
> > 
> > Apart from the typo but -> bug I'm not sure this is related to that
> > issue but in any case this does not trigger but works around some
> > possible bug so maybe "This work around may be related to issue URL" or
> > something like that maybe? I'm also not sure what comment to add where
> > so I'd appreciate if you can handle this on merging.
> 
> Ping? Is this queued somewhere or will it be merged? Maybe Adding Buglink
> tag to commit message could be sufficient or just mentioning the link in the
> commit message. I'm still not sure what the best way to do that so I hope
> you could take care of that.
> 
> Regards,
> BALATON Zoltan

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/360

?


> > > > > +    ar->pm1.cnt.cnt = val & ~(ACPI_BITMASK_SLEEP_ENABLE);
> > > > > +
> > > > > +    if (val & ACPI_BITMASK_SLEEP_ENABLE) {
> > > > > +        /* change suspend type */
> > > > > +        uint16_t sus_typ = (val >> 10) & 7;
> > > > > +        switch (sus_typ) {
> > > > > +        case 0: /* soft power off */
> > > > > +            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> > > > > +            break;
> > > > > +        case 1:
> > > > > +            qemu_system_suspend_request();
> > > > > +            break;
> > > > > +        default:
> > > > > +            if (sus_typ == ar->pm1.cnt.s4_val) { /* S4 request */
> > > > > +                qapi_event_send_suspend_disk();
> > > > > +
> > > > > qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> > > > > +            }
> > > > > +            break;
> > > > > +        }
> > > > > +    }
> > > > >   }
> > > > >   static const MemoryRegionOps acpi_pm_cnt_ops = {
> > > > 
> > > > 
> > > > ATB,
> > > > 
> > > > Mark.
> > > 
> > > 
> > 
> > 


