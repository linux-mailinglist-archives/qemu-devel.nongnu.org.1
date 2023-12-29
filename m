Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB65E81FEC7
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 10:51:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJ9WB-0006fE-5b; Fri, 29 Dec 2023 04:51:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rJ9W9-0006f1-7q
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 04:51:01 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rJ9W7-0002VH-29
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 04:51:00 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-555aa7fddeaso1006489a12.2
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 01:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703843457; x=1704448257; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yTWBBuIS4Juupi+sDFwMniiepShxY6mDyVmwGRvY7Ak=;
 b=pZg4mQddazHBd3mHcmbsdNkcIWiBQfGviyLBciw4AOPivnOjKepUuk0iUp7IYJRCLe
 Lk7a3VWblbqkdh6vdUAVP2b2RUuu1pGmi5pCesmqCwYP/7j9Fg7NJUV/5BwS46vykFya
 BTSPY2azW+wz6NvZ89RgE3Tmi+D4ImgyXdcRdFvjk2DF88KQQgrOY1Tt4puxzU7lC21V
 8Qvb66f4+9xg7pMviw4S3gMGqlgNfuMTjrF1ky/8yZ+LfS9xr1TdmveUP4+E0HFXBCwr
 kBGs2NOuvj7FQ07y53DBKG8h3l2PL5vvq9BIS1wj0gj8AnGHYeBr55YEk1xI+xpSN77T
 4gZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703843457; x=1704448257;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yTWBBuIS4Juupi+sDFwMniiepShxY6mDyVmwGRvY7Ak=;
 b=LUaUzxQqNOUB8UUkTcso3j/F3ea2yCv9hLOGlrm4w/R68zZJZnyEn41s6AkiVb3NF/
 W2EWLbhHNp99ja1mSlGG4sEtWzYraVhp1OvSArMbdA8SbcwR+oBIlUbrfk2AJr1vlo2u
 knI11WhLw+a8UY3Xvr3eXQoWZNxc6OQjT+1QSVWpoaHVjg/+FrjlNFvrkwOaBONk5F8o
 kOoE04QP/8Ck3XCgoBbCVm0HWomBHiAVN0ZjiXrrSIpli37sbsU8aAJBk74SmuGtbxap
 vXAb60A/+ShNCwQdfM5erqmt8J4otmxweh37yozogLD7SkCei6ob5KqZuPqOWmbsi+ql
 sN6g==
X-Gm-Message-State: AOJu0Yy2RNPsuiMRV7cuJhUe55fP8XbvWDUys296rCusD3NXc1GP0QHG
 JU0Swn2m7ieIrfHiGd1adWsYnMITfnQ6hh6kvydtU6bxJGA=
X-Google-Smtp-Source: AGHT+IE12JelyO3WFwfrvzTeg2ara9tVaVzN2+IKr9exzo7copYYgAORkZ1KpocPcsRUcjskmWvEZw==
X-Received: by 2002:a17:906:25a:b0:a1c:85bc:e9ca with SMTP id
 26-20020a170906025a00b00a1c85bce9camr4635268ejl.13.1703843457072; 
 Fri, 29 Dec 2023 01:50:57 -0800 (PST)
Received: from [192.168.69.100] ([176.187.202.55])
 by smtp.gmail.com with ESMTPSA id
 zv13-20020a170907718d00b00a26aeb9e37csm7355835ejb.6.2023.12.29.01.50.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Dec 2023 01:50:56 -0800 (PST)
Message-ID: <287bd879-bedf-4d27-ba4d-f78864169e66@linaro.org>
Date: Fri, 29 Dec 2023 10:50:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/21] meson: move program checks together
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231221171958.59350-1-pbonzini@redhat.com>
 <20231221171958.59350-15-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231221171958.59350-15-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 21/12/23 18:19, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   meson.build | 90 ++++++++++++++++++++++++++---------------------------
>   1 file changed, 45 insertions(+), 45 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

