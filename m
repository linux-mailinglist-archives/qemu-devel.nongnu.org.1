Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B73F773AF8
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 17:24:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTOYk-0005Oj-Q2; Tue, 08 Aug 2023 11:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qTOYj-0005OY-5z
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:23:45 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qTOYh-000326-Ko
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:23:44 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fe0e34f498so9601460e87.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 08:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691508221; x=1692113021;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZHbtE8TI3cZ4Y9+6i69+57QAQZKC+yWVp4Ljpbl9GrU=;
 b=dRgWAjKpV2NwmGWeZr0HzRnn2drQatYTQksGMT9un0KM0eGMUKZnQOBvNaBV0K5N5T
 mjOUq9ZmyNW8wqsK/2Dw4S69PM0GDvHlj1l7pre9TtzXNO2qjITMYuILBPdmn7hIWKp+
 1MED2UJMEfWa7B8ef/U1PKYHF3DC+XF/hwBLvY49J/aYLm5G0Doo1dI3CvS3x2UJUBSl
 T9wuTpKwPTomvqMVT478OXyGVFOLex9bUFl5F079NFYKBQkG8KsytijyTeap0yl4Gjwt
 Zarowv57Zh/HPyv5iF+q8caKjQw6M6qOmKj7HTtLyZKJbdxXsBuNlKeMvxyJ0vdnswV4
 7Ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691508221; x=1692113021;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZHbtE8TI3cZ4Y9+6i69+57QAQZKC+yWVp4Ljpbl9GrU=;
 b=F5eI6nBn1odPPVw1//w4Mw9TYsl/XIwBei84RqDPW2sou0SprfpDPx3Bey2y1fmAoa
 O9yZfgFsGc4xN+3vGqKV3iXSUGZSjQbngaI2nuPYNBOlSNLVz+MkhtJZquwXquJI5hGu
 E5XLRWFgmDNgI2lmtuExNqFX5T2nlU74t4kotTzLpOXX03kvK3PaHuvE74Dv8JYnK8lB
 jmnILp6kddx2C5+l0GibUXHF7Lf4enNXAuNgNboIlF3TBR/Y5AOSW84LGe47SPmGAZzy
 WU23yOP/iyZJxLMzKjnUcU2Y+AR4k8a7u7WohXBakROIgjhFD/FxH/SxfRQNtpYLihLP
 VWIQ==
X-Gm-Message-State: AOJu0Yz16/wCos3wPgNgz4CSPqcTvTxLBtMn698m38os+qY0RwbsUV7C
 qTY29gILPJB5U9C+yyu86jWeQiJZ8ST3SsRxjURdOQ==
X-Google-Smtp-Source: AGHT+IHKneLR09jVn4uqup3IjkIX/jcoHgYXLv6iUTDMC3prTy3MWzVTcCYoHCB6Pv4Ri8FLmuX7AbPi0hLKyy6BTZU=
X-Received: by 2002:ac2:4e8c:0:b0:4fb:7666:3bbf with SMTP id
 o12-20020ac24e8c000000b004fb76663bbfmr8106343lfr.26.1691508221281; Tue, 08
 Aug 2023 08:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230808152026.100096-1-akihiko.odaki@daynix.com>
In-Reply-To: <20230808152026.100096-1-akihiko.odaki@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Aug 2023 16:23:30 +0100
Message-ID: <CAFEAcA-YuQBkoSE78jMzVFXt5GuJHYAO36U2okHbn1_hSXHkzg@mail.gmail.com>
Subject: Re: [PATCH] util: Delete a check for IA-64
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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

On Tue, 8 Aug 2023 at 16:21, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> HOST_IA64 will never be defined since IA-64 host is no longer supported.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  util/oslib-posix.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 760390b31e..f7adb36dfb 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -618,10 +618,7 @@ void *qemu_alloc_stack(size_t *sz)
>          abort();
>      }
>
> -#if defined(HOST_IA64)
> -    /* separate register stack */
> -    guardpage = ptr + (((*sz - pagesz) / 2) & ~pagesz);
> -#elif defined(HOST_HPPA)
> +#if defined(HOST_HPPA)
>      /* stack grows up */
>      guardpage = ptr + *sz - pagesz;
>  #else

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(There's another one in include/exec/user/thunk.h.)

thanks
-- PMM

