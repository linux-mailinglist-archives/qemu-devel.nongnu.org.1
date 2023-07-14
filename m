Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9497531DA
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 08:19:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKC8m-0004GT-9W; Fri, 14 Jul 2023 02:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKC8k-0004Fq-4j
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 02:18:54 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKC8i-0007mm-HS
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 02:18:53 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1b8a8154f9cso9766175ad.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 23:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689315530; x=1691907530;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H9w7Ft0dUoYjvvhHQxcQZzGKeT3BFrBzQqRHcrWo+gI=;
 b=eHvfIi7VfQG2qh/hD2YR99vtNzSPDpj06NJ1y92yaq3jwr4K9Bag4AgU8gg6F3q2Vd
 nTOpB98gnz/LLWzO1frXsIAQXPhzH82et5cMbEnXOpOdLVInYamCCocez6fPJlZiWf5M
 cflazyPWwVX6cp90DcMyIWwPeHSPXHBVx44jFiAXo5tupaYCv635dTDOZYobhDQpHG9V
 mYLhmB2L6sFumpgtm7d/xktwh8eVUdBcNxCVXOOxO5yAPzLDzZPXAPmpG7+URlXQD6Ux
 MQb5oWzc4jIXpCOYDs5LvUtAymoiOsrfZtiDDPEvdTAHEMXqoCCSbbNux9Vtc/BLqbxo
 +OHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689315530; x=1691907530;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H9w7Ft0dUoYjvvhHQxcQZzGKeT3BFrBzQqRHcrWo+gI=;
 b=f8iWasXBffe/gNeyOuE+xwwnXXzPve7Y4JKgEarAONaKpOcJth2VxeD0hsFlAHYj/O
 /Qln9hQQl1qh44kR4zc8+jZ3gwhM6CF0JLcQPtGB2IOK8iGvZtor8g54WaTEXxXSFX0h
 I8delEiEBrZ1rwMMb7BNodMXCLJrjP/4LGck0Wh+kG1z9EJ1SKseeOOLHRbrW/bI8vju
 cnTGbPpbCGEtaKMOXl9fJc0JykWDALmIn7blu93/QUYH5PhNP7EqD1vDHa95qPrBXwkX
 /XQ3no42N/YhqKrzvTybuWoCjEiJ6vy89G3uYqTiX55jDiLL4N3dZT3fjBbsxQxsZdu/
 sY2A==
X-Gm-Message-State: ABy/qLZS+7UjWXxw0DiBmk1wcrYNFJ+4t9gDHfngfOdf7yEQIQtoza6r
 MGs2eDzfSkWZgRm4UXFGQEFoUA==
X-Google-Smtp-Source: APBJJlEqjSBrcfj3I8HTP73f0hgL2gjsEstVWfnGDSJcXGfTeiPc1cKKVOK47OatGzMKZrR0IZMBUA==
X-Received: by 2002:a17:902:c245:b0:1b8:5bca:8256 with SMTP id
 5-20020a170902c24500b001b85bca8256mr2105707plg.31.1689315530342; 
 Thu, 13 Jul 2023 23:18:50 -0700 (PDT)
Received: from [192.168.149.227] ([172.58.27.104])
 by smtp.gmail.com with ESMTPSA id
 e15-20020a170902ed8f00b001b7fd27144dsm6927384plj.40.2023.07.13.23.18.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 23:18:49 -0700 (PDT)
Message-ID: <df0a73d8-8063-4147-e697-6e08085a09c5@linaro.org>
Date: Fri, 14 Jul 2023 07:18:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1] tcg: Use HAVE_CMPXCHG128 instead of
 CONFIG_CMPXCHG128
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
References: <20230713202327.12662-1-richard.henderson@linaro.org>
 <c99ad0cb-a5b6-3a6b-a256-32aa9028eb2a@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <c99ad0cb-a5b6-3a6b-a256-32aa9028eb2a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 7/13/23 22:36, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 13/7/23 22:23, Richard Henderson wrote:
>> We adjust CONFIG_ATOMIC128 and CONFIG_CMPXCHG128 with
>> CONFIG_ATOMIC128_OPT in atomic128.h.  It is difficult
>> to tell when those changes have been applied with the
>> ifdef we must use with CONFIG_CMPXCHG128.  So instead
>> use HAVE_CMPXCHG128, which triggers -Werror-undef when
>> the proper header has not been included.
>>
>> Improves tcg_gen_atomic_cmpxchg_i128 for s390x host, which
>> requires CONFIG_ATOMIC128_OPT.  Without this we fall back
>> to EXCP_ATOMIC to single-step 128-bit atomics, which is
>> slow enough to cause some tests to time out.
>>
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>
>> Thomas, this issue does not quite match the one you bisected, but
>> other than the cmpxchg, I don't see any see any qemu_{ld,st}_i128
>> being used in BootLinuxS390X.test_s390_ccw_virtio_tcg.
>>
>> As far as I can see, this wasn't broken by the addition of
>> CONFIG_ATOMIC128_OPT, rather that fix didn't go far enough.
>>
>> Anyway, test_s390_ccw_virtio_tcg now passes in 159s on our host.
> 
> IIUC:
> 
> If we have CONFIG_ATOMIC128, we use qatomic_cmpxchg__nocheck;
> else if we have CONFIG_CMPXCHG128 we use __sync_val_compare_and_swap_16;
> in both cases we set HAVE_CMPXCHG128;
> otherwise we can not use atomic128 cmpxchg().
> 
> (I'm trying to figure why we need both CONFIGs).

Or sometimes we use inline asm, because there's no compiler support at all.
Please see host/include/*/host/atomic16-*.h.


r~

