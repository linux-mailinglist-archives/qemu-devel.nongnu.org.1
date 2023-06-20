Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6FB736732
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:11:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXOT-0002qT-9l; Tue, 20 Jun 2023 05:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBXOP-0002oB-IL
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:11:17 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBXOO-0000WD-2M
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:11:17 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-988a5383fd4so375947266b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 02:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687252273; x=1689844273;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yq68unAUdMneW4tN6/iQG1fgqeqN99gloUkD0F59B5g=;
 b=lBPd+kTusZHoxz5EdU23W+yALUmezNVSJil6xsybN07BwrnjXQq1h3GNEJzS+fqlc9
 kXlHT8OEFY14A5eDY6pdspX4fZ6DhgSUWbO0slcCLNkdslkjL256vmrn2UA9d+zJJOZO
 69se5JBqLsslAd9hBGtpBELZpCbI7vr/lwDuBCKOH8nMxpjiLYERrnOUIHDz3tKqxxvE
 tbv0vQe8D/IBqYRsnxZkgZP51Js3TMPMdmGEwXQo4O0kkWOKC8uj42zTOYZrulevbbKw
 op0F63I7+9oFlAOWiA2LeDoAxEKMOhHKVAxuB2oQ3yn7lyN59VpADddDidhLKs2nbIl2
 Oipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687252273; x=1689844273;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yq68unAUdMneW4tN6/iQG1fgqeqN99gloUkD0F59B5g=;
 b=Q1xrfcOk0YZhilwXu2+b4vclmkgRJYtjJQ6Qa8lmWy19F4FJichfF1R9qB8xAjVRrw
 oZcZfJmgfnlQ9AuoLddXytvtbr/vrq+K8q4GZ4x8eACTy7eBa2P/mYYtQZBddiiYPME6
 C/qSDZIy3uZu3q+DFd07MS+YHYs+B9hspNQTMQq4dg6BT+I8Qgn61q6kYTCvfUdbWmxd
 hhQIeq5Lqsb1RTWunJojTC84UmtP0bpH6MI1Cp/qrmQgl91OBsfRXjvAzKA/MyELUlsH
 e2ryVeNPO2Zh10tcE+NXEv9lOpamNF57OLD3AxcI1UpFYCyQVhVMSmU9rLfE2iRQaklU
 +LCg==
X-Gm-Message-State: AC+VfDw3tng7FoO6X66ta83RJAFTEXIGPgP2lIPbi+PkTQHNJiCAfpge
 3dG0E+3ugVtDiP/gph4wpPMVGQ==
X-Google-Smtp-Source: ACHHUZ5lQD7Fwy5K2bc0HXy1L/5BRlzDtSrezKkYa+KNEbePQzSKPULh9GusX+/VtAIfPc9QuV/z6A==
X-Received: by 2002:a17:907:360a:b0:982:a022:a540 with SMTP id
 bk10-20020a170907360a00b00982a022a540mr12929152ejc.11.1687252273805; 
 Tue, 20 Jun 2023 02:11:13 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 fy25-20020a170906b7d900b00969f25b96basm976952ejb.204.2023.06.20.02.11.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 02:11:13 -0700 (PDT)
Message-ID: <bcbadbf1-5905-713d-799f-101f0cc22923@linaro.org>
Date: Tue, 20 Jun 2023 11:11:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/9] MAINTAINERS: Add reviewer for PowerPC TCG CPUs
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>
References: <20230620055911.187065-1-clg@kaod.org>
 <20230620055911.187065-3-clg@kaod.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230620055911.187065-3-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/20/23 07:59, Cédric Le Goater wrote:
> Nick has great knowledge of the PowerPC CPUs, software and hardware.
> Add him as a reviewer on CPU TCG modeling.
> 
> Cc: Nicholas Piggin<npiggin@gmail.com>
> Signed-off-by: Cédric Le Goater<clg@kaod.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

