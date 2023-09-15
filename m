Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3647A1B24
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 11:47:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh5Q1-0007FA-Mh; Fri, 15 Sep 2023 05:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qh5Py-0007CB-CC
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:47:18 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qh5Pt-0002LJ-5B
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:47:18 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-99bdeae1d0aso241017866b.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 02:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694771231; x=1695376031; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UKjxf1SZDXmQFpyPOOLNqvYrCpo04KEU3dcRX+wxLb0=;
 b=uqtIIkeOVqEFvaS5s29OgtDKX7qblDa5weILzpirSnXzdeWh1QPrKFgkLAUVf9XfCB
 A2vXpoa6hiZ5RfHwZIg542h4A+GgyYXSqXShujkVAhBm83F6yPvHPwKgDPkdrzr9cAlV
 9nHMAAeL2mVHPZhJNQvh3wOySj/Vd/WceYeabZgezyvQDR55GVbKp/+i+f6p3qQCFkxq
 Y5kskesjDTYXuUQEUlrGhWvVPdMBSZ0OcQBRiMVZnch0soq0srRnodZQjSDtV6rNzboN
 PZVp8m9n0A+t/uGEuHgFFxIEguiwjOAGb79B0TTt12A++rXmC0v38JcHa0R91YYdFGG1
 N/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694771231; x=1695376031;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UKjxf1SZDXmQFpyPOOLNqvYrCpo04KEU3dcRX+wxLb0=;
 b=cIGKhkD6kCl0rH+/LW4R39gInhwzLgMol8dAvVN32tzWS1Ag2lCak4xF6+YyUslsUQ
 tX9s85TQXXFPettlZmaFPIFv0nWwSTQhyyWGMt0+G6FW1V8sfKqm/u98dS8OOz9TFVN6
 9LQDdLz+b9vbhGKPTPQrMeesur72hNz5rJYChs7fYlEFM4GUl2afnH8z/K8mGoCKUQG2
 ACBrEwOvBwRy+l/3/Hh6ZZiQMG4aytNxC7RaxgtnP/l3jwulZ10fKV1D1kG08b0qAxlQ
 U7Cq7bwvifR8vhrAs8190izpJ1tIRdZ8TMZyKVmtDLSiEuXga1b9wtBZf9GPtdZle/Fa
 Redg==
X-Gm-Message-State: AOJu0YyVcv3ur7muBi2HWL2SFVQGJMLj5oC49fNen8a/ao5yDIPHi3p5
 +J1PcsT33w1DWb1CVytMr4LrL7VDAV5tgzt4TY4=
X-Google-Smtp-Source: AGHT+IFIHjJ/3Cd70sqesseUxu4+NiPlFl/PPR9hyEqkZKlUFfSepV0UfFkvC1IPU8ISvyYil7Pnkw==
X-Received: by 2002:a17:907:7883:b0:9a1:cb2c:b55f with SMTP id
 ku3-20020a170907788300b009a1cb2cb55fmr973071ejc.53.1694771231209; 
 Fri, 15 Sep 2023 02:47:11 -0700 (PDT)
Received: from [192.168.69.115] (176-131-223-129.abo.bbox.fr.
 [176.131.223.129]) by smtp.gmail.com with ESMTPSA id
 v7-20020a1709064e8700b00977cad140a8sm2135171eju.218.2023.09.15.02.47.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 02:47:10 -0700 (PDT)
Message-ID: <b2e75a5c-35f4-2012-610e-e5e4fc1f98d8@linaro.org>
Date: Fri, 15 Sep 2023 11:47:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 4/6] accel/tcg: Improve setting of can_do_io at start of TB
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230914174436.1597356-1-richard.henderson@linaro.org>
 <20230914174436.1597356-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914174436.1597356-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 14/9/23 19:44, Richard Henderson wrote:
> Initialize can_do_io to true if this the TB has CF_LAST_IO
> and will consist of a single instruction.  This avoids a
> set to 0 followed immediately by a set to 1.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/translator.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


