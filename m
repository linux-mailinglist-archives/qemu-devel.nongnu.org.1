Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E4D7D00CF
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 19:45:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtX4Q-000103-Ai; Thu, 19 Oct 2023 13:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtX4O-0000zc-4S
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 13:44:28 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtX4K-0001mu-WE
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 13:44:27 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-27ddc1b1652so1511409a91.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 10:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697737463; x=1698342263; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qwp5fzOPksIx88Je6PXAsSi8EosERFMCmHnUpVO4PIM=;
 b=ncNqkdVs03U480zaEfYU0YC/0OyB7W1xXv/3GmEA5lQYD1b+gVj9igihLFipDqvacH
 o387u/5YlqUCnKqMci3mG3S/1Ld5bXdUQ4+EwiTFf/2oYQNLFBz7TPCbSx6m7jWLgPde
 Cr99vJjnbUkJtKOA09g3krRzEVC/Gl7O1zOl1SvobcOHPPOibcxneJ86xsWOK7guaA7/
 WOMdftmtikcOEcDW+0RuCxj/FcQ+GroDuCKMjbWtNVKSiC7VQg3d2Uo+B+xqMMSToETH
 fflOkPCa/tP7HQIgvqUQmyb5lXnzSzrs2W4uHK9gAEfIZZYspcgMf7v87bN4oH+usy3/
 bvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697737463; x=1698342263;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qwp5fzOPksIx88Je6PXAsSi8EosERFMCmHnUpVO4PIM=;
 b=XeXMDJ5BbPxID3TL28Tpb3VUZaxMoD60zUFLQ37NivFm/dm4M+SWNYs2co1bXOxD2q
 D2KBajGtAu/MKRPr5Ae+AFTJQWqsVHyo5iLRJFZf6Okrwb8pEbwcYI6psCdIhhn6T8dk
 Y3caQXZ2ec4ungcnaKdJhL/2Qju5EQ2QLb73dNcdNaMcta42EwT0TvBPgXOSxWZN1wh/
 HNtsvFoHNkOuN+sVKaQr3u0m0Rir15oDZL/qFsb2EoLoxsiiAwXODRZrA+zTE0UnZaCh
 lEfunSSpP7Bk9+nr3FFegtVKscvD6eRHBKfQyVNz+g4h/S+4IA6iUEoFsBsrG309MORM
 cB7Q==
X-Gm-Message-State: AOJu0Ywz2ONEmEOvVnvBTZ4tTZlrnSx9nMqNRe4quTbDRUW/xe7HMBXD
 SF5yApxb7jZf2e50cj/aEhyqA76r6pU9UgIk4HY=
X-Google-Smtp-Source: AGHT+IFyuPC0j0IGjTYKEgbeFuUrMHRwS6o4F7YLm5Sd+28xcmqyY5qF9iARec+tZOoxqyK1C1cQwA==
X-Received: by 2002:a17:90a:17ae:b0:27d:63ae:f376 with SMTP id
 q43-20020a17090a17ae00b0027d63aef376mr3256728pja.38.1697737463352; 
 Thu, 19 Oct 2023 10:44:23 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 l21-20020a17090a599500b00277560ecd5dsm1843913pji.46.2023.10.19.10.44.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 10:44:22 -0700 (PDT)
Message-ID: <3cb64878-7f3c-46b4-b423-0c5a31aba797@linaro.org>
Date: Thu, 19 Oct 2023 10:44:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/19] target/i386: introduce flags writeback mechanism
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231019104648.389942-1-pbonzini@redhat.com>
 <20231019104648.389942-8-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231019104648.389942-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/19/23 03:46, Paolo Bonzini wrote:
> +    /*
> +     * Write back flags after last memory access.  Some newer ALU instructions, as
> +     * well as SSE instructions, write flags in the gen_* function, but that can
> +     * cause incorrect tracking of CC_OP for instructions that write to both memory
> +     * and flags.
> +     */
> +    if (decode.cc_op != -1) {
> +        if (decode.cc_dst) {
> +            tcg_gen_mov_tl(cpu_cc_dst, decode.cc_dst);
> +        }
> +        if (decode.cc_src) {
> +            tcg_gen_mov_tl(cpu_cc_src, decode.cc_src);
> +        }
> +        if (decode.cc_src2) {
> +            tcg_gen_mov_tl(cpu_cc_src2, decode.cc_src2);
> +        }
> +        if (decode.cc_op == CC_OP_DYNAMIC) {
> +            tcg_gen_mov_i32(cpu_cc_op, decode.cc_op_dynamic);
> +        } else {
> +            assert(!decode.cc_op_dynamic);
> +        }
> +        set_cc_op(s, decode.cc_op);
> +    } else {
> +        assert(!decode.cc_dst);
> +        assert(!decode.cc_src);
> +        assert(!decode.cc_src2);
> +        assert(!decode.cc_op_dynamic);
> +    }

I suggest you use cc_op_live[] to ensure that each output is present if USES_CC_* is set, 
and absent otherwise. Obviously that's not possible for CC_OP_DYNAMIC, but for everything 
else...


r~

