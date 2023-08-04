Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7A976F986
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 07:23:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRnGY-000677-OX; Fri, 04 Aug 2023 01:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qRnGW-00063T-7O
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 01:22:20 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qRnGU-00019Y-Hx
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 01:22:19 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bc3d94d40fso14453205ad.3
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 22:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691126536; x=1691731336;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vhp0NmCdf0YHvlNJY/KHs73gky5aBO9brfuE5XjAnAY=;
 b=yo2Odq284o57hpHZSzJ+nSHUsyNVlgLM5ijNGeXHW3014p27R/AI1xj5R9cv1FwkfF
 3wZWhwhJFNLzoDlICny7dNPTIpP7uGlOhu2RES3o8Bjudyh9S8f8SCcGzpjkIMiTzckx
 j+kKMhW3kYzQyc90vZi1aJwp6NV9PESj+aDYugqbCaBI0PlTqZMzXKmey3hRAzZkvKMD
 ENxFqQaMcm2eBDBWaqYPlv0AEkq73MfjdmY6hvxP6d3pVYj6MZan0AZE45L2DwjpBEQZ
 TscGz2j3ELx356n7Dty2xcawC6Gv08caq3DY8fMAjN4GgLXTkINSlhc8Ljg6j3AZVJ3p
 41hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691126536; x=1691731336;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vhp0NmCdf0YHvlNJY/KHs73gky5aBO9brfuE5XjAnAY=;
 b=GfP9ScGD6FqqqMd5+iNTZ18nXFrki1WMtF5oDZY4WSzL2oXEI3BuKSedMZTvJ0L7Q9
 4uQnIIBX79V7MvDXGJIFQbikSIIQ/3uDb8EBUsDgx+4NjmJJTwtcO6utrblDCyedh+2f
 AUId41U0cKudtbwyo9+vC0H2cvpQUHgSrLPQAwApx0u8W/E0INzSTZEJb9Rp6QL8HJQi
 I5whrbDXQDd+NBntRllmci/o2elIigcw1R++X6oJZuGY7tHk9Cjgs67RkwksfJr1DKTn
 eVypzdWOgRT+xL2XdogJt+4vVIeqHNvGiifo+7h8mNnt1r7+a2NFApc+9DQV6iJ9+Y3t
 fr7Q==
X-Gm-Message-State: AOJu0YwEJUMum7YUpZnXsSGrf8/RsOSw1RqfzTs0m7niUm/c/NMbiJ1H
 6ouOQdg7019HtJ8pzyxdS1Mw84f/SSRlQlqmBQw=
X-Google-Smtp-Source: AGHT+IGX2EROc2l9b6wvZtvGh4JTaSFlFL+6DTC5UpKgJNj/CVYcS4BcZAl96yE4QrsbFuIJ5lG/Xw==
X-Received: by 2002:a17:902:ea09:b0:1bb:7b6c:983a with SMTP id
 s9-20020a170902ea0900b001bb7b6c983amr828317plg.59.1691126535813; 
 Thu, 03 Aug 2023 22:22:15 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 jk21-20020a170903331500b001bbb7d8fff2sm763579plb.116.2023.08.03.22.22.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 22:22:15 -0700 (PDT)
Message-ID: <c0faaada-b286-9ee4-4b5b-daa5e6083822@daynix.com>
Date: Fri, 4 Aug 2023 14:22:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 11/17] linux-user: Use MAP_FIXED_NOREPLACE for initial
 image mmap
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: joel@jms.id.au, laurent@vivier.eu, deller@gmx.de
References: <20230804014517.6361-1-richard.henderson@linaro.org>
 <20230804014517.6361-12-richard.henderson@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230804014517.6361-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/08/04 10:45, Richard Henderson wrote:
> Use this as extra protection for the guest mapping over
> any qemu host mappings.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

