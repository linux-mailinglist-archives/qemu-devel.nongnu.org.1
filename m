Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6772470FE30
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 21:05:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1tnf-0002GG-Ff; Wed, 24 May 2023 15:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1tnW-00024b-1G
 for qemu-devel@nongnu.org; Wed, 24 May 2023 15:05:25 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1tnU-00074g-G7
 for qemu-devel@nongnu.org; Wed, 24 May 2023 15:05:21 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-64d41d8bc63so1052580b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 12:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684955119; x=1687547119;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s1TPa5C9dkS0DgAt4c2JNa2SqnZwy0XNjFqkJf5tBcg=;
 b=hXuQ5hqB1tzXUaX1p0lbbt82VLLqpjq8DkpU3HZIAAIW8l1TkVEyWtfRqIYNentcbr
 VDFirae4s1/nDBd5qgW8qiS5v7JAD/wOVkZQCJPKxJ9VjTtRUtvVFsTwJJRK8hy345qp
 U0eHnXV67QST5qDtqne3sW4icwPoewI8ZYMI79B4WurKqcbflc0wHKVG4Zla4iTc1F2c
 0zu6YNnshwKHv2cupEucvkMewgQbhBYo583QUK0AVOz6AgturEUiq7Nnrq4RMEjCJrGH
 SP5SICKJhsr1xPbPK+WZAQjBpRJ3YjVexQfBhP0I7deHd7TvRPB+h3hc+A7I03By4YE8
 AqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684955119; x=1687547119;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s1TPa5C9dkS0DgAt4c2JNa2SqnZwy0XNjFqkJf5tBcg=;
 b=QhJMaaX/MJxfm6uFpfm6B1EGV5ny5TKlNCpq1KTQW4eVSSJhExbtNH4LcMhu5QtGXC
 yKv1blGRN+o7qL7pbDDLZNcntgXqxuu1Z+iFcHGyvc7QT1ZVxuxYbo9haeQAQl/K/2U+
 jtgWjIrkp8KfMkOyUiTOEqtUCgfrTOyJpkLT7uc8n5rQVkjThgq11OcXipeB0hcduKfO
 OkwMNdCGq9IB4iJe0eJiCDI7r3xnT3EvutQALnn65agNd1OlkGLrSN80L+4Qgk3buxEV
 0WtW/JrZRgTBx+OsSHj1YJ02KWaZy3Z7m4lDAZ/0AUP3mFc6kXR4lnlBvIaxfcYO8/vb
 Vu1A==
X-Gm-Message-State: AC+VfDx50ug/nT7ryXOKpf/PvYqwFnWY9PnWqEeB/997M39cOAd2SZW/
 7tCKFetL8C6YjJtcQwu2Chl1KA==
X-Google-Smtp-Source: ACHHUZ7biCChd5hvZIM4l3qiR3q7lp/39kzy1xSHDWusfG8fyXh5vPrn/0T+p18rWEVWJhCYZ9kb6w==
X-Received: by 2002:a05:6a20:144e:b0:10b:97c8:2e16 with SMTP id
 a14-20020a056a20144e00b0010b97c82e16mr13502740pzi.29.1684955119123; 
 Wed, 24 May 2023 12:05:19 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:6b03:9af2:33c1:3d6b?
 ([2602:ae:1598:4c01:6b03:9af2:33c1:3d6b])
 by smtp.gmail.com with ESMTPSA id
 g4-20020aa78184000000b0063d24fcc2b7sm7797245pfi.1.2023.05.24.12.05.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 12:05:18 -0700 (PDT)
Message-ID: <00a4d515-2524-3814-47fa-2a69bd863f4b@linaro.org>
Date: Wed, 24 May 2023 12:05:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 04/10] hw/arm/realview: Factor
 realview_common_class_init() out
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>
References: <20230524145906.33156-1-philmd@linaro.org>
 <20230524145906.33156-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230524145906.33156-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
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

On 5/24/23 07:59, Philippe Mathieu-Daudé wrote:
> Introduce realview_common_class_init() where we'll set
> fields common to all Realview classes.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/arm/realview.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

