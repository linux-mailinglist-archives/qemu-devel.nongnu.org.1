Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B951F7E6EA7
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 17:26:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r17qM-0005sw-JI; Thu, 09 Nov 2023 11:25:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r17qK-0005rV-0b
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:25:20 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r17qI-0005d4-Cy
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:25:19 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53dd752685fso1680445a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 08:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699547116; x=1700151916; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/2uBjKrecsVQfmngG4qwT9L61EL9vacXq8BtvBHOyHM=;
 b=vY4iMLwHSGgYEcdx/XaZ4dAuRvUlpiVLeRsv9YaH/qozPJhCsnCrCyMLTGB9OZ4aBB
 Pt3i5tkM7cYyJRXGlJOHJfChe7csKoT3CohccgxVoduzf6F1kWX4ntkpDvqIvo12LoqZ
 315QxnFrIsX8vgUGR0RAlrz621J/7Ok9V0vaxQn8RENzDBpFAOPbpojfsVTL1FZO0gn7
 yWGSmO6ycEJJI7N1CovAIY4W3/VTPwZb5od5GcRV3TC18oBHSbOiEkU6GXwrSqJE0Asn
 l0XIf2m1zqwGYes7KV77tSq0XAY5ACaEipJkFVtM8M4il8W67WcyF63GJadOxdHcEAgF
 NRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699547116; x=1700151916;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/2uBjKrecsVQfmngG4qwT9L61EL9vacXq8BtvBHOyHM=;
 b=v/0vJqOVvA+RpSBbbcaVjSQGEQNw0twKZtJFN8lfpX+y6q9ovcu1iqZdrQ9WXCszqM
 onw1RKt1xNm+9tyZhqb9kS9m2CcLrx7iG8GPInFLbJBVzRFvowsgyom86B4pt9JVnrjd
 NFizGwfXZbwE7SWJDA50NqoXvz5Rjc8Q48+xxuqkFXJUpy3bIc7hBTOCVql37Q/Feucn
 WJlR9M/MTPYmKHbIRhYh/OIYJGNit9weNzsVO0XwvvDjMKIefvdHs3K08ObLbbsy1t2p
 upD6YCrn79HDKL4yZpUG+dEaW7zDu2uRNKRKC3XXPrC0Hm3pRkN09mmmtmM+rfLmLTRT
 JW2w==
X-Gm-Message-State: AOJu0Yz+GlZcHSitxQrkisNOXVitCjzemsCDhWQCpofxkuGTyzrkJKco
 DUC0eYJMpV1SI/0F8IyRTBCktRpeiyA0nMbnM5gW9gDeRnv/oCuM
X-Google-Smtp-Source: AGHT+IHhg+s/F2c3hD/8cntJqaRSxnPbuzJpNbe1H1qgzn0zkBVdNOB+1JGnOVAEt5qU6G7Bp8lTnJEBhMjnwz/T6BE=
X-Received: by 2002:a50:aa8b:0:b0:544:9887:1031 with SMTP id
 q11-20020a50aa8b000000b0054498871031mr4237104edc.38.1699547116059; Thu, 09
 Nov 2023 08:25:16 -0800 (PST)
MIME-Version: 1.0
References: <20231109162034.2108018-1-manos.pitsidianakis@linaro.org>
In-Reply-To: <20231109162034.2108018-1-manos.pitsidianakis@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Nov 2023 16:25:04 +0000
Message-ID: <CAFEAcA-XqkBqKt33pxXHv0Y81kShV1rZatgAYMJNxibBD1a_6A@mail.gmail.com>
Subject: Re: [PATCH] virtio-snd: check AUD_register_card return value
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Thu, 9 Nov 2023 at 16:21, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> AUD_register_card might fail. Even though errp was passed as an
> argument, the call's return value was not checked for failure.

For whoever picks up this patch: we can add
"Fixes Coverity CID 1523899" to the commit message.

> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  hw/audio/virtio-snd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index a18a9949a7..ccf5fcf99e 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -1102,7 +1102,9 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>
> -    AUD_register_card("virtio-sound", &vsnd->card, errp);
> +    if (!AUD_register_card("virtio-sound", &vsnd->card, errp)) {
> +        return;
> +    }
>
>      /* set default params for all streams */
>      default_params.features = 0;

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

