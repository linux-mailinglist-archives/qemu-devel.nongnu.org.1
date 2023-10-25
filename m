Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7942C7D78CF
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:42:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnVp-0007HN-2g; Wed, 25 Oct 2023 19:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvnVj-0007Fh-Ca
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:42:03 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvnVV-0001N2-Jg
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:42:03 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6b7f0170d7bso274385b3a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698277307; x=1698882107; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nARN9n65iF4g6yjW1J1v+Ru5RhoGyCy34q1vACMDUok=;
 b=QXb1nrmH/LTpRCEdZK+uFLjzWtkvntdlXWw8df/2RvzYuMQkNBr1qOzGpoA2Io7fwl
 2SSI1ds8R+W76cCZ6E+nt2cFA8iywXKJX8ozspRxBXEozReBed00Cykb1oDtL3zGmGMp
 mfthfI1TZ2KZMgdduS6lEyDtNhZnJJC6uXHAnKDY6+qQmSjMk8cb2YXDC486tew7h6Tx
 qkcTBr9o3JZ/d+RAbcPbB9wecH8pU5YVyijpBgg2PY/Hsgqi2DMaucCiNwHzfUXBkncN
 wT0BvebD0ukqBdKQWWr3W6z3Ry6jL50+/NoL8hBM01hC4osGmPT8yqwTD4Um5E1kMcs7
 ExAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698277307; x=1698882107;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nARN9n65iF4g6yjW1J1v+Ru5RhoGyCy34q1vACMDUok=;
 b=dewQPZntkq5cq7NgVPFgrWVQHN5cP4ELvbi0tbz6LwA7aRPgTIaIlhSsyTFILSV1Zw
 SVl5cqgIvOwL2HoXz6vY/cdnkPJgPuKJ2epbe6uVWnBd+deLc/+agL8M7RqkJhPjuqbU
 w2PqtDgUp1eoZ9wcDWPHlktdLBbbzbf/fFSCE5IGSAoVMzqOs0coPU84kkTpzf1Gb+rE
 Hcum8p+eOeK/JEraUBPpfX/zCJ2AUVIexRnERGPv+zYff1MjgkA9HBQzu2jGaNy3wzVr
 nzS7x8bfG51eRFTH2UWrjSOn8K4z2DoOGMxnaNMLAw3jcQUJZG++qr0/tq3qcYVXWsYt
 4sDg==
X-Gm-Message-State: AOJu0YzyjdYPMCLIC1vZEztMywewBRgjNythT5gdl7RcUQqWdaAqOcrr
 duH7uyGANc1mzpcM+07tpwanRw==
X-Google-Smtp-Source: AGHT+IEltmQBiFrfj74ABGdOTcBX78DJrXar221VALqhrQ+Dqq4LbabJo5r+bTH7SZ0RNrWcChF6pQ==
X-Received: by 2002:a05:6a20:3d8f:b0:15d:5f9a:3921 with SMTP id
 s15-20020a056a203d8f00b0015d5f9a3921mr8019343pzi.27.1698277307638; 
 Wed, 25 Oct 2023 16:41:47 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 y23-20020aa79af7000000b006b5922221f4sm9931736pfp.8.2023.10.25.16.41.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 16:41:47 -0700 (PDT)
Message-ID: <12febade-6f85-484e-b416-09fce7eb38a5@linaro.org>
Date: Wed, 25 Oct 2023 16:41:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Fix syndrome for FGT traps on ERET
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20231024172438.2990945-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231024172438.2990945-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/24/23 10:24, Peter Maydell wrote:
> In commit 442c9d682c94fc2 when we converted the ERET, ERETAA, ERETAB
> instructions to decodetree, the conversion accidentally lost the
> correct setting of the syndrome register when taking a trap because
> of the FEAT_FGT HFGITR_EL1.ERET bit.  Instead of reporting a correct
> full syndrome value with the EC and IL bits, we only reported the low
> two bits of the syndrome, because the call to syn_erettrap() got
> dropped.
> 
> Fix the syndrome values for these traps by reinstating the
> syn_erettrap() calls.
> 
> Fixes: 442c9d682c94fc2 ("target/arm: Convert ERET, ERETAA, ERETAB to decodetree")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

