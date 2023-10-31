Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1387DD82C
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 23:21:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxx6Q-000557-GI; Tue, 31 Oct 2023 18:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxx6M-00054X-8R
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 18:20:46 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxx6K-0008BY-Nb
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 18:20:46 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6b87c1edfd5so5170985b3a.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 15:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698790842; x=1699395642; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BOAONDCGHwMnQ7RpL6cDA8vfxIZ+Vnw5igk2HNytNvs=;
 b=FLLdLdtPJHtu/q5v8AHAzFhNFhqz5X3yMEYoxBtaIkG8gPbHMExlm/Ohy51PH15VGE
 MVJazbHzY56cfxHXtIXaEjlhBDQglaWMkRPGzWwO94VspYmC1tQ8YI823BqGQdJL/oZq
 RGORCJkBiVlOCCTWKz0LRfMjphW5eKdQxFSD1EDtycGX623BXYJ/JENQCAC9FezYt9jS
 ShKiQ5prGyClGHZD1oNFL+SXq/t9XfPuP0IjcmlAO5DwtPg5iYxmQ6YeznU2XIw6W6M5
 EYx5/+uzlRsn4h97upzXR7HtxIACr9fkmFpg+yTj08PtdLDmJ2UUHjFQGficEjBsl495
 KMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698790842; x=1699395642;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BOAONDCGHwMnQ7RpL6cDA8vfxIZ+Vnw5igk2HNytNvs=;
 b=uCINrGQ27DOAnVyV+jXlMqqiz2GvjBr60Gzia/8xgr5N1WJwVew1nDje7KY0Ju2uFj
 hxzx8d3Zu0oeHjVx+wwnVMjFctdjX8YdNFpDzyPN7N26lNKGlKXA/8XB2V+vghuUbgt8
 T3gDFC+ZHVNUqiu01S3I5gWOIso6yNx+9WkYjy526+/CL3ve1mXT5nOtUxewaFRAIjew
 CuS4jA8g4gHnGdt84SwYAPhWTgXvSfGQsvDJHnuvd2PZjyXBZ1aKaK9f7e7EqNsHLOCZ
 TTJgh6rRuGV5PR+TW5QlCAWCnwBUZ5DZVHaLE7GCjHTR7PnioDxi71W9IjaEkzzBpZrN
 GMXg==
X-Gm-Message-State: AOJu0YzY09UK7RoYETReHBqV2xxZnTOmNYtTFrT19F2n6OralXewLK5a
 MLjJsReTtBZC+vRu/gHKc/xV7CBvafSbvu6dnPo=
X-Google-Smtp-Source: AGHT+IFuCG0KtdJ8iaqJeEmarwJvp1BEs54LWeq3eqIJ8eTc4q2yBkZqL32MRPgrrycwtM7sNv6uQA==
X-Received: by 2002:a05:6a00:a27:b0:6b7:18c1:c09a with SMTP id
 p39-20020a056a000a2700b006b718c1c09amr11518571pfh.5.1698790841899; 
 Tue, 31 Oct 2023 15:20:41 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 b19-20020a056a0002d300b00690ca67d429sm107368pft.100.2023.10.31.15.20.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 15:20:41 -0700 (PDT)
Message-ID: <735ee998-20e8-449c-a4fa-79a3ec7aedfc@linaro.org>
Date: Tue, 31 Oct 2023 15:20:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] tcg: Canonicalize SUBI to ANDI
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231026013945.1152174-1-richard.henderson@linaro.org>
In-Reply-To: <20231026013945.1152174-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Ping.

On 10/25/23 18:39, Richard Henderson wrote:
> Supercedes: 20231025185956.72677-1-pbonzini@redhat.com
> ("tcg: allow a target to request canonicalization of SUBI to ADDI")
> 
> Based-on: 20231025072707.833943-1-richard.henderson@linaro.org
> ("tcg: Introduce TCG_COND_TST{EQ,NE}")
> There a couple of optimize.c routines introduced which I use here.
> 
> The final NOTFORMERGE patch suggests that I've caught all of the
> cases, but I certainly wouldn't want to merge the assert without
> a lot more testing.
> 
> 
> r~
> 
> 
> Richard Henderson (4):
>    tcg: Canonicalize subi to addi during opcode generation
>    tcg/optimize: Canonicalize subi to addi during optimization
>    tcg/optimize: Canonicalize sub2 with constants to add2
>    NOTFORMERGE tcg/i386: Assert sub of immediate has been folded
> 
>   tcg/optimize.c            | 35 +++++++++++++++++++++++++---
>   tcg/tcg-op.c              | 25 +++++++-------------
>   tcg/tcg.c                 | 49 ++++++++++++++++++++++++++-------------
>   tcg/i386/tcg-target.c.inc | 13 ++++++++---
>   4 files changed, 84 insertions(+), 38 deletions(-)
> 


