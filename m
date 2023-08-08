Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD3A774251
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:41:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQh4-0005ER-LZ; Tue, 08 Aug 2023 13:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTQgy-0005Cs-Te
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:40:24 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTQgx-0004lK-Bo
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:40:24 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bc73a2b0easo14071815ad.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691516421; x=1692121221;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iKjiemnqOykWLfe5AtUFCY6LjhdWPF1ouPvBQgWX+Ws=;
 b=Ym46kN4VbbqmjDyycxDardZvSDHiNTcIifbPBVF8jQuGK3kP1qRjXYyhCxjBR9HoJb
 c50tITAR6Z+9+ouj9r65tGjPbtzZiIY/j4aYBCRpv8dK4MjH9a5xZuFaCvWJON0q/ST/
 L3tiPvQYZ81coeDvju8WFBCD+gniZoa7U9gggUmmZ4IxC00Vzv67CGhHYI6gibiAmunA
 eLZFEQHzGQSQBmPXaeSUm2M6ft18H9UbzG21fGuSajAw04qgkcd0l25sGAst4L1/FDsY
 0F3bg+C5wpajktRxqiOLbJAZFCnggvVDWzUeGlDxtnUM0b6pzwNKLRlhqxArUSKCdqkS
 qUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691516421; x=1692121221;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iKjiemnqOykWLfe5AtUFCY6LjhdWPF1ouPvBQgWX+Ws=;
 b=i/3IgCG4WCtYf/XjXmQ52QbQQU9v1og0D03wPV1i1iAUG397k6fTqdwctu/a1zrudx
 nCDG8a/x6wH6bfD0YCz+LKB67qNPq02pmQtuDhLYEB0uKaNlRRWoHWKnElSqQWY4JHu7
 JtVzeys9ezrcvfBYvnqZ82aURj7wP33TEGg34J5F8iIJIVf7mzKeHI0j00xSeoeAuAQW
 /cKZB4oJ4sIDynAxczDv1228Zc/4IGnycBD95ExhGTi+3PkbS48mkXEqzWChWmf3BPRb
 oZKB6dPYYddEGMgXHWSPeywZN59gJmItLa9SYGlK28SoKnNU5kUJLmiLZBimLyAw5UMM
 Fg2g==
X-Gm-Message-State: AOJu0Ywg4r8SXeBzuKTHyu/4rD4ATLHRWlWxfN/1tV3GIJs/IONVeNxk
 wCNqLTfg8K8r6fYHQvqc7NeyWw==
X-Google-Smtp-Source: AGHT+IFgMUPGaq0o9z+HlEpPTtGo13UkCToNgGMsKnLznCcXL0mm/xfl3+OJgBfYdIqlOl7/Q3n2gA==
X-Received: by 2002:a17:903:44f:b0:1bb:a771:3542 with SMTP id
 iw15-20020a170903044f00b001bba7713542mr363255plb.58.1691516421076; 
 Tue, 08 Aug 2023 10:40:21 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 kx14-20020a170902f94e00b001b890009634sm9320774plb.139.2023.08.08.10.40.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 10:40:20 -0700 (PDT)
Message-ID: <f09ce557-545f-8983-1e84-60d78188c405@linaro.org>
Date: Tue, 8 Aug 2023 10:40:18 -0700
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
 <87wmy599j3.fsf@linaro.org> <ce7a8180-bb8b-0693-c2c0-22fb378239f0@linaro.org>
 <874jl979m9.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <874jl979m9.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 8/8/23 09:59, Alex Bennée wrote:
>> All of this is part of the "legacy" memory layout, for which there is a personality flag.
>>
>> For 8.2, I think we should work on implementing the "new" memory
>> layout, which places everything top-down.  But most importantly it
>> completely separates brk from the binary.
> 
> The QEMU brk? The guest will have one emulated for it?

In this context we're talking about guest memory layout.
So there is one brk: the guest one.


r~

