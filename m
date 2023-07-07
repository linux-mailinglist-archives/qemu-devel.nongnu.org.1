Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8E474B7B4
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:16:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHrsR-0003ua-CV; Fri, 07 Jul 2023 16:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHrsL-0003uK-NQ
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:16:21 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHrsK-00034u-9b
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:16:21 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3090d3e9c92so2590067f8f.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688760979; x=1691352979;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZEYdXbI+y4fiJSMuRe5fpxENPHkNKfzGfe5hkroN4SI=;
 b=HEuIEDlTJ9LPOlMvbkCfDKpnTZ4CVtIAFncsbcfCA/Kflv7soZo+jj8H9HD+AhCpzC
 0/KB165XCX4TFGB0xbq+T0tc1HGr9Rlfo/ZrT3Xej1z/AK7c3hbGCp6VzVyw3I6ZXtei
 iD2sumG7jbLmaQAZ+Pyjhnh4wnk/wjCQ5RnN7HZnpAuLSlClWpZikrav8jFhLOU5Ttmn
 6QhJWuhWGaKU5DHxjhGSHeHzkp++EONGFzK8vyyvC3okT6n/A1S60uYJ5iMUMa//LmJQ
 /uhA37uI8P71HKg2AtG14m2+m1BbUa2fuPk1xqAbsrMHO03+zX/ozgGbnVO5zupGusEs
 lfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688760979; x=1691352979;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZEYdXbI+y4fiJSMuRe5fpxENPHkNKfzGfe5hkroN4SI=;
 b=EmcxpaO19t6cMsWh6YvHqqngFEcLbDrIbzNnKprJHuXXWC0RZIxVU1HilemXv76mCi
 f6vvaQ0/JAS53eG6xKRkkK84HKC15nDKAsiLgw5oDZhJY210yqV3YhaBRoCL3Z2191bM
 OXcd/iM+iG3yn5UvauwpJGEM06A3yDPA2+p+8am1Rz0M+Sugfuu7lMVk3dwdR2jMgS00
 pL8JpUkZb307eft8iGoeOyb+RE7HWtu1hyqWXCn4jhvtWlKMQxE4TePYvkSkX1+MuY0F
 R0avtFKAGX2QadL1rCGIyEXB2dpD+0eVEepBaginGRVa6hWToNfTrCK3jPtaUXIIQMgw
 EWSw==
X-Gm-Message-State: ABy/qLZ4cH8o7wc/uHSClFKo5iH/hW5TqfH602EXE4mL3rFHVcfNr4CS
 VgkZYhirFJuKk9nRfEoMSODedQ==
X-Google-Smtp-Source: APBJJlE3ZplcT6Rcc6UwuqH+MvI4wo+CzCvr8WkCjZ83rQsb6tVGBVVJTyzxE07mxcrikbb7C7uzpg==
X-Received: by 2002:a5d:6045:0:b0:314:52b4:cc38 with SMTP id
 j5-20020a5d6045000000b0031452b4cc38mr7280039wrt.52.1688760978853; 
 Fri, 07 Jul 2023 13:16:18 -0700 (PDT)
Received: from [192.168.1.5] (host-92-23-208-66.as13285.net. [92.23.208.66])
 by smtp.gmail.com with ESMTPSA id
 n2-20020a5d6b82000000b0030ae901bc54sm5253912wrx.62.2023.07.07.13.16.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 13:16:18 -0700 (PDT)
Message-ID: <696c0783-a903-8dc2-08eb-84785bb22dc5@linaro.org>
Date: Fri, 7 Jul 2023 21:16:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/4] linux-user: Improve strace output of pread64() and
 pwrite64()
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
References: <20230707131928.89500-1-deller@gmx.de>
 <20230707131928.89500-5-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230707131928.89500-5-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 7/7/23 14:19, Helge Deller wrote:
> Make the strace look nicer for those two syscalls.
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> ---
>   linux-user/strace.c    | 19 +++++++++++++++++++
>   linux-user/strace.list |  4 ++--
>   2 files changed, 21 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

