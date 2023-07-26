Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D027631D9
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 11:25:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOal0-0003fP-RS; Wed, 26 Jul 2023 05:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qOakz-0003ey-91
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 05:24:33 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qOakx-0001A1-PA
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 05:24:33 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fd190065a8so66115455e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 02:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690363470; x=1690968270;
 h=content-transfer-encoding:in-reply-to:organization:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=U0QSqnqRTNuBOYNVQxtRdgDxm4yeKmElCPV7/jRjZE0=;
 b=AnWeHlhW/ZcqmWbjgHxHt88IXTGKtoPFsoJ9GVO0owQJnELpNo/XM8dAbwUIZZjacy
 qpXG1LXpEG2XJap0I2woWVxNbuFyMC3uCAmoWaMB7+GT5EN6XM2qWvXJZlNNS0VWotHG
 ircv6MC3j2r7ZfbIEA4gSH1s/V2ELGaC18D4EwJemdYg13lDZLVQEdSTSFZDlOMBokEw
 oMA9jzqH+JrnuuYVxSTNexbV4K/NoYAEHh2vGR8QUD4ZEYDox+II7f8tp3x76R4iXAny
 cI3bpEqKno6AXzU4NuaNSd27zm6h8ZIxPGbA09ADFmEDkl7UbyPKpnx+RQyOQ7GTBKjA
 kFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690363470; x=1690968270;
 h=content-transfer-encoding:in-reply-to:organization:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U0QSqnqRTNuBOYNVQxtRdgDxm4yeKmElCPV7/jRjZE0=;
 b=j6LPi8tDkgZk52nRR13KKVQZBgARnrKBVG/0j3b5Kt6sEexE4RbKSn0FS2tXNtaVhI
 WquZ5ZajR3ztVwu/M8JUS2FDvoOhAr09KHEzA5dHT3II7dG02QUcqNxxK2A3+ZBRndfI
 xiRo2S76aUhnXACgOXCHFup6FHeDomz6KtUu4O3jWCBh1ZXCxf6Xaw2xV1dlS2fHyLNp
 Gijwu3G0DnYWqUcjTE+SFJFWHcaLWFkk1p5hpDGG3U4odV1a6xY1IEMMRNCmf5bg8+q+
 9geQpp0Vt6dvOzT70zQDJRd7XDrpe8m6hfvc23FIAW3pEWn30qgQUn0qNK53S8HPBJhB
 vzzw==
X-Gm-Message-State: ABy/qLYjlyKN8NZad/m0s9U55aUV95qsO5EUhRBFMPZdXLo0WiRdoMAX
 c4kqtDtbgkg5GpDzdNfmzQo=
X-Google-Smtp-Source: APBJJlH3CDTm+2+O0hdbcUiY0ekOrAjFeEkN1mP3dH8jxKKCuEMjtYC/sFHwEZGHqYu1AoxlEJaIXA==
X-Received: by 2002:a5d:470d:0:b0:317:6992:855c with SMTP id
 y13-20020a5d470d000000b003176992855cmr785856wrq.19.1690363469830; 
 Wed, 26 Jul 2023 02:24:29 -0700 (PDT)
Received: from [192.168.24.200] (54-240-197-226.amazon.com. [54.240.197.226])
 by smtp.gmail.com with ESMTPSA id
 m1-20020adffe41000000b003113ed02080sm19009432wrs.95.2023.07.26.02.24.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jul 2023 02:24:29 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <8ff47c7e-81eb-2795-6e61-cb93ea8f1abf@xen.org>
Date: Wed, 26 Jul 2023 10:24:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: i386/xen: prevent guest from binding loopback event channel to
 itself
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>
References: <c976d480399a44e09b1da3ad201e3021def223f7.camel@infradead.org>
 <e2df69f7-d7d1-a2c4-6bf0-e2142f64a53b@xen.org>
 <93bcbaee0b800b4a951a76340f3988088dfb1689.camel@infradead.org>
Organization: Xen Project
In-Reply-To: <93bcbaee0b800b4a951a76340f3988088dfb1689.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 26/07/2023 10:07, David Woodhouse wrote:
> On Wed, 2023-07-26 at 09:44 +0100, Paul Durrant wrote:
>> On 25/07/2023 11:05, David Woodhouse wrote:
>>> From: David Woodhouse <dwmw@amazon.co.uk>
>>>
>>> Fuzzing showed that a guest could bind an interdomain port to itself, by
>>> guessing the next port to be allocated and putting that as the 'remote'
>>> port number. By chance, that works because the newly-allocated port has
>>> type EVTCHNSTAT_unbound. It shouldn't.
>>>
>>> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
>>> ---
>>>    hw/i386/kvm/xen_evtchn.c | 11 +++++++++--
>>>    1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>
>> Reviewed-by: Paul Durrant <paul@xen.org>
>>
> 
> Thanks. I'll change the title prefix to 'hw/xen' since it's in hw/ not
> target/i386.

Yes, makes sense.

> Please can I have also have a review for
> https://lore.kernel.org/qemu-devel/20076888f6bdf06a65aafc5cf954260965d45b97.camel@infradead.org/
>

Sorry I missed that. Done.

Cheers,

   Paul

