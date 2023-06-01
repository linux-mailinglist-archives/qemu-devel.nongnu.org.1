Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CAE71F3C4
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 22:22:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4onx-0004FJ-0O; Thu, 01 Jun 2023 16:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4ont-00048T-H3
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 16:21:49 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4onr-00085F-1q
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 16:21:49 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f6ef9a928fso12804255e9.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 13:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685650905; x=1688242905;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wABknuCeZTB++QwlLNViuEhbbi14NCgbQlCzJXEToFc=;
 b=LEYxhUYYDFTfnuiRVgVdX7Uiof6PL8iM72Y7+5EHvq0A+qeVjzWM/s6cYCxVNvrW18
 DwIsDmy/xg3ACKjhZcemp0lLLvy9XUiE/0LteV1jS8LaKbT8D31zqPmFMKN2jPyun2Kh
 cnsThmgySvewjtcRx2mrN3fLQmbQpW0XPzFV7CqieS9iav4LYLMALnzeJfQPWSCrDzZ4
 AJxJvSlAAicJDqV3uOVGfQwlkst5NrDke2f/fN6EeZL2Sc83L5KYU6zMlCEbuoL7uHE4
 DGiJpEQuBMSrzxE+lO9I1DwsQ4r7OUllDRQ6CABzUPXHwc143hPWdK+Jjjp7A01uzlgi
 QdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685650905; x=1688242905;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wABknuCeZTB++QwlLNViuEhbbi14NCgbQlCzJXEToFc=;
 b=BtZO1CqY8gdq6QdZm8TbcfuOpAGdnDxuNbYzi8ovaV8jpicVnu3QEtzujHtDqTDoF1
 BNgLlwb1upVziGQWS0gZzrgjyYAS6Vwu0rqAxviIfj/SdTAULYuLJhdvWMcP3nUZrLNI
 I8tZbFd2ZIFiU5l8aGAh+9XDB7BboGdb6D5R4+OSK2yE4EykYNa8ZbfMkNnCU8M3yAyr
 UIuF81By8DlLyV/u2xYQFWHx4EXoinowbD44TqOJMneOMwRnilS2D0TQI6ak8sFtKgdm
 XHZXMvR5SsnoqVt5IkRvsxesq5TRMJRpd7of7S8K8keXjcYxaAybSv1aRW5RK+CB02K9
 8sCQ==
X-Gm-Message-State: AC+VfDxUeXV0UhNNL7UC+Xa4tXewpyAW/XFSkOeDhRbTMxiID4y04pDS
 DZ2qQwnta8oWcf0arRBOL/4NFwR82J5Eurzd2NM=
X-Google-Smtp-Source: ACHHUZ7+aB0XjlFb9WTLAdNQVVZSujrY9HWXNZk8XeHnr94QaXNDcDKmEXfnZAXLQr+txpAZ5d8axQ==
X-Received: by 2002:a5d:6950:0:b0:309:4e64:7a28 with SMTP id
 r16-20020a5d6950000000b003094e647a28mr2826136wrw.49.1685650904893; 
 Thu, 01 Jun 2023 13:21:44 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.141.224])
 by smtp.gmail.com with ESMTPSA id
 m7-20020a056000180700b003062d815fa6sm11258094wrh.85.2023.06.01.13.21.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 13:21:44 -0700 (PDT)
Message-ID: <2f9917cd-883f-fcec-78c3-e4ee26014283@linaro.org>
Date: Thu, 1 Jun 2023 22:21:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 28/48] tcg: Split tcg/tcg-op-gvec.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-29-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-29-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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

On 31/5/23 06:03, Richard Henderson wrote:
> Create tcg/tcg-op-gvec-common.h, moving everything that does not
> concern TARGET_LONG_BITS.  Adjust tcg-op-gvec.c to use the new header.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-gvec-common.h | 426 +++++++++++++++++++++++++++++
>   include/tcg/tcg-op-gvec.h        | 444 +------------------------------
>   tcg/tcg-op-gvec.c                |   2 +-
>   3 files changed, 437 insertions(+), 435 deletions(-)
>   create mode 100644 include/tcg/tcg-op-gvec-common.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


