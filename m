Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFE1766D2D
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 14:27:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPMPG-0000Fe-E0; Fri, 28 Jul 2023 08:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qPMP7-0000Ey-9G
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 08:17:15 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qPMP5-0002BW-JP
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 08:17:09 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4fe0e34f498so3404925e87.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 05:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690546624; x=1691151424;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/ELjSVLZH84qOfiJaoEtC1L28zvAhOz5ZAuKlibG+0k=;
 b=UoRnMeM4E28DqkG64MYrJ+ZmoZQ+xuxM+6M27UfoQKgEZGbooqQKFVTRYxtHM4Ll/u
 Tw14LCVYCPstaEsowjADzgwvNDiQdOy2q9OL8q2IlbXYehfRxj/zXfAE9weKDeUTpIcX
 8ktM8BahrAn2FoGxT1SVIoo3atdM2WQy2ehk0wfLRV8AdtrXavtiuob4DjiEkPqbNDUS
 PArHfA5TksykQFYctL/CoAqjs8Gwq/Sy0XZJph8HCV2tuEjdXsohjo0pkiEdlqqrKIYq
 a/plKAZ0tC1sy+Q6FYMcpsORjaNfVy4iDYPPMVe5i4PWXqxhoVxorO+/Gr/l+11z6fST
 Kqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690546624; x=1691151424;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/ELjSVLZH84qOfiJaoEtC1L28zvAhOz5ZAuKlibG+0k=;
 b=iyjUff3zzhEW+gRmp3owEajRCB/C9KCfPj+5DzROFKpLo+gm2mflM6z0gmOllpjxbK
 lMmBcqPPvMjDR6OvizU65IY9LZE73oOY1L9p9x/SLySBGN6gkvjJQK5uChLrkkVBlVSq
 /e+FcePFYmcWjlmnfQCu3g/U1vj0dZmrQ+FizINOkUU0iw+RbVU+8byiVgsNHAwPNSUG
 rLMPoV3lu5X5NyFGO+fucPGH3zK+89bykbBdyyV2kCEMrSKKeYYy9Zh+7awojmncfHil
 HRwEog7gHhzQfBe0Q20jFWAvMI8R+Bl+MH2JFUQfAJcLBboKM70iXycKBiGE8qPZkuyT
 qLwA==
X-Gm-Message-State: ABy/qLbgXK+Lu+Ehk8/Wu/+8bL6td/UtWEF6fPvj+qsDMn3QWXBzBodz
 gbRbZhbxJXPBTYcv1kTNBKImp1/dcYkiPgRJDrL35w==
X-Google-Smtp-Source: APBJJlEcpyMKSbSqsTJBVML/FH8fqTnt5M9QnXG4p+NfKURBbgCDuurkrtS/lbKYAKpVGHSpw4Nj7jUh8C26ca79sLY=
X-Received: by 2002:a05:6512:543:b0:4fe:676:8bf2 with SMTP id
 h3-20020a056512054300b004fe06768bf2mr1509923lfl.10.1690546623651; Fri, 28 Jul
 2023 05:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230725080630.1083-1-dinglimin@cmss.chinamobile.com>
 <20230725090039.1271-1-dinglimin@cmss.chinamobile.com>
 <106cf02f-f746-e216-22be-8f7594028695@tls.msk.ru>
 <CAFEAcA-ErMrk60uZMu8M-0G15aTvhOZsYsvJD1F-YbLGOFDBYA@mail.gmail.com>
 <E1qOWH5-0002Du-U6@lists.gnu.org>
 <CAFEAcA8UdN4-DU4dAiY3VGLA77mLK-ohfFJs5+5fDt3v1mAAcg@mail.gmail.com>
 <9a05f370-1857-2c28-a184-a5197455b314@linaro.org>
 <CAFEAcA-4qzq7hivk-vuZMfxOaMXU7zusATtotiashNqrSbupSg@mail.gmail.com>
In-Reply-To: <CAFEAcA-4qzq7hivk-vuZMfxOaMXU7zusATtotiashNqrSbupSg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jul 2023 13:16:52 +0100
Message-ID: <CAFEAcA9KV4A3pEOZHousHCgD57-pnsmMxPC4EYoiSUSeYh6-bw@mail.gmail.com>
Subject: Re: [PATCH] semihosting/uaccess.c: Replaced a malloc call with
 g_malloc.
To: Richard Henderson <richard.henderson@linaro.org>
Cc: dinglimin@cmss.chinamobile.com, Michael Tokarev <mjt@tls.msk.ru>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 27 Jul 2023 at 15:56, Peter Maydell <peter.maydell@linaro.org> wrote:
> The only real reason is just consistency -- the project uses
> the glib malloc wrappers, and in theory any use of raw
> malloc() ought to be either:
>  * something that's third party library code (eg libdecnumber)
>  * because it's going into a standalone program that doesn't
>    link against glib
>  * for a special case reason which is documented in a
>    nearby comment (eg because the memory is going to be
>    passed to some library which documents that it will assume
>    it can free() the memory)

I wrote up a gitlab bite-sized-task issue for the remaining
conversions which goes into a bit more detail about some
of the pitfalls to watch out for, and made the bitesizedtasks
wiki page link to that:
 https://gitlab.com/qemu-project/qemu/-/issues/1798

thanks
-- PMM

