Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D67DF7C9540
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 18:07:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrh9r-0006PE-3i; Sat, 14 Oct 2023 12:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrh9g-0006Mh-Iy
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 12:06:22 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrh9R-00027i-2D
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 12:06:20 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c5bf7871dcso24229935ad.1
 for <qemu-devel@nongnu.org>; Sat, 14 Oct 2023 09:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697299563; x=1697904363; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FsdaAirJpSLA+la6OBB4at1QS3pn1Q0ibml9wEG7WyA=;
 b=BQ9inxxRfMB/yzDyFENX3i3re4EptnT8GzAfBWKCruivikbu43jLY02lLMeYdoR5tX
 lm6gSKyIrr5V1Bvb5YiW+ZJhaqZkMkCgmt6b5Va3NkhRmR7W7xcNjUsu39BOKKs0dYQR
 TAQxxOGbFy5XidOlsRFM6VvHhPgNV99379jsKiqLs5brk/YFLbAoR6dKnTFV+sguaeS+
 LspD/H/77XTXwfHG+iUqMRXukoIwkekP2Wahfs04zGkZgCciNQXSaHLC1UyRbGW5HdPG
 S/4LrfBycqVlf7NxatNmJ2geIg1bOuAblnuqXggQZQECG4gM2iNHMmsWIh9Z7G/7gBQq
 W4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697299563; x=1697904363;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FsdaAirJpSLA+la6OBB4at1QS3pn1Q0ibml9wEG7WyA=;
 b=Met4syqdqOqlpC2Kfj4h8GCm0GVjWyO2RSL4ygzzaEAyLR/J5zm2psv8hASVQHohoK
 2iPZzKFtp0/LQztIOo/RwmnrPrA+fTQMxJ3vDYlAks3bexmuinErFg381hIXxrXIQn22
 pGhPBv3frsQsT02KFhpooTJs2K7K8MyG/l947FIe3zpGKQU/epjH7x5EDFUboQ9y/7C/
 xvjxVXbB5PAAWVPTowAlPxYol4NzxIJYNo90XO2dD5jF7xbT89snATQUIr4lSqvP5Q6w
 tBNv74WiaAU0wLUXNRVznkRRaFTYowbkcCtlW+JGAsK3Z/RwNRx7GrJAsDqGELXGQIMh
 pNBw==
X-Gm-Message-State: AOJu0Yxj1yoawBGvX/P5E05l2xoxNLHtTv6DC7WA9ImQOFyaH27hzrDf
 Vwfo8voQLoth9OcEfQVRdaB46A==
X-Google-Smtp-Source: AGHT+IETV0ZCmoUtmUcqyFl1/lyPuKtdGdtgfw48q+iifuZRAXd5P+mnwth6/UdpW9BXnNK3q1WnYA==
X-Received: by 2002:a17:902:82cc:b0:1c9:c735:2d60 with SMTP id
 u12-20020a17090282cc00b001c9c7352d60mr10495989plz.17.1697299563411; 
 Sat, 14 Oct 2023 09:06:03 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 ji20-20020a170903325400b001bbc8d65de0sm5722639plb.67.2023.10.14.09.06.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 09:06:02 -0700 (PDT)
Message-ID: <47144c91-3c1d-430a-b917-fbe9bb7b193c@linaro.org>
Date: Sat, 14 Oct 2023 09:06:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/18] target/i386: introduce flags writeback mechanism
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231014100121.109817-1-pbonzini@redhat.com>
 <20231014100121.109817-8-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231014100121.109817-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/14/23 03:01, Paolo Bonzini wrote:
> +static void prepare_update1_cc(X86DecodedInsn *decode, DisasContext *s, CCOp op)
> +{
> +    decode->cc_dst = s->T0;
> +    set_cc_op(s, op);
> +}

You must delay the set_cc_op() until the end too, for the same reason.  The function call 
will emit discard opcodes, which will kill cc_foo while still live via the memory exception.


r~

