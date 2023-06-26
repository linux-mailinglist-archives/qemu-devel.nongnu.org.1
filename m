Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AE973D904
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 09:59:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDh8J-0001Y5-C5; Mon, 26 Jun 2023 03:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDh8D-0001XN-Kv
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 03:59:30 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDh8A-0005Ie-KJ
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 03:59:28 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f9bdb01ec0so37109785e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 00:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687766365; x=1690358365;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=82JviyxFOfNWY+QpxIM4vqHQzV+G/ZWEUCh2G+cl6Ls=;
 b=Va1uk72/q3aRS9wd82O3cU2BVNrJjABOx/Q4a0RyDchYnsshSZPx5lEYKlw+buPgL8
 QG+eeqNGhjFfTQR0x24NGqALT5migAoNq5jG/lWIo3wwi1De2fFyk4c4irIU0pFrhm4C
 5Djw73mD1toIurznyYzO93fl7a9LSqnGpSdSlPg4BAcw9V92eJd2X9xdaGgKmDYswUfi
 RbWeDbcTx2nH4Uew+rnv7nzAvYEOLzlOFQ/10BcXvqo+c244um7Ky/5e0K7IPL53m3J+
 5xmhjC2Q7xdUw+omkdfmIFIfwBpIJkbxu0+7J5mmlsh6i+2N/MMFw0rW6n7sZcdjSGz3
 Wppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687766365; x=1690358365;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=82JviyxFOfNWY+QpxIM4vqHQzV+G/ZWEUCh2G+cl6Ls=;
 b=hseUei99mHas6xW+PqCjsHutmgqN3xvTpb7rlgs9AgJ9HnY1I5iGRzNf4pkn4lX8xy
 lC+IQ1aEHPYs+dJ3kXzDu/JRdpYM8DTdbBWnUOFUtAzZYtix1dTb+HjYXBZqcg68kvu9
 lkRdYY2tLHuRvOCh9n3XkbCqudneep1k7BRMoM8Sz9wbI1U2XaUvOZMa860id0I4PdiO
 IBV4a53KL2WcztyyGR263czuKp4jp+edEogIwNmaLDL6uiOWOKNHj1GoRwNzahMNyAeE
 WYSFXpEXm0C+xObPGnToGxQLzPeeYq4M4NtzBsKSYxfsOOieRqpNeCbbEGXePZDtQobi
 1GAg==
X-Gm-Message-State: AC+VfDw3JkdxiCrUhhkCFBv0Oi0uAhI8L015bIOGuw0lbasrONSJTlca
 u8+FMBqPgVnQ4nKNjQIk9CiK3Q==
X-Google-Smtp-Source: ACHHUZ6spqsJSyi1rB5f6gTfVrbnmcRQAsQGxWmX+Q2KrNeX+4+UxYaQlO4Vlodj+gD3vHj5YrC+Ww==
X-Received: by 2002:a05:600c:ad7:b0:3f9:991:61da with SMTP id
 c23-20020a05600c0ad700b003f9099161damr18754727wmr.39.1687766364875; 
 Mon, 26 Jun 2023 00:59:24 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 v4-20020a05600c214400b003fa95890484sm2378288wml.20.2023.06.26.00.59.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 00:59:24 -0700 (PDT)
Message-ID: <67f63484-a8ed-ae69-9eae-024e889bd23c@linaro.org>
Date: Mon, 26 Jun 2023 09:59:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 02/26] gitlab: ensure coverage job also publishes meson log
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
 <20230623122100.1640995-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230623122100.1640995-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> The coverage job wants to publish a coverage report on success, but the
> tests might fail and in that case we need the meson logs for debugging.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-Id: <20230503145535.91325-3-berrange@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .gitlab-ci.d/buildtest.yml | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

