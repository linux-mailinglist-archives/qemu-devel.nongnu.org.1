Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C132B8212C8
	for <lists+qemu-devel@lfdr.de>; Mon,  1 Jan 2024 02:16:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rK6tv-00071x-KR; Sun, 31 Dec 2023 20:15:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rK6tg-00071e-4H
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 20:15:17 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rK6te-0000g3-F3
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 20:15:15 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d3ef33e68dso54294405ad.1
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 17:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704071711; x=1704676511; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YVh7VETEb57NtSYcHAGYPvfJ6wu1wYnFnD9PD22qLr8=;
 b=Cpa9hDXWv3I2SobIc7srj19P9wVPt9UO6q5tRWLoDLicO16KXIfEl6TyXDfi9qe9EB
 DEw6L8kS8Y0h3ofYvSSEsjjKo6wvnnNhTMQh/ZTuAdxSvuM6d0A+tWpEq51lhUFIOOqE
 oFyxFYIlqESyGsaAyzTNpEmK/3+TB+Og2b46E+Go3pryzV0F63IVVBRSj0iEldaiJOba
 UIrJjhGClqc3lg5YUDrUNDaPzicZnAdxFCW3ICkJu2KQMyNhDKtV1eHTUKEP9spoJ5KD
 k1v/vRqtIq05l3GRn/hFn6QRM8Mma7tjCz5qCGXXdPVm6rB1LcbwOZFeXcAjle23xoJg
 orOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704071711; x=1704676511;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YVh7VETEb57NtSYcHAGYPvfJ6wu1wYnFnD9PD22qLr8=;
 b=rAVIwNNAPDbAn3NkSAjn9OHzd9ok8VWYyAhdESBqpg71S7XV77ifoE5qagRDyvMOEh
 hiTSMvGoLitVP/9yRQsZqQOzWsTvPyiecpVxSHOF/v2/n7fDB0OX9phkULqWJSL9OPxq
 UH1qDk4vZrR2jd/cDmDq0ebkf3I3Rrrg1s+qSYrotQeu9jlXIxpty3N0duAGwXI9fSCZ
 KAQ2AvYGIRR6C62ZxjLQWxZS0w0moGbxIBYQeFb2liDbaUgyl84p3/vOunlJDEqTjhwA
 NKXPrJxXR2BA7G0W/1NEYtsrZ9EAs6DehTxvPIRD+62vGaONpO+HBV8GwZXtGRyTGEAT
 Fpzw==
X-Gm-Message-State: AOJu0YxLR/gk6jfYlzxhWJh3CgIr7EREyHWTKWlE8//IRy5HvnWZXFya
 xng7UtqO7E/Ix0CNaAQWWeXhQI3aHUgvXA==
X-Google-Smtp-Source: AGHT+IEw8Qb4Gchwyn2l24vQrZnixQ46gBIgT61QXEqeTotbGmUapNbKVykl0U59zrWYidwtSRt8Yg==
X-Received: by 2002:a17:902:efd2:b0:1d4:415:5fed with SMTP id
 ja18-20020a170902efd200b001d404155fedmr14085971plb.65.1704071710787; 
 Sun, 31 Dec 2023 17:15:10 -0800 (PST)
Received: from [192.168.50.95] (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a170902b08400b001cfcc10491fsm19149798plr.161.2023.12.31.17.15.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 Dec 2023 17:15:10 -0800 (PST)
Message-ID: <5b954500-4600-4bf7-a5eb-0ee546147a01@linaro.org>
Date: Mon, 1 Jan 2024 12:15:05 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tcg/i386: convert add/sub of 128 to sub/add of -128
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231228120514.70205-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231228120514.70205-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 12/28/23 23:05, Paolo Bonzini wrote:
> Extend the existing conditional that generates INC/DEC, to also swap an
> ADD for a SUB and vice versa when the immediate is 128.  This facilitates
> using OPC_ARITH_EvIb instead of OPC_ARITH_EvIz.
> 
> Best reviewed with "git diff -b".
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tcg/i386/tcg-target.c.inc | 40 +++++++++++++++++++++++----------------
>   1 file changed, 24 insertions(+), 16 deletions(-)

Queued, thanks.


r~

