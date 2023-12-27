Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D70C981F22B
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 22:09:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIb8B-00008W-17; Wed, 27 Dec 2023 16:07:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIb85-00007s-7D
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 16:07:56 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIb83-000712-OH
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 16:07:52 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d3f3ee00a2so20806745ad.3
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 13:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703711270; x=1704316070; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QMMNPAyfBsxRDnN0YMoSQQSLw/5d3Sry2HkjSV8AK2Y=;
 b=vm/7MlplqZkmOEkl+GB+HJ1xNO+F6tEWzSyMczkW5OXiqlLaYx8HQaNxiNz58zyGJ2
 0lvttR8CSGWVueQQ9R31jvCsRNVvOEq7/A1Is9ZuIv+AHSbP4OS7nchAstEp0geS0Uzi
 fSCvR/oQm2DXQ8Dd0lCsdMf9ZHSjqJny9/iTZSj8AESxfI46l5TQ+e+7RoK6EC4q7duj
 UHoy39pvj0409oX1Y9AB20l4V8hXK1ee+5QYUqKA3TrVULWozggCMgFKzbsaa2KiaIww
 rkjAEvfB0Fiyiz0o+7NUoEu3kXtXQdGKvM9g9YkTdLaxJXY/9+TQUTGWNDDvqMNZaAcj
 /WxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703711270; x=1704316070;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QMMNPAyfBsxRDnN0YMoSQQSLw/5d3Sry2HkjSV8AK2Y=;
 b=EuCZUp92yO3ICEO4hWP8kqzIPGmLYTzeIF6LIvbrJnfl27oOdhzdYuVO9VB8mV1i4r
 WjjamCDQIbxB+1kQzS8a1A9kbx+Ootu4MGKHUKpFOA8WhIrllxmCRRqtl2z/9WJup+kD
 eIwuYEq98ayn1Y7U5k57QDSHOWyoMB0g6LLDPbmyTRikDmOeCeeamqGxL/VbNWJ/yLJ2
 30p6WEdH2kZI6LGYmzNMrvR5li8GhjziRO/tPYkux5xo3KQVxw5jRD2gGr/Qnk2+vfB9
 CNR/7rFRsd2f3xqOAQTL5qwkIE1IrvyzNqwXG8VBZRGIy70ThUD9i5MLr4Lo9xXrJao/
 xJqQ==
X-Gm-Message-State: AOJu0YztCLNJsK6gwpu9ogwyZcXwv0iegF4O8WRAZXObdTJHsV5aQ9PB
 1GkiaIKvXpniQ7silYxfV1+m4oF3dCBOeQ==
X-Google-Smtp-Source: AGHT+IFJ2Ofb5EgnnhUNdxAXo2ram3adymeO48Kd4qyKFf/bGc/QsafjKNylG6bCorfUMEoN8lFgXw==
X-Received: by 2002:a17:902:680c:b0:1d4:2774:3640 with SMTP id
 h12-20020a170902680c00b001d427743640mr2904082plk.119.1703711269780; 
 Wed, 27 Dec 2023 13:07:49 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 m10-20020a170902db0a00b001d0b4693539sm12436231plx.189.2023.12.27.13.07.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 13:07:49 -0800 (PST)
Message-ID: <cef2282f-9060-4f9f-bffc-296ed2e58fa9@linaro.org>
Date: Thu, 28 Dec 2023 08:07:43 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel: Document conventional file prefixes and
 suffixes
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231226150441.97501-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231226150441.97501-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 12/27/23 02:04, Philippe Mathieu-Daudé wrote:
> Some header and source file names use common prefix / suffix
> but we never really ruled a convention. Start doing so with
> the current patterns from the tree.
> 
> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   docs/devel/style.rst | 49 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
> 
> diff --git a/docs/devel/style.rst b/docs/devel/style.rst
> index 2f68b50079..4da50eb2ea 100644
> --- a/docs/devel/style.rst
> +++ b/docs/devel/style.rst
> @@ -162,6 +162,55 @@ pre-processor. Another common suffix is ``_impl``; it is used for the
>   concrete implementation of a function that will not be called
>   directly, but rather through a macro or an inline function.
>   
> +File Naming Conventions
> +-----------------------
> +
> +Public headers
> +~~~~~~~~~~~~~~
> +
> +Headers expected to be access by multiple subsystems must reside in
> +the ``include/`` folder. Headers local to a subsystem should reside in
> +the sysbsystem folder, if any (for example ``qobject/qobject-internal.h``

subsystem.

r~

