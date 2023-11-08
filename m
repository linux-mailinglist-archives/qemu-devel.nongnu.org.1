Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6A07E5C80
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 18:36:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0mSU-0002kl-UV; Wed, 08 Nov 2023 12:35:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0mSS-0002kY-DV
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 12:35:16 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0mSQ-0000at-NH
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 12:35:16 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9d0b4dfd60dso1081218266b.1
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 09:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699464910; x=1700069710; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TaZOkiuCIJBSrz3Yf50gfUgaDBqaSwlGdFVQNZNMaDU=;
 b=dQFt4Yo+4eRi+fct6yiwwwz6hNGIErxPHn6lx85SbahjBW4EqM6hQekhOsemok8axY
 oPkTZAEO+rfUKfN0eCMERVqYPcoN0r2ETBaboMbITH/hsDcGbQNpk8R39LbBEgWXqNaI
 kYIscDvq0fdT0Kpj++qSP3gL4N736yN5HJAfq/SwBZjkQpO63WY9HpF5FByQuo65CUYv
 cxuUFnF0M+hbrvVI3PF6FxUsWWkTIhsVLJZ4Pf3PvgPBE7uIQ5ASzwFHMkS5YK4Z4NFb
 5/RPKbVvBaliKHnUQemEAUFfmw//2d0RdTvgxkH/v9rO1GOK+/CsRc7I6J8W8Wh8vHwX
 w8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699464910; x=1700069710;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TaZOkiuCIJBSrz3Yf50gfUgaDBqaSwlGdFVQNZNMaDU=;
 b=eKEjRcR+6Ht6a1BOxj2qS/frIeTUlke4xUhdtPY0JvP5y6+qZnTZvku+8s2vNKN23w
 oxeuOCKsWMpDimAM+ORkDTZoBH4TiAlxgdlZNV58+PZPcUPu6BZxOD6rfH9t81uH5Mbc
 jBPms0GJuYe2T8HAxoAUfnpKpb71wNGrMoCtcu5MLpTn6XG5u6wVzXZyY4bYPd19VU/O
 lHSyR8wZKcMq5x2bFJnJHHbQIuYkKlFHROBUreDcjWksK4cqMI6D8KqcNrfFSVT+Hm9y
 wlV2//F7RtaJsBF/UzQ0UF5AToF8oHR6DlB+gP8VmYA785D4VTlasi1Teut6TGJ25jn/
 Rs8Q==
X-Gm-Message-State: AOJu0YwICLLtezwGqo4JIo/FfhP5XqY7Uco1L3SPe/AJX4dJZmCmeNRd
 HEPIWyV5b/ojSkrEIGjKfW+mPA==
X-Google-Smtp-Source: AGHT+IE37dIVmSPaTiRf2d2ADKaeb8L3/2zFRYggUkQ0RPOM0Xpn6NluNTBM20dEtBo8H4zzRWgA6Q==
X-Received: by 2002:a17:907:9342:b0:9dd:f303:8e6c with SMTP id
 bv2-20020a170907934200b009ddf3038e6cmr2200111ejc.73.1699464910240; 
 Wed, 08 Nov 2023 09:35:10 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a170906395100b009de467a25d5sm1386271eje.13.2023.11.08.09.35.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 09:35:09 -0800 (PST)
Message-ID: <039a6e2d-8daf-46a4-a175-8df1ceaef0c3@linaro.org>
Date: Wed, 8 Nov 2023 18:35:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/docker: merge debian-native with debian-amd64
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anders Roxell <anders.roxell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20231108165602.3865524-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231108165602.3865524-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

On 8/11/23 17:56, Alex Bennée wrote:
> debian-native isn't really needed and suffers from the problem of
> tracking a distros dependencies rather than the projects. With a
> little surgery we can make the debian-amd64 container architecture
> neutral and allow people to use it to build a native QEMU.
> 
> Rename it so it follows the same non-arch pattern of the other distro
> containers.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Anders Roxell <anders.roxell@linaro.org>
> ---
>   .gitlab-ci.d/buildtest.yml                    | 12 ++---
>   .gitlab-ci.d/containers.yml                   |  2 +-
>   tests/docker/Makefile.include                 |  3 --
>   tests/docker/dockerfiles/debian-native.docker | 54 -------------------
>   .../{debian-amd64.docker => debian.docker}    |  7 ++-
>   tests/lcitool/refresh                         |  9 ++--
>   6 files changed, 18 insertions(+), 69 deletions(-)
>   delete mode 100644 tests/docker/dockerfiles/debian-native.docker
>   rename tests/docker/dockerfiles/{debian-amd64.docker => debian.docker} (96%)

Good idea. Why RFC?

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


