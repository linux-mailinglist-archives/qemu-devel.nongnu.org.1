Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19378774CFF
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:25:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTUCH-0006Mz-Ol; Tue, 08 Aug 2023 17:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTUCF-0006Ma-Vr
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:24:56 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTUCE-0000aK-Fq
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:24:55 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3a5ad6087a1so3525081b6e.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691529893; x=1692134693;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=22TEvse9lAesR0zStf9Ij46h9t2KivkUat8oP9Qzq+E=;
 b=LWTYtLLnqRXFbnGl/JERXlENPoASacqcNHhKRiUHrEX6TeO97BTZgjsN2O5a+7Q5UL
 wfoPm1kNRdmGeMurDNQ1QcFqZ0oUWu2t3tAVt/wopl8Nfo9uVHZnN1lfZ3qUynqymio0
 uplvBPnBS5V7Cveiq3N6YuXVEMNa3YSHRQYlm+P6ECRbyUPGQ1NLz+X0trGLGEE0x6Yo
 UWaWq4pUngrCQAqTjxYNaK5V2HZEIdWn50JxdW9k897QBfVrMeAT46j7X3NZ5O/g79mB
 HuY76nAMAgGZQuUO2CEjISjS5S2/K4zLy8HKSwUlLZVUJOM1TTBZZiH0D9nr1ifpXXsJ
 y+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691529893; x=1692134693;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=22TEvse9lAesR0zStf9Ij46h9t2KivkUat8oP9Qzq+E=;
 b=c38oplkOqcO7kYz7vSAYtOJ3s2NfXEUS8W7SQvvC1ICj+WLr1Ag1jdXmDLEY95+/0W
 Hzkn3Ci/JkmloLbT0FwlTi8UDYxw6gJIaPX2WPwQ/N3CiRwvw0hjXVts0n/CEIM3bOPO
 sGqMVlispIqNkLEV7vCXU9VRxi4vd7HWR94yULwXDntw8+Szj07II/FT0Cpt08OF5lAU
 g+0pz/onqiqi+ILceNZHfITQrcCZOEab6Br6AVIRPGixZ9qyqeyB5d7ZdwUtqyuzjMXx
 2tkDNsy1RWAQZX4voDxdrJKphjW5tuAMyBAtZFeTdazpJ61IBQC6OEtPdyAY2sFeUc6J
 afdA==
X-Gm-Message-State: AOJu0YzYJQ5SRg8y2x0yhX2kxWQmJkBJ6uy4yoU2d455YYPuzTxn3IJp
 vv2GDPH+t7ahv6SpdhEbX8jp1M+Ii7yshrgRmes=
X-Google-Smtp-Source: AGHT+IEm/O8HB9e5VG6NvfCClaiSrFgFoGI7cEJKUwiQoSk+eXgVAUe0HML6pST7LuRORPXyzQgueA==
X-Received: by 2002:aca:2415:0:b0:3a7:5314:e572 with SMTP id
 n21-20020aca2415000000b003a75314e572mr935626oic.53.1691529893166; 
 Tue, 08 Aug 2023 14:24:53 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 v1-20020a17090abb8100b0025bdc3454c6sm1399pjr.8.2023.08.08.14.24.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 14:24:52 -0700 (PDT)
Message-ID: <14d3fa60-0c91-66b7-7887-7854a6a5125a@linaro.org>
Date: Tue, 8 Aug 2023 14:24:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 08/33] Add structs target_freebsd11_nstat and
 target_freebsd11_statfs to bsd-user/syscall_defs.h
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-9-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808060815.9001-9-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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

On 8/7/23 23:07, Karim Taha wrote:
> +    uint32_t   st_flags;    /* user defined flags for file */
> +    __uint32_t st_gen;      /* file generation number */

Drop the __.

> +    /* __int32_t  st_lspare; */

Why commented out?

> +    struct target_freebsd_timespec st_birthtim; /* time of file creation */

Does that not place st_birthtim at the wrong place?


r~

