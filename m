Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9047C47EF
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 04:45:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqPD6-0001L1-LS; Tue, 10 Oct 2023 22:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqPD4-0001KO-JI
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 22:44:30 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqPD3-0004tf-06
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 22:44:30 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53d9b94731aso2097346a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 19:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696992267; x=1697597067; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vPcG6O3r6R6vmrpuD+agRdb/Qy6XShXq47ZdTDFc2eA=;
 b=IwSHR9tXKJmikz74vkL5zHZxuPqXT7x2Ucl7uq+N9huCJo7nwB/JjZig3r53abho8q
 XDh9f/jzyaGHN0uMoXABeoi2c4bZgF0ML9RADGGqJA7eeZ0jt/167kaFZg+WqB6NI8v6
 7w4bPZFEA+TkA+YaIwjNomR8hJhsxzr17dgEGgi2zjzAxeB1uaizrOdT3wnXWxDtjdGf
 ADA65xklDK+GSpENAJHMc+3+ZuXA7mv6/fDShbq4Z9J9Q0vWjD4rWIH5ZqN8XR1n4ub5
 Zl/2yhwaIPFjn8Xb+tb5+Kd2utWjsn3x8wBk3z1nu69HQEMyIoUaD7IiFA6Yy1S00quO
 7Xtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696992267; x=1697597067;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vPcG6O3r6R6vmrpuD+agRdb/Qy6XShXq47ZdTDFc2eA=;
 b=l4NQ5uMCVMqNuLhdxrx8MK+i572/ebmTS43uPJbd5UgK9ywVyoqvgLQOkG7bAcU6Gr
 IZ1I72aMJ5xU5mN/SnXh5iJZsjVIOA3ShP5m6eIthRn84Iiv120ROCzTBeFNTU56JjOc
 rJZjGtnnhRcczQIuUOJlpecbrbWvcBegH9bONARPwOBZHnkg8I12GU00Ic6ip6ksBs8p
 NDN/jQBl91nkuXqR8WkLz/VyEXALUaGgMIu06ZZ0OWJVCyrV4BKZi17KpdvScqb8wHay
 75OnRhqU3utNwrdsrvSC+CQjS2iTSuaLRWcz3IlNPPdxTVuODsRoTw4D0mHL6Ru2F4tS
 pFcw==
X-Gm-Message-State: AOJu0YyiHmc2M9mZvwinah0dyBKad2eslR/idjKYgQHw4RbqKNVi8X2L
 acKFWn4Y8fhs/b21TxTQ6aifFQ==
X-Google-Smtp-Source: AGHT+IGrvLpbuah4ZRoZ7fyUqP8vmpOVTR49mUeF4b4dk54RFBRBiJRaaJfylkIQSsRLFAs05vI+XA==
X-Received: by 2002:aa7:cf90:0:b0:530:c536:443 with SMTP id
 z16-20020aa7cf90000000b00530c5360443mr18956850edx.1.1696992267090; 
 Tue, 10 Oct 2023 19:44:27 -0700 (PDT)
Received: from [192.168.69.115] (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 n24-20020aa7d058000000b0053331f9094dsm8332754edo.52.2023.10.10.19.44.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 19:44:26 -0700 (PDT)
Message-ID: <f5a296f8-cfc6-b98b-4e5e-ca4c448495d6@linaro.org>
Date: Wed, 11 Oct 2023 04:44:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/3] arm/kvm: convert to kvm_set_one_reg
To: Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20231010142453.224369-1-cohuck@redhat.com>
 <20231010142453.224369-2-cohuck@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231010142453.224369-2-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 10/10/23 16:24, Cornelia Huck wrote:
> We can neaten the code by switching to the kvm_set_one_reg function.
> 
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   target/arm/kvm.c   | 13 +++------
>   target/arm/kvm64.c | 66 +++++++++++++---------------------------------
>   2 files changed, 21 insertions(+), 58 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


