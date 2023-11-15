Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE347EBAE2
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 02:18:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r34Wr-0001Gd-1M; Tue, 14 Nov 2023 20:17:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34Wn-0001Ea-NP
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 20:17:14 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34Wm-0001Ny-1Z
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 20:17:13 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6c10f098a27so5035382b3a.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 17:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700011030; x=1700615830; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wx85rs6Ux3JpR5jRxN/05WqS9fnSH+sBvHMQ3ONY1RI=;
 b=aSN15p4eVMV03IIXAuLWJosAvJ0lLSOPC5uE9lUqhiqdyMZsW2TNWi4GP6zbGmJX6r
 OyLDlW8RT47XREeTRUbtPAooBuxqRav0fWek9p0AKiqjm8sZDxAqnrsR4QzN5ZFp8wS7
 yO7c/kmoxdsFecCfw4XNqWtvZq8Ti6YGgSkMEdIa0MnNjjPFcS6uuMMFcw5koO/ORxvn
 Vpa7hAL+NqAYHXdn+afFg/Sl1qvBTYOBiiDfEPHclAgKYOA41U80SohwT4mjZS+krsju
 apEZlqeudqGlgTDm6x33Eg/I1Qs+DM6oQ2FcUCtnyWhfXK2Kq/SI2M0y3IFPXPHlg71y
 qT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700011030; x=1700615830;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wx85rs6Ux3JpR5jRxN/05WqS9fnSH+sBvHMQ3ONY1RI=;
 b=pG6Wh6I1NjL/uCH8Z8Bs6nuhdXkOa4OpjfSmikARRF7CODqosnEybZoqVFBK6UI1vF
 a4wzWg8Zz45M4TsiIGTPpU4E727k8Tcm8E1KQk37PUQ7U9fGz2PRKoe+tFQ49G+IbtnA
 ol2QQjjOfYauJBnPtgKi2FPXoqYocKVH0GQGhTToh6IznTFHkcICebk38Jdy8Qt9ZzPz
 ie9GdfgaDE0A8yOQTnxsj9vgEArUSQ0P2+mJnrplWlyNBuSeMpbIskyijpTbVm49g7jl
 Rhx+HMhYroF+//IRkBfZKTtmC0q+osaTEXvFkeMQs11ycdRELqXym819j3iNDflh6TY6
 v/mw==
X-Gm-Message-State: AOJu0Yw7IUCEZlD5/rjtwtDSiN3MIvJu+K7oFN6VpBbVVUqy49Cg49f5
 2DfdOkIW9gJptseJ5Ce0nVQqqYGju9Ip0c0sSCI=
X-Google-Smtp-Source: AGHT+IF7vKicqcSNJGEMA/rxl9+FkIH+gt0fHhW6EocA8jZ8mu5O7LQTykOlxUu2KfnTMg+yqVrogg==
X-Received: by 2002:a05:6a21:3e04:b0:186:11da:59c8 with SMTP id
 bk4-20020a056a213e0400b0018611da59c8mr9535138pzc.61.1700011030426; 
 Tue, 14 Nov 2023 17:17:10 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 k6-20020aa790c6000000b006c5da63556dsm1867085pfk.178.2023.11.14.17.17.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 17:17:10 -0800 (PST)
Message-ID: <99e6e9fc-d3a4-4285-94ae-3cec0207db46@linaro.org>
Date: Tue, 14 Nov 2023 17:17:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 22/31] target: Use generic cpu_model_from_type()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-23-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231114235628.534334-23-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 11/14/23 15:56, Gavin Shan wrote:
> Use generic cpu_model_from_type() when the CPU model name needs to
> be extracted from the CPU type name.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   target/arm/arm-qmp-cmds.c             | 3 +--
>   target/i386/cpu.c                     | 3 +--
>   target/loongarch/loongarch-qmp-cmds.c | 3 +--
>   target/mips/sysemu/mips-qmp-cmds.c    | 3 +--
>   target/ppc/cpu_init.c                 | 3 +--
>   target/ppc/ppc-qmp-cmds.c             | 3 +--
>   target/riscv/cpu.c                    | 3 +--
>   target/riscv/riscv-qmp-cmds.c         | 3 +--
>   8 files changed, 8 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

