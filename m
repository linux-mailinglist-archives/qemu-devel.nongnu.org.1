Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E245724935
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 18:32:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Zb3-00059Y-47; Tue, 06 Jun 2023 12:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Zb0-00058p-SP
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 12:31:46 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Zaz-0003AA-2l
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 12:31:46 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-542c54455e7so1955304a12.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 09:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686069103; x=1688661103;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CCSZOC3ace9mgIPiCLtuSJqT1KrCOoXa+Sft6OEDda0=;
 b=wcLupTDwB2WAZsscImkXoR6/nE2UCz6/svrkcLEob5Oa9SCKK+zDA0W3LMFIMcXBhO
 hHUVMxUDnQ9EwWiFkiDX3Cldo7R1h9bFctvsiadHmd99TIdJF3lkMvEbWi4vB/BrN9d8
 9lykGd1OxqctDPgOfL5zao1zOcMFUetIsc1R5l3AmAsz/Ma5R3L9CiFaDnq9+KNaLVU4
 Gawv8/brAtNSNT0v22LNsQesjtCuyNxg52qnGTEohGnGiESInH4alGdH3mvsHj4XGn7C
 s3sxFsd6V3NdwxKVD2rKXOSTwRIK7simShiZ8WWcJ1fj3hMzSPSad1tpNyWR2YCcymeV
 fziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686069103; x=1688661103;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CCSZOC3ace9mgIPiCLtuSJqT1KrCOoXa+Sft6OEDda0=;
 b=APcrxOQCRwp77dCDTCaCa/AcRH7+Y8Qdg0B88jejXc+W1YyqYBwmXyE0L2SsftxIqK
 dx/Mx7gID4AHOkb3amQfXSdoSb+i8Nv6HNuYQD8GJSO7IXyumN+k5bD0X9JjK3VRwaMK
 RWxuFinP7irq0qBgIUiUIDdUM2UC2TDUPxi8NIrQWONxXSyvW/AQqZvPcLNjp8SVAy6D
 kJu7u6Z8LbIXGZVGT5d357SWKS2qCPEUivEPPCuaoJQDv06azyeVPF/Wgt2aDgEqO0ui
 Q2jsQYcwygYO31BkHfBy5PnC0zMsQ/a2gttdr0avoAL+EMYVo1wED+ciLgV2oVJYECc2
 +LvA==
X-Gm-Message-State: AC+VfDyO85RCETBXxijskKlc4/9pyKiJWMCD6r78R6FVzR18xwtCTNA1
 xor2WoKDMOqGRFLw+9uPM8ItWg==
X-Google-Smtp-Source: ACHHUZ4aJf+qqsz6XcGRR2polUHRTRIviQyHSI9K6uDIB44fWTtJBvQyfF/pRMTuv3xQ9d5FQRMr9A==
X-Received: by 2002:a17:902:7c92:b0:1ac:8be5:8787 with SMTP id
 y18-20020a1709027c9200b001ac8be58787mr1060626pll.21.1686069103125; 
 Tue, 06 Jun 2023 09:31:43 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:b7fa:ce59:1445:805a?
 ([2602:ae:1598:4c01:b7fa:ce59:1445:805a])
 by smtp.gmail.com with ESMTPSA id
 a17-20020a170902ee9100b001ab1b7bae5asm8777394pld.184.2023.06.06.09.31.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 09:31:42 -0700 (PDT)
Message-ID: <5642acfc-46b3-c471-f8e9-1dbcc512e61a@linaro.org>
Date: Tue, 6 Jun 2023 09:31:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/5] target/arm: Rename helper template headers as '.h.inc'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org
References: <20230606141252.95032-1-philmd@linaro.org>
 <20230606141252.95032-3-philmd@linaro.org>
 <9ff0f082-1b04-8bf2-6a97-1e9220aa4509@linaro.org>
 <f991008b-015b-dcce-fe00-838a6ddefde5@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <f991008b-015b-dcce-fe00-838a6ddefde5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 6/6/23 08:49, Philippe Mathieu-Daudé wrote:
> For example in translate-a64.c handle_msr_i(SVCR) calls
> gen_helper_set_svcr() which is declared in helper-sme.h.

The placement in helper-sme.h was not done with consideration as to which compilation 
units might need to use it, since that wasn't a thing at the time.


r~

