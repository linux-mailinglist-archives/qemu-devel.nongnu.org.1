Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BBC7E750B
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 00:16:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1EFC-0003kf-2M; Thu, 09 Nov 2023 18:15:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1EF2-0003gW-7S
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 18:15:17 -0500
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1EEx-00062l-1u
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 18:15:13 -0500
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3592fadbd7eso5618675ab.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 15:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699571709; x=1700176509; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2yWdT/Z4cWLzUryLTqY6tt1ohWW/kvwoOTeU0FO6Fjc=;
 b=FwcVuIV6tQ2XXEuqI1oWkbGoAYa+srG4Vj9PvMVkK3oG7Cp3e9adhI3ufHIJcLt22X
 hGWvN+1fr4jmgBqaFpLl8TdrF2ulRszw70dx6jsXWawSemLKKLBFrCRk0AL2Y4rs7XVg
 6zMKsv4z541X5gMs54GIkaA1hP25TrECqI2yIV9DswJp5a5923af4BKi78Vwj2MMrQgH
 6IDre7kbwFz6tlxAwhI2FuRz/qeSnpbBOkBu2RkH7EVmRgguyaMiX2v+zN6Iy5VAgtSh
 Q8vXYX3rtGUzfBcSgNkSmlT7o6KpcIlSwH3/gbs+OgAY3i8TdBtJ6Kuyo3gzaMJ/yG0n
 upUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699571709; x=1700176509;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2yWdT/Z4cWLzUryLTqY6tt1ohWW/kvwoOTeU0FO6Fjc=;
 b=XprA9eE9YSMe0S94dyEnyRYARQ9QA97U6UCM4jQ51vyPo+euDcoYFpsTM8izhA6Xfj
 Bvkmi9mgsJ38T+8/9hmpdJDuqWzBhN6tSglYnv2hOEbyaR7i32MI5v/nmVLxJdIy+KqF
 uHmO/17LW3S+FhCPQu7dDy+wAZP9chnIWbOgLUiJhnwfFECg2ZRmPOSWITt7fEipPmUQ
 riJ+RcnaJDEl0Z5INqezKncRZt2aLsjzH8NrmbA0htonOYUnAjqCNCPjUO8+Xp/ZUHXQ
 4/i5qE3VFKepc0ngOr87KhSwYh41C+V7Ch6a2KXTlpR/lb6PnENtsNA0GA9fKJ02/ULG
 u5zA==
X-Gm-Message-State: AOJu0Yz/Kai7w1g9MZszXhA8re4NXfb64lvPS8pi4eo7hVT5s2AuVsnW
 ZKwR+5LX10LAv+1Z+VfeXi+xhQ==
X-Google-Smtp-Source: AGHT+IHn7ZmlJ4OeUYZmBb6LdgW1RlA7RrStuxah7FNK4uOoClvf5g6j0X09bGxk0CLwtGOmiyYxiw==
X-Received: by 2002:a05:6e02:1d92:b0:352:a73a:16f9 with SMTP id
 h18-20020a056e021d9200b00352a73a16f9mr7353933ila.18.1699571708615; 
 Thu, 09 Nov 2023 15:15:08 -0800 (PST)
Received: from ?IPV6:2607:fb91:1ee6:29b:6626:64c4:1b48:c565?
 ([2607:fb91:1ee6:29b:6626:64c4:1b48:c565])
 by smtp.gmail.com with ESMTPSA id
 y16-20020aa78550000000b0068e49cb1692sm11237476pfn.1.2023.11.09.15.15.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 15:15:08 -0800 (PST)
Message-ID: <0be4199e-cb05-4735-949f-bc4e2ad18f9e@linaro.org>
Date: Thu, 9 Nov 2023 15:15:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2 v4 02/10] util/fifo8: Introduce fifo8_peek_buf()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>, qemu-arm@nongnu.org,
 Francisco Iglesias <frasse.iglesias@gmail.com>
References: <20231109192814.95977-1-philmd@linaro.org>
 <20231109192814.95977-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231109192814.95977-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x131.google.com
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

On 11/9/23 11:28, Philippe Mathieu-Daudé wrote:
> To be able to peek at FIFO content without popping it,
> introduce the fifo8_peek_buf() method by factoring
> common content from fifo8_pop_buf().
> 
> Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/qemu/fifo8.h | 27 +++++++++++++++++++++++++++
>   util/fifo8.c         | 22 ++++++++++++++++++----
>   2 files changed, 45 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

