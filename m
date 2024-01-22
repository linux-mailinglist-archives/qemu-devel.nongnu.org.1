Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3908375B6
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 22:59:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS2J7-0006qk-D9; Mon, 22 Jan 2024 16:58:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rS2J2-0006qA-Qa
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 16:58:12 -0500
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rS2Iz-00027Y-Eu
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 16:58:10 -0500
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-598a5448ef5so2391952eaf.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 13:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705960681; x=1706565481; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tjWjybt/zgLq6P5NZFanM3ugb1hYhyr5rrMmFU2mgL4=;
 b=K+wXKh+PfSUcRDzQh9UwmgOnD/YZaydXpeCDIlYEgrdAgN28K7+vSYloAUj8L2kPkh
 dwD+Run4a4J9QeORzclvJD4iQZrXdSTpIbAhh0zUPCMl5Csqy1E8Nm4bCGWF5lXfk45G
 gafmsZs03b6aViZMyeom0vzsmK3x6RvU1dX7blhvzgvsuywNdVPwqx12UI46XtPCj5tA
 Qe6A7XgYMTI3STv2n4Kipnt1USwywqAWYOnMJaz8Z6yMUfZGAZg8JXilgu9XciGFykgr
 pBvBfu+ZPWzZLx8XShINBmyhPzSVC6Ivf8LWal0MBgUaaWgk3p03Ea4sZQdv3hWhmRma
 s1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705960681; x=1706565481;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tjWjybt/zgLq6P5NZFanM3ugb1hYhyr5rrMmFU2mgL4=;
 b=W8xbZFmU+gYrx32msEGXS9RlqyTaUolwBkXsVnmYg10+tU1ykl6GatVIF5fwCOn7R3
 dSail7+rEyrcVu2aj6n/epTdVpS9zQcFxpqc8Yu4orACgKdPCE3VaXTW6jxbKLowNVPi
 Q3PnAucgM5A42tnoS5YE3NJ7tG1xvQs/YvBd36r9zLEvBuTRoCG1vWCxxJ52QI0iKDnl
 3tsTaebFhD+ODR4zLcgxENV3ZORojIFwuMFkVifQ2kgTmIff1LIobVfjH7mskMTnszks
 X+UUZsI+CYFSw9q+D7Mbto6ixV3A0EvAcAn/c1ZdguOUk5PPgA4zP6EwjJhZygwKpZ4S
 Vh0w==
X-Gm-Message-State: AOJu0Yw9sBtLmge5/jCki8miDo5PXQah/rRNx8/xM6AS9YQ9qenLl/J6
 Fn3M/yJfVUVbDXrO2FMgnkmSy6FC7e/TpDYCcptKRVdkM6gtN8OmUAqkOT62s0g=
X-Google-Smtp-Source: AGHT+IGNUHYoK6pIcvGCW1Uei+LGbmmKN1Ge9d8jP/4TorslrGc5m9XoVitDmGU62cT4IG2iwliFYw==
X-Received: by 2002:a05:6358:89d:b0:176:5d11:3071 with SMTP id
 m29-20020a056358089d00b001765d113071mr1616745rwj.12.1705960681271; 
 Mon, 22 Jan 2024 13:58:01 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:2a49:979b:9002:98e6?
 (2001-44b8-2176-c800-2a49-979b-9002-98e6.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:2a49:979b:9002:98e6])
 by smtp.gmail.com with ESMTPSA id
 d2-20020a056a00198200b006d99f930607sm10346911pfl.140.2024.01.22.13.57.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 13:58:00 -0800 (PST)
Message-ID: <d569042e-2c27-47f6-8636-f708b11814b4@linaro.org>
Date: Tue, 23 Jan 2024 07:57:54 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpu-exec: simplify jump cache management
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240122153409.351959-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240122153409.351959-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/23/24 01:34, Paolo Bonzini wrote:
> Unless I'm missing something egregious, the jmp cache is only every
> populated with a valid entry by the same thread that reads the cache.
> Therefore, the contents of any valid entry are always consistent and
> there is no need for any acquire/release magic.

I think you're right, and I over-complicated this thinking about invalidations.

> Because of this, there is really nothing to win in splitting the CF_PCREL
> and !CF_PCREL paths.  It is easier to just always use the ->pc field in
> the jump cache.

Once upon a time, PCREL was an ifdef, and the jump cache pc did not exist for !PCREL.  The 
split has not been addressed since then.


The cleanup looks good.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

