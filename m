Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D67980424E
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 00:04:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAHxm-0007q6-P0; Mon, 04 Dec 2023 18:02:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rAHxk-0007pj-8t
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 18:02:52 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rAHxh-00031M-PC
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 18:02:52 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-58d98188dc0so3073595eaf.3
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 15:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701730968; x=1702335768; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pkqcBhd3l0VbuwsyaXQGzFypfyhcFF8nz+R8dQFUITI=;
 b=GsoSl4sYlyxLT0b/FNZ57HkwFvVSQJpqgJLTX+8kB1MT243afN/RYA+oCBli0fvYv8
 AXqiYarv5sat4nvPcvIq//OT9yP9RHS8bjO/dxdF5MggJgmkULlQAmZ6ceVBZjUELu1v
 5WRwtwzT1wEUcUU6usqRzbto1azoYDa/vXa3VzJhBm0AKKtYosGfDLWGqFAooI92YMP4
 baAJ2hfB0Bt2u76VPrn63uG48MZumzsdnLYrtS8P5oXWFGAQZtZ5Xuq+5XC5OZQpUzaF
 Oe1h6qM/+BBZSaJOny1mydQePSRuiO+1bcMmQj+rcwX72nYgenSIKfuCQf6RNKIewxmu
 XdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701730968; x=1702335768;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pkqcBhd3l0VbuwsyaXQGzFypfyhcFF8nz+R8dQFUITI=;
 b=jOo5KVm1Ud65A6FrV977iCb2Fr8yaF1IB/3ZmGoV1hUmDxs3apH4Gj/vm9iPREz0nk
 pt/r/V5dKP6pm02guXnaZCtgJMKNb2+7WO1ZNSXcsCkZA7p7+W6Xr589VvdsAjqmsMMG
 3WjEL8PXNt0LGwC4ezmSsyVBob3re2ckI6osPj5ZUjjblCMIUFUsWqCmx/HSwRJca2Ak
 1d9kncvuKL5Y8qmhLTizq/ZzgjB2EZVNiJNT67Wd6cDzpxhYuYX7D0/x6GmcIti0u5ag
 4K961Fe/aT+nrhZocK1FUC0z5Cp2iRB967v06SVQcqSOvQpafrGsSKQTj9NdsgMiemBi
 JTUg==
X-Gm-Message-State: AOJu0YxM5uI0YmMcOkypDUhAc8WKv8zXrJ2EVDr+/0AQcKmpRGi9vwSz
 vjTdDnuM9jlI3Bpt7LuJe/HAsQ==
X-Google-Smtp-Source: AGHT+IG5umE+2uxpOA0u87boCTw5Fe7XyMSn+ijMyHDVv/41mLQTc3gV47IbRqs6TFordXwC8S2WiA==
X-Received: by 2002:a05:6358:7f0a:b0:16b:fcd3:a3ed with SMTP id
 p10-20020a0563587f0a00b0016bfcd3a3edmr7132737rwn.24.1701730967855; 
 Mon, 04 Dec 2023 15:02:47 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 bm9-20020a656e89000000b0058988954686sm6939335pgb.90.2023.12.04.15.02.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Dec 2023 15:02:47 -0800 (PST)
Message-ID: <caa90c99-aada-467b-a005-84642cd55a86@linaro.org>
Date: Mon, 4 Dec 2023 15:02:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-8.2?] accel/tcg: Implement tcg_unregister_thread()
Content-Language: en-US
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20231204194039.56169-1-philmd@linaro.org>
 <CAJSP0QUjZQQCk+VSJyxLq2jzuK=nxXDCiBn-r4dVzNPOCgH67w@mail.gmail.com>
 <20231204200937.GA9696@kitsune.suse.cz>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231204200937.GA9696@kitsune.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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

On 12/4/23 12:09, Michal Suchánek wrote:
> On Mon, Dec 04, 2023 at 02:50:17PM -0500, Stefan Hajnoczi wrote:
>> On Mon, 4 Dec 2023 at 14:40, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>> +void tcg_unregister_thread(void)
>>> +{
>>> +    unsigned int n;
>>> +
>>> +    n = qatomic_fetch_dec(&tcg_cur_ctxs);
>>> +    g_free(tcg_ctxs[n]);
>>> +    qatomic_set(&tcg_ctxs[n], NULL);
>>> +}
>>
>> tcg_ctxs[n] may not be our context, so this looks like it could free
>> another thread's context and lead to undefined behavior.

Correct.

> There is cpu->thread_id so perhaps cpu->thread_ctx could be added as
> well. That would require a bitmap of used threads contexts rather than a
> counter, though.

Or don't free the context at all, but re-use it when incrementing and tcg_ctxs[n] != null 
(i.e. plugging in a repacement vcpu).  After all, there can only be tcg_max_ctxs contexts.


r~


