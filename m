Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A9A7F592E
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 08:25:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r644M-00054D-3g; Thu, 23 Nov 2023 02:24:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r644J-00052s-ID
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 02:24:11 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r644H-0002Wc-Un
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 02:24:11 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6cbe5b6ec62so308549b3a.1
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 23:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700724248; x=1701329048;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WGlTPW3xVQBrGzxZ3PIJH6SHW9JKGrytJBUktVOvRkE=;
 b=V4KN19/PFFiWnqPndG5qdC0j0lGAaIEcigVrq8bY+OVbvVR8TDN79fYxzqKZsND7UL
 O2DjxeKqk0SOIa7Mx4nYIpw2SAe7+8DTlIX9Ux9gs4MKxqKBmyBb6OVbZOoWYaqVCkXm
 ZkhpGtoC3hhLJhBzUc9CLXpCYxy2ngwv5EW9lKP21BeKHFvsPbedBFuZy2/i4giRrF8/
 TojkN5ivGQQ5KY4o/xvGqb30Hh3htxiypmTEcUN8o82WRkEiT0YK08JpA3stUC3lDm14
 KRy3DoLOBBve3jP1lK7BSWsbtt+BzmqmwNen27DF8coPcpkFE/xcMqrSvUQ7XDKlAoMa
 9jMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700724248; x=1701329048;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WGlTPW3xVQBrGzxZ3PIJH6SHW9JKGrytJBUktVOvRkE=;
 b=rI+VBPlrEnMa+o8ux3PVp+iayrRWuNMH3K4B+2w+EfbC3EkIlS1qc2awPRcFLUpZ54
 1mHLlq3tRvR64aWSiM+IUDmdGvKj582o4hp1DggzpLvdKQOzrPih8nwvPNGvaOVqClRc
 rw8nBCcxzCQmcTqhO/jc1bvOKuASiDJdha0k5IRbkzz2UPxNg9ouyMJ053+qht+OotU3
 lfeSCMuYNi2G/+Si/8W07PRKAMuzChCe0fTxzHQhMU/R1DxVrYKQGU8hrv5UF+tyKTVt
 yp0PikszxODg/4wPFRERhDJYGPFQHfAtABtfbu5m9ryAEWM6dfXNUaZXpfH3ePaXuLgT
 wa7Q==
X-Gm-Message-State: AOJu0YytptNBP4KIcl57UDJAMIdKXSeSCxiNe3QRhVoHLz2NMlAMTK5/
 F0m2Z+Y36DWnoHBtwJYRU/0CtQ==
X-Google-Smtp-Source: AGHT+IFAmexz7i3YdJjx2Np3NOEEA2/6fr/dRuuvOryid+zNTqGv1u4cxFxvbsNx23dSVVKuzW45KQ==
X-Received: by 2002:a05:6a00:1d8d:b0:6cb:88c2:83b3 with SMTP id
 z13-20020a056a001d8d00b006cb88c283b3mr5035006pfw.0.1700724248102; 
 Wed, 22 Nov 2023 23:24:08 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 it27-20020a056a00459b00b006c7ca969858sm602308pfb.82.2023.11.22.23.24.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Nov 2023 23:24:07 -0800 (PST)
Message-ID: <fcf3a810-7492-4f60-9126-63713d6a30bd@daynix.com>
Date: Thu, 23 Nov 2023 16:24:04 +0900
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
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAKmqyKMo41GMJ0vVN2_CsfOVrfsz8H9AtxTe6-JbtX+Pi6B3DA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::435;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/11/23 12:04, Alistair Francis wrote:
> On Mon, Oct 30, 2023 at 3:50 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> The effective MXL value matters when booting.
> 
> This doesn't sound right. Surely the max is what matters here
> 
> Also, this was specifically changed to misa_mxl_max in db23e5d981a
> "target/riscv: Replace riscv_cpu_is_32bit with riscv_cpu_mxl".
> 
> This needs a much better description of why this change should be made
 >
 > Alistair

The kernel will be executed with the current MXL rather than the initial 
MXL value so the current MXL should be used here.

For example, if you are going to emulate a system that has a RV64 CPU 
and a firmware that sets the MXL to RV32, then mxl_max should be 
MXL_RV64 and mxl should be MXL_RV32, and the kernel should be assumed as 
a RV32 binary. Loading a 64-bit kernel will not work in such a case.

You can find a similar example in x86_64: x86_64 systems typically 
starts in 16-bit mode, and the firmware switches to 64-bit mode. When 
emulating those systems, QEMU switches to 64-bit mode and loads a 64-bit 
kernel.

Regards,
Akihiko Odaki

