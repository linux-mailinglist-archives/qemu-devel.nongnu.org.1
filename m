Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAB579199C
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:24:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdAUx-0005jH-92; Mon, 04 Sep 2023 10:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdAUp-0005eL-5u
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:24:08 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdAUm-0005Bx-RA
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:24:06 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-52bd9ddb741so2119344a12.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 07:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693837442; x=1694442242; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LsHH22Ut/8tvjfzIN0oka+/x5H0TkWYTkubcxjRRzvY=;
 b=czaVzUctiJ2LZeV9WhC++Xe5C+jN/mRlX7HyGcmPL95JX1MP91CNwu4c120+5n50Du
 KXIOzFGNr8TStrqT+ntSctilXnGFr/dx6mgPtltOfG4lSoBfPnz5nd3tB1bcxaJ3g4vT
 mIty84YaVrBOXVTlppRh+88c6+IKChrXfbGYsCRJDVKYtJJhek21iRIvex2e53GYnAL4
 dWDl7GVs4pqNoA7Ijwg8/p0IgRU4QK0tehwvMObI64648q+b1s7OKtulS5YxREimw0mL
 s+gCL2Pt8PGenwWofoJ/B+dNoH+q/UrkLQa3Ao8jPs2xX7O1C69OU+1uPCu7Eu2p4WV4
 X/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693837442; x=1694442242;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LsHH22Ut/8tvjfzIN0oka+/x5H0TkWYTkubcxjRRzvY=;
 b=Trz1OP9idin2u/bItg5WoKHP2I8bv4lYRSzDqai41Br3mmnudtSklhS9Eb34spn903
 zmdiDrh/ieFFgAhrN3CbLnxIijazwycGwmsSSvfD4EKp2fQxZw/SJKlYCe52OuFQ9Du4
 2eUC9FGxIqFzx1i8bKCwGQJxDPK7TuM3n2QqKi8HugbYuTpOhVL/ErtaBWyBZLpgpGTV
 TD8V5SzVFdk6HYpTXsBcINTEX1s5oNU1Wot21eavM/ndPTE54ukY0fsNp7GSEfypHwXu
 JUAEoSs7FloXR22vDTFYDdrE7AvyETSZ37cg7R9OLdyEX0CRVJt0C0T1M4Ni/QrBvUdn
 kJ9A==
X-Gm-Message-State: AOJu0YxTT+saObcoIJmc8r3ry3EO0TVjWgWV8DaEKhZqHJqXt/qcp3li
 DLhCQ5NSPKRq20nM6k4LYiSGYw==
X-Google-Smtp-Source: AGHT+IEW1FPxf9wNpSg3ms4X/n5YPZMHSHrY4tEB56SkOhQFpWN6mXqOv+1ZiYdm9Va6dPX2kiQl4A==
X-Received: by 2002:aa7:d30c:0:b0:525:501d:9bd3 with SMTP id
 p12-20020aa7d30c000000b00525501d9bd3mr6642538edq.32.1693837442321; 
 Mon, 04 Sep 2023 07:24:02 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 f26-20020a056402069a00b0051e2670d599sm5961170edy.4.2023.09.04.07.24.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 07:24:01 -0700 (PDT)
Message-ID: <2834fae5-29c5-2f86-733e-aeaa3cf28e63@linaro.org>
Date: Mon, 4 Sep 2023 16:23:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [risu PATCH 4/4] s390x: Update the configure script for s390x
 support
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>
References: <20230904140040.33153-1-thuth@redhat.com>
 <20230904140040.33153-5-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230904140040.33153-5-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 4/9/23 16:00, Thomas Huth wrote:
> Auto-detect s390x hosts and add s390x information to the help text.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   configure | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


