Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8794378D033
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:18:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nc-0001BG-DM; Tue, 29 Aug 2023 19:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qb4Of-0007Fu-EH
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:29:05 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qb4Od-0001oI-5r
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:29:05 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-99c4923195dso598019366b.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 12:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693337341; x=1693942141;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S7VrKV1zP/OP3NTeH3U/2rcoWCSYNx+ukNZCKG8r9SQ=;
 b=BR0hWhggo/1X6LmVbmAH0NAWvMCJZ6pqLIcg8dLvusPj0yBQtt22uT7F2WERtVNFGV
 pqVEn0rtQPHZZ20Xvmipbk/IrQQLPu20FMso7XJwS6NX8h6qz1pWjJf+43OFMEWNJZnU
 slkuwd8xYTiVZGAaJiI5nrlVoeTb205BZwAzRrAeGVc81ZgVSgegFNqYB0ne9QX7vSDT
 tA3b0lnRvsGejW63oF7WDEkG+T7OLkEHzyBfey0LWbfjDtIb1WZ4iaoDQvl5eAJFlysX
 WCa1P0Bmxfsty5lsbX9kvqBBNb8TiEqYUWIEXbQWiI5cgbOnw5xpV7yMNIY3yxdN494V
 L4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693337341; x=1693942141;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S7VrKV1zP/OP3NTeH3U/2rcoWCSYNx+ukNZCKG8r9SQ=;
 b=ir+iC3p9vPwGs7i//qsjgx1YmyJ2QQaaxEcjnGNgI5Gz+Ams6fNyRUGNvh2O5unFqz
 wkKwSfax9T2ZQjlGiAZ586CCE8WNvJqr2Guc4UquYI7/24MD8Dmoow0kFt4JJlzZi/zo
 AaqfrvnQbrCDtl2kRMRR3SfU6sdHgmr+qtg8+P9v/aPZGqcA7prE14THYes9AoNUZz6F
 LhKDj/Y/Im/W9ncOIJ25UJSstHR/w6ctvI+0XCyhbZUB1+JPAantXJ3zKkRiCvJT2zXI
 psGVXUIOTPOTQHzgne6ysqFfwJAsSoUaw7sa4BIBjusZh8x1FgBPjPW4m3mXGGQXwIqD
 85WA==
X-Gm-Message-State: AOJu0YwR/qb2w1n7oc0FibXgva/TiCCc/i8vntuXhOfI5siBv4wx+17q
 ZiHFHSbbKMTNfle8P0E82T+TRA==
X-Google-Smtp-Source: AGHT+IHvuzY8l/uZlLZyw9li6pZ91ZFsvPwuntZXr5ShP+gI9fFebPMVFSrKoc407Vt8I/THRQ7WbQ==
X-Received: by 2002:a17:906:ae81:b0:99d:f47b:854c with SMTP id
 md1-20020a170906ae8100b0099df47b854cmr20170704ejb.72.1693337341583; 
 Tue, 29 Aug 2023 12:29:01 -0700 (PDT)
Received: from [192.168.69.115] (sml13-h01-176-184-15-56.dsl.sta.abo.bbox.fr.
 [176.184.15.56]) by smtp.gmail.com with ESMTPSA id
 g24-20020a170906395800b0099cd1c0cb21sm6266420eje.129.2023.08.29.12.29.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 12:29:01 -0700 (PDT)
Message-ID: <7b4fe44d-3241-5517-1a3c-8e183254e9b5@linaro.org>
Date: Tue, 29 Aug 2023 21:28:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] target/m68k: Add URL to semihosting spec
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20230801154451.3505492-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230801154451.3505492-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 1/8/23 17:44, Peter Maydell wrote:
> The spec for m68k semihosting is documented in the libgloss
> sources. Add a comment with the URL for it, as we already
> have for nios2 semihosting.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/m68k/m68k-semi.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


