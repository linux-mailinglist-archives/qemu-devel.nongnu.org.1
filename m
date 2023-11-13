Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1997EA2B7
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 19:19:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2bVn-0007wR-Am; Mon, 13 Nov 2023 13:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2bVl-0007q7-3y
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:18:13 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2bVj-0000YU-Fh
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:18:12 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2800c221af2so3806445a91.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 10:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699899490; x=1700504290; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cUZHYtdDAzSjFTXLnaas09EEkDjSU/8RG04d1d7Vlz8=;
 b=WV3Gnw2xcivtX8D+bRiCgFjmwEbwfiqrPBOLbgi2IpdEk6UFbrgypqnlo7qkwb1gbN
 uBBVpLXb1CClZ0/jcS86BdobQTXbR7xtyqN6kXGtsvZnK98KxZvGmF09GV0TiILx03Vg
 nLseuqho7E1F7SyR5J9shL9zta5IFusPCJlo9bVg0lEmja6OR0KElLQ2xzemv9xWXtLH
 femmEa/fPb6rCu59qQVaB5VJRbzZj8L7aKZH8on8k+GIeCGhVQByaPN/UOp2xsomGd0w
 dPb7XgU/dIG+XeO6VXSrLFMqFFxtEPJOiLEdDP5ehzDSOn/Ff67cn+X4IhcbMorGQ1ys
 qRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699899490; x=1700504290;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cUZHYtdDAzSjFTXLnaas09EEkDjSU/8RG04d1d7Vlz8=;
 b=CMT8WsF505L7YuvsnC1JbbPcn6W95Lps2zKlFooi3/Ty6mH70Lf5B/gxXLBpFQMM6k
 T0t6xC7GdBmDJNdIfeNXgmZT+XqrO+pMnadeqWY3nrESR7j7ehKd65jhOpn4yJEJjnlc
 bYQkP4zs3McjNAnZiONiDOuEQlhF0IBGWq5yGIpgZNqLRbY43KftOpuly7cb8PGVQ5bR
 SqSmROS8R5BWKyLUTmq7Uos70Ra1LmH9BLHVHdYmAHLeDXIs3RrewrIN2/R/CMDr77yl
 3AuR8eHF3ytLXksUuq2yOW7SSwOLBA1G7JwTvy4UoZqJcdszP9qy1uYZFKI+wNupr66o
 WaZg==
X-Gm-Message-State: AOJu0YwQYFJYJmyiqIfpZBWCcbMxT1QeWdQFvBMFIDxuhSDHPOUclbXt
 pvxZwkgpA+fXz4Px8gCb8IGRHw==
X-Google-Smtp-Source: AGHT+IFJSWU0EbEsWYs25C8piGyK3+q/+cqma/6uQPpfrlrJMZSyxnmKER/5e0gBjmHmts16wFp5ww==
X-Received: by 2002:a17:90b:1a92:b0:280:bb7:9fa0 with SMTP id
 ng18-20020a17090b1a9200b002800bb79fa0mr5083402pjb.43.1699899490100; 
 Mon, 13 Nov 2023 10:18:10 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 ju10-20020a170903428a00b001c59f23a3fesm4142792plb.251.2023.11.13.10.18.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 10:18:09 -0800 (PST)
Message-ID: <ed177c44-6a59-493c-9010-1d534b0109bd@linaro.org>
Date: Mon, 13 Nov 2023 10:18:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 05/10] hw/xen: Use target-agnostic
 qemu_target_page_bits()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Woodhouse <dwmw@amazon.co.uk>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Paul Durrant <paul@xen.org>
References: <20231113152114.47916-1-philmd@linaro.org>
 <20231113152114.47916-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231113152114.47916-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 11/13/23 07:21, Philippe Mathieu-Daudé wrote:
> Instead of the target-specific TARGET_PAGE_BITS definition,
> use qemu_target_page_bits() which is target agnostic.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/xen/xen-hvm-common.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

