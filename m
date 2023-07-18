Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E50757B8C
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 14:12:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLjXT-0000nk-Nf; Tue, 18 Jul 2023 08:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLjXR-0000nC-5I
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 08:10:45 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLjXC-0002z3-1G
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 08:10:44 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-307d20548adso5380649f8f.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 05:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689682227; x=1692274227;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hYL7LjT3V05rYF+lDdy6wb4R1RjJZl3yFqoIYBW+yEc=;
 b=JhACjV3yDZDzsqftfiZYoVjr18zS7THOjcL/Mb7bkJu2S7x/HVnlz6v329p5BguYEV
 dIC1RIxU/u+AD0N9ckPrliyBd+O3ZGoL5qvLsVD1pgMl6u/Yd466zCJ5jl1bzL/7hxbn
 Fg3m/ujzhVVUK05/mStXG+LB5VlZAHfMutuiq0Tkw8zCxXu1TjnAde++vctFFUKDka6R
 OCef55kFQ4KWExDvr2GdE3WhMy+Z5Qgt1dttKx+Vau7uC/J5ZhnMJ4UyoUSVK2NrLtHu
 YZvKu3xZY8ehT3Q7xITE/2UuiCuuLpvGdEuVPhiAu5F8Sfl6Nm/xGpbcF9cUqbrUwCF0
 EcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689682227; x=1692274227;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hYL7LjT3V05rYF+lDdy6wb4R1RjJZl3yFqoIYBW+yEc=;
 b=PeK7x9vFiczIB69mw5fzs8q3WMIeMiy1aqPiotZg0f4Suiq5eTO601gpue9AwlaH1p
 ffPoLgB9cOT1vJi/Yk2oJ8yxXkYkXLeeq1bDQ6G7xXRfXeDDJswakmrF29ud6/2Pv6ei
 7wAfT/p2YYXIGVZ9EmhFXv2ku00li6hLNeGBbhwsGYxVxTIIpbDdLSMfjYnrGq/WkJOL
 DLoiza2L9uenF2byALXj4bdcXnbUL4yPNi2f8oQ7KKcs0EuRgCoEuaDk0SJ7n/By8m4L
 SyDewBbLGeZEpb9c/K5XyDSaHJCkwfVykX6Jc20xwydGx4FlPzgu/flKX/zbOTAqKELP
 V4zw==
X-Gm-Message-State: ABy/qLZth3pcPlm+A+pwEozUIdJugqp232Lu1zdBV48C2QF/Rw3GQTy6
 O9FSoyeDaQfOTPxbJD9wqhJ5Bg==
X-Google-Smtp-Source: APBJJlGBNU9xLZxdYjvCOyCFdyWJUchNEav5h9Lz6QjQGCJ79odANjP4ae+uiBj82heDS4GSxMl98A==
X-Received: by 2002:adf:fa8b:0:b0:314:1443:7fbe with SMTP id
 h11-20020adffa8b000000b0031414437fbemr12061069wrr.36.1689682226834; 
 Tue, 18 Jul 2023 05:10:26 -0700 (PDT)
Received: from [192.168.94.175] (140.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.140]) by smtp.gmail.com with ESMTPSA id
 i3-20020adfe483000000b00313f61889ecsm2237628wrm.66.2023.07.18.05.10.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jul 2023 05:10:26 -0700 (PDT)
Message-ID: <961f67fe-8c79-d1e3-a58c-5516f00bb249@linaro.org>
Date: Tue, 18 Jul 2023 14:10:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1] hw/pci-bridge/cxl_upstream.c: Use g_new0() in
 build_cdat_table()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20230718101327.1111374-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230718101327.1111374-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 18/7/23 12:13, Peter Maydell wrote:
> In build_cdat_table() we do:
>   *cdat_table = g_malloc0(sizeof(*cdat_table) * CXL_USP_CDAT_NUM_ENTRIES);
> This is wrong because:
>   - cdat_table has type CDATSubHeader ***

Yes

>   - so *cdat_table has type CDATSubHeader **

Yes

>   - so the array we're allocating here should be items of type CDATSubHeader *

Yes

>   - but we pass sizeof(*cdat_table), which is sizeof(CDATSubHeader **),

Indeed

>     implying that we're allocating an array of CDATSubHeader **

Ouch

> It happens that sizeof(CDATSubHeader **) == sizeof(CDATSubHeader *)

Ah!

> so nothing blows up, but this should be sizeof(**cdat_table).

Still, what a mess :)

> Avoid this excessively hard-to-understand code by using
> g_new0() instead, which will do the type checking for us.
> While we're here, we can drop the useless check against failure,
> as g_malloc0() and g_new0() never fail.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> This fixes Coverity issue CID 1508120.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Disclaimer: I have not tested this beyond any testing you
> get from 'make check' and 'make check-avocado'.
> ---
>   hw/pci-bridge/cxl_upstream.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)


