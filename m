Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5308A745E1F
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 16:05:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGKAW-0006w5-Ns; Mon, 03 Jul 2023 10:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGKAS-0006n8-T7
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 10:04:40 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGKAR-0003Nx-BK
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 10:04:40 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3128fcd58f3so5195998f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 07:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688393077; x=1690985077;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ANjXEKEsnP792nmvQsOQDq6jnexee5rcgxquDnBk8HY=;
 b=CGjM9FnwP7ERDMBaba6zIEKqpjeb6/i8hNK19nhdP8hbPNRurwzMXidJhShh2lmkDw
 ZMCss6/VMwpQ7JduAVxOc0PWTwV4KcoYqu+H5lwtbfcE3LgX9j3TIHx1sPosBs96qxut
 zZ9T3U5U0BfC01yekK8M210aTrY01qzwjWkLM7ggJIM54Fkcv828HN1j2RQyGXBdUmT3
 3L/tc/BH3BEKafeg/g0U/+m8vR+U1arnRYs8t7WpD2RfoX3n/cGuy460kl2Nz0ajuJk7
 tOhVFMpHzHkgaTs36uTI4NJDpGN73NymOWdfnacb9d8Sky7r4bF8rm+/MNGiBolUUyQl
 wSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688393077; x=1690985077;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ANjXEKEsnP792nmvQsOQDq6jnexee5rcgxquDnBk8HY=;
 b=F+nTvqjPIpnoN98WLdZQD8AXNFVE3ID8nGwxWn8ZDRb8xtqhi6LyYMu7Cu1bNw9lVc
 /jbX8M+avxuyYc13IdOGRmQUiR/FgnHNIsJQb/wSXxtRNJRLSviH8awW5+8kjQ7XkZVR
 Opf+g5bSnJSba0s/W2wDWAO20bBfABwup/Is2MtTL0pGn4rCpqpsMCXjuuFRwlOWs8lK
 s4O/C/Ds2dsibqnAC5w0dB6kfsvHc/vbkHlVvsO+jEZSMcT6nEj2/jTolbiCwXCRu8cb
 N4kdTO8GrRW3s+w6KpGOL9xLNsWi6thjML8cHhO4CQ3+mlWgaiPgOk0KROCVaVe3vd+c
 JR3g==
X-Gm-Message-State: ABy/qLYr3/s02vsHBBKfYtFqNec8IQF74d2PRj122Siqt79A0jOAcbrr
 bVozABmFCCtn1XWFpT6g2CwOFA==
X-Google-Smtp-Source: APBJJlHP5zqWfk/JA2MNmgBboSOzZSW8k0Beh5MhSw06j5NIM6+oNlYlqeNona1oHp63PNg9T/N33w==
X-Received: by 2002:adf:f3c3:0:b0:314:1261:4fb2 with SMTP id
 g3-20020adff3c3000000b0031412614fb2mr9051952wrp.31.1688393077251; 
 Mon, 03 Jul 2023 07:04:37 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.178.91])
 by smtp.gmail.com with ESMTPSA id
 14-20020a05600c020e00b003fba92fad35sm14675600wmi.26.2023.07.03.07.04.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 07:04:36 -0700 (PDT)
Message-ID: <f955951f-b50c-7461-4ce3-39429d861be6@linaro.org>
Date: Mon, 3 Jul 2023 16:04:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 02/10] block: Remove unnecessary variable in
 bdrv_block_device_info
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Jo=c3=a3o_Silva?= <jsilva@suse.de>, Lin Ma <lma@suse.com>,
 Claudio Fontana <cfontana@suse.de>, Dario Faggioli <dfaggioli@suse.com>,
 Eric Blake <eblake@redhat.com>
References: <20230609201910.12100-1-farosas@suse.de>
 <20230609201910.12100-3-farosas@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230609201910.12100-3-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 9/6/23 22:19, Fabiano Rosas wrote:
> The commit 5d8813593f ("block/qapi: Let bdrv_query_image_info()
> recurse") removed the loop where we set the 'bs0' variable, so now it
> is just the same as 'bs'.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   block/qapi.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


