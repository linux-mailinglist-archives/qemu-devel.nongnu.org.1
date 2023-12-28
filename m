Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4E581FB41
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 21:54:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIxNS-0004cR-El; Thu, 28 Dec 2023 15:53:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIxNQ-0004bf-M2
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 15:53:12 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIxNP-0006IE-5W
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 15:53:12 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d422c9f894so39257365ad.3
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 12:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703796789; x=1704401589; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6uGblvUMaY/6+7XT5kpObAKyVNrlSKEtqK7+rtIUwlI=;
 b=skhdF0Ofqg+YK62v7JQMwKXfe/biS/eASse03yIOhQ84tVBre7d7n/PuIJ9A4WtM/n
 G/YJXcomqhBN4vYLqzs+FNbpNT9z/symqclynWWSd2E5uIdP1KLWrDosfuWvBV/cdxMC
 G3PpVq1uN4MN3ZHx8eZGd94kehnf89vk6vcd39TfNHExFfZa5KjA2koKBvbluZl7D2S1
 +PcRj9xI/TWta8PUvzyZEk5CL178sDBtSiTkgiKmda9GD4kkNdBVF/bXqE3E+6c0hHnQ
 NOlWO9F8n3RWNB+CubVyv3kQxAkiCgWV84tjUgct5yUQGrP35/wKzyHqqqN7lpXylZRL
 vpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703796789; x=1704401589;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6uGblvUMaY/6+7XT5kpObAKyVNrlSKEtqK7+rtIUwlI=;
 b=ABX7Ux2sw1/UuPBOeH4wK1EesTcKO/xsqyOlvdwsPDcm6JfYk6hU/+YTsldcnpelYP
 ReG8dxjqnVBDzAHQOR6/GHQHN0CuArsTfAMu5uMZP9Lwi3UrK7inReWFnn4WZCBAROdq
 8ZwT21cQ8Oz2zwOfhAfQejXLZ+t7JEJ79fLfz5ygN0CnYUiqjemzBPolr7VOJzpHycwc
 9KenF/kvGyNhgFuYcpmS6Y4k2+scVywF4fwyk3jrsCezhfQl6ojz3g56FGL8QMWTJk4g
 Vq+uXk7/r4yhTzcTAXBNtGgvWB85q17D38/Wbab6qr8f69KouB7q/qKCQfBa09Me3tXz
 +muw==
X-Gm-Message-State: AOJu0YyqAGBp4M8kHwSTKJYjYeG+WwdnTOAyCD/4B7sb6tkrhKONE3yo
 064q7qmzi2AviqMl7l2Km5WOjn5NmHyOfg==
X-Google-Smtp-Source: AGHT+IEgMTGV0WzDXkklzqaVZh22jG6KHOmcG89qpVHkyve9JnZ6zjC3Vh7tJwOAJaMhONMmvfXsfA==
X-Received: by 2002:a17:902:c412:b0:1d4:202f:945d with SMTP id
 k18-20020a170902c41200b001d4202f945dmr14651261plk.98.1703796788890; 
 Thu, 28 Dec 2023 12:53:08 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:324d:cbc2:5f8b:3a9d?
 ([2001:8003:c020:6900:324d:cbc2:5f8b:3a9d])
 by smtp.gmail.com with ESMTPSA id
 e15-20020a170902ed8f00b001cfed5524easm14323816plj.288.2023.12.28.12.53.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Dec 2023 12:53:08 -0800 (PST)
Message-ID: <4d3e4454-5b5a-4522-8e2c-939f3f468ba8@linaro.org>
Date: Fri, 29 Dec 2023 07:53:03 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/22] target/i386: optimize computation of JL and JLE
 from flags
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231222181603.174137-1-pbonzini@redhat.com>
 <20231222181603.174137-2-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231222181603.174137-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 12/23/23 05:15, Paolo Bonzini wrote:
> Take advantage of the fact that there can be no 1 bits between SF and OF.
> If they were adjacent, you could sum SF and get a carry only if SF was
> already set.  Then the value of OF in the sum is the XOR of OF itself,
> the carry (which is SF) and 0 (the value of the OF bit in the addend):
> this is OF^SF exactly.
> 
> Because OF and SF are not adjacent, just place more 1 bits to the
> left so that the carry propagates, which means summing CC_O - CC_S.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

