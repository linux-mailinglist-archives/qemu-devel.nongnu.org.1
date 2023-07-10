Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 718B674D802
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 15:44:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIrBq-0001wf-9W; Mon, 10 Jul 2023 09:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1qIrBn-0001vy-WC; Mon, 10 Jul 2023 09:44:32 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1qIrBm-0001xo-6j; Mon, 10 Jul 2023 09:44:31 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-57712d00cc1so58193237b3.3; 
 Mon, 10 Jul 2023 06:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688996669; x=1691588669;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PhAWojEDscUBme5QQ2Fh2q5LfLGuLGiAPML5xQlJLUo=;
 b=XeT8HFBaAq8m5/GIlkQ5xFbyJPzsRKp8qKulcMjnaEZREdlRHSmkvMM4E4lFtThZTN
 v6FRcwCXLCV5gVmTsqTt5Ha4jR0e1u8LjF37o2yPShG3GW7bgLp6NpY9bXY8lcbOXmiT
 pbEHn6sheL139f+xC9X3C2BLwilVRsX7GTKKGvMTvt0RMFIf/kkNbNOs4PAKtEf5KglO
 1h2fCc3yzfnGZII6rDtRloc0pvvSwtiuppsmBCtaP117A7yv6wFStj3K3iKANFwdKMow
 ldavDL7UURTBT6Xzr9HSC5jFqNzcLqhANLON6zF1t5sbK7ZKdan0gewBvaHjfIyUcDyX
 Plqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688996669; x=1691588669;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PhAWojEDscUBme5QQ2Fh2q5LfLGuLGiAPML5xQlJLUo=;
 b=iGEHAZijFcVlj4QK62L/t37D0gc+EJgDGbpyGMSYKlFeB5yTtdKlP3wInd1BDibsKm
 qSbY5V4EK958nNjjIYr33yNk5kbyTLpWnvc8ASahgpN5T4gzfRDOyGYXwhwYwOdN7I8r
 67zkn++pLG9zceKzaCDrGK6SOYQ2EkdCqYIACSB59dWOpa2KLRgZ/Aeefn00BbYAW0+S
 dru2N1DMbCEhkyAbZcNsCDobb8jiKY+O5U7cDBkCN3CjCpzZocmOlXHHAbUolkfMx9Ka
 ayZFlCg8gM+c463fJf/rfdjebP5uN3IW3cDHnPZAfasQ5rANGbmKTdKhotrdtD/tdYya
 ZQjQ==
X-Gm-Message-State: ABy/qLYFGWaTMZqCR6Yo7n+/4MYrohCHyJ9LT0HgMOeGVepcnfNlzvPb
 o33uS6L8YwVYdt6c6zgRm6Y=
X-Google-Smtp-Source: APBJJlH1G1MyRypKNk/okBYkyh1F536tv4J7aRa6aJLS8CssHeu51LTqGBbpU+HdB8DzHxSLEtvttg==
X-Received: by 2002:a0d:d4c2:0:b0:56d:4d17:99b0 with SMTP id
 w185-20020a0dd4c2000000b0056d4d1799b0mr15857164ywd.10.1688996668834; 
 Mon, 10 Jul 2023 06:44:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 x201-20020a0dd5d2000000b00570599de9a5sm3071185ywd.88.2023.07.10.06.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 06:44:28 -0700 (PDT)
Date: Mon, 10 Jul 2023 06:44:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Bin Meng <bin.meng@windriver.com>
Subject: Re: [PATCH] hw/sd/sdhci: Do not force sdhci_mmio_*_ops onto all SD
 controllers
Message-ID: <250f2cf5-9c5a-4098-a68e-35468437f57e@roeck-us.net>
References: <20230709080950.92489-1-shentey@gmail.com>
 <52b5a36a-5744-0ac9-a3f5-0dbd247410ed@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52b5a36a-5744-0ac9-a3f5-0dbd247410ed@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=groeck7@gmail.com; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, Jul 10, 2023 at 12:16:35PM +0200, Philippe Mathieu-Daudé wrote:
> On 9/7/23 10:09, Bernhard Beschow wrote:
> > Since commit c0a55a0c9da2 "hw/sd/sdhci: Support big endian SD host controller
> > interfaces" sdhci_common_realize() forces all SD card controllers to use either
> > sdhci_mmio_le_ops or sdhci_mmio_be_ops, depending on the "endianness" property.
> > However, there are device models which use different MMIO ops: TYPE_IMX_USDHC
> > uses usdhc_mmio_ops and TYPE_S3C_SDHCI uses sdhci_s3c_mmio_ops.
> > 
> > Forcing sdhci_mmio_le_ops breaks SD card handling on the "sabrelite" board, for
> > example. Fix this by defaulting the io_ops to little endian and switch to big
> > endian in sdhci_common_realize() only if there is a matchig big endian variant
> > available.
> > 
> > Fixes: c0a55a0c9da2 ("hw/sd/sdhci: Support big endian SD host controller
> > interfaces")
> > 
> > Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> > ---
> >   hw/sd/sdhci.c | 8 +++++++-
> >   1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> > index 6811f0f1a8..362c2c86aa 100644
> > --- a/hw/sd/sdhci.c
> > +++ b/hw/sd/sdhci.c
> > @@ -1382,6 +1382,8 @@ void sdhci_initfn(SDHCIState *s)
> >       s->insert_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_raise_insertion_irq, s);
> >       s->transfer_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_data_transfer, s);
> > +
> > +    s->io_ops = &sdhci_mmio_le_ops;
> >   }
> >   void sdhci_uninitfn(SDHCIState *s)
> > @@ -1399,9 +1401,13 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
> 
> What about simply keeping the same code guarded with 'if (!s->io_ops)'?
> 

That was my quick fix which I considered a hack, and I didn't submit it
because I thought it was a hack ;-).

On the other side, this solution would probably break on big endian systems
which have their own io ops, so I am not sure if it is any better.

Guenter

> >       switch (s->endianness) {
> >       case DEVICE_LITTLE_ENDIAN:
> > -        s->io_ops = &sdhci_mmio_le_ops;
> > +        /* s->io_ops is little endian by default */
> >           break;
> >       case DEVICE_BIG_ENDIAN:
> > +        if (s->io_ops != &sdhci_mmio_le_ops) {
> > +            error_setg(errp, "SD controller doesn't support big endianness");
> > +            return;
> > +        }
> >           s->io_ops = &sdhci_mmio_be_ops;
> >           break;
> >       default:
> 

