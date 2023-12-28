Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7328D81FB7B
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 23:14:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIydp-0004gB-1w; Thu, 28 Dec 2023 17:14:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIydm-0004fF-V4
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:14:11 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIydk-00065P-DW
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:14:09 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5cdfed46372so3495569a12.3
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 14:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703801647; x=1704406447; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dNmIZnB07revID0U1bGlxrg2KUuooPbZ3j5RK8FNHzk=;
 b=AoBia7Y/3GByuO8MebJA+0boA9o1io/bqmO+FlqyjpkubAdMxVEQrhXq6CF3qvJVfs
 lJy3gtJHBAP2DmbArskv+BrZWo0VKdbJKEm17Sq1CblAQfNWKljGInhxWziZOFdTQUMh
 S11Zp/8KH5jKQK5edP10z4ktWuT8QLffBJbkAFCbX4lqDsSwO3j9tShOIIQoRekry6Gr
 7zX/IfxhweugO+LmhrLK0Lr1YGquRMSQ8fHxkfiPXsdwjgamkUOt5rQ/J1rMMq4SqDLR
 wbrMVui02JhNGu5ouetX+O3BxwxCAMXDXFCxKMG5AGtCjD0dgrkK9stOo3tkbW5eXKQU
 M+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703801647; x=1704406447;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dNmIZnB07revID0U1bGlxrg2KUuooPbZ3j5RK8FNHzk=;
 b=UKBchdUR/geahaIljQMa/rjOnGffEDvB/Fx75y9mS7Bo6jHXDZWMEHiw/KVLJ8i5QP
 RQEM7g//VwfQr7SRwOK7cQi31KY3xGnVy7nlmT4tdwdDOQkBtWVrssMV1lpVsfCt+Sgk
 NQ9LTgvrH5Vg83VIcGtV2j6fEeN9Wufc6zahz2Y6hxWh6Qw3wEqYR/GCFvQYW5IZluFL
 vQZPUwSsiGDeig6arKiE/7EEg/FVDAQM5GoDRlb7lTv+g1KWgkPiqmzW0VKd1zOgeLrq
 /X6mvn/CgE/g5HepO2h0kUw0CW3sc+hXkRG1NxJyrv6s9yEu4X4KM4/imEFqoG99oAOO
 suFA==
X-Gm-Message-State: AOJu0Yw2XAsnOI3nbvJF7sxqb0gNVVq28nD0my3cjRV9Fwvcww+EkBMw
 5EVxc37OD0r1fRpbijY18BKBEZ6/X/MpzIkQWKWlZg3H4SAryqNs
X-Google-Smtp-Source: AGHT+IHSkpEwNWm6GmPfXUl6bdqZHrZOxruEI5kQLFQK3YMZQZ3Ctva0/tP2NTZeBNbE58d/Tyo/dg==
X-Received: by 2002:a05:6a20:1046:b0:196:2c19:cb37 with SMTP id
 gt6-20020a056a20104600b001962c19cb37mr2668593pzc.109.1703801647062; 
 Thu, 28 Dec 2023 14:14:07 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:324d:cbc2:5f8b:3a9d?
 ([2001:8003:c020:6900:324d:cbc2:5f8b:3a9d])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a63f406000000b005c66e25497dsm13780300pgi.83.2023.12.28.14.14.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Dec 2023 14:14:06 -0800 (PST)
Message-ID: <d2056c43-1bc9-4154-a293-9410151ee969@linaro.org>
Date: Fri, 29 Dec 2023 09:14:03 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/22] target/i386: do not use s->tmp4 for push
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231222181603.174137-1-pbonzini@redhat.com>
 <20231222181603.174137-16-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231222181603.174137-16-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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
> Just create a temporary for the occasion.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

