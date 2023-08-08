Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76037773BDB
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 17:56:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTP4V-0003po-Fj; Tue, 08 Aug 2023 11:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTP4T-0003lx-4u
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:56:33 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTP4R-0004Cn-KD
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:56:32 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-686be28e1a8so4120344b3a.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 08:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691510190; x=1692114990;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ve910R+/xVZ+Bmy/qjiUfCQe9wKcmTpfD2AdWGDMg9Y=;
 b=L3sU3XKGbnvGY2DbBFEbGgfWYpGBZSPHnKB7nhe62QnCSpTlNgYbkaKQlR/PVinrHn
 Uh/EvAz3c1OKJ1e/C7ZhlKmLkdbU4zTaPKSo7LmA/e6AmFM4dUVRve2CDv08tUeXVFoc
 Wzd6BuTI7YRFt0jzrmm4yBL38P+VeJ+WTHilHKA7UlVdpie1tJ6m9NKzZ4maUyntIGqt
 R+6oMJq2vyvhUcAfCPqF+A8LDKZ/btWvqnJ2ck7fThDCn3dHWEWRWKwbx2lNYIhabQP8
 U1THsdoARZ+hNWhyjKtCsldtyEWUszW00KOuVgvnBFc9y4s8Tg525nO93D+51dfVSlfA
 N/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691510190; x=1692114990;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ve910R+/xVZ+Bmy/qjiUfCQe9wKcmTpfD2AdWGDMg9Y=;
 b=d1Hrd6ytYdAUEmLKiL1Bz0ljiAaKSy0zWzhfupU58nfdZhCiGDTS2pg8x7tGsl7/pz
 +U4AZgT/uxkmgH3l0Vt1UNhU87EOzzY1/5eaef3++OkrphERzwqSuYJ8bP7+kYuLOosI
 zU+9wKBN4WgULozohGLRZUJtzHj5rjOSpzhF2yiEz++IvEv4EvO8kZNprbdTklSwg80r
 jtajLccg937b0MKBg+bCEtZF8h2kGzkyDewxe40bIqeCv/inSGJZ5UYqs6AF6Hsd9Vrv
 o4UyioiR5hkzsCj1G9wp2iXi6EDNGyTI5IAO0XFNS4AYfsJQat4fgQ03PFYAnxe2wBm0
 weEA==
X-Gm-Message-State: AOJu0YzVcPVjhAXAe/wy3fjfSNEReR5Q+pSg44MTQjXLBGLQ9GmJq6d5
 1nmg+HQWKnfL9ksgQhXgl7DpEA==
X-Google-Smtp-Source: AGHT+IEmsg5WNZ2f8Ag+vUr+nqbgFAsjE162egygBx38qDPePHXWKvqzKoirTmQPclTbHK5lUZDYoA==
X-Received: by 2002:a05:6a00:2d8c:b0:687:1a86:7a78 with SMTP id
 fb12-20020a056a002d8c00b006871a867a78mr12511051pfb.9.1691510189885; 
 Tue, 08 Aug 2023 08:56:29 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a62ee10000000b00686f0133b49sm8230709pfi.63.2023.08.08.08.56.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 08:56:29 -0700 (PDT)
Message-ID: <90019c4e-72bf-806d-2fc6-9065b4e99852@linaro.org>
Date: Tue, 8 Aug 2023 08:56:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1 v10 08/14] linux-user: Do not adjust zero_bss for
 host page size
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu, deller@gmx.de, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org
References: <20230807163705.9848-1-richard.henderson@linaro.org>
 <20230807163705.9848-9-richard.henderson@linaro.org>
 <877cq5932a.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <877cq5932a.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 8/8/23 04:38, Alex Bennée wrote:
>> -    if (host_start < host_map_start) {
>> -        memset((void *)host_start, 0, host_map_start - host_start);
>> +    if (align_bss < end_bss) {
>> +        abi_long err = target_mmap(align_bss, end_bss - align_bss, prot,
>> +                                   MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS,
>> +                                   -1, 0);
>> +        if (err == -1) {
>> +            perror("cannot mmap brk");
>> +            exit(-1);
> 
> brk != bss even if brk generally comes after the bss section.

I've removed this error report entirely, returning failure to the caller, which will then 
handle it like any other mmap failure of the image.


r~


