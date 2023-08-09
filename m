Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 408C5775137
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 05:07:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTZX1-00034i-GV; Tue, 08 Aug 2023 23:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTZWz-00034M-QR
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 23:06:41 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTZWy-0002H5-CC
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 23:06:41 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6bcf2fd5d69so2731260a34.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 20:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691550399; x=1692155199;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jbNQhB1LrpeD7YGq04NGWWLkbAI97+VfYJki60Kci/A=;
 b=gRsvvDIbDK3IaEH7lbvwURIgYcWzRSW71PE9ebG9C+7Id3ak5/pObVpfJdiRYF+ERZ
 5WWMXY8m3EYGgdQ5AdGSe/uhGL0DZEcFQ9kqf7jZyWwM/re7sFIpVZlgj0CZaK6IQdXD
 8EE9gyoAi3LDIpb6BgiTYXgkHotTw8Swsu5Atgbbt0fVbwxweNa8CAyTsyV7usKm1OKg
 twKHE07arK0gr+CUi12b4itHfU5EHMAKMWng/1PRjE1dojX3NXSSbBcORuiPkL7efu3k
 3QNGE6d9MibXi5gZjiFN7mIWe29kqtsCkh1a/f+piOukm4AdVd2UASRKbdMl2C657Ghz
 lCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691550399; x=1692155199;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jbNQhB1LrpeD7YGq04NGWWLkbAI97+VfYJki60Kci/A=;
 b=AY1VjYMfNT4oliE8gyVKOECHOFB5WhMxKkEWNlKZAQ0D/nBQO0KfVv0OpyFwZYs4Nz
 IdRkvebIG/Ca35bCvHoO27FBYauQUm+Gpjo4A3SDhed3iwm0q4OS8YpWj9F8tb/a50R5
 cmnk4+Cns2/alNQdIKhESmRMfrT6j/oyb52KjWF5Et2WIjbptYJnR0GXOJ3T0hajVLDx
 EKkmPR0V4VXbHNTYLODaaVYxQt38WynMfbIqtZgLNhWyI4r7Kd4GQvJ/TMiQUNvvgLHA
 ylxbZF5wGodBQe4NAtA2lcTnaVj1W6bMo6cS1U6iX5uCpDD0ug+wVuk/5bLhC+A+mq6f
 CTfQ==
X-Gm-Message-State: AOJu0YwbqizLy0lviscFR0fmfylalR9TFuG7S1/fgWr/XNIUExpPqmzT
 Vy3fqaaPGrvnzv7q4pf7pPMMzw==
X-Google-Smtp-Source: AGHT+IHWBofNK+bJ0BdX28CWQlx+X6/vvhTqprr5kpDovXJPM2bUh/RG5vqFz+s6CZWFZ/Ki9qxgLg==
X-Received: by 2002:a9d:6c4c:0:b0:6b4:5ed3:8246 with SMTP id
 g12-20020a9d6c4c000000b006b45ed38246mr1756530otq.2.1691550398924; 
 Tue, 08 Aug 2023 20:06:38 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:aef:cddd:11b6:aee3?
 ([2602:47:d483:7301:aef:cddd:11b6:aee3])
 by smtp.gmail.com with ESMTPSA id
 g64-20020a636b43000000b0055bf96b11d9sm7385796pgc.89.2023.08.08.20.06.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 20:06:38 -0700 (PDT)
Message-ID: <ad931c07-77e8-37b7-d817-c2fb3c5b8642@linaro.org>
Date: Tue, 8 Aug 2023 20:06:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 03/33] Update the definitions of __put_user and __get_user
 macros
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>
Cc: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-4-kariem.taha2.7@gmail.com>
 <d9caacde-d8ab-2fdc-372a-20988f22267c@linaro.org>
 <CANCZdfoMCNF-SuBz5Ab=rmeW+1VLbR4mcUvfYqkbuV91rdtyPg@mail.gmail.com>
 <0a5370ca-ab9e-6a35-ea14-d685e1fa0540@linaro.org>
 <CANCZdfqWsrvhqbGC79Mu=05nmMANwXxb+TrKVi_fQpyk6QpEdw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CANCZdfqWsrvhqbGC79Mu=05nmMANwXxb+TrKVi_fQpyk6QpEdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/8/23 19:41, Warner Losh wrote:
> I tried to implement both get and put in terms of this, but found that it broke the blitz
> branch. So why don't we land this as is for bsd-user and then one of us can try to
> put it into common-user so as to not create too many waves for our GSoC student Kariim.
> There's already enough to fix in this series... Sound fair?

Yes, that's fine.


r~

