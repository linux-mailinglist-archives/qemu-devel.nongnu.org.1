Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D83277AB4E2
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 17:38:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjiEk-0005bT-Nc; Fri, 22 Sep 2023 11:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjiEi-0005aF-SO
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:38:32 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjiEU-0001l7-8U
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:38:32 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31dd10c2b8bso2202960f8f.3
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 08:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695397096; x=1696001896; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AFCaAzdNrvDh4+Q2kMe8z1q4ZlGOkyzo+a3Q+1yHIcc=;
 b=YWqn/g9ux6UaKnSZmblG1nysMXRiqX3EG1qgiMmJCGWemukUWOGGJehpHvpiUWNMN6
 uhymYaVvcYeFZMgTLjuk6N8l+P8mqcCN8IGM0SheNhEMJA6iCJ1Te1bSzNQYGRK/jzjQ
 Dfp0GYwPcKWqa9S/iWQ22hWVhnq6OdDN+HrtQ+SwV0xNOWMofYTZV2fqCwMk03jWiGga
 Fx/Dm7msFZS/XvpxmAGX8hjlJoa6UD0oGgMdRpC/vnTdbwpPyaLSy8soWvgKuA5+OU00
 4Q4aBP4Xbj3EAv6iejSZ1YTh49sfNtLmvLmmVsnVBOyEqpLChqNBtcRAE081nFqq3GL2
 NG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695397096; x=1696001896;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AFCaAzdNrvDh4+Q2kMe8z1q4ZlGOkyzo+a3Q+1yHIcc=;
 b=wzB3V8kYa1QvJOufdNQnvVMaEk6o1w0ehtUVDNnb51Y5eFH8bqQcSPSZzCK9Nr4/ho
 /mBO0EJnixYiW7fVvEpLLwA4cilb4bJb5SJkKXyMVs8x/zaNLOLysXAcg28PoAg7zm1M
 8kBiRl5N0EF1dmVFaP6KJOK3hNGXTYKe8WTOORynQ0ToAc3xoSQRh+Oxi11m5a8+q6ur
 xN5Zm4lwLllVmBBdhd5VuCuUVkcDeQJ2RIj2t+VIFsY5CR59D4C48QKpqhEQu+pzV4iB
 qEO0IUIg+7ZXdsdsyYz4l6MIn1ycyKGQ9FP8vOXcKkGUkdGMmehhbGYybfCbTWMP9Elm
 Xf5w==
X-Gm-Message-State: AOJu0Ywv1JIQn+NDL0luZpU9mszwVdWiKfwEzAOL6n8OdnZC9++JiZGY
 gN8a5ugXISllC3bwvrSShKDaDg==
X-Google-Smtp-Source: AGHT+IHeBqfuZd1k0iqB3O4Jjchhwe9jmUDL2729sxrNfJLmj4CM8bJLWMDjEOgu6MRLTCZ+8x17LQ==
X-Received: by 2002:a5d:6a0f:0:b0:321:71ae:736c with SMTP id
 m15-20020a5d6a0f000000b0032171ae736cmr49562wru.7.1695397096554; 
 Fri, 22 Sep 2023 08:38:16 -0700 (PDT)
Received: from [192.168.250.175] (234.red-88-28-23.dynamicip.rima-tde.net.
 [88.28.23.234]) by smtp.gmail.com with ESMTPSA id
 a2-20020a5d5082000000b003143cb109d5sm4715197wrt.14.2023.09.22.08.38.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 08:38:16 -0700 (PDT)
Message-ID: <6a79b3ab-e726-2f29-2ded-20c6dc32c170@linaro.org>
Date: Fri, 22 Sep 2023 17:38:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 2/4] hw/misc/arm_sysctl.c: Avoid shadowing local variable
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20230922152944.3583438-1-peter.maydell@linaro.org>
 <20230922152944.3583438-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230922152944.3583438-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 22/9/23 17:29, Peter Maydell wrote:
> Avoid shadowing a local variable in arm_sysctl_write():
> 
> ../../hw/misc/arm_sysctl.c: In function ‘arm_sysctl_write’:
> ../../hw/misc/arm_sysctl.c:537:26: warning: declaration of ‘val’ shadows a parameter [-Wshadow=local]
>    537 |                 uint32_t val;
>        |                          ^~~
> ../../hw/misc/arm_sysctl.c:388:39: note: shadowed declaration is here
>    388 |                              uint64_t val, unsigned size)
>        |                              ~~~~~~~~~^~~
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/misc/arm_sysctl.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


