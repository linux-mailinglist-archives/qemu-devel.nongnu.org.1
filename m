Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD8B838DCF
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 12:47:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSFDu-00059x-Oc; Tue, 23 Jan 2024 06:45:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSFDt-00059i-6N
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 06:45:45 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSFDr-00037F-Dz
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 06:45:44 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40d6b4e2945so50239915e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 03:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706010341; x=1706615141; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d+6HecxFXfNe2HBfJN+hhzyOccUxn8QuYR9EJF1Bxjg=;
 b=aMFk9ylIfBXw+ZQqYlHYkIbclQgQPdbqoxI3dzxq8+lxwGKiER0H/3yJmwlclCR2sA
 EaxD7dGMMWq0LMQQVXgbTvBqMch+vhvvPmjgfD3hawxMdfqsPedRRSQIV+HjoTptEQ1/
 DEuloC4e4lv+bEa5iA9N3Pf60y3/5s/82SM5rMzONG6XivbcXZpYBGz8uJ1H1FLQ0+Hj
 Qr0t5B1wsNnGxRI0zvGby5+6HTD7WnGmOdEZ6EUIh5n6ChUua02A2fqkVa9xjSBlbFmk
 uuw9Pu0p06udm8lnEA3VQaDiknTiPEDIEln9teK51PkrVi6vB8RQANwmBVKdad/GgS9z
 kw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706010341; x=1706615141;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d+6HecxFXfNe2HBfJN+hhzyOccUxn8QuYR9EJF1Bxjg=;
 b=fVPa1+VtC9O1F1nQj4ie3b5hHQbb4qt3q/6wm3I5hweqS+ZtGI7Oi94aHz6UE86LxZ
 /cieVBceOmWJzxXLH3rNMkuOtLQlw8gSaj9ffhmnV1XmL4PWfDGbesq5wMbHs+ACp/NI
 QSeAhfLnHsxdVsODjMBaLRwRVKxoCWTBirr8HeGC/EUFFDhGiySUKUZNdbRAgwGDgcQ8
 ZSSHiLwUI/x6f83g75+39h+ZWxSTNxCtYNd95IRn0zb+gwGtOd2+yrIxP8Qbolte+am0
 3NqW/7q2K9TZ/CkxJ4MG+/mKsvvdHu1JkSrLcZkFJM1+/sP45bhG82NJYCPkD2WxCc2K
 UR8g==
X-Gm-Message-State: AOJu0YxR6OrYPQNUYmCeK4btaAQov50DcveTsK6fG5OleGr3JM70FN3L
 uc8EFjbWQjNytDg3hL5qXlYhyul42JgRjiDIOgLc4Scu3zvC9n4QMwbQ2d942v8=
X-Google-Smtp-Source: AGHT+IES7Z0WE7synZo0a/h5RFn7xVP01cXD9mv/aI+9bCYAnyrBtnx2fUP6+Lom8cAmU/izpDes2A==
X-Received: by 2002:a7b:c40e:0:b0:40e:4747:69f9 with SMTP id
 k14-20020a7bc40e000000b0040e474769f9mr31613wmi.187.1706010341403; 
 Tue, 23 Jan 2024 03:45:41 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.78])
 by smtp.gmail.com with ESMTPSA id
 u11-20020adfa18b000000b00337d2d1e0ecsm13436861wru.104.2024.01.23.03.45.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 03:45:41 -0800 (PST)
Message-ID: <b1c7e761-34ef-4143-993f-98580bffb086@linaro.org>
Date: Tue, 23 Jan 2024 12:45:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 30/34] accel/tcg: Make tcg-all.c target indpendent
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-31-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240119144024.14289-31-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Hi Anton,

On 19/1/24 15:40, Anton Johansson wrote:
> Uses target_supports_mttcg() and target_long_bits() to turn ifdefs into
> runtime branches.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   accel/tcg/tcg-all.c | 25 +++++++++----------------
>   1 file changed, 9 insertions(+), 16 deletions(-)


>   static void tcg_accel_instance_init(Object *obj)
> @@ -137,17 +129,18 @@ static char *tcg_get_thread(Object *obj, Error **errp)
>   static void tcg_set_thread(Object *obj, const char *value, Error **errp)
>   {
>       TCGState *s = TCG_STATE(obj);
> +    const bool oversized_guest = target_long_bits() > TCG_TARGET_REG_BITS;
>   
>       if (strcmp(value, "multi") == 0) {
> -        if (TCG_OVERSIZED_GUEST) {
> +        if (oversized_guest) {
>               error_setg(errp, "No MTTCG when guest word size > hosts");
>           } else if (icount_enabled()) {
>               error_setg(errp, "No MTTCG when icount is enabled");
>           } else {
> -#ifndef TARGET_SUPPORTS_MTTCG
> -            warn_report("Guest not yet converted to MTTCG - "
> -                        "you may get unexpected results");
> -#endif
> +            if (target_supports_mttcg()) {

I started smth similar but then realized this call has to be per target,
so put my work on hold. My plan is to have a single common tcg
accelerator framework, having target-specific code handled by vcpu
dispatchers. Is your plan to have each target link its own tcg?

> +                warn_report("Guest not yet converted to MTTCG - "
> +                            "you may get unexpected results");
> +            }
>               s->mttcg_enabled = true;
>           }
>       } else if (strcmp(value, "single") == 0) {


