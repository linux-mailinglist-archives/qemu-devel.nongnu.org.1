Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C69481FEBC
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 10:42:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJ9No-0004D3-7N; Fri, 29 Dec 2023 04:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rJ9NX-0004Cn-QQ
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 04:42:08 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rJ9NW-00054F-6i
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 04:42:07 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-55372c1338bso7071654a12.2
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 01:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703842924; x=1704447724; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K5ebSk4qcs5utv0Lq0vCi6lCQJ4rv+m6v1o2uoMfXSE=;
 b=EJ9HA6JmclpB1oloXLOJ4QKiZZQO/gBLFog49kx1dQS5owgVR3V874zF+gc/qAUims
 /ICyGqHgu0DDyhr5UelHqLhhKisSOptTAw2O78mdtOVkJPR8I3ZPrMLTHKm3PXGWdMnz
 wSDbLvlzoqOaYHFcMkYKpcye+8X6aN3K8Ecz9fH9w0LHlPZSxB9JMo3c5jW1Pl9sHknr
 l0fw8DuH7Fw4bMTzm0J0xDOvM3Tts1nPkM7+UEhtgjxQ3afOsvT8eLxSIrhVxKYqx92L
 nBM0abVibtxSOqowhnkVBrMU5lSAUssx7BAmPkA0RBpx+j+nlWPz+nKeAMrOaRzkx3Hm
 G83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703842924; x=1704447724;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K5ebSk4qcs5utv0Lq0vCi6lCQJ4rv+m6v1o2uoMfXSE=;
 b=rnKlYUzK1VUq3CJEJTPHYUo0DWzjp3kD3Ts0j2fwF0GbQ03pjVDCVRohsd9BlnAXgl
 HSnvvISzEDx9zSyYXmbEQAigQ6BRH3v0JrZfkFRWipbfZvbPAtGLjcU5NThcLD1SChZf
 EeANVty1Qf1P/BIbi9yff7t/M2ihVQuUXsw9tX/db9AQzknDQB222k0m3Ntbtzwx1C2K
 fe3OWy5d0sZLU0MlyGqajcgC6j21/2j3yqyaqgcm6cNzOpjXLu+j0O3SnQwt0Yf9/Z76
 3t3z1xIksFFjgBXTymjKjSHjSqMtAWZOQLe7hDLm7g8PSWIhZcF0B5CZ4H+YJZ0GKVTT
 yu0Q==
X-Gm-Message-State: AOJu0Yx5l45HU8iZaROyjI9Elb9wAvAfb0F/pguwLD3xJSMS/hcN5zv6
 Sch7H3/cJA3nyNZlHkFuHCTItIZH1q066g==
X-Google-Smtp-Source: AGHT+IFVCxiCY3WEK5jpiItaYqJUG3o+1C7bK4J/Q+qJzhKLR+a56R8Y24uvqEPUHl30LE9YR2u78Q==
X-Received: by 2002:a17:906:3b05:b0:a23:7355:2c94 with SMTP id
 g5-20020a1709063b0500b00a2373552c94mr4885497ejf.43.1703842923968; 
 Fri, 29 Dec 2023 01:42:03 -0800 (PST)
Received: from [192.168.69.100] ([176.187.202.55])
 by smtp.gmail.com with ESMTPSA id
 l10-20020a170906078a00b00a26adbd4f15sm7488110ejc.102.2023.12.29.01.42.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Dec 2023 01:42:03 -0800 (PST)
Message-ID: <ffd4e821-469e-4dd1-858b-7c342c8a3165@linaro.org>
Date: Fri, 29 Dec 2023 10:42:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] meson: remove config_targetos
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231221171958.59350-1-pbonzini@redhat.com>
 <20231221171958.59350-11-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231221171958.59350-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

On 21/12/23 18:19, Paolo Bonzini wrote:
> config_targetos is now empty and can be removed; its use in sourcesets
> that do not involve target-specific files can be replaced with an empty
> dictionary.
> 
> In fact, at this point *all* sourcesets that do not involve
> target-specific files are just glorified mutable arrays.  Enforce that
> they never test for symbols in "when:" by computing the set of files
> without "strict: false".

Cool!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   chardev/meson.build        |  2 +-
>   gdbstub/meson.build        |  4 ++--
>   meson.build                | 24 ++++++++++--------------
>   qga/meson.build            |  2 +-
>   storage-daemon/meson.build |  2 +-
>   tcg/meson.build            |  2 +-
>   tests/qtest/meson.build    |  2 +-
>   7 files changed, 17 insertions(+), 21 deletions(-)


