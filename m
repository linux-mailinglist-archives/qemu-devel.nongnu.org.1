Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCB87686C5
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 19:34:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQ9ro-0004S5-Hd; Sun, 30 Jul 2023 13:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qQ9rm-0004Rd-5j; Sun, 30 Jul 2023 13:06:02 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qQ9rk-0001lr-ON; Sun, 30 Jul 2023 13:06:01 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3a5ad4477a7so2900197b6e.1; 
 Sun, 30 Jul 2023 10:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690736758; x=1691341558;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gMCdYZiFKyT2bbS8172XGwCgjUMF87oSNmCVjaQ1qsQ=;
 b=Y9vMb+yQHs8RRFHgZm62QE/L5n8+mxH/P9uZPg9oqi3AxxU6GteqR8/fUHZuUyBEYw
 7L6TGl6ieUGcJaI28z5cIv3y72FNchyKiKHu4YDiIMJ46TKYO4bWUYq8w5DwWxnYadbU
 0uMxhImTZMS+l70CKudXyNDOgRaoPOUzVt9PFqAOhFfKk5AM77BbK3cTqgNgVduwNMwW
 FGmHytrAhfDa73jUCVUrDs2tpuRWoLqKKts1RH67P/qR8nYWmongi5ElDxdhTOT5gifO
 mJ1OJmTzojJVN2G8mVmva4AyORD9W58vLi59zKQOgajrziOHVECG1L51ST/hl1P6f0F8
 SiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690736758; x=1691341558;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gMCdYZiFKyT2bbS8172XGwCgjUMF87oSNmCVjaQ1qsQ=;
 b=D+f1zztza3od86aH6bIKBKFSGNRXLVvjbALeK4QoB4JX1zp6864XM6B0xcxMkq2O10
 g6iL7ul/gXCF/HGM9u70wqc+BlXv+kZ5Nqb+Cq0JoosOXY/xEj6CTAo20YNgCHIzQ1qe
 Z2lMfJSSAVxoRFiWCz70XgutkIXsYSdJ0xTU4vNBHOHQrjFg0ztw9a+QymsaieHaz8a4
 aAUX4x3baKiXUP2Mu3aESzU+vPY9uN6iJ3glOkBCR7N62pmaFo7k0cdQvNUjd97xiPOa
 81VOy7O+z2DGa6nqM5cgBbNyUlnuK+ZD9cw+3uH2yavEVG6vgPGU2eAKqHGGCI6pb4Ti
 IZSQ==
X-Gm-Message-State: ABy/qLYIvS75UyqLsZF1Z/csaMUCL3Gj93TPO7zL8r+lwPwjZfFcVzUf
 00Fcx6ZLIAEpGAKm06df05k=
X-Google-Smtp-Source: APBJJlGvZ0qCq9fGt/TapvC2orhGTHf5VcZFXa6H/AFtseSqLA5dPR7Hn+fynmXKF6wFivAOemXB0Q==
X-Received: by 2002:a05:6808:1888:b0:3a3:64a3:b5a1 with SMTP id
 bi8-20020a056808188800b003a364a3b5a1mr7309965oib.7.1690736758242; 
 Sun, 30 Jul 2023 10:05:58 -0700 (PDT)
Received: from [192.168.68.108] (201-69-66-36.dial-up.telesp.net.br.
 [201.69.66.36]) by smtp.gmail.com with ESMTPSA id
 y1-20020a056808060100b003a4825088ffsm190957oih.51.2023.07.30.10.05.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jul 2023 10:05:57 -0700 (PDT)
Message-ID: <93fcb62b-7e16-fc9b-3741-53fbbb44cc5f@gmail.com>
Date: Sun, 30 Jul 2023 14:05:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 2/2] target/ppc: use g_free() in
 test_opcode_table()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org
References: <20230728195646.168997-1-danielhb413@gmail.com>
 <20230728195646.168997-3-danielhb413@gmail.com>
 <CAFEAcA9vsv4BpSfFb6=W=MFjGdR283KEGFN13Sfy=TxtcjT4hA@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <CAFEAcA9vsv4BpSfFb6=W=MFjGdR283KEGFN13Sfy=TxtcjT4hA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x233.google.com
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



On 7/29/23 12:32, Peter Maydell wrote:
> On Fri, 28 Jul 2023 at 21:47, Daniel Henrique Barboza
> <danielhb413@gmail.com> wrote:
>>
>> Use g_free(table[i]) instead of free(table[i]) to comply with QEMU low
>> level memory management guidelines.
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>> ---
>>   target/ppc/translate.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>> index e6a0709066..d90535266e 100644
>> --- a/target/ppc/translate.c
>> +++ b/target/ppc/translate.c
>> @@ -7129,7 +7129,7 @@ static int test_opcode_table(opc_handler_t **table, int len)
>>                   tmp = test_opcode_table(ind_table(table[i]),
>>                       PPC_CPU_INDIRECT_OPCODES_LEN);
>>                   if (tmp == 0) {
>> -                    free(table[i]);
>> +                    g_free(table[i]);
>>                       table[i] = &invalid_handler;
>>                   } else {
>>                       count++;
> 
> Where is the allocation that this memory is free()ing? I
> think it is the g_new() in create_new_table(), but the code
> is a little complicated for me to understand...

It's on create_new_table() in the same file:

static int create_new_table(opc_handler_t **table, unsigned char idx)
{
     opc_handler_t **tmp;

     tmp = g_new(opc_handler_t *, PPC_CPU_INDIRECT_OPCODES_LEN);
     fill_new_table(tmp, PPC_CPU_INDIRECT_OPCODES_LEN);
     table[idx] = (opc_handler_t *)((uintptr_t)tmp | PPC_INDIRECT);

     return 0;
}


I probably should've mentioned in the commit msg ...


Daniel


> 
> thanks
> -- PMM

