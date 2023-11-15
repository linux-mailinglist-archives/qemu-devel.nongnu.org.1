Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE827ED5F4
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 22:23:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3NKU-0006Fi-I7; Wed, 15 Nov 2023 16:21:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r3NKC-00064c-Ap
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 16:21:31 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r3NK8-0005v6-Nh
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 16:21:26 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-53fa455cd94so85607a12.2
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 13:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700083282; x=1700688082; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o/HrsuSmMhTmej1DsWCC7YGHx+DKgYWtN40nLdFXdMU=;
 b=C0MSF6GNTvnNkEWe+5LjxsiGGoQqXTIyKR6wTpwx1XJ9cSKh+SSKV9XN2KUa7R3qrR
 aNfQGMh7WLXz2RKTs1FUxRcoRscH84MCuFi2kucnrjDwdYAgIozfIbk+N6KoW7WLqseQ
 StehE7fIywiflbvC6mujv3+ZqhaXoLXYFPgVViPhpf+0curnqTTRM9cuFS25tCHAonAv
 U1YSeKc9RNJqx/C6L+aPoSHnm/2KYVxIg0DMgN2Honf4XsCoy9eUFHurvmkWHxu/QC0Q
 v0BdO7qNCTEjv9uIjL2/2dzSXoKaGouIdDATmEgeFIcYdFOmbp4eq8roxIbct1IAYTKZ
 ETvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700083282; x=1700688082;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o/HrsuSmMhTmej1DsWCC7YGHx+DKgYWtN40nLdFXdMU=;
 b=Tt7XZxmWkqnBZgpp+TdKbbT+fFOkJBod1+8viAZ7ptIJL9ZrJjmqjN5Rt2ostewwVv
 odJkJTFRv/wi+u5PkX6W0EWEAmp2BT9e4YYCxrAUvos4H0hyZFUkiGiz3cWyfUWuY9AC
 M3yllGiONjMTzG9Tf+dDK933r41OIgPmqFIN5XvU9cDYwj5mTRd7P8h7GGiZ37U+SJ1X
 atmXmm0FM3G6oGNkD+nq6KqsjxgvBtLZA0ZIWn7AEls+dwxVsET+6JTS4g+jK4ryN+FW
 xOM/mZuKDVGap8b890HBYm+/hZd2ylT5BtRcXjXaTuH2D7ApCKZpviF1Ktqo56KTz4BD
 bmAg==
X-Gm-Message-State: AOJu0Yxm5lAhoVdWtoyHvfPDOa2TlJSkTF9RDudoG5IwsiPn01cMegIJ
 pxx5y5seU2xHQITRmIFIGFm8eg==
X-Google-Smtp-Source: AGHT+IEG6qtX8+kF+O3swKNzwdHffdb4XxjwxO21jWVj8PnDunDG2RTrnqAz8V69fk2mQxCr0MERxA==
X-Received: by 2002:a05:6a20:7f83:b0:186:5265:ed1c with SMTP id
 d3-20020a056a207f8300b001865265ed1cmr11554070pzj.6.1700083282437; 
 Wed, 15 Nov 2023 13:21:22 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 m18-20020aa78a12000000b0069305627491sm3238404pfa.159.2023.11.15.13.21.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 13:21:22 -0800 (PST)
Message-ID: <84796698-f848-47a3-ac6f-26e0777a6cfe@linaro.org>
Date: Wed, 15 Nov 2023 13:21:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] tests/tcg: enable arm softmmu tests
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20231115205542.3092038-1-alex.bennee@linaro.org>
 <20231115205542.3092038-10-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231115205542.3092038-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

On 11/15/23 12:55, Alex Bennée wrote:
> +vector_table:
> +	b   reset		/* reset vector */
> +	b   undef_instr        /* undefined instruction vector */
> +	b   software_intr    	/* software interrupt vector */
> +	b   prefetch_abort		/* prefetch abort vector */
> +	b   data_abort	        /* data abort vector */
> +	nop			            /* reserved */
> +	b   IRQ_handler        	/* IRQ vector */
> +	b   FIQ_handler        	/* FIQ vector */
> +
> +	.text
> +	.global __start
> +__start:

All globals, and ideally *all* symbols should get the type+size markup.
When qemu reads the symbol table for lookup_symbol(), it will use both.


r~

