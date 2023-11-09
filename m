Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B387E750F
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 00:17:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1EH9-0005Mg-3X; Thu, 09 Nov 2023 18:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1EH7-0005MR-Ti
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 18:17:25 -0500
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1EH6-0006gU-B8
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 18:17:25 -0500
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-677a0ac3797so559446d6.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 15:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699571843; x=1700176643; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x/zvy6M0WjzpIt4ulLJW5qm9XjQDmYpFtH6bXpIfrfU=;
 b=i/wtBQEmLc2fuZFkFxx3Hron9sX3CJ6rBbOmkoN8+SFUU/EHS2WDrClwQwwfQ9IF4p
 Se+/tlzFvzCEAwN5nJ10gC73Yw+2xQ8MtbL1DY7oowvbohHwf3/4mhVmWGs8ZJPrcC/0
 NMnLf3yIHiiEIC+K8fWl/da+54cjAz/rHXpS1Is+3y6a0TbRLHRmHyussYqoLMBjgpiW
 9y7CWyDZhv2YO8aUEpmE+0Ossb82jycnl/WwEig/BcblhHhWeVecDJhli7hCyg1ALd2p
 /Nz1lIANYzAiP3Bm56v38ledfr77JOBKFS2Xaq6b56OlHjEI08IhefeeXtQTZL26rPt2
 u4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699571843; x=1700176643;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x/zvy6M0WjzpIt4ulLJW5qm9XjQDmYpFtH6bXpIfrfU=;
 b=okD0VEJ5NnkAQTvcK9bbsCuxtVlqI/q8EPspLL9j2xID0siv0ntZe+TpLhMY9r8O6l
 P9rphHONlOrU87LPuTomnrV1EMpSkmYVXw6nfAzdBPNitscnEr0FgolZLu4c9wcgqS1E
 N+U02+ntb/Esx6lb6YT6Ud7WB1d8HMIdWkakusLwadl5JKMFa7/+3TprORfyVthyrX3p
 im/sq+mDnycJVHX1yez6eSgVrc2zqz/6UPgi9m9PHx3JIlgWQp40107DAYx78htW+OCr
 yvvZDGfgKMSH5qlPKBm7ey9lHO2T2roLImWgBjFdxav2B0kadjvXOhJ6JXQyiJCkl46R
 8cIw==
X-Gm-Message-State: AOJu0YzKsGLbUKHvLPhE6izlNz317Iv3vv5nieGeqRUwu1tiCAxMUSiR
 oI5iOViwVdK9LY6oXJcXmpvTCw==
X-Google-Smtp-Source: AGHT+IHgmW17V9aPFKhVe1o6zEMnv2hLFCHua3PwIFEeeQIPtE3qdHbAvt56PpgSs+IwXoW5aJUBsA==
X-Received: by 2002:a05:6214:20c5:b0:674:b63c:a67d with SMTP id
 5-20020a05621420c500b00674b63ca67dmr8386524qve.58.1699571843306; 
 Thu, 09 Nov 2023 15:17:23 -0800 (PST)
Received: from ?IPV6:2607:fb91:1ee6:29b:6626:64c4:1b48:c565?
 ([2607:fb91:1ee6:29b:6626:64c4:1b48:c565])
 by smtp.gmail.com with ESMTPSA id
 v2-20020a05620a122200b00767e2668536sm279431qkj.17.2023.11.09.15.17.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 15:17:22 -0800 (PST)
Message-ID: <e499f176-d882-4727-8caf-268d72e06606@linaro.org>
Date: Thu, 9 Nov 2023 15:17:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2 v4 04/10] hw/char/pl011: Extract
 pl011_write_txdata() from pl011_write()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>, qemu-arm@nongnu.org
References: <20231109192814.95977-1-philmd@linaro.org>
 <20231109192814.95977-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231109192814.95977-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2c.google.com
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

On 11/9/23 11:28, Philippe Mathieu-Daudé wrote:
> When implementing FIFO, this code will become more complex.
> Start by factoring it out to a new pl011_write_txdata() function.
> No functional change intended.

...
> @@ -262,19 +273,13 @@ static void pl011_write(void *opaque, hwaddr offset,
>                           uint64_t value, unsigned size)
>   {
>       PL011State *s = (PL011State *)opaque;
> -    unsigned char ch;
>   
>       trace_pl011_write(offset, value, pl011_regname(offset));
>   
>       switch (offset >> 2) {
>       case 0: /* UARTDR */
> -        /* ??? Check if transmitter is enabled.  */
> -        ch = value;
> -        /* XXX this blocks entire thread. Rewrite to use
> -         * qemu_chr_fe_write and background I/O callbacks */
> -        qemu_chr_fe_write_all(&s->chr, &ch, 1);
> -        s->int_level |= INT_TX;
> -        pl011_update(s);
> +        s->readbuff = value;

Why the write to readbuff?


r~

