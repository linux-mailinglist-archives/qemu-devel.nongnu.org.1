Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D8876F5D0
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 00:45:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRh3D-0005sT-KV; Thu, 03 Aug 2023 18:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRh3C-0005sF-0D
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:44:10 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRh3A-0008VV-DP
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:44:09 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6bcaa6d5e2cso1293552a34.3
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 15:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691102646; x=1691707446;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5Xax/i81wWuuTHacUrrWZ2wEVvCt2zpX9rQ5rNAXH/A=;
 b=g6YklAzGIS8VX87XWfeV89J6iSw5PLRV4Ww4FhztJw2RTk53n/Lm7c+X0LsAz4WOE6
 0klzdWu1JqCol2L162Q0ID8Po97xUl98j6tFzwN8BxFpt8eJZGd/xJ+pSmPTNu1YWnV6
 smT5W1Fzk5yvicwR73HOqxOXvY5bcJYLKZ5MvOox8pM+nzS2PQUmdRIjKMKP7xPTdUZ5
 H6ZyJ1uM6lz5CO3wGxfMh6NL9LatIXfLFsZVA08h0mukzpJ8xBkc7fVK6Z3o/dICKY0d
 rKEcrs/SdzAazUreCeCX98iqzspdt2aSR9nti2mKsHBibyjHEDc6T+cO9MdgFETCxGpD
 AbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691102646; x=1691707446;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Xax/i81wWuuTHacUrrWZ2wEVvCt2zpX9rQ5rNAXH/A=;
 b=eBrqrPlBXVNxovYlLBLF1V5TN13mFFTzsKYBsuJTBSpmxos3wDs1iZaeiYH786jJWe
 NEArx3FoSs5x8eVPHVZgxWDfNVOOtgtzSxb3LfBW9OUn5abDWm/XaFFpjd9VMW03Jjg3
 bZls3JMsco25TZZBSHQeCW5YCErPfJD+mMpNhtGbomIoRv8xr2AA+gTamz4GZ8YcNieJ
 cQ/rwLs20DN9jZp3IS1/M9kIKjnV1/UIGmLBIe/Orx3MX2/TyMzpclqcjlt9OanUsVg4
 C4nQz2LqS06h2jvsXxAezNxPfqOhTpK4nGc7HZKYnQUEvQOzg2QJSpbC7Ppl3ZKkxHo9
 kmgw==
X-Gm-Message-State: ABy/qLblT+p3rofaYEd9bOjiTRh043LzczHg4pgn0keUbI8FvUknm3um
 vd7pEDgFuD5cAPfD/DbfL/Le0w==
X-Google-Smtp-Source: APBJJlF3vKggXlp4dFXeafF2+/FMq1dnBdnJJ4lgzDtvTqvu5ofNJ2qY1IBoWxNQoioQMq5HodVvDw==
X-Received: by 2002:a05:6871:10c:b0:1b0:3cd4:76d5 with SMTP id
 y12-20020a056871010c00b001b03cd476d5mr23107676oab.37.1691102645732; 
 Thu, 03 Aug 2023 15:44:05 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.144.105])
 by smtp.gmail.com with ESMTPSA id
 ne10-20020a17090b374a00b00263b4b1255esm1485963pjb.51.2023.08.03.15.44.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 15:44:05 -0700 (PDT)
Message-ID: <b8f7799a-c54d-1635-d5b0-abe7e515bc19@linaro.org>
Date: Thu, 3 Aug 2023 15:44:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/3] linux-user: Emulate /proc/cpuinfo on aarch64 and
 arm
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230803214450.647040-1-deller@gmx.de>
 <20230803214450.647040-3-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230803214450.647040-3-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 8/3/23 14:44, Helge Deller wrote:
> Add emulation for /proc/cpuinfo for arm architecture.
> The output below mimics output as seen on debian porterboxes.
> 
> aarch64 output example:
> 
> processor       : 0
> model name      : ARMv8 Processor rev 0 (v8l)
> BogoMIPS        : 100.00
> Features        : swp half thumb fast_mult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae aes pmull sha1 sha2 crc32
> CPU implementer : 0x41
> CPU architecture: 8
> CPU variant     : 0x1
> CPU part        : 0xd07
> CPU revision    : 0
> Hardware        : QEMU v8.0.92 arm,cortex-a57
> 
> arm 32-bit output example:
> 
> processor       : 0
> model name      : ARMv5 Processor rev 6 (armv5l)
> BogoMIPS        : 50.00
> Features        : swp half thumb fast_mult edsp
> CPU implementer : 0x69
> CPU architecture: 5
> CPU variant     : 0
> CPU part        : 0x2d0
> CPU revision    : 6
> Hardware        : QEMU v8.0.92 marvell,xscale
> Revision        : 0000
> Serial          : 0000000000000000
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> 
> v5:
> - use is_a64()
> v4:
> - more refinements based on Richards feedback
> v3:
> - show variant, part, revision and implementor based on midr
>    value (suggested by Richard Henderson)
> v2:
> - show features of CPU which is actually being emulated by qemu
>    (suggested by Peter Maydell)
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

