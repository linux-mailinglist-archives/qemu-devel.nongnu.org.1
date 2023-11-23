Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 039407F593E
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 08:31:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r64AQ-0006ci-BW; Thu, 23 Nov 2023 02:30:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r64AL-0006cC-0x
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 02:30:25 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r64AC-00050j-4Z
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 02:30:24 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cf897c8de1so3612945ad.0
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 23:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700724614; x=1701329414;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oTAWXsd+5aytMUjc2UHdZcOceO5Js9LlAW63vi5Bq3k=;
 b=KnoB047qNZjqqRjY5MJ3YlFEFGFhdkkXvZMoV9dYE6tAwPRXkHE92bMOHFk5f1Kgzw
 kjl6SSmFzXgU3ZkXRCWr/aFwWs217Cbqb8btbVCbMyy4MkIX9MnPbRTBNWkXnhR6zzWH
 lGfhls903fmn/sYyPpDSfr5ajhmgWClmYNeW0ECitKbatBWY7RLMM81wz9MOwVG4OySS
 8F/O/h5CzmyZqKj7nu1cv+SKDB/gz/O+98dAgVFoCW1yExLfDb7BDWfrS63XJdaz8qG4
 beSgUiUj9J4TgfrQOHl7lpSs1Kvuc2iem1HjY1WhgDE2N766z8gkLKPATniq4N4paWqN
 tDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700724614; x=1701329414;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oTAWXsd+5aytMUjc2UHdZcOceO5Js9LlAW63vi5Bq3k=;
 b=tDHgYg0r4akhqp8CSnmhlgjYRBIfLojTJ3Hhxa3/P1X78MJ8nDqV70hRkWdZAjA8aM
 huLzYvqwtv4eivPDEzPUPsLm44aIPZNeQQTOJqobYrwHcIKI/eQEu1fjFX7FgvKYjcjI
 nbZPsrjO8hxR11+RrPCHb3UhWaXQ+Qegdbe4z7RnfUZ8R1ACWV26LRC6MxOUWVEHbFbX
 DvCVReNpxxvKX4it5lLQe9FnYUnJSrWLUOFC7JMjxfAWv9UQmzSkSLvyW2XZ0aDdVFHq
 f39i9uYaSCVUpK7ns69R0dK+r/WKK91jzYKv/toHirAewtYERmXd/0KXX/UdMrOSvJQU
 X1Lg==
X-Gm-Message-State: AOJu0YxinpaWxIsmEnYDikOgw9QJA7f6aK+kTV4e5Q/W8ZdLKRr8a1vr
 U1+VuL+qqp95cXJIg9qa1xiU3A==
X-Google-Smtp-Source: AGHT+IGSfSez0xGf5YVi5swvyKdQTAQEmur2yuUY9HbMZG7GsE61cUNtESidkcQsXLGPIxnKVfT7+w==
X-Received: by 2002:a17:902:ea10:b0:1ce:6693:d6f9 with SMTP id
 s16-20020a170902ea1000b001ce6693d6f9mr5114070plg.3.1700724613653; 
 Wed, 22 Nov 2023 23:30:13 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 u11-20020a170902bf4b00b001c61073b076sm631518pls.144.2023.11.22.23.30.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Nov 2023 23:30:13 -0800 (PST)
Message-ID: <beb72507-22d4-4d76-9286-05a96710e8f0@daynix.com>
Date: Thu, 23 Nov 2023 16:30:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] gdbstub and TCG plugin improvements
To: Alistair Francis <alistair23@gmail.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
References: <20231030054834.39145-1-akihiko.odaki@daynix.com>
 <CAKmqyKNzYdDVQgQn-8eB_-CZtw=oobsCmOe4SQa3H_LQpczyxQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAKmqyKNzYdDVQgQn-8eB_-CZtw=oobsCmOe4SQa3H_LQpczyxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On 2023/11/23 12:10, Alistair Francis wrote:
> On Mon, Oct 30, 2023 at 3:49 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> Based-on: <20231029145033.592566-1-alex.bennee@linaro.org>
>> ("[PATCH v2 00/19] Maintainer updates for testing, gdb, semihosting and
>> plugins (pre-PR)")
>>
>> This series extracts fixes and refactorings that can be applied
>> independently from "[PATCH v9 00/23] plugins: Allow to read registers".
>>
>> The patch "target/riscv: Move MISA limits to class" was replaced with
>> patch "target/riscv: Move misa_mxl_max to class" since I found instances
>> may have different misa_ext_mask.
> 
> What instances? Couldn't MXL have the same differences? >
> Alistair

Instances of subclasses of riscv-cpu. While misa_ext_mask are 
configurable for each instances with properties, the misa_mxl_max value 
is hardcoded for each classes and will not have such differences.

Regards,
Akihiko Odaki

