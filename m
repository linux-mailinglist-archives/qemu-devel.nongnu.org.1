Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D07B476BE45
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 22:06:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQvcd-0004D5-GH; Tue, 01 Aug 2023 16:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQvcZ-0004AP-GV
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 16:05:31 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQvcX-0004hH-Vi
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 16:05:31 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fe1e1142caso28659085e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 13:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690920328; x=1691525128;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nm2DIExF222orN1LklzMO5fRN1UmXYnKx40VOzdDNo8=;
 b=vM7vh/rziCnm37Nx2pR4d1GSOXq0aWik65M8VNqSLp3DY2PN1xDaYXQyc1XCn7Ynw6
 ICB8nd/Vt5jhavEuW2deZAHHDaImbBJeZJRQk4UzhkUJdMGrcAAdLg1Ocq5cGR8UeGEL
 rxw0FhQWtdoWlzgFYPCFa6BctcdR7r1RDwrLzVSj2AReKDhFIpjLcOYJT4Q6810b68aL
 kbp3DuH5LXQkmzemCafO6YSLjaK6tvs4un8Ny+N3QiyPpURVu6bGq80oPkw6yWDfpO4Q
 UgDDAvH+aE71/7F5RwRfz8mvx77iNGPkvy/OcWK58syJazDynyTwSSTPoINkIMGDp0Er
 SyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690920328; x=1691525128;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nm2DIExF222orN1LklzMO5fRN1UmXYnKx40VOzdDNo8=;
 b=U77XnOQl3IA/tOBCUWW6fq8En0j4N4jnF8kR8XS/SjSUfbNAEqXfgKZDeXhJjqxy5C
 HBRuATRZWqh+kSetPQreXm5Su5IbGLAgH9+MeFOyX8LekmfnaW8bk1rmlrPxWRY1xBR2
 Ljas9gTAbev5B51LAd33JDE2+VH/WYJgZq9S9OcjYxhaZgjp4/X/7o2M+nNruBgLcz14
 E/SzgPMO7XZvm0vuThQsPIRUwIO2DUG+aLDUNQ4W1pApBrND0kpeb63y9dsudoJ1o3Cg
 0BeKl5cBF0uLucGr27LAazuetE0tJ/yyOV64rJhaxPfvWjfnO1A7DCKJqlQ+eGxZjra3
 BcYg==
X-Gm-Message-State: ABy/qLZNSoMZT0SzvRPlpFRcy20JRkOJVhlrCb5NOaUsydscJ/Tgxvcp
 r0uu16lJjOSuxoOvbVlIHy4rWA==
X-Google-Smtp-Source: APBJJlEFUatF4/jXsTJiEDJRs9QGOlkROpT9qemL41PDPqXhcNCzsrNIVLIuJH8wkWuStsb5damwdQ==
X-Received: by 2002:a05:600c:2198:b0:3fe:e1e:5041 with SMTP id
 e24-20020a05600c219800b003fe0e1e5041mr3184030wme.32.1690920328274; 
 Tue, 01 Aug 2023 13:05:28 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.174.59])
 by smtp.gmail.com with ESMTPSA id
 s21-20020a1cf215000000b003fc00892c13sm14503558wmc.35.2023.08.01.13.05.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 13:05:27 -0700 (PDT)
Message-ID: <4bc9c439-4648-07f7-dd70-92828e006e5f@linaro.org>
Date: Tue, 1 Aug 2023 22:05:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] gdbstub: Fix client Ctrl-C handling
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, alex.bennee@linaro.org,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 fbarrat@linux.ibm.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230711085903.304496-1-npiggin@gmail.com>
 <a18e346fc0e38f1014f5484e0b1ef27a7bc8cb41.1689073223.git.quic_mathbern@quicinc.com>
 <CTZTUVQXKUGA.11SSOS1KIFLZK@wheely>
 <CACPK8Xf-fa4qKZpgg4FvMkgzwbqgP1rh4=qLmv12N1JFcBn3Cg@mail.gmail.com>
 <CUFEQY5EGPAK.BFTBD2ZPJV5A@wheely>
 <CACPK8XdTVArJCVh0UaSe2mwY2FtO3zpMepkqPfkDy7zAmc16jQ@mail.gmail.com>
 <CAFEAcA-oB2U=eTzRqdHJVw2DZWPEnR_tS3M_+=yiF5GHtv_3tw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-oB2U=eTzRqdHJVw2DZWPEnR_tS3M_+=yiF5GHtv_3tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 31/7/23 15:59, Peter Maydell wrote:
> On Mon, 31 Jul 2023 at 07:59, Joel Stanley <joel@jms.id.au> wrote:
>>
>> On Sun, 30 Jul 2023 at 09:43, Nicholas Piggin <npiggin@gmail.com> wrote:
>>>
>>> On Wed Jul 26, 2023 at 4:35 PM AEST, Joel Stanley wrote:
>>>> On Wed, 12 Jul 2023 at 02:12, Nicholas Piggin <npiggin@gmail.com> wrote:


>>>> I was taking a look at -rc1 and it looks like this hasn't made it in.
>>>> Is it something we want to propose including?
>>>>
>>>> As a user of qemu I'd vote for it to go in.
>>>
>>> I think it should, gdb is hardly usable without it.
>>
>> I think I hit this issue when debugging u-boot in the aspeed arm
>> machines. Your patch fixed things:
>>
>> Tested-by: Joel Stanley <joel@jms.id.au>
>>
>> Alex, Philippe, can we get this queued for 8.1?
> 
> I'm doing a pullreq today anyway, so I can grab it.

Thank you Peter!


