Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 490407D5837
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:26:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKDo-0002R5-Me; Tue, 24 Oct 2023 12:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvKDf-0001uA-36; Tue, 24 Oct 2023 12:25:28 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvKDd-0001Ge-Ad; Tue, 24 Oct 2023 12:25:26 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40853c639abso33779135e9.0; 
 Tue, 24 Oct 2023 09:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698164721; x=1698769521; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UQsq2LWk3bVW9FNqtR4uLNXJWBJH5YdmWftR29dvZwY=;
 b=EdWoMWG+PN87I5vZa6XaApEswRqXEWFuFbP0xZm/kko6LLJHPcC8JjCuuM8r9Ghh0s
 c7IO7RZYBRGADt4w8G++PTFH/VFSZaszoJhTDjzmKbYUpF2USWAMkObAbZHPp9ZSdWYr
 S34cojsALtTgMopuy/tkh3oCoeEVRon7pUr7GogsoYLprpUx/9JBB2YjwtQugZ4E26pp
 Nhlol3v80VapGAQb1pZv8po6XFn5dxVre2WQaHOu7b4FCdX1w5r+5ttATe+1+Gk9t40D
 kdRFnNknlX8tLolCg1rVvC4k/8LjPSzi1uRAyMkZ8bcBjtyJvCB7P1+Ll+r3ifDR20l7
 1L9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698164721; x=1698769521;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQsq2LWk3bVW9FNqtR4uLNXJWBJH5YdmWftR29dvZwY=;
 b=XqG9JeWizBM5KmPapKRcliUa4tQuOyFA7jiCNLf78hItbQYfBnILycNc+tz9/Jxy+y
 FtYSwxb8KWkHhNqHwDM3LmFYsdBlhRkwAC4N+Y5wcjuQzcqjcmFxCPGDTgTwwN8fKt0K
 qeLFZ3G/vCdtqwT9n8wFm/5B9ZYUQn+yc944usJ8lVhcTAWNYVj/d95d8uy+V93BpQz0
 lGvn3rRuJudDXrkG7Su1N0b6ShXUTfrLEteAyxHOBMDaYBQNbkgu+bdQTDUTHETpPZyo
 eWdPgog1GBAqaXzzUB1j4enYgZy57bT67101HBHpHpFhTNqvwcZ+qkRaIKUvBqYyGvWf
 TExg==
X-Gm-Message-State: AOJu0Yx2kW7xqHfP7EGuKrRIpc2I5GYLecGccRDT4p0Bk5HwxBt59S10
 4dsOdNsgJfBV95XOGdd1EHw=
X-Google-Smtp-Source: AGHT+IEyWeztiwQ8cM58Q3Udtb/rgzHp2VAypkAcc4XZaR7o8nmAoBYxpyNYOMgRGMHbHOA9ZtR7WQ==
X-Received: by 2002:a1c:790a:0:b0:406:5308:cfeb with SMTP id
 l10-20020a1c790a000000b004065308cfebmr9764626wme.11.1698164721279; 
 Tue, 24 Oct 2023 09:25:21 -0700 (PDT)
Received: from [192.168.6.66] (54-240-197-238.amazon.com. [54.240.197.238])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a05600c418c00b0040773c69fc0sm16842887wmh.11.2023.10.24.09.25.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 09:25:20 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <19fc2701-4cd8-4a14-9d45-bfaea37ed2d6@xen.org>
Date: Tue, 24 Oct 2023 17:25:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] hw/xen: add support for Xen primary console in
 emulated mode
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org
References: <20231016151909.22133-1-dwmw2@infradead.org>
 <20231016151909.22133-13-dwmw2@infradead.org>
 <c18439ca-c9ae-4567-bbcf-dffe6f7b72e3@xen.org>
 <3acd078bba2d824f836b20a270c780dc2d031c43.camel@infradead.org>
 <3f22903b-30f0-40f2-8624-b681d9c7e05d@xen.org>
 <42b005d7c03d5b0d47a16c4e025d8c3ec7289e0f.camel@infradead.org>
Organization: Xen Project
In-Reply-To: <42b005d7c03d5b0d47a16c4e025d8c3ec7289e0f.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 24/10/2023 16:49, David Woodhouse wrote:
> On Tue, 2023-10-24 at 16:39 +0100, Paul Durrant wrote:
>> On 24/10/2023 16:37, David Woodhouse wrote:
>>> On Tue, 2023-10-24 at 15:20 +0100, Paul Durrant wrote:
>>>> On 16/10/2023 16:19, David Woodhouse wrote:
>>>>> From: David Woodhouse <dwmw@amazon.co.uk>
>>>>>
>>>>> The primary console is special because the toolstack maps a page at a
>>>>> fixed GFN and also allocates the guest-side event channel. Add support
>>>>> for that in emulated mode, so that we can have a primary console.
>>>>>
>>>>> Add a *very* rudimentary stub of foriegnmem ops for emulated mode, which
>>>>> supports literally nothing except a single-page mapping of the console
>>>>> page. This might as well have been a hack in the xen_console driver, but
>>>>> this way at least the special-casing is kept within the Xen emulation
>>>>> code, and it gives us a hook for a more complete implementation if/when
>>>>> we ever do need one.
>>>>>
>>>> Why can't you map the console page via the grant table like the xenstore
>>>> page?
>>>
>>> I suppose we could, but I didn't really want the generic xen-console
>>> device code having any more of a special case for 'Xen emulation' than
>>> it does already by having to call xen_primary_console_create().
>>>
>>
>> But doesn't is save you the whole foreignmem thing? You can use the
>> grant table for primary and secondary consoles.
> 
> Yes. And I could leave the existing foreignmem thing just for the case
> of primary console under true Xen. It's probably not that awful a
> special case, in the end.
> 
> Then again, I was surprised I didn't *already* have a foreignmem ops
> for the emulated case, and we're probably going to want to continue
> fleshing it out later, so I don't really mind adding it.
> 

True. We'll need it for some of the other more fun protocols like vkbd 
or fb. Still, I think it'd be nicer to align the xenstore and primary 
console code to look similar and punt the work until then :-)

   Paul

