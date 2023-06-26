Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F1F73D955
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:14:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhMh-00041v-Pw; Mon, 26 Jun 2023 04:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDhMe-00041Z-SA
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:14:24 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDhMX-0000sO-Ug
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:14:23 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fa8cd4a1c0so11118115e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 01:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687767253; x=1690359253;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FaNXnhQtfxVrjkr0JiGgbTSmQ6f0idMuGlXkbfil3rw=;
 b=zF+XmA/EmK1hKE74PSiFgm2ckKqaHm0mqz5TVJLCrlPsEocU7Iuu9tz0JI36+n5Fu9
 QeAnInzL9IsEizbUpVtd5fMFsLUgfu6XjVDYWNN4DS0w5m0dJm7mCRxsDBNac60tjkee
 GnujhZYUrXNalqACqUtSQrh3KfEbHyx1LXEKHlS2hOo1OLvmO7wsnhN3NE8FrpYF6iGD
 ZaxeogCSgTlwi+nD1zoRhWmSjvX5ia2iUMBN0g4qnH4ntAxFu+J6Y0C82OyyyX/Fp/3O
 vT8srHOGCI2n7dSUa2qqAg2HyFQ8YLNeg+r0pi7HygyU6M9oCGFWlPojkLszn8zePf2N
 al9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687767253; x=1690359253;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FaNXnhQtfxVrjkr0JiGgbTSmQ6f0idMuGlXkbfil3rw=;
 b=CywMJ8UkrbGavaVSty3JYl+cRTy0TPTeik+jqB5bFhHYnn9OT4IK8nGEJjtq+0HZ2/
 SDNjTlo5vBLssxOLCiIsLGFOGUn7t1yKy2MdJUe2RjSIW86VCgtofNb8QD3xBA4MDy0t
 NNJ9xKY1h9gWVFOex/bE20+QfP6pGKFF0MEapR8MFb9rWIFyMOFBvggUmREOLnEu5Hca
 +OIjRU1biKnKB+WAR6GqO2XCN2P8hC0zCKnW2rzK6LY+6Z//dh6WZEzX2q1ZpL1+D6/6
 z1zv3tmMJhmcD1rD8sx2H2aopUGJWN+w0fS58nV/iY3LZst0c4j0uEugUdgFGhuDGoYx
 Yhzg==
X-Gm-Message-State: AC+VfDx6XRqQK8cYviF+xpzpWDdKnIvYqmYhWFA/Y1uneHZ7/Wq2+rZe
 AjPDrZIGp03w4de0frXcjinCaw==
X-Google-Smtp-Source: ACHHUZ6PCmyy/biK3qQ/Xxmf3Vpd9OTo9KzZX7Yk57ceTSDUliO0XISGgGWNhHjYH6T281ftEVE1Ng==
X-Received: by 2002:a05:600c:2113:b0:3fa:7dfb:b7b9 with SMTP id
 u19-20020a05600c211300b003fa7dfbb7b9mr6897912wml.41.1687767253079; 
 Mon, 26 Jun 2023 01:14:13 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 p22-20020a05600c205600b003f8044b3436sm9756158wmg.23.2023.06.26.01.14.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 01:14:12 -0700 (PDT)
Message-ID: <cd82df1c-5b3e-269d-84ed-c9e09d8e070c@linaro.org>
Date: Mon, 26 Jun 2023 10:14:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 15/26] tests/lcitool: introduce qemu-minimal
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
 <20230623122100.1640995-16-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230623122100.1640995-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/23/23 14:20, Alex Bennée wrote:
> This is a very bare bones set of dependencies for a minimal build of
> QEMU. This will be useful for bootstrapping cross compile images based
> on things like Debian Sid where stuff isn't always in sync.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/lcitool/projects/qemu-minimal.yml | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
>   create mode 100644 tests/lcitool/projects/qemu-minimal.yml
> 
> diff --git a/tests/lcitool/projects/qemu-minimal.yml b/tests/lcitool/projects/qemu-minimal.yml
> new file mode 100644
> index 0000000000..507f1f6881
> --- /dev/null
> +++ b/tests/lcitool/projects/qemu-minimal.yml
> @@ -0,0 +1,23 @@
> +# Very minimal set of qemu packages, used for early bootstrap

"early bootstrap" doesn't seem like the right phrase.

At least it reminds me of gcc building itself once, so that you can then do it again with 
the full environment.  But we aren't going to do that.  We just want to sanity check that 
some host-specific bits don't contain typos or get bitrotten.

Perhaps "used for minimal cross-compile sanity checks"?


r~

