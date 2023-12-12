Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6355680E0C1
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 02:19:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCrPs-0006Ir-BI; Mon, 11 Dec 2023 20:18:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCrPq-0006IP-7S
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 20:18:30 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCrPo-0002Wr-Jb
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 20:18:30 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5c1f8b0c149so2795712a12.3
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 17:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702343907; x=1702948707; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wfR79JrO8oInUT1fsDkVIyYsxgoZP2fWLUKE4BnW60c=;
 b=d4JIcmpCQV0UuYxqcBvAu0T39STckVsv+ml/HwS6K85B4FfvdKsgXQZIXvu58ihVTf
 LNQdbay72QNdDM6vih92DDpICLdW4D38LLNY38+dgOP9euKO/3PYBP/K2nzqdmlzCZo2
 phnhOqr4WNFjblOkpEazKc5FAgn6ZNa6ICnxV3JBbkmQAnTOtE/E451/1cVq3tORcFEq
 UGx3LdIjcsZtlpqgrELEMBgNy1Pa60eiVwhJXWFX9SEs7dI28xjhn3JRX3WRGkYsEeHV
 xm4Cpm5YEDMP2ymbZnNl6eQc/qzEfKyzjn2g5G1Hfqini24//NZvbhRlKcIup1siLXMx
 HHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702343907; x=1702948707;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wfR79JrO8oInUT1fsDkVIyYsxgoZP2fWLUKE4BnW60c=;
 b=aje9DYym/s9zws5bZALXDdh6VmJm/BzKa07/viu6fBgThCgszDRxu5wQxbmulu7owh
 gXq1roFBvkJhCUgDG5XGywebhWo/AFjp9E+xtUguGwEqsuJS7vcXciJmkeRiMwUd1P15
 l8iY6OlH7nCHoPGai48zB7AG0ucmYywK3dwkKLn3gop4bUZL565zte4oaLfOXd4w0kGw
 VeidOp8NOIUcFpjKEDPCmT+MXcPV6sSuQ7XTJI//sFlkV2R+Zd9CjWzM95ZDMi6zBJd+
 Ie8H+Rofvr1R5UWPt13YHHX4x+T8MKbxf0+7fzjaxDiwPDfW106McnjIUW3Ru60kxaUO
 aOVw==
X-Gm-Message-State: AOJu0Yz6NGlC4HOU319l7dXlwfCeakZfEkhFNN+u5vTvX/3fEK/Uh31k
 jUV8O+wu1GIJ234k9I2dn3V8Gw==
X-Google-Smtp-Source: AGHT+IFlizFRfqp9L8PtCaCYjcncfYhGR+tdeyCUoMzIhma84z78F+QlLqi1i/gdYv3Or8hCg1Q/Wg==
X-Received: by 2002:a05:6a20:429f:b0:18f:bf28:536b with SMTP id
 o31-20020a056a20429f00b0018fbf28536bmr3453823pzj.22.1702343906746; 
 Mon, 11 Dec 2023 17:18:26 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 12-20020a17090a01cc00b002850eb8b6dcsm8382402pjd.44.2023.12.11.17.18.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 17:18:26 -0800 (PST)
Message-ID: <98de081f-9a24-4019-8834-f7e4e6c209dc@linaro.org>
Date: Mon, 11 Dec 2023 17:18:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/24] exec: Declare abi_ptr type in its own
 'tcg/abi_ptr.h' header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231211212003.21686-1-philmd@linaro.org>
 <20231211212003.21686-21-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231211212003.21686-21-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 12/11/23 13:19, Philippe Mathieu-Daudé wrote:
> The abi_ptr type is declared in "exec/cpu_ldst.h" with all
> the load/store helpers. Some source files requiring abi_ptr
> type don't need the load/store helpers. In order to simplify,
> create a new "tcg/abi_ptr.h" header.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/cpu_ldst.h   | 17 +++--------------
>   include/exec/exec-all.h   |  1 +
>   include/exec/translator.h |  5 ++++-
>   include/tcg/abi_ptr.h     | 32 ++++++++++++++++++++++++++++++++
>   accel/tcg/cputlb.c        |  1 +
>   5 files changed, 41 insertions(+), 15 deletions(-)
>   create mode 100644 include/tcg/abi_ptr.h

I'm unconvinced about this being tcg related, per se.
Leave it in include/exec/, with exec/user/abitypes.h.

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

