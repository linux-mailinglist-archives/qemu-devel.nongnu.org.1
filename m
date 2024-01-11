Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F1582B6D4
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 22:50:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO2vL-0005Jn-VX; Thu, 11 Jan 2024 16:49:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rO2v2-0005JI-TC
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 16:48:57 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rO2v1-0005cE-Eu
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 16:48:56 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5c229dabbb6so2281025a12.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 13:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705009733; x=1705614533; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UERmyTvgZ8jaqHQonVa3zRHYJNHfBGBf0VLvg3GLZxA=;
 b=Fh++xPHQpOhMtr/CQ1fOGdoNJK5ceboOz/2F7VEfD5BhMjTxVU1iW8FVZ3Cqe6Tuhl
 Rdq2x1/sIMCgOT8tzd7Htzbcxg69I0t0yB+X9Q4VYlbW66uPoOnx/cxc8xeKeAl+ZyPs
 bEQ/JK394bwlBLi44TtuBG9BtoYDs9AZ9h1knNBt6s8zOggwUmaZm1ZkhMJXLXkoFsGZ
 ti/TIu4kKFSN3jtwJZ3tD3bfwC9jVJnX0IWBl/xlMRLdRKFisvdg66Q7FIbb08B1D+el
 L6evFl2YgVsx+bloXLSGKAWQOiGZdkNi7xDzcV1KzcX3pWjP5Ze5Q2ZBysIxicBmkiej
 //OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705009733; x=1705614533;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UERmyTvgZ8jaqHQonVa3zRHYJNHfBGBf0VLvg3GLZxA=;
 b=AQvc5wgg1p/+MpVONqY2ArT0F+eH/Q2wrH2FWkWVeDq9F2tZUneDzynsFaCqPg4TdR
 6CdUtUvbkxEwPcE1XNI0o9O9uCscZ9GD0bFP/nqpHi9n3wMDYtaxk6Uhe6hGzlSvFsjb
 gTKIzYq0M8aD1fRVI2w8xj0lJ1UVhhd4la1Yf7yG15NUz+lqVVsAXg1evwBuqwTDAUZI
 UdOD0vb45T34/ULk2cZYJsNUzu2NCH800+AFQ6/GkEsIL7zKX6gS0Eu6IPSgdqsCjdVI
 XjXrZkDL5tubb8AitEveAJ87nz4ONEHpd1jzmBCSjQcrz/U3WqGLzdzUvYAfNhYFjbWv
 NCCg==
X-Gm-Message-State: AOJu0YwrwBRzaJhJqNhraqXgNu57asJPcMq+9HmkTCvhNdlQ9NnATKdb
 W6z9sBKsEfKIBNNGx7KLNxI/ZzrB9JLR/CzRG0RWL/BpXMtuPA==
X-Google-Smtp-Source: AGHT+IG2c3WZurvRTSnQQlmLErOBoSlK3aHrB35WLH3Ecu96/YwjeMARUTmNU/aa/RhbXKXQYGT5kg==
X-Received: by 2002:a17:90a:6f85:b0:28d:f3a1:dc25 with SMTP id
 e5-20020a17090a6f8500b0028df3a1dc25mr414824pjk.25.1705009733130; 
 Thu, 11 Jan 2024 13:48:53 -0800 (PST)
Received: from [192.168.5.64] (ericne.lnk.telstra.net. [203.45.18.161])
 by smtp.gmail.com with ESMTPSA id
 oh15-20020a17090b3a4f00b0028c1a5aafe5sm4336284pjb.14.2024.01.11.13.48.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 13:48:52 -0800 (PST)
Message-ID: <88a60a9a-e678-4bb4-b8c3-bafae3d1d09e@linaro.org>
Date: Fri, 12 Jan 2024 08:48:47 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpus: Restrict 'start-powered-off' property to system
 emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20240111161817.43150-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240111161817.43150-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 1/12/24 03:18, Philippe Mathieu-Daudé wrote:
> Since the CPUState::start-powered-off property is irrelevant
> to user emulation, restrict it to system emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   cpu-target.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

