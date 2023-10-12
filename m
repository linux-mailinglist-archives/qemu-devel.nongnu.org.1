Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 979767C6F75
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 15:42:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqvvK-0006Ca-3Q; Thu, 12 Oct 2023 09:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqvv9-0006B8-2d
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:40:11 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqvv4-0002xX-Lq
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:40:09 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-533d31a8523so1765409a12.1
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 06:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697118005; x=1697722805; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uYKLXRBDpjhnnA5ve4A3/KEPKk2ji4Xv7HCEFBJIRF8=;
 b=tJ6gcb6cr/ZXMtmIAFmgmKlPzv4HvWuZtABomB0kkTVf/brUmQSaqcXqi7er4wWKP7
 h/6pqw9JhJUxwx+pAVNJM5XugkBd2yy4lJYmmrXMw5AUnzN/cYVOHgPhUbA0ENFS+dH4
 ZTLJxkvRLQpfd8WqkBd7EjZpu4Rq2bV8WBZrvToKCn3/4nWrYuanAtN23GRxDfSp6SzD
 K8gwqiCMGSYH4W3HO8Ad9ji8dL4ybEYuSOKREZAVyc2lJmxWRRZsCaTe5GHhcnX9gZPc
 gw8H6l9cBPm0gYjHfGJo5AqL9N1Pj/HIVZG7BVbzy6OjLl0xj/7DXH3vI+JrmxttBj1I
 12yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697118005; x=1697722805;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uYKLXRBDpjhnnA5ve4A3/KEPKk2ji4Xv7HCEFBJIRF8=;
 b=A+H/qdeD7bs5U9niR3xcHMTOLStHhgdtvC4cNIJIbK86EafO3JdqiZG0yS1CblrDXC
 6Ok79+e29tLuO/Jo+ysvES3nULS/hMHgfGw523dZ5199v96AFkMYcjQXh7WM3T66Rcnb
 HBkGtIPTAIR5ydTUSbHHlG7EU75J8I6lWcDm8ORYSMvYYjzWxKnog/ZF92m1vTx/CjMr
 epLh9pqSCBeNI/MITvUa6KubQHG3gQmFSp1y0FM/nrkxtLEc58tRCCn2YEHsF8/QTXJq
 k7oWo7owIIfQK9HKDWvLPDQqT7Gj+F0af3QwQtnVDRq7qtMmlHyFJp31X1B4XMgKLmHj
 Kjsg==
X-Gm-Message-State: AOJu0YxJFOxhjcRbtiJWS/of5ctG+cOxHKxY0tJU1nbkHT4BETnH6Bo7
 qO+kKrEWpTv6cVsAt0jKuoPywg==
X-Google-Smtp-Source: AGHT+IEG2/mmPvu6Dk8Uj2JxxGJV/oAs2NAZI7DoFsmE1StO0al7tlMTTqywfa7XlsR5j8JdEqR98Q==
X-Received: by 2002:a05:6402:60e:b0:523:33eb:1103 with SMTP id
 n14-20020a056402060e00b0052333eb1103mr21984333edv.14.1697118005004; 
 Thu, 12 Oct 2023 06:40:05 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-232.abo.bbox.fr.
 [176.131.211.232]) by smtp.gmail.com with ESMTPSA id
 ee48-20020a056402293000b0053120f313cbsm3392652edb.39.2023.10.12.06.40.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 06:40:04 -0700 (PDT)
Message-ID: <acb33f5e-4234-fc18-63a6-b74294857468@linaro.org>
Date: Thu, 12 Oct 2023 15:40:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v11 09/18] gdbstub: Change gdb_get_reg_cb and
 gdb_set_reg_cb
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Brian Cain <bcain@quicinc.com>,
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>
References: <20231012130616.7941-1-akihiko.odaki@daynix.com>
 <20231012130616.7941-10-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231012130616.7941-10-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/10/23 15:06, Akihiko Odaki wrote:
> Align the parameters of gdb_get_reg_cb and gdb_set_reg_cb with the
> gdb_read_register and gdb_write_register members of CPUClass to allow
> to unify the logic to access registers of the core and coprocessors
> in the future.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   include/exec/gdbstub.h      |  4 +-
>   target/arm/internals.h      | 12 +++---
>   target/hexagon/internal.h   |  4 +-
>   target/microblaze/cpu.h     |  4 +-
>   gdbstub/gdbstub.c           |  6 +--
>   target/arm/gdbstub.c        | 51 ++++++++++++++++--------
>   target/arm/gdbstub64.c      | 27 +++++++++----
>   target/hexagon/gdbstub.c    | 10 ++++-
>   target/loongarch/gdbstub.c  | 11 ++++--
>   target/m68k/helper.c        | 20 ++++++++--
>   target/microblaze/gdbstub.c |  9 ++++-
>   target/ppc/gdbstub.c        | 46 +++++++++++++++++-----
>   target/riscv/gdbstub.c      | 46 ++++++++++++++++------
>   target/s390x/gdbstub.c      | 77 ++++++++++++++++++++++++++++---------
>   14 files changed, 236 insertions(+), 91 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


