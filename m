Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4098312F0
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:04:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQMQx-0002VX-8J; Thu, 18 Jan 2024 02:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rQMQn-0002NW-S4
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 02:03:19 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rQMQk-0003wc-Jl
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 02:03:16 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d70c150632so631505ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 23:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705561393; x=1706166193; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+P1igeA2v7zWxAzona+4enOvU4/4WDU0nsOhQfkdXJw=;
 b=L3ewrbp7K6ElRCa5S4v/6vRHpKLXjetvtSMC0neM3q2E+mhg7+WNg+nxMlw+7W0Uge
 +RPJgWptff1mO5cIvu6kZvgF/FSJr25GxwZUxhTsQI9DusChojNJlUJT3Duh6eIMJbxS
 AOPsnyRHX5o16qkznUgoaQx28kDZ2BYxmKi1of3p6+jRkXleIDBs7Y6IjEaDcBgVtGsz
 x6+4/nR7WRbHeQIsmnazUXB2Tje7QqoCVs2DEU9OLLCkWxZr51CfTWHh4USEPzI3Bh6N
 sfhIia+yrIj44uVuMyFk8KV7048luGmNdKQ0mUbrwrt9TLLuJkD/+/98pv6iE1xvw7jf
 jN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705561393; x=1706166193;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+P1igeA2v7zWxAzona+4enOvU4/4WDU0nsOhQfkdXJw=;
 b=DZgDu06oFqYhkvXM7Dyw6G+VG0pMv5Wpvowq1G4WGWg9YiQml1W/D+voqsnPzv6yhG
 raeZQCStuHtjEy830l3ZZlpBDa07Qk3ZzQGUwpof10X9vA1l7j7MCxn3JSyPwDeYl52C
 V6gGHLdcRrGA1fidSIgb/dN7wsnJhMsVCVEPuc/NaiU05aduWyAH1Y0yi7V7SXJWhqbS
 p6HF3yVcyoZ7faHKQGi4N0DZAU93aJKVOwcpORgrhLUk0qsEP4SSbH7S3+XNO/SMMQdo
 /ZxZWoUMbaSNxLI1p5eYVrplTtWc1knGw6k46zVo8i7tC4L7K8UgIMxZNA6JrQndwSu2
 l/pg==
X-Gm-Message-State: AOJu0YwN91MlSuMGAW078R77OxWjwTBa8BxFuGKrya1Zgw6LyHnhhtyd
 kdmiGbsu4DtIReH39aBlvGlLQURoElXSbDL06nNyyLGfScCvJUX9vGa0SJYor/I=
X-Google-Smtp-Source: AGHT+IE7cdPaZF7IoiBGW9S/EWqbqbTYkwZKkROmctM1L5P7mRG9mJrUmVt2+Um4a3qOUsn1CA4Kxg==
X-Received: by 2002:a17:902:7204:b0:1d5:f577:723d with SMTP id
 ba4-20020a170902720400b001d5f577723dmr468939plb.31.1705561392970; 
 Wed, 17 Jan 2024 23:03:12 -0800 (PST)
Received: from [192.168.1.13] ([43.252.112.244])
 by smtp.gmail.com with ESMTPSA id
 j17-20020a170902f25100b001d70e83f9c3sm110669plc.242.2024.01.17.23.03.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 23:03:12 -0800 (PST)
Message-ID: <7776adfe-d9be-4606-9696-a90ebfbf4999@linaro.org>
Date: Thu, 18 Jan 2024 18:03:07 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tcg/s390x: Fix chacha20-s390
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, thuth@redhat.com, david@redhat.com,
 philmd@linaro.org
References: <20240117213646.159697-1-richard.henderson@linaro.org>
 <8ec9eefe-024c-4bef-9f2a-4bd094feaa5a@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <8ec9eefe-024c-4bef-9f2a-4bd094feaa5a@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/18/24 17:07, Michael Tokarev wrote:
> Why the problem didn't occur on non-s390x *host*?  As I noted in my initial
> email, the testcase worked on amd64 host but not on s390x host..

Because the error was in the s390x host tcg backend.


r~


