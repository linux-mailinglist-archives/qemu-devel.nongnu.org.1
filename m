Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A1E8237A5
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 23:19:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL9Z5-00020J-9Q; Wed, 03 Jan 2024 17:18:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rL9Z2-0001zi-0O
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 17:18:16 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rL9Z0-00014O-Gz
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 17:18:15 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-595aa5b1fe0so1636816eaf.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 14:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704320293; x=1704925093; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oY7A6dcazrd1HX/YecrgNeGFMezD5hHIGXl4MS6ZxdA=;
 b=T3703RyBJ4I8hIoHXkF/KEf/DB1LOqAa9eUA4IhtT3dMjHiw8BK+hGhyJdJWcpVOzf
 S+OZyAYdyWe355lwiYz5qqJq1e+cF9JXNHltNDwFhDf2RFNx6EF6OHN2u8y/C00RCg0a
 g8ZJpviyXagpHRY9Sz3nimPT/0E0yMVDhUk66G4vjMVrmKt0hwdY+/4R8u4CvBBl9/Gi
 GNJ55gcGNAfWNO0WsnPAE8pTOYBTqJENxS76biYfG7NR2nXyYhv4rtuUrUt1VMNnQRJv
 7A0zl8xnffLSv/9r91IWarnKG9X9BlN+/nxSvsEN/T6MkTbnmgk2XSHfBAUZnmL7L//U
 FYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704320293; x=1704925093;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oY7A6dcazrd1HX/YecrgNeGFMezD5hHIGXl4MS6ZxdA=;
 b=Z/HwPSpF1AUPmSVPK2hnYRhasuSrc6PzsZ7bgSRL4uWPuWBodmF5I+icEFedvNXloi
 nj0LELGibDAOtqw4Kg8OU/Jlrs4D71PNGllXbyub80BQE0gXAFrLN40QgZJFgVvGXW+N
 x5MPXNhgRDohjJXsNh07X9TPjxfRWpvNJ7JoW217nvkugVf02ijbBPeOXLpuRxLKLSed
 mxIZmzepHmfWpFIFvF9hT3GJLrlenFKdnBvGdUESMpNzbhmK975HccgRH/KQmAlZarIk
 nEDdXD6YbSDTUrTY0FikHVNHh+4zlgqnj/b+C1gjmRRguNz0HR98YEwQiVZj7JMmqVjM
 TsgA==
X-Gm-Message-State: AOJu0Yyq4RHxIO6ARYMVBhYUkh1Ffj9GfTxfGPJBrct2R+06v1Tm2esX
 T40gGDF9h81QyPicn9kCzDh2etlqNEKlzA==
X-Google-Smtp-Source: AGHT+IHfl63e3h8k0UBNGbukm9N6fcWtClBQsI2DHfGkuEYK4eVmhRuqADGuMXejLyJE1ZfrfNa/Wg==
X-Received: by 2002:a05:6358:6f8d:b0:170:cc82:db41 with SMTP id
 s13-20020a0563586f8d00b00170cc82db41mr24209890rwn.21.1704320292794; 
 Wed, 03 Jan 2024 14:18:12 -0800 (PST)
Received: from [192.168.50.95] (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 k4-20020aa792c4000000b006ce5da5956csm23439586pfa.24.2024.01.03.14.18.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 14:18:12 -0800 (PST)
Message-ID: <8ee0bdd6-42b8-4b4b-9083-ea6eba08447d@linaro.org>
Date: Thu, 4 Jan 2024 09:18:04 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] target/riscv: Update address modify functions to
 take into account pointer masking
Content-Language: en-US
To: Alexey Baturo <baturo.alexey@gmail.com>
Cc: zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20240103185716.1790546-1-me@deliversmonkey.space>
 <20240103185716.1790546-6-me@deliversmonkey.space>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240103185716.1790546-6-me@deliversmonkey.space>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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

On 1/4/24 05:57, Alexey Baturo wrote:
> From: Alexey Baturo <baturo.alexey@gmail.com>
> 
> Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
> ---
>   target/riscv/translate.c     | 12 ++++++++----
>   target/riscv/vector_helper.c | 12 ++++++++++++
>   2 files changed, 20 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

