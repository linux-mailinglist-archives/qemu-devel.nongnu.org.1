Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6765675328F
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 09:07:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKCsh-0004c7-Iq; Fri, 14 Jul 2023 03:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKCsf-0004bD-7u
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 03:06:21 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKCsd-0002bC-OC
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 03:06:20 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-765a311a7a9so70040385a.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 00:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689318379; x=1691910379;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y/nraKwf4A13m/XOj/qEjRykkBHYdmzAh91OERfh0wM=;
 b=UoOuTGSiclO9/4oz/pCtkwXipqHfLgSO0NM2qh9Y0f6g2sBiXBexT16ocvsT0rLg3o
 f6vmybCBNthY2xQUT2aqyRtuOZH1MasoyyqycpNVN8iQlgSeihs305wr6Hpih7EhftyX
 1nffKBObe5lE9THPW93myh7TUTpM3NHOLJOOtLasDfHm4r413Lv4YoitMJ4x6CJIi42P
 AWQp+27IQsR+NZNugY37qmLZ331WBXw0+5D6I0QuzWzv5GhNJ1GS9kE/AxL5wST0Dghc
 jrBPt7PLgeMkSc21so/AfzOZxrFuprAEldSK+UTCojfrvdoMrgoLlz0kTzHgAa8/VKp5
 1PDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689318379; x=1691910379;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y/nraKwf4A13m/XOj/qEjRykkBHYdmzAh91OERfh0wM=;
 b=hWfwB1haqvO7uNb2+xzxn323a9pc/kLgMflha4/oRX4SOZHodayxZR+QzRSQNH8yyf
 E5cBmA7/9JekaXqYKgJl32XNfuBSW06P8e79sKv8E1E8CHRDzJ0orrC+rBxDkaDXFPAG
 7TeYGZYxtpAYBxKYrvJYZsuQMe7mBKUAATzkS10VwEIRrTCgY9q8ApFS+EWnGjZXdy/H
 pKZV9USW3hKI+K0WRFw9HtOi/PqVlq2AN1OcYd7bSPb8yNy882mRGKx13Mrd4GiYGYgA
 ZEeyy9LuNWIIGcCXS6+kHFvuuu1ZtLcYVyX/Vz8gQAHw7fhehy2HvYtOAE2rF+1wyyMR
 9mDQ==
X-Gm-Message-State: ABy/qLYCAv74MLAg7PkctewMvMqctkf6bK4io9qknFxEKoyPPoenqi6P
 wDgf6HqtBXIAdBB/JIqFFXk+3g==
X-Google-Smtp-Source: APBJJlHOI6PeaEOT3TagzDghdAAMY9hhVqBjoZQeAwpeOZtMelsfHu3afu+KpNPkhro9Kjscv+P7xQ==
X-Received: by 2002:a05:620a:133c:b0:767:156e:ddaa with SMTP id
 p28-20020a05620a133c00b00767156eddaamr1841732qkj.35.1689318378734; 
 Fri, 14 Jul 2023 00:06:18 -0700 (PDT)
Received: from [192.168.149.227] ([172.58.27.104])
 by smtp.gmail.com with ESMTPSA id
 g7-20020ae9e107000000b0075cd80fde9esm3547613qkm.89.2023.07.14.00.06.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jul 2023 00:06:18 -0700 (PDT)
Message-ID: <290271a0-88cd-88b6-a485-3e1a3b9bf3e1@linaro.org>
Date: Fri, 14 Jul 2023 08:06:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 10/11] hw/char/pl011: Rename RX FIFO methods
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
 <20230710175102.32429-11-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230710175102.32429-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x736.google.com
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

On 7/10/23 18:51, Philippe Mathieu-Daudé wrote:
> In preparation of having a TX FIFO, rename the RX FIFO methods.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   hw/char/pl011.c      | 10 +++++-----
>   hw/char/trace-events |  4 ++--
>   2 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

