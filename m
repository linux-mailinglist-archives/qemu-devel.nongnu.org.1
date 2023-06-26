Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B760B73D911
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:03:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhBS-0003qx-7A; Mon, 26 Jun 2023 04:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDhBO-0003q5-WB
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:02:47 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDhBM-0006OE-Js
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:02:46 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fa93d61d48so9849285e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 01:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687766559; x=1690358559;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BBsywvgrie/RYW0fnLWguUN0R4taO5ncR8t93HmWJnQ=;
 b=safoOg1VdJCEByWRGqW65xUXEZ5wRO42ez2h7f64zlRecY9r1ey0gCUB7Yssdej1AO
 bKC0eQ/i2crbep/MmIvE82zknm+6gk5aDNVRbduzoZH1bR64r9McDHb+drk8T86l5XIl
 nDhYiYwC6CZfQJtsUhQhgwlEv62XMKHajHRKs8lMdZ4F2ebB4C9tUYMf5QLwKEgbYyTJ
 5fzfYWZtW5pGT/tJplMp82AcsH6Wwm5ZyyaPpi8UqoO4jUEQ4AQbcFtbUDf+WdTb2SEN
 EiozcPhLKZyDjyIw5i/skXfRGhZ2MmmF51SO8x/nX46O9j2gLuwGtcnCU/gySJgkAeDa
 Uvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687766559; x=1690358559;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BBsywvgrie/RYW0fnLWguUN0R4taO5ncR8t93HmWJnQ=;
 b=XOvXtFznWF4zFOAnVO3MUd+HiPgz6FGgoAb8WfjAkrzfdYljMQWb83mqI61N9qcs46
 OX9r1Mw/5+RnmHjmThiUCRVMb08sJ/fMqAKUXeLX6njkRkpy4+9kmWulqe+Nl3LBho3I
 +VI2wyYtLrOpRM/6QahfdG+HofgJ0kiWXIJacvl+8n//VNskZzVVkGv9GtQDwS5lH4FT
 mwCym8fz+J96wl9SPTQRUzYArcZlHlrlrHeBETlyIAcq2HqkAxWBKAS8OsL10jTj+6zj
 5c8c3gVh+Kx7XD9l0QsNl/PLVszH9OIMDrsJDIq759g97wyE0hCDzsA7n+YHBtCTl5i2
 epag==
X-Gm-Message-State: AC+VfDxz7op1vK/XrfH6g7q41nnk27uRGt0UYKy0JlY4owQZnhLNiRZF
 r1b+2ebX8XgOrkIH6hqDDO7bU4oilfUB5WfVWCQd2Lft
X-Google-Smtp-Source: ACHHUZ4PxHJhBmCliVOp/tUPQyRpeQuDRAAROS1+2QD/qFFrnjpFwlVKuKGyuAoVofQVBsLmL01ziw==
X-Received: by 2002:a05:600c:219:b0:3fa:8956:22c7 with SMTP id
 25-20020a05600c021900b003fa895622c7mr3090277wmi.33.1687766559577; 
 Mon, 26 Jun 2023 01:02:39 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a1c7708000000b003f50d6ee334sm6745305wmi.47.2023.06.26.01.02.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 01:02:39 -0700 (PDT)
Message-ID: <cb5b1b8b-12a0-cd5b-4c90-a525e488f815@linaro.org>
Date: Mon, 26 Jun 2023 10:02:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 08/26] scripts/oss-fuzz: add a suppression for keymap
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
 <20230623122100.1640995-9-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230623122100.1640995-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/23/23 14:20, Alex Bennée wrote:
> When updating to the latest fedora the santizer found more leaks
> inside xkbmap:
> 
>    FAILED: pc-bios/keymaps/ar
>    /builds/stsquad/qemu/build-oss-fuzz/qemu-keymap -f pc-bios/keymaps/ar -l ara
>    =================================================================
>    ==3604==ERROR: LeakSanitizer: detected memory leaks
>    Direct leak of 1424 byte(s) in 1 object(s) allocated from:
>        #0 0x56316418ebec in __interceptor_calloc (/builds/stsquad/qemu/build-oss-fuzz/qemu-keymap+0x127bec) (BuildId: a2ad9da3190962acaa010fa8f44a9269f9081e1c)
>        #1 0x7f60d4dc067e  (/lib64/libxkbcommon.so.0+0x1c67e) (BuildId: b243a34e4e58e6a30b93771c256268b114d34b80)
>        #2 0x7f60d4dc2137 in xkb_keymap_new_from_names (/lib64/libxkbcommon.so.0+0x1e137) (BuildId: b243a34e4e58e6a30b93771c256268b114d34b80)
>        #3 0x5631641ca50f in main /builds/stsquad/qemu/build-oss-fuzz/../qemu-keymap.c:215:11
> 
> and many more. As we can't do anything about the library add a
> suppression to keep the CI going with what its meant to be doing.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   scripts/oss-fuzz/lsan_suppressions.txt | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

