Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EAE75C2CC
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 11:18:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMmFn-0007Kr-UZ; Fri, 21 Jul 2023 05:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMmFY-0007Kf-9m
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 05:16:36 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMmFW-00084X-M3
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 05:16:36 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3158a5e64b6so1367523f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 02:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689930993; x=1690535793;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c9zYKZRRDPlrZ7D3x51o3zBFDwMkW36wIKK9QSvJLWo=;
 b=aGbu+FmjkufQFYKF/rk2l0o4oz9xFhzY1NespIGb9xKLo+Ulqyh2eh2eUUI4LQAkx7
 uhT60BJtjYDzqkSd8yK3Mm1Z64eBB2vCqR7mF7hpakrk6r1VsMNYGK/eECR8YLtjg9Cy
 pI0wqDfGC76pcgIpI+yHeRyauzkzuUaKFiGv0KvLJ5uPrybq8/cAkJLSsmBQ6kMq+GpC
 n0w9fMs5g0uf3DftSfnTjpTW++yTnWqkwoFd2YW03LBclRn6NWHgPJyXksgA2qu5f4NO
 VTI4AbNuftw+OYHyhWJ25ioBASo3GsxPP+a5QjRRoJnSUxOtQFKVHySUEt8QOSc6eMrx
 FLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689930993; x=1690535793;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c9zYKZRRDPlrZ7D3x51o3zBFDwMkW36wIKK9QSvJLWo=;
 b=YN9ypdVSud+iny/XlxcPqZ6N5/QArzhJ/hi9+12LKhoqK8nuTvr/TglL/nbvMLeivM
 LOTP8YWYJ4AW56r6wx4uwvJbqURs7d1XyVFCntfv/q9ejBs3s9EifjbQ41l1pZqM8hdk
 ulOfFGPWf+TsiXqeek2p8JWthDsPprmF92+p8I5tnzPOPQUNPwneea1Eil8Iq5xZWQPX
 NwGvfugWJ6ysPcb2ZQYS2BMFWqObXwSNBkYioTtPGwzsDu5gmANjO45qr+k9KY+yqL8H
 qPa1HiMRGPGf6NAoJ4mXF/GeENt0Leya5kxOtGE0OKH3wxE04sRw7kVu9UyLTq4dWbc3
 JWZg==
X-Gm-Message-State: ABy/qLax8NKbIdg7KYVF84TOHAUgfY/ttIVz/9HQD+jDpEm6nNiKFIiV
 rcTc7FZRkkTcTyGKcXT4wcmD3Q==
X-Google-Smtp-Source: APBJJlF2VvTmc7E0lRHLmDJIrC9wv2d26YmE4irmV3uLmtuHn78TG9nvFYCJ6KtYsoe/oGMzjloK0w==
X-Received: by 2002:a5d:534e:0:b0:316:f34d:68bb with SMTP id
 t14-20020a5d534e000000b00316f34d68bbmr1022250wrv.54.1689930992983; 
 Fri, 21 Jul 2023 02:16:32 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.192.5])
 by smtp.gmail.com with ESMTPSA id
 r6-20020adff106000000b0031424950a99sm3635240wro.81.2023.07.21.02.16.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 02:16:32 -0700 (PDT)
Message-ID: <1d7fc618-fb10-4990-dbda-5fd610655a66@linaro.org>
Date: Fri, 21 Jul 2023 11:16:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 0/4] rtc devices: Avoid putting time_t in 32-bit
 variables
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?=
 <hpoussin@reactos.org>
References: <20230720155902.1590362-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230720155902.1590362-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

Hi Peter,

On 20/7/23 17:58, Peter Maydell wrote:
> This patchset was prompted by a couple of Coverity warnings
> (CID 1507157, 1517772) which note that in the m48t59 RTC device model
> we keep an offset in a time_t variable but then truncate it by
> passing it to qemu_get_timedate(), which currently uses an 'int'
> argument for its offset parameter.
> 
> We can fix the Coverity complaint by making qemu_get_timedate()
> take a time_t; we should also correspondingly make the
> qemu_timedate_diff() function return a time_t. However this
> will only push the issue out to callers of qemu_timedate_diff()
> if they are putting the result in a 32-bit variable or doing
> 32-bit arithmetic on it.
> 
> Luckily there aren't that many callers of qemu_timedate_diff()
> and most of them already use either time_t or int64_t for the
> calculations they do on its return value. The first three
> patches fix devices which weren't doing that; patch four then
> fixes the rtc.c functions. If I missed any callsites in devices
> then hopefully Coverity will point them out.

PL031State::tick_offset is uint32_t, and pl031_get_count() also
returns that type. Is that expected?

