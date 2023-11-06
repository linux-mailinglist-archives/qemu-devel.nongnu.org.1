Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C127E2074
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:53:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzy8t-0003DE-NU; Mon, 06 Nov 2023 06:51:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzy8p-00035m-Qv
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:51:40 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzy8n-0006Fx-4D
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:51:39 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2c50305c5c4so62915701fa.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699271491; x=1699876291; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UZA4mCcFAXGCZgdP33pM5RMr+uzepXL80cFdH1l92Jo=;
 b=AxvWFO/ZLv7g9UW77M4QJj2w64Y2vytn+54f1xsu6F0gJZDnMl1GtWuXHZrmk8y8bW
 o+Up5doh3/h75U1MgxCHBzy+L+cElCh5zX+LG0LEdvrK+7aoQe5yXcpqHHQrV9n2jx7t
 N8D57Ay6aJrIcfyojMyBFuRSgA1amTtgGWPsxlJj/OOfRL1M/GSRccNnLw+t8qQsdOCF
 ys2uCUT9DLahjXHFzwZIFqcvCUT/GDtXJM5ktMJ5R7bcUip2x7vQwyXY/P6bh+STmvwW
 xZJZ8+Jud2vR11Edobh0maPTr5NCh7D5Ey21zjpFCnurhD6Le8okQT6P5Ghz4YrOL+ss
 nf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699271491; x=1699876291;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UZA4mCcFAXGCZgdP33pM5RMr+uzepXL80cFdH1l92Jo=;
 b=ThL8R+tBnzsyuIZ/F0+wWvXYyTnEPIcPtBQWhsJezgB13lP1TLlp5aOGXWSuZHA+7c
 FZie9clFyzGYQEryRXiv3sFisAfZQFh2GhJliiPF9rhWdrmU3NqZ+XRxH1JyZyhvMJ4x
 Hdkp8IaY2cP8BraAJpq2r0UxYVCPAAvWpBj0qrpHwHc/iyNu/tncUN88p5rqpd6rfXXX
 ks2/+RdYUC46l44ElVEuQrrl6eKcHi2QeYfTDNNlfkNb7feLGAhiEny4EIv4XJUtc20r
 wDO7cKs05KiyRHrmsGOuELZmwfLjHvCYMSoB5MPMoG9e4l7MPqxXKXqro1dl3ZEy81RH
 aTTQ==
X-Gm-Message-State: AOJu0YxE3U7qOkGhC74isSfsGsPL0+qFbzY6noC2dXOn9QhXZW9P0OUP
 vvuHr4Hp5SVyZ+wnzMYO4By09A==
X-Google-Smtp-Source: AGHT+IF+jkveThrSOnKavESswhlWmEbqX0WWAdbdEhEZd2Y9a0aLvnNcpqIFdpQuLqCuVV8shSMfew==
X-Received: by 2002:a2e:a268:0:b0:2c5:a21:8388 with SMTP id
 k8-20020a2ea268000000b002c50a218388mr20848524ljm.29.1699271490873; 
 Mon, 06 Nov 2023 03:51:30 -0800 (PST)
Received: from [192.168.69.115] (176-131-220-199.abo.bbox.fr.
 [176.131.220.199]) by smtp.gmail.com with ESMTPSA id
 l11-20020adfe9cb000000b0032da022855fsm8658386wrn.111.2023.11.06.03.51.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 03:51:30 -0800 (PST)
Message-ID: <398d6f5d-1811-0914-de52-2398ef384750@linaro.org>
Date: Mon, 6 Nov 2023 12:51:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 67/71] system: Constify VMState
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-68-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231106065827.543129-68-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.085,
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

On 6/11/23 07:58, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   system/cpu-timers.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


