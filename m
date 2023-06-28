Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC40074109F
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 14:00:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETpF-0005AY-Kn; Wed, 28 Jun 2023 07:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qETpC-0005AN-CB
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:59:06 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qETpA-0005Ac-GZ
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:59:06 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-313f58d6652so3120161f8f.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 04:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687953542; x=1690545542;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XAnNOBqj7/aZOLa/iEWVdgiwRfPn+uBhlnTFYDZDHtw=;
 b=XE7Vi2wrCeeILyk3U/eN0QEw2vyalWxVrmJf4lD0tUb7oMCiVJf8wS7IHVCfWF1ljm
 UcYgRcV+vj/TBd9upybrGu2ZGnWQcYk115AdgEaWs35KGlrLBhcqG0BEhTcU7YjZck4e
 hZnPymWrPJt5bpB6buQ8HEi1nwHGrrdsvvsmSmYanpPr8vBk4Iw+l38CFXHwaRUuBcEw
 oO5si+rS6KwqffIjHKgUWwn6ziExQo+Lxfh6bCrhbutF0UwXkHqNHNbT49sTTF/BwM5b
 xVXU+6JUZHdDPEpQFm8vio/70Zk337UqTeAm/3QQDEKOChBQNaN3tDnqXgvim7JECTXh
 ovwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687953542; x=1690545542;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XAnNOBqj7/aZOLa/iEWVdgiwRfPn+uBhlnTFYDZDHtw=;
 b=aSO6sAiV/C7nHcASAewl8TQMIY6kVXet/jw/EhS9fS/nh0n5AbuoBGTkf2L0tvpied
 L9s+ybcWNphzkYL1Wsgk0pkbYFn2sgTKm0zhsV5iM6T4lVhCS2U353mxU3AqiYa4QiXT
 WNf4HGhlRuidX0PH495bctdmk7DUpsIImUisqthM/BQPKDuli8vqRNCgfPvjtUTVYMQg
 fnhmvINjdvVGELAim5W//9a/Zkq6ci5ZNWuH+ZDLsZ7PqaGaCcQpjzY42VG5F8jaTSQg
 SomKt8BeDSRQSSCttXyO9CG+yiTJ6M6P7UjTny0hVNrykRMD8/7x8Y67UcV+2HeSK6uM
 X3WQ==
X-Gm-Message-State: AC+VfDzOlARIPMHt1scOV+7mEhmwJdh59+fOI+zkoAsUsxB2SlxgoAK5
 KHr9EFklJF8tEqGB7HvIf4MXobjsroowfu/qiNI=
X-Google-Smtp-Source: ACHHUZ5EJieVTJ0ylfA8kzbRNwsOjUJqO0iacg3Gk1TjS5ordwDft3hLui2kj4QeSRA9jXw9Lp4yWQ==
X-Received: by 2002:a05:6000:1b81:b0:313:f957:fc0c with SMTP id
 r1-20020a0560001b8100b00313f957fc0cmr5011317wru.47.1687953542430; 
 Wed, 28 Jun 2023 04:59:02 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a05600001c500b00313f7b077fesm6513263wrx.59.2023.06.28.04.59.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 04:59:01 -0700 (PDT)
Message-ID: <19821e47-0ea0-ca79-2c1c-3f663c9921f7@linaro.org>
Date: Wed, 28 Jun 2023 13:58:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 00/16] accel: Share CPUState accel context
 (HAX/NVMM/WHPX/HVF)
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, xen-devel@lists.xenproject.org,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paul Durrant <paul@xen.org>,
 Reinoud Zandijk <reinoud@netbsd.org>, Eduardo Habkost <eduardo@habkost.net>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230624174121.11508-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230624174121.11508-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 24/6/23 19:41, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (16):
>    MAINTAINERS: Update Roman Bolshakov email address
>    accel: Document generic accelerator headers
>    accel: Remove unused hThread variable on TCG/WHPX
>    accel: Fix a leak on Windows HAX
>    accel: Destroy HAX vCPU threads once done
>    accel: Rename 'hax_vcpu' as 'accel' in CPUState
>    accel: Rename HAX 'struct hax_vcpu_state' -> AccelCPUState
>    accel: Move HAX hThread to accelerator context
>    accel: Remove NVMM unreachable error path
>    accel: Rename NVMM 'struct qemu_vcpu' -> AccelCPUState
>    accel: Inline NVMM get_qemu_vcpu()
>    accel: Remove WHPX unreachable error path
>    accel: Rename WHPX 'struct whpx_vcpu' -> AccelCPUState
>    accel: Inline WHPX get_whpx_vcpu()
>    accel: Rename 'cpu_state' -> 'cs'
>    accel: Rename HVF 'struct hvf_vcpu_state' -> AccelCPUState

Series queued.

