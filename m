Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1397B536F
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 14:52:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnIOT-0006kv-4Z; Mon, 02 Oct 2023 08:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnIOR-0006kj-Sb
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 08:51:23 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnIOQ-0005LP-Ay
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 08:51:23 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-323ef9a8b59so6854928f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 05:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696251080; x=1696855880; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JJDajxbIl3qklNV3jQiFSzdiGI50r5dNRaCEPlU+2mw=;
 b=Igo6lr/vHYzwc3wKFwvk8cbJXPE50N4efp7hfhP2n8uAzNXCMewBbbQvLlaozM2qqs
 RmbiF0ryasENEPjFyhQ4+fwFMjASAHiEb0ZLkmwCi0jm4hgw5BsktC74THLickp/3Usx
 7x1DbIKTFcobbT9I27GUhLcUZw3ThFVPxSkrT/hl6gwsqtGWIcmxkzuVTYcVhTUwtevX
 AEDjgLwb7BBbyYs883oc2fu447qVH5sXbUXSikrFm3Gqgx16v5uXHIxicFqJMvI94Hr9
 GeQMmqrtV0hYdFDS+xklJghurl4/y2g/zd2ddpBPPRxOZx0Yj+NYI/OKxUNhMlCaK82J
 GMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696251080; x=1696855880;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JJDajxbIl3qklNV3jQiFSzdiGI50r5dNRaCEPlU+2mw=;
 b=Nel1OfJwT6yoOEgGFieizF6/2Kh38cr7ujGLwYmBdVsPNVaIh6bKxFk+YhoikkAJeH
 BuKcd7MHZzpyx4nhzlXFzH68/Wa6X61cGJSPkyI91U8vpJD/2qrSNMONwAGU451AkeRy
 NvdHQL2gSxD9meoVPOuejx2CrTJ8t/4IpjYeAG3ne38no9q4w7Uzgh9m3kE9Oexunl9j
 6ZnRMljtWyZHqJoDl2dlIeQIKYQeNMwzsXLEqomMfNJoaG1P0B7A7OE9RK1crmZZ37xI
 i6iyFFtkypIbJMP2iiNkF96t4Af8yny8BaExKEwXo4wzIxKSJXIkSAix1xCBDPFpPm0x
 nJHw==
X-Gm-Message-State: AOJu0YwBhu1g82nLkMLZsttqj6zAKqGHfUr+u2neRmYv9zbIE0kfPlYJ
 1Xp0r4+nRwnb6m4g59E5XamdkecO1AxVGFw+1OlNwg==
X-Google-Smtp-Source: AGHT+IHe8WjuhsLaPKOlcAy9oGAHUlFUqPwIItz1YUpIDwx4orUwR31SWet+t5DZW1jKLMrVRFUAFg==
X-Received: by 2002:adf:ec05:0:b0:323:1df0:c039 with SMTP id
 x5-20020adfec05000000b003231df0c039mr9910128wrn.56.1696251080385; 
 Mon, 02 Oct 2023 05:51:20 -0700 (PDT)
Received: from [192.168.69.115] (sto93-h06-176-172-7-203.dsl.sta.abo.bbox.fr.
 [176.172.7.203]) by smtp.gmail.com with ESMTPSA id
 e9-20020adfe7c9000000b003197efd1e7bsm14048422wrn.114.2023.10.02.05.51.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 05:51:19 -0700 (PDT)
Message-ID: <b9d95267-c213-0ea1-ddc7-7af54046b566@linaro.org>
Date: Mon, 2 Oct 2023 14:51:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/2] Split out tcg init functions to tcg/startup.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20230930031114.1042913-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230930031114.1042913-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.321,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 30/9/23 05:11, Richard Henderson wrote:
> Supercedes: <20230923130843.3708899-1-peter.maydell@linaro.org>
> ("[PATCH] tcg.h: Split out runtime-only functions into tcg/runtime.h")
> 
> I thought "startup.h" was perhaps a better name than "runtime.h",
> at least for the functions moved, since it's about starting up
> either tcg or tcg within a new thread.
> 
> By removing the argument to tcg_prologue_init(), we can simplify
> the users even further, since they no longer require TCGContext.
> 
> Adding tcg_init() seems to match the other two as a startup-y
> function and allows tcg-all.c to avoid "tcg.h" as well.
> 
> 
> r~
> 
> 
> Richard Henderson (2):
>    tcg: Remove argument to tcg_prologue_init
>    tcg: Split out tcg init functions to tcg/startup.h

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


