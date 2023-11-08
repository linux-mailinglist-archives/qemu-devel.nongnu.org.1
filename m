Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 025687E5322
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 11:14:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0fZc-0007wP-7Z; Wed, 08 Nov 2023 05:14:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fZZ-0007cO-41
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:14:09 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fZX-0005HR-8G
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:14:08 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9dbb3e0ff65so959648566b.1
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 02:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699438445; x=1700043245; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G6vuF18Joq4CA7Aq1ah20wdIX/Pd0MTmRyV3S+CBasI=;
 b=jFcneYGxJxNixLJpXYXKE0Y7+497aT97HzkhXSnAM5AaorVlVDDCGUNd0OEai2hV8n
 QK5ODDkZ5NV37UE7PxU8pWCZ/g27W4C8NBV2oqfnDZyWqk3+1aDWYwNhaj37SUI04rQw
 5c3ZeW4JUTvxvlt+jI1W/GB36n+PLKVP7r73i06Hv71OHVz2GlhrBKE1/CmltOk9u5TZ
 outaodk7gtnMyqTo41D+Yz4+VkuRn7mDPph+EKFCzKRmmxa9jAMKfYeZ2rxGKgGS1rwp
 E1rY8xbJXUrt+1WHMHZw44bkjvea5uqiu045ARQjvXsOEPamg/rssk1BnAIdwjn8Xy9a
 w65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699438445; x=1700043245;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G6vuF18Joq4CA7Aq1ah20wdIX/Pd0MTmRyV3S+CBasI=;
 b=SA02FB5mLebcLMoK3BIH/H+4nu94S15mqwqMjjYBNtPW9X1jpsOAPW5CYRQs6eTLAB
 Tleyjw6NUCo404gp5jfpcQRl/QADgHwfpLT/luBKQIIoSKmY1Sy8dT2SJ4NVoDCuH/F/
 ikRrCwPRJQScqrFUi8D+eRK7aXE+jtZpX5rr6U8f9earqFx9l4dBIbiaQG0XIOCj52Xc
 0zOyc5/RxwQUfgAdgGnYQmwNzkJEyT81B12jmj5Uqgmp6itYz/VL036Lyndo+j15hF6a
 FEAzTSxJ4f6YmeTesp+/oKhSQiXFeCtZh/hKC03p4qcg8jFzaiEAc73VwPbCK1OyHjKb
 rjWg==
X-Gm-Message-State: AOJu0YzwL8y4kjT+6PMsGj3c2/k9vx5yx/sJ82Ut1vKO6YUiEPpSvx9K
 Nv/Ru/jVCApvaTbNkZbJthEJdg==
X-Google-Smtp-Source: AGHT+IFsxqAqE3dBdAdmrfH+zZ8AGXq+8+V9n/BL9EhzV6LKLOoVN/+IijFFRwRJX/dSjTghiOhjNw==
X-Received: by 2002:a17:907:9715:b0:9bf:d65d:dc0f with SMTP id
 jg21-20020a170907971500b009bfd65ddc0fmr1014527ejc.4.1699438445467; 
 Wed, 08 Nov 2023 02:14:05 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 o14-20020a1709062e8e00b00997cce73cc7sm794992eji.29.2023.11.08.02.14.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 02:14:05 -0800 (PST)
Message-ID: <b20f5476-39ee-4858-a149-447dc8a635c0@linaro.org>
Date: Wed, 8 Nov 2023 11:14:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 37/71] hw/isa: Constify VMState
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-38-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231106065827.543129-38-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

On 6/11/23 07:57, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/isa/apm.c      | 2 +-
>   hw/isa/i82378.c   | 2 +-
>   hw/isa/lpc_ich9.c | 8 ++++----
>   hw/isa/pc87312.c  | 2 +-
>   hw/isa/piix.c     | 8 ++++----
>   hw/isa/vt82c686.c | 4 ++--
>   6 files changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


