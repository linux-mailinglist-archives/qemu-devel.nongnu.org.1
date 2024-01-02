Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6694C8221DC
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 20:14:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKkDG-0000OF-8k; Tue, 02 Jan 2024 14:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKkDD-0000Ny-7s
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 14:14:03 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKkDB-0002Tt-OA
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 14:14:02 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33748c4f33dso683034f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 11:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704222840; x=1704827640; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7GZv3KYTkWjasm/oFdH9CGzYzRRL4JqjQt0xh6dClYA=;
 b=Xx26XP1/rvNFnO/Ir4PaigktQ0uqoDqRRlfaqdYDt2XODCnuJmtvlAYCQDpd4CDzsb
 ZZG18AN1RclVFgCNiLepYI7XlBAKr3cbiTZ3j3dk79A3bU931g2F4EcvxyODlxBJD7Ly
 pG8cGOFolTkasA5cGbwD4s07EVTW5qvjaSY1WRTrk5GINDm+FM7WoBR6zuhm84smJLpK
 vx7y/G9n/j3961XdpLYJqJdm2LwrqQBDgTGl//P1Ik0ENQ0nrVhYiEX0ZiamUrYieL5y
 v3ymSFICXfHtVEQyKn4S05PUCh99EpVQEsg7eBLpobXXMoLOZA1n8cK7H+UhZngcXzdg
 q56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704222840; x=1704827640;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7GZv3KYTkWjasm/oFdH9CGzYzRRL4JqjQt0xh6dClYA=;
 b=rx7vfq6vaeRgzwplr8077NuXZ3l/sq0rUGZrqJWnudUOXoNmn2eIzRCWLOPv9fF6J/
 8Kaf+8jh/uLuj1TK90tTfof4plxDSHl9tXqbRMgQcn9p9LcJ7O1wxRGLwok+Cv1sVIDe
 w+bcGmZXyKn6CFFA6TNdAC3e4s0vNlKw4bbGza3/ndnVW+s6LTguY6pFkAqNmkntk/ag
 6rbd3UuZxpVuFX+1U/juIO3k6OKygm5cbGVI8hlXOzEzSr3fURRJ/SPv0nCEIM4uMldr
 He3dkzMkukZErnVsvU6ggQVYjX0Qbmwd8LRQrJwhJLceNrHxBGKRfWSIXzXtAUadg5E9
 AE0g==
X-Gm-Message-State: AOJu0Ywd6r31Gg4E3c3vyXFbGXjRn+Lu5XpMJXWqHqM/KZXMDMvAXrJB
 ifCHCX12JOMFx8BTRnfvRf7d7IeDl7bi5w==
X-Google-Smtp-Source: AGHT+IFlcZvz1NJwf5dpfunOi4YMnYQDhGleKGDxt+LQCZ4XTEEV7X52vvp80ybziItPXZvg+nH0Zw==
X-Received: by 2002:a05:6000:100e:b0:336:c5e2:fc9f with SMTP id
 a14-20020a056000100e00b00336c5e2fc9fmr6314344wrx.29.1704222840294; 
 Tue, 02 Jan 2024 11:14:00 -0800 (PST)
Received: from [192.168.69.100] (sal63-h02-176-184-16-71.dsl.sta.abo.bbox.fr.
 [176.184.16.71]) by smtp.gmail.com with ESMTPSA id
 c5-20020adffb45000000b003372818f4ddsm10966910wrs.0.2024.01.02.11.13.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 11:13:59 -0800 (PST)
Message-ID: <97d3b8c0-e9d4-4e82-9a94-aeac9a038494@linaro.org>
Date: Tue, 2 Jan 2024 20:13:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 26/33] *-user: Deprecate and disable -p pagesize
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-27-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240102015808.132373-27-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 2/1/24 02:58, Richard Henderson wrote:
> This option controls the host page size.  From the mis-usage in
> our own testsuite, this is easily confused with guest page size.
> 
> The only thing that occurs when changing the host page size is
> that stuff breaks, because one cannot actually change the host
> page size.  Therefore reject all but the no-op setting as part
> of the deprecation process.
> 
> Reviewed-by: Warner Losh <imp@bsdimp.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   docs/about/deprecated.rst |  7 +++++++
>   docs/user/main.rst        |  3 ---
>   bsd-user/main.c           |  9 +++++----
>   linux-user/main.c         | 11 ++++++-----
>   4 files changed, 18 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


