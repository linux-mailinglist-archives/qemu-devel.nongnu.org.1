Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D30D773A7B7
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 19:52:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCOSo-0004U1-QC; Thu, 22 Jun 2023 13:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCOSl-0004TE-GS
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 13:51:19 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCOSj-00070U-Sk
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 13:51:19 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4f86bc35f13so7918634e87.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 10:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687456276; x=1690048276;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9RxDEfypLP474dWXJLDSfwdHncLLmi9Gthq1bxnH6Sg=;
 b=RiVWMtP0j99xIRYUNXDURWNefogBeHrukb98HKl2KpQPFeqzG8I5jV1I8RYGUIxgwH
 sBTf6FPI0LAFSEQpvawCbcgioqZrrkhjCenDgar1wInj2SzuwqjwDBLhQxIR2y/WHDOD
 uDQ5+I4pvWVB6lwB5UW3bgC25Cd4/1Dr4pX5ff+Xtzu5kIWnQxozPwnZBupIPOtpEfbi
 AxCY/kmKMitTxzq+qp51TgVcvHwWugs+tFjPpja+shXEeqz4rfRWJr73IzbwST2ryOSo
 yu3gSElU9n8FQ6tnrRY0Gl+RD1sXGK1RjAue2K0BBFP2LCwPwBr1gimeAqkmcjsllPjQ
 725w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687456276; x=1690048276;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9RxDEfypLP474dWXJLDSfwdHncLLmi9Gthq1bxnH6Sg=;
 b=hqTEQbSnNzJO9sX/S05k5+DwDAMITSRxuXHnGybNDF5SO9u7Ifn7HS/Q454kfk48Cc
 IBWtTKv6YYsKn7KoIUxLTBy3mhe1jJKsPWqLykXkfiFy3j2wulrqUgFdwf8UV/LcSrfR
 WdJTz1vtJCy8uU7OuTSDTLpaCdL87F7cXTEr071iP6P/IDlGmcd20KB5d0afdjDWNZY0
 aaam0ZhX/Hc++50nQ2fGeJC80g2zDdmsVKaXHoM6/mcrP8q8+asCTBkNw8Z7geSyyAju
 6gkZCcageBZRg3eRnb94aa0/vzQEhW5erlUIWMqHP0Zp0Oi5rdGLArgjl08rSVjB7yK0
 ygkQ==
X-Gm-Message-State: AC+VfDxVOB5QGRKAYLWligXhaMfy4aoAd2SV/1BNVIvFFtLIL4AjyRvw
 XT4riQc4KvhGQXwJoQ/dFpzDaA==
X-Google-Smtp-Source: ACHHUZ4jTKt0S9wGV9j57uZV2AskBM6ykJg1BX+PUA6Y8ggImBM58aMPiFh3pdEHVJWhW5Jzj4GL0w==
X-Received: by 2002:ac2:5bca:0:b0:4f8:67e7:8a1c with SMTP id
 u10-20020ac25bca000000b004f867e78a1cmr2333897lfn.45.1687456275753; 
 Thu, 22 Jun 2023 10:51:15 -0700 (PDT)
Received: from [192.168.157.227] ([91.223.100.47])
 by smtp.gmail.com with ESMTPSA id
 i14-20020ac2522e000000b004f24db9248dsm1195907lfl.141.2023.06.22.10.51.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 10:51:15 -0700 (PDT)
Message-ID: <58c48176-c9b2-0184-a93f-3168f66b7d72@linaro.org>
Date: Thu, 22 Jun 2023 19:51:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 15/16] accel: Rename 'cpu_state' -> 'cpu'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Maydell
 <peter.maydell@linaro.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Durrant <paul@xen.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 xen-devel@lists.xenproject.org, Eduardo Habkost <eduardo@habkost.net>,
 Cameron Esfahani <dirty@apple.com>
References: <20230622160823.71851-1-philmd@linaro.org>
 <20230622160823.71851-16-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230622160823.71851-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x134.google.com
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

On 6/22/23 18:08, Philippe Mathieu-Daudé wrote:
> Most of the codebase uses 'CPUState *cpu' or 'CPUState *cs'.
> While 'cpu_state' is kind of explicit, it makes the code
> harder to review. Simply rename as 'cpu' like the rest.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

I would have chosen 'cs', since 'cpu' is often used for ArchCPU.  But ok.

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

