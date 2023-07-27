Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 123EA765C71
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 21:51:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP6cI-0001Eg-FK; Thu, 27 Jul 2023 15:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qP6cG-0001D1-U1
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 15:25:41 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qP6cF-0008FD-A9
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 15:25:40 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3a4875e65a3so1111769b6e.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 12:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690485937; x=1691090737;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6P0QGMnwy+Ki7Wq++5mmVEiaWv2fIF92OUZUmBVFZyA=;
 b=GTuxoWyVVDNydJ+5cQqP5joE1b9IKijGEjUPiHicSXQyxbqheTDWyCc2jotZ/2fuXT
 UoXHu6OzBcEY20nPgF/hOzUhV3nScG4Md2H4L+6j8P0JFHN8fHYlXXiJRbNfcXstn9lj
 iiYZytFnHxiZA9KKmTrlLN/3y2b8VI1WnxZI40feemYWWtExLvsbg2M6/Q5DoZC6782R
 FvmeuyDRJgnwKJl1TfV99oq5pPpQWNMAmSLeFlYlDJpRKJPQf0KfQVjQ0nFEwPwAPSb4
 OSocOMSFTHcg/uBdey3nk4/nl6+PlKWwT6aBWD5ERDegS01cfOxCbLXs0DglOGvoZUrX
 h2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690485937; x=1691090737;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6P0QGMnwy+Ki7Wq++5mmVEiaWv2fIF92OUZUmBVFZyA=;
 b=YjQ4zJFNrrJP9tTUDcayQkUIqPuOuBQ81iq3TJbhJNViK9dV4/3EIYoubGFy3k0iV6
 1pLEOjGlEWf/g3e5Q+yk4LcjepsTSZa0XEmz8S5oNsj3IUP4i35Wq3yqGCUXHNwKgdGo
 KLqHKaVDNBIK02q1pmoudowSbN/KpdnueJdaRotsJIG5S/fjw9IrFxSMcj29YYoEB2zV
 EOIfHyBVLdyPVVHknbtarsM1pi3zt8/npfFPlsLX+tV9TSEcJcLb9uGUaJx0IB0JmjKN
 L4btuHTLXKwfS0bdEhrtYcnR+1SEKrnQc+lZ3pHiBBBzmHMuqs+dtRSGeeCsXis278AL
 rinQ==
X-Gm-Message-State: ABy/qLaGAuUbPOue5jPvowZchxDYkChEINvZDxkkCYJU3pNfvZwoh3ht
 EAjsx1wlPmUs20cKjKyA2aEkRw==
X-Google-Smtp-Source: APBJJlHRGm0FRWGJCToVQHsWG4D5j8oIjmFquG3fbmDfddnNwrnQR7jEjQYFRoGUHxqCPLwsDSN0Kg==
X-Received: by 2002:a05:6808:200d:b0:3a3:645e:9ec1 with SMTP id
 q13-20020a056808200d00b003a3645e9ec1mr166900oiw.42.1690485937049; 
 Thu, 27 Jul 2023 12:25:37 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:caf5:5ae2:432a:1bdf?
 ([2602:ae:154e:c001:caf5:5ae2:432a:1bdf])
 by smtp.gmail.com with ESMTPSA id
 u9-20020a63b549000000b00563bee47a79sm1892928pgo.80.2023.07.27.12.25.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 12:25:36 -0700 (PDT)
Message-ID: <93463ba6-b108-1ac2-8732-3aa1e257d4e2@linaro.org>
Date: Thu, 27 Jul 2023 12:25:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/9] accel/hvf: Widen pc/saved_insn for hvf_sw_breakpoint
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, pbonzini@redhat.com, philmd@linaro.org, agraf@csgraf.de,
 dirty@apple.com, rbolshakov@ddn.com, anielhb413@gmail.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com,
 ysato@users.sourceforge.jp, peter.maydell@linaro.org
References: <20230721205827.7502-1-anjo@rev.ng>
 <20230721205827.7502-3-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230721205827.7502-3-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/21/23 13:58, Anton Johansson wrote:
> Widens the pc and saved_insn fields of hvf_sw_breakpoint from
> target_ulong to vaddr. Other hvf_* functions accessing hvf_sw_breakpoint
> are also widened to match.
> 
> Signed-off-by: Anton Johansson<anjo@rev.ng>
> ---
>   include/sysemu/hvf.h      | 6 +++---
>   accel/hvf/hvf-accel-ops.c | 4 ++--
>   accel/hvf/hvf-all.c       | 2 +-
>   3 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

