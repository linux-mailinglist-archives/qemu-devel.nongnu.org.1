Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B15734D11
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 10:06:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB9uU-0007ad-Uk; Mon, 19 Jun 2023 04:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB9uR-0007SX-Ma
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 04:06:47 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB9uQ-0001LU-0d
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 04:06:47 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-51a426e4f4bso3675659a12.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 01:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687162004; x=1689754004;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AQWh0SeDVslmu7ceBeHCnmFpC713019xZJXrjmLHmmg=;
 b=bylCYLE5KhHSODhpWyhkTE7WdweovUfFN7HZUabaIW8zfwSFKXnQOSHnV3e0WRhSlq
 /3VyHiw7UF6dw+Z7k+eR2/7o+1vXFAx4r216RdBejPOQ9s78QaMDmrDGCBbToGzdSOPC
 WAhgvVBCZs0bQX30GvfRgcOqel74YWrws+pBv/5ZmEi692WuXig1VP+/DLDuCrJNfDE8
 7a9QFnoVQ0WW+2oqjA43JkI9Gj8u2/NfiovGfCSZ/K58xeiSLwB8SKQgGfcqC0r+yuSZ
 GA0QPwo8Zb7VaKTBXSDF1p44fXeq+3uy863sv+PorpBbBMYjHgOCnrUntHLSzErDUnHY
 QXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687162004; x=1689754004;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AQWh0SeDVslmu7ceBeHCnmFpC713019xZJXrjmLHmmg=;
 b=jCXOHMJydH5DqjKUX5X6fCTAE6rj6jSv5YJj12ufNBehhrwieNUMOMXvvdR7S6hLgh
 etvv4aiCV46BegnqMaPXkaYTGeoMZ7qrIq2FrXCLVeMeGWIyKf7nk+IeyPPuofFMv8bi
 xdZelqrAa2CBHvglGnrFMTBnX5MOo6SxbcaRcBjI+avzAbdgEJV8GZzCWf+kuhpTx27C
 OnTx1k/ddtkmswyu1iGh/GziKzcYKfSlrt4t5cI/+ErvPXlh9SqG79ojukOk2nXLZrbc
 qGADWgSmiahXEoi8JhrqhD1c3gA1wYmlvvrOQqfMKsiEN22/yiQLpWZzp7Nr962Rjh6V
 73Uw==
X-Gm-Message-State: AC+VfDzZC8dztJy6628KegZcit8SYm+0tbo2Rj+Y7hsyNvok+HAf4Nhx
 BHjDQ1kKEl7rW6uLZy/Aw5azKg==
X-Google-Smtp-Source: ACHHUZ79hi1qAcDnYz+X2e8MXmhzRwV6Oq5meHZJrwNRkoxzHrbb5Mj/T0SY0oCQqhLfFlkP7OZtGw==
X-Received: by 2002:aa7:dad2:0:b0:51a:597e:c3f2 with SMTP id
 x18-20020aa7dad2000000b0051a597ec3f2mr1764796eds.5.1687162004394; 
 Mon, 19 Jun 2023 01:06:44 -0700 (PDT)
Received: from [192.168.69.129] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa7d047000000b0051a5a6a04a8sm991650edo.68.2023.06.19.01.06.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 01:06:44 -0700 (PDT)
Message-ID: <c513a9dc-1586-cec6-4489-0109846d637c@linaro.org>
Date: Mon, 19 Jun 2023 10:06:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/4] sysemu/kvm: Re-include "exec/memattrs.h" header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Jason Wang <jasowang@redhat.com>
References: <20230619074153.44268-1-philmd@linaro.org>
 <20230619074153.44268-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230619074153.44268-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52c.google.com
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

On 6/19/23 09:41, Philippe Mathieu-Daudé wrote:
> Commit 1e05888ab5 ("sysemu/kvm: Remove unused headers") was
> a bit overzealous while cleaning "sysemu/kvm.h" headers:
> kvm_arch_post_run() returns a MemTxAttrs type, so depends on
> "exec/memattrs.h" for its definition.
> 
> Fixes: 1e05888ab5 ("sysemu/kvm: Remove unused headers")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/sysemu/kvm.h | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

