Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC45B748366
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 13:47:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH0xh-0001ZR-Vx; Wed, 05 Jul 2023 07:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH0xO-0001Z7-Qj
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:46:04 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH0xM-0005XR-W0
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:46:02 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-51d9128494cso6405607a12.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 04:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688557559; x=1691149559;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YlvHuKvesmhTB8CtcHXWorDgoBFHKq7RenHPoX+G0Z4=;
 b=SEb4sg8F4P4jfE826Tb7ceQjgy9rUIaFR3o+2UOlpHsBbrHpA8IHi1lU6Ed5ST83RG
 sJv9btC8mvq5HhFjzKGWee0LAImzEx4E/I7tac8CAmWFT8dkZViNhXFEJ8Gj4v4HVI5e
 579TQ/JJ9kpOCmfRzx+eLgke8Wlvx+9AG2oCdEqNDWJhSCitbLVaIeUzv0ixJUPNvz+m
 rk5f0LBG1mJt+If3AKNjmUNEtRF/T1z5VRnLQ/ibSedarOD/Du2S6HBFDu7+V6te6b9w
 WwxgMpZPPBNfylh/HPYixSWtqUSpQGKgUXv4efCSl/sFZXxRUnZgHILrtpHai8zVANqk
 JMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688557559; x=1691149559;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YlvHuKvesmhTB8CtcHXWorDgoBFHKq7RenHPoX+G0Z4=;
 b=k59EvzMDaRWj5HC5ftpnxHHGjxXO6+Ec8dEbycVXpfRYLvOHty3iNWzxNMJIz21yni
 VxVEX2LcZwKmHV86flkIQ1SHq9/vnUPDYh94Ni+orrtgzaLcyNtSCiPr93CXpbNwEbrM
 6YcuAxETblylspEBQL4a9RMvBU4pzrhDhSAHU9pydA9shDYtmN4NQp0PbpqtvfHtKRhx
 FnhD0HfAJtgxEqR4Ud2s/O7UJL82kWJcr0/sPZexeVN/v7uCfpd43P8oyPNcVfuMRA69
 z/aQ4skBKsOIX//x8P5V+8vlxhYDNhsQDv9Yz+eVu/Lz8b3TSYSPleRTRVLKKB9gDpL5
 tf8A==
X-Gm-Message-State: ABy/qLZmtSwneFTGOO35i+uWt8H8W8TETq7gXsrHKnXTxsKx1BIn6RJJ
 pM5mzPo313KgUtrXY5gZNoV/qQ==
X-Google-Smtp-Source: APBJJlE4cy0RhzUGjVA17GRFp7Umjk0tcR4I0JlhRBltbSddVLwhLg/uAKHhhYE58Ii5NTr89bI/tA==
X-Received: by 2002:a50:fb09:0:b0:51d:fa7c:c330 with SMTP id
 d9-20020a50fb09000000b0051dfa7cc330mr9710215edq.26.1688557559242; 
 Wed, 05 Jul 2023 04:45:59 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.96])
 by smtp.gmail.com with ESMTPSA id
 b18-20020aa7d492000000b0051da4b5bc8fsm10131989edr.20.2023.07.05.04.45.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 04:45:58 -0700 (PDT)
Message-ID: <82434e83-d156-1a29-fb82-d6127162c185@linaro.org>
Date: Wed, 5 Jul 2023 13:44:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 06/13] docs/devel: simplify the minimal checklist
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: fam@euphon.net, berrange@redhat.com, f4bug@amsat.org,
 aurelien@aurel32.net, pbonzini@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, Thomas Huth <thuth@redhat.com>
References: <20221117172532.538149-1-alex.bennee@linaro.org>
 <20221117172532.538149-7-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20221117172532.538149-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

Hi Alex,

On 17/11/22 18:25, Alex Bennée wrote:
> The bullet points are quite long and contain process tips. Move those
> bits of the bullet to the relevant sections and link to them. Use a
> table for nicer formatting of the checklist.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <20221111145529.4020801-8-alex.bennee@linaro.org>
> ---
>   docs/devel/submitting-a-patch.rst | 75 ++++++++++++++++++++-----------
>   1 file changed, 49 insertions(+), 26 deletions(-)


> @@ -314,10 +320,12 @@ git repository to fetch the original commit.
>   Patch emails must include a ``Signed-off-by:`` line
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   
> -For more information see `SubmittingPatches 1.12
> -<http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches?id=f6f94e2ab1b33f0082ac22d71f66385a60d8157f#n297>`__.
> -This is vital or we will not be able to apply your patch! Please use
> -your real name to sign a patch (not an alias or acronym).

Revisiting this patch, asking for some real name instead of alias
was at least helpful during patch review, we could address the
contributor by its name. Addressing an acronym is socially weird
(at least in my culture netiquette).

> +Your patches **must** include a Signed-off-by: line. This is a hard
> +requirement because it's how you say "I'm legally okay to contribute
> +this and happy for it to go into QEMU". The process is modelled after
> +the `Linux kernel
> +<http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches?id=f6f94e2ab1b33f0082ac22d71f66385a60d8157f#n297>`__
> +policy.



