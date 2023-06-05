Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 793497226AD
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 14:59:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q69nD-0001hq-FN; Mon, 05 Jun 2023 08:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69mi-0001Rh-Vl
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:58:19 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69mh-0007Me-AA
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:58:08 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f730c1253fso15477845e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 05:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685969866; x=1688561866;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SRFyiC1cbR+q4ep3GwCEAl7NYIhvxGT3Fa9ivBA0qTo=;
 b=OoOGmBA/LZ4SWXD2kjLSXdthlnlPAUo77wDUcLSw5IKNH2j+aL8EsXH8IPFqlg22aE
 v45EyG9l26a54CwHlxs6qBAoUJajgXmph8rIZCAZX36GM/PPPmo2+vRUsjWu0kRYe+w2
 fnMKz/0eYjFXBj8Cq3hE7VLrtxW3iJZXLucxosFY0jJelTA02YZfSUXI1YYaKyMyOII2
 +SNEsSENrj/yXs5jyhkqfbRcSbwPKSpYnqCEBBcat6MQ8t/zKS5MhFLALAbxYgx1JpVQ
 WZwX4FYKYoOzNaehZQxXHcjqEkkfilgaTcmqI1Zxnm0XZpDFzqkdDCDM8GlMbJZx2Q3r
 zZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685969866; x=1688561866;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SRFyiC1cbR+q4ep3GwCEAl7NYIhvxGT3Fa9ivBA0qTo=;
 b=A7w8q3CFH96PsiyjXZ91Y+HnwAGy6iwx3QNJ5PEGV9O0PlQ4l5iuU3PFnhVnpEksVU
 M+bHJ7J3Vd6cs2enKEggp30Ofnf/MBzBv0hyJ9V9qdws6W8D/qNyyGx/g9yyI6dlobdA
 qnev1/9of/zCiju0gOY03X1MWRl2M0/rwefN+pUfwFZj0NQ5pOdrQPmySF34w98I08jE
 2hG2ev2+slEydNyozZXObKFzo36+2h5tArCKJGlcANtm6r7u5HKhoKQ1NQU1vW03X+ib
 VqtdHKCAbbG5g50Lg7lXQNWbEE/QGInPkB7RWO6BW4IDt77bf6dJsaXT7TO6K1MUC21c
 8hXg==
X-Gm-Message-State: AC+VfDwEYTp09OwX5blNtb9lzwxkNBHCTGwDD0YY9RHmahDjrzJNjjVd
 87ofl1KMltK/yZqJdn5wYYOa3P2gjmh8L4sgz8o=
X-Google-Smtp-Source: ACHHUZ5u2Pn1z56/Ib4tbabvD3edc6cKDyNISXORflhdEWyAdMPe7UI8DMLHnTkXZeiau8BowEOrwQ==
X-Received: by 2002:a1c:750a:0:b0:3f6:69f:75cd with SMTP id
 o10-20020a1c750a000000b003f6069f75cdmr6665135wmc.0.1685969866382; 
 Mon, 05 Jun 2023 05:57:46 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 t23-20020a7bc3d7000000b003f4290720d0sm14316931wmj.47.2023.06.05.05.57.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 05:57:45 -0700 (PDT)
Message-ID: <512515a4-7f90-6ebc-0633-d64c5f8bf7ef@linaro.org>
Date: Mon, 5 Jun 2023 14:57:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 13/15] linux-user: Use abi_uint not unsigned in
 syscall_defs.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20230603222355.1379711-1-richard.henderson@linaro.org>
 <20230603222355.1379711-14-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230603222355.1379711-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 4/6/23 00:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/syscall_defs.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


