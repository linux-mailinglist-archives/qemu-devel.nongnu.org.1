Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85958772A48
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 18:14:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT2rB-0002ya-9R; Mon, 07 Aug 2023 12:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT2r7-0002y9-BP
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:13:19 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT2r4-00061v-SI
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:13:16 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-686b9920362so3033170b3a.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 09:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691424792; x=1692029592;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YIHbwdFY9z8HluTnzOFJLCNHJX3lFlAdL16cw1yuftY=;
 b=Sk/3hvVm/8784pLP9gNmAjxtR5nEOqaZ2e2Yu1C63qSEasi5+L86y05R/uPG4E4Q7A
 X92++6yVrlftz1CXjYvlAcixxQxXyJl6f1ZV01qwwgUQ/Ux7mV/iaWc4dLgglfm/RSy+
 J79iuFL/0yV4RmFrVLCHj10zioIRISReBFZhwD/i+l9oyOO6Wg8EvCH0yyIs0VeaxACj
 SO4kOnT6j7cqZJA7DZvQy8mEhxKZrhjLYLPDO3OKi8wqpa5GqsgxnFtElPoM52e5y0vN
 SSULtQLqssq5b4s9sQfgj+BDFQnXMfiXOwjlR+QYEVJ3BY7C/G3kdGJO2RrxALUnW7Qf
 3QgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691424792; x=1692029592;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YIHbwdFY9z8HluTnzOFJLCNHJX3lFlAdL16cw1yuftY=;
 b=LqBcUuXyoPobqnfXzgPXoldVF4NaohsEqMSYbIXzeTWHPYtTT1BLVs93yCIaWWPYLz
 /6Bvl0JQVARE9v0JOCZyqCrrwYlSAl+f8whVujQOzfywppH/GosdVrvjM8eEVlRzqhQV
 CW5rJzN8wS5mbfayLuIJ6mQ4jMUKlKDoPgF7+f+pDWxOb60WpYlJ3pUkWLWaPWwQKYXH
 UwZwr7TrjNincK+QUC4jd6GhDBQ2V4H039QtLZDYQ3MoAxvc75KbAEkGmB1aA/B7UY0I
 rksY5XjT2V6wSt4JyFFH7+Jo482p0bgM2e92FVXr/FT2QKuqid2H1Lhq+/LiRR8U434u
 ncJg==
X-Gm-Message-State: AOJu0Yzjz//iHVuo54nEARlFCsxkwEpEuJPy5Zl6RD3t67FFGNn1kINm
 WuV8EG0/U1FYkaSEV898vkYfSw==
X-Google-Smtp-Source: AGHT+IF4sg60htCL/ZIHQn44scAgQjNIbLUXmBWqThCiVgwFCzDMElr69bYn9/yg4a06XOZUJzmY5A==
X-Received: by 2002:a17:902:ac97:b0:1bb:de7f:a4d4 with SMTP id
 h23-20020a170902ac9700b001bbde7fa4d4mr7402162plr.61.1691424792496; 
 Mon, 07 Aug 2023 09:13:12 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:e306:567a:e0a1:341?
 ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 ji5-20020a170903324500b001bc445e249asm7111998plb.124.2023.08.07.09.13.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 09:13:12 -0700 (PDT)
Message-ID: <c71711d6-b56e-75c6-3126-fb7bf3ed3591@linaro.org>
Date: Mon, 7 Aug 2023 09:13:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/3] linux-user, configure: fix CPU canonicalization
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20230807094807.471646-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230807094807.471646-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.809,
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

On 8/7/23 02:48, Paolo Bonzini wrote:
> Paolo Bonzini (3):
>    linux-user: fix detection for x32
>    linux-user: cleanup unused linux-user/include/host directories
>    configure: unify case statements for CPU canonicalization

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks for cleaning this up.


r~

