Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FCA82337B
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 18:39:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL59M-0005ZE-PD; Wed, 03 Jan 2024 12:35:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rL59J-0005Tu-Hs
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:35:26 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rL59E-0003DE-B1
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:35:25 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-336746a545fso445128f8f.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 09:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704303319; x=1704908119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KD8fHoYY9U39+j5t+ooqKoaHFyC3927TgphRWKKkdTI=;
 b=inFojhz3ZNH41mWAHV4CbUO3LZ9c5Z+UjWLfdi/39ty0uXFTk1A/t70oYYrXq35C3j
 0QlhME7KVvvXwefjo4OFZue6Sgjom4dSevoY5C19ijXDfbgXH1UXp79Quf8GhpUpxIpZ
 NRDu5cqIKHCc9PSXUU6WuT6O1vGt/H1xBX8nlPNlZHK7fNW7TOv+uL2oPJ8U3nIayZKA
 pB1TzD0rIofXpbK+pN2oh6OPG+U1jj/OBxsaPWd9xHbH7OXhNVxoBKJah8DST7G5mNui
 jKrQZZOUymYZyaVvoNkXTI5vxi2bmtV3HU1xO1SHirc7jGTQmJFp0zKz8Vtg465nMoQv
 +inA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704303319; x=1704908119;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KD8fHoYY9U39+j5t+ooqKoaHFyC3927TgphRWKKkdTI=;
 b=XpvqVCIgQGbnidZ5nS5pF1s+cQYJtCL4M0pTKFOWHpQkLPceDAVByxlU9jW0CrB/cz
 iG7HUqb+dyRnmQvAOlGTv3G/YoVo9un0gI0vpm2stL/m0WBFFHAtd/1darsxqCRyz6ix
 izICOIYd874dikMIIsGREnohBQkWIaQprbgXd/bJUtIn0H6qwEED2gcaEh3Bd+1dlkH1
 zkynv4UaQsFUzeZ6kJCc5IiY5lygkOyL7mPnU+a8ZPtZN+Sp7s2VfrznzsJu03a5/hNL
 2XdD00DBgl0MbtZfj9ojmhxbBnweJZhoyg0NVcPFIJvhf7Ul67B4XcRV4XTdaubhEiDA
 /LYQ==
X-Gm-Message-State: AOJu0YzDdt7Vm/ah1DzvFxZoKjJopZuQ4KhA/K6d9tGqgVccIe1/0rz1
 8byEIh8LBGQlTYNn6oHIyKXM7snDuZRfocyPYQ8fS/O2BQU=
X-Google-Smtp-Source: AGHT+IGHqjfl2YnBGzIh53H1YFXaGD+aPYNJLKinq1kCK73QY5tSJnaKRC7CmLB9Va56r3QWYcWz+A==
X-Received: by 2002:adf:ffc3:0:b0:336:8af0:1fd1 with SMTP id
 x3-20020adfffc3000000b003368af01fd1mr660063wrs.11.1704303318825; 
 Wed, 03 Jan 2024 09:35:18 -0800 (PST)
Received: from [192.168.69.100] (tre93-h02-176-184-7-144.dsl.sta.abo.bbox.fr.
 [176.184.7.144]) by smtp.gmail.com with ESMTPSA id
 e14-20020a5d6d0e000000b00336cbbf2e0fsm21642247wrq.27.2024.01.03.09.35.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 09:35:18 -0800 (PST)
Message-ID: <b6d96fea-ab43-43cd-bd7c-1da59ab7f2d1@linaro.org>
Date: Wed, 3 Jan 2024 18:35:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: use "buses" rather than "busses"
Content-Language: en-US
To: Samuel Tardieu <sam@rfc1149.net>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-trivial@nongnu.org,
 Vikram Garhwal <fnu.vikram@xilinx.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240103172817.2197737-1-sam@rfc1149.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240103172817.2197737-1-sam@rfc1149.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 3/1/24 18:28, Samuel Tardieu wrote:
> If "busses" might be encountered as a plural of "bus" (5 instances),
> the correct spelling is "buses" (26 instances). Fixing those 5
> instances makes the doc more consistent.
> 
> Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
> ---
>   docs/system/arm/palm.rst    | 2 +-
>   docs/system/arm/xscale.rst  | 2 +-
>   docs/system/devices/can.rst | 6 +++---
>   3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


