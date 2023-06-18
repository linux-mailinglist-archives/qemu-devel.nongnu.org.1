Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 363FF73473D
	for <lists+qemu-devel@lfdr.de>; Sun, 18 Jun 2023 19:34:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAwI6-0005oi-SV; Sun, 18 Jun 2023 13:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qAwI4-0005oa-RD
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 13:34:16 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qAwI3-00089x-9c
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 13:34:16 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f9b0f139feso2378505e9.3
 for <qemu-devel@nongnu.org>; Sun, 18 Jun 2023 10:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687109653; x=1689701653;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t5cGdwe7n8jZdIbjOIj9IdZCThNjh0TjinYpzMtlbgw=;
 b=yjhItUdomZwcnBTeoXb2v+TB8M5HCBzTJtBjetQP05fFOqnW78i9f/7hhibKNyiNOt
 gOtfs68zJy2sjoMZhMuNTyWwFO6LGwNn7wM89jWNlHDrjA0LW/bdUr+J0uDDztUhWKAl
 B5wL0L5UqHs5Ts0CA2El3/EfR/a/NqMiThjysFfSpB8ihnJd0qKv0pElN1j5ol4W6MJ8
 iT3N0EW9SfJH2U+IbKXbTLhWwhkjNw/bKHYQZ+n1dRcah/GqvnJnxSz6xCB9eFKwnCVK
 412b2/2fjIQL0Fv70khlJEXnO1vCGeS0XNdivVIbS/mP8dXq8bP+atTLKeQNqmYcT3b3
 MkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687109653; x=1689701653;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t5cGdwe7n8jZdIbjOIj9IdZCThNjh0TjinYpzMtlbgw=;
 b=JQJtkppncDvXtI6Rs0s4mwbIXeXCgj4HluCNdBPVQcinUlSHeYykg/rBRTbureKfFk
 evMwq9RbNkk41VsjmlRUUmxWM23u8I02fHclkXxIFi11DLZbh1Kw8bEZ/cTpMFfLnp2j
 xlzRMb3kFQG4od5I/dwqUpfFxg9e41mJtsep+ITJrMmmFQNwWCRt2uCDaqQlNUX8La8b
 E4o630OJ7JFq9+PRUamU468QvW7pfEvhS9KDBLreg3lIgSQYeRzsU9r5ROzXOvcHqULd
 JpmANeDG7PMdYueteGlYRYdXsAnseQXGzmBE87lDvviJI5geD1nzen7h8hYyBXmFq9YL
 TY3g==
X-Gm-Message-State: AC+VfDyruBUGFoskD8OxML+NKbaZGf3jtQJo7fKDfHdAFRkUPTeRIhor
 ssVDJOnZw6IUGlVmXbLvW42sCgf2zsTGOLHmzIQQVdcM
X-Google-Smtp-Source: ACHHUZ6Pv9+DdKa8dvtsjN6NEgHZ9COcdCrvDKI8EcbQ678g6BruAHk3oBePUPTTxqOuN5vh1dvxvQ==
X-Received: by 2002:a7b:c39a:0:b0:3f9:19f6:b817 with SMTP id
 s26-20020a7bc39a000000b003f919f6b817mr1656705wmj.30.1687109653323; 
 Sun, 18 Jun 2023 10:34:13 -0700 (PDT)
Received: from [192.168.69.129] (mon75-h03-176-184-51-101.dsl.sta.abo.bbox.fr.
 [176.184.51.101]) by smtp.gmail.com with ESMTPSA id
 17-20020a05600c021100b003f735ba7736sm8173807wmi.46.2023.06.18.10.34.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jun 2023 10:34:12 -0700 (PDT)
Message-ID: <e4673a26-f943-88ee-6cbb-88ff78a1749a@linaro.org>
Date: Sun, 18 Jun 2023 19:34:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/8] target/tricore: Indirect jump insns use
 tcg_gen_lookup_and_goto_ptr()
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20230616152808.1499082-1-kbastian@mail.uni-paderborn.de>
 <20230616152808.1499082-5-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230616152808.1499082-5-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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

On 6/16/23 17:28, Bastian Koppelmann wrote:
> @@ -6075,7 +6076,7 @@ static void decode_rr_idirect(DisasContext *ctx)
>       default:
>           generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
>       }
> -    ctx->base.is_jmp = DISAS_EXIT;
> +    ctx->base.is_jmp = DISAS_JUMP;
>   }

Not quite correct, as generate_trap is NORETURN.
Return early from the function there?


r~

