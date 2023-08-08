Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E29774D1C
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:35:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTULv-0004hw-MG; Tue, 08 Aug 2023 17:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTULu-0004hT-6J
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:34:54 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTULs-0002M7-Ky
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:34:53 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bc8b15c3c3so7288725ad.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691530491; x=1692135291;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4mEK9hUNad/KalhQv9inXPFyz+xpOTXcISk5ikscxBI=;
 b=rFiRwWUcbsr3gIDEmYcYnq0yIoYPjEPlFZVMG4IQaYZo4tH4htJKvIDWeY4l44I6yr
 69U14jLRPVQzwxWGCqktiTS4zuLe0JosmNBAkBoU0GQNuJRDuXakaLhb4igZ4ZBeuiuA
 XEZxOoL6K8L0YaLzPsvnByrz81oHb6mWut1pcBHICPqv18mgszAvjyWtLaa3IdxVc0Xg
 kYqzAvQOXYLQuf8eHNLj2cJARrhs/1pdD1AQ2CEaXc5jlaNDph/QwLpVGFjb4ATOz8/P
 Fing+TCMKthkOx3e+DcZbwTN59J8qXsv/3gxE0aNfXvfA0TStUHVA+IiRtfyIJbWJgya
 lSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691530491; x=1692135291;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4mEK9hUNad/KalhQv9inXPFyz+xpOTXcISk5ikscxBI=;
 b=Z88PuIwVSPFN+YccjxtbI7oCPZAbQYB4++0Dm9+nXotE1twciVY5TrsC2EKeaVISSc
 zl+WEautq+Pl4OHTegqQl/FMvKeVQxUFuo7AqlfjNdYpV1RXCYik46w7zyPpbPWbGtXi
 kPz2k1h5Nf5PfWHB5eUrTD0qWevHnQGj2SV6LyfgS91lXD8zcD8fDFKzo8iNom0BiWX3
 RHmMOiPTU7Rm5uelhHZqF3UE95cy/JxaM2pe6n4Z2Z+7zkd0KH8Lc+cnY30oTh2w/RGn
 E2awE2MGJPR1wm7qlXAcLXYobTi7oVn/rBVgbelx7jjrQmhfiPPM/4b2oDopIFnCdFfl
 3E+A==
X-Gm-Message-State: AOJu0Yx9fjSTeA9lQNZN9d+52N5n+2zTbw5ND5SCEVUHiTkgJlHK3h/J
 QQV5BQNDg+JBxkj3FhbiASshAQ==
X-Google-Smtp-Source: AGHT+IE52eyxqjeiCb+yehbXja+Ld/C9PvF2hAfH0D6lDHi8i6g5n8oB10k3p4aN/jx4lrXL331Uhg==
X-Received: by 2002:a17:903:486:b0:1b8:475d:ebf6 with SMTP id
 jj6-20020a170903048600b001b8475debf6mr946585plb.0.1691530490660; 
 Tue, 08 Aug 2023 14:34:50 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 c13-20020a170902d48d00b001b801044466sm9483258plg.114.2023.08.08.14.34.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 14:34:50 -0700 (PDT)
Message-ID: <6735af7f-1b3f-356e-f475-493cab871b07@linaro.org>
Date: Tue, 8 Aug 2023 14:34:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 14/33] Implement host-target convertion functions
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-15-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808060815.9001-15-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
> From: Stacey Son<sson@FreeBSD.org>
> 
> Implement the stat converstion functions:
> h2t_freebsd_fhandle
> t2h_freebsd_fhandle
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/freebsd/os-stat.c | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)

Same typo and changes to subject.  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

