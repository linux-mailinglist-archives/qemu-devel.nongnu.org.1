Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEE573A75D
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 19:37:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCOF4-00020y-Db; Thu, 22 Jun 2023 13:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCOF1-00020f-4q
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 13:37:07 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCOEz-0000DB-L4
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 13:37:06 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4f8792d2e86so5530759e87.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 10:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687455423; x=1690047423;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/fsL2cVXAXnCdY15L3MolzVIRIDo39bn2bc5jAVthdc=;
 b=kK9ms6oxy4w18XnqLzRC42c2y3VtHaZF6WjXDGqNMNiQNvba5S8AHyOTZEqCY8BDzY
 gSHrJgC8UlnZMr3hGroun6OS37q7nTj7t0rJS1s4dj4kEV/EdOM8bG6f6JAbd91UV8Re
 ovlIHAL3ZTFS25sFLjk1CL4w9JQHOOEo3xYK1FUH6doAfwuUX/AZyGxw7CjLF/N9xRPE
 Ce6z40LRpgoVSeaffnwM6XvFDi1MLGoP0rPfRGV9+UEr6gsStEfKCmRCH3QhxI4LKpZy
 17/b15DUPPGEIlxPBA4ymfRxYz11wMz+nZmLgkeWJndJ0QllQ7EC1vHkRYpy6UOVehTP
 gASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687455423; x=1690047423;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/fsL2cVXAXnCdY15L3MolzVIRIDo39bn2bc5jAVthdc=;
 b=NFoO2SsTGNPmC6PXzuVHQVo3o0y5F7N0wRGXWSAaatK6ExgudWG9f2+bw4WntVAmlf
 qJ66K2+u/aI/vsF+PSv4PSJI/uyTC0rAbvNPodvqqo4noRjJlrMHGOfqqcX3P+PNtsSO
 3J6b4oC6Dwfak66YxiuM+yahD9WXzufX0UsX0079RjrFt7LQ1GtfGhxKyUBwqOcs0YLX
 xRUTQipWJBJ71vuqlM9Bcw8Rk2MbFy0+6biVV6cQwkbqqujVf8kcXBwJ76QUHJq1dzW+
 KrSXSEpiRi7cRG9y11MT/UTShk8T0DsWqardUASVYwW87m5hqKD5tcLH3S5UzMadkf+L
 wSRg==
X-Gm-Message-State: AC+VfDyGQQAlb2mqY7M7YILHQrt/pO6Qbsg1Bqk62l13ttUgEAVYogdh
 lGeIMU/h84MmZOSLeKa2Tz360w==
X-Google-Smtp-Source: ACHHUZ4hXNqmNTn6U0F9nFN6Me87Rr7UBrptzXZ7Yf1Vq5uPEksRCjxnuN8AqvGh0D6IfBMleD+RSQ==
X-Received: by 2002:a05:6512:1284:b0:4f9:5ca5:f1a6 with SMTP id
 u4-20020a056512128400b004f95ca5f1a6mr4238864lfs.17.1687455423332; 
 Thu, 22 Jun 2023 10:37:03 -0700 (PDT)
Received: from [192.168.157.227] ([91.223.100.47])
 by smtp.gmail.com with ESMTPSA id
 ep8-20020a056512484800b004f26f437ad8sm1181122lfb.53.2023.06.22.10.36.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 10:37:02 -0700 (PDT)
Message-ID: <960b4b4f-8899-b263-4f31-5a4ea798e034@linaro.org>
Date: Thu, 22 Jun 2023 19:36:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 05/16] accel: Destroy HAX vCPU threads once done
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
 <20230622160823.71851-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230622160823.71851-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x135.google.com
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
> When the vCPU thread finished its processing, destroy
> it and signal its destruction to generic vCPU management
> layer.
> 
> Add a sanity check for the vCPU accelerator context.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/i386/hax/hax-accel-ops.c | 3 +++
>   target/i386/hax/hax-all.c       | 1 +
>   2 files changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

