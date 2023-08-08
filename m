Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D28E773AF2
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 17:17:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTOS1-0008Ts-CH; Tue, 08 Aug 2023 11:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTORz-0008SB-D2
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:16:47 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTORx-0000sh-U2
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:16:47 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-686f8614ce5so5713985b3a.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 08:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691507803; x=1692112603;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a2oaPpujhCxRBcr02f8wlHAWy42WgjRhAkTX4Vn7rJI=;
 b=o8XT6lxYW7OOiyx0ZWWbuGAb0i/1pk6grzMsivq9PZKWGDT2dFWdG+oYI1Zrl77hfw
 eKcIaBAIzduC2wmRh61CkcWiDBMwRojFAmL0lV3RQ/l2cl0X58M3AVio2B33T7kwzuPo
 au263IDvtoMEyjbRILMZn1IcEIhuKWIK5jJb8lZ6JDSuWA+Kn2SJsswnwGbLyiRTD5x3
 vsn4GsOzJsveP9mp1hCr4NOVr6RXHC0Kz/TayUcIoD6lBY5dvQTizDgir4TVYLpq19uZ
 s/Lw5GnRRsFCT3HIwqrhf04zuADbh1lsXIM9CvV12PHPm4AFldKkz90OoL6dFDmQxMN3
 6HNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691507803; x=1692112603;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a2oaPpujhCxRBcr02f8wlHAWy42WgjRhAkTX4Vn7rJI=;
 b=ViHkjQqu8UIVfG0RqN5cANCnBe+VT4JwpoD/bzGaVqdzbdEuDmt7GYud3v2EaDaPfP
 /lTxwm4hCsr86w9IGtRiLVMWci76zBmPAJnQX6bP4SaBFXF1RpNSPwQmX7/jLADr9Jgi
 AmBkuFPZkfMwKymwGfq8L5oSkj0TQjyWrkY+Gjt+nUkflC893r9uOdG3k4X4VELAFK0x
 8HWsWDnM8HUEB0V8AZGdC4jYu4Rwhyg322ZnuiQtjbtFfvgIYdSUxS8Wv1tbtPWEFxsr
 U6WpIsvXI4Yn+kAIy/KQi11bViMKw8GoYWD2ypu+ZKC5HLjJzWLAgO/198EJAmXN4+G6
 MIrg==
X-Gm-Message-State: AOJu0Yxt1gQU5CEUXSiT1rxkB2+xIMUPQ8pzgzofBBI7TUPnBu+FAR7b
 cCcfNsSx7q41VBCPg9pYnN/rrg==
X-Google-Smtp-Source: AGHT+IFIIXqm3T/b7qSYfYr85gZct2HXrWopQ63bBiyKLZBnRhgw3DeXLZdQiyGI8BdqXTufytrBwA==
X-Received: by 2002:a05:6a20:7f84:b0:13e:3a7a:2d70 with SMTP id
 d4-20020a056a207f8400b0013e3a7a2d70mr12015338pzj.0.1691507803674; 
 Tue, 08 Aug 2023 08:16:43 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 k14-20020a637b4e000000b005533b6cb3a6sm6718036pgn.16.2023.08.08.08.16.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 08:16:43 -0700 (PDT)
Message-ID: <ce7a8180-bb8b-0693-c2c0-22fb378239f0@linaro.org>
Date: Tue, 8 Aug 2023 08:16:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1 v10 01/14] linux-user: Adjust task_unmapped_base
 for reserved_va
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu, deller@gmx.de, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org
References: <20230807163705.9848-1-richard.henderson@linaro.org>
 <20230807163705.9848-2-richard.henderson@linaro.org>
 <87wmy599j3.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87wmy599j3.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/8/23 02:10, Alex Bennée wrote:
> One thing I'm slightly confused by is the ELF_ET_DYN_BASE can be above
> this (or sometimes the same). Should the mapping of ELF segments be
> handled with mmap_next_start? I assume once mmap_next_start meets the
> mappings for the ELF segments we skip over until we get to more free
> space after the program code?

ELF_ET_DYN_BASE is a hack imported from the kernel to put separation between an ET_DYN 
main binary and TASK_UNMAPPED_BASE, so that the brk can follow the binary and have space 
to grow.

All of this is part of the "legacy" memory layout, for which there is a personality flag.

For 8.2, I think we should work on implementing the "new" memory layout, which places 
everything top-down.  But most importantly it completely separates brk from the binary.


r~

