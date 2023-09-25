Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BEA7AE0CE
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 23:34:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qktCa-0002Qb-W4; Mon, 25 Sep 2023 17:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qktCZ-0002QD-3d
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 17:33:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qktCX-0007Bf-HF
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 17:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695677588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MbRXgan9pvUAsLTU4I0mP5lm75jwKqfDUWA1tzGuW/Y=;
 b=I2hMKB433ZIidTVzJ/32p/p5sJUgw9t4R1aVjevsl7b1NZsdvrTk/jXEAQLuZICUa7ujyW
 Rh1+uWum151p64ItV3L/0g7ra8df50UYlo343hnoFbdiSPojSq4vlzVySOxe+UyT231+8C
 5W9mTavkLwyqXbPSgYf9uICRukONpWM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-fL24iKBxN56ZY6wmxQCISQ-1; Mon, 25 Sep 2023 17:33:06 -0400
X-MC-Unique: fL24iKBxN56ZY6wmxQCISQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4180b3527c7so80632821cf.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 14:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695677586; x=1696282386;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MbRXgan9pvUAsLTU4I0mP5lm75jwKqfDUWA1tzGuW/Y=;
 b=Yg6aGTBF5CFd0uAIjnz5YdmsJBXomyDd9jj8i8y4WWT1Jq+vnNkXUzYzbmx16cisWR
 h1pyLJiHlpyv00j9xyhPOBu1nNsfzEnHf3XlERu0mmdWJaOOWbQlD1HWKiza8piKnWeN
 /bDjn3qjhpfK+3NvDRSh/HtqEjOdvSq32JmGuhh/Rx+4W8sdGs/3yujL0wNIT17Jbr+B
 U+X647Gr2ELpC3ZycjUQfQFRz38P9OqbSpCv9SxnrDPjXw2Q+cgkpJjmBveNYUJ4KTZ6
 FabWyloIpVVpIkHALpdNs7qIBbQkWF6UrxwynbDElhTbuOdnD/G1oPlrFeAXSllJLGly
 olOA==
X-Gm-Message-State: AOJu0YxqNGLaX1bAQQ64iCOW2yErwY1UGDSTyaKmYt5EMaBL9+9S1lTo
 j/XpVesgq0VY2ZOp5n5fESV22yFxN2iu9SCn/vPDV+inwSiNM0UdrbTIfua35QV/GIN7gSYfr4g
 JHQFZjBe1w8oa+PM=
X-Received: by 2002:ac8:7d16:0:b0:417:d26b:122c with SMTP id
 g22-20020ac87d16000000b00417d26b122cmr10488828qtb.62.1695677586054; 
 Mon, 25 Sep 2023 14:33:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZ+tMAP5mN1+yAMIVz5GU9tjHtVzPav9p40pHlQRQteQrHbWlzWcWQgfKKLNP1gENEqkt9wQ==
X-Received: by 2002:ac8:7d16:0:b0:417:d26b:122c with SMTP id
 g22-20020ac87d16000000b00417d26b122cmr10488818qtb.62.1695677585814; 
 Mon, 25 Sep 2023 14:33:05 -0700 (PDT)
Received: from redhat.com ([185.184.228.174]) by smtp.gmail.com with ESMTPSA id
 n16-20020ac86750000000b004194c21ee85sm137781qtp.79.2023.09.25.14.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 14:33:05 -0700 (PDT)
Date: Mon, 25 Sep 2023 17:33:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Evanzhang <Evanzhang@archeros.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Subject: Re: [PATCH v1] rtc/mc146818rtc: improve rtc performance
Message-ID: <20230925173144-mutt-send-email-mst@kernel.org>
References: <cover.1690188072.git.Evanzhang@archeros.com>
 <4490419ebd87e46adf2294f62c5f3808d2467e40.1690188072.git.Evanzhang@archeros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4490419ebd87e46adf2294f62c5f3808d2467e40.1690188072.git.Evanzhang@archeros.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 24, 2023 at 04:54:22PM +0800, Evanzhang wrote:
> under heavy workloads,irq_coalesced could up to 30+,
> after modification EXTERNAL_INTERRUPT reduce by 40%
> 
> before:
> Analyze events for all VMs, all VCPUs:
>              VM-EXIT    Samples  Samples%     Time%
> 
>        EPT_VIOLATION    9833984    63.41%    15.96%
>       IO_INSTRUCTION    2160843    13.93%    50.07%
>   EXTERNAL_INTERRUPT    1949267    12.57%     0.89%
>           APIC_WRITE     767795     4.95%     0.55%
>          EOI_INDUCED     615308     3.97%     0.30%
>                  HLT     130821     0.84%    31.77%
> 
> after:
> Analyze events for all VMs, all VCPUs:
>              VM-EXIT    Samples  Samples%     Time%
> 
>        EPT_VIOLATION    5238031    50.91%     6.44%
>       IO_INSTRUCTION    2257658    21.94%    54.88%
>   EXTERNAL_INTERRUPT    1160086    11.28%     0.61%
>           APIC_WRITE     780454     7.59%     0.54%
>          EOI_INDUCED     615309     5.98%     0.28%
>                  HLT     179703     1.75%    36.87%
> 
> Signed-off-by: Evanzhang <Evanzhang@archeros.com>



Paolo do you mind picking this old patch up?

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/rtc/mc146818rtc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
> index c27c362..2995078 100644
> --- a/hw/rtc/mc146818rtc.c
> +++ b/hw/rtc/mc146818rtc.c
> @@ -96,8 +96,8 @@ static void rtc_coalesced_timer_update(MC146818RtcState *s)
>      if (s->irq_coalesced == 0) {
>          timer_del(s->coalesced_timer);
>      } else {
> -        /* divide each RTC interval to 2 - 8 smaller intervals */
> -        int c = MIN(s->irq_coalesced, 7) + 1;
> +        /* divide each RTC interval to 2 - 32 smaller intervals */
> +        int c = MIN(s->irq_coalesced, 31) + 1;
>          int64_t next_clock = qemu_clock_get_ns(rtc_clock) +
>              periodic_clock_to_ns(s->period / c);
>          timer_mod(s->coalesced_timer, next_clock);
> -- 
> 2.9.5


