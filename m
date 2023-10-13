Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC467C8776
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 16:06:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrIn9-0007wt-By; Fri, 13 Oct 2023 10:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrIn6-0007j5-Ox
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:05:24 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrIn4-00033E-Sh
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:05:24 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9a9f139cd94so345605766b.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 07:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697205921; x=1697810721; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EzlKYbgiGyXCh1lKaxUmgJBbtAmhUCw0Z6tR5OnwLQg=;
 b=HZdyOIQAyjfiT+CO3wuf45Wd4lkN0C1UYGdFlSQ/51Lof7eR1PNIh0l7WlkBDEdf+/
 i+9aVp9JPwjDtA0wzUoDl17rZC8Zq5JfsvksjB7PWJ5ZRQoMuXLTCFZiokWBv+GdvwF4
 HfHhgKNwjHc7rKvH0Xo9Dgejg5IeYXsWuSMPwJCcnmmjHVeRJcLGYYjubL9BmiU+PP1Z
 vAOEEOe7tRFRBc7azeSWL7ZtMXJk2dM2ilrtEKJRo/VmdDb0+Tu2b4bh3PS52h8UNv5n
 /Omv3zDHYzRjZGqKTgoROcF2NHwUKcyNsAkovzK/J/P70fTsmIwp82MSf0L2DVTGjhcU
 jo7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697205921; x=1697810721;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EzlKYbgiGyXCh1lKaxUmgJBbtAmhUCw0Z6tR5OnwLQg=;
 b=cyzKbW+YkiAVdKUMUiCtl+pZRwSmKVf6059bNME0ms3FAHA+nyQeKYif+GJm5AEvcF
 tKY+LBe72x6LjDyblPem8ilSHcgIjFHDFz0Anc5v/zTaZX5w00jWRCFJYBG4TMtQgtOl
 1Mpq3cZBOl470EJloYblf9FIEaFutSNJ0WNcTpMrll+Lzx6GOSQabdUMv9aZKNr2m7Ry
 LAE73wqHYO/ip9PFD1eXP3zE2I9u4Rm8+1PZthTiUa0hdtLyjJHMk8gzXn+h3OXTXuNG
 2xB2ITioxNBZ5XNco5tugRy6J4ue0fl4Jr0ZQoGz7xQeSq8kK2vD0RhsmvgKWfEw3MLx
 dIFg==
X-Gm-Message-State: AOJu0Yyibyvr8EZfH2Uyd1dhuTd71yjSDwQv5gdc0piFGdBcpw6ARWzX
 zbbeoXacIaSQenMX9E5x6W41Zg==
X-Google-Smtp-Source: AGHT+IHWdDI5+k6mh6QP9Xu71GRxahapYXjw1VFneGTJJKcVw+xb8AJCmu3w/l/URjhbCtInQATD+Q==
X-Received: by 2002:a17:907:78cb:b0:9a5:ed5b:241e with SMTP id
 kv11-20020a17090778cb00b009a5ed5b241emr22201524ejc.25.1697205921131; 
 Fri, 13 Oct 2023 07:05:21 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.118.168])
 by smtp.gmail.com with ESMTPSA id
 ov19-20020a170906fc1300b009a193a5acffsm12354893ejb.121.2023.10.13.07.05.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 07:05:20 -0700 (PDT)
Message-ID: <a4187886-148a-d8a3-b862-e0bced33e62c@linaro.org>
Date: Fri, 13 Oct 2023 16:05:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 11/11] hw/char/pl011: Implement TX FIFO
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Mikko Rapeli <mikko.rapeli@linaro.org>
References: <20230710175102.32429-1-philmd@linaro.org>
 <20230710175102.32429-12-philmd@linaro.org>
 <f9c35a6c-be32-7758-d78a-e63449f864b8@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <f9c35a6c-be32-7758-d78a-e63449f864b8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 14/7/23 09:27, Richard Henderson wrote:
> On 7/10/23 18:51, Philippe Mathieu-Daudé wrote:
>> +static gboolean pl011_xmit(void *do_not_use, GIOCondition cond, void 
>> *opaque)
>> +{
>> +    PL011State *s = opaque;
>> +    int ret;
>> +    const uint8_t *buf;
>> +    uint32_t buflen;
>> +    uint32_t count;
>> +    bool tx_enabled;
>> +
>> +    if (!qemu_chr_fe_backend_connected(&s->chr)) {
>> +        /* Instant drain the fifo when there's no back-end */
>> +        return pl011_drain_tx(s);
>> +    }
>> +
>> +    tx_enabled = s->cr & CR_UARTEN;
> 
> What happened to "Hello, World"?  We ought to be consistent.

What do you mean?

> For actual modeling, I think you need TXE too.


