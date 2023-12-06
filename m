Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 628C08072A2
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 15:40:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAt2i-0007bp-4i; Wed, 06 Dec 2023 09:38:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1rAt2f-0007bP-GC
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 09:38:25 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1rAt2d-00065w-KQ
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 09:38:25 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3b9d8bfe845so52754b6e.0
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 06:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701873502; x=1702478302; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :sender:from:to:cc:subject:date:message-id:reply-to;
 bh=QFCfDA//rGXyKBJb0RYyN6qxtI64hTLsSpzG8VAyzw0=;
 b=jyvvQUdvoxt2/j9ocS8TZRcLeANrlXJE/vuuT+SHZeW1rVrmbrfviaEoCxm7E2M2av
 Z/q/0lxIQKRvcLIqt+uXJOpbhW+rTTpdWHYYUgiH5wj/KsmFi0Rcjfh0vZc1qBXAaTAW
 qh2zXbnAqewD6lb4qVOqpVqvfF5gXDIRuTQ4y7FJvxXd+x1xPzxXcBOGfYwMbS1IBdNO
 k1xDyv35hmNki7CnZBCZHMaUkHBHDIC+PmhDuDfm+m6B9PU+X6d+5suZ2ficsvSPRO3c
 NSoGQlU0L/c/P5VGUuehwneqaLIFcXVPFSHEu7/BfF0PN1nAFD2yAZG+na4pt0WBb4dH
 P4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701873502; x=1702478302;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :sender:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QFCfDA//rGXyKBJb0RYyN6qxtI64hTLsSpzG8VAyzw0=;
 b=abEGxV6BwI1mlaoFxm6RHsnq9+/i+4zlDnCZN0a9DiwkgIYb3A/2QVnG6H9PdRrDot
 Jh2NC47DYVIqEQxZY3C+eYfF//SRYapAgGs3LBmbuZiSedaBRD7HXPUDCLc22UofcuJ8
 /TRxc/pXFtniAUfKni+YvNv+YMOM9cZieYxHBTYJeWoBfbOrtCAyQyHSuT2D0kp2zL15
 tBwThnc6TCJedgJNFBOdqv0GTeeA5VosEY7g60Qxv5JCSqAlpRDGKPhASYZZfdP3gJpv
 cCx6NNgR9bOEsK0XyGxCxhfaokn20JleYt/onQcLLxwxTeol1Ysz2P+0q+lXpO3NTm1m
 FTKg==
X-Gm-Message-State: AOJu0Yykmlv1dhGl0KVlcAKr6wnq3NkpJynL0FjHUsST3ihdPQ8wKNza
 DbyxQu2nncSPdcH5+03hWI7HdHRfcw==
X-Google-Smtp-Source: AGHT+IH2C+soSKcVkKSRbYUIRNRFqHit6fdicd4s53kCqf+Fd57AGZRmb4EXBWw8gGsqmQtl4UwRXw==
X-Received: by 2002:a05:6808:1394:b0:3b6:d1cc:4c6 with SMTP id
 c20-20020a056808139400b003b6d1cc04c6mr1485812oiw.16.1701873501833; 
 Wed, 06 Dec 2023 06:38:21 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a056808019800b003b9ccc75725sm11535oic.13.2023.12.06.06.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Dec 2023 06:38:20 -0800 (PST)
Received: from mail.minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:8ff4:f8fd:ca3:53c6])
 by serve.minyard.net (Postfix) with ESMTPSA id 08D57180047;
 Wed,  6 Dec 2023 14:38:20 +0000 (UTC)
Date: Wed, 6 Dec 2023 08:38:18 -0600
From: Corey Minyard <minyard@acm.org>
To: Patrick Venture <venture@google.com>
Cc: Potin Lai <potin.lai.pt@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] hw/i2c: add pca9543 i2c-mux switch
Message-ID: <ZXCHWvS7CVESVo2G@mail.minyard.net>
References: <20231113063156.2264941-1-potin.lai.pt@gmail.com>
 <ZVQDHlS7TgZpXms8@mail.minyard.net>
 <CAO=notw8mNjiCGK1h7CjmhyHwvXY92BYKW5qvh6NO5romZ7LGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO=notw8mNjiCGK1h7CjmhyHwvXY92BYKW5qvh6NO5romZ7LGA@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=tcminyard@gmail.com; helo=mail-oi1-x233.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: minyard@acm.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Dec 05, 2023 at 11:05:33AM -0800, Patrick Venture wrote:
> On Tue, Nov 14, 2023 at 3:30 PM Corey Minyard <minyard@acm.org> wrote:
> 
> > On Mon, Nov 13, 2023 at 02:31:56PM +0800, Potin Lai wrote:
> > > Add pca9543 2-channel i2c-mux switch support.
> > >
> > > Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
> >
> > Looks good to me.
> >
> > Acked-by: Corey Minyard <cminyard@mvista.com>
> >
> > > ---
> > >  hw/i2c/i2c_mux_pca954x.c         | 12 ++++++++++++
> > >  include/hw/i2c/i2c_mux_pca954x.h |  1 +
> > >  2 files changed, 13 insertions(+)
> > >
> > > diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c
> > > index db5db956a6..6aace0fc47 100644
> > > --- a/hw/i2c/i2c_mux_pca954x.c
> > > +++ b/hw/i2c/i2c_mux_pca954x.c
> > > @@ -30,6 +30,7 @@
> > >
> > >  #define PCA9548_CHANNEL_COUNT 8
> > >  #define PCA9546_CHANNEL_COUNT 4
> > > +#define PCA9543_CHANNEL_COUNT 2
> > >
> > >  /*
> > >   * struct Pca954xState - The pca954x state object.
> > > @@ -172,6 +173,12 @@ I2CBus *pca954x_i2c_get_bus(I2CSlave *mux, uint8_t
> > channel)
> > >      return pca954x->bus[channel];
> > >  }
> > >
> > > +static void pca9543_class_init(ObjectClass *klass, void *data)
> > > +{
> > > +    Pca954xClass *s = PCA954X_CLASS(klass);
> > > +    s->nchans = PCA9543_CHANNEL_COUNT;
> > > +}
> > > +
> > >  static void pca9546_class_init(ObjectClass *klass, void *data)
> > >  {
> > >      Pca954xClass *s = PCA954X_CLASS(klass);
> > > @@ -246,6 +253,11 @@ static const TypeInfo pca954x_info[] = {
> > >          .class_init    = pca954x_class_init,
> > >          .abstract      = true,
> > >      },
> > > +    {
> > > +        .name          = TYPE_PCA9543,
> > > +        .parent        = TYPE_PCA954X,
> > > +        .class_init    = pca9543_class_init,
> > > +    },
> > >      {
> > >          .name          = TYPE_PCA9546,
> > >          .parent        = TYPE_PCA954X,
> > > diff --git a/include/hw/i2c/i2c_mux_pca954x.h
> > b/include/hw/i2c/i2c_mux_pca954x.h
> > > index 3dd25ec983..1da5508ed5 100644
> > > --- a/include/hw/i2c/i2c_mux_pca954x.h
> > > +++ b/include/hw/i2c/i2c_mux_pca954x.h
> > > @@ -3,6 +3,7 @@
> > >
> > >  #include "hw/i2c/i2c.h"
> > >
> > > +#define TYPE_PCA9543 "pca9543"
> > >  #define TYPE_PCA9546 "pca9546"
> > >  #define TYPE_PCA9548 "pca9548"
> > >
> > > --
> > > 2.31.1
> > >
> > >
> 
> 
> Corey, can you include this in a pull email? I don't quite have that set up
> at present, Titus is going to help me figure it out.

Ok, I'm running tests now, I'll get a pull request in assuming
everything is ok.

-corey

