Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0497D24AA
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 18:55:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qubhw-0000i7-MC; Sun, 22 Oct 2023 12:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qubhs-0000hQ-HO
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 12:53:40 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qubhq-00030c-V1
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 12:53:40 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-27ddc1b1652so1970681a91.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 09:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697993617; x=1698598417; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x/1hi5CChFIx2el9gS9cT/lXx2jCfOOkVO1kn47N7NM=;
 b=JhT/WmRy0PX09vt0f6aInt0zD9OZBpFtB1E5/ZBLIRNk8vXe+jYY0rINgYk4Jqbd7z
 rqEblTUE4nv1nHO24b8/dm0FzivXTvdGN+g62qRnAJCy9+cr1mS38gRZ65Rthu8SOT9E
 F3pce3O/8nDbcoXEQKUu5ockyEccwTDNIV7c2hQybhIGnATiwBzYq6/FUqRGHVpaYqYp
 kVyG9HHj0LfkDB32YXWdm413E2/gP11UlZ2jpZUikSKQisWaA13/N4M50axLsZbOmYg6
 wZJ/eUg0kmtOymcTfWoPPenBoVcG65SCaOs31qLQMdF6/gFF9XlBxShBml+i7t6hssSF
 PMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697993617; x=1698598417;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x/1hi5CChFIx2el9gS9cT/lXx2jCfOOkVO1kn47N7NM=;
 b=P9xkBxrxy+99qTVnj0bcJDJ6XA0AjEK8dF608/tIZXpLmUSAGCduvdq3RlzksoblFo
 OaJJIdBBkvPmYNaiMGvixKdmZQKvcy6UGgo/G6jduy4Fz4ALlmkG46iW95WGD2vBIauh
 eaGv7KBGbrWnhU7EzvanHb1E14d1Ok4yF+3t34RKANXkngn6KzsrpWafOo34UHN531PS
 ePQQy1l0468NLSgUnITrdXY8DZd1WpBPyBy6R0AbQHE1weSnGpT+Rx3rxWsdUrdLoPE4
 3iGGvANeA/Yfm2vIg58oV+NMVh84wEs1m3entSd3GTN5STDokgZtp9XW7fJ4uB8IiZBK
 Fexw==
X-Gm-Message-State: AOJu0Yw1W7U0BimT7hqyPu+8TDQ9j5yW8bSqzG43eGmtEUAlqYoCvleQ
 sfhnfbg5tHzjlSd/30pdU2BQOA==
X-Google-Smtp-Source: AGHT+IGl04UgMTBdGd+f85Tcjo+AJJku9xkgXhsT3lqbXtsOh77eitKeTmETfrSEiWTuaewSLDbIDg==
X-Received: by 2002:a17:90a:d443:b0:27c:f309:f381 with SMTP id
 cz3-20020a17090ad44300b0027cf309f381mr6807045pjb.6.1697993617359; 
 Sun, 22 Oct 2023 09:53:37 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 d10-20020a17090a2a4a00b002790ded9c6dsm4934130pjg.31.2023.10.22.09.53.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Oct 2023 09:53:36 -0700 (PDT)
Message-ID: <c9ff4b6f-2ac8-43f2-9be7-7bf92ef69496@linaro.org>
Date: Sun, 22 Oct 2023 09:53:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] hw/char/stm32f2xx_usart: Extract common IRQ update
 code to update_irq()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>
References: <20231020170009.86870-1-philmd@linaro.org>
 <20231020170009.86870-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231020170009.86870-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/20/23 10:00, Philippe Mathieu-Daudé wrote:
> From: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
> 
> Signed-off-by: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
> [PMD: Split from bigger patch]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/char/stm32f2xx_usart.c | 28 ++++++++++++++++------------
>   1 file changed, 16 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

