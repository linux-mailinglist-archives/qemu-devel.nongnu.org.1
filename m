Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 429A67288FE
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 21:49:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Lc7-0004J3-PY; Thu, 08 Jun 2023 15:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q7Lc0-0004In-AL
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 15:48:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q7Lbv-0005PU-Tz
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 15:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686253674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m5Ni/9Aed397AbtOkVQKcrnRvkjFz2U9eWH3dn/XX1M=;
 b=Zfl1OeNPCES3l8IMyiOWZUUjwBsw1rNlYa+yD/pREi7q39EBWTfeDza6OXMqV13EBrv9xI
 2uZKPnn+maK9JPNGh8kSBNsoZcGTAHAV9dtfea6l3ZmNneeNgauCL7lhXUS9oppgaxCgrR
 6XvINurOO+k/4RduER3bXJTzEd5zruo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-qUF_amErMrSGlsYKHJNcdg-1; Thu, 08 Jun 2023 15:47:53 -0400
X-MC-Unique: qUF_amErMrSGlsYKHJNcdg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f7e7cfcae4so5610825e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 12:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686253672; x=1688845672;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m5Ni/9Aed397AbtOkVQKcrnRvkjFz2U9eWH3dn/XX1M=;
 b=FR3DgWWMXhYploprE0QvZvVkZubF0urL/b6TnHQspPMJSQ+YIMrIwqfdtGL+TbChYk
 SiwhgzWN+obPu+yW59G3XBqq+OZeSTDCaJQP1Djvgjdt4V7ELkyVCUhIQV3erSzuOwgw
 POD6NrIKS1eP2Z5QeT/I141l5SQ7Kr01Hx8k0J4hmwmUGG+5e1PmWm4JUHqeuasbfRlB
 KSfBL7LyIIsopdhgy51YHcVLcBpQo1BWOwM0zHAE6TKKfcwKbniMVdglt/SB1srlLFln
 dDLI6DbGK2EAC+DfVXAulEth0EVDAsmdCS6Zlvi8PRpuAWVOqUQp4Zf4geuZqAMww1eN
 jDCQ==
X-Gm-Message-State: AC+VfDzuGeKGEfLIS0Y1IG86wUcMAtWgBzieC/m6FdVfFuR5qtVC8Xj/
 /EE5viT/AA5HqxiEjSNV8ddVJkxBLdd7qQXAXs1V4ucv3Hc4x3mkRPXaVPnCAIdby11LJPEt2RA
 QamXaoBLKFFML3jA=
X-Received: by 2002:a5d:498f:0:b0:307:cb94:85de with SMTP id
 r15-20020a5d498f000000b00307cb9485demr12072992wrq.11.1686253672264; 
 Thu, 08 Jun 2023 12:47:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6qOSDt/1MS03Jwpdns38870llbCOgOu8T0w2TzB4g5AGgdk2goGk6UKx5tALyJOqNL9nHiIQ==
X-Received: by 2002:a5d:498f:0:b0:307:cb94:85de with SMTP id
 r15-20020a5d498f000000b00307cb9485demr12072983wrq.11.1686253671976; 
 Thu, 08 Jun 2023 12:47:51 -0700 (PDT)
Received: from redhat.com ([2.55.4.169]) by smtp.gmail.com with ESMTPSA id
 i7-20020adffc07000000b0030631a599a0sm2417352wrr.24.2023.06.08.12.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 12:47:51 -0700 (PDT)
Date: Thu, 8 Jun 2023 15:47:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] hw/acpi: Fix PM control register access
Message-ID: <20230608154721-mutt-send-email-mst@kernel.org>
References: <20230607200125.A9988746377@zero.eik.bme.hu>
 <c080f8f6-b1d4-4ffb-7fcb-f29c7ddaf980@ilande.co.uk>
 <20230608111241-mutt-send-email-mst@kernel.org>
 <5f6e8650-5468-0091-9cd6-eaeeac12a2d5@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f6e8650-5468-0091-9cd6-eaeeac12a2d5@ilande.co.uk>
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

On Thu, Jun 08, 2023 at 08:35:42PM +0100, Mark Cave-Ayland wrote:
> On 08/06/2023 16:13, Michael S. Tsirkin wrote:
> 
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
> > > >    hw/acpi/core.c | 52 +++++++++++++++++++++++++-------------------------
> > > >    1 file changed, 26 insertions(+), 26 deletions(-)
> > > > 
> > > > diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> > > > index 6da275c599..00b1e79a30 100644
> > > > --- a/hw/acpi/core.c
> > > > +++ b/hw/acpi/core.c
> > > > @@ -551,30 +551,6 @@ void acpi_pm_tmr_reset(ACPIREGS *ar)
> > > >    }
> > > >    /* ACPI PM1aCNT */
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
> > > >    void acpi_pm1_cnt_update(ACPIREGS *ar,
> > > >                             bool sci_enable, bool sci_disable)
> > > >    {
> > > > @@ -593,13 +569,37 @@ void acpi_pm1_cnt_update(ACPIREGS *ar,
> > > >    static uint64_t acpi_pm_cnt_read(void *opaque, hwaddr addr, unsigned width)
> > > >    {
> > > >        ACPIREGS *ar = opaque;
> > > > -    return ar->pm1.cnt.cnt;
> > > > +    return ar->pm1.cnt.cnt >> addr * 8;
> > > 
> > > This shift here...
> > > 
> > > >    }
> > > >    static void acpi_pm_cnt_write(void *opaque, hwaddr addr, uint64_t val,
> > > >                                  unsigned width)
> > > >    {
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
> Well it was just an observation based on its similarity to my patch, but it
> would need a quick check with the debugger to step back up from the access
> to confirm if it were caused by the same issue (see the above issue #360 for
> detail).
> 
> As per my previous message no objection to the patch, but if it does have
> the same underlying cause then it could explain why this has been a tricky
> problem to solve (as in general the memory API "just works") and also
> provide another test case for a potential fix.
> 
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
> > > >    }
> > > >    static const MemoryRegionOps acpi_pm_cnt_ops = {
> 
> 
> ATB,
> 
> Mark.

Yea look at e.g. discussion around
https://lore.kernel.org/all/20211108130934.59B48748F52%40zero.eik.bme.hu/t.mbox.gz

-- 
MST


