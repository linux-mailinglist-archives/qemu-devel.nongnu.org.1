Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA397263B3
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 17:08:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6ukq-0000yy-GR; Wed, 07 Jun 2023 11:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1q6ukm-0000yh-1c
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:07:16 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1q6ukk-0003r6-F7
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:07:15 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-bad05c6b389so9475694276.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 08:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686150430; x=1688742430;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x2tZKNg/N18lBhSyZJdVvUxai/+n5xOKK0LlYnVhuyU=;
 b=PRo/fz0LbLVJEl7Crm0ATqx48v7AdAbTjWkqpGyoGJmeup39Kz319W7svFMAIc0NYU
 TcSs8O1tqIG7/89/ZlGlw/Yx8kEkm/Iw76CejGce0YE9dg/sUUj/sZV3YCV4HiIUopz7
 nC0u78lkQVbc4hQnXAf3/slMAur5SNroq06WlW07Wd9DSOXeC+VRaG/ryhmDcyGckshw
 puO0FI5komCzHQGQj1/TK808P1jym27YcLflCqwJ0liv6qVj2eEU69nHYNRI532hGIex
 SP4eSlBBLEOn2lq+jKad5kloQaJ5FhX6YX+3z/i8n0jHX7wpSaEazlLiRXZnDcURH/g+
 0xWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686150430; x=1688742430;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x2tZKNg/N18lBhSyZJdVvUxai/+n5xOKK0LlYnVhuyU=;
 b=b0DWzYR6eeaL6E3eFLpJyY+9gh4VkVdU7eClaWVfJkIcq9L3uW0xK7cLgzSfbDA2EZ
 6I4t/AFTtfajACPy4lArVfoNJSv7oLqQbyQZcYx/W3EPYcGRSOp1saDmaS0xfULOqBls
 7/NUcIIPQLRLG6ditKubG8jJ+34jsRPqEe6Qqo87L5CRcZlJsiaayxqp/O/aRZedGrNG
 utTigFt/tpR61niijSbRueYqGvvTVhCvFcUhUE/3cWAyLUlXUClPibguVAKaStV4Fj0N
 tTPuwFODIOtt+KWFxYvwUm/P22++AJaBj1gN5rnZ5ZoiPtHwJ0l0xnT0bXetrXiLe31s
 PqxQ==
X-Gm-Message-State: AC+VfDxuWMB4vokc/KnwyBALwN+orIf3QYwvAZkwwfP9Ov4qVuh0VLeB
 DLYxQQInc/0RpIsgHo/n7tL4Qc/GMUky0HUt54E=
X-Google-Smtp-Source: ACHHUZ7g5qjlo1XRa8rGw+yoSz+dxKIUzkK4awMhDmL2/e6//rz7RuvAdtCGYL7WpnhPtvNGScIS2AjgXC7eBu8+AjA=
X-Received: by 2002:a25:810b:0:b0:bad:1468:a928 with SMTP id
 o11-20020a25810b000000b00bad1468a928mr6686895ybk.52.1686150430191; Wed, 07
 Jun 2023 08:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230606162556.58110-1-richard.henderson@linaro.org>
 <9be02919-305d-9373-e26c-9d3e9c1a8421@yandex-team.ru>
In-Reply-To: <9be02919-305d-9373-e26c-9d3e9c1a8421@yandex-team.ru>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 7 Jun 2023 11:06:58 -0400
Message-ID: <CAJSP0QVhr29HWyyHxD86K=wDXwmEzNgwidQXj5CNgR2ZGvCx+A@mail.gmail.com>
Subject: Re: [PATCH] gitlab: Disable io-raw-194 for build-tcg-disabled
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 stefanha@redhat.com, berrange@redhat.com, jsnow@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=stefanha@gmail.com; helo=mail-yb1-xb34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, 7 Jun 2023 at 10:39, Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> On 06.06.23 19:25, Richard Henderson wrote:
> > This test consistently fails on Azure cloud build hosts in
> > a way that suggests a timing problem in the test itself:
> >
> > --- .../194.out
> > +++ .../194.out.bad
> > @@ -14,7 +14,6 @@
> >   {"return": {}}
> >   {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> >   {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> > -{"data": {"status": "postcopy-active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> >   {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> >   Gracefully ending the `drive-mirror` job on source...
> >   {"return": {}}
> >
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >   .gitlab-ci.d/buildtest.yml | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> > index 0f1be14cb6..000062483f 100644
> > --- a/.gitlab-ci.d/buildtest.yml
> > +++ b/.gitlab-ci.d/buildtest.yml
> > @@ -236,7 +236,7 @@ build-tcg-disabled:
> >       - cd tests/qemu-iotests/
> >       - ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032 033 048
> >               052 063 077 086 101 104 106 113 148 150 151 152 157 159 160 163
> > -            170 171 183 184 192 194 208 221 226 227 236 253 277 image-fleecing
> > +            170 171 183 184 192 208 221 226 227 236 253 277 image-fleecing
> >       - ./check -qcow2 028 051 056 057 058 065 068 082 085 091 095 096 102 122
> >               124 132 139 142 144 145 151 152 155 157 165 194 196 200 202
> >               208 209 216 218 227 234 246 247 248 250 254 255 257 258
>
>
> There is actually a bug in the test, I've sent a patch:
>
> <20230607143606.1557395-1-vsementsov@yandex-team.ru>
> [PATCH] iotests: fix 194: filter out racy postcopy-active event

Awesome, thank you!

Stefan

