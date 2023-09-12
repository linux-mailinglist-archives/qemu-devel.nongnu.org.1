Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DCA79B99E
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 02:10:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfqyf-0007u7-3Y; Mon, 11 Sep 2023 20:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfqyc-0007rF-6T
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 20:09:59 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfqyZ-00045B-Sd
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 20:09:57 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c1ff5b741cso45944135ad.2
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 17:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694477394; x=1695082194; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SDuWF8c9b4lA5L05Gq1UPOVSFQIGxlGtRayvwvGbKMs=;
 b=QkG4Ue4kS4KetTTOolvYg3PGd1YYLdPSPkaMSWSEO1CIxcQQedoQu2YJQbBUqSkkJQ
 equMP1rR1qsY3jCDBHT3iJaGShSgtvO3xnP/K58NvFLXkqrv8WnqqDYJUoPk1HraT5h7
 WJaWvtLhonWMWDu8jmvnCc9GyyP+0dG+IEZcftQjkBezUaMQ/rXaQUlQVhzzYsURGIie
 t/C1elogEDMbi+LRan6dvgLvRZAwHICZbgk8OZ5qvJVvREmEBRmKXOwqMZ1Jh/+/8si6
 uavakbLk9Y5xAmJ/v8AMi+EJPgHpiTOvZ8V2GcK9jRq4g0tB+VJr5fZRG4mZcqtc/Wy4
 Mt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694477394; x=1695082194;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SDuWF8c9b4lA5L05Gq1UPOVSFQIGxlGtRayvwvGbKMs=;
 b=LOWIYkn5ee2QH7KX2X9tGzVxoh2QaFr0Eyns+UJMUolNNlOnQkpRVDr6j3oyeSNLIK
 H8dFTQO1YoHfYCGY6anSDWnX1/9k1QKMR9EppYiV8hZzZO1B3hDc/OC6NwDV1YZ13guk
 6NF4c23miSOfNOukP2hwHC5xkqKL3VY46jqgfaI23PDNzZIorVd9Q5j3NulfA7zzEJPK
 yutz3+5A1qQ53fVG60JIH6o0B8APoNycL6FWueKFJ9UkLU6Bm/nEub2x5Z/S0FHT08rf
 /80WTwPEEN2AWQU1gAVrIzcVwRLO9OLVkiYe4p5qyNe2GzFYVIB3Yoqh4A4eCkm0cIO0
 MBcg==
X-Gm-Message-State: AOJu0YyCd8IspjQxNvVwndoO/3TzNnNidZrbzzVU/SzlS4k1NEDhgEUp
 1d/lSrVy2wxv7XvSoYHtevi5QKnhNtYE4IeN6qg=
X-Google-Smtp-Source: AGHT+IE3aq0MbJbAVORPpAnVEDU9PD6FP84s1m0ch4LOlL4umqVzBHz2Uy8QzNWFXs5/FbhBQalAPw==
X-Received: by 2002:a17:902:ea0d:b0:1b6:6e3a:77fb with SMTP id
 s13-20020a170902ea0d00b001b66e3a77fbmr13187683plg.2.1694477394528; 
 Mon, 11 Sep 2023 17:09:54 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 z5-20020a170902708500b001a80ad9c599sm6993201plk.294.2023.09.11.17.09.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 17:09:54 -0700 (PDT)
Message-ID: <f38f5742-72a3-03cd-860a-71dcd444a3c5@linaro.org>
Date: Mon, 11 Sep 2023 17:09:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 23/23] bsd-user: Add stubs for vadvise(), sbrk() and
 sstk()
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
 <20230909193704.1827-24-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230909193704.1827-24-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/9/23 12:37, Karim Taha wrote:
> From: Warner Losh<imp@bsdimp.com>
> 
> The above system calls are not supported by qemu.
> 
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/bsd-mem.h            | 18 ++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c | 12 ++++++++++++
>   2 files changed, 30 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

