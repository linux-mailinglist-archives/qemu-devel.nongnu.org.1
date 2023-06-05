Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 834C572279E
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 15:38:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6APR-0002j6-PN; Mon, 05 Jun 2023 09:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q6APJ-0002d7-1d; Mon, 05 Jun 2023 09:38:03 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q6AP4-0008Ds-VQ; Mon, 05 Jun 2023 09:37:48 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6b20421deaeso280264a34.2; 
 Mon, 05 Jun 2023 06:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685972265; x=1688564265;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=njS705oyx6h5/F5vA+I53uGxwkzZa5NcwtATP8/E+yE=;
 b=W8tGgSmmkS+hW4XgnYFF2X39YHa0XV0MfaM5Xb0nCECSDT0qgeU5Kn/3x5NcKCCw7u
 sP9rXUEut83iPdMh5c2mec3cwikT26Zp0DpZh1rtI4g3/w/UoMkXfdlOhSlI8ssinRhZ
 XYW9ziWhpTpYwGPh5Aw7lZz7lncP1+/R0ce1or/n2AhIJtSBGz5cbIr9vzXd/PzjBNTf
 06StbsDDVSaTYPDGhH51VfNOSD7hIbwo3iZflGjj8yvZkSjNgRP2ZyzERwIucu6L43Wh
 MK/F6kgP8ZVzuKqu64Dx11NvqaJrmaZ/2QESjAJiLjN2WeLXrNidMw8GJJW8MwMmPONY
 rHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685972265; x=1688564265;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=njS705oyx6h5/F5vA+I53uGxwkzZa5NcwtATP8/E+yE=;
 b=AxkUZy6XiZ9UYN34jlyRnvyHkMc8Lk0pbrTX/9kY4/nHAjgjSCFQDmeU21Q/eo7JL+
 7opEU/G1dd6RwvlfTcb/TyhutpexPFpeptX08G2q8njEYUUy3moEcJgeRppIMlKrHJG9
 MsLyLGu7+UHirI2XvWoosHynI+57/LEfrJtgveIbvdBcTICMMybDYY1PL65635aKJN7I
 SFzlIBP+W2wWQdJGfJjOPRTptiBpde0wTnxZknZxQUYSYFPn4xyllRT9TlE2CaBboZ5T
 +Cc+rkGRolGEo4YgaXIdu6dp40EN1Nl+BDEpA/rph8NrUxlzwD/8izmaw0Pwv0XbZH1H
 L7iA==
X-Gm-Message-State: AC+VfDzwAF/l+Jixw118Ihp1L3EwiD1VtkAyVHdtGO7goHuI50/kL+qQ
 MlmeuXVFloxcx/Ei0y9/ycc=
X-Google-Smtp-Source: ACHHUZ6l7V3YNaNMxZ4vBgCzAv2FV3ZWb+AqUfhbRWaGG67Trc+5obirv0duJu0sfxjaeKAfp2TKIw==
X-Received: by 2002:a05:6830:14c3:b0:6ad:cd1a:cc54 with SMTP id
 t3-20020a05683014c300b006adcd1acc54mr4812794otq.13.1685972265413; 
 Mon, 05 Jun 2023 06:37:45 -0700 (PDT)
Received: from [192.168.68.107] ([177.170.117.52])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a0568301d8d00b006ab039a0cb7sm3356871oti.5.2023.06.05.06.37.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 06:37:45 -0700 (PDT)
Message-ID: <192a3fe4-8574-79f9-5319-1d6687070def@gmail.com>
Date: Mon, 5 Jun 2023 10:37:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/7] Embedded PPC misc clean up and optimisation
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>
References: <cover.1685448535.git.balaton@eik.bme.hu>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <cover.1685448535.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.09,
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

Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel

On 5/30/23 10:28, BALATON Zoltan wrote:
> Hello,
> 
> This series improves embedded PPC TLB emulation a bit and contains
> some misc clean up I've found along the way. Before this patch
> ppcemb_tlb_check() shows up in a memory access intensive profile
> (running RageMem speed test in AmigaOS on sam460ex) at 11.91%
> children, 10.77% self. After this series it does not show up at all.
> This is not the biggest bottleneck, that is calling tlb_flush() from
> helper_440_tlbwe() excessively but this was simpler to clean up and
> still makes a small improvement.
> 
> RageMem results on master:
> ---> RAM <---
> READ32:  593 MB/Sec
> READ64:  616 MB/Sec
> WRITE32: 589 MB/Sec
> WRITE64: 621 MB/Sec
> WRITE: 518 MB/Sec (Tricky)
> 
> ---> VIDEO BUS <---
> READ:  588 MB/Sec
> WRITE: 571 MB/Sec
> 
> with this series:
> ---> RAM <---
> READ32:  674 MB/Sec
> READ64:  707 MB/Sec
> WRITE32: 665 MB/Sec
> WRITE64: 714 MB/Sec
> WRITE: 580 MB/Sec (Tricky)
> 
> ---> VIDEO BUS <---
> READ:  691 MB/Sec
> WRITE: 662 MB/Sec
> 
> The results have some jitter but both the higher values and that the
> function is gone from the profile can prove the series has an effect.
> If nothing else then simplifying the code a bit. For comparison this
> is faster than a real sam460ex but much slower than running the same
> with -M pegasos2 so embedded PPC TLB emulation still might need some
> improvement. I know these are different and PPC440 has software
> assisted TLB but the problem with it seems to be too much tlb_flushes
> not that it needs more exceptions.
> 
> (If somebody is interested to reproduce and experiment with it the
> benchmarks and some results are available from here:
> https://www.amigans.net/modules/newbb/viewtopic.php?topic_id=9226
> some of the tests also have MorphOS versions that's easier to get than
> AmigaOS or sources that could be compiled under Linux.)
> 
> Regards,
> BALATON Zoltan
> 
> BALATON Zoltan (7):
>    target/ppc: Remove single use function
>    target/ppc: Remove "ext" parameter of ppcemb_tlb_check()
>    target/ppc: Move ppcemb_tlb_search() to mmu_common.c
>    target/ppc: Remove some unneded line breaks
>    target/ppc: Simplify ppcemb_tlb_search()
>    target/ppc: Change ppcemb_tlb_check() to return bool
>    target/ppc: Eliminate goto in mmubooke_check_tlb()
> 
>   target/ppc/cpu.h        | 13 ++----
>   target/ppc/mmu_common.c | 91 +++++++++++++++++++++++------------------
>   target/ppc/mmu_helper.c | 32 +--------------
>   3 files changed, 57 insertions(+), 79 deletions(-)
> 

