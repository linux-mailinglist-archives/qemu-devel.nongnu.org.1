Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABBA798766
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 14:54:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeayt-0005EB-JH; Fri, 08 Sep 2023 08:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeayq-0005Dx-VR
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:53:01 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeayo-0008Hu-AZ
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:53:00 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ba1e9b1fa9so35704991fa.3
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 05:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694177576; x=1694782376; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S45oJumoIOuXOyWh1/hmNAyvyqBjI4zeS78y/NDYnKY=;
 b=EcvK6P+TYL0w3Uk26O2tJXVYJNkHktW/4vFq9oSlMCRyQGb9JYge+98cWgJYvO4Kb4
 jg7ZHCUMrn/J99CYs7AGopbd+08T5Tt4PCEk4G0ErHHSr+wDmpPcFyzUR21/DS/30530
 ElPKA7qIJ2zbWu8TaWyGvkw82Z9XfFflfHCjfrtKp7+B3vNptSAcGGu2w55o3fsnAGJI
 OQw4PINCT4i0gsckb6/Q/IhnL8BY/TeMtJbcuUgAKHqEl6eSHCPsmmhXVt/rPlZn3OJj
 GLgIwZHPJnNnm7CNKZC8VwA+Yl2yVnlfGMBMrfwWu0zCQ4rftMU5TWMlaO8OTrLnFIcF
 4FLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694177576; x=1694782376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S45oJumoIOuXOyWh1/hmNAyvyqBjI4zeS78y/NDYnKY=;
 b=nvLKXTFexS/9MFUtOR2IceBcLmjrE6c1d3Da0UxtVTgNdO5O7vceILoO5ck4wLe7Fc
 d4JyhKnkK74Qsu4v1cqeBgxQnqoLcSJsEOWi58XvH/FUFV2F5G+a0zrO0pgZJrFwTdBN
 Zi+m6pkgr5yQH1J4HnRlR6gSKJPe08fM5DrZ9+U389Yk357mp2CuL4AzqACIQMic1nDj
 gZ0OrZbF5t4R2unD2OfEcPR1mcPOA34WDNqHX//QQcxCelMF391tvQRZPC/ijNGT4Hls
 kFLifaq7Vp7sNL0XOy1Bt57p1iRA0VTipgmjlpQBWPGxtXyj4irSMUCBeHaf1UBOW0Og
 v5Bw==
X-Gm-Message-State: AOJu0YxbQCgjT/9eu98otGJxhWOir6fhRxHll0z+G/X0LGO3M2dYP4w6
 +l12jNMbOOhDTY49wBOh7bbFk2AZ0KJY54hSmZcqpg==
X-Google-Smtp-Source: AGHT+IEzCGv+YXQuJIhQ5edCywYkpojc15AzjpbBojlyvkNMWfpeIN3VTyjvHDCIwtk1Ve762Bg6nB61J1XC5VjN8bM=
X-Received: by 2002:a05:6512:1581:b0:4fe:7e1f:b044 with SMTP id
 bp1-20020a056512158100b004fe7e1fb044mr2063176lfb.15.1694177575830; Fri, 08
 Sep 2023 05:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230904162544.2388037-1-berrange@redhat.com>
 <ZPbt0io6He9mE2SB@redhat.com> <87edja9vkr.fsf@pond.sub.org>
 <CAFEAcA-OVUqhwUprR2MJW24yxWpvz9zxv7u7iGqnYhtaGNM96w@mail.gmail.com>
 <ZProov27HNpHmz5j@redhat.com>
 <CAFEAcA9sKeUmVvzPoQGCZc_GJa8vUbp58T9VnQ3F+P+Zhht9QQ@mail.gmail.com>
 <ZPsSC4K6XSJGrdIw@redhat.com>
In-Reply-To: <ZPsSC4K6XSJGrdIw@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2023 13:52:44 +0100
Message-ID: <CAFEAcA9TBJr4eC1E1izU8hZkh48VgW=0v0epK8+ZiLa3G9UudA@mail.gmail.com>
Subject: Re: [PATCH 0/1] qom: fix setting of qdev array properties
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, William Tsai <williamtsai1111@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 8 Sept 2023 at 13:22, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 08.09.2023 um 11:53 hat Peter Maydell geschrieben:
> > On Fri, 8 Sept 2023 at 10:26, Kevin Wolf <kwolf@redhat.com> wrote:
> > > I have a patch to use QList (i.e. JSON lists) that seems to work for the
> > > rocker case. Now I need to find and update all of those internal
> > > callers. Should grepping for '"len-' find all instances that need to be
> > > changed or are you aware of other ways to access the feature?
> >
> > AFAIK the only way to use the feature is to set the len-foo and
> > then foo[0], foo[1], ... properties, using any of the usual APIs.
> > So git grep '\<len-[^-]' should find them all.
> >
> > If you want a cross-check, the devices that use it are easy
> > to find (search for DEFINE_PROP_ARRAY), and almost all of them
> > picked property names that are easy to grep for.
> >
> > But as Daniel says, if you haven't changed the behaviour for
> > "code sets the properties in the right order" they may not
> > need updating.
>
> I'm replacing the 'len-foo' and 'foo[0]' etc. properties with a single
> 'foo' property that takes a list, so the callers need to be adjusted.
> The devices can stay unchanged, though.
>
> > (I would be happy to see the rather hacky implementation replaced
> > with true support for list properties at the qom/qdev level.
> > But the hack is there because it was simpler :-))
>
> It's not really that hard, but it would probably have been even easier
> if we had just used the list support in the visitor interface from the
> beginning instead of adding this hack. (Though obviously that wouldn't
> have worked for user creatable devices before we added JSON support to
> -device.)

If you'd suggested it back in 2013 I'd have been happy to do
array properties a different way :-)

thanks
-- PMM

