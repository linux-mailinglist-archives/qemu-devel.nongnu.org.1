Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E34E7E7204
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 20:12:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1ARE-0001B5-JQ; Thu, 09 Nov 2023 14:11:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1ARC-00019j-OM
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:11:34 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1ARB-0001vC-7M
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:11:34 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-53e751aeb3cso1941078a12.2
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 11:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699557092; x=1700161892; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4K68xf8NAjNggL6wjAW9d2As5hNmQ2lG2+eujmVb0VQ=;
 b=PmzVGZdO73PxHqYXZCFtigNWXRiUXzjUcvPAnUXW70Xc0jamJLhFVgvplLApP2uNDW
 qAKN/H8SzlcyeL5lLq2TgQc5GMCoy7XIsKj3Ct7LrQHkicqeQRekQ6S66Him5AUUIaBz
 IWwi7IwJP7DyNkLnGLOP7xf/Ij2SfQuS2vYaYYSTItmD168DGF7yYMBXmAk0OVpP79Xk
 cQ+iT/2E2spRgmlSjFNlAcFta/9N/bGVaS5LkI9MbhP0H6dC59nhU8UqmfBC1H+jFjox
 KjEppmHXLNQZtC5sqE2kUIoYhZpd8pPhP7nIvlgvdsrtmvPKGQWa5T4oEGOCtXOmRER5
 RH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699557092; x=1700161892;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4K68xf8NAjNggL6wjAW9d2As5hNmQ2lG2+eujmVb0VQ=;
 b=sfObAh6+vDaGrTyNAiBXOsTlKAhpjG89wwqUbuAJ1aY+TPKqjHaJs8sYYk5VX7rc+g
 n8B8iKaDFLJO6VvVHvW0SaMEB90docMriTCqDKGRzL12izwzTpfxVtCVa1IKnT4rDrRK
 lMWD5WUgbtlJYWCypcDPnT865+/6mT2QmHI42RG+sat6D7BEb9535n/OuKl0G/hnQVaP
 n5IXocTFf40z9Cj+nw+7ZR8zk7Fmv9mEc3YFAAIdPoJkbRiXUaWl9Q0YBzJuEOXpB0Sh
 dmpslUEhzZABWX8WPtt2yvCLZ3fjvHpdJx+nB9aju8HLu1TJHeKfx75FBHDJZapiYt1b
 Cc0w==
X-Gm-Message-State: AOJu0Yyo5CTcRpAalqOu3K2t8EoJ44iwFmcC3qNAGC/v3EL11SJixWgH
 kEqaFvJw9n+Dr0UvZoIRKJWVCw==
X-Google-Smtp-Source: AGHT+IG26E6p4hp3Cz7qxfj3R2pUcr4PDuMtPjNBC04aR3Y9cuvWXUYmSj7t7nDDnT2ZQMdVbVIjJw==
X-Received: by 2002:a50:875a:0:b0:53e:e6eb:c838 with SMTP id
 26-20020a50875a000000b0053ee6ebc838mr5158486edv.8.1699557091803; 
 Thu, 09 Nov 2023 11:11:31 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a056402516400b0052febc781bfsm166756ede.36.2023.11.09.11.11.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 11:11:31 -0800 (PST)
Message-ID: <ebfa35fd-595b-4f30-9fd2-895d8bf5d52b@linaro.org>
Date: Thu, 9 Nov 2023 20:11:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] hw/i386/pc: Use qdev_prop_set_array()
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com, peter.maydell@linaro.org,
 pbonzini@redhat.com
References: <20231109174240.72376-1-kwolf@redhat.com>
 <20231109174240.72376-2-kwolf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231109174240.72376-2-kwolf@redhat.com>
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

On 9/11/23 18:42, Kevin Wolf wrote:
> Instead of manually setting "foo-len" and "foo[i]" properties, build a
> QList and use the new qdev_prop_set_array() helper to set the whole
> array property with a single call.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/i386/pc.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



