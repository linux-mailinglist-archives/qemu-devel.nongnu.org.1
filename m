Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3C6773134
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 23:27:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT7kH-0007SF-5o; Mon, 07 Aug 2023 17:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT7kE-0007O5-6Y
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 17:26:30 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT7kB-0008EE-RQ
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 17:26:29 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bbc87ded50so33039125ad.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 14:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691443586; x=1692048386;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uA0qTOqdePwQv/jpBb5xFYzpsQ2uXEnzLmfLE4BPNEM=;
 b=gfLNPdVjkhjJ169U64YgONe6HZ/M2SvW/VgrQwLxkl2HtxsbOMK26ZokKMo/ByaBYV
 qXWxFVWwCvVy5b97DrWIDcBzN7FRPG4Q6NfKBdZUvmi26Svt2+eXisC1BnT6FZUF8YXB
 yLfo34ey5QNwnOA5F6fRxwbcMd+pKQyU8MQB68YvdcUn5Npeyun+LQIl0560vQrsvQYp
 5zchUHTJI73vFofP/do1VgfKm9577Sn6L1z7ZfjkRAdDNV0VHswXoxWxOkZw4qTLsvHh
 hMXmB+GqaJfYsoc7u/Ln9R219SsRXOq2k54sWIO9RcrN0Reb0s0+1tkGKLM0AnVpkbm9
 D0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691443586; x=1692048386;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uA0qTOqdePwQv/jpBb5xFYzpsQ2uXEnzLmfLE4BPNEM=;
 b=cQJHZwHbEAPseMjz+W+0DSmEh6lRXaA9uIMGteuoueXZJjAls+G2uVzdJsbTgv83LA
 gvwAIhLjdP44DjV732wA03WzU7iLPrMJOH+bBaeGuQVBJ+Uf7evJiKmDtqX42p+NLqzv
 506sol2eodIdFb7P2ccZEEhSBeIAl2q0X8mPajuRZLGhoTFJd9n8Eya43shxE83af8gG
 Gq7tcWvWWBEmr07fTsEqgb2c+muQDrTBvRQK5lQlBDAbR49y7AOY6DXNEKMS3LZFrfxm
 +Y1W480yvci69bmSpDKfdcL7YcqbEQmVshIdOYO6tghw/HlDep/C0yl+/sLHX/4yizxG
 8zng==
X-Gm-Message-State: AOJu0YzMmZ6ji2zsnu07a/PSVgkfKE4CzIc43+eZQYofaC1KrT1xqhvr
 RWEpoTa1z8LNtkTt4xw7uMDtgA==
X-Google-Smtp-Source: AGHT+IFNQqJfN+GQDEDw+72bFhaFhpKv37GnaJ94ctWITfLfSXyxaQyD/VyuUmWn+pmBeb3HYOuQYA==
X-Received: by 2002:a17:90a:4611:b0:267:c0cb:e462 with SMTP id
 w17-20020a17090a461100b00267c0cbe462mr8024006pjg.48.1691443585767; 
 Mon, 07 Aug 2023 14:26:25 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:e306:567a:e0a1:341?
 ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 18-20020a17090a035200b00262ca945cecsm9790121pjf.54.2023.08.07.14.26.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 14:26:25 -0700 (PDT)
Message-ID: <91548e24-16e0-d177-c4fe-2a3d98f76ee8@linaro.org>
Date: Mon, 7 Aug 2023 14:26:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/7] tcg/ppc: Use PADDI in tcg_out_movi
Content-Language: en-US
To: Jordan Niethe <jniethe5@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, bgray@linux.ibm.com,
 Nicholas Piggin <npiggin@gmail.com>
References: <20230804213355.294443-1-richard.henderson@linaro.org>
 <20230804213355.294443-3-richard.henderson@linaro.org>
 <CACzsE9r1w2TQ9-587g7CCZOzjE2bsnQch6Xe3LC6binDEkB1jQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CACzsE9r1w2TQ9-587g7CCZOzjE2bsnQch6Xe3LC6binDEkB1jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.809,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/6/23 20:53, Jordan Niethe wrote:
>> +        tmp = tcg_out_need_prefix_align(s) * 4;
> 
> tcg_out_need_prefix_align() returns a bool, optionally might prefer
> 
> tmp = tcg_out_need_prefix_align(s) ? 4 : 0;

I suppose.  C type promotion rules make the multiplication just the same though.

That said, I've merged back Nick's tcg_pcrel_diff_for_prefix function using ?:.


r~

