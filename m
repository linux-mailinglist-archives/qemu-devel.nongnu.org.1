Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8B37CD1DA
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 03:36:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsvTl-0006Ys-UG; Tue, 17 Oct 2023 21:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsvTj-0006QU-2B
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 21:36:07 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsvTh-0003QE-He
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 21:36:06 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c9de3f66e5so39601265ad.3
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 18:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697592964; x=1698197764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sMVXFbQ8krTj5weNoLmeXogaGVSWyjI6aQDwqYKPQVk=;
 b=bJ6OgLANiBL6vaLtvn1D5fuMzlgpvmFa4XHv7oI0FYntyncEaiCVuuGMW1y9dBHsqp
 cmKK4uI5cAtgr/6zEjqJgdkYGQj6Ktyu5j8L2rb6vJHeyBA47+kUYA0FZvydUXzvhqU7
 qIkbGL2oymYSvrSL/6X4WU+LtltVz7aShSJR23aPNGgyJULObAe1lR1cCV6rWg3PctYV
 QISSH841Hq4dSIDdaIWTKk/MVud6DrXWbovst0joIv1LVAxxiCK/t7iQd0d3mqrL3ohD
 2hRpwGHwx64VFxFHmkTUaU2lNFqDufIXWlhUPORKl6vA+mow0hDmhYUe9GvfzAPUZCbe
 bjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697592964; x=1698197764;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sMVXFbQ8krTj5weNoLmeXogaGVSWyjI6aQDwqYKPQVk=;
 b=dXWr4ZQB6utwUAXWuX48WJ88qDdujC7KOaiR93rF2TWrOxNT+pRsTu86+rU3UbNLhG
 l4jZdD9KJh3NTA/fXgm5+6097bSTOtJ58LEmaauAmMX6ZRMoz0GOEvFsc6NiOsfXzSX8
 QhHiSrNcsWdgTVp/D9LZV8n0TCbV4Il0j98PeI+D+FfViC7/n6m3gQ6rne5YEreWj3TY
 QZ4GIHPxSiUf8657KBEiZMRvW5hpboeJ+bt9692FGI0G8xwJQGxC26Ea7KEew4RJoK3w
 ZCsEXwCUP5sq/RS7eFDktFgw6L23P0WqFY/9wCTx6/MTp6NPpGG/iETVEQPygu6koAwD
 HUIA==
X-Gm-Message-State: AOJu0YxHbt9T3pYC6H6f5nM3/aE4sPavTmv76+lii7uZrZbdd85raB+h
 2JKwuPbUM+70aywGgLw17OSjUinqNF8tUYJza/E=
X-Google-Smtp-Source: AGHT+IEvHOm0yS1FHTrj0ExJfBvc2++A/wlU0F/vJVAklZJeLaAr0zSwqIx22wY85VZ9bI2LGlCVxw==
X-Received: by 2002:a17:902:f98c:b0:1c7:4973:7b34 with SMTP id
 ky12-20020a170902f98c00b001c749737b34mr3595786plb.50.1697592963857; 
 Tue, 17 Oct 2023 18:36:03 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 jg9-20020a17090326c900b001b9c960ffeasm2249064plb.47.2023.10.17.18.36.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 18:36:03 -0700 (PDT)
Message-ID: <17de28a5-80fa-4cac-a98b-5bb3bbfe6647@linaro.org>
Date: Tue, 17 Oct 2023 18:36:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/18] target/i386: remove gen_op
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231014100121.109817-1-pbonzini@redhat.com>
 <20231014100121.109817-19-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231014100121.109817-19-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 10/14/23 03:01, Paolo Bonzini wrote:
> It is not used anymore by the old decoder, inline the CMP case into CMPS and SCAS.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 145 +++---------------------------------
>   1 file changed, 12 insertions(+), 133 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

