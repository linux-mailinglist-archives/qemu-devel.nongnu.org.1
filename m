Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF12E736989
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:40:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYmN-0004ar-NE; Tue, 20 Jun 2023 06:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYmI-0004Zc-EB
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:40:02 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYmG-0004R1-Rp
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:40:02 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4f6283d0d84so5986094e87.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 03:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687257597; x=1689849597;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fBKPGzWdiAKh1lBBK006f90hBk1zPc1eEIvQejRjmFM=;
 b=A85Gu1soaHcx+akI/ocJWSu9l+3z4cAH0QIPA/vMT4Kb1xsN42J6gaF46NZGxJeam1
 qUebqXrHy5VeK/98gQllEnkpCbGrj44KDN0i/j/R7nrpXrwPfZ4c9ue5kf1k0GvuFLaH
 ECqpbhM3mzETiU0VcO1Zq+cXyJHQDtJNaIOwrcAQ1yopyQaFVmVJ9yk3C5VyYlTciVhL
 jGrLoA6oetPV6tJ9YCQru8aJi097gWCoMADDlGSpaG/QpZrP9h9faO/jIhG5xXNlR5FM
 Jai4r2YwDxWbj1xr1Hv96Qi7y53uJ0jLMnp4HfNvyhz0olB4MQxcjd9wrcGmA08tHdy6
 wXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687257597; x=1689849597;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fBKPGzWdiAKh1lBBK006f90hBk1zPc1eEIvQejRjmFM=;
 b=joUr/j0ShiIR+2+iK8m5vpdxfTYBozEga9CVTkM38655Dw7kk34XW33sw0oGzTH3ye
 uF1PY49h89vbstNTe5xINN6dxZ3bNM9LGHOjPVWpPJwbSBU7tEQU6x84HOEEnncRXQVX
 +yPRwRyFqOcp9FcDru8pz7jrrvPUwIPhfXuZqj+QZAcZ4qJOpfteCbo3Rum+1LthzKl1
 g7LDzfge+csIrHWlMrR3GdXRqMyGnBd/zMEcxNu0noo1+XqDn7KJGZeUq3WB21F8v218
 Q4mfio82e7V1ofugGG3ll7WyztJWPRtr6sV27sf6vMD7MVVJKdjvvyWtzI9pLtQwRjwz
 qFwA==
X-Gm-Message-State: AC+VfDyoIl7QtIWp2lNc2V4guatJqfw1+9bRrS585g/JFS/5qzcGop5N
 8aa40XnYBAYcRuVBaYY1+/lJ4c+nm5khK1I6df5xIx8B
X-Google-Smtp-Source: ACHHUZ6KyADH6vC4JgIz2ytprcCZg7jYkojnAEYzIKiwTGd+L7lI8VW3OkKwD8bZSLvicxqr0s3nYA==
X-Received: by 2002:a19:5e42:0:b0:4f3:b588:48d0 with SMTP id
 z2-20020a195e42000000b004f3b58848d0mr7280492lfi.14.1687257596710; 
 Tue, 20 Jun 2023 03:39:56 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 l23-20020aa7c3d7000000b0051a5cf5fcaasm941258edr.23.2023.06.20.03.39.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 03:39:56 -0700 (PDT)
Message-ID: <a086406e-7960-d816-9fba-35b7e5db32b5@linaro.org>
Date: Tue, 20 Jun 2023 12:39:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 24/34] target/arm/tcg: Reduce 'helper-sme.h.inc'
 inclusion
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
 <20230619155510.80991-12-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230619155510.80991-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12d.google.com
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

On 6/19/23 17:55, Philippe Mathieu-Daudé wrote:
> Instead of including helper-sme.h.inc via helper.h which
> is included by all TCG files, restrict it to the few files
> that require it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/helper.h            | 1 -
>   target/arm/tcg/sme_helper.c    | 5 ++++-
>   target/arm/tcg/translate-a64.c | 4 ++++
>   target/arm/tcg/translate-sme.c | 6 ++++++
>   4 files changed, 14 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

