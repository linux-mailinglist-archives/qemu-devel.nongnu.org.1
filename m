Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C6076D36F
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 18:11:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qREQG-0007L6-UX; Wed, 02 Aug 2023 12:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qREQC-0007H0-NO
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 12:10:00 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qREQB-0004gw-Ao
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 12:10:00 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-686f19b6dd2so4799703b3a.2
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 09:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690992597; x=1691597397;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s++/Zsko56kzhbOMV26wFGArtEL7ZAq8lUyGSY4wvZQ=;
 b=TbdCGqSSt3F4DmmM4U1/ZUrkayd0P336MOz109E+oSOmrzV+ogrqKb8SGzxf5n7n2q
 f59mG+IsKuAuBO55biNz6Kmn0qQ3MjEETU4unIc0EflEdxWZts0nUzrt+R3jKBINAGwJ
 wIFDadWWa74hfFN0L2+5s6vZ0I5wmr99cdR5k46WbiF63+n6x9+Gxb23lxzQCZllJRO0
 SCkEOwcF1ZNOe3Ws02O6rVtfItg6W/OZAIvsmmLKEYlWZhFU8MJFj2zUfUfca+289DPH
 FUGspwN2C1MTMP/Cet/6dUyM0P9mzELfClI7gz7n+hyszZCrE3fi9y5mK1POJUiEmemP
 pVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690992597; x=1691597397;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s++/Zsko56kzhbOMV26wFGArtEL7ZAq8lUyGSY4wvZQ=;
 b=c9+rnXDiMPA2tEEOJrl9ZEpKM5m1LsgMhuwt4phinWY68+rteRJo+WQWpXONXDWkp/
 19GqGHJ3bEWiYeHtJ1ELR69qxWsS1RXULDY3iIgrIA3RnyGChSZZR7/UWXdihKtuWOnn
 ktBTa0tZZiRnR4oUe0b2HdyadwP0wf5I8dc7hdoz79Ko+bmH9+So9tSaCKjI1+vtkckY
 XHpNmruJS7wpmYA5xYU5sYUQlTuQMiKYDXJbFQCYN9PoLOj1G3KPKk4ia320+hc6maxf
 skhE+tHWVYqS0JHDbg861GUhOdrPzRecg/2QhUoBz2uctgB0+SRU21f5AtUiRmJU55rL
 WWhA==
X-Gm-Message-State: ABy/qLZ3gSUcW6HYE1/ENVJphkPuNcV7e9OBuMUMiNFdVnKqqJ2KpArh
 Tz9vDIWyFbCtan9LwtiEhTdbGA==
X-Google-Smtp-Source: APBJJlGZ2WbcKcuf0raVLiGJscdnye2RUjOpvZUQPaHdwQqcQgMB7rBAYc8KIpCmeYpwMg5xGdUBmA==
X-Received: by 2002:a05:6a00:843:b0:67a:9208:87a with SMTP id
 q3-20020a056a00084300b0067a9208087amr17927350pfk.23.1690992597141; 
 Wed, 02 Aug 2023 09:09:57 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:b659:bbad:1a22:7ef9?
 ([2602:47:d490:6901:b659:bbad:1a22:7ef9])
 by smtp.gmail.com with ESMTPSA id
 x41-20020a056a000be900b006815fbe3245sm9271535pfu.37.2023.08.02.09.09.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 09:09:56 -0700 (PDT)
Message-ID: <ffcb690c-91d2-60f5-3e65-e0be204de7b8@linaro.org>
Date: Wed, 2 Aug 2023 09:09:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Fix SEGFAULT on getting physical address of MMIO region.
Content-Language: en-US
To: Mikhail Tyutin <m.tyutin@yadro.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: d.solovev@yadro.com, pbonzini@redhat.com,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <bf8ae2fd-158a-57b6-6270-2e56b6506421@yadro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <bf8ae2fd-158a-57b6-6270-2e56b6506421@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.102,
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

On 8/2/23 06:08, Mikhail Tyutin wrote:
> The fix is to clear TLB_INVALID_MASK bit in tlb_addr, as it happens in other places e.g. 
> load_helper().
> 
> Signed-off-by: Dmitriy Solovev <d.solovev@yadro.com>
> Signed-off-by: Mikhail Tyutin <m.tyutin@yadro.com>
> ---
>   accel/tcg/cputlb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

The other places in load_helper happen only directly after tlb_fill has succeeded.  Here 
you have no such guarantee.

I think perhaps the save_iotlb_data() call should be applied to loads as well, and then 
tlb_plugin_lookup simplified.


r~

