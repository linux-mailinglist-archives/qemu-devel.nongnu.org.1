Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 216B17B727B
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 22:29:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnm0m-0006Xm-Qr; Tue, 03 Oct 2023 16:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnm0j-0006X9-5Q
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:28:54 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnm0f-0001Xt-T6
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:28:52 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c1e3a4a06fso10462675ad.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 13:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696364927; x=1696969727; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0e4/JO57YQImFLHZPXmeKqU9ZF/znrSmUlXSYTqB6DQ=;
 b=s+giaCL/ESrvpuZM/J4cI7BJoYvM/yDOeMeQ2+hiYvzOcJUcOm/42/P0N9kstZdHbp
 6DqVkVE0D0BeAZZy9JfQ1DCEzydlmKDg5WDs/iy48c8VU2q59dgqk7q5Nrou92gDbs1U
 4As9xLuMCVWnJ3Y17SQO4aH9+m+MTghncgpjiWIG0K/mVwLVYh9vztE81xk8Shk1rOfl
 w2i1o5KUBTOTub8Tr6X9pCtxJx3yZ9ObXHwesoYBblkZX4ZXBAAst//UP0cfyQfwD/W6
 HXTi705Gz6TF8HwBj6aZFbPNHcTLjtpU9uKQAEYAO563GnozI7/wEIpWpKnOxUD0C+aD
 NiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696364927; x=1696969727;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0e4/JO57YQImFLHZPXmeKqU9ZF/znrSmUlXSYTqB6DQ=;
 b=Arw9axg2fqW9fTSjFqXkyLWCn5jK3If0EmzeZcKemspVUHKHoNuEHhnSNssWUfAKzv
 ksU7qgHI0VAaC047rjxtJW+6EKYnfZWpEJfe2bd2RIYzR8e/xJfuOJ3F5QdCOp5dvgcR
 23JdHpqR3jV3i/s8Kub8LLgBf2jqb3RvIiCzcswmGBGSUje/PyvxWmrG0OsNjieBPKma
 rJmrK6f4iXIv24jzuhn4uzNwivWvngwaQeCpbEKhQ0rKA+tFUyPW5R/G1tDiTsqjG75S
 1f6CBaSQXLzNgpuOBkvVcqrfjYTui72mF+ldMN4Gvt6fwlc381KsbfMSuzvqrt9NBwqG
 7+CA==
X-Gm-Message-State: AOJu0YxDj9QJv4eMbIcSt4rQ0NpC4DbsXW/dRDkB0pqT2uG6XFY//DYW
 Uk2CE2hdvCdHGtrMbt02es/Nm/0LzpFYQ6xv5ig=
X-Google-Smtp-Source: AGHT+IGlYpw/julF/9EX1f0LgJOddZmdBIRdyvxHsO8rggRk42RH6DzIygimTyolRcAFO2Do6MJOcQ==
X-Received: by 2002:a17:902:ec8d:b0:1c3:4210:623f with SMTP id
 x13-20020a170902ec8d00b001c34210623fmr721821plg.13.1696364927620; 
 Tue, 03 Oct 2023 13:28:47 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 12-20020a170902c20c00b001b016313b1dsm2026664pll.86.2023.10.03.13.28.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 13:28:47 -0700 (PDT)
Message-ID: <c2166e70-1e2d-0b9b-ba76-2ab27ef17c50@linaro.org>
Date: Tue, 3 Oct 2023 13:28:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] mips: fix abort on integer overflow
Content-Language: en-US
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@kernel.org>, qemu-devel@nongnu.org
References: <cfa02bbb-cdaf-4310-ac40-a2837d33c710@redhat.com>
 <6148083e-ba07-798c-4cc3-6cf29236c53c@linaro.org>
 <3ef979a8-3ee1-eb2d-71f7-d788ff88dd11@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <3ef979a8-3ee1-eb2d-71f7-d788ff88dd11@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 9/28/23 12:55, Mikulas Patocka wrote:
> 
> 
> On Thu, 28 Sep 2023, Richard Henderson wrote:
> 
>> Just call force_sig_fault directly.
>>
>>
>> r~
> 
> OK. Here I'm resending it.
> 
> Mikulas
> 
> 
> 
> From: Mikulas Patocka <mpatocka@redhat.com>
> 
> Qemu mips userspace emulation crashes with "qemu: unhandled CPU exception
> 0x15 - aborting" when one of the integer arithmetic instructions detects
> an overflow.
> 
> This patch fixes it so that it delivers SIGFPE with FPE_INTOVF instead.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: qemu-stable@nongnu.org

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

and queued to linux-user-next.


r~

