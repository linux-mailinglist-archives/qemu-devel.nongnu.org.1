Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 484AB70DEE3
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:13:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1ShE-0002si-9h; Tue, 23 May 2023 10:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1ShC-0002rb-5g
 for qemu-devel@nongnu.org; Tue, 23 May 2023 10:09:02 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1ShA-00075l-Cl
 for qemu-devel@nongnu.org; Tue, 23 May 2023 10:09:01 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-64d3fbb8c1cso4764585b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 07:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850937; x=1687442937;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fekR8d+EabLL9PGgyOWnMR76p/GEA5hvyyx+MobWcP0=;
 b=MoWS0ib6sXrHJYvg/HLy7Mytnw09KVRWvoQs5gLg+4+JU+8b7Nea/hD2/ClSSh8nmr
 WYDm0gmx3iG0r8696ZDAam5DMyN7AnQRBhVcRXVAaBVa7xGba9EPsTF8hK5GqQ+5fZbq
 MTkB1KjVBwvZE1Nb+0KsRlnDtCIl0PrfHPs+rR14me+oT+XxBVInMOXzpAC9vYSk+t4U
 HPr3CM9md4Vn658JBJboWQqm2T3+5txLymEYSTbrEkLGOhGwwovvXnNx6OMR03YxJJu7
 TPt0M5kGW5t01qemWJnMjBGtLQ0rOFxTw63QP85ELKRjYr8EhkJQXNBAxab6qlgJXG4U
 0/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850937; x=1687442937;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fekR8d+EabLL9PGgyOWnMR76p/GEA5hvyyx+MobWcP0=;
 b=dhLYJg7vPsNiWHAS+ws782WdHeVJla5dENTNNoiYRJCWTzw0noe/hINaNz2Uv+Z+42
 a9dVTURn7SEnbfSQ4kBGcgPGwfYOKkf64CJaIx0JwxPrf4XJu1y0L0K/NIoB1vJciS+K
 C96VarH5MRRU+1NpKWelHDYAl1gDZIkrnWbOkW56X3XafT9EshbRqDTsXDdKE1QGp4A3
 S/+V/xUK50llK20sNfwRcYnxQ9vMDT3WWUh76nbNM/B10UwyPDdvbGoVEc7UME4L962J
 CeChxF8yySP1/6b1e2vLCgJa/RJWqD/4Gl/ZhLGdRZlXYECoYBVgQ7KLt+MIRtm7DuMz
 MMBg==
X-Gm-Message-State: AC+VfDz69BEmixnxJxQenY9Pl/uXdZt7mmC832D0kmT7Qhct25V1Cch/
 cDcSFFq/G6JIRsloNwgXUvTGwjSOmacYaHo0wLg=
X-Google-Smtp-Source: ACHHUZ7d99vV2JKboWZECWhhm8umfxIfQ2DaeKmFt7AuaMSmFDJP8mvdzMGGGHbMiPE/T88CnWj5pw==
X-Received: by 2002:a05:6a00:890:b0:648:1311:fbc4 with SMTP id
 q16-20020a056a00089000b006481311fbc4mr21171464pfj.33.1684850937471; 
 Tue, 23 May 2023 07:08:57 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 s23-20020a63dc17000000b0052c737ea9bbsm6165821pgg.39.2023.05.23.07.08.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 07:08:57 -0700 (PDT)
Message-ID: <3466d603-ebde-0d26-ae40-6b805bbc2af5@linaro.org>
Date: Tue, 23 May 2023 07:08:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] meson: move -no-pie from linker to compiler
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, vr_qemu@t-online.de
References: <20230523073029.19549-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523073029.19549-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 5/23/23 00:30, Paolo Bonzini wrote:
> The large comment in the patch says it all; the -no-pie flag is broken and
> this is why it was not included in QEMU_LDFLAGS before commit a988b4c5614
> ("build: move remaining compiler flag tests to meson", 2023-05-18).  And
> some distros made things even worse, so we have to add it to the compiler
> command line.
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/1664
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   meson.build | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Richard Henderson <richard.henderson@linaro.org>


r~

