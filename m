Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3EE7FF91F
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 19:13:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8lWr-0004Y3-5P; Thu, 30 Nov 2023 13:12:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r8lWd-0004Wz-Am
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 13:12:35 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r8lWb-0007nS-Mo
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 13:12:35 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6d64c1155a8so800904a34.2
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 10:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701367952; x=1701972752; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=laErPs+7gwDDt6UC3cW4toYc3pUJyKOVn3ClprVcDa0=;
 b=g/prb2Z9ujJgv32x0qbmTe9vJt3A+4chXtMZdbhN4OR/rJcFF9ROGGb7X0KaDdzqM0
 zAge2UGv+oNDzoWGYbsgEoBDgvDeAWflpGbAIyXsl0Q6iTWnDidSnBFSKvQFIHoJ+ljw
 mCUgds0NGgAPm7jRw6mrw2YmCxTK/lJHLaygnw0JqVjfbXrlUuFkjUpmuJ3uUUZh0Hi9
 OHiXSddP4hhl8C2S8vWbzKPB+tpv0OYeg2VEsiRcJsMFLxvji1kcGb1gI3O0PGJVnmWD
 yetwzli4G+vqFlt0+01yGx9MOmklY5MRD20D9F5JPLK3wIllvgJ6+KqgRdHR+j0qJaQG
 ZtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701367952; x=1701972752;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=laErPs+7gwDDt6UC3cW4toYc3pUJyKOVn3ClprVcDa0=;
 b=LwlTod+gj/lWFqBRiEsibcZ3TIqCcbqV87SavOny/984Q8W6gOayMr+U8Zblc3ou9s
 p9Oz2noj2fmyI/lKb2RPWaZp9nfRs43LYH+0DkOjl/LLBKZwfMdufwl9q6hGsCVZMo7V
 OP3CG0mYNWp1vhyvZA0FhOExSLM3onIuXsdCaLTAw1JQ8njPvN2ffYk9qoxsTGjcPjrv
 CYtcdzlZPAhpKdxDCfhm8QNT1TjF/gg7CzmRGS9qmFGs/b/kSQxwp9ndvc1m7MsPjUNc
 oTMwb2kBxE9ljGNf2JtDsuk99mzXRo0W/Qf4KW9xQSIvUAQDE1+QilTCZnPRuLtYKxBX
 WfzQ==
X-Gm-Message-State: AOJu0Yz4CmBa+7+OQuGJcV/7ryyFAHjbtjsclYG6IZMRFGvR4QXDdB+v
 XYBffmHVEZnx4kgp2Ylr/6DYfA==
X-Google-Smtp-Source: AGHT+IG3qfTzOLJuknqTQUJA9UvfOAQgVd8UAI0i0D3OZCWlHrYN80gx1YJrOSyUZHa5l6Sx1jBc3A==
X-Received: by 2002:a05:6830:44a4:b0:6b9:dc90:8a85 with SMTP id
 r36-20020a05683044a400b006b9dc908a85mr447956otv.24.1701367952423; 
 Thu, 30 Nov 2023 10:12:32 -0800 (PST)
Received: from ?IPV6:2607:fb90:f2e0:8450:be70:af46:b71a:41bf?
 ([2607:fb90:f2e0:8450:be70:af46:b71a:41bf])
 by smtp.gmail.com with ESMTPSA id
 e24-20020a0568301e5800b006cd09ba046fsm226380otj.61.2023.11.30.10.12.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Nov 2023 10:12:32 -0800 (PST)
Message-ID: <c7f94264-7d05-4532-80c2-74b963134d49@linaro.org>
Date: Thu, 30 Nov 2023 12:12:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/xtensa: use generic instruction breakpoint
 infrastructure
Content-Language: en-US
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20231130171920.3798954-1-jcmvbkbc@gmail.com>
 <20231130171920.3798954-2-jcmvbkbc@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231130171920.3798954-2-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

On 11/30/23 11:19, Max Filippov wrote:
> Don't embed ibreak exception generation into TB and don't invalidate TB
> on ibreak address change. Add CPUBreakpoint pointers to xtensa
> CPUArchState, use cpu_breakpoint_insert/cpu_breakpoint_remove_by_ref to
> manage ibreak breakpoints and provide TCGCPUOps::debug_check_breakpoint
> callback that recognizes valid instruction breakpoints.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>   target/xtensa/cpu.c        |  1 +
>   target/xtensa/cpu.h        |  4 ++++
>   target/xtensa/dbg_helper.c | 46 +++++++++++++++++++++++++-------------
>   target/xtensa/helper.c     | 12 ++++++++++
>   target/xtensa/translate.c  | 17 --------------
>   5 files changed, 47 insertions(+), 33 deletions(-)

Thanks a bunch,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

