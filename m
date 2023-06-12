Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6AB72C4F2
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 14:51:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8gzb-0006zI-Kz; Mon, 12 Jun 2023 08:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8gzY-0006yh-HM
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 08:49:52 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8gzW-0004Vv-KT
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 08:49:52 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f735259fa0so43544355e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 05:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686574189; x=1689166189;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7HnMuCHfKAnGfdj4TgjWq7bBPKhDX9Q67vwe7EvNhsY=;
 b=TAvd5gkW2TvZ1+h5FafigImLQ44GtE3IeFp91KGAZoe1ELPi9Et1kmR7sdC718Myt8
 f454PigUFEbOKb1iDZUMItgOzDe9kC94g/JxDf7SxLv5IpY5RFMGVPhIOPqgINKhx9Cs
 pJcKXxV0usoJGT758T55GTOanLLaFWy1FNZv+ZrAGmbAmOFSmcDtEWhgQ1Php6wjLwgw
 ttOgYsK/yB4VOS6gYa0j6YgRapFy+iLX5Zn1lkXEwnZ6yxt8czEksvZVdtmMSIInnKDC
 0j/OhMyoOpFVwW5n9hLY95OFfaOf8Y9VcNDr7+230I5OHnQc0TSTw5qMn9FkOXqr9eaf
 hOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686574189; x=1689166189;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7HnMuCHfKAnGfdj4TgjWq7bBPKhDX9Q67vwe7EvNhsY=;
 b=gkmIIzgzrly6w+HsVS7Sx3p2GkhjCT4H+mCCgajKPyc2jXaCX0jpShWfTE73F3Y0tT
 VwDnRZB6GWIHkrYX4nZT203q5I0M+MrkiPKSwoJw9k4F5e9jwi7VsvDj50CvvfIzF5P5
 35buw/vqy7tXXI3nRE2HWWp5V7yMTsrwsyqUYMSFe+Gw1Zd5JGRN2UypZvN54qoQmXmf
 cLoLYaedGiof9MEpFB3fZs6RTlR8OQ9FlRFv7npzFVCZ1n77cizu/5qZ+Y6ACJlTZaZt
 D8jlXskHYXhFgW8pnm9yWVx5FSuTEyPY4Ie4ZpUNuKP0AfIt4cmH2qv/tDb3M0BU7YSx
 0sUg==
X-Gm-Message-State: AC+VfDxMdY3gaZm0siJFwJt2sXHNEsg4LzVb0QklSqRjW8aBnsPGXr6E
 zKjjEuOFhnFyrMjsyw7IAxJOnA==
X-Google-Smtp-Source: ACHHUZ7a37Wi6xMWjbUU9I858Xnb/FHkjzvw7DJV0K8kUTnGrS+xR0na0OF+fS0wP0A6JjanfMbkcg==
X-Received: by 2002:a05:6000:18c4:b0:30a:ec6c:913 with SMTP id
 w4-20020a05600018c400b0030aec6c0913mr4556659wrq.10.1686574188877; 
 Mon, 12 Jun 2023 05:49:48 -0700 (PDT)
Received: from [192.168.112.175] (176.red-88-28-1.dynamicip.rima-tde.net.
 [88.28.1.176]) by smtp.gmail.com with ESMTPSA id
 b14-20020a056000054e00b0030c2e3c7fb3sm12260158wrf.101.2023.06.12.05.49.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 05:49:48 -0700 (PDT)
Message-ID: <67d05b25-0ab4-9c63-caa1-22be11fc6153@linaro.org>
Date: Mon, 12 Jun 2023 14:49:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 1/5] cmd646: checkpatch fixes
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, jsnow@redhat.com,
 shentey@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20230609185119.691152-1-mark.cave-ayland@ilande.co.uk>
 <20230609185119.691152-2-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230609185119.691152-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 9/6/23 20:51, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/ide/cmd646.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


