Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AC574BC72
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 09:00:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI1uA-000532-9I; Sat, 08 Jul 2023 02:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qI1u7-00052I-KR
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 02:58:51 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qI1u6-000334-3O
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 02:58:51 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbc6ab5ff5so29201525e9.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 23:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688799527; x=1691391527;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JvnH6S/veuGqfccc61xFTmdXDiRUCJVExTm/xC3MFSo=;
 b=SetA3/AOld9I0B3QkdXwyuMdxqYgTIu9Nuv6ciguaa7fDTTBu+b6m4BsFerxOVAY1t
 INNI51NK4mg88CQJkHUnzV6HkwlvYhefbn0oTWtBouosgYWnXAuBkLVDQuQOFlskxFOv
 nmltGLrmkFIczpbaQHvKKpZrBinsBKL/aBxeuaAKhAQXCUY/KEqddRZttzn8CGPxgE3o
 hlVo4GiMMASCWkO0jxobisYuVyaxvOhvTMnXAnIpPRQg7yiqKRjoKxu3sRLetQiY42NY
 3dBMZjUvqjuGsxxg9KcDAuqOcRE0J+JwilvQtRDEXcP+LZzjK/Nc0h3uAp5Scp0S3HOl
 OQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688799527; x=1691391527;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JvnH6S/veuGqfccc61xFTmdXDiRUCJVExTm/xC3MFSo=;
 b=RXoLKmNIQSl6UqIwUZ+nfKyxJ1jOqBHrbJoOacSd1KkEF61vp0PweOsbeWRp8hgUMN
 hmvTQs7TyFirjGcb1HBiI+t/X0RKafnsR2AE9KIsQDQZGceyeUwFt+kx4VIMUBVgnNbz
 hKJrgjR19hS8CR9rB8iJ2EPAmyg6griFoaDLNKHsTuR4KEyvtsyMOJqopwYh7nW5D3Wy
 DBW+p89S+/wgY7W5CoARoPKVdHIZ6Q/awg5JHze74eMK79aTbXjUU/DySdwImpcR9ep5
 osesPo5f6Dgqoz5lAyyknSwg/SuSxGPibv7ivrdDk2bTuBqxsl+wvjPypbztz0rizMAY
 jClQ==
X-Gm-Message-State: ABy/qLZaQs6pa+CHR/Hoyf5mexa12+/W6MWe1ZKd4QCykncEtBKUROtm
 m73i58vQGnOww1ua3AAzz0e765Tu75Gy9KdfQrG32w==
X-Google-Smtp-Source: APBJJlEOCsbJY2FVFaXKHaH9xQ3shzv7x2XlahL5tpvNlt/94fz0iastJyNYFgsqQ5229xlydb1ATw==
X-Received: by 2002:a05:600c:210a:b0:3f6:58ad:ed85 with SMTP id
 u10-20020a05600c210a00b003f658aded85mr5380226wml.10.1688799526913; 
 Fri, 07 Jul 2023 23:58:46 -0700 (PDT)
Received: from [192.168.1.5] (host-92-23-208-66.as13285.net. [92.23.208.66])
 by smtp.gmail.com with ESMTPSA id
 v21-20020a7bcb55000000b003fba9db141esm4318909wmj.38.2023.07.07.23.58.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 23:58:46 -0700 (PDT)
Message-ID: <2b831f11-f235-609f-939c-3aadcce81e08@linaro.org>
Date: Sat, 8 Jul 2023 07:58:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 21/46] target/loongarch: Implement xvsigncov
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230630075904.45940-1-gaosong@loongson.cn>
 <20230630075904.45940-22-gaosong@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630075904.45940-22-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 6/30/23 08:58, Song Gao wrote:
> This patch includes:
> - XVSIGNCOV.{B/H/W/D}.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/disas.c                     | 5 +++++
>   target/loongarch/insn_trans/trans_lasx.c.inc | 5 +++++
>   target/loongarch/insns.decode                | 5 +++++
>   target/loongarch/vec.h                       | 2 ++
>   target/loongarch/vec_helper.c                | 2 --
>   5 files changed, 17 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

