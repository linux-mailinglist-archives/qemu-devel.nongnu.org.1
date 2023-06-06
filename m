Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 501CC72493C
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 18:35:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6ZdD-0007O6-0u; Tue, 06 Jun 2023 12:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6ZdB-0007NM-89
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 12:34:01 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Zd6-0003r0-J7
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 12:33:59 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1b23f04e333so2835175ad.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 09:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686069235; x=1688661235;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uwzNbHVid0QdBW+VK8OUgztWX+dCkqeks8RvSC54Phs=;
 b=opjBV8I2kc9ljiFWkeFChGAtl2dPcNPdFuwda9NzDxZ1GsT37G3ZQxAxa//aMmF34r
 2AcVRVlhLHvMkYiT/t7Th81vD60udHg+fk5ehi7qvLEuTwCe+6VXzVUmZ7o7Ruz3BSQL
 sx/BZW1h8KL/4v1y/OaI62dqZB5AbTL8OqVS4jjX1/HIsjhdlxYoChQHKdqGoIBYw5Gs
 G7MiKApS/NrDQRdjStRiV/iQ6LIYXHigSa5AIKjcCDSdxKdDFcEDuaFis00HZDgOGmSE
 mv9tpcvxd5Xwr6cvEOdbWGc5hhuREodgwgnzv781rWqdsDibd8kKIM3EmalhOj9GkAid
 91SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686069235; x=1688661235;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uwzNbHVid0QdBW+VK8OUgztWX+dCkqeks8RvSC54Phs=;
 b=Ddxe2nyjXbokq2MyaE4Al5Hg2DoPBGNQl1T9/jezBQl7dszQj+n1Ho7t2l5TjZQj6Z
 cl2C6fN7FuzYCsLqz1rF0fgUyg0qoACYhcWrk2cpazpQA3SJFFFWmbupuyC/HguMJ0xZ
 Ur5Mh0EjgbbXmk6KJqrHlJ6N3aiAprzQCiAUyf0sDZf+XeNRQ3ha+MPcvINvcjfUynzy
 AVMOpGopCBdAa95qPGrzs5F1V4GM8yg3+9g+djgzekL5syfWkrztj/KDv8QR8xQol7ea
 sHLVABDo4w8w/ynLNGlbey0Y6yDfUrwXRRadGCtIklVKJ5xOcpyeSMGvmdHrGswGWaax
 kL/A==
X-Gm-Message-State: AC+VfDyfpUYhMagipN8QHhLimjlnm/Jv3tE01NmdQ4/f3uvSmMDg1Fza
 InB+5JZkriuuLsjkUSC3G7eNhg==
X-Google-Smtp-Source: ACHHUZ6iUA2d2lId+3IRVF/DpcwfPylAOh3KP04zB3XGM+EnFzCXblR65wLOj+J6CRTJddDQ4JBQAQ==
X-Received: by 2002:a17:902:d716:b0:1b1:9d43:ad4a with SMTP id
 w22-20020a170902d71600b001b19d43ad4amr1129770ply.44.1686069234985; 
 Tue, 06 Jun 2023 09:33:54 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:b7fa:ce59:1445:805a?
 ([2602:ae:1598:4c01:b7fa:ce59:1445:805a])
 by smtp.gmail.com with ESMTPSA id
 y20-20020a170902ed5400b001b034faf49csm8712730plb.285.2023.06.06.09.33.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 09:33:54 -0700 (PDT)
Message-ID: <6fc611eb-59f0-4943-08f8-f6653a13d4f4@linaro.org>
Date: Tue, 6 Jun 2023 09:33:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/8] linux-user: Expose do_guest_openat() and
 do_guest_readlink()
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20230606132743.1386003-1-iii@linux.ibm.com>
 <20230606132743.1386003-2-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230606132743.1386003-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 6/6/23 06:27, Ilya Leoshkevich wrote:
> These functions will be required by the GDB stub in order to provide
> the guest view of /proc to GDB.
> 
> Reviewed-by: Alex Bennée<alex.bennee@linaro.org>
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   linux-user/qemu.h    |  3 +++
>   linux-user/syscall.c | 54 ++++++++++++++++++++++++++++----------------
>   2 files changed, 38 insertions(+), 19 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

