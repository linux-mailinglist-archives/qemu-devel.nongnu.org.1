Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BD37E2E82
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 22:00:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r06hE-00008P-0m; Mon, 06 Nov 2023 15:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r06hC-000072-FB
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 15:59:42 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r06h9-0002yJ-KT
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 15:59:42 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5435336ab0bso8506487a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 12:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699304377; x=1699909177; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6sPS15HXp2zjrIE3EzZhB9UIZBdrlHd4jdlK4zKohic=;
 b=oTsQ5Eki82ZmRDhGgubY5bGujA8acE/X88wp+Qfgz6GAKqJGNFFNE8c9dlb/6DOnZn
 8wPUb+LmLv7QepJAQtAQqrtJhViMJnivW0kSN9U3l4VbAolEQIrCk9w/AdDCNp08jcP/
 XZgCbs1QgnMno/BWo4jTMQ3/Ft8cgsHc/ay6Nu9EBFu5SgCcQHEVJHEDmXbwgLe8UnBh
 5LfsjoFUFgmZud2zBd1L2kgSBJ8UNOOTa6AVamCuRttX1oQ4YQUhfMygBtbG71S9xNdg
 hDXpIXXkP6jaxkjdOGCPj/ICbyj8qkw/IELYY0jyqYdwABhexQMoh717kifNmBrV9CBY
 mFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699304377; x=1699909177;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6sPS15HXp2zjrIE3EzZhB9UIZBdrlHd4jdlK4zKohic=;
 b=BQd/3AbM3sg1ugljQqXsH61G0BS+85V27Yfh+V7wC71HAyaoKY70SAzseUBN4AW8YU
 MWrO343n4H7HKYzefVHD0H7MO2aAOArvkoPeuBvL0tzlI7AmCTsXmYOvWaoJgk1PBv7R
 ZpJ6GsmmN7OBfga7+P1yvSB+mHoBcsG7BHGpoRFA2m9Q0S3oSlXA7GFJHnga+fpTGU42
 7OrmJPkjbecXqd0YLJvP6TpwBNcaYd6ZGYFc0AP6FPbmjbqQRF4Ms9S32B93X2P8cUTf
 Fum0mXOx8LtqZPz1mfe3ArqLhm4y9Do2YrQeLDB57Pa2NDO61/LkJomr4bSRkb6kbYPk
 dgiQ==
X-Gm-Message-State: AOJu0Yzfz60WalrlFSEO3Lx+PChYVKM6g73CRFFCIrhAtd7RLUwGR0/d
 qapVOfJKvMBxS+eTguf/yZxgUIkNGaMnxmx/oog=
X-Google-Smtp-Source: AGHT+IEyF0MFf9ciekBR+xGFddsQeLtm+RINovBnwfrP15/sqtyRLP3ZUEP+mXQOttU3KQ+msrprcg==
X-Received: by 2002:a05:6402:cb6:b0:53f:d261:7945 with SMTP id
 cn22-20020a0564020cb600b0053fd2617945mr22964649edb.21.1699304377528; 
 Mon, 06 Nov 2023 12:59:37 -0800 (PST)
Received: from [192.168.69.115] ([176.172.125.26])
 by smtp.gmail.com with ESMTPSA id
 s18-20020a508d12000000b00540ea3a25e6sm4830280eds.72.2023.11.06.12.59.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 12:59:37 -0800 (PST)
Message-ID: <4e2346b8-6c2e-4c43-b869-c3c9b2ead305@linaro.org>
Date: Mon, 6 Nov 2023 21:59:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/35] tcg/riscv: Support TCG_COND_TST{EQ,NE}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-19-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231028194522.245170-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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

On 28/10/23 21:45, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/riscv/tcg-target.c.inc | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


