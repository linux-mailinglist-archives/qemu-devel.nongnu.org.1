Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 356DD72A34A
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 21:44:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7i02-0001h3-Gg; Fri, 09 Jun 2023 15:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7i00-0001gj-Pm
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 15:42:16 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7hzz-0007ny-6S
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 15:42:16 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-650c8cb68aeso1893405b3a.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 12:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686339733; x=1688931733;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CWgEyfGBYAr6DbHtzbnXgH76n0fj4zQQnrvMvFuWBIU=;
 b=UA3Zi+Crpmm8NelxJEYfq/2Cs4g/vYk7WAvGCRrEGK9+DPOlH7+umazvM6k6maTN5w
 wSQGQlrarDlUgA3/pHCOxp9nGOnlNOB1QVhDX3/wkq46W76t6uC7au1rjdSjwxFHo0V2
 ahEL8PS7nyVU7RLe+QqJfDc3kRAV89AEu5DQiwU1ZHlcZlxIse5q4N7hLySBivHrB+p0
 tJ+1rDimbO1jhFHbeqf30zdgAVI44j+4srFU/cDbcpf+7lLLTTUXIfmg6RQa/n1uleoS
 vyfnXajtETTJSkvjqZQmEOf110ZnQbEc7Wkx+3Ge51+sPkEDQ5ZCHQpPmS8v1LlzSBPL
 /0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686339733; x=1688931733;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CWgEyfGBYAr6DbHtzbnXgH76n0fj4zQQnrvMvFuWBIU=;
 b=eQ4sxvgzDSFPQkup6VOYOW2IHMr+Q2Q7Ls3LYqGfmaQw3Cr5OmG7ndSwDo23sF5B7K
 g+IC2kkDg/oCOIjumbW29UNicibKyGFlu7aV5ZFttnYOXYtsj0zrleNUlnIqcqX6jA5h
 0S2xXMtu7Ub6SrpY1tLNrdhINdwCAaCSr9hdkJ66R84tZySXeT2+POgnWn9ybrbE3bJ5
 ANtav4JRBWPZrOXgAAXWsbu8RcHn7YccjVaouNsDXo8JnxXwhZ7Ilm6FOL4uNnh1vZl7
 f2Z6DIfAYNhZvWRG7Rr+wIB2E7GVmWo6CZeAXJ2jEEUmzvEMtGd+xU24BxlQAfWqFH5l
 HCPg==
X-Gm-Message-State: AC+VfDyJglfEQCEELsLPuGE4WOt/98v/aIJUCGcK83qm9dAUReYnKHjo
 1Nkvb5ykK8KAaRo5opGiywJZZg==
X-Google-Smtp-Source: ACHHUZ6H9YJC/ERcaRW8YqPJAeJ6RIGOPMj6AyGA1G1hkMdo0n0Z7P7g4uVwsBGNdo6wqY7zR4Qlrw==
X-Received: by 2002:a17:902:eac6:b0:1b0:6e18:ce49 with SMTP id
 p6-20020a170902eac600b001b06e18ce49mr1858130pld.23.1686339732968; 
 Fri, 09 Jun 2023 12:42:12 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:20be:c4cb:f609:8cca?
 ([2602:ae:1598:4c01:20be:c4cb:f609:8cca])
 by smtp.gmail.com with ESMTPSA id
 u16-20020a170902e5d000b001a525705aa8sm3590206plf.136.2023.06.09.12.42.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jun 2023 12:42:12 -0700 (PDT)
Message-ID: <929f60f1-187b-5258-de32-90b0e270b610@linaro.org>
Date: Fri, 9 Jun 2023 12:42:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 12/22] target/arm/tcg: Move neon_tbl() from op_helper.c to
 neon_helper.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230609104717.95555-1-philmd@linaro.org>
 <20230609104717.95555-13-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230609104717.95555-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/9/23 03:47, Philippe Mathieu-Daudé wrote:
> neon_tbl() helper is only called by NEON files. No need
> to have it in the generic op_helper.c, move it with the
> rest of the NEON helpers.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/tcg/neon_helper.c | 22 ++++++++++++++++++++++
>   target/arm/tcg/op_helper.c   | 22 ----------------------
>   2 files changed, 22 insertions(+), 22 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

