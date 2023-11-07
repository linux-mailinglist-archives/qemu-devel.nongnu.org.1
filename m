Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9685D7E33EF
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:14:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CX2-0003Gg-BG; Mon, 06 Nov 2023 22:13:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CWz-0003Ez-Pk
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:13:33 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CWy-0002Fn-7G
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:13:33 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ccbb7f79cdso14896385ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326811; x=1699931611; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ksB+6M3EAlC9VCyemGaBxFPiWH1NM4Rzt3EydbpiwqM=;
 b=xgXnzEvddgy1aNXusXqQ8huz0ctOWLeIo64HWx6qBz1gNbrhEOji2kmSZlxznj18t5
 i6+F3n6HorJz7RES/SRa6PicDrA/tpyhS+G8hN7HPsLGJQQJPqPIr501phjM33tUNRpB
 O12wDtj+jp2N46vx8329jHb+2JMR/XfvptmHKCFWZrMeciRCPTxWY9bmhLaqc5gfHmJn
 yMrdIm90/HkOwTAcAF9ftA8ixyGXFFhjDruIdPzjoVGD9vXKok5YaN3FjaisPpv3uNGk
 Z7cykMzOamRTKfPXs6/4s5Gg7NTwdF/CCcMN6icENykDDEzPlzcr6ySjf6G8fNyy0Jcp
 kwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326811; x=1699931611;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ksB+6M3EAlC9VCyemGaBxFPiWH1NM4Rzt3EydbpiwqM=;
 b=TOJgQ3LARXg4yQHNpeTAMJsP8Zvc+PSL7DTKCoi5DjFeDa5P95neZdLNHv2a6V95r9
 C8BpSuhq8Dts5E6I3IA3NJCpZx6jQ4jDSFpbQCeh2Pknc4jxLmn+cKLNuRPKLVSkzgig
 x+MvJgbTNle9EdhCIpY0OaQ5UwztePNs1PXQc0W1DxKosK24/HmBQjl/51Iz7B1+lBq/
 zKOKiPVyFcHYDxidt/FwaUCGOgef4Z78y8SqQkStFJBl3YZEse7TSpUOJrWV8i9Ta2dT
 7IZerLIJwwhdC5fqKat+O8XTNGI6m8F518uqNpfzh9csD6G0mTyRouQ3UK3q0JlIOUNc
 YOQg==
X-Gm-Message-State: AOJu0YzHWr86z83Bel5bGH0DJRHh/eK3tHOKwut1BFGzBwzHPM4OprRY
 PsJTMVS9GRFq5dbrR+rRjz9RZ8LxGe+Yn+awEAA=
X-Google-Smtp-Source: AGHT+IFjKE2Luj8SbhIoHouXFLcsBbr7/zZ9xY6bybthuT7ubfx7+9bi1F8YD9++i7DOLHYMUwQvqg==
X-Received: by 2002:a17:902:fb45:b0:1cc:379b:3505 with SMTP id
 lf5-20020a170902fb4500b001cc379b3505mr18593802plb.49.1699326810749; 
 Mon, 06 Nov 2023 19:13:30 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 21-20020a170902c21500b001c736746d33sm6533759pll.217.2023.11.06.19.13.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 19:13:30 -0800 (PST)
Message-ID: <c6140f05-d1e9-4fbe-9aad-c764102675fd@linaro.org>
Date: Mon, 6 Nov 2023 19:13:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/29] plugins: Use different helpers when reading
 registers
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231103195956.1998255-1-alex.bennee@linaro.org>
 <20231103195956.1998255-24-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231103195956.1998255-24-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 11/3/23 12:59, Alex Bennée wrote:
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -89,7 +89,11 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
>                                             void *udata)
>   {
>       if (!tb->mem_only) {
> -        plugin_register_dyn_cb__udata(&tb->cbs[PLUGIN_CB_REGULAR],
> +        int index = flags == QEMU_PLUGIN_CB_R_REGS ||
> +                    flags == QEMU_PLUGIN_CB_RW_REGS ?
> +                    PLUGIN_CB_REGULAR_R : PLUGIN_CB_REGULAR;
> +

I'd really rather you reject QEMU_PLUGIN_CB_RW_REGS entirely, rather than implement it 
with incorrect semantics.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +        plugin_register_dyn_cb__udata(&tb->cbs[index],
>                                         cb, flags, udata);
>       }
>   }
> @@ -109,7 +113,11 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
>                                               void *udata)
>   {
>       if (!insn->mem_only) {
> -        plugin_register_dyn_cb__udata(&insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_REGULAR],
> +        int index = flags == QEMU_PLUGIN_CB_R_REGS ||
> +                    flags == QEMU_PLUGIN_CB_RW_REGS ?
> +                    PLUGIN_CB_REGULAR_R : PLUGIN_CB_REGULAR;
> +
> +        plugin_register_dyn_cb__udata(&insn->cbs[PLUGIN_CB_INSN][index],
>                                         cb, flags, udata);
>       }
>   }


