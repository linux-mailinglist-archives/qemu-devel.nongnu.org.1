Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 820147262C0
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:27:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6u7F-0003NW-FR; Wed, 07 Jun 2023 10:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q6u7E-0003NO-Bv
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:26:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q6u75-0004lw-77
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686147974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W3L7MeWTccUcg3w2cVEG1nrPjOoLdmT9oTKUV78kjgE=;
 b=TzVOjUdEGS0CQzzDOk1VexlRA2LmlDcD2egBedw5FxyWOna35J+cYf0M8ysZI5AMqC9SuZ
 L0mGZDYKwdDReGEQFvqMlZ0NiRv8ZdPA1pQNGFtf867k28FsAkTyVIB+bRCKVYRcIHLcOZ
 DO5Uc3vHQ4Rl3YKYGS+AtlQKsbA6VVg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-kK4eH1eTMDSU_2-Z06qEXA-1; Wed, 07 Jun 2023 10:26:12 -0400
X-MC-Unique: kK4eH1eTMDSU_2-Z06qEXA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-977d0333523so432583066b.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 07:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686147970; x=1688739970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W3L7MeWTccUcg3w2cVEG1nrPjOoLdmT9oTKUV78kjgE=;
 b=ikMAzd1WloQuOOwBCl2OzsxjT4yfN3mrGlLATfdRVtkCdrF58WS2TadatRwaw+w/ds
 YcIWKD7Udfse8A8OiK7gOt8TMQ8hLRjcrz0lt80WJi+G/7DxahtNfT3/2r98ikpFfoPX
 HacOUZNYnKc7z4sB9QoKq/YWZEMrGAH+rVC1fJ+lw3qtyGUGgVS6wQDls6FHDzgggKgH
 P5l6dI6UalADFfl8IBCBsgZ15y5Xszih68NIoUstEuY64rmEW2V2NihlwKE1Hq50v3qH
 LteQnInYpHmZQxJizU2ozewLmLJvW2gB1bfxnD7u/RmBEqorY8GnHU9sz5iq1Nn7S4Ow
 6hbw==
X-Gm-Message-State: AC+VfDwxCuWWwIZpPa29M1gtzlgbZbKjOH7ye3FWDrraItdpxuQRo91W
 vXi51BRB3/NDMGsTkpZVV9d86CmbkCx+oLDTH9P9Rup9x/ERZlU162insndEJTuFJ6sbyOd1fqM
 AKcj3qW9Wi8EdMimTfkkD+Is=
X-Received: by 2002:a17:907:868f:b0:96a:5bdd:7557 with SMTP id
 qa15-20020a170907868f00b0096a5bdd7557mr6140891ejc.70.1686147970669; 
 Wed, 07 Jun 2023 07:26:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4c3LwhVd35c+lF6NmepKbBFb1kwJ2PLi94pwRN8y4HiodGuP3D4lfhsjL4ZRE48BtiZorfVQ==
X-Received: by 2002:a17:907:868f:b0:96a:5bdd:7557 with SMTP id
 qa15-20020a170907868f00b0096a5bdd7557mr6140870ejc.70.1686147970366; 
 Wed, 07 Jun 2023 07:26:10 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 b11-20020a05640202cb00b005147f604965sm6323192edx.24.2023.06.07.07.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 07:26:09 -0700 (PDT)
Date: Wed, 7 Jun 2023 16:26:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH] hw/acpi: Fix PM control register access
Message-ID: <20230607162609.306e6bb4@imammedo.users.ipa.redhat.com>
In-Reply-To: <1639953d-6f1c-cd9c-bba5-bc3b0b9134f1@eik.bme.hu>
References: <20230528135750.4145574633D@zero.eik.bme.hu>
 <20230606145046.159b6bba@imammedo.users.ipa.redhat.com>
 <1639953d-6f1c-cd9c-bba5-bc3b0b9134f1@eik.bme.hu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 6 Jun 2023 18:59:48 +0200 (CEST)
BALATON Zoltan <balaton@eik.bme.hu> wrote:

> On Tue, 6 Jun 2023, Igor Mammedov wrote:
> > On Sun, 28 May 2023 15:57:50 +0200 (CEST)
> > BALATON Zoltan <balaton@eik.bme.hu> wrote:
> >  
> >> On pegasos2 which has ACPI as part of VT8231 south bridge the board
> >> firmware writes PM control register by accessing the second byte so
> >> addr will be 1. This wasn't handled correctly and the write went to
> >> addr 0 instead. This fixes ACPI shutdown with pegasos2 firmware.
> >>
> >> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >> ---
> >> This is replacing the previous attempt which changed enduanness to
> >> NATIVE_ENDIAN that was found to be wrong. I'm still not sure what's
> >> happening as these functions are called with addr = 1 and size = 2 but
> >> maybe the guest really does word access to addr 1 when wanting to
> >> write 1 byte. This fixes the problem and should not break anything
> >> else but please review.
> >>
> >>  hw/acpi/core.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> >> index 6da275c599..bbc599a252 100644
> >> --- a/hw/acpi/core.c
> >> +++ b/hw/acpi/core.c
> >> @@ -593,13 +593,13 @@ void acpi_pm1_cnt_update(ACPIREGS *ar,
> >>  static uint64_t acpi_pm_cnt_read(void *opaque, hwaddr addr, unsigned width)
> >>  {
> >>      ACPIREGS *ar = opaque;
> >> -    return ar->pm1.cnt.cnt;
> >> +    return ar->pm1.cnt.cnt >> addr * 8;
> >>  }  
> > that looks fine
> >  
> >>
> >>  static void acpi_pm_cnt_write(void *opaque, hwaddr addr, uint64_t val,
> >>                                unsigned width)
> >>  {
> >> -    acpi_pm1_cnt_write(opaque, val);
> >> +    acpi_pm1_cnt_write(opaque, val << addr * 8);
> >>  }  
> > however, if this is 1 byte write at offset 1,
> > wouldn't this wipe out lower byte
> > (aka:
> > #define ACPI_BITMASK_SCI_ENABLE                 0x0001
> > #define ACPI_BITMASK_BUS_MASTER_RLD             0x0002
> > #define ACPI_BITMASK_GLOBAL_LOCK_RELEASE        0x0004
> > )?  
> 
> Since this will either reset or power off the machine it probably does not 
> really matter. But to fix that more we'd need to rewrite 
> acpi_pm1_cnt_write() to replace acpi_pm_cnt_write() and handle that 
> internally. Or is there another way to handle this? Does that worth the 
> effort when the only known usage is in pegasos2 firmware when it calls 
> power off?

it maybe true for pegasos2 firmware, but this code is shared between
several chipsets, so I'd rather do it correctly now, instead of tying
to figure out where S3 got broken later (potentially we can go into
sleep without reset).

maybe split acpi_pm1_cnt_write() into 2 functions
  acpi_pm1_cnt_write(hi, lo) - updates register contents, or move contents to caller and drop function
and then
  if (ar->pm1.cnt.cnt & ACPI_BITMASK_SLEEP_ENABLE) { 
      acpi_pm1_cnt_handle_pm_req(ar->pm1.cnt.cnt)
  }

> Regards,
> BALATON Zoltan
> 


