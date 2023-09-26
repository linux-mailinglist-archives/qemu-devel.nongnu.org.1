Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B91317AEAE4
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:57:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5k1-0001Mh-6m; Tue, 26 Sep 2023 06:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql5jw-0001Hw-I3
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:56:28 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql5jt-0005Jw-3X
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:56:26 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-533d31a8523so6436077a12.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 03:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695725782; x=1696330582; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iILj5dJkXSsxkqU8QPToQfY4utteSbNG1IgbnYiYWC0=;
 b=H7dkJAr7CpseGjLXeZRRUdoZ2iVEjju7SqjE10LEfXAoF+EtlPYCUZ5ILeywBVkp01
 uSoKJb7ykXoI3+fN+hGiDL60Oh6mMPIwxplbC24+8MxUFit1ArOVkL7gGX5bYR9/NGdf
 7q2pj+IwkXLdHzEbspU1s7BIxY0HDITAkJ4kn7MdVtdo5cy2Sq6EGBYB0jbaIl7eur21
 AmBKZo+bHzC6TmaY/UKDwK35dJmIuPxfZifnKn0bZrxROcl/EUPgnwrDNlTLpERxNcac
 q3q5mvXaqK0+j2qiN6lrERT0f76hM7iKpzGFiP723Z0Ae7OTdNrXReQtNtUT10DZXLeZ
 VffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695725782; x=1696330582;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iILj5dJkXSsxkqU8QPToQfY4utteSbNG1IgbnYiYWC0=;
 b=LqD8IFOvlC+of6W5s0H20wrnbZmZl4fJdnh14b0nGUm3rEJV3joZ1SYk6B63viV5c/
 vuHgt+RMol0CK8X29kwq2B6E3ihV0+2uDA4++FrKuH9XK4J8qz3F5auNOmQD4zrvZG4h
 cw1rmhVCKdXa5HaHuo69kLKLBCEeFtRz5GCZ4ARPV37onMZ1sN3Hp5L2O9hFWiiiKGQ4
 8T0aiC1a0VuWveeSFTabqg0Nw1aICZUaUvnEc3yGBzH6i2UzBAE8xg15S6aIAdPLgmWm
 l4OWGQB9CnQ3LN7N/cLh0rb1ec4PJciBss1/nNeFvGgbBArA9QGJQsqzsKkCS3+sDSke
 SKuQ==
X-Gm-Message-State: AOJu0YwF5KhxjnKQcNa+e9M0CkxmnmoUfVgKd5MC52K/74XNbL5Tfo4o
 I1xxJpf1OlVo1cJoXDmJ2GzblcnZePigYsWxU2n3tvP5FS+jV09g
X-Google-Smtp-Source: AGHT+IG+pDQ3gb/l/L66IqLY6BYG0uXvqMlUGzrMmktGMnTMv2ufRAkefx5K8tk7guOjfcWF0DFJkHLHJpLZYcGd++E=
X-Received: by 2002:aa7:c6d4:0:b0:530:b86f:9c3f with SMTP id
 b20-20020aa7c6d4000000b00530b86f9c3fmr7453753eds.37.1695725782489; Tue, 26
 Sep 2023 03:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230925194040.68592-1-vsementsov@yandex-team.ru>
 <20230925194040.68592-7-vsementsov@yandex-team.ru>
In-Reply-To: <20230925194040.68592-7-vsementsov@yandex-team.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Sep 2023 11:56:04 +0100
Message-ID: <CAFEAcA-mFrbAea0KkZjT61xSEhU9P0TN=ujhNr3YPzWBA7Fayg@mail.gmail.com>
Subject: Re: [PATCH 06/12] mc146818rtc: rtc_set_time(): initialize tm to zeroes
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Mon, 25 Sept 2023 at 20:42, Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> set_time() function doesn't set all the fields, so it's better to
> initialize tm structure. And Coverity will be happier about it.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/rtc/mc146818rtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
> index c27c362db9..b63e1aeaea 100644
> --- a/hw/rtc/mc146818rtc.c
> +++ b/hw/rtc/mc146818rtc.c
> @@ -599,7 +599,7 @@ static void rtc_get_time(MC146818RtcState *s, struct tm *tm)
>
>  static void rtc_set_time(MC146818RtcState *s)
>  {
> -    struct tm tm;
> +    struct tm tm = {0};
>      g_autofree const char *qom_path = object_get_canonical_path(OBJECT(s));
>
>      rtc_get_time(s, &tm);

This is probably a false positive, but initializing the struct is
easier to reason about for humans too.

Our "zero initialize a struct" syntax is "= {}" without the 0, though.
(The version with the 0 is the standards-blessed one, but in practice
some compiler versions have not been happy with it in all situations
and produce spurious warnings.)

thanks
-- PMM

