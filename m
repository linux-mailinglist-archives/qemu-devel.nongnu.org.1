Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 603B58141D6
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 07:35:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE1m1-0005QN-6l; Fri, 15 Dec 2023 01:34:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rE1lz-0005Q2-0R
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 01:34:11 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rE1lw-0004QC-TC
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 01:34:10 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5be30d543c4so177966a12.2
 for <qemu-devel@nongnu.org>; Thu, 14 Dec 2023 22:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702622047; x=1703226847;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XUmCbduFkJ09eKtUaIDq7WEVpin+UggiNmfML2rNR9Y=;
 b=Bx5GniCr2I5CodW2/nZU/oTOQvMmJ/R2mk7ZXZY8jP6GUWd9BQ9Qcz8vkSwJU2XIWe
 RAkOy8pPICPIML7IfEi1lNTHf43tpn+b5IF3aaSLx1cgeBOZd/0KkdKRfi4Ob6UFc5Sq
 UK4hGZBjFxEJNmS2EXlLXjyBOw7TilP8s728KQRPLb5lgyiaPs7Y+JrEum2GtppRrZLA
 h+OYOahppewqqr6fENQxdQms/vK4vCYKLOlhtANm4f+3imdasgIPH9bgLUCQx+i2fI6Y
 RME/rbuEPFHhPIFEnJfdA81SBVhmsMyOjvrLns/SxdriS3f8yYTf1rwkNHT/DiN/g683
 g3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702622047; x=1703226847;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XUmCbduFkJ09eKtUaIDq7WEVpin+UggiNmfML2rNR9Y=;
 b=FzCYOIC5NVMjd7e22q89Lfnbj5lxVUWgDN1aQ69fp3TzCwwxyW0uS1r5BskYY4hRnL
 xqMSJ5THnq5P+Z5QUCSiOIKmiN+YJQjc+OwcnESPLUksg0QbBk4/sTWogH7xar7aSdNj
 EAEplbx3mxNUQMrknR0tHJtTLE7T6QRBOfpDXb43gufQQSQnnwLdwGNl1NsKS5bFlrYb
 vb59i8W/eBrn05XM3D6UtioebejnwUTVV4jVt1QFTUnH32m84foormlTPdMr+2z9sWr5
 B2/8rY2fQlQnDkwF8GHpHs4dbRLeGs7wsdfTvvBHaArdeQ2AWN9CkbsC7gsnC+8jR556
 U9fw==
X-Gm-Message-State: AOJu0Yxi6kahabechLMg/DtGb1VWEqZ8gIA705W6mEwogPotGdbRlOqS
 djmknlH4b3lUFvDV4+Zla7vQPw==
X-Google-Smtp-Source: AGHT+IFqZHFIAWBf8fXxPdRc0olAtE1sW2+cox7ONK3aXxcih83876zjEO9qcr4aHzBS0/g+L3CbKw==
X-Received: by 2002:a17:902:b197:b0:1d0:c906:f5e2 with SMTP id
 s23-20020a170902b19700b001d0c906f5e2mr6429380plr.74.1702622046880; 
 Thu, 14 Dec 2023 22:34:06 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 k23-20020a170902ba9700b001d0b6caddbasm13423222pls.291.2023.12.14.22.34.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Dec 2023 22:34:06 -0800 (PST)
Message-ID: <946c24af-042c-43e5-8092-4488a32e549d@daynix.com>
Date: Fri, 15 Dec 2023 15:34:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] hw/riscv: Use misa_mxl instead of misa_mxl_max
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
References: <20231030054834.39145-1-akihiko.odaki@daynix.com>
 <20231030054834.39145-2-akihiko.odaki@daynix.com>
 <CAKmqyKMo41GMJ0vVN2_CsfOVrfsz8H9AtxTe6-JbtX+Pi6B3DA@mail.gmail.com>
 <fcf3a810-7492-4f60-9126-63713d6a30bd@daynix.com>
 <CAKmqyKOvwZ71+pGz-HSvE29U9a2dbYVPLR0Li2ak5ji+_Ez4-A@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAKmqyKOvwZ71+pGz-HSvE29U9a2dbYVPLR0Li2ak5ji+_Ez4-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::530;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
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

On 2023/12/15 14:34, Alistair Francis wrote:
> On Thu, Nov 23, 2023 at 5:24 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2023/11/23 12:04, Alistair Francis wrote:
>>> On Mon, Oct 30, 2023 at 3:50 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> The effective MXL value matters when booting.
>>>
>>> This doesn't sound right. Surely the max is what matters here
>>>
>>> Also, this was specifically changed to misa_mxl_max in db23e5d981a
>>> "target/riscv: Replace riscv_cpu_is_32bit with riscv_cpu_mxl".
>>>
>>> This needs a much better description of why this change should be made
>>   >
>>   > Alistair
>>
>> The kernel will be executed with the current MXL rather than the initial
>> MXL value so the current MXL should be used here.
>>
>> For example, if you are going to emulate a system that has a RV64 CPU
>> and a firmware that sets the MXL to RV32, then mxl_max should be
>> MXL_RV64 and mxl should be MXL_RV32, and the kernel should be assumed as
>> a RV32 binary. Loading a 64-bit kernel will not work in such a case.
> 
> But this is called before the firmware runs, so it won't be changed by firmware.

It's more like QEMU emulates the firmware. It's the responsibility of 
the firmware to load kernels for the real hardware, but QEMU does it 
instead.

The firmware can change the MXL to load a 32-bit kernel on a 64-bit 
system so if QEMU happens to emulate such a behavior, mxl should be used 
when loading the kernel instead of mxl_max. QEMU currently does not 
implement such a feature, but in such a case mxl == mxl_max so it does 
not hurt to use mxl.

> 
> Maybe it's worth putting what this fixes in the commit message?

What about:

A later commit requires one extra step to retrieve mxl_max. As mxl is 
semantically more correct and does not need such a extra step, refer to 
mxl instead.

Currently mxl always equals to mxl_max so it does not matter which of 
mxl or mxl_max to refer to. However, it is possible to have different 
values for mxl and mxl_max if QEMU gains a new feature to load a RV32 
kernel on a RV64 system, for example. For such a behavior, the real 
system will need the firmware to switch MXL to RV32, and if QEMU 
implements the same behavior, mxl will represent the MXL that 
corresponds to the kernel being loaded. Therefore, it is more 
appropriate to refer to mxl instead of mxl_max when mxl != mxl_max.

Regards,
Akihiko Odaki

