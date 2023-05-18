Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30244708337
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 15:52:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzdX6-0005j4-Ax; Thu, 18 May 2023 09:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzdX3-0005ig-OE
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:19:01 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzdWu-000463-0d
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:19:01 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ae5dc9eac4so10130365ad.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 06:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684415930; x=1687007930;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4mWTROfbP8SPGG24LIxHfqlxrWU7Yk9pbfns+3xufH8=;
 b=Ol/2N2HlbAON+YkrcuYU6Y/Wql18AS0I6jNpR8GqpeCzK388NhQk6B4Y+uBskDKMg6
 bIMqh44MF1as9dlMimJTH9jy8a5wTCKLBZbga1f25Ir9NrwcM4ZePFnNwuQzNxqKv/G4
 244m4HpWoIhBa15PsVcRpeqsR0X0ZA3/pD8/1IRrPXjT01EWHS5t33M/AYbCgNF7/KJu
 OkdZ+oN00TGNs6hn6nQWlUMAPCprX8izykjmZ9gIWq9UGUJVtkTqBh9YslT5He/Rw7/O
 uZk+OVUBHnBmnwOB+Q2db04V61NPeiW8GnsSMAIr6CImKIXTfpZ+BZWjTx1B6eoD1Nvw
 cWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684415930; x=1687007930;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4mWTROfbP8SPGG24LIxHfqlxrWU7Yk9pbfns+3xufH8=;
 b=jK/D9+KvBjPVKMU4R7vkE+8pWcrSWWll1z8vyh+FwT7OYGKDphY1obVjBc2RiF1Lx8
 ivXYr39CWsCk02k5J+3PYnia2PszPc529dGZ4N4Ff76JO6R8atRavgKR5gmhm/BuKVNJ
 QRysMqsq1XkhCu9YI6SDkdXh2z6N8Ybqvs/+SKuFZRET/OkSpxrqAus73wce8I8cNfie
 NTIi5rh9Wl38e5hv5Yyqp4vkRvJUyqUH0BW4eUkVvnFveXymuD+cY/5lUJqOXI88HctK
 GqQBgHj5UCjzedXb+4Alt7MuXyDmP7CaQBB+DWJ9WzOwBuX/2ymiS9P/aktUkL0fcIIG
 ytVA==
X-Gm-Message-State: AC+VfDzCwTtVL38rgUlgxTZoVh8KWPkJLraYGxfNh4z7Rg/l+nJsR/Gd
 6Ig3GEZ6j1HHtBIr1aMJr6WxTA==
X-Google-Smtp-Source: ACHHUZ4/lyyRLLDFKrnW+5uSItM7PrUZnSY1y4/KdgjJmfhR0ngXqn1vAhPerirdeOk0/rjmE4wARQ==
X-Received: by 2002:a17:902:7287:b0:1ae:4a0b:5957 with SMTP id
 d7-20020a170902728700b001ae4a0b5957mr2136216pll.54.1684415930246; 
 Thu, 18 May 2023 06:18:50 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:5dd2:c230:399b:cdc1?
 ([2602:ae:1598:4c01:5dd2:c230:399b:cdc1])
 by smtp.gmail.com with ESMTPSA id
 e12-20020a170902b78c00b001993a1fce7bsm1386425pls.196.2023.05.18.06.18.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 May 2023 06:18:49 -0700 (PDT)
Message-ID: <c6c46518-6da7-cdbb-e9f4-23998752e0f6@linaro.org>
Date: Thu, 18 May 2023 06:18:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/4] monitor: use QEMU_LOCK_GUARD a bit more
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com
References: <20230518101804.992085-1-pbonzini@redhat.com>
 <20230518101804.992085-2-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230518101804.992085-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.544,
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

On 5/18/23 03:18, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   monitor/monitor.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

