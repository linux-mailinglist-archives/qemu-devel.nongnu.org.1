Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B24D174D080
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 10:45:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qImWM-00075n-1S; Mon, 10 Jul 2023 04:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qImWA-00075Z-9u
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 04:45:14 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qImW8-00048R-Me
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 04:45:14 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-99342a599e9so551319766b.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 01:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688978711; x=1691570711;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1oUeeFWIYePb509upYMQnXRp/NkxRm3L5uE2Lc1GZgg=;
 b=JHzyq5OuCye1E/SYrI0DbkTtXpQXBXoIvMmN+m69J2U205jR3Ijt4dhD59MVHSmIdo
 mdYgcQ6JynOLakUTjGCZ0lHppfB0kcJ5T8Ed+GswATuQtG181IMoG344oQV57VqOcnfe
 30ej6KtWW+Q60kJHGCe71IZVFVCzH+n8C6wT7NhKM+h2HEQr5DGExNaI+bfkhs5UKlLf
 DVXPZqPZdzjGk3+gRE7ktrWqf12FqRWmKRFdJo3mJy0AZF5fbkqOiTtmRK+RRxUafJ7H
 tivQOrQLaNSuiPJuNZ+2jqNPXXs1lz/OCv8OAKZtx7+GTV5/g3DEUFpBSTFosxE8hNZV
 TEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688978711; x=1691570711;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1oUeeFWIYePb509upYMQnXRp/NkxRm3L5uE2Lc1GZgg=;
 b=YaYF4rO0RQ2TkkOwxbvKEM3kSKwTfKEHB1VZKwte77I//Lv7e/FbSN2MZqr/uaynpH
 Q7o+zxqL81UJq6WRTgkb1/6ryxywBJXVj1G7Fkzupd9prI9Hi+c0lvf8VrXqso0Z4Wdy
 cXhNLA1ptEfRtxPsWe0Rkau48W2+RJ5NYZ1q/ThbZsKfTlZPePpMrzJd9SdkDdTs2Vp5
 uKOdBuRdX+NY5vtjHB/kMouyxRzJMZyEIjI1hqkevSf8Rh1DKHW1BSPbS+NmNuNRv194
 Z8wOKQ79sB5pswpOkrmIOQGtaQJGMgMYqlA8xCKf3IsApEa/DsnteCyUTeiGLOypyFjE
 3c6g==
X-Gm-Message-State: ABy/qLbFgYJG0MNmOYKskxZ7ktCTdaInaehk2f0nGLP5HEy4yV9YH/cF
 NWdWWvuwmo3NKCNllz4GTAtc8fKnpR/Hleo9jT0=
X-Google-Smtp-Source: APBJJlF9dqU9YxeNa/4UpZN79vCKAQXkFavsHAL+MV22x60T67oWfnooNn1Vm1g+i0l81Fa6pWhrYA==
X-Received: by 2002:a17:906:5304:b0:993:db29:d27e with SMTP id
 h4-20020a170906530400b00993db29d27emr8212805ejo.25.1688978710847; 
 Mon, 10 Jul 2023 01:45:10 -0700 (PDT)
Received: from [192.168.1.102] (xbn44-h02-176-184-35-162.dsl.sta.abo.bbox.fr.
 [176.184.35.162]) by smtp.gmail.com with ESMTPSA id
 o18-20020a17090608d200b009829dc0f2a0sm5863086eje.111.2023.07.10.01.45.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 01:45:10 -0700 (PDT)
Message-ID: <5c4a5f43-b65e-a6b2-e5cf-647ec74548ee@linaro.org>
Date: Mon, 10 Jul 2023 10:45:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 10/45] linux-user: Use abi_int not int in syscall_defs.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20230709182934.309468-1-richard.henderson@linaro.org>
 <20230709182934.309468-21-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230709182934.309468-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 9/7/23 20:28, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/syscall_defs.h | 216 +++++++++++++++++++-------------------
>   1 file changed, 108 insertions(+), 108 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


