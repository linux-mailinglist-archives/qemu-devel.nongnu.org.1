Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC21811B77
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 18:44:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDTGB-0001V9-B4; Wed, 13 Dec 2023 12:43:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDTG9-0001Un-2I
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:43:01 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDTG7-00052C-Hv
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:43:00 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-54c77e0835bso10084639a12.2
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 09:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702489378; x=1703094178; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9UxbCxX/DTFHK/2Qn2HpqwTAqKkskE+/xSX1LCa0GlE=;
 b=v8Q6ujr7IGB4h8qPdXe7D+Lhw09dokaSG7rkICRjDcb+I9I9tU17C2fID1KYnHHN/q
 rWtWz3Cnsn3b/pueiytKaAmcr2hvmgCPfjJeZz8JF3Bze7wWRtKshlBn7DxnG9ufRogw
 RcTC3UlwgFM1ANhV4qyiBnZP1la/Kva6c/jdtvqhwd8JT6TN3LK+nSinnrEZx39nuhmx
 LLFiOUQaf7Dklkh1mDVNEzlvdIqXJp1G4FR/+xIM9P8SpLGGIJJNIxElj/9IMx4kSKbo
 +hobpK2uCdqrOMiDFMWo2xLQXXnl+hnfrDgP8AUKdQXD9b7NK+mpgRLhVvolvvOVh0ms
 MN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702489378; x=1703094178;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9UxbCxX/DTFHK/2Qn2HpqwTAqKkskE+/xSX1LCa0GlE=;
 b=ALgDmn9VX5vejxOHsI4tsxt3ICKGQc5PEKaPKb/bQqfRgBUZY7zUC5KsJyATsrfWia
 wrMNYkMk4wxKXSloTT/dvZxApnmjTCHRy5Khlc6Pm887aPXEgXk8iIFeZNIUjj58YeZ4
 uSv9FDYmwrLysXrrLH6//A3wezC3rZBO4+LYRTTmTgzlsltsYEPEiY0kNnLg2mlDzrBj
 4wMBMa6uieelMQtwbQYEuMcdTadkhzlZFcU1Y7OZlU21faRvjrkLrLU7UZY2R2zCFjz0
 HsCcOALp3HOINjilli9kxtxdlLTDFVy5FvhPWmLrpybhOXNgFA0h/5BImctwMEG7oIsy
 NnxA==
X-Gm-Message-State: AOJu0YyRFMhDpGhKgSV7NXfH+HXqZpcR5xwYbtSos2GfhDMOjXF/I3gu
 NsA2MtLEi9zO4tOTj1X43OhATw==
X-Google-Smtp-Source: AGHT+IHK/wvdiSzwlZm0agcStmiP30hSMGDCYYSPqdzO8hMAxTAmMIfti02BecSzgG4V4doTfKq6NQ==
X-Received: by 2002:a50:c8ca:0:b0:551:fa18:fa60 with SMTP id
 k10-20020a50c8ca000000b00551fa18fa60mr835316edh.22.1702489378053; 
 Wed, 13 Dec 2023 09:42:58 -0800 (PST)
Received: from [192.168.79.175] ([93.23.251.22])
 by smtp.gmail.com with ESMTPSA id
 p6-20020a05640243c600b0054c9b0bd576sm5868220edc.26.2023.12.13.09.42.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 09:42:57 -0800 (PST)
Message-ID: <e3a19159-9909-4d24-b05a-00518073eb9c@linaro.org>
Date: Wed, 13 Dec 2023 18:42:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] tcg: Unexport tcg_gen_op*_{i32,i64}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231029210848.78234-1-richard.henderson@linaro.org>
 <20231029210848.78234-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231029210848.78234-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

On 29/10/23 22:08, Richard Henderson wrote:
> These functions are no longer used outside tcg-op.c.
> There are several that are completely unused, so remove them.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h |  47 -------------
>   tcg/tcg-op.c                | 131 ++++++++++++++----------------------
>   2 files changed, 52 insertions(+), 126 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


