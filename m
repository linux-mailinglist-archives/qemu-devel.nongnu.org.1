Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CBB7692E9
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 12:18:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQPyM-0005mU-PB; Mon, 31 Jul 2023 06:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qQPyE-0005mA-NI
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 06:17:46 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qQPyC-0005K2-Sc
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 06:17:46 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-99c1d03e124so65790866b.2
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 03:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1690798663; x=1691403463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jPKjNnWPKLpaO84MQ0YUL99FRPvOe2hpQ+c3iyY9xbE=;
 b=HdoK2ErNh1kd8WPEOBa+7dwKcf2juxm34u49Oeld6feswnjaO1xjFZEi+tLWG9HOAT
 T//CPOozFHjxQTVlcr7BQ/nzWNTlPLuNzN7g6skhOE6jEdlTjgVil9Ti49p7f1JWJ0wk
 ZtyNu2ZzbJwWY/7ZlXNH0Y5T2mfPK46f4mijg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690798663; x=1691403463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jPKjNnWPKLpaO84MQ0YUL99FRPvOe2hpQ+c3iyY9xbE=;
 b=g42o71A27UYEIMFbHeosgdyr2xk0YyqQFoSdtD/t4MxtggtrVgS8T2tKmNGQbBPKJv
 r+nabAJauOmBcwyKjt/9AfgcqQpx9WsJeq4ODi2wsYk49iJwu2yYliw8u1zDL+uuoslq
 qQ0S/JKxRyK3z2P7pftg6TJhyZFjIcl2jmH285ST1J7hgCFc9IULX20HEH1xXSyJdrND
 dmS950EJ8EM1YBTJYeqAOqchYqXYDHfJTHhcqqnp1X1hwLOcR/MOABjhPb7B1eYczaU8
 RunRgb4C9cwiU86K3EMef70xwjAnZ7Mn4S5dwSl5VQMjZ2Z6By193pZ64yE3+QwhWVWB
 ycnw==
X-Gm-Message-State: ABy/qLZ8JlZAy2UN8jEb+2AvF51QarPqEjfBWktdxgqA6HdyyHi6zuc1
 CNcsL3BLaHuaCbODFeysTSoYI9j7bHDZMyJ9HHs=
X-Google-Smtp-Source: APBJJlFYtXA+eMwJbbwXHcki1EVguoWDNZW06IvnXLTF7CL0wteIjHX0jljiilxlUcLYHdUQhCKAKQY8ZpQqkD3sTEg=
X-Received: by 2002:a17:906:291:b0:992:33ba:2eb4 with SMTP id
 17-20020a170906029100b0099233ba2eb4mr6084025ejf.71.1690798662967; Mon, 31 Jul
 2023 03:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230731080317.112658-1-akihiko.odaki@daynix.com>
 <3088d223-64fd-9aab-3c08-000f0924607c@tls.msk.ru>
In-Reply-To: <3088d223-64fd-9aab-3c08-000f0924607c@tls.msk.ru>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 31 Jul 2023 10:17:30 +0000
Message-ID: <CACPK8XfcOkn281JZNYc7+AhDAxP_N9__G4Snxtx=ZhXgVChXgg@mail.gmail.com>
Subject: Re: [PATCH 0/5] linux-user: brk/mmap fixes
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, 31 Jul 2023 at 09:31, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 31.07.2023 11:03, Akihiko Odaki wrote:
> > linux-user was failing on M2 MacBook Air. Digging into the details, I found
> > several bugs in brk and mmap so here are fixes.
>
> There's another work in this area by Helge Deller, have you seen it?
> ("linux-user: Fix and optimize target memory layout", a v5 already).

Applying this series fixes the qemu-arm running the static armhf
binary on my ppc64le host that I reported here[1].

Tested-by: Joel Stanley <joel@jms.id.au>

The changes conflict with Helge's patches, so it would be good to work
out which of your changes should be combined with his.

Cheers,

Joel

[1] https://lore.kernel.org/qemu-devel/CACPK8XeyqcEDyyL3Jw2WYWs_gGdtTCf2=Ly04CMgkshSMdj7RA@mail.gmail.com/

