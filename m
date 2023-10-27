Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EA97D9F5D
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 20:07:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwRE3-0000tZ-Oz; Fri, 27 Oct 2023 14:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwRDz-0000s4-2i
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 14:06:23 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwRDx-0002Fn-8o
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 14:06:22 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-53e2308198eso3745764a12.1
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 11:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698429976; x=1699034776; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dZ0HVCGUoSqUuHn4Y9bG/S0MV8oUMXOD/+AEX3E49U0=;
 b=rYFYMQha7OtzqO1hFtOC8gMslbW+U+apsJ2UXNZrccMfVu+Oo4kJohOrX7rDxIxkuC
 uxjoddyUtkOsEAUIm+36MvP5lFbuOBZoseccOPLvw2CEeU4FEOHsa3WuMEXUkdiNEIqE
 baRA3nca+Co7L3yLs3AUSnAwz+jtnE/px2Ab4XK5Y9nA6fyvjUY2+cdZZpLWh+z5xnWN
 edIEEd5lJYUdHUnU/6qEG4gtD77g9mIId5CgkmgLkOJ8Ix5R7LxE2PFVoGFauncBWT4i
 1QRda7xDfJXqkAYwM1J3dhpSvsrGIsnlvo9nRWt4mUmo26LcNVwpTjoAS0kPcC3AHrUO
 /Mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698429976; x=1699034776;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dZ0HVCGUoSqUuHn4Y9bG/S0MV8oUMXOD/+AEX3E49U0=;
 b=Yo7iBpE9I7BXnasf25+gWwFFYRD5T41K1uscIEN+axQ1N8KYnY2wZa3pM1sTQwt3yr
 N2XEaSm96IChCZHknj4AUTQTEV5B0RO7CIA9H+y7l7sMu8Er9QssLRBFm16ZFVt96NHN
 HDy2Btd0ou/bcM9TjmAecUw1RhV127nIV1s9X8x/hcU3PEQ370MplPhQIDLM6nspfQjW
 pk/qvYoDHmTmq8ovMtSnQBDEzRv2ZIYEl/FT8sSGXLUz4icwzmI+dVUYsL3S9QQgnUxQ
 bIv0CIJqvIQjYYfagCMH8UF2DfJi2P+luQe2nSe0Y6c5M++k+Vumd0SnnNWu3/TaB5DH
 V3XA==
X-Gm-Message-State: AOJu0Ywt16d9vxelsG7eVwhIvEm5kkhpqEr3ejUPH7YTOxdc/anHx42b
 yYH3r1Tx6n0cbvpuUB8Bf/usz4/49fPD2kqYp9NRBw==
X-Google-Smtp-Source: AGHT+IF/cEBEih0e1GREX/Kq+mMrwYrz5nKHkJR0WoAUe4mgF6hqS0Xtk/rVQdDQGI0aid3hPUyehtyvabbudiKN1rc=
X-Received: by 2002:a05:6402:1049:b0:540:c989:fcdd with SMTP id
 e9-20020a056402104900b00540c989fcddmr2816251edu.11.1698429976657; Fri, 27 Oct
 2023 11:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230908143703.172758-1-kwolf@redhat.com>
 <20230908143703.172758-2-kwolf@redhat.com>
In-Reply-To: <20230908143703.172758-2-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Oct 2023 19:06:05 +0100
Message-ID: <CAFEAcA9nEvr+ALhhMC3L62hyuKo6s3AfsJXb==QOq6_-SRws9g@mail.gmail.com>
Subject: Re: [PATCH 01/11] qdev: Add qdev_prop_set_array()
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Fri, 8 Sept 2023 at 15:37, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Instead of exposing the ugly hack of how we represent arrays in qdev (a
> static "foo-len" property and after it is set, dynamically created
> "foo[i]" properties) to boards, add an interface that allows setting the
> whole array at once.
>
> Once all internal users of devices with array properties have been
> converted to use this function, we can change the implementation to move
> away from this hack.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/hw/qdev-properties.h |  3 +++
>  hw/core/qdev-properties.c    | 21 +++++++++++++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index e1df08876c..7fa2fdb7c9 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -206,6 +206,9 @@ void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
>                             const uint8_t *value);
>  void qdev_prop_set_enum(DeviceState *dev, const char *name, int value);
>
> +/* Takes ownership of @values */
> +void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values);
> +
>  void *object_field_prop_ptr(Object *obj, Property *prop);

Are we happy enough with this interface that I can take this single
patch in a series that I'm doing (v2 of
https://patchew.org/QEMU/20231017122302.1692902-1-peter.maydell@linaro.org/
"arm/stellaris: convert gamepad input device to qdev"), or should
I stick to the old style "set length and element properties by hand"
code until this whole series has passed patch review (thus giving
you another item to add to the conversion list) ? I went for "include
this patch" in v1, but this series has spent longer in code review
than I was anticipating at that point.

thanks
-- PMM

