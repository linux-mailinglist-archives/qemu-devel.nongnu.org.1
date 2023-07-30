Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 996937686CD
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 19:38:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQ9z7-0007ue-Hv; Sun, 30 Jul 2023 13:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qQ9z5-0007uC-8M; Sun, 30 Jul 2023 13:13:35 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qQ9z3-0003i9-NW; Sun, 30 Jul 2023 13:13:35 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3a3c78ede4bso3018270b6e.2; 
 Sun, 30 Jul 2023 10:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690737212; x=1691342012;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SWL6EHCQeViUbN65x4SyzzXVs9zI02tk25qs3q7X04g=;
 b=PHa0c7l/2t4VT6vyNnfq+TKYshC3athz82QEOoxNWhtmJQag4LawOn4IGZgv9GqD1s
 Ty34L0ZFtizSZAJGe8imgrP5IUqrmT0ltpSYrVDseTheMMfLjHk28fw5yZKqoSDQUM+a
 vmHJzP1GWKNM8uVR/0XhqHO4YCVJerYcYz6aPT8mrJ4CIYQrwUM+E0mt8H4EeEX1L8gW
 HqAMi9TkeKwRl9fdR1TOE+mJK+MREbvEst5jWKXMAqpuF9cJMmSnE+ZXkm6rM9dPm1Cn
 ymE/DiSxm5GYE1Esgx8sVz00GNTT+QrhkXQ3ZbBoRPHwHfjYYQEEh7USMoyd7bl2sLmN
 zC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690737212; x=1691342012;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SWL6EHCQeViUbN65x4SyzzXVs9zI02tk25qs3q7X04g=;
 b=XaCtK/chzy8d2riOop2/VFVUPTxZOkpYSD6P+y0OL3nze4ax3kL/JqiRN693YyFpkd
 C1gL32GAaCSnSC6QoTXRXf6eMFB5P7Dpb5BOjQdOk01Q3vh3e0e4P3ciwEIE/ehh95So
 rxECAv52cJMaN+IxH5GMK1qH8J/frW7iIiUDXizZD9zTWX1Ufk9AwDBGliWoSzv56Jll
 ++5Fkrj+3lznHznPkUdlXz5gb8n51cIDDZbTYPSmeg59N+7zq4cG0UcWbXnx6pE6S2Cj
 HSgigJf0EuGaq8e08tYRHU7bf9wLXzlCbDHTjNVZsrVUPLh5MX0mQciUvGlaLNBjLRMj
 pVdA==
X-Gm-Message-State: ABy/qLbsjbn9fRxZg9eREPEiZaBTQWysvjHA0OW6F+Euk+9srGyjeuJW
 Vu/3qRJu4mXZB66Rd+9FUI0=
X-Google-Smtp-Source: APBJJlEqtuZHZ8aDMaaOX0SIHixaDxrUu5n05gWhTWFPso9R/xmuHZd3f76rENNIyyac3iI2putpXg==
X-Received: by 2002:a05:6808:3009:b0:3a5:a4b4:f93e with SMTP id
 ay9-20020a056808300900b003a5a4b4f93emr10465365oib.7.1690737211796; 
 Sun, 30 Jul 2023 10:13:31 -0700 (PDT)
Received: from [192.168.68.108] (201-69-66-36.dial-up.telesp.net.br.
 [201.69.66.36]) by smtp.gmail.com with ESMTPSA id
 t4-20020a4a8244000000b00567829a4991sm3599330oog.36.2023.07.30.10.13.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jul 2023 10:13:31 -0700 (PDT)
Message-ID: <6dc430f0-07d0-81d6-2639-5d03231f203b@gmail.com>
Date: Sun, 30 Jul 2023 14:13:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 0/2] ppc: get rid of free() (gitlab #1798)
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org
References: <20230728195646.168997-1-danielhb413@gmail.com>
 <CAFEAcA-79hxq7Uxne1wRx_waWkCy75ObKw5+krtbp-aTbxFkoQ@mail.gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <CAFEAcA-79hxq7Uxne1wRx_waWkCy75ObKw5+krtbp-aTbxFkoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x229.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.101,
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



On 7/29/23 12:35, Peter Maydell wrote:
> On Fri, 28 Jul 2023 at 21:57, Daniel Henrique Barboza
> <danielhb413@gmail.com> wrote:
>> Here's some trivial changes following Peter's call to arms against
>> free() and friends in gitlab issue #1798 in an attempt to enforce
>> our memory management guidelines [1].
> 
> To clarify, this isn't a "call to arms". The issue is marked up as
> a "bite-sized task", which is to say that it's a potential easy
> place to start for newcomers to the community who might be making
> their first contribution to the codebase. The changes it suggests
> aren't urgent; at most they're a nice-to-have, since glib
> guarantees that you can mix malloc/free and g_malloc/g_free.

I failed to realized it was a byte sized task :/ and my Coccinelle comment
in the bug makes me fell dumb hehe (given that Coccinelle is not newcomer
friendly).

> 
> We've had this sitting around as a suggestion on the wiki page
> for bite-sized-tasks for years, and occasionally people come
> through and have a go at it. I wanted to clean up and expand
> on the description of what we had in mind for the change, to
> give those people a better chance of successfully completing
> the task.

What we can do then, since I already sent these, is perhaps link these patches
as example/template in the gitlab issue later on.


Thanks,

Daniel

> 
> thanks
> -- PMM

