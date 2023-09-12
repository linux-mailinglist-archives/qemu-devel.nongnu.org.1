Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF5E79DC48
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 00:54:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgCGG-0003jg-Ie; Tue, 12 Sep 2023 18:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgCGE-0003jY-Kq
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:53:34 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgCGC-0005ho-As
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:53:34 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-573ccec985dso4809996a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 15:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694559211; x=1695164011;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A57yz7xcMBeQsshuuqtk0BsI8T/zjYKVefsAXKS5vf0=;
 b=GC+KqL/L+QcvUmNvLunztkKp2SGBmbsRiJV1QlNdQ1Cx6RvAyhDQJBDem4IuLtsWr0
 0AXxLK/1GFCjUXIxSuhMUDEOEUmKyslpwTHAk9TtdhqK5YaA1xs3Em0MnYGrNNs0K5EF
 um3WT9Os/W1q3dR2aMApiyHdxM8wYdlBRtAKMzw0EW3UKlJp1S1d66EQ5QQNOqD8xl8S
 XhmEs+VliavWgKABF2PsCdyr7SkpiLEPtZapB51ternq81JPIxE12V4AJ1dG7t1eOfaA
 TaqBNbdUFdhQdz7a3OBOzThM0eluOZOpIqOsdcbM5BHkAyIKW1Xr9YGPzdPzWHxJZt3a
 LTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694559211; x=1695164011;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A57yz7xcMBeQsshuuqtk0BsI8T/zjYKVefsAXKS5vf0=;
 b=iap19ifsrMZcVg+iu19mp0xAIAzchk+AelGPATzIDsrctF+8OFI50rcDaANW3X+KJq
 8qBS5w/Le9djtcEpufSwxbQFtYzhIw6cLEeRZS4IaxtxfAYq9lVS5BU4FcTRrnQ2ds9M
 5bF5LolXWqn6Gaj3SXVvU414yFIVzd1xlETeN0pKcmbzLWXNhTm4jE3OtmQQ8d1Aw3Nq
 VxRua/uXZpHK9TGiTOzo66IIKHE6WGk6MZH1nqCJ6zYx3R8gqr4ZAy2b1NrYK3Fvpvdz
 gix7UMmlJcwPitFWlmH+l9ZW76xWlX+zdH1Q715580cXjRbf1hygd0TgclRZLv76bv5h
 v5Bw==
X-Gm-Message-State: AOJu0Yy+xpUaOqfjBakc2LIbhAtO3vRU6obknAVjqwW+QaZGc4UnTWSS
 WgNxWc6G6WUNcuzXuH91lCPPEA==
X-Google-Smtp-Source: AGHT+IFEjvkXkKmPGRFt2QtkoRLpX7Q+P/PosRlRivIGS4lYuBbsBAPvhPHlWqK2HoZqHk/S1bs6TA==
X-Received: by 2002:a17:90b:4a08:b0:273:e24e:36b9 with SMTP id
 kk8-20020a17090b4a0800b00273e24e36b9mr687577pjb.8.1694559210797; 
 Tue, 12 Sep 2023 15:53:30 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 19-20020a17090a031300b00262d9b4b527sm121084pje.52.2023.09.12.15.53.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 15:53:30 -0700 (PDT)
Message-ID: <0f21607d-8b01-4378-8934-92be1066fdf7@daynix.com>
Date: Wed, 13 Sep 2023 07:53:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/18] cpu: Call plugin hooks only when ready
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20230912071206.30751-1-akihiko.odaki@daynix.com>
 <20230912071206.30751-15-akihiko.odaki@daynix.com>
 <1f64f982-95fc-786d-1217-856a62335eed@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <1f64f982-95fc-786d-1217-856a62335eed@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/09/12 17:46, Philippe Mathieu-Daudé wrote:
> Hi Akihiko,
> 
> On 12/9/23 09:12, Akihiko Odaki wrote:
>> The initialization and exit hooks will not affect the state of vCPU,
> 
> What about:
> 
>   qemu_plugin_vcpu_init_hook()
>     -> plugin_cpu_update__locked()
>        -> plugin_cpu_update__async()
>           -> bitmap_copy(cpu->plugin_mask, ...)
>              tcg_flush_jmp_cache(cpu)
>              -> qatomic_set(&cpu->tb_jmp_cache->array[i].tb, ...)
> 
> ?

Hi,

bitmap_copy(cpu->plugin_mask, ...) is contained in the plugin 
infrastructure and shouldn't matter.

The TCG is not started filling caches so tcg_flush_jmp_cache() is 
effectively nop though that is not clearly stated.

By the way, I found plugin_cpu_update__locked() will not synchronously 
call plugin_cpu_update__async() after this change because cpu->created 
will be always true for the system emulation. For user space emulation, 
it has already been broken and it *always* synchronously calls the 
function since cpu->created is not set.

I wrote a change to replace cpu->created with DEVICE(cpu)->realized and 
added to the base patch series ("[PATCH v3 03/12] plugins: Check if vCPU 
is realized" in "[PATCH v3 00/12] gdbstub and TCG plugin improvements").

Regards,
Akihiko Odaki

