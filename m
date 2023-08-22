Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEA878483D
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 19:11:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYUuD-000669-Do; Tue, 22 Aug 2023 13:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYUtv-00063R-EY
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 13:10:46 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYUtt-0004I4-9h
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 13:10:43 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-56b0c5a140dso1944907a12.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 10:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692724240; x=1693329040;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Za8c4+5RrtvZHY7iLQRfGk7Xp7HIKUtWW4qpYHy4zas=;
 b=CLZVv1xFme5rivBjo5lLdrz8HQh1lcnALL+yAlJzb/Gv2onbsjw7O4MUqKO5g3WLx2
 wISs0Hyvf/01HCyJa10db5qLuMmcXd4VXMNCexh4IP8XHEka5TcoNoBjaG5eS9KiRxPB
 ymc4Sh+QP9KklJfQeLfnCh8vxp4+CIfW4TCt401FOOwhOdL9JQN9z4lFkq7neB9xyHjU
 wIO73W08PoIw7siGnxrR8mOcYh2hHvOlf4pXgGdrJ8hUCY/1WeAHe0ISdm9TbDbk4DHq
 tYZkOe9QVpivyMZLLNf0KxRzSBOlKBqrMYhrIqAB1XetLGt5ml3DM9eDee/mkVUT6IwT
 m+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692724240; x=1693329040;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Za8c4+5RrtvZHY7iLQRfGk7Xp7HIKUtWW4qpYHy4zas=;
 b=MIF6c4Jaor4rS0ELy7vaB9BJE9S0Fyz7TlrH8VdOew2u58OMP3/z18RL2TS/7zMbOx
 gMzGtOJiDzCVR+AWVoygbCLIbgc+VqKftTYAlq52qv6zgUnmV8VTmbAs/HA8/edXmqFA
 XQe0nONf2XgnE9QEorf/gP5TEVPMTc8gE47NKovKm2Wg/Gen8qTY/s4i/wkogHAS+RkH
 6oulwGhUh1LG8ztM6dDKxnSE8LmakmwIh75H61IdO9bXyBAWWbuNsJ9lWOU1hwUiX+h1
 Zh+OFEVdw6jBc0S5kbqlwkt9otriOLTq258yaXLF5StSGQa6iq0A0T7dd7tlqN5Rq7tB
 jQdg==
X-Gm-Message-State: AOJu0YyUTd4PftcnjYa+r9AF2Vd8tRFdRdDt9wITEGgC0vehzxX9tkNz
 G0WbznD5yyCe05qhayI2mW9ZtdsnbgR8PZ5Ld20=
X-Google-Smtp-Source: AGHT+IESYSa/FJTRIogTIIZENryHnDuHQZCAvmqngTUC8tAe57Pv+PihVZy+d1ezgCI8wN9BLXvbPQ==
X-Received: by 2002:a17:90b:4a02:b0:26d:17e0:2f3d with SMTP id
 kk2-20020a17090b4a0200b0026d17e02f3dmr8881624pjb.44.1692724239904; 
 Tue, 22 Aug 2023 10:10:39 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:4e3c:f4a4:b92a:b5ab?
 ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 28-20020a17090a019c00b00263d3448141sm8789563pjc.8.2023.08.22.10.10.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 10:10:39 -0700 (PDT)
Message-ID: <e9e86484-d70b-1075-a412-1040e9ad9d10@linaro.org>
Date: Tue, 22 Aug 2023 10:10:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tcg: Prohibit incomplete extr[lh]_i64_i32() implementation
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20230822165101.72695-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230822165101.72695-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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

On 8/22/23 09:51, Philippe Mathieu-Daudé wrote:
> extrl_i64_i32() and extrh_i64_i32() work in pair. Backends
> can not implement one without the other. Enforce that
> assumption.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/tcg/tcg.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index 0875971719..a6f51130aa 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -172,6 +172,9 @@ typedef uint64_t TCGRegSet;
>   #define TCG_TARGET_HAS_v256             0
>   #endif
>   
> +QEMU_BUILD_BUG_MSG(TCG_TARGET_HAS_extrl_i64_i32 != TCG_TARGET_HAS_extrh_i64_i32,
> +                   "Both extrl_i64_i32()/extrh_i64_i32() must exist");

Just rename them so they're the same symbol.


r~

