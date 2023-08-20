Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2C7781E72
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 17:11:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXk4h-000429-8x; Sun, 20 Aug 2023 11:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXk4f-00041y-Ne
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 11:10:41 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXk4d-0006mo-Jh
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 11:10:41 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bf078d5f33so19570725ad.3
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 08:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692544238; x=1693149038;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O8MFuZpeKY4hnXkA4Z6IvjsIfVWiTj1q20cG2xdwOg8=;
 b=nQ+Hxadb4Ty5xzH6eMBE3jpE54co29ZUh7sKwdhrXqdvh0jzVSebZQCLzStTIuU1t+
 KoGK0K9GV4Zi2QGt+qdInUtq50zOKLvsKrvULallt9LgWZZar0nqABya3ZcDjlYxltZ7
 cqupR5wqHP97FgA1hVJ1uGFaAh8x/fNRfMld9c9GJjCYpo+uuWjZb2COKZaqGUmxHbSm
 +8e8fmDQHIbL/kNpAyp7kPxw7TwGZoLspLBWZaRSZn4YnVgEbRCyQg+AG/XQ/fS/nm3w
 pMP12ZM9yHtS1CCLFFEZ0XmokhE2kePU0IHj807Vr76sRsM6pz5L3az2vhPft6nl7hw4
 vENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692544238; x=1693149038;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O8MFuZpeKY4hnXkA4Z6IvjsIfVWiTj1q20cG2xdwOg8=;
 b=GGdJBSIbtvkKImmk3lVbqBh8rvhOi6HZx0hqEdiF1qnsB2XFbqd5uFYbUXtkVgZHKT
 JrgblzAKoBnHNYvjbCKdL1Q89j9K7qhSaeO3aztl6tOeNfc6lQmPgbTlq5QSscRY1ktd
 ZQZVhbOxy42wDJyZva+U789vScnAHc5h590GM+QYsSYXZfn8CfAdMu88XBplqg2BDeiW
 T33yvDHmJuUeYCMBYklMMhJ2T/uvIcPpiSywSZSsVISAOdowr2Cx19gq1Vu9Qb00XD4X
 b0Wb6gDoprQRsfpEE3RknWIu5QwR8pyWCv4i2VnWOkwXf4EhRn7MyHEMHQcixhAL4blz
 2eUQ==
X-Gm-Message-State: AOJu0YxmLoNT0B/bwBcsPzx2OLdyqJYxjQ6gUlVdQ3nDXUzMS8yCS13s
 60Aconf7s7Q+k/4lQsLj+gwkrHE+sTlqVlQcBXk=
X-Google-Smtp-Source: AGHT+IE7pK8cEn6f1Xwdtn/lJtifOB3Z7B+iEUNsID8X16TCcl9d7/KGU7bvWZsa83wJO8fd4ppseg==
X-Received: by 2002:a17:902:f684:b0:1bf:205e:fe5d with SMTP id
 l4-20020a170902f68400b001bf205efe5dmr6283895plg.7.1692544237796; 
 Sun, 20 Aug 2023 08:10:37 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:347d:4d37:bdd7:f5e5?
 ([2602:47:d483:7301:347d:4d37:bdd7:f5e5])
 by smtp.gmail.com with ESMTPSA id
 iw14-20020a170903044e00b001bdea189261sm5212715plb.229.2023.08.20.08.10.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 08:10:37 -0700 (PDT)
Message-ID: <561ef2b3-b4a1-3f58-bff1-73bc034b0aa0@linaro.org>
Date: Sun, 20 Aug 2023 08:10:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 18/22] Implement shm_open(2)
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Kyle Evans <kevans@FreeBSD.org>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-19-kariem.taha2.7@gmail.com>
 <7262295e-b98c-448a-a864-fab81e05babb@linaro.org>
In-Reply-To: <7262295e-b98c-448a-a864-fab81e05babb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 8/20/23 08:04, Richard Henderson wrote:
> On 8/19/23 02:48, Karim Taha wrote:
>> +#define SHM_PATH(p) ((p) == SHM_ANON ? (p) : path(p))
>> +    if (arg1 == (uintptr_t)SHM_ANON) {
>> +        p = SHM_ANON;
>> +    } else {
>> +        p = lock_user_string(arg1);
>> +        if (p == NULL) {
>> +            return -TARGET_EFAULT;
>> +        }
>> +    }
>> +    ret = get_errno(shm_open(SHM_PATH(p),
> 
> Again, SHM_PATH is not needed, because the condition is handled by this IF.

Oh, no, that's something different.

But path() is wrong for shm_open, because it's not a path in the regular file system.


r~

