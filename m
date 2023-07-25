Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EB776196A
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 15:10:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOHmJ-00076J-T9; Tue, 25 Jul 2023 09:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOHmE-00074X-9R
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 09:08:34 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOHmC-0001dP-2q
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 09:08:33 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fbc12181b6so54253795e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 06:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690290510; x=1690895310;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Iu6eSU0FuEZRh3L8kmG3m5ikhAUA/ImG9papwK8lvuc=;
 b=vTxUiTV+bG8+vVCugdHtRaT4B7YFRfqFOhdkrbZFj8Mlk2hXaZapvOWkEkzHOzWJCI
 fTVW61GC7MlptgtUOmn3IwaLM7dmNEsmPo9FIfDP1l0hsjOcfgliUZj/dWFpT1aG9wKJ
 YRfns8WV1FGaju9yVOB2UmkL8yAVAFAy+G0BCKzfyITg3WDk52pJXLJFT3ZQNLWAxoZV
 Z7SAuXVKOCKoHAfcHT3WRUjwtLCtQWw74HzGQ05mrniCcmkZmuY/p/XB2NzBCiAW2svA
 HtigQ+SawVO8qno0z99zSQk2CnffOgsy97FUUmNI/kRX1MD5SZIaB6JhHCLkZGJESoIZ
 sCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690290510; x=1690895310;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Iu6eSU0FuEZRh3L8kmG3m5ikhAUA/ImG9papwK8lvuc=;
 b=fOSc68Dosl3e2H4jbPleiSBynlpkzF1xdZRIImsgCnJfGEr378vVxY2GRChpD7Jymq
 Eln85WsSVfF4Ez+g2aQRLqhCCpqkmc3RUORepiSXjIXprwV26crvX44I6xLChaColtb4
 7pVfEH45nB4wFtCBLR40EgqiBXL7VEE12iUqEwxZIldYZfq8Rlj3ZLUxj9ZXVgGHVmwW
 6zRt2WKyZpsnMGq9yhoRhY0uUeMafkY7BkAMxRmVZ57R+xRK1AbYedUXPpQSGTVREEfS
 t6yqmU8tWvUuueaCITB9+xqFWlhIBAVwsmOI3bhHLET1HNdlek7Ga1o2fR1dtj/LfoZ7
 qypQ==
X-Gm-Message-State: ABy/qLYnwXbtCK0Gqv3yEkqgwU2R1SLmoanfDiiT8m5ftp/lomkF1CQS
 +nj1p6Zcmtv5qY+ve35BxcxwBQ==
X-Google-Smtp-Source: APBJJlHOmvhUi+o+Kl4fNW6Xs0UF7JzRpiSWwG4/kUGomNASZ4FSQTCWd/teRp/nciEKJKGNe92+tw==
X-Received: by 2002:adf:ed50:0:b0:317:69d2:35be with SMTP id
 u16-20020adfed50000000b0031769d235bemr1859615wro.30.1690290509994; 
 Tue, 25 Jul 2023 06:08:29 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.203.142])
 by smtp.gmail.com with ESMTPSA id
 o2-20020a5d4742000000b003063a92bbf5sm16483365wrs.70.2023.07.25.06.08.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jul 2023 06:08:25 -0700 (PDT)
Message-ID: <ffbcc556-827c-3577-42e0-3c2cda39b823@linaro.org>
Date: Tue, 25 Jul 2023 15:08:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1] hw/rdma/vmw/pvrdma_cmd: Use correct struct in
 query_port()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20230725113632.2386874-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230725113632.2386874-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 25/7/23 13:36, Peter Maydell wrote:
> In query_port() we pass the address of a local pvrdma_port_attr
> struct to the rdma_query_backend_port() function.  Unfortunately,
> rdma_backend_query_port() wants a pointer to a struct ibv_port_attr,
> and the two are not the same length.
> 
> Coverity spotted this (CID 1507146): pvrdma_port_attr is 48 bytes
> long, and ibv_port_attr is 52 bytes, because it has a few extra
> fields at the end.
> 
> Fortunately, all we do with the attrs struct after the call is to
> read a few specific fields out of it which are all at the same
> offsets in both structs, so we can simply make the local variable the
> correct type.  This also lets us drop the cast (which should have
> been a bit of a warning flag that we were doing something wrong
> here).

Fortunate but also kind of amusing :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I don't know anything about the rdma code so this fix is based
> purely on looking at the code, and is untested beyond just
> make check/make check-avocado.
> ---
>   hw/rdma/vmw/pvrdma_cmd.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)



