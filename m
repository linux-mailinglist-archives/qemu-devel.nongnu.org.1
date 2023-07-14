Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ACE75326F
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 09:01:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKCnL-0001c8-Qs; Fri, 14 Jul 2023 03:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKCnA-0001YL-UX
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 03:00:40 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKCn8-0001XY-Nn
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 03:00:39 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-666ed230c81so1556641b3a.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 00:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689318036; x=1691910036;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pAKA0QabmqHkU+d+oceFox8otAHUlSc6ZWZkW9K5Zfg=;
 b=WW3n0iEvuSOGnQ5lH/HYNfqceuAu/lIkd5VHp6H1IRWo5oM8jIEutn5q17POJkcQVK
 rqTAvwMd4jWzlhYhHOwcDDbFOfyj4xUbZJUnUkI1ftNwWZf9WmBX3hLB0gkcKntqrZPi
 dPB2MgLMG2PPDTat479AsA81uqXh7+Z8eh/e7RoApx/BkEMeAE95ls7KEMLl1eIGkohT
 EuYBT/f//OpYSZcb4JGoCs0EjlK4bMjlHy2nBLr4+6XfByZJgrktqTqSNdWGe6THhYRN
 gdUR+W52EHJJ50e4SHxvLjtAjxdk2QuZQ1WZ76knFeB35BR/HtzJ4wUMJEF3mDtBRKWN
 l5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689318036; x=1691910036;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pAKA0QabmqHkU+d+oceFox8otAHUlSc6ZWZkW9K5Zfg=;
 b=WFF1FTk1ATq4ZAmQ8Z/8DucNtPVmGm/v42Ltp/QED6FC0nuv2WepP6rTs3SgZRU9oa
 UyhOswT2BX0FFwtZQ0J/tlZfICxXQFCR9jDO+2cGD6zhnpxzjBbIBuiYg3Bbg/Tzcv3q
 cWXxsEvqvdm4kY3hTUvRIMrJYZLypATQgQgVqrUN0Se7aHTG7C3KECQ+gYA9xICGbG0c
 t4dCAnjbVUiEtHWtg0PCew3gCeIgMilgWy9U6+qkLvPi4MC/X8GBZF4TScO45bN7+G69
 reLS842EzC4NvSVNUgox4/GSaPd8SKQjv7bLjnXcJ/vlhCAz6QnjVIVg7TaHci2Kdfke
 EW2A==
X-Gm-Message-State: ABy/qLa2XZyIfD0Fl5d+mrqgDaOQjqdhOWHwWoponLiED3l6cvyrzM4h
 QpzA7AFJnJ/BULv6OCXAZeWk5w==
X-Google-Smtp-Source: APBJJlHhVTO76nDSTJ6/pC5QBycGSiMnMLbB4W2T4HMZ8gsmUbEkyOvyH8cOs8x15HT/j3LkueQhBA==
X-Received: by 2002:a05:6a00:2d19:b0:676:76ea:e992 with SMTP id
 fa25-20020a056a002d1900b0067676eae992mr4897124pfb.5.1689318036450; 
 Fri, 14 Jul 2023 00:00:36 -0700 (PDT)
Received: from [192.168.149.227] ([172.58.27.104])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a62a50a000000b0065dd1e7c3c2sm6410290pfm.184.2023.07.14.00.00.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jul 2023 00:00:35 -0700 (PDT)
Message-ID: <82bd3dc8-ff75-65e1-82dd-651bf73b8960@linaro.org>
Date: Fri, 14 Jul 2023 08:00:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 07/11] hw/char/pl011: Extract pl011_read_rxdata() from
 pl011_read()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org
References: <20230710175102.32429-1-philmd@linaro.org>
 <20230710175102.32429-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230710175102.32429-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 7/10/23 18:50, Philippe Mathieu-Daudé wrote:
> +    if (s->read_count == s->read_trigger - 1)
> +        s->int_level &= ~ INT_RX;

Fix the braces.  Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

