Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 121937AEAB0
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:46:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5ZB-0003bZ-UY; Tue, 26 Sep 2023 06:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql5ZA-0003bR-OA
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:45:20 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql5Yv-00035v-JC
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:45:20 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5334d78c5f6so9484850a12.2
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 03:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695725103; x=1696329903; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9l4Z1A21bQw+9zo02BY3GbKkf5x2KImex/9xFCigwgI=;
 b=uLZVWytyBVdFvLT9Av6JuVY2RYMqKYAn2W+bX8+hKGB1bjkgd/HPoaxiIg7CZBfdgt
 ljE/tP9HwKU4I3KEgrlgm8iJBbmSEI7xnLdA+nHAUfagF2PfwNgGf44K8a8OmMd06Jtr
 K0FqsJfmjH6jtz+dxY/MPofW4odyzP0+v+aMilyhnJCuK8udOOQVNlrgVKbP0OkZmyVx
 5cYNuBa1IsQfuhJHyQnnLQaOSrrRZSkHCIv0lSfOV7AfeU6bxMuF4KQnKfZ4u1lFBl+n
 EztN/AZ4vKeeFgqqI1/0yAq8bvTAALkfboXk38Ew2lS6EZzxjCoAmoHOV7bvDiQc629p
 7jqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695725103; x=1696329903;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9l4Z1A21bQw+9zo02BY3GbKkf5x2KImex/9xFCigwgI=;
 b=hzrN2PZ0Tqj9Rw41HX/eGPACKQp3z/nqAQcFgJwOu+Nf98kPnoMgXwIuzdciadsP0T
 wJWysMrHxcK0tTkK1De+x7Fe/aiAFY0G0R9P9/Ym5PaTalVVN9ejyB5CRAb+ApL8Diqr
 XGgc6E17trciHXp0bvURa7Jh4IN6VL0WHcHNz6DOLRY6LLTV2k/O3cnEARwf8fWrBDWZ
 oXxPy9bWTJbj44+5mYICulCLwU/SmEE9ECtve47BW7fH/P/1agYzE32XbqUeiotHmywv
 7MOF26gz9bSu2MBwLgq36Ffm9mLQPbbDZNekFXhZuLJzHVr+w2GZxVJZV422Ebjkjrhz
 7xqQ==
X-Gm-Message-State: AOJu0Yzg4wRf36Z0HverQJJi37XFNoI6XeZbHqpWiUGrUTtNzE/Uxeoq
 UwOSYg5Qn9+af7GvpBsCuBj/zseVK8l54vW2A5cZGQ==
X-Google-Smtp-Source: AGHT+IEBVV/8PwRjWTKsspW268ugANfi14bXGER4ZiKgdAWsQhykEJiVwMXgd142ozUc8bdWtu5zv9+XKOH4CBinKKU=
X-Received: by 2002:a05:6402:198:b0:51e:5251:8f45 with SMTP id
 r24-20020a056402019800b0051e52518f45mr8166735edv.4.1695725103268; Tue, 26 Sep
 2023 03:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230925194040.68592-1-vsementsov@yandex-team.ru>
 <20230925194040.68592-4-vsementsov@yandex-team.ru>
In-Reply-To: <20230925194040.68592-4-vsementsov@yandex-team.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Sep 2023 11:44:45 +0100
Message-ID: <CAFEAcA-mov=mQ0QDWdPvG7xeL8_duziXhqKVRx05nYCariDMaQ@mail.gmail.com>
Subject: Re: [PATCH 03/12] util/filemonitor-inotify: qemu_file_monitor_watch():
 avoid overflow
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Mon, 25 Sept 2023 at 20:43, Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Prefer clear assertions instead of possible array overflow.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  util/filemonitor-inotify.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/util/filemonitor-inotify.c b/util/filemonitor-inotify.c
> index 2c45f7f176..09ef240174 100644
> --- a/util/filemonitor-inotify.c
> +++ b/util/filemonitor-inotify.c
> @@ -81,16 +81,21 @@ static void qemu_file_monitor_watch(void *arg)
>
>      /* Loop over all events in the buffer */
>      while (used < len) {
> -        struct inotify_event *ev =
> -            (struct inotify_event *)(buf + used);
> -        const char *name = ev->len ? ev->name : "";
> -        QFileMonitorDir *dir = g_hash_table_lookup(mon->idmap,
> -                                                   GINT_TO_POINTER(ev->wd));
> -        uint32_t iev = ev->mask &
> -            (IN_CREATE | IN_MODIFY | IN_DELETE | IN_IGNORED |
> -             IN_MOVED_TO | IN_MOVED_FROM | IN_ATTRIB);
> +        const char *name;
> +        QFileMonitorDir *dir;
> +        uint32_t iev;
>          int qev;
>          gsize i;
> +        struct inotify_event *ev = (struct inotify_event *)(buf + used);
> +
> +        assert(len - used >= sizeof(struct inotify_event));
> +        assert(len - used - sizeof(struct inotify_event) >= ev->len);

So this is something we can assert because we trust the kernel
(which is what's on the other end of the inotify fd) to only
give us a valid buffer with complete event records in it, not
partial pieces, right? If so, then we should say so in a comment.

(FWIW in the online Coverity Scan we just marked this one as a
false-positive.)

thanks
-- PMM

