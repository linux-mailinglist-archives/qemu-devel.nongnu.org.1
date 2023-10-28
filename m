Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E2E7DA99A
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 23:20:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwqhq-0003QU-Qd; Sat, 28 Oct 2023 17:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwqhn-0003QG-Ll
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 17:18:51 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwqhl-0003Nq-Iu
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 17:18:51 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3b2f5aed39cso2004259b6e.1
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 14:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698527927; x=1699132727; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qfD1feqxPFmrM2GIEYjN7ItgwZUW89j42Wh4Wwsqjzs=;
 b=OZnoofdMXgCflg4/jsHqEW7leGc5Bl/x2VK+/Fsqn1HNtzzIGzU+K0ALhn2+xqXs8m
 CMCkhPW8SZnqrnLjQWMrlR7axoEeynuJnhqVO5Oj1SvDJRr4blONba1pm6GqJm+nDU7D
 iLf5tMfPWUyYEfKTqs1YWf2RM+Vof8GZ47VPL+bSq2+qrsnnIUgcUhK2jUrY7AgIgHYX
 AAp4F1USeuwHisbl9I4Kl8qMApxc5tTzCuZM5kBuEos5k4C1fPC/7u0Id6VUIdto8kd1
 AqeXjcK48+tPiwyz87eZ1S65/iCMHrG1XlhIs9rbntZfCrBIuhLvZtQKGbiPJz4MaOKm
 0L8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698527927; x=1699132727;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qfD1feqxPFmrM2GIEYjN7ItgwZUW89j42Wh4Wwsqjzs=;
 b=Uho6eErdHGz9AOlByjLTJFARH4FBQdpdCwVmoPbXI/m/bw7yVf8QVbZ3kX5inZeI9u
 e5iE/rUn8oxgMq/VTArobyanoHOdxxnT9Dfbb1WP4nAhXibdwW9zVlxZssyDMwiAvkrj
 zjDIUssQ8o4kWq2lVJvhUJy4uRjdMRfuCZ2QI5/jzuHYLzC9CuM7XpUYiKqkPQtAvf0P
 /PGQIfSejiTD2iEXP4QPFz46L/TzCHpV6WZP1+VlRUC0cm63fx4rcrLhdOQ8tIY+JZ+M
 Gzuq6Uy0yqZq0Yw70GDDds77rlc6Hsb4Ato+J2/z2z3LSSpr/anBkyOK/cJnklc2tN/z
 kZng==
X-Gm-Message-State: AOJu0YwPT+dTF4WH12rZbLk0dA33bcyEUfdPx0Je8ePFvhqh6bm4RzdR
 GF9rzGJ4lyDs+0cmRpPfFXlpOA==
X-Google-Smtp-Source: AGHT+IE5rv3/v3f3HWLyhXpfgDacwV/kLL4ZD8n+jMk9G/jCQOM3/e+LI+BRmKm8OpVSnVmVc356tQ==
X-Received: by 2002:a05:6808:243:b0:3ab:5e9e:51f1 with SMTP id
 m3-20020a056808024300b003ab5e9e51f1mr6703446oie.46.1698527926882; 
 Sat, 28 Oct 2023 14:18:46 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a056a0023d100b006c0316485f9sm3343700pfc.64.2023.10.28.14.18.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 14:18:46 -0700 (PDT)
Message-ID: <956a55d9-3b18-4acc-a078-36f64486d7c4@linaro.org>
Date: Sat, 28 Oct 2023 14:18:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/6] linux-user/loongarch64: Fix setup_extcontext alloc
 wrong fpu_context size
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: philmd@redhat.com, laurent@vivier.e, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, laurent@vivier.eu
References: <20231010033701.385725-1-gaosong@loongson.cn>
 <20231010033701.385725-4-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231010033701.385725-4-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

On 10/9/23 20:36, Song Gao wrote:
> See:
>   https://github.com/torvalds/linux/blob/master/arch/loongarch/kernel/signal.c
> 
> The alloc size is sizeof(struct target_fpu_context).
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   linux-user/loongarch64/signal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

