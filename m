Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D218AB178E2
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Aug 2025 00:10:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhbT5-0000m8-EQ; Thu, 31 Jul 2025 18:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhbFO-0004PA-Ae
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:55:35 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhbFM-0003ky-Oz
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:55:34 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-76b77a97a04so235370b3a.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753998931; x=1754603731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VkwhlzMWv2xIDFjhPhSqjrikQhELMdOISOjf/yTpLzQ=;
 b=M431i3AyEk9adXFmbAXAYIOaFeC3IZ2a3aqPwtGexvYebvUCBnh9Zg7mnMtuQ1gNXW
 pfXR9eqvBgk88ZayvkK/zFL4Oustt9Nww5HqFfQhbVUP0OyE4Ra7vsn4hPItdD6xgToO
 Urdyz/XNraNz+W4Y0wCxP3SnSwrkTqVNf/EyNEzXvQSrxU+MpZav4lZsYs78buwzq7jJ
 eHeimW5eX/FK0NpcL1kH9horDP3BHadfZuzwAKivbzze434upCuyo2pIMXFIIflL7oft
 ZLUSP3I42N6giu6RvHe/IghnEgBAzSekmrafivpYQGIA6lIh7GUVF+Uh98+nu/JjRHv8
 98NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753998931; x=1754603731;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VkwhlzMWv2xIDFjhPhSqjrikQhELMdOISOjf/yTpLzQ=;
 b=LLqpOvgEsy+mVeoukYiBKS1SmIX9f5sZzzrBGa1OcIk2x1Kdlz1wasSFf32Rt4GoDv
 fexyQeHcJHlEJSP+7vx4BiowH5KUwCA/ggp7zVG4OcFZTGEbdyjrhhunz3j26DFt6O8M
 GbJbXQGAhmvCtVt7FIFs5gKbzMNfruEFCufZugsssh4xaUqJ4yr0T+jLQcO/7GkI0Cd3
 OkBKmZao+RwQctP4e12LS7tokr1azwNcWs/OTk/bmQH9GBjjsP+cUBi7nncs3ubR8RT4
 v5nz/KKMAu+8PwhVMDUpNqjVWBh0VWWYHfGqGVNQcQGOUSdCp/R9RnGBM8AVdP0zrOes
 ayLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU0r6EQFPRe2ybYp6R/cC9n4R/HKOjwER7GRNqhbUFv+KMut8ZmVU0Mh6bVpkO/yhOINQrfjY37uf9@nongnu.org
X-Gm-Message-State: AOJu0YxfyLatqsgHHxCujcJQWsnheRhNsSVzquclekcqZCyFW4m4bM7y
 MITssK8BLWcha5NvKfjbX1sk33/AqEpgLWA4bE+ZqvVx+zXuzl/viGzsO8aXoXP4T24=
X-Gm-Gg: ASbGncsyLEmYH2YAo6gMfVPk+I+87sws88cTxEgc6pfnRjnOgHcVB5TLlFzR1R1W/Ox
 nhm1MNufQvpsCb9fROlKUvDAfFa9lP4hrzkRgr/rbP5cGnvzy/hLA6SWuyzHKHM1SG34jy88+w/
 gAiLnhC4/QD8uh63N9It43S034toF6/REovWCATl7BsrF6riCPZN7CCuB16aMSEWwt7SRQkL3uD
 aoBlL3Xx52PN3hyI8xqgoCwFU9En7B8JEc7QbULsHwSX7YGgoLZryBnmML4vCJeHXv2AU8EpD3Y
 +CqJk3hW1AHaK+KWOHmNUNttCEL+f1Q6a8RsDt0oL/Zliwx3our1WbPKPPYp2TDi3m0quSJhm+9
 2FeP+OWxl88YtOXeRHyCUyJ1lLo0hGHrAxfw=
X-Google-Smtp-Source: AGHT+IE8elHVyuSE1JoCLIccW7VssLdM4k0nnyL6qmQXKXtccvo2oQ+fQoLui7HdbD4wlxg57IW4kg==
X-Received: by 2002:a05:6a00:188d:b0:76b:ca98:fab4 with SMTP id
 d2e1a72fcca58-76bca98fd98mr4949892b3a.2.1753998931117; 
 Thu, 31 Jul 2025 14:55:31 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce8de34sm2501348b3a.30.2025.07.31.14.55.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:55:30 -0700 (PDT)
Message-ID: <d89b54e7-0217-4933-9ec6-18dedbf27b8f@linaro.org>
Date: Thu, 31 Jul 2025 14:55:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 74/82] linux-user/aarch64: Implement map_shadow_stack
 syscall
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-75-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-75-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/syscall.c | 59 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 59 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


