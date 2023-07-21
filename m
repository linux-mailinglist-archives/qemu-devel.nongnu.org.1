Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE12D75D5D8
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 22:40:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMwtD-0002rv-LK; Fri, 21 Jul 2023 16:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qMwsz-0002rX-J3; Fri, 21 Jul 2023 16:38:02 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qMwsy-0000Pp-7c; Fri, 21 Jul 2023 16:38:01 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6bb0cadd372so1301416a34.0; 
 Fri, 21 Jul 2023 13:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689971878; x=1690576678;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r8TtzdAi0Wlgm+zHTe+M52v/6J5pW6LLMv0J1bDz+n8=;
 b=GHfmsh25UwdL30Mdmp7C6euUk7j9dZ7tWf3D5yvfbXmDo/OAc/4csRlTVXQgf/sJic
 6GQRTUFL+0paTT6BbAsuSfnXS2c5KS2qdQr+Ia2kuYwv2ClIFZ6UO2vSTQZCuy/SxZKJ
 LUUE4OpcoVm7CYNzDC7Dq0z0MAQZ+2Mnp1cZh9cvBPh7q1uzvwB7SaQ+Wg5nH78mjMF7
 7TMTeYRWaS6CXBeD7mka7XyWtOC3+uIZu6+bA/yXdUlbv/HOXWQ6qJOPr7S0kH2TD1HA
 PoCzLR2FmE0LQiSb6b9V92uVjhBXMYrr9aNrStAMpZtNOwiDAAwIICbxm9FgVPSjl564
 SMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689971878; x=1690576678;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r8TtzdAi0Wlgm+zHTe+M52v/6J5pW6LLMv0J1bDz+n8=;
 b=IgMsDZ6WbpeHl2JwyUGe7V4EMEIzRjZYb18spC3CKID73tJWyVto58bLQne82bKwD2
 vLTEGgyHHS8i9kdw5UFn/lo+2s5cu/v++46038zitEZjvm5pXCGELxbU7hlUlTmJAXhv
 3s431C/lokL1jXdubeWAUmImS/38NZkj0/OhRB/GJYOCMrS9vehkJOuY1YjGRDSMTwQV
 IiZYNt4DQM1DTviEVKCfnbsXNvz12FbznTiDBo9I7wh5TrUOgL8YbxBcgd8lKKYk8DBJ
 UAVPK+1lpOCMpsq3sNLANn3y3wFKuFegqoj+P6Ji+STJ6n/49W6RPtzQJXnJJ9FOV8L+
 8l+w==
X-Gm-Message-State: ABy/qLZsskizoBlWGajzta5NDE7zQG7ZqSV0HLM6NbU1WAmOoeSHQnNJ
 jllJrrUEdsyJErblYW31mmk/UK3XEf0=
X-Google-Smtp-Source: APBJJlF7+kk1MPOlhI4yERoPBAZSfEFXhZqLOUF7tWv0FvvQAiYOqMHDxHIPdtHpiRQWutGnuSNvGg==
X-Received: by 2002:a9d:7492:0:b0:6b9:9cc0:537f with SMTP id
 t18-20020a9d7492000000b006b99cc0537fmr1125958otk.33.1689971878132; 
 Fri, 21 Jul 2023 13:37:58 -0700 (PDT)
Received: from [192.168.68.108] (201-69-66-211.dial-up.telesp.net.br.
 [201.69.66.211]) by smtp.gmail.com with ESMTPSA id
 m10-20020a9d644a000000b006b58616daa1sm1754837otl.2.2023.07.21.13.37.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 13:37:57 -0700 (PDT)
Message-ID: <e3eee7ac-a6f8-4643-4600-845d6718e1d4@gmail.com>
Date: Fri, 21 Jul 2023 17:37:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/3] pegasos2 fixes for 8.1
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <cover.1689725688.git.balaton@eik.bme.hu>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <cover.1689725688.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.094,
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



On 7/18/23 21:32, BALATON Zoltan wrote:
> These are some small fixes when using pegasos2 with the QEMU built in
> VOF instead of the non-free board firmware that fix bugs in the
> generated device tree and matches the board firmware in the reset
> state of on-board USB devices. This fixes booting AmigaOS with VOF and
> only touches parts that are used with VOF only so I'd like these to be
> merged for 8.1.

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>


And pushed to ppc-next. Thanks,

Daniel

> 
> Regards,
> 
> BALATON Zoltan (3):
>    ppc/pegasos2: Fix reset state of USB functions
>    ppc/pegasos2: Fix reg property of ROM BARs
>    ppc/pegasos2: Fix naming of device tree nodes
> 
>   hw/ppc/pegasos2.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 

