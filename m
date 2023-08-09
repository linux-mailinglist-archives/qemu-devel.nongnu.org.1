Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CDA7764AD
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 18:07:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTlhi-00039T-9u; Wed, 09 Aug 2023 12:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTlha-00038m-CQ
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 12:06:27 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTlhU-0001R4-8t
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 12:06:23 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-686efa1804eso5106603b3a.3
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 09:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691597178; x=1692201978;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bkv//8XijS+l7sH4FiUA+RcnFb2pfXoaDpLeA56xX9U=;
 b=a8yZQ4wgvcgEkTEd471qwsPCRTdu+anyK+kUl++ZJVv0VCFa6y32MaqZTKvSI18oYk
 asIkivCm+yZpRDEC69qIS8wNDO4HMh3wekkv06Nocrg4O0PWgguk3vOUam8ttNIHreew
 oOam1d+GhyMxKWEAyGegfqfK95ckMKZX5F6qI9ZdPxbAzc7J8k5LXDIb3tVHgI2O0qtN
 USJL+UCAfcevCJCu3E6bSlc1CHSs0dSjt11VTXhGkj2qz3XlGUIYFw7f6GDjNUjsuJh5
 6ziv5CjcilH+cIphLiJKHl+hZK7KtOooE9dx4FHsK0GUIwHhagQ7pSpfN0vCmksb0Rp3
 gDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691597178; x=1692201978;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bkv//8XijS+l7sH4FiUA+RcnFb2pfXoaDpLeA56xX9U=;
 b=lAjUGL5J7PkRdvuoYwnFBDMqm6guMEJNt/oT7HWKhqQUSDXnlZXu6TDtmDqrl3QBMR
 TCNSFs2hyCz8hAC8LwO9SYLmLbaySRKkl78W7zbrN/VBydom6K6G/5MKQdvA9W16DNKS
 2PTMIM/Fn25R/DYjZDmZT67vgDX3OxCuzdZWFE9xh7KRGmKViRVoCLDou8xihBE1tCtt
 mdLKfzVmCAYfBcDo6W8QVIsREjybUcPPY1WAQ7qVc3IEFUO4aaMJZdV33ZoUWXj7NR8C
 +NChl3s89kP2F2WAd9N/CPzuJgJNqmm94FDy9Nzb9T4cR/uN1+TmyMj5k8R+OoqyU7Fv
 DrBg==
X-Gm-Message-State: AOJu0YykjSwyP9G8cmUjzAruJm4seX9HfqcXcKCzx4A0boFVLyDZhlJG
 0o2yjqFL4JUDbpymNwd+XQkTPQ==
X-Google-Smtp-Source: AGHT+IGCLZ2B3bEOYPW5dm3g2pxGDFkkNgr1KbOZz2YZTBYXsR/uHa+Q9IdPwlU1bwCcGr2dc63R/Q==
X-Received: by 2002:a05:6a00:3906:b0:668:99aa:3f17 with SMTP id
 fh6-20020a056a00390600b0066899aa3f17mr3037644pfb.16.1691597178391; 
 Wed, 09 Aug 2023 09:06:18 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:6bf0:9674:6ac4:f74c?
 ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 19-20020aa79253000000b006862b2a6b0dsm10401985pfp.15.2023.08.09.09.06.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 09:06:17 -0700 (PDT)
Message-ID: <f6e0eac9-695e-80f3-00c2-32ee32295015@linaro.org>
Date: Wed, 9 Aug 2023 09:06:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC v4 03/11] linux-user: Implement envlist_appendenv and add
 tests for envlist
Content-Language: en-US
To: Yeqi Fu <fufuyqqqqqq@gmail.com>, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org
References: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
 <20230808141739.3110740-4-fufuyqqqqqq@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808141739.3110740-4-fufuyqqqqqq@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/8/23 07:17, Yeqi Fu wrote:
> +        char *new_env_value = NULL;
> +        size_t new_env_len = strlen(entry->ev_var) + strlen(eq_sign)
> +            + strlen(separator) + 1;
> +        new_env_value = g_malloc(new_env_len);
> +        strcpy(new_env_value, entry->ev_var);
> +        strcat(new_env_value, separator);
> +        strcat(new_env_value, eq_sign + 1);

This is

	new_env_value = g_strconcat(entry->ev_var, separator, eq_sign + 1, NULL);


r~

