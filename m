Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C7B7EDBB8
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:02:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3WNo-00052y-7F; Thu, 16 Nov 2023 02:01:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3WNl-00052U-Ia
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:01:45 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3WNk-0005eX-0e
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:01:45 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9d242846194so64193166b.1
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 23:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700118102; x=1700722902; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TWbrS698MFr51KSPWfkk0IHqdu25PwCXN5aSIDdeA0A=;
 b=YO450t0VLowDDcz88sv3XxeHkrSlq3bm0ElRHHqxGQgierhx2LyUyiWG0EFj9rX8n7
 Cpkw5UA/V1GRVnnBFtRfBTqq8EVu0kAVsk6PrCgxY/fSRafuVMCoclTYaYy0/ZgXVEEk
 bBAHbkuKQIgXwme/gLbflSGcWoaZ6iIYw2pPVYwh86Dj7REl08FyZyLsWRy7+B7NchSU
 tw8Y8wyhCw5at8ffWcLjODStmoM65aJGm2lNAhvm+363m71U5KfpgWYsYs+mh2Ii1d+N
 FFZXGCQlWmYP4juHBnQJB5mYTDgKw0y4GBPBnBVWky9OLk4fxYL7/rxKfTCYibxjgjvt
 rPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700118102; x=1700722902;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TWbrS698MFr51KSPWfkk0IHqdu25PwCXN5aSIDdeA0A=;
 b=iNmiy6DBBF1OL0lJJYr9Rw0hN/i3wABpzJcuKZcLbYQb/17OqHOzyE7ClgN2/hsbRw
 CgIM3ay0IlOpoJ4fryL0j2bb6MRgye5sKWKMjDAcVJ39JGAtyNmlhjhmG2P4cq5Yx4ij
 IqIAvFwGh8L6Cg3vEIWFyWvIwFJ/XbXXspOo6thbdtgSzqV/dqd51Ys+raESDfn5qSEu
 cwXGPCoYrzUBxPlV+l+3Vh4DgqEnq2i3mxwBE17PODB34PucKsZ1QmQ1k7dq2PqJucu+
 2MI2+/63FK/0lWZA1D2uHHOmjLSAmEWHcdEb/C6obAhFG/GGBNIkZTXovQ4PbFHVeMm7
 LKLg==
X-Gm-Message-State: AOJu0Yyo/J8WY8bF4OP6fNWIoYHMGw4NJOiBIsa/gMXPP2q8L+Wb4Hi/
 /dg7olw2eZJ+2XgtU5uswBLvsw==
X-Google-Smtp-Source: AGHT+IGquqbd1+VYKketVw5Zi91d7aWKaum89HUzm5p9YwLlIBbzSHHveII9PEDZ5+Eq79eotq+ppw==
X-Received: by 2002:a17:907:86a3:b0:9be:b41d:4f7e with SMTP id
 qa35-20020a17090786a300b009beb41d4f7emr12832877ejc.17.1700118102516; 
 Wed, 15 Nov 2023 23:01:42 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a1709067b4900b009b2cc87b8c3sm7932457ejo.52.2023.11.15.23.01.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 23:01:42 -0800 (PST)
Message-ID: <cfe6fcce-260b-41e6-9080-8e87d73b61ce@linaro.org>
Date: Thu, 16 Nov 2023 08:01:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/19] qapi/schema: fix QAPISchemaEntity.__repr__()
Content-Language: en-US
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-2-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231116014350.653792-2-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 16/11/23 02:43, John Snow wrote:
> This needs parentheses to work how you want it to:
> 
>>>> "%s-%s-%s" % 'a', 'b', 'c'
> Traceback (most recent call last):
>    File "<stdin>", line 1, in <module>
> TypeError: not enough arguments for format string
> 
>>>> "%s-%s-%s" % ('a', 'b', 'c')
> 'a-b-c'
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   scripts/qapi/schema.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index d739e558e9e..c79747b2a15 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -76,7 +76,7 @@ def __init__(self, name: str, info, doc, ifcond=None, features=None):
>       def __repr__(self):
>           if self.name is None:
>               return "<%s at 0x%x>" % (type(self).__name__, id(self))
> -        return "<%s:%s at 0x%x>" % type(self).__name__, self.name, id(self)
> +        return "<%s:%s at 0x%x>" % (type(self).__name__, self.name, id(self))

This is commit 6d133eef98 ("qapi: Fix QAPISchemaEntity.__repr__()").


