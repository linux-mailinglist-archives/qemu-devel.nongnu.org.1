Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 887BC7EA0F8
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 17:10:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2ZVS-0001kq-4P; Mon, 13 Nov 2023 11:09:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2ZVQ-0001k7-2m
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 11:09:44 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2ZVO-0003LN-DU
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 11:09:43 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9d242846194so681641066b.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 08:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699891781; x=1700496581; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MT2jqnM1EXDZd7Eo9GsBNo8vayQdwjXlJYvjk3d8/BQ=;
 b=D2k7O3l8xKnz4x6wHlGOSQfJsyHaIm93c9sprzxhHXam42me7jCzDE90qRNp2778Gz
 qNPDuqJwWF+2Dj04lnQUtKJuLuhukvMSpiwFn35aE9PACZeRTAK8QW81vG3mG8F2cE+f
 Txq2dZTgh1PnXs0jeuUDpC4ROhEblGPg0TQqTdIBTB6V8MaXP8ZXaSuGvMwIU+QDTjNC
 2ckAlUu5/aMKqXEITHpzWpuxTTEZvW25W/djih2QOQGxcJ5iiaeLvPhIsj5c0fTsfW1J
 LKfQxNx/358OOLNXBzvG2531BZPak8Tbj6Z/3ZWyuI0Zc2qRIBzgmMBgVl0CNns664RI
 mM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699891781; x=1700496581;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MT2jqnM1EXDZd7Eo9GsBNo8vayQdwjXlJYvjk3d8/BQ=;
 b=v1nxys14P3E5IejMZCPPuCdNbUvCfS0vX0acW+/xeXQeEGCRQBiJvwmuuHoyhB8x3I
 Qm6fUlrA8+nOmnLycLu59mGV4PNuY+B4kApj66GW7D9dO0SLeE7ib08Rtq84TJ8aLh8v
 iMHZWkLH4scrrNPNmHm8RsZgOrLdRx5SlbwVu+Q5ksOr5+ploxaXD/EzvZPiCJQdoDZf
 dcRDDD6c6q9I1Sx0EKhCiKc/sMyzBrRG4T495eWCaWE4CI7U38uaovTcYf+gF1gLCXHX
 I4MqGqxAET7M+axK9veQlTCKoHJwK0AmyqaR8AnRqWUleaOt++KrxhFusk4fyZf1Wu97
 mlJA==
X-Gm-Message-State: AOJu0YzFz8jl/MUSmp8OZZfVipYly1hDd+iubHjOAkKBs2C0IaPeb5Pj
 W1aOMUvl0bERc0wZQDfuBupxeA==
X-Google-Smtp-Source: AGHT+IGeRhJFxDoIfveJ9ETd2OdQ3oHGQ3FlHAF/NrjNVpCIp+vrcNE4rMVRNzJtDcSpxiFGnRsC1Q==
X-Received: by 2002:a17:907:86a3:b0:9be:b41d:4f7e with SMTP id
 qa35-20020a17090786a300b009beb41d4f7emr5851496ejc.17.1699891780129; 
 Mon, 13 Nov 2023 08:09:40 -0800 (PST)
Received: from [192.168.69.100] ([176.164.221.204])
 by smtp.gmail.com with ESMTPSA id
 qk16-20020a170906d9d000b0099297782aa9sm4153050ejb.49.2023.11.13.08.09.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 08:09:39 -0800 (PST)
Message-ID: <7a66c289-19e1-4690-8c6e-31a9f6344b6f@linaro.org>
Date: Mon, 13 Nov 2023 17:09:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 04/10] hw/xen: Factor xen_arch_align_ioreq_data()
 out of handle_ioreq()
Content-Language: en-US
To: "Woodhouse, David" <dwmw@amazon.co.uk>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anthony Perard <anthony.perard@citrix.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Paul Durrant <paul@xen.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <f791a822-f6f5-44fa-904b-f67d3f193763@email.android.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f791a822-f6f5-44fa-904b-f67d3f193763@email.android.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 13/11/23 16:58, Woodhouse, David wrote:
> On 13 Nov 2023 10:22, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
>     Per commit f17068c1c7 ("xen-hvm: reorganize xen-hvm and move common
>     function to xen-hvm-common"), handle_ioreq() is expected to be
>     target-agnostic. However it uses 'target_ulong', which is a target
>     specific definition.
> 
>     In order to compile this file once for all targets, factor the
>     target-specific code out of handle_ioreq() as a per-target handler
>     called xen_arch_align_ioreq_data().
> 
>     Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>     ---
>     Should we have a 'unsigned qemu_target_long_bits();' helper
>     such qemu_target_page_foo() API and target_words_bigendian()?
> 
> 
> It can be more fun than that though. What about 
> qemu_target_alignof_uint64() for example, which differs between i386 and 
> x86_64 and causes even structs with *explicitly* sized fields to differ 
> because of padding.
> 
> I'd *love* to see this series as a step towards my fantasy of being able 
> to support Xen under TCG. After all, without that what's the point in 
> being target-agnostic?

Another win is we are building all these files once instead of one for
each i386/x86_64/aarch64 targets, so we save CI time and Amazon trees.

> However, I am mildly concerned that some of these files are accidentally 
> using the host ELF ABI, perhaps with explicit management of 32-bit 
> compatibility, and the target-agnosticity is purely an illusion?
> 
> See the "protocol" handling and the three ABIs for the ring in 
> xen-block, for example.

If so I'd expect build failures or violent runtime assertions.

Reviewing quickly hw/block/dataplane/xen-block.c, this code doesn't
seem target specific at all IMHO. Otherwise I'd really expect it to
fail compiling. But I don't know much about Xen, so I'll let block &
xen experts to have a look.

> Can we be explicit about what's expected to work here and what's not in 
> scope?

What do you mean? Everything is expected to work like without this
series applied :)

Regards,

Phil.

