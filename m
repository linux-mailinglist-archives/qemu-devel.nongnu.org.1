Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B14791313
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 10:12:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd4gu-0003rK-On; Mon, 04 Sep 2023 04:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd4gt-0003r2-2F
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 04:12:11 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd4gq-0007kE-JK
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 04:12:10 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-52a49a42353so1659767a12.2
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 01:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693815127; x=1694419927; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gRbglbqLvgbmDeJ/Fz7loOq4VsEl0qztjrwoGwraqu0=;
 b=KaV/kfu+Oru08kcGMApJ4J9FlKMK8yMEfNsc8yrl/P2HJj2aaB6CtWYZ31M1py/Dp8
 nYxtRDCzT2+KLi+I+MnS0f0+DJIvuycmB/VBdm+1qfyg/lkDRydFfAgd4RbJKc37yB+c
 p7uCrPVBSmmGN9iATa7RE0JNCwxbx6+TLNzrQfQTfKwg4TXx26CdqOwGThd+GfmMp0SX
 68kgOBJzYj0WrIXGneQoD//h19O1g3xk0U/YrJNsaE5X6NnYvtAzMg6wNPeVeUacEgE6
 TnUrgnOB3iOyzImUb4DeDO3E9z/26tZx2N5KcINqAuAotjwyJtWoBcbMvhKYui46z9VK
 qtwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693815127; x=1694419927;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gRbglbqLvgbmDeJ/Fz7loOq4VsEl0qztjrwoGwraqu0=;
 b=eVnKaVWkq0QFb5Z/vmwQJGRXdhg0LyIo8SrjbQTupsNnyo4rqFHYRgql3yZYcRicyG
 uJBxupDossekCI8d75Sx+GmWizZ9/bIGvJFbhu4/8dM2u/UPFlWpp51dJGkiomnNftA0
 sQRVCpXwfNxIF/OcJR7IjvAYQAd6ssgPD+608FJ6d8+quaDnejJmkkrMlT3jFTt8qltN
 ALSg91Hu1TZeB5B1Dk4zAj5nhR/ZDro9FOqpbExpk8iFU6Tg/iPBAS43ujVwO83assq+
 deYc8gcZFA1SmZCG70Wk9e+csytC9f2fPnB/7OzfcrhFnC6Nb1DSCR5Bf9njUJKWZoIc
 w+1g==
X-Gm-Message-State: AOJu0YxVw7Dd3AEbW5DfS66026i2FN7llGtKb5A4cUfBUuOS74fVrDam
 SDcFFP3aF5ym+x1+XnX80f0uhw==
X-Google-Smtp-Source: AGHT+IFUjr5PucGbIv2FBooczgq2QFogbs7Dyg0gaIQM8GqgVOSsi2saZu2WxsGqvKA2wt32woDrZQ==
X-Received: by 2002:aa7:d50e:0:b0:52a:10b3:3cc2 with SMTP id
 y14-20020aa7d50e000000b0052a10b33cc2mr7706641edq.30.1693815126878; 
 Mon, 04 Sep 2023 01:12:06 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 c20-20020aa7c994000000b0052a3c7c9e8bsm5486491edt.56.2023.09.04.01.12.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 01:12:06 -0700 (PDT)
Message-ID: <231e23c0-e5a5-be2b-ccb6-77e24c2c1f55@linaro.org>
Date: Mon, 4 Sep 2023 10:12:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 01/13] memory: Let ReservedRegion use Range
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.williamson@redhat.com,
 clg@redhat.com, jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com
References: <20230904080451.424731-1-eric.auger@redhat.com>
 <20230904080451.424731-2-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230904080451.424731-2-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/9/23 10:03, Eric Auger wrote:
> A reserved region is a range tagged with a type. Let's directly use
> the Range type in the prospect to reuse some of the library helpers
> shipped with the Range type.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   include/exec/memory.h            | 4 ++--
>   hw/core/qdev-properties-system.c | 9 ++++++---
>   hw/virtio/virtio-iommu.c         | 6 +++---
>   3 files changed, 11 insertions(+), 8 deletions(-)

TIL "qemu/range.h" :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


