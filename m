Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 595A273DC16
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 12:15:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDjEo-0007xy-Fl; Mon, 26 Jun 2023 06:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDjEm-0007xA-IE
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 06:14:24 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDjEl-0002Q8-1A
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 06:14:24 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fa9850bfebso5224805e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 03:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687774461; x=1690366461;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+ePr3lO0hFViGKBVcx618Y5ELh+ZCONib46qb3ps8cc=;
 b=jFprbiovpruRdbwh6FBklgtV4A1Ge3DOTNJsLmkYtZyhpKXY1au/Y803PPyzVrMQEb
 hTG3bGXcCJvRKf42F+i4lWkjC1qYF2sboZHf6/HBTDapac6qx2lPR21IDE6O3lU7QAHp
 4wQrpehHzfchUrPo18co69kRp9giIcSAgko60oGUwZ47kGgNRMWKr3rwTN2QV/Vzotl1
 bg6iZERT+5OHzAqcKFzyWLiddo7szv/Vwe9Wwhz7QYiCTgkRnC+dn14g6ZfpKmIwNbaO
 kiUSUXTESfk+z6NdlGW6GptruGWy9Q/Ly5uAc2B6B+J6BrMMAdT1o+o0ic/4jhVYmisE
 /0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687774461; x=1690366461;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+ePr3lO0hFViGKBVcx618Y5ELh+ZCONib46qb3ps8cc=;
 b=CFVjQJ+yTyoCyfLzgcZoL7EXc0luU8ZfYj5Qjh/4fZPcGZwroMJ5bxBoOz8VH05tsN
 u+du+TpbRMVuMHEnK/RtXfF+bsM82CgnMyFHZ6NMUGQn5io173n9EGN0oKxzAJlwLd/T
 tBuJUPaLuVDxEZRxvtFWraLlTxOuX3+FDK3nqlozY+1B5/5xwKD/xFoaZatbsLgHjCy6
 VPLnaJ2NrgFtAoyUgvzibpjwRA/TsIf8smcno+SK6W/kyuh7iwaoipFRVHK5pCHF1qPE
 5nGiv7U035IWgfRvpmNTS6fuHkABguVGg5DShgB0LisD9Y6F/CgK3/9judrk7Iuxx9W2
 ssSQ==
X-Gm-Message-State: AC+VfDz2zV0/45w0FL1eeZKwfvMXaV9maQ/X0PAUo2OsoCRMlig+TXcd
 qW6+fF2mw4BcnTozuVWI5duJNg==
X-Google-Smtp-Source: ACHHUZ68ku1JpEN5QaRZNJX/jXc1HXF+i7KnVnFssx+tKwNdvHzfLL2ypb/4Xa9KQFZX7dp3HOxupA==
X-Received: by 2002:a1c:ed08:0:b0:3f4:27ff:7d48 with SMTP id
 l8-20020a1ced08000000b003f427ff7d48mr19195567wmh.19.1687774461194; 
 Mon, 26 Jun 2023 03:14:21 -0700 (PDT)
Received: from [192.168.157.227] (141.pool92-176-132.dynamic.orange.es.
 [92.176.132.141]) by smtp.gmail.com with ESMTPSA id
 r13-20020a05600c284d00b003f733c1129fsm7190886wmb.33.2023.06.26.03.14.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 03:14:20 -0700 (PDT)
Message-ID: <0b710b90-c0e5-3805-6357-d418e968f15b@linaro.org>
Date: Mon, 26 Jun 2023 12:14:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] target/ppc: Fix icount access for some hypervisor
 instructions
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20230625103700.8992-1-npiggin@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230625103700.8992-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

On 6/25/23 12:36, Nicholas Piggin wrote:
> Several instructions and register access require icount reads and are
> missing translator_io_start().
> 
> Signed-off-by: Nicholas Piggin<npiggin@gmail.com>
> ---
>   target/ppc/translate.c | 7 +++++++
>   1 file changed, 7 insertions(+)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

