Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B385C799C0E
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 01:32:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf7QW-0002HT-I8; Sat, 09 Sep 2023 19:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf7QT-0002E6-TM
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 19:31:41 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf7QR-0008SQ-LM
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 19:31:41 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6c0a3a2cc20so2307346a34.0
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 16:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694302298; x=1694907098; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bwgrzhzStxt1tRAlOrpewVz1odsaEa2xY4qIDGr9x8c=;
 b=dFKFfSZKR4dNPqJ/eCRIkqv9AXk4K8OArqxeVDXdm5c6k1HwIH3H+x/U3LqZEydMXJ
 P5t0VdjvEjFOxSz1vSKNRvVjXJhCO366KZozvNjb6IYj4MOIAQCu+yeagR2KgW3Jx3Mw
 ++IdG6VWia9nqmlcG8LBzP/YlP6mzuiT2BW7Ni2nIhkdMGosmt979Cld7C6klQFddkA/
 GMncaVyIUSPCYA5DYjT2AM0H40k8t1MaiBbUKH5E7OXefHp4/ksDevgaxb3ay9WojJeL
 EuLHvVmJFL/t8bXNVTyqaG1qmWKeAiVjIA7LtRggiig/P6gtUp36Ha2HMVd/L3HdJybJ
 hKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694302298; x=1694907098;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bwgrzhzStxt1tRAlOrpewVz1odsaEa2xY4qIDGr9x8c=;
 b=vkWmHZrk42DnzaF8M9QR4NObBsqqUlD3y3z28KBViwKC1AwSUe3Qw3HUEv/iv5zgym
 6Gucis/2JDn0dYPGdiv9XnDIe0YDlsEuTRkSAK6o91IuoGL83mOIMAAkW/FbiKpxlKh+
 Jfv0ngZfAFAiV+YqEBFjCugD0A1vtayUAKv4hqD+0z+Ja0yR3pQqGASgQ5ZEhgiT0Mos
 yC26MqrlsckOl60UiCA+Y9T63/X8Ynln+BT/rffo006ZxbllysViy7yneSc9EjPZiZ+K
 JUR14totIMbHOmo8opVqB3WfSf8ZA2U3yBYj01dnKR5p7EYSQKfv5yLbLl2lYc1warAD
 aIgg==
X-Gm-Message-State: AOJu0Ywbm1KVfTsNWTGj6EcJorE3QVZS8E/EVNKaRdVCTSW5MEN15EM9
 9Jy5r5xNQpiyumX17hIW8FQI8Q==
X-Google-Smtp-Source: AGHT+IFj9+H2m6xx6ih/UkJynIxDwWufzRc2p4Gk10whdJxNlD4Ts9kGcSxFBgqfJyazq0xPelV7bA==
X-Received: by 2002:a05:6830:1dad:b0:6bf:178f:aade with SMTP id
 z13-20020a0568301dad00b006bf178faademr6776820oti.11.1694302298423; 
 Sat, 09 Sep 2023 16:31:38 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 k12-20020aa7820c000000b00687ce7c6540sm3252795pfi.99.2023.09.09.16.31.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 16:31:38 -0700 (PDT)
Message-ID: <2c1a73c4-176c-8324-d3c0-9b02eaeef17f@linaro.org>
Date: Sat, 9 Sep 2023 16:31:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 03/13] hw/i386/fw_cfg: Include missing 'cpu.h' header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230904124325.79040-1-philmd@linaro.org>
 <20230904124325.79040-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230904124325.79040-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/4/23 05:43, Philippe Mathieu-Daudé wrote:
> fw_cfg_build_feature_control() uses CPUID_EXT_VMX which is
> defined in "target/i386/cpu.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/i386/fw_cfg.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

