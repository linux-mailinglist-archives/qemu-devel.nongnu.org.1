Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BB89BF46D
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Nov 2024 18:41:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8k1M-0002Sd-5f; Wed, 06 Nov 2024 12:40:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t8k1E-0002SI-Gj
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:40:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t8k1C-0005ZU-Ny
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:40:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730914832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=P2UyyHm/Gf8fwA53vejNDe/AXdMPWuBO33mVDR7EgzY=;
 b=LeHENthSrpoJ5fuzZUZKX6mJJHApl1h9RqqkV3ZHfPcti9tk40eorMiS+gMf2d8fhgxjfM
 SdidIcs5anclo+Dy4Jf5P88DGMBrz6Gbzk/hnnk1YWfTqU1c8tnYxSJCW/0RsGp+vba0UX
 mIMYZshyyVLbnol1fGATaMFDUTPsnWU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-GWN4ikRuOqe_mpKlmMmdaQ-1; Wed, 06 Nov 2024 12:40:31 -0500
X-MC-Unique: GWN4ikRuOqe_mpKlmMmdaQ-1
X-Mimecast-MFC-AGG-ID: GWN4ikRuOqe_mpKlmMmdaQ
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4314f1e0f2bso426825e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:40:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730914830; x=1731519630;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P2UyyHm/Gf8fwA53vejNDe/AXdMPWuBO33mVDR7EgzY=;
 b=Qh69dCzBKQ0fU5T8A7jD+yp6S4OeoQZIA9wm4xG1mu9zH1lFFy7RTwqWOUkuROyIsy
 Wn3FwdDxp/A9nSypq8AnTrJNfV9XNrULg354BvJDlqr8eTcZJopBEqQvVpcGpe86w/OX
 VrZAPAAscaJ0yi6o767J84S0JGpzfjpJ/i7UUwwAkPZuIEefevUsxzOWMtaPHS/S9kpT
 s1Ch4wQBSoiOfoaLNZHFcJMYYYFreXN2982pgIiA1IwrObXYMEXwBiRoqoifZCQYFHoU
 BIX2jB68Hxja3keg6c+oZCRY1M/wgkCwaMl5uQDRZVhg81oqn10WzH9B6bkEw5/dl8nP
 NkEg==
X-Gm-Message-State: AOJu0YzZ9g7dXR2KhPMZqZgIVK+V15SA2GXflS8rkrxAYwK48YpeQWzz
 6MHUFlW8Pv8E0ggGgcRbxnLTOcq/vgv2T7YIv4+k6AMrH0xUf3ijolAavRLs4fdG+aF6aHZhsUO
 aFCagdvtqofpnQ/xxhYsxrEiOeoHbc2min57TEj2YjbNePfsSuTHv
X-Received: by 2002:a05:600c:35cf:b0:431:3b53:105e with SMTP id
 5b1f17b1804b1-43283244e02mr185307455e9.9.1730914830350; 
 Wed, 06 Nov 2024 09:40:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTcksxe1+KTqJHE+HzwHho3ZxG6gMNLEtH9XzUbLoN/ZSKYEOgSeXKnQwLKFHB2mcguFvwYA==
X-Received: by 2002:a05:600c:35cf:b0:431:3b53:105e with SMTP id
 5b1f17b1804b1-43283244e02mr185307235e9.9.1730914830009; 
 Wed, 06 Nov 2024 09:40:30 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-55.web.vodafone.de. [109.42.51.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10d414csm19597355f8f.26.2024.11.06.09.40.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 09:40:29 -0800 (PST)
Message-ID: <f1e324ed-e086-4f8b-8027-be2323383665@redhat.com>
Date: Wed, 6 Nov 2024 18:40:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Bump timeouts of functional tests
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20241106170946.990731-1-thuth@redhat.com>
 <c233a6b5-bfea-4d5e-9b1f-5bc3a467e17d@linaro.org>
 <CAFEAcA-MVg2EU2cKJz+drZp3=GBCPJXqbP7iNimg8fs0NYfhOQ@mail.gmail.com>
 <235c9cc1-aba0-4612-ba19-32885cb4b138@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <235c9cc1-aba0-4612-ba19-32885cb4b138@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 06/11/2024 18.30, Pierrick Bouvier wrote:
> On 11/6/24 09:26, Peter Maydell wrote:
>> On Wed, 6 Nov 2024 at 17:21, Pierrick Bouvier
>> <pierrick.bouvier@linaro.org> wrote:
>>> I noticed by --enable-debug in configure is a combination of enabling
>>> checks (enable-debug-tcg + graph + mutex), and deactivating optimizations.
>>>
>>> Would it be worth keeping the optimizations and runtime checks instead?
>>> This way, there would be no more "timeout" issue.
>>>
>>> I'm not sure which added value we get from O0, except for debugging
>>> locally QEMU.
>>
>> "Debugging locally QEMU" is exactly what --enable-debug is intended for...
>>
> 
> Yes...
> but it seems like we take it for "enable debug checks" in CI as well and it 
> impacts runtime, because optimizations are deactivated. I think I've not 
> been the only one confused about this.
> 
> So my point is that we should maybe differentiate the two use cases at 
> configure level.
> 
> --enable-debug and
> --enable-runtime-checks (or something more explicit)

Would that really help? I guess people still want to be able to run "make 
check" when they compiled with --enable-debug, so we still need to be 
prepared to run the checks with a slow QEMU.

But I wonder whether we could maybe use -Og instead of -O0 nowadays?

  Thomas


