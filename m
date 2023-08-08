Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E1E774D07
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:27:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTUE8-0007gS-8L; Tue, 08 Aug 2023 17:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTUE4-0007g9-G8
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:26:48 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTUE1-00010K-C1
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:26:47 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-686c06b806cso4206863b3a.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691530004; x=1692134804;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2nZWyCsAFQI+GQW917C5QGLSE5CJ/znR9yNSkfzxAlI=;
 b=StKTcP+fmo5H3OO0SryBlf5pUrIc4ywSeVXAjt77Fqj4hAWWPfusFZCxctRYF11lcL
 u5B6Yktu1UxH71yhdzZ2EMvmFPgplqJGXuyK1YgqQfjlfbam0bk+cQxcSnTkbMwIhwy8
 T+73iyHvJFrBQWkIJeGy9dqkS7Pa0tD0eEoeg0zAgUwTXcxoE3oDlwaDa1oa9CITL6jZ
 ZVB4rKQCuEYr2ZhWYtHJwAG2OjgHJ7IR5dc4K0yJM/6V3hQC0uRKpGNOBQQHXh4P/SwP
 8Pln8GvHC2nwAF4xQn6+Wx1/1iat+BTyKEpQlJNsKFrYme8qD/z3o+7TZMuqzzvPXXL4
 22Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691530004; x=1692134804;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2nZWyCsAFQI+GQW917C5QGLSE5CJ/znR9yNSkfzxAlI=;
 b=Q/8opryo8h4tRSArJvhHSjfbWjoUZt8rhoVc5XeWZd02BPzkC3n96J9tKbsr73FUhc
 AYH11tPft3lXaedqLN58RmzUpe8Ks4Du8ChFnAUtdMPWZoIv3rhIcQ2IlA0Va//C3C5i
 G78dO3WBE+s6oYJppIZ+Go6087XcFBZfnoBHWHj1jr9IVE1Ph6/NfLHXfyH7ZqJAP8nL
 tyYcmgbMSA09GaPjLsezU1FsNXNHLbS5K0sWYJntT7vnsSawuo0RUmZQfiTOGLsW/d3s
 reftz/+N9nCgAujlAj2AX/0xXHjZphTHvL1kZvGEQAS97mna2WHbfXe49O0aKT0gKjK3
 Q23g==
X-Gm-Message-State: AOJu0YyfTWaaCy9Z0IEOiZzbcBWIYMrysir1AmiCdrR+U4EZHIHsRNcw
 qE+Dby1/xDqmJC1pQNNJdlKIMw==
X-Google-Smtp-Source: AGHT+IG9ZjJLMp9GTMfk4wvmLVwXwzDhlgatLUVdhGHJcfYOWPgHw8WnD2lD2VtvXqlO79I0cJCntQ==
X-Received: by 2002:a05:6a21:27a7:b0:137:a9d7:de12 with SMTP id
 rn39-20020a056a2127a700b00137a9d7de12mr633719pzb.59.1691530003893; 
 Tue, 08 Aug 2023 14:26:43 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 a12-20020a62bd0c000000b00686e00313easm8548641pff.157.2023.08.08.14.26.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 14:26:43 -0700 (PDT)
Message-ID: <2c787602-ba70-3607-aaf0-fd3db6857c1b@linaro.org>
Date: Tue, 8 Aug 2023 14:26:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 10/33] Add struct target_freebsd_fhandle and fcntl flags
 to bsd-user/syscall_defs.h
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-11-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808060815.9001-11-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 8/7/23 23:07, Karim Taha wrote:
> +struct target_freebsd_fid {
> +    u_short     fid_len;            /* len of data in bytes */
> +    u_short     fid_data0;          /* force longword align */
> +    char        fid_data[TARGET_MAXFIDSZ];  /* data (variable len) */

uint16_t?

Otherwise,
Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

