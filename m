Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE757E5E18
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 20:03:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0noz-0000IR-5b; Wed, 08 Nov 2023 14:02:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r0noy-0000IH-6N
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 14:02:36 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r0now-0007Q5-BN
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 14:02:35 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53d9f001b35so12197034a12.2
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 11:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699470152; x=1700074952; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JnS6wYPpg8/Dds0iazqskWjGNdrqiXhb4tjP8jVnjQQ=;
 b=TA6FKiy2ZgNSMDmw4JFgDjiWgLrcI8V2UK6mYUbktAmkwJ6QqzbnpATFBTrNUhQL3X
 7488Rht0Ez7zqLUW87pvC9ndA0n7EG8ahFKlyWQNOWJR7i9mTZtb+OOEvBnzyQZzox5i
 In8sFLMVXlncr5o95f6ptzv1vtjm+rewtYe03HCROP40UewTrkdUb+Xc8W4/DLUuA32F
 K/O1NylI+9R8AKc2g/sbCBsN81kuLDpZAYInva9Jyw3hzwiCXaD/xw/urMCXREnS6Bi3
 Zft9pQzJ74+K+ur4pexNL3DTiv7zFqoPWAu60lShV1qfKk+Ph52BaxIix36MrtpBymNb
 Q0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699470152; x=1700074952;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JnS6wYPpg8/Dds0iazqskWjGNdrqiXhb4tjP8jVnjQQ=;
 b=CR43O4MsMgJ0Ja1XyGMqYjPrpz10cwn+F6GFv61BEdDGa1t+uPqa35UlQI4VX+3d97
 jzWtWzOuUowlakvyTtb2ETdvaH/Kpf4mtYWldMi88MPQxfEq2L70uD3xNks3rQjEP5Rm
 UdnBAsPtQq5mCUTZnVEp8EzCVgFDO99BY1WraDQydWj0MZnChduGK2+/Q2ev0iqRTmKM
 nfwAYR01pkbpH1rsdbLpA5QbQLcuw1TYif8R5ck0eF5t0pczS8Bw6s8YZk4bASD00K/y
 Z3Ok8JX6/kmprucye5+PppoTFjNILUPIFmsAlJsXAuFep5C5czo71e0Us7VOLgAZcEvD
 dxqw==
X-Gm-Message-State: AOJu0Yx5tqBBT2N0KylnV3Tk0uqugYhFsHGk9F843VpVcb58mq0m24vH
 iWAtBeUjXUgfpMTxafWwdpR/GE29zcfymi9Tb64TKQ==
X-Google-Smtp-Source: AGHT+IH+nKCPN+X24+zu9HazTMUPSeOWH+r9zThhM/KvWeXOvcK1bjjj0VpXHwIqGgcWjhv9V9GKeCAZgbrqaF8sVPA=
X-Received: by 2002:a50:d5c1:0:b0:543:56d8:eb26 with SMTP id
 g1-20020a50d5c1000000b0054356d8eb26mr2392737edj.35.1699470152583; Wed, 08 Nov
 2023 11:02:32 -0800 (PST)
MIME-Version: 1.0
References: <20231108183251.80572-1-philmd@linaro.org>
 <20231108183251.80572-2-philmd@linaro.org>
In-Reply-To: <20231108183251.80572-2-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Nov 2023 19:01:48 +0000
Message-ID: <CAFEAcA9xgS_8VV1S+-7vaqSqzK_2=0hJ+ceDP7BVdFd6TUR-nw@mail.gmail.com>
Subject: Re: [NOTFORMERGE PATCH 1/2] configure: Use distrib meson
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Rene Engel <ReneEngel80@emailn.de>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Howard Spoelstra <hsp.cat7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Wed, 8 Nov 2023 at 18:33, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  configure | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/configure b/configure
> index f1456f6123..93735b7661 100755
> --- a/configure
> +++ b/configure
> @@ -955,15 +955,8 @@ if $python -c 'import sys; sys.exit(sys.version_info=
 >=3D (3,11))'; then
>      $mkvenv ensure --dir "${source_path}/python/wheels" \
>          'tomli>=3D1.2.0' || exit 1
>  fi
> -$mkvenv ensuregroup --dir "${source_path}/python/wheels" \
> -     ${source_path}/pythondeps.toml meson || exit 1
>
> -# At this point, we expect Meson to be installed and available.
> -# We expect mkvenv or pip to have created pyvenv/bin/meson for us.
> -# We ignore PATH completely here: we want to use the venv's Meson
> -# *exclusively*.
> -
> -meson=3D"$(cd pyvenv/bin; pwd)/meson"
> +meson=3D"$(which meson)"

Presumably the other approach would be to make the pythondeps.toml
say "on macos we need at least version X of meson" ?

Do we know what the upstream meson issue is that we're running into
with the older version on this host ?

thanks
-- PMM

