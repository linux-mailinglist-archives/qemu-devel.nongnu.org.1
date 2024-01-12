Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6217B82C82E
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 01:00:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rORQ3-0000XX-Si; Fri, 12 Jan 2024 18:58:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vineetg@rivosinc.com>)
 id 1rORQ1-0000XH-1U
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 18:58:33 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vineetg@rivosinc.com>)
 id 1rORPv-0008S8-KL
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 18:58:30 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6daf9d5f111so5439673b3a.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 15:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705103904; x=1705708704;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k9jfAF/AlBIgYVQHtahwTnBQ9smRez8CJqwH3ctTnAI=;
 b=I6HyGXvggp3NFMQo8xOig2dr0EKRLpAuttV0ADKZLsq0YBzq18H3WAgkyst3wanoS5
 +iKXTp1fPI5BRgt7J2wDQfEYbWdSRqPUz4mT3SmqQxkhAEnlyOpvUzrMiveHbLsSrMj4
 kRXKqS56tZ0uRkY3gMeD3tPRWYlus/wcrOHPJWq61KHNwxB9dq/m/Fz7l5+4MN91Tio4
 +OlWMfGcVVjA2Cjj6HW1H8s3XwXwuHIWA+G4alpDNG41MhIYrW95HuffQMA0RgW6yAVx
 ODUyo/2WzzWbgJImMRIE6DET0AoyD/nbFtt9ThF6T/LKBK/xFeFZdqZvtZHpmrKpgfaN
 6Urw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705103904; x=1705708704;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k9jfAF/AlBIgYVQHtahwTnBQ9smRez8CJqwH3ctTnAI=;
 b=ejpRnN0U50APy03qSY4TQQNGkGsny+jkGX8TFAaXZCn85gbQBjXg1l+sLXcLkj9U+w
 8ubVX6YiqSx2e0kHV3vazPkNauQhkZDCnP0hXztJFfDbxRfFwa/VxISIWZAWUKGGMpUu
 lLVSNUxBlN7ZUOqQLFkV+ZyKeY6TiIDJGnK7Ar7rs00kW+VtWc0qLLNBR62tFbsoxGE5
 SeWOlAk0JJlqHmYWsCzGxsglMFeh2J1hvysKpFlJMv5Hg0GF5X1leP28iYsT/WYqcvNv
 MYHjoS95xBVg4QUxhLziL2verbN5+JtH8pDF/xlRmknaAEocm6NI9/NFspr5iCkW+jzd
 50iw==
X-Gm-Message-State: AOJu0YzU76pE5rG2ZDPMvuAkB4LHrKi2+64ZPNfCnL4BgKH62GfyOzcx
 DoL1iOZ6LgTrF7Cs8l07Z1DvPCoDWgJGOg==
X-Google-Smtp-Source: AGHT+IGIKu09IXYG9zxhBUyRfAw6c4xb0gNjLrPgiiQtrNC8Xl4T7BHkRqaTYe2B37AE6tWJk+O4RQ==
X-Received: by 2002:a05:6300:8082:b0:199:a725:9b59 with SMTP id
 ap2-20020a056300808200b00199a7259b59mr1910515pzc.114.1705103903801; 
 Fri, 12 Jan 2024 15:58:23 -0800 (PST)
Received: from [192.168.50.117] (c-24-5-188-125.hsd1.ca.comcast.net.
 [24.5.188.125]) by smtp.gmail.com with ESMTPSA id
 f13-20020a056a000b0d00b006db07575334sm3714422pfu.59.2024.01.12.15.58.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 15:58:23 -0800 (PST)
Message-ID: <c941d676-716c-4d2f-8961-67633b2fd51c@rivosinc.com>
Date: Fri, 12 Jan 2024 15:58:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/21] linux-user/riscv: Add vdso
Content-Language: en-US
From: Vineet Gupta <vineetg@rivosinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Edwin Lu <ewlu@rivosinc.com>, gnu-toolchain <gnu-toolchain@rivosinc.com>,
 Palmer Dabbelt <palmer@rivosinc.com>
References: <20231030211727.165090-1-richard.henderson@linaro.org>
 <20231030211727.165090-16-richard.henderson@linaro.org>
 <d5265d3a-7df7-4f93-93c4-a5d3a6251372@rivosinc.com>
 <119848b9-0cd7-4d33-bc43-385c86069388@linaro.org>
 <b84e0809-669f-49c9-8163-847485cfe7e4@rivosinc.com>
In-Reply-To: <b84e0809-669f-49c9-8163-847485cfe7e4@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=vineetg@rivosinc.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/12/24 15:37, Vineet Gupta wrote:
> Now if only I could rebuild vdso/qemu with the revert of following and
> the reg size change.
>      2021-07-06 468c1bb5cac9 linux-user/riscv: Add vdso  

And is there  way to debug qemu internals in this regard, like a
developer toggle on steroids or something.
-d in_asm,cpu,exec -dfilter etc show that app is taking different code
path, but not why.

