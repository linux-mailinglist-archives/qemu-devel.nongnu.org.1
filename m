Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C87D6744187
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 19:46:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFIBm-0000mD-99; Fri, 30 Jun 2023 13:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFIBj-0000c0-41
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 13:45:43 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFIBh-0000B6-J9
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 13:45:42 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbc6ab5ff5so11073535e9.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 10:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688147139; x=1690739139;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lPGfh6riNwi8WNNxkBTyS9Jw55+rs4bn4wHR2BQGVhM=;
 b=YiJcanjK8kP0xOcrKQNfwmEqHs9L0mnGTe9whLpzJ1WTHuLT69wzhhf6r6QMk5WHkK
 QNpeP+R/8bP09oeDcOVv1qaegFA5wI9uCflUn0TlXiKdN+/ePxsQlQe3JnGWauAX3cGT
 SbADY9Cob0KHdUO5VQx2wupHswB4KjqI+bnAH+TW476HXAhLLFEaLwF6P8SwujKKrtKU
 YTGSa/lDpZ2ih/nvD+AjXmcmIauXrG80akk1DMTMocyd/CRquMntuXuwyUF+BIbN2Idk
 GsA4rG1WPiVtwjyE3+9lW1BmDsm7gM4oG7NTcGcduLVXJ7TYwXz5vKSA2lr3Wfz4F6U5
 KRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688147139; x=1690739139;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lPGfh6riNwi8WNNxkBTyS9Jw55+rs4bn4wHR2BQGVhM=;
 b=Zr2spj5uAVIhfCNIWCRW+kYhu4eZNXURh/VOTX+SQnFqhZSvn0z6EoARj44d4L6Aei
 n/xlOkyApxMJc5wFwpNxYJZUyoRhqemO2yQMkJc+VtjZOw+mjYqGkTfskYEzLXpB8rdE
 HaW7PcG6BNMVJ4MP2C2HOvT4LGA/AnYXcoyPJ4iPpSNo8nR20PiQigQ9aldoQbxYNh6N
 d7eUflTTqx6FxdGMaKNiubhGwIerACjVOSxN0B9Df88laLi5SWKQXmaMV/lGcQU/abAr
 pjKXaD4L6J6WQolJhSxQbWfwe9YyDzuEQiVB2G0ThGyH3Yd1vldBAHDGAsEAZ8tiScQe
 zp4Q==
X-Gm-Message-State: AC+VfDyYh5Ads0Sw4+CCXXeTVo2OjaKLdgMwsNnnxfNW7wPRTXKpGhVz
 lXqJxx5Q3LpsSGuLkj8CBGvyOg==
X-Google-Smtp-Source: ACHHUZ5cHWikbp+ocHabzsVv010UrKVZ9E0q8DvunQXkoZQ2bvqeXYfeWxVPrnTz+PMfEkLW+Ja5/A==
X-Received: by 2002:a05:600c:b52:b0:3fb:afc0:56c5 with SMTP id
 k18-20020a05600c0b5200b003fbafc056c5mr2649785wmr.12.1688147139442; 
 Fri, 30 Jun 2023 10:45:39 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a7bc8ca000000b003fbad1b4904sm8321194wml.0.2023.06.30.10.45.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 10:45:39 -0700 (PDT)
Message-ID: <c8ea83fc-f62c-04a5-8b47-3685ed595187@linaro.org>
Date: Fri, 30 Jun 2023 19:45:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] tcg: Reduce tcg_assert_listed_vecop() scope
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20230629091107.74384-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230629091107.74384-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/29/23 11:11, Philippe Mathieu-Daudé wrote:
> tcg_assert_listed_vecop() is only used in tcg-op-vec.c.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> RFC: Maybe we plan to use it in tcg-op-gvec.c?

Whatever any future reference, it doesn't need to be in tcg/tcg.h.

Queued to tcg-next.


r~


