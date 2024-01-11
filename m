Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF9D82B6F9
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 23:08:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO3Dn-0005Bn-7j; Thu, 11 Jan 2024 17:08:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rO3Dk-0005Bb-Hb
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 17:08:16 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rO3Di-0006Gb-7j
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 17:08:16 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5cde7afa1d7so3030835a12.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 14:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705010892; x=1705615692; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0fkwGfTMqBGrK6cEyauhdcgQexwYrrKqr4+stcldH5o=;
 b=FnBANPjL225MbSBiwXAzOAoHurIOSg4MXZOTCgjH41z842terl7cUN4zBp9rQBfkHt
 ikM7MXI0b6F8RMyheKnRVX4xYZR22TOprW7ItbiVTHyIUPyNM1NMkW415b5beLanxJQZ
 qmtRWNzI3+BaXYx2M9aziABxVYZkY9Mm/EPt2GZT5zlc4a0Xfi73bWMkpCmmi671zAsV
 y6H/wBuPn0dfbYAgmZjqX3bfLysIsTMAeZj74aJr0OE3ENIVAEelBuVo6QyvPr1H5+8v
 u5+0owFo8fDn/UvGxNK7vQWnU/tDdqaBIIwr51WI3vpnv1g8joAtSQqavME8EVnbAmTf
 ucag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705010892; x=1705615692;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0fkwGfTMqBGrK6cEyauhdcgQexwYrrKqr4+stcldH5o=;
 b=M/M13LgUIAlaAzLFFcSQ9b+Z6Q42tQ8yBsYFvlrsiXlg4pYnTatyBkeWiGsTPow9lA
 y/GTA5/IQFZp2o3Crszt9qSOhEKWKMsObTKgZUcgF9cuB8auV9zk3rxa8ytXJ8j2vxIn
 6+akbIueyUXXjRlc6ZkmDCOUD7rQolp8g4v/T9111YclCLmXgAxfwQYGbTG5qOlq8SUc
 OcWpw89jub/T5JCruNLig5Z5PvmZ08PVzDLomsqZfWddvWSNj8JcMVfDzf1S2+SAotxY
 zHVnckF5MblBVvyl9d4smyis3KWqWJg8DvrdRO7Cr8S4GULyWpB1I1LiZUNCUCF0dIAH
 O9uw==
X-Gm-Message-State: AOJu0Yzf0AuXi6qWIuXz/Pu3ks5n4VDQBRvqVFfryZmObVvTesh6oiuW
 UE+e1JXyaV5t0V+VOix8UtTNQBXslijtcQ==
X-Google-Smtp-Source: AGHT+IGcXSP1VsCHqYoC3+szQ+8899pU5KFQlmJFbVowfwPidET0wdrBi7jzwTjCPjlpseIrXFoikQ==
X-Received: by 2002:a05:6a20:160d:b0:19a:3646:2da7 with SMTP id
 l13-20020a056a20160d00b0019a36462da7mr47426pzj.50.1705010892492; 
 Thu, 11 Jan 2024 14:08:12 -0800 (PST)
Received: from [192.168.5.64] (ericne.lnk.telstra.net. [203.45.18.161])
 by smtp.gmail.com with ESMTPSA id
 z17-20020aa78891000000b006d9b4eda6b0sm1689504pfe.157.2024.01.11.14.08.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 14:08:12 -0800 (PST)
Message-ID: <083f8794-fbd7-4568-90e2-ba2a92f69cd8@linaro.org>
Date: Fri, 12 Jan 2024 09:08:06 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] plugins: add inline operation per vcpu
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
 <20240111142326.1743444-3-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240111142326.1743444-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 1/12/24 01:23, Pierrick Bouvier wrote:
> Extends API with three new functions:
> qemu_plugin_register_vcpu_{tb, insn, mem}_exec_inline_per_vcpu().
> 
> Compared to non per_vcpu versions, ptr is now a base, and current
> cpu_index and an offset are used to compute memory location on which
> operation happens (ptr + cpu_index * offset).
> 
> This allows to have a thread-safe version of inline operations.
> 
> Having a flexible offset is useful in case a user wants to target a
> memory location embedded into a struct. In this case, the offset between
> two memory locations will be bigger than sizeof(uint64_t).
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/qemu/qemu-plugin.h   | 56 +++++++++++++++++++++++++++++++++++-
>   plugins/api.c                | 36 ++++++++++++++++++++---
>   plugins/qemu-plugins.symbols |  3 ++
>   3 files changed, 90 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

