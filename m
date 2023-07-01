Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBAF74485A
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 12:01:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFXOP-0007I8-Ck; Sat, 01 Jul 2023 05:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFXON-0007H5-8S; Sat, 01 Jul 2023 05:59:47 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFXOL-0003f3-HV; Sat, 01 Jul 2023 05:59:47 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6b73c2b6dcfso1903697a34.2; 
 Sat, 01 Jul 2023 02:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688205584; x=1690797584;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8T9b7BEML1LMS2mHqbhMhxWDB5WWBOG/ARqvuQNjbOI=;
 b=Kvxm5HgxxSMQLQ6eJtLT63y31WbxTolfOCbgOtr5yl8O2yctcxU4EyNJORAENhSeZe
 USOfKaAUNc7DzSHzlbvvSaIRIwmbe/cETDIgdf+czBKPwxXdo43oprUUCwzMdCEFfmQK
 N0B1uOKV6YxOx23jUOZUsBhcChUKBQNKlYKh15IU+fIH5kb6zBD32qUhu5IwyE4fax7e
 GOPWhgY9dAqPHRQoOWnwg/R/xTSaluHO8/P3wP/4ZakEWXXIFrZxVwB1AX2Dfw5gv1aJ
 hEURtofaK2NY2UO78i+cVkHokwK4WvPmC7Finjw5qeOU/9xvC1uYpjO0JtTuxvaFcQGS
 RUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688205584; x=1690797584;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8T9b7BEML1LMS2mHqbhMhxWDB5WWBOG/ARqvuQNjbOI=;
 b=Rgjme62rlCvGT4VVN7O84Rm+WOSChqh3Kweh8NV4EtRTgAG4YowoD9GCkN5Tq7WRue
 tO/K8gtzWRY/LHNqLmmRKpTP4OLW04TcL+riiAaOGJVKbo92s1BFNeG+iAOrn4UYzQJT
 LhjMAuhcXH5MQxnWmcJq0PBGCRsNbh5XQjH3HwXVXE/AadmfnQABWCp5s5aR6P+CGuMd
 LxEruKHy/3gprEfp887irv+71oYipeNJ4Cr0fHCpWd+dvHmRUIFghR9nWozq6TW1vhgD
 719WiRJ2/qjZab9MbT54oeBpcguNmUAgvtVOQ7FDVOOcxH8BIWwLEIoyFpCZ+SQYHApf
 e+EQ==
X-Gm-Message-State: AC+VfDwm82O74cF86rzHzUH+x0O5+LGMTkMFsXJvefesApvLkKV+ew6h
 Mo/SYtavOlPuzGDXvGmh22I=
X-Google-Smtp-Source: ACHHUZ4ow15BlIlLTcs1jQGZv7DoZmH5vURsz45Ihf5O8gvc5PTKSORm2U426N+XkwGi4fx3hi11rQ==
X-Received: by 2002:a05:6830:450:b0:6b7:296d:3d4e with SMTP id
 d16-20020a056830045000b006b7296d3d4emr4816264otc.30.1688205583954; 
 Sat, 01 Jul 2023 02:59:43 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 z6-20020a9d7a46000000b006b8ad42654csm915338otm.0.2023.07.01.02.59.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jul 2023 02:59:43 -0700 (PDT)
Message-ID: <a314ebf0-fede-2646-a255-59ee9ebf33d6@gmail.com>
Date: Sat, 1 Jul 2023 06:59:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 00/14] Misc clean ups to target/ppc exception handling
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org,
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1686868895.git.balaton@eik.bme.hu>
 <92e3591e-cce7-c3e7-7d73-a0bd24de8c2c@gmail.com>
 <1726bfcd-0e6e-0a72-bc97-be7a79f95340@eik.bme.hu>
 <03e0c0c0-d3e5-bc4c-6c07-db642d2e6f52@gmail.com>
 <275e9cc3-8cb5-052a-7683-7abf4ea78522@eik.bme.hu>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <275e9cc3-8cb5-052a-7683-7abf4ea78522@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.095,
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



On 7/1/23 06:39, BALATON Zoltan wrote:
> On Sat, 1 Jul 2023, Daniel Henrique Barboza wrote:
>> On 6/30/23 19:57, BALATON Zoltan wrote:
>>> On Fri, 30 Jun 2023, Daniel Henrique Barboza wrote:
>>>> Patches 1, 2, 3, 5, 7 and 11 are queued.
>>>>
>>>> If you would be so kind to get the remaining patches, rebase them
>>>> on top of my ppc-next and resend, I believe there's more stuff
>>>> to be queued.
>>>
>>> Thanks for taking care of these. I'll do the rebase of remaining patches once the current queue is merged, they aren't urgent so I can come back to those later. I'm working on some sam460ex patches but don't know yet when can I send it so don't wait for me now.
>>
>> Got it. Just bear in mind the current release schedule. Code freeze is July 11th:
>>
>> https://wiki.qemu.org/Planning/8.1
>>
>> I'll send one last PR before freeze (probably on July 10th) and then it'll be only bug fixes until end of August.
> 
> Do you mean one more last PR after merging the current queue or the current queue will only be in that last PR? I hoped there would be a PR now on which I can rebase the outstanding patches for the last PR so I don't have to rebase on next but if the only PR you plan is the last on 10th then I may need to move to ppc-next now.

Just use ppc-next right now.

Even if I send a PR today with what we have, Peter/Richard has no obligation of
merging it quickly on Monday (there's an US holiday July 4th, and some people will
also skip July 3rd). If you wait for such PR to merge upstream, then start rebasing
your stuff, you'll have less time to work with.


Daniel

> 
> Regards,
> BALATON Zoltan

