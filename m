Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F3578CFE4
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:07:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7mp-0000gR-Km; Tue, 29 Aug 2023 19:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb5Os-0005eW-AG
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:33:22 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb5Oo-0005El-88
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:33:20 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bf48546ccfso25521055ad.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 13:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693341196; x=1693945996; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NFUn9s3gB8MS1OGZntSPdlOvr/nK7zSkfhnMoYnUHlg=;
 b=PzheyGsKNQPxBnmT+NE6ceP1rnjZIyBrVOTzZNIwM0xTiRxanVNkyi1VFiCxH5f92j
 00kWzL0NnlFrWFmnBFgFYW5lBj2rMcmLc1SxtFTO+ftqseNCXCoAsCHWAzx9aSoX4m+2
 PknUvMGq6EHpR4wy3Ven6N03EWJKdmd9W30YUGQSUxvBTtiFPIW0QKJPY0oMmrMCKCSn
 amzKp25WyKjkimZayn3Jejpg4xAp3qE4mFxWWPA1fP8pCvQRSHi/JHNYT9LSpxvLR6d8
 lBU/T91LOx6V1vHcu63F6Qkm8SCUJYU4uq4bXIKZ+B6/50NL0J+DQWV7j7lEDX1wLE3M
 yloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693341196; x=1693945996;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NFUn9s3gB8MS1OGZntSPdlOvr/nK7zSkfhnMoYnUHlg=;
 b=fu2B4CCnnfcuE/Dr3yfiZRpWB+2lBO6XyE2/SkuFzQiBN8Xc3KatpmH4EzOD+32DtY
 +bhGx66TYwlOngVtVwXqdDlIWvMkENl9jq142cyH3OBl4xRv5+r82Wn+Lj5vN7OQuaI/
 SHUpH8W+tztNGj6IhJq8z/KWzI+Yzlk9AnqwaNcO9/Nr0XW8uAJphjxyQObartZTlilD
 Gq3Gr0IiOtNdqScPTfYbZWjpndQNQAfPgDmBcf70jcT/IZn0zPeOfaiNpjmb5BBuCXqG
 Geyvnwp2flQxkRq4qwppvk9gXOYKYelD4b7xLpmNL6umAu3pS89466iVmLhQqLhtbWsv
 IIMw==
X-Gm-Message-State: AOJu0YxD65ryRMK8tQAks6Ufn/C9VDr1ttLj283IyUrSChRzwwNVx4sd
 qxP7aS2dj7SjBwfB32qWmA/mDA==
X-Google-Smtp-Source: AGHT+IGuhxpsyI2qkTXs3OT2is/pm8kDB0Ct/eF0pEGH52SP/F5yoZyGvsTvfyOI7xXff4Roy3CjXQ==
X-Received: by 2002:a17:902:744a:b0:1be:f2a1:22e1 with SMTP id
 e10-20020a170902744a00b001bef2a122e1mr147678plt.53.1693341196539; 
 Tue, 29 Aug 2023 13:33:16 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 j1-20020a170902c3c100b001b8ad8382a4sm403864plj.216.2023.08.29.13.33.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 13:33:15 -0700 (PDT)
Message-ID: <688a1134-3e5d-9af1-4e2e-2b9216423637@linaro.org>
Date: Tue, 29 Aug 2023 13:33:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 27/32] bsd-user: Implement wait4(2) and wait6(2) system
 calls.
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-28-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-28-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/27/23 08:57, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/freebsd/os-proc.h    | 75 +++++++++++++++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c | 14 +++++++
>   2 files changed, 89 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

