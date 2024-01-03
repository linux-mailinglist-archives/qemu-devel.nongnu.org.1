Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC28F82308F
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 16:30:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL3Ab-0008Vb-Gw; Wed, 03 Jan 2024 10:28:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rL3AX-0008S3-5z
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 10:28:35 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rL3AV-00086j-Gd
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 10:28:32 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a287be6dbc0so135583966b.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 07:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704295709; x=1704900509; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H7S59wnKnFp3XaNZVDyXdyiWnLvc5cXJbfTJTdNgDpw=;
 b=ABpcX7fVyzQnMsujW5NEqwtclSL7bRe0rqaq16Ty4vbQzk+4XUamvA/lgfNKSwXtj9
 V5j5CzpUUXZJLy3m0ND4datRu/6+39haGd528/i46+0kaW7ZPmo1xNl/+JnCYRUJI2Rv
 UfQ5q67OMapXxlGpzsFjqz63+pb/B/g7qqdJ5+mDCR7IBCytoWqoJFX4uulJdqqghdLN
 OQDuY0Rm3jN0whKOCOJrhgx8KtRHIi3oq6OWMkrD05s0bpoYCipN1oedyJIuOqBqjT81
 Ez42pHb6UTNsW79OjEgLzYZcpH5P3vjHmngbIIzHHk6jsL4AdOmO8chliRUNsvcbb58Y
 KFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704295709; x=1704900509;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H7S59wnKnFp3XaNZVDyXdyiWnLvc5cXJbfTJTdNgDpw=;
 b=lvJiirwX4+sjOciEFjyzZ6r6ysuM7WW3l/+IKfFauq5BdnZovvHpEgS5ygAwntDf9a
 LNC19CMkZbNVARkWLe9Tx4Wakw1X9UVmvMpf8yBXtKq7trotMk0GMQnPAqYWmZWXTK7n
 6S9cTSGWz1to8l8mMfTAAhJkof+GASfS5MtlhP17aQs8mbQMX2p/PkWXA2CGnVDtPPJI
 Y0vm6TxRZd+Q8VvA1gydL4IWhGm2ZIpo2eeZ1HBHCCdhDCHSHxKq7Z0ImE9ba7URbyN4
 uaffSI9NiahLTSynKHsywI4Fp7TVvsUdY0dkfB61LgMpIIiiQnJ09Vc2x2e6odGrpsGN
 BDgw==
X-Gm-Message-State: AOJu0YxlRXmVgOuL75nCMhPHP80yOcf+unVowr9AcYhQo3hVF3x2ZgtK
 7AZSryCEd2HL+NIkdiUgWOEXNUrgjt1ygw==
X-Google-Smtp-Source: AGHT+IFxIkAylR9ExE4JcPQCblTnXUpwy4A0EThPoviQ7DC2wIkLwMpokGllvcqpXjz9mExvSzC3Hw==
X-Received: by 2002:a17:906:abcf:b0:a27:db15:3e70 with SMTP id
 kq15-20020a170906abcf00b00a27db153e70mr2454512ejb.35.1704295708885; 
 Wed, 03 Jan 2024 07:28:28 -0800 (PST)
Received: from [192.168.69.100] (tre93-h02-176-184-7-144.dsl.sta.abo.bbox.fr.
 [176.184.7.144]) by smtp.gmail.com with ESMTPSA id
 ju24-20020a170906e91800b00a23577b265csm3262390ejb.173.2024.01.03.07.28.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 07:28:28 -0800 (PST)
Message-ID: <274d8a5e-3e51-4d7e-b079-739f9f25dd0a@linaro.org>
Date: Wed, 3 Jan 2024 16:28:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/33] accel/tcg: Remove qemu_host_page_size from
 page_protect/page_unprotect
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240102015808.132373-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 2/1/24 02:57, Richard Henderson wrote:
> Use qemu_real_host_page_size instead.  Except for the final mprotect
> within page_protect, we already handled host < target page size.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/user-exec.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


