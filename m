Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D487058E4
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 22:33:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz1Kb-000281-78; Tue, 16 May 2023 16:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz1KZ-00027f-OY
 for qemu-devel@nongnu.org; Tue, 16 May 2023 16:31:35 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz1KY-0005r2-06
 for qemu-devel@nongnu.org; Tue, 16 May 2023 16:31:35 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-53202149ae2so2850545a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 13:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684269092; x=1686861092;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/HYphPqsQCx/mNqQgAGncflo4HLMvbGDxz2/uuT5K4M=;
 b=qD1KUvAg6109bSI+noOTiDSsowYyo+TrgzHk1Y508Zpqs3aRYKJSkQH+i6ilRA9w++
 SV9o74uqr+V18EexdQK1qTk5rhGfiFUOuTHH1oh9f1UIfTb586A8M15GoEj9U8Bv816A
 ATK759h0TNvNoTQECL6iIddtUUIQRcwbfU1e/shDEnWK8hMPrsfaVstr+V8CESTZuHei
 a7/0BhqgMedhxIg/lwwUFA4nXuLcWhtIBL1CoR1v+HtwX8QTfMaU7al5ivABBUB+0Co9
 0lEXoM1LIPn/7CJTrpkmhgmAbyyH/39F1VCemA21wjRuCGdVYZA77A/f59FmKUe2OnpB
 vaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684269092; x=1686861092;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/HYphPqsQCx/mNqQgAGncflo4HLMvbGDxz2/uuT5K4M=;
 b=OmguBeZuDka3kUOPzx60YIZytdz7BtBPvSRGT6L9O4MqN5TExbLcvadaedZqMakrkQ
 a2zTJWD3ZfvPrH4qI5CLv/C1TLdNKUNB43+dRQoZCijyE4++lrmSKm6nhB020Nlf+ED+
 +JlDIYIPrC3Js1/RZ2igTHbYx6OikIUu4Brrntm4vqWM9ZurAUwf62xBlBLAcJ+Ezgar
 SS2rq8vl2O5O2Vtw8KXzUFH0/LF6Bsp9OnTD9LFvhNnLarLqCFZewWc6JKmOKoZcxvDi
 6jogz+tnNaDpN5OkFWCn3mBT5zS6NnvGJpsqLpHGmHHbHqYaZmg0LFFvLqgTIrvuC7rU
 qv3w==
X-Gm-Message-State: AC+VfDzcNcaFCax3goZzLzGs4zVo+d0LKQlzCujskztTPQ9e+u7qGOHL
 D1kzg0xB1meKTSLhGXp7GOTy5w==
X-Google-Smtp-Source: ACHHUZ4/Ow/38dzsjcAtR38/bP2w4DLQ7kvf/12MZ162RiG+VdH0tcDbn1Wni1z6cprdwkK97jGaCQ==
X-Received: by 2002:a05:6a20:3d87:b0:101:e680:d423 with SMTP id
 s7-20020a056a203d8700b00101e680d423mr30678831pzi.28.1684269092286; 
 Tue, 16 May 2023 13:31:32 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:ec81:440e:33a4:40b9?
 ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 c20-20020a62e814000000b0063b8ddf77f7sm13581301pfi.211.2023.05.16.13.31.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 13:31:31 -0700 (PDT)
Message-ID: <db06ccfc-fcf7-3ab9-d114-8f4285f58e73@linaro.org>
Date: Tue, 16 May 2023 13:31:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v7 1/1] arm/kvm: add support for MTE
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eric Auger <eauger@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Gavin Shan <gshan@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Andrea Bolognani <abologna@redhat.com>
References: <20230428095533.21747-1-cohuck@redhat.com>
 <20230428095533.21747-2-cohuck@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230428095533.21747-2-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.666,
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

On 4/28/23 02:55, Cornelia Huck wrote:
> Extend the 'mte' property for the virt machine to cover KVM as
> well. For KVM, we don't allocate tag memory, but instead enable the
> capability.
> 
> If MTE has been enabled, we need to disable migration, as we do not
> yet have a way to migrate the tags as well. Therefore, MTE will stay
> off with KVM unless requested explicitly.
> 
> Signed-off-by: Cornelia Huck<cohuck@redhat.com>
> ---
>   hw/arm/virt.c        | 69 +++++++++++++++++++++++++-------------------
>   target/arm/cpu.c     |  9 +++---
>   target/arm/cpu.h     |  4 +++
>   target/arm/kvm.c     | 35 ++++++++++++++++++++++
>   target/arm/kvm64.c   |  5 ++++
>   target/arm/kvm_arm.h | 19 ++++++++++++
>   6 files changed, 107 insertions(+), 34 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

