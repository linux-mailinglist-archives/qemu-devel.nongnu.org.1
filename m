Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3556876EF25
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 18:11:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRaua-0007E3-5b; Thu, 03 Aug 2023 12:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRauY-00075Y-44
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 12:10:50 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRauV-0004ZO-M3
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 12:10:49 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4fe48a2801bso2054591e87.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 09:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691079045; x=1691683845;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2BbtFeAujhoYn8c3RRVv29pV+qM8VAxQAHfs7hQZrj4=;
 b=S4ypy0e3VqHXFHUUYrOXFnK195pU/bnCEjNzKm3c+7m8p186vELx67Lxh6hxhH2TCM
 43DEjVzJN0gBFuwPpZ3NGDQ3u7XiEz/kJRDKwFVxZlTOxRsFz6YR9jvWPJUUYpUzAdL9
 4f1BdXXzXjx4bozMLc3Lw2uacDHhHc0o99Oy5id1nkS2NKFW2NXc/ZKHumdGmZK+EzLW
 XXD287M59bMFR6CwUVB2CfwDivGMZU/I2+R1UIW2PQSjc2OoGSm6LdOKUdjPpTDZeLwV
 GTR2i5zl4RQF/5e0O9tZMbryzv2W/8pCR5JWY1JRFdjbXw2XjYgQgRnTRjW2oD3qzG4u
 RZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691079045; x=1691683845;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2BbtFeAujhoYn8c3RRVv29pV+qM8VAxQAHfs7hQZrj4=;
 b=IvMBXyK9L+pNrgRi+Dd2ap3n16lZfWQTw8uWSf+ZTZDwm9ukQKSlD81adFCYYJy/m0
 w2IXKKVv+YQDwbewKpUfBtpBotYYGFbnJYoMC+cKKmaojvjt/ljus9+hm28HqGsumdEV
 pjgSEi6+PBPVvvB6d7kwF1s58YVVdaDpZEhNByCffrG8G95ajIxG1QEsX1lKx53ZYHrP
 XX9NNkzwFkeooaGYxaMr05dLyMd+nwmwhbqJzhTkQVu2THu7568tgJ4j7J7+wkmDOGs+
 pzwrcoJySzBzxMu/EK/9++OGkNH4J2HNFAGq9la3eEdj3vdGCWDmhcypPIIR0yrE8ZXk
 fPjw==
X-Gm-Message-State: ABy/qLYeamh2defrQtj+QE+pT9vNXLBeduEyjHknZAmL9an7loj70xdl
 fUMPBCech/o91td2NKu4nT+LyQLM7mfV/Wq8D5IhpFHZft/8uOL4
X-Google-Smtp-Source: APBJJlEWL+nq3BxBAkw2tYPRSUQSNJHAPd75JHkd2Xd7jiIG0Y5BA9QNmIw65yCeb+Xjc08MXnoc+kGR71d3prAHs4A=
X-Received: by 2002:ac2:43b1:0:b0:4fe:3e89:fcae with SMTP id
 t17-20020ac243b1000000b004fe3e89fcaemr7009283lfl.24.1691079045584; Thu, 03
 Aug 2023 09:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20230726132512.149618-2-sergey.kambalin@auriga.com>
 <CAFEAcA9Q6N38ScEj26EYBCQH9PYrQjOgxQ3iNYNbZ5HArceYcA@mail.gmail.com>
In-Reply-To: <CAFEAcA9Q6N38ScEj26EYBCQH9PYrQjOgxQ3iNYNbZ5HArceYcA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Aug 2023 17:10:34 +0100
Message-ID: <CAFEAcA8GeRgw1xn822W6pgS8f8ZZ9CodyKfTAsvCGMvUejGM8w@mail.gmail.com>
Subject: Re: [PATCH 01/44] Split out common part of BCM283X classes
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 3 Aug 2023 at 16:48, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 26 Jul 2023 at 14:43, Sergey Kambalin <serg.oker@gmail.com> wrote:
> >
> > Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> > ---
> >  hw/arm/bcm2836.c         | 102 ++++++++++++++++++++++-----------------
> >  hw/arm/raspi.c           |   2 +-
> >  include/hw/arm/bcm2836.h |  26 +++++++++-
> >  3 files changed, 83 insertions(+), 47 deletions(-)
>
> > @@ -230,11 +238,17 @@ static const TypeInfo bcm283x_types[] = {
> >  #endif
> >      }, {
> >          .name           = TYPE_BCM283X,
> > -        .parent         = TYPE_DEVICE,
> > +        .parent         = TYPE_BCM283X_BASE,
> >          .instance_size  = sizeof(BCM283XState),
> > -        .instance_init  = bcm2836_init,
> > -        .class_size     = sizeof(BCM283XClass),
> > -        .class_init     = bcm283x_class_init,
> > +        .instance_init  = bcm283x_init,
> > +        .abstract       = true,
> > +    }, {
> > +        .name           = TYPE_BCM283X_BASE,
> > +        .parent         = TYPE_DEVICE,
> > +        .instance_size  = sizeof(BCM283XBaseState),
> > +        .instance_init  = bcm283x_base_init,
> > +        .class_size     = sizeof(BCM283XBaseClass),
> > +        .class_init     = bcm283x_base_class_init,
> >          .abstract       = true,
> >      }
> >  };
> > diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> > +
> > +struct BCM283XBaseClass {
> > +    /*< private >*/
> > +    DeviceClass parent_class;
> > +    /*< public >*/
> > +    const char *name;
> > +    const char *cpu_type;
> > +    unsigned core_count;
> > +    hwaddr peri_base; /* Peripheral base address seen by the CPU */
> > +    hwaddr ctrl_base; /* Interrupt controller and mailboxes etc. */
> > +    int clusterid;
> > +};
> > +
> > +struct BCM283XState {
> > +    /*< private >*/
> > +    BCM283XBaseState parent_obj;
> > +    /*< public >*/
> >      BCM2835PeripheralState peripherals;
> >  };
> >
>
> This gives us a slightly odd class hierarchy where we have
> two "common between bcmxxxx SoCs" types:
>
>    TYPE_BCM283X_BASE --> TYPE_BCM283X --> TYPE_BCM2835
>                      |                |-> TYPE_BCM2836
>                      |                \-> TYPE_BCM2837
>                      \-> TYPE_BCM2838
>
> The only thing TYPE_BCM283X seems to be doing here that
> TYPE_BCM283X_BASE is not is handling the BCM2835PeripheralState
> object. Would it be clearer to keep the existing
> class hierarchy where everything inherits from
> TYPE_BCM283X, and accept a little code duplication for
> the 3 subclasses that use the same BCM2835PeripheralState?
> I'm not sure...

Ah, looking at the later parts of the patchset I think I
see the issue -- because the board code wants to
embed the SoC object in the machine struct, not having
a common type for the BCM283[567] which is the same size
for all of them would mean that the board code would
also have to split rather than being common for those
SoC types. This is the downside of our "embed the structs"
style of board and SoC code, I guess.

So it's a bit swings-and-roundabouts, and since you've
written the code this way, let's go with doing it this
way. I can always come back and try a refactoring
later if it bothers me too much :-)

-- PMM

