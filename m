Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 533AF7409AA
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 09:18:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEPQp-0002U1-SW; Wed, 28 Jun 2023 03:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qEPQU-0002Qe-ED
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:17:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qEPQS-0007q1-Od
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687936633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DM36D0IFIiMOVqzyPBl5t7nMw8/woLBi0aBrbWDf64c=;
 b=EwuaBq37NwGS7YV+DekwbboAK19vliqlk+5QhmfktsU3WPxcXE6zYE+SvPixP8jvfYK2Ue
 c95io97GI5WJUxMVZp4Q5lM+rsdPjwfS+qioLAM89azn48CnvuW2C+nSWJfNlxb83zW5HX
 LR9GJkRjuNqLhieFZYOp33gGZTXMGXY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-p-6jNun4NVql8oTT5lXzNg-1; Wed, 28 Jun 2023 03:17:12 -0400
X-MC-Unique: p-6jNun4NVql8oTT5lXzNg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-400a393268cso40930901cf.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 00:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687936631; x=1690528631;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DM36D0IFIiMOVqzyPBl5t7nMw8/woLBi0aBrbWDf64c=;
 b=Cn9WiiVhknVjbgYznaVUxtivKd7/eSwTRnfm1+raSR1en7BKxNN0+GSuw0qPPByUix
 F35vb8tWOpuOh3ZP7tRhUiTG2+pWiwyul3I34ElprPrr6lwq8U3hZvi0eubc76D+25Nr
 beJ4f/mGiXQrOWIjOGTCptO2Mww7KPTmFwxjLy+JnXX3z/3KVaJ+vABxmjsDUvkMMKzM
 /DPLjrHEW2WVCmLWm2iNFCslPn4We0o5vLzaIqCQUi4WA+U8KNTAcqb3GdtOOV52m0fi
 6cZPpBsGYLh6Map8fPOF5/Xhpc+yAvFux4kfoyzLVIutQN3JzAYXKYBVKE72ijQTCbMM
 diSg==
X-Gm-Message-State: AC+VfDwlYTkoaHulkf3pgm29uofrEkQTeFtIuvyn+YuXZIgBNRjXdHm+
 ShtAYgNzf/omCeU8IXw8Q5wXnfI/Tnw0kq1+/0oY4Ts5exmrZd3kHeLnBUMAjWR/99VCVzOCwoD
 yx//9aP6KJ7Qa/A4=
X-Received: by 2002:ac8:5c01:0:b0:400:ab8e:5f82 with SMTP id
 i1-20020ac85c01000000b00400ab8e5f82mr7714640qti.52.1687936631363; 
 Wed, 28 Jun 2023 00:17:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7RQUOxeZsHmT+Xjss8cuBFQJSkpiKVaA79UC07XA5TKtka7Q5uVH5VcnWDkk8V8Rf3WpnkQQ==
X-Received: by 2002:ac8:5c01:0:b0:400:ab8e:5f82 with SMTP id
 i1-20020ac85c01000000b00400ab8e5f82mr7714618qti.52.1687936631077; 
 Wed, 28 Jun 2023 00:17:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 x4-20020a05622a000400b003f7a54fa72fsm5583088qtw.0.2023.06.28.00.17.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 00:17:10 -0700 (PDT)
Message-ID: <2bc2ca94-c1ba-a9de-0b81-6f9d3d4ad333@redhat.com>
Date: Wed, 28 Jun 2023 09:17:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/4] target/ppc: Catch invalid real address accesses
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Christophe Leroy <christophe.leroy@csgroup.eu>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230623081953.290875-1-npiggin@gmail.com>
 <CAFEAcA_Brf-R12t+DKNAoygqgC-qjKJ3Wiz4ULjGHOo8_vPovw@mail.gmail.com>
 <47197a73-b106-47d5-9502-393a6bdc9945@redhat.com>
 <966b3fce-512d-f122-e76e-efded0db9731@kaod.org>
 <cefdeb3f-3442-ede4-3e5d-6a4a99b38293@ilande.co.uk>
 <CABLmASF92ux10=D5MJ4Ax3FbCi4digWJajHy4VE1fNUL9bOJxA@mail.gmail.com>
 <8e3010d8-9ca7-c834-3348-e11060c53f8a@ilande.co.uk>
 <CABLmASFsWK9Bg_bo=kC9C_8EnLpoVJKtqg0ca8gv1YdrffQSAw@mail.gmail.com>
 <d9b7499f-f462-79b3-e9e8-25a14a3b538d@redhat.com>
 <840c34e7-0f5c-89fa-2dfa-f8de3da4d643@ilande.co.uk>
 <7e596b48-c631-34d5-2b63-0aac1922de93@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <7e596b48-c631-34d5-2b63-0aac1922de93@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.103, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

>>>> qemu-system-ppc.exe -M mac99,via=pmu -cdrom C:\mac-iso\9.2.2.iso -boot d -L pc-bios
>>>> crashes Mac OS with an address error. (with unpatched and patched builds).
>>>
>>> Same on Linux. I get an invalid opcode. QEMU 7.2 work fine though.
>>>
>>> C.
>>
>> That certainly shouldn't happen, and if it worked in 7.2 then there's definitely a regression which has crept in there somewhere. I'll try and bisect this at some point soon, but feel free to try and beat me ;)
> 
> bisect points to :
> 
> commit e506ad6a05c806bbef460a7d014a184ff8d707a6
> Author: Richard Henderson <richard.henderson@linaro.org>
> Date:   Mon Mar 6 04:30:11 2023 +0300
> 
>      accel/tcg: Pass last not end to tb_invalidate_phys_range
>      Pass the address of the last byte to be changed, rather than
>      the first address past the last byte.  This avoids overflow
>      when the last page of the address space is involved.
>      Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>      Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
>   include/exec/exec-all.h   |  2 +-
>   accel/tcg/tb-maint.c      | 31 ++++++++++++++++---------------
>   accel/tcg/translate-all.c |  2 +-
>   accel/tcg/user-exec.c     |  2 +-
>   softmmu/physmem.c         |  2 +-
>   5 files changed, 20 insertions(+), 19 deletions(-)
> 
> 
> I think the instruction is fnmadds. Needs more digging.

the invalid opcode is just a symptom of something bad happening.

C.


