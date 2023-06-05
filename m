Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8264F72268A
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 14:55:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q69kA-0007d9-DY; Mon, 05 Jun 2023 08:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69k8-0007cx-JZ
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:55:28 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69k6-00071h-Dw
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:55:28 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-30aef0499b6so3767282f8f.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 05:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685969723; x=1688561723;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GW5O9Y9E1J4FKdNuhz3utykDhMyC+G+33EjuIcdGx/0=;
 b=VehKzZ/BCTLJVmYX0UdSsjVdCTWXfAVWzWyMM2RIqvMPUVG+lwMCbay2uOVCOTC62v
 svpwY+wYEzBq9koYFMv8gTM3aF7KoNmCqw3hgOJ5FM36MFaLGh15b+yI4Tdh+kcqV0q9
 2F3srTd30V1HWJAJpO+JtFEg3lxiYU4xTeD0Lt+Fws1uCJxGMY8qo8LtZhNJTSI4cyxr
 kmCU59xdanzG1GlL0CoZxW7l4xJQ76LXxH8X00MY9Vt8KAPsPIpqVVJOD06DzT6gw/1/
 9E4iyl8MK5XUHkSjWn9onomWvsKiuQwRy7nEV578BVDLvtExBQ4xnh834WMg1tMP3kR7
 tf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685969723; x=1688561723;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GW5O9Y9E1J4FKdNuhz3utykDhMyC+G+33EjuIcdGx/0=;
 b=MUpak/P6wqaoEzWUXwSi499/ymeKkrh4HdIS1l/l7wlLmI6eyZ9wqYBdOXyMZ6alXl
 agdOee8/CaFI7OteB67K7UEB1pSVU90O3CVs80J1zs3lgQJ+UaoWFM5HvIfYC6hZo3yr
 ZqtuNDZv98un+dpYPFwO9f/5bWeIhkwvf1fstvMc2SPk4ctDkw2o6Z3jRTI96pWY31Ww
 Yo4NNxU6U3eoASse+vxzVpQxTswWLlz1eKE/ycMjRNi24ggrrZwBB3pq4yBZLK7dBoxG
 IVK2htuc7jYLpiIXqrVNpOqgaE/rJ90uZkQIR9Ek0giiAJEPjLKGwb9CwKApiM5gXzkY
 KP3A==
X-Gm-Message-State: AC+VfDzRRI6SJEaOLj8/8tKUIULwhLO+3yz2RA/hiN36i9fiT73JswTr
 lCYgw4UQ6244ax8DBnqkvBKD+aEZ4IZW1B9hyx4=
X-Google-Smtp-Source: ACHHUZ6Tmb12Qs3CGAzrehlbbhRJP+J6nlr8OoZb9MqLornrCh56sixIapkIMtNS32Pnf72d4u58Xg==
X-Received: by 2002:adf:e788:0:b0:30a:aeb0:910d with SMTP id
 n8-20020adfe788000000b0030aaeb0910dmr4520406wrm.44.1685969723370; 
 Mon, 05 Jun 2023 05:55:23 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 p6-20020a056000018600b0030aefd11892sm9696220wrx.41.2023.06.05.05.55.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 05:55:23 -0700 (PDT)
Message-ID: <ceb3876e-9cb4-d8af-a1d5-411179e414c7@linaro.org>
Date: Mon, 5 Jun 2023 14:55:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 09/15] linux-user: Use abi_llong not long long in
 syscall_defs.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20230603222355.1379711-1-richard.henderson@linaro.org>
 <20230603222355.1379711-10-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230603222355.1379711-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 4/6/23 00:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/syscall_defs.h | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


