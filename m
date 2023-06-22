Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A7C73A79F
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 19:48:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCOPk-0007Kd-1E; Thu, 22 Jun 2023 13:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCOPa-0007Dg-Qg
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 13:48:02 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCOPQ-0006Mc-5m
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 13:48:02 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4f86d8a8fd4so7685083e87.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 10:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687456069; x=1690048069;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CA2JjQ8/OleI6z0qNtxgxu5zyvvw1MZeyIYD2fCQD3I=;
 b=Woxpb7WYR4FvOn5NOxMo42gcotnVmBXbNOaTEK784GMQg+He54w6TFwrLdYPT0bEdn
 9ZKkMM/hG3Mk2TOVQrKcTvXUZu5ZgixwDMwBHwNiAydolumiVmFo2RKYOYR1Dx1A90lt
 Xce7H9QAz1xzbY+ZlchmtggODp6W3O9g4x5uk6/NbI7Vc/iJfcRXuBttmX2lBQSmWNrX
 adAR2Z1B2IFRfGtQiK7ZGG6nBAT7WiP58lyLTxjV/BZ3g4+SEowVSx6RepdoKm7jjbw9
 x2OQNQXlO+iv3T303ZMBmKGi/QaLOYNaHfOC3vRTynsIoXC2E9njPdaJcZ4CY+ZvB1Se
 s8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687456069; x=1690048069;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CA2JjQ8/OleI6z0qNtxgxu5zyvvw1MZeyIYD2fCQD3I=;
 b=f3jNhG4l0qNFqSgnTDoqyLzKlHv56acAJJfbTx9qEjxvu4VasmKdIRrZigVg1xbjG+
 1nDJAu2kAaw9Ifid41u31xvWOcCUUclmJQmuQIcGnpofPLMg6EsCbDA9V0qnl1tRzN2/
 loUaicaaNUuuFQSshBT/5z+h727HatUBd6ZgdFfBuh1b5NkUX2YgiZRz4uIwuf64B0Ut
 6FwLbiz4xbj5ouRc+S5kkMEz+lxzJQ+uSqmKLDfR0Sc0Lai7xAh96Fa84hRXj/BYGwpe
 x0ouLE+AB0Vx2LcBWJxtUAavGed6+YseoaaVbo/KzTYIfdttEatizTGXvPHGKZGDggoh
 jP3Q==
X-Gm-Message-State: AC+VfDz880J+ShZJPwBINoEyG+gbpGS0GwSKpNEQLpp3+TO1oTuPt9q+
 NFt8gZQ5omREJ2hpitylQwxqLQ==
X-Google-Smtp-Source: ACHHUZ70krz16gmVF54iWhD+K94iRIEs8ZK4yutx0YkjOW53miT7yXbm7wIhwHFKhqthG2rHfxqvaA==
X-Received: by 2002:a05:6512:3ba7:b0:4f9:6221:8fb7 with SMTP id
 g39-20020a0565123ba700b004f962218fb7mr2907515lfv.11.1687456068808; 
 Thu, 22 Jun 2023 10:47:48 -0700 (PDT)
Received: from [192.168.157.227] ([91.223.100.47])
 by smtp.gmail.com with ESMTPSA id
 x24-20020ac25dd8000000b004f84b36a24fsm1179173lfq.51.2023.06.22.10.47.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 10:47:48 -0700 (PDT)
Message-ID: <32335eb2-a766-dc4e-afd0-09ce62cf7fb2@linaro.org>
Date: Thu, 22 Jun 2023 19:47:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 09/16] accel: Remove NVMM unreachable error path
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
 <20230622160823.71851-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230622160823.71851-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
> g_malloc0() can not fail. Remove the unreachable error path.
> 
> https://developer-old.gnome.org/glib/stable/glib-Memory-Allocation.html#glib-Memory-Allocation.description
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/i386/nvmm/nvmm-all.c | 4 ----
>   1 file changed, 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

