Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3796383014A
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 09:30:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ1JI-0003p9-Ev; Wed, 17 Jan 2024 03:30:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ1JF-0003p1-Rl
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:30:05 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ1JE-0007Mv-6y
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:30:05 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-55783b7b47aso11524537a12.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 00:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705480202; x=1706085002; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qNnwIFCMrXpJMjb1pIaRSRVwb5EkQZE0d+nwUWAUw78=;
 b=xn9mgfJucOp9CUgbsU5zoWWF/MINZNvH8KVjB9qvgWDKacv6q2ijKf8i8gan0Y+zwF
 Jr/w9a1a4dSmc66gaWuDy/fNR5aihu1q82woq3OknmKjhOO7BEpZRQByCQCbknuprGZU
 u/hGEibs2xVUxvm7fNwLyrapdhsa/qBMQZigLDX7EJ3IPXrLdp1VfaFUQyaIeLywSNSW
 vJMTX37g+c432U54QFByFh4Kl2/y3MMR0hE8Ff47yhepC1jdPFDeXuFUbXniEekEBOOw
 frD3gZKGotJ0dWIPd6eObBkP2upWXucx/g5CUR8GbwUvxdcaK9t8x4HV2jeKe0x5m/4Z
 IzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705480202; x=1706085002;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qNnwIFCMrXpJMjb1pIaRSRVwb5EkQZE0d+nwUWAUw78=;
 b=Fek/C/o3Rzgh1Men3U/p57ExTEgzd44XfP2YFsQx5CN1DJz6pZWiBAyOAmYV/xOto9
 i6iTmYYb7RRLF+0V3D7Lxb2vnN+xV2TvU1hhtgRiju0m2BiZ3Pv9GNn+L4z65rrP26R+
 b/j8aUjCYCvecBpCSY5StpUOdsKpGnJ+iZC2qY1bmZwKhz088medeNvgwqsLlfaBc3oA
 wxUHd4JYCZILghnWnJigY2j1f7WCUyoWF21QM9l6uPk9+fOCM9KmnDhYPtRr7wCYHTLP
 d6SDhxN7OwHdDLnYrJ+eo1ZHj8dIYRLFcOahqpFrEnbuxKFfgl9XO8se7ovVooS7yDAD
 E5MA==
X-Gm-Message-State: AOJu0Ywat5/Av5HOnDhLzHbCCbcNlXt0IuhzU02tGFDWsBaZ0jkfkZjE
 qotgKqXHAwvasROdAQkvG2CHLslHDaZGHA==
X-Google-Smtp-Source: AGHT+IFBJSx8fBBv4Jf6RRpwyqlG6mmAfWlV9ecJGkrkhjk6vG7Ex47+Nt1hRudyXndZc7vqlM5e/A==
X-Received: by 2002:a17:907:d40f:b0:a2d:14c9:e4c6 with SMTP id
 vi15-20020a170907d40f00b00a2d14c9e4c6mr4093629ejc.4.1705480202514; 
 Wed, 17 Jan 2024 00:30:02 -0800 (PST)
Received: from [192.168.69.100] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 o10-20020a170906288a00b00a2a632e4eebsm7399108ejd.119.2024.01.17.00.30.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 00:30:02 -0800 (PST)
Message-ID: <0f689e73-0816-44c9-8477-6557831f3157@linaro.org>
Date: Wed, 17 Jan 2024 09:30:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] accel/tcg: Move perf and debuginfo support to tcg
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231212003837.64090-1-iii@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231212003837.64090-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Ilya,

On 12/12/23 01:34, Ilya Leoshkevich wrote:
> Based-on: 20231211212003.21686-1-philmd@linaro.org

> Ilya Leoshkevich (4):
>    accel/tcg: Make use of qemu_target_page_mask() in perf.c
>    tcg: Make tb_cflags() usable from target-agnostic code
>    accel/tcg: Remove #ifdef TARGET_I386 from perf.c
>    accel/tcg: Move perf and debuginfo support to tcg

I'm queuing your series as part of my accel/tcg/ rework,
and will post a PR during the 9.0 dev cycle.

Thanks!

Phil.

