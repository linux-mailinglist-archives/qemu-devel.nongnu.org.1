Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C156770F071
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 10:18:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1jgt-0005e9-9C; Wed, 24 May 2023 04:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>) id 1q1jgp-0005dx-Ji
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:17:48 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>) id 1q1jgn-0004xj-I9
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:17:47 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2af2e908163so8637981fa.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 01:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684916263; x=1687508263;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:dkim-signature:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tI8E4DXO1MUWzMZQWs8TEe+RROrNwJj6SPsU99ts464=;
 b=Fny+7CW0Qs2grdqVnwE2KMhh576XFJ5D/d93Vhx6SSojhHNG8Ye2xJm49a5UgHGtaL
 uK4ElqF/JS3FtHIQvnt2Fkplrf+OKYAz5EJ5GFqY7f1FUO3jgrZcAN1f6GDcL1Z22vUm
 /msHGrgNKSnv+NZVsmfzah3jtIDQwdch+8CLeTJriWMxo2XmPi4Q+kVmXPWvRhug9NPC
 xoQkaNHacBA3IT5oQW/0kPX9h7PuentbCQDGL5g19OG9k9jG92oIZ5AohAtXUIoDOXbt
 mRTw2XuKYJy5FlUflOAbjDwEDCk1p/+Hu1VdZK9Zd8IB4LTMuFyGjqT7vctFgVBlEujD
 keIg==
X-Gm-Message-State: AC+VfDyKFJa9YWye8104a/QWTL4U+NyKh2xbTIQhJx/vHjADJLLv6nU/
 fWmfbGTHbmmQkXQLySFJPwM=
X-Google-Smtp-Source: ACHHUZ6AibATxOb1mM23rlfV9v+WKtWa276eGPrlvDpceWUcmixKNOYamBqQ00mUjhp599tPRcwRbA==
X-Received: by 2002:a2e:9f42:0:b0:2af:19dd:ecda with SMTP id
 v2-20020a2e9f42000000b002af19ddecdamr6055739ljk.45.1684916263068; 
 Wed, 24 May 2023 01:17:43 -0700 (PDT)
Received: from flawful.org (c-fcf6e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.246.252]) by smtp.gmail.com with ESMTPSA id
 z11-20020a2e7e0b000000b002ac71095b61sm1926280ljc.64.2023.05.24.01.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 01:17:41 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 1001)
 id 24C7538A; Wed, 24 May 2023 10:17:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1684916260; bh=a1lvFVxclhcvKZoGKQz9Fo4IYS7nHgWKks1riNbDQEA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X3L2Tzk1iWH1iYZOxiUHK9hmn9mpDh8dfbaiuNIvy89LZzcaQu8F6mE5D2PkpfwiZ
 tqAIYGPEBenOVMyNxTxhRvAW5aSAKrLvuE63TnFI+EKRtV5ZX27/yVhYi3+kMh5S3t
 sfuzxwYJo8wMwcyTFzZ7WvCFGuPNJTglgIhMUYEM=
Date: Wed, 24 May 2023 10:17:39 +0200
From: Niklas Cassel <nks@flawful.org>
To: John Snow <jsnow@redhat.com>
Cc: Mateusz Albecki <mateusz.p.albecki@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Mateusz Albecki <mateusz.albecki@outlook.com>,
 Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH 1/1] hw/ide/core.c: fix handling of unsupported commands
Message-ID: <ZG3II3qlIjmuSZzm@flawful.org>
References: <20230416222838.36642-1-mateusz.p.albecki@gmail.com>
 <20230416222838.36642-2-mateusz.p.albecki@gmail.com>
 <CAFn=p-bcAW9aMymmWeVSMeyuT88YDZ2iYVh-t1GoogbBBPFjSw@mail.gmail.com>
 <CAGe=PKEvnnjBQVx-rNDXjmwvQ272S2DLw-xEDjp1vVuU30i4Hw@mail.gmail.com>
 <CAFn=p-bVdQ6E10F9FmapMcBvEUMX7hOjr-kz7FgfQL+cdJHV+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFn=p-bVdQ6E10F9FmapMcBvEUMX7hOjr-kz7FgfQL+cdJHV+A@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=nks.gnu@gmail.com; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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

On Tue, May 23, 2023 at 10:35:56AM -0400, John Snow wrote:
> On Mon, May 22, 2023 at 5:16???PM Mateusz Albecki <mateusz.p.albecki@gmail.com>
> wrote:
> >
> > Certainly seems like my patch is wrong as it will make the abort path
> execute ide_cmd_done twice. During debug I came to the conclusion that
> ide_cmd_done is not called at all as I was getting timeouts on the driver
> side while waiting for D2H FIS. I am still not sure how I was getting this
> behavior if the problem was actually with setting correct error bits. Even
> so I think it can be safely assumed that Niklas' change will solve the
> issue, I will try to verify it in a couple of days and if I see any problem
> I will come back to you.
> >
> > Mateusz
> 
> Great, thanks :)
> 
> I'm waiting to hear back from Niklas, but I'm hoping to take their patches
> this cycle as I think they look quite good.

Hello John,

Unfortunately, I've noticed an increase in boot time during
the initial SeaBIOS part of QEMU with my changes.

Will need to debug to see which change is causing this.

I'm at a conference this week, so it might take until next
week until I have time to figure out why this is happening.

So unfortunately, I think we need to hold off with my series
for now.

If Mateusz can confirm that
https://lists.gnu.org/archive/html/qemu-devel/2023-04/msg05552.html
solves his issue, and that it does not cause an increased boot
time for SeaBIOS, perhaps that patch could be picked up separately.


Kind regards,
Niklas

