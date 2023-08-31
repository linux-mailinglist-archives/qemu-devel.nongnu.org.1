Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C1978EFD2
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 16:55:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbj3y-0001oQ-E9; Thu, 31 Aug 2023 10:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbj3m-0001nn-Ug
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 10:54:14 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbj3k-0001mP-8D
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 10:54:14 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-52a3ec08d93so1146164a12.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 07:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693493650; x=1694098450; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2wEWAeSU+xhAZFakzZbQNkD6WWYDXkiKXFY/AdXwAUY=;
 b=VuvxTrhRSIt23AUBu9xRTzOXKRWu+f1QwOv9hyH5MthKoQpX7/HsgWAssCxHvqrQgw
 en/g9yvBG/JbwKKk09yZbXKhuw4QYwxMkJE/PdXIrNiHUPRK7B5CtiZ2Wd0dMkPO0D8l
 NvWj1yO4InXm/yk/ylwmRkUNVr6utEQacFwDj5WQiQeGxOUSwUs1ed996J/G+vkRdzb5
 WWyImmUZmQv6NFUdyR6SCDslPLpxh1vIGnoMfxI/9AHBIeV/1/bVr+z+Z/ixX7MxpuSx
 KJim567LMVQMDzK93ugPNN5dwpZZYBi8RDwtKDtWusYnp8W5dBYARPW+VhZX31kWD+HK
 1ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693493650; x=1694098450;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2wEWAeSU+xhAZFakzZbQNkD6WWYDXkiKXFY/AdXwAUY=;
 b=DVq0EUiQl86xmWjXL3La8Db+CgErEIigSOP27bqQG+P3dFYfibUYnn5ldirPfxGl7I
 5uxaw28o4BeE6fS2PuQ4HFdiKeerqose0S16wRetr0EbanmmCBD6Qu33z+VfxoGm+EMD
 U/ik9D5omvP1DvL5nJXhJK2OW3dT8FLhnuc/14kKoRA+u8GSa9n9dxJtfzB+CZYPGPo5
 p70pBTq29diiBZRkRebyGhg69JnpZKAKCmyvuAz7N4M2CrprcpDl5ic8eAYn6HfxxJmT
 VBkmB5ngbQn15LD4wblJrSJ8marCQ9kIJ8Su2Z14tuge7HqDMK5x2IH4aWRd7v26xKiC
 HtWg==
X-Gm-Message-State: AOJu0YzEP7fXtAWJ9+Gy25sw6SEmReNNfY1MXwGLnVOTYTnSElYVOOw6
 GkzkTYdV4Xu1kI0ch5X0roTA4WZS57qFs1GG3gJIkg==
X-Google-Smtp-Source: AGHT+IFqT8KTaZoEKWvPQ8gzuOKgMSnOVcBh2vLKZ3yJ/Ezgic6ziyRaHhtm93rngv6BIta49p6MDa1m6R6t3HSfp6Y=
X-Received: by 2002:a05:6402:1604:b0:522:3a37:a463 with SMTP id
 f4-20020a056402160400b005223a37a463mr4323944edv.20.1693493650556; Thu, 31 Aug
 2023 07:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230831132546.3525721-1-armbru@redhat.com>
 <20230831132546.3525721-4-armbru@redhat.com>
In-Reply-To: <20230831132546.3525721-4-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Aug 2023 15:53:59 +0100
Message-ID: <CAFEAcA-0yYGkeg1gOtz8GRp-DbaxMQCzhRf=B4rq=Bz_DrsxNA@mail.gmail.com>
Subject: Re: [PATCH 3/7] ui: Clean up local variable shadowing
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com, 
 eblake@redhat.com, vsementsov@yandex-team.ru, jsnow@redhat.com, 
 idryomov@gmail.com, pl@kamp.de, sw@weilnetz.de, sstabellini@kernel.org, 
 anthony.perard@citrix.com, paul@xen.org, pbonzini@redhat.com, 
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com, 
 philmd@linaro.org, stefanha@redhat.com, fam@euphon.net, quintela@redhat.com, 
 peterx@redhat.com, leobras@redhat.com, kraxel@redhat.com, 
 qemu-block@nongnu.org, xen-devel@lists.xenproject.org, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Thu, 31 Aug 2023 at 14:25, Markus Armbruster <armbru@redhat.com> wrote:
>
> Local variables shadowing other local variables or parameters make the
> code needlessly hard to understand.  Tracked down with -Wshadow=local.
> Clean up: delete inner declarations when they are actually redundant,
> else rename variables.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>


> diff --git a/ui/vnc-enc-zrle.c.inc b/ui/vnc-enc-zrle.c.inc
> index c107d8affc..edf42d4a6a 100644
> --- a/ui/vnc-enc-zrle.c.inc
> +++ b/ui/vnc-enc-zrle.c.inc
> @@ -153,11 +153,12 @@ static void ZRLE_ENCODE_TILE(VncState *vs, ZRLE_PIXEL *data, int w, int h,
>      }
>
>      if (use_rle) {
> -        ZRLE_PIXEL *ptr = data;
> -        ZRLE_PIXEL *end = ptr + w * h;
>          ZRLE_PIXEL *run_start;
>          ZRLE_PIXEL pix;
>
> +       ptr = data;
> +        end = ptr + w * h;
> +
>          while (ptr < end) {
>              int len;
>              int index = 0;
> @@ -198,7 +199,7 @@ static void ZRLE_ENCODE_TILE(VncState *vs, ZRLE_PIXEL *data, int w, int h,
>          }
>      } else if (use_palette) { /* no RLE */
>          int bppp;
> -        ZRLE_PIXEL *ptr = data;
> +        ptr = data;
>
>          /* packed pixels */
>
> @@ -241,8 +242,6 @@ static void ZRLE_ENCODE_TILE(VncState *vs, ZRLE_PIXEL *data, int w, int h,
>  #endif
>          {
>  #ifdef ZRLE_COMPACT_PIXEL
> -            ZRLE_PIXEL *ptr;
> -
>              for (ptr = data; ptr < data + w * h; ptr++) {
>                  ZRLE_WRITE_PIXEL(vs, *ptr);
>              }

For this one I'm tempted to suggest instead moving the
pix and end currently at whole-function scope into their
own block, so it's clear these are actually four
completely independent uses of ptr/end. But either way

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

