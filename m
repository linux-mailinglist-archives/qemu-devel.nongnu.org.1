Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9715472DD0D
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 10:51:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8zkO-0001rE-Im; Tue, 13 Jun 2023 04:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q8zkK-0001qj-J7
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 04:51:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q8zkI-0006Ea-Lm
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 04:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686646281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4lqEjEO+dOVkkxWmXPoGbya5+ha60llkOa867pRN5Sw=;
 b=O7HL12ELPhBePFcZ0vDvt77sNkTuCfNf+EokfUK+0IUQf/uGBwS4tCjCFHNHB0EXod8O8X
 9t3wnyas6CsggXyJZCfIqP7XJh+hEdK6FGsjguz5SKk2flHc/0hgxaqea+moY5lkbuzqlr
 18gTWf3CtiboOLZfkr1XxhwcfAZp25c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-Su9nz7xIPgOOmOWCkYVpvA-1; Tue, 13 Jun 2023 04:51:19 -0400
X-MC-Unique: Su9nz7xIPgOOmOWCkYVpvA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-977cc772639so467956466b.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 01:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686646278; x=1689238278;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4lqEjEO+dOVkkxWmXPoGbya5+ha60llkOa867pRN5Sw=;
 b=WYR/jQwdrpp5A8/NuT3fi+76HGdNQH5ZCFBhiU+E2fCtwRYOcaJ0hfsa7OGLNvTIzq
 xNKxTywPk+VbzBYnbfEE8q3PkmxXBGZm3dHHBm9l/8//Q6n6wEMKAhx4MssHlYD5Ym2D
 4S89pdzebqommUVq3dTOl5D/Z/X9j7duCZ9O+ch7vGtNlD4OcXyNN/CKnjtNpoCKIddJ
 DrnbfaYQEU61+z4u1cY0dD/cetKBh9dJHRWYsq20o2myvEe7NHC2i0OT1mewqUvE1jhF
 G/oqAxHM2snhmxX6v+BJVvOY06O6d6oFXWPZX9EnndMBkySmNYyIGDgiPKRTVj+sPmJG
 Fs+Q==
X-Gm-Message-State: AC+VfDyFDHwaggyZQ4QqvRhnWSA2m17YmY9rEHTDUkqojQ0MjYAbDPu9
 3L+Tfi9Xq/u+rgqaPqytWGoytbe7BkjHwfbXk7e/0LOYW6ajBKkk6r9i8KmYYk7XAilaIboc7L/
 7e0RVrP9XQbE5X8U=
X-Received: by 2002:a17:907:162c:b0:978:8925:7a00 with SMTP id
 hb44-20020a170907162c00b0097889257a00mr13303405ejc.15.1686646278450; 
 Tue, 13 Jun 2023 01:51:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4rTOSE/3+HVLuaf8yaKfseGBeBVE8zfEeWQ67htMkfaVwY8MWVOMREDIa6pYTUyG4Ix6gvFw==
X-Received: by 2002:a17:907:162c:b0:978:8925:7a00 with SMTP id
 hb44-20020a170907162c00b0097889257a00mr13303396ejc.15.1686646278126; 
 Tue, 13 Jun 2023 01:51:18 -0700 (PDT)
Received: from redhat.com (server.hotelpassage.eu. [88.146.207.194])
 by smtp.gmail.com with ESMTPSA id
 jw19-20020a17090776b300b00973fac6065esm6242221ejc.223.2023.06.13.01.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 01:51:17 -0700 (PDT)
Date: Tue, 13 Jun 2023 04:51:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 02/15] hw/pci-host/q35: Fix double, contradicting
 .endianness assignment
Message-ID: <20230613044810-mutt-send-email-mst@kernel.org>
References: <20230611103412.12109-1-shentey@gmail.com>
 <20230611103412.12109-3-shentey@gmail.com>
 <20230612150154.438d842f@imammedo.users.ipa.redhat.com>
 <CAG4p6K6yR+iJmjnYOkJFd=GbxPU+QpkzTSEfW1VuUwM95o5_iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG4p6K6yR+iJmjnYOkJFd=GbxPU+QpkzTSEfW1VuUwM95o5_iQ@mail.gmail.com>
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

On Tue, Jun 13, 2023 at 09:46:53AM +0200, Bernhard Beschow wrote:
> On Mon, Jun 12, 2023 at 3:01 PM Igor Mammedov <imammedo@redhat.com> wrote:
> 
>     On Sun, 11 Jun 2023 12:33:59 +0200
>     Bernhard Beschow <shentey@gmail.com> wrote:
> 
>     > Fixes the following clangd warning (-Winitializer-overrides):
>     >
>     >   q35.c:297:19: Initializer overrides prior initialization of this
>     subobject
>     >   q35.c:292:19: previous initialization is here
>     >
>     > Settle on native endian which causes the least overhead.
>     indeed it doesn't matter which way we read all ones, so that should work.
>     but does it really matter (I mean the overhead/what workload)?
>     If not, I'd prefer explicit LE as it's now to be consistent
>     the the rest of memops on Q35.
> 
> 
> I got a comment from Michael about this in [1], so I've changed it. I don't
> mind changing it either way.
> 
> Best regards,
> Bernhard
> 
> [1] https://patchew.org/QEMU/20230214131441.101760-1-shentey@gmail.com/
> 20230214131441.101760-3-shentey@gmail.com/#
> 20230301164339-mutt-send-email-mst@kernel.org

Hmm it's not terribly important, and the optimization is trivial,
but yes people tend to copy code, good point. Maybe add a comment?
/*
 * Note: don't copy this!  normally use DEVICE_LITTLE_ENDIAN. This only
 * works because we don't allow writes and always read all-ones.
 */


> 
>     >
>     > Fixes: bafc90bdc594 ("q35: implement TSEG")
>     > Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>     > ---
>     >  hw/pci-host/q35.c | 1 -
>     >  1 file changed, 1 deletion(-)
>     >
>     > diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
>     > index fd18920e7f..859c197f25 100644
>     > --- a/hw/pci-host/q35.c
>     > +++ b/hw/pci-host/q35.c
>     > @@ -290,7 +290,6 @@ static const MemoryRegionOps blackhole_ops = {
>     >      .valid.max_access_size = 4,
>     >      .impl.min_access_size = 4,
>     >      .impl.max_access_size = 4,
>     > -    .endianness = DEVICE_LITTLE_ENDIAN,
>     >  };
>     > 
>     >  /* PCIe MMCFG */
> 
> 


