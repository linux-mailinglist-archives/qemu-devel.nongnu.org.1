Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D617C016C
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 18:17:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqFPD-0003cG-W9; Tue, 10 Oct 2023 12:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qqFPA-0003bd-EH
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 12:16:20 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qqFP8-0005dt-RO
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 12:16:20 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c434c33ec0so36229655ad.3
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 09:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696954576; x=1697559376; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CwnMGMlyByFPEM9cIvswAbNsUIdnBnQG6Rgnf/fzddo=;
 b=rzbhRhNGhQe5ilSwCEWNAeiFUjFUQbenKXhRoIHnG7Zq0Rtu1zuskNFDlXR1rXYglg
 woC/55LlMMrRC1nHNCvxO/F9Fpvv+TWZtGcWTQIqwR6Hvn2bXuo7u2SoXaaAduHAbyp/
 PqTLJg1PT193FvnDPWomEBYPQun8VnZiJ6R6TnoQOFYJ/HRDGglZKVUbpkCYs3BU17fK
 HynEmSHo4nW9UFYjmrgURaj8l2SkzsILBy9ay/PemZeu60eck1Cz6V+YxuSQWMUQ2cWf
 nYRg2XkOEOoyJfd16GRYwdM+CxwaqKiLrsvZU3Pl9KLaMk031cDRcrBoJauUKKVEeJQ9
 nuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696954576; x=1697559376;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CwnMGMlyByFPEM9cIvswAbNsUIdnBnQG6Rgnf/fzddo=;
 b=XU7SRn/GnrNdUp8iqEAf4VVU8FnRlMyTwLKUViuNrro8BIdPM56aOFWBhDWO8GJIAf
 VaIj16IAKj8umaf5ayUQ3ECUL1BQCghfqAkyN/HVTw1U5EHuQ0nP5/JCmAOH1BvJZBZ0
 vksjK6t7v8VMHJSrRS1mbQOJGvniMxebhhAV5Es1PdBMXZ9OidaDp6UepzuxtWnxs6Eo
 7m01R8Xsys/uxFP1g8itgFuSk0UwnZSjyxlv5PNphOZc8A9uZjFDGyN7NsP6xunEfmSK
 wMkqva6WY1J7OcnYiGIDR7ZG0bHKadMtPFLxfDa//ZlQY1/NPCSHm+XmYhHrQjQyZ/Yf
 g9SQ==
X-Gm-Message-State: AOJu0YxbcYtgEVef6Th/iCFK5wsJQLthiDNSyEOkjDy7HzlRNu2FQdy8
 0iOOqfg0lzORg4TsuuhrVOeOzQ==
X-Google-Smtp-Source: AGHT+IHt14dFX7q6XdxGLszqMB1wJppesGaUdi4ybuFPtkKzDaIM4LdLCcBvhgVLtwn+4LDEOndzdQ==
X-Received: by 2002:a17:90b:188c:b0:27c:d01b:6c9d with SMTP id
 mn12-20020a17090b188c00b0027cd01b6c9dmr4109160pjb.20.1696954575932; 
 Tue, 10 Oct 2023 09:16:15 -0700 (PDT)
Received: from ?IPV6:2607:fb90:b763:d52:6ee3:1cf3:f2d2:e12d?
 ([2607:fb90:b763:d52:6ee3:1cf3:f2d2:e12d])
 by smtp.gmail.com with ESMTPSA id
 fa9-20020a17090af0c900b0027360359b70sm12392489pjb.48.2023.10.10.09.16.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 09:16:15 -0700 (PDT)
Message-ID: <692e508d-ea6f-48fa-a885-dcc32fa2f653@linaro.org>
Date: Tue, 10 Oct 2023 09:16:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] semihosting/arm-compat: Have TARGET_SYS_EXIT[_EXTENDED]
 return signed
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20231005062610.57351-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231005062610.57351-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/4/23 23:26, Philippe Mathieu-Daudé wrote:
> Per the "Semihosting for AArch32 and AArch64" spec. v2 (2023Q3) [*]:
> 
>    6.5   SYS_EXIT (0x18)
>    6.5.2   Entry (64-bit)
> 
>      On entry, the PARAMETER REGISTER contains a pointer to
>      a two-field argument block:
> 
>      . field 1
>        The exception type, which is one of the set of reason
>        codes in the above tables.
> 
>      . field 2
>        A subcode, whose meaning depends on the reason code in
>        field 1.
> 
>      In particular, if field 1 is ADP_Stopped_ApplicationExit
>      then field 2 is an exit status code, as passed to the C
>      standard library exit() function. [...]
> 
> Having libc exit() is declared as:
> 
>    LIBRARY
>         Standard C Library (libc, -lc)
> 
>    SYNOPSIS
> 
>         void
>         exit(int status);
> 
> the status is expected to be signed.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

