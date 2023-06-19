Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E049734BF5
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 08:56:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB8oJ-00011c-0y; Mon, 19 Jun 2023 02:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB8nx-0000fb-4S
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 02:56:07 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB8nt-0003Gh-FW
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 02:56:00 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9829b12b80fso487181766b.2
 for <qemu-devel@nongnu.org>; Sun, 18 Jun 2023 23:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687157755; x=1689749755;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TpSg8e/eKDUqeKruCbgMujSFK3lOba2d/KBtH+rYPw8=;
 b=vkdX7MCG1iGAojKVz2DvtymMQ5NiukDxsNEKCSC6aVmEs6i95R0vpQ4NZrg+OMvwlG
 Qb5zMkIS/jRYydqDD9AquU5ih4VIT0LOOhPvdS7Lq1TdzQgAZg+ejexAQJGDyDayNkN8
 YO0GhmYQUWFLNMVM1EBQWwLMEpFIhikbDb4bCLKdwrSlwbrrLq6vtPBIMElxmgNAUm6t
 ATOyevsc5EDlEL80Dw4aGhUmOt9exmFIHVKdSEtqw/EiSklmQwb4FX02hUlyjCUg43Fd
 /luM5OxQRBA38wn81Fqe6hY0Evtun1pnODXtG+Nxae3lgBFVg3J5+NbWgv9KlGXrK5wa
 9bjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687157755; x=1689749755;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TpSg8e/eKDUqeKruCbgMujSFK3lOba2d/KBtH+rYPw8=;
 b=Z41xzgYUWoX3DwJm/tam1ifFYProbIgBH3+lzKKxrjB1B40MxW/Q72nIuAXBj03X5a
 pooF32N3rwGsjwI1PyvArVmSGIltQ1mIguSbH0CBrFmH355IP+Pd3n4hx98ApswvER6T
 nk4RLQn6Rnm4IDR08D3j025kTYrB85TVEF2RvdMcrrVKWXq+Ni97QwzhKJTX/0xPrcuH
 IUzRuMOU4UV42CKbSk1GTGonRYBJo6GOd1VvIXlzr0wHNxJKgSlH9atJsv7f9lwWvoJS
 0jJFW8fDfU+/xCk0slS+Pi9rAIEAm+nyftVuig0XgoZPTJFW40tAVtvOD0VUvXYjafWH
 TVMw==
X-Gm-Message-State: AC+VfDzSxSC2ZaJtjHHUjmuUCOaIPssbKRiL3CV4moY7Aqe96pwykJEe
 vLHjt7BPhgSAO0bp8YC6WQkGO1Cyndvu8FIMWelwBDpN
X-Google-Smtp-Source: ACHHUZ6fo7VO3JSUXdZNfLShxfB83CJIkdUo1t0hpzpZThSP01wT/MEOtVNg2yL58aM9XE6TallZsw==
X-Received: by 2002:a17:907:9603:b0:969:813c:9868 with SMTP id
 gb3-20020a170907960300b00969813c9868mr8312196ejc.18.1687157754979; 
 Sun, 18 Jun 2023 23:55:54 -0700 (PDT)
Received: from [192.168.69.129] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 w18-20020a17090633d200b009875f08c213sm3015429eja.181.2023.06.18.23.55.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jun 2023 23:55:54 -0700 (PDT)
Message-ID: <26c8ff0d-67cc-f6fb-1c02-55bd8ec97d53@linaro.org>
Date: Mon, 19 Jun 2023 08:55:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/6] tests/tcg/cris: Correct the off-by-one error
Content-Language: en-US
To: Bin Meng <bmeng@tinylab.org>, qemu-devel@nongnu.org
Cc: Zhangjin Wu <falcon@tinylab.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20230616152737.23545-1-bmeng@tinylab.org>
 <20230616152737.23545-3-bmeng@tinylab.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230616152737.23545-3-bmeng@tinylab.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/16/23 17:27, Bin Meng wrote:
> sysconf(_SC_OPEN_MAX) returns the maximum number of files that
> a process can have open at any time, which means the fd should
> not be larger than or equal to the return value.
> 
> Signed-off-by: Bin Meng<bmeng@tinylab.org>
> ---
> 
> (no changes since v1)
> 
>   tests/tcg/cris/libc/check_openpf5.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

