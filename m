Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CFE737211
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 18:49:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBeWz-0000ru-If; Tue, 20 Jun 2023 12:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBeWx-0000qv-66
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:48:35 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBeWv-0004HQ-Ex
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:48:34 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-986d871a9beso640327766b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 09:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687279711; x=1689871711;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oHJja0sseFGPbho8OKig4+L941WnlMPcDfOMYGQOS3g=;
 b=Xztpds0xzJjxtE6zRLBIzk4DGB/kuwyv3qGsbyP5BGpWtO3QAmG6Jk2zGzGFmKxzJR
 An6O44b75xqoj5npgPmuH1HBG9IVMu91Hu3XcLmJyfSmnUtobKqSVontFrEuXVxSht2a
 5MYa1aWlaGGS+skTm4pfoPOHOxzBQ/jucYfu+atGuFSy3PSpPJ6r2p6LmzPBe3tfLVAw
 /s1ywXNCC4A+pEiyaJsq4QKIOX8t1Pq00LlbOGqjRzSPpefLLfSds+wk7EXpbUa509q/
 RejP0c82WN76DS7OrUQo6yPzmP2JL7qHUhotBNzSm3m+Zjf+r3vPqou0LnY55joDyiP7
 iKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687279711; x=1689871711;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oHJja0sseFGPbho8OKig4+L941WnlMPcDfOMYGQOS3g=;
 b=R1bKQDu9ZX58leyAZZdQ/WgP6SJTZ8/vpPdm3hfvUKBO5B1hcjqRXUZcDQ6QqtZWIm
 ioEMFe/YTuBmZIkbcexo0RP9MhTQezbKkShY3D+S7DlfxgQFsVJSinpdMhYoRioEfdW8
 PBgvtLYyWr6o5uVGuFi+wFkx0Hq5vWAosGS64EJku73aLbizktkBNU6t/BtRHQ6f2Ha2
 6bkbN9AQkveQPws44UbE/0nkxIUebmAOfOzRKxizxdVTZUJekNPLeSbCOKOrv062UM1s
 CEnqIMhhRMyPQWmZdfpfL19BoeD8wB5+ozL817Jqc/KWAsTBTL2uZv1wmy+K6GPAiZnW
 d8ng==
X-Gm-Message-State: AC+VfDwfNB+UbStoGfuJ5YnaJZ8nZQDlFEDhdbS87ZmA1VYXQMIShgYl
 rVUeXdz21mF3S3rGbg2N7ZTWoA==
X-Google-Smtp-Source: ACHHUZ7SK9cjAqBkBvZF0mm4gHbkQ/+bfgUfezm2hNZN8Cs9KlvjW/gsAUZw6ITdcXpy57/dcJA0oA==
X-Received: by 2002:a17:907:3e88:b0:97d:cdf4:719f with SMTP id
 hs8-20020a1709073e8800b0097dcdf4719fmr13531888ejc.68.1687279711480; 
 Tue, 20 Jun 2023 09:48:31 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 c24-20020a170906341800b0094f07545d40sm1659684ejb.220.2023.06.20.09.48.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 09:48:31 -0700 (PDT)
Message-ID: <666fbda6-33d5-48cc-3e12-6045617bde8d@linaro.org>
Date: Tue, 20 Jun 2023 18:48:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] target/sparc: Set TCG_GUEST_DEFAULT_MO
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com,
 Fabien Chouteau <chouteau@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>
References: <20230620164040.912490-1-richard.henderson@linaro.org>
 <20230620164040.912490-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230620164040.912490-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

On 20/6/23 18:40, Richard Henderson wrote:
> Always use TSO, per the Oracle 2015 manual.
> This is slightly less restrictive than the TCG_MO_ALL default,
> and happens to match the i386 model, which will eliminate a few
> extra barriers on that host.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/cpu.h | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


