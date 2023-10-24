Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F4C7D5817
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:24:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKBC-0006PV-ON; Tue, 24 Oct 2023 12:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvKB9-0006I9-Vx; Tue, 24 Oct 2023 12:22:52 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvKB4-0000Oh-Jt; Tue, 24 Oct 2023 12:22:51 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4081ccf69dcso32750265e9.0; 
 Tue, 24 Oct 2023 09:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698164564; x=1698769364; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e3Lw885OKwVMAKJ+lcANwbqiLUJvnaLF4rMzyVhxCiE=;
 b=mCUO2Bqg1YtEA9Ixqqe3/Xc3CLGUuAjOK4/DM3MDe1/asTe1ZReEGmOID/BC8fPUFe
 uzFohmCoeiUTsS/EcWZBme2NewfZr8U8jeMhnMoG6/uze5mFqo6gnUrcZPaTUuhbHCUV
 8S1rByvlDq4lptNRHiKQT3lUF/K56bPY6H7fswtn8x9i6Kp5WyYywJAeQI6FwGvDp9TA
 DFRV/mX2m6zuIb9pODWeJwseus1KwRjI5UPOirNpRGsSR4PMmw0IhRIyjEX/rAvGlmjv
 Cdrl+ActuV5i0lmVNS9yKby/fCwzb0RsuCBIl7TuMRT4yZkDP0I/RDqilzGSvG+gBR4f
 7RTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698164564; x=1698769364;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3Lw885OKwVMAKJ+lcANwbqiLUJvnaLF4rMzyVhxCiE=;
 b=adn6r5a6I5dPDoQoTgPbDSP6V6/cTR/tsQ8EWFtG6gA0GfiiyWO3+QXXCJic5c6UpZ
 S4lHvF6rt/5/dFViRgDdaS+qlzQCy8LszNZKeO3cNvaHn7QrY0T/sltHfE11q8N+SyfZ
 GbMoUHL+eb8ew+b7agGQHmgUR7viQB2vjKBGASOxo23OcsKn3Noo8adG2FQesm1V+K0Q
 /DmBToZuiYP6fVshKQZAbgmV6zSZYoxcl/ryh3S2pe2ZqCrKe8jQza3Nju0b8msd2gkH
 kOBmcXaMpWSeW9CQqk+7sDxn9jcriwd2eS+XQMBIoJclOQ5lkEWZN2yw9mUnsynRS+SR
 FQjg==
X-Gm-Message-State: AOJu0YxRPSyw0IVzm1309VfJHsX6Js+41G2ijnq11u7y982KWzNWq8Ye
 AkOhhcGV8CVEYhCTz6HryJ4=
X-Google-Smtp-Source: AGHT+IGE5clc2rOnE6leeciZfVRiFGqwOxcrDHe1tg4zz2ecPacv7kXaqp1axxGRcGZHMciB9vvCKw==
X-Received: by 2002:adf:b1d1:0:b0:32d:c755:d73d with SMTP id
 r17-20020adfb1d1000000b0032dc755d73dmr14284793wra.18.1698164564123; 
 Tue, 24 Oct 2023 09:22:44 -0700 (PDT)
Received: from [192.168.6.66] (54-240-197-230.amazon.com. [54.240.197.230])
 by smtp.gmail.com with ESMTPSA id
 h12-20020adff18c000000b0032d402f816csm10104046wro.98.2023.10.24.09.22.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 09:22:43 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <ab2aabe5-b3c3-43f5-812e-bce98d2e59ae@xen.org>
Date: Tue, 24 Oct 2023 17:22:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/24] hw/xen: handle soft reset for primary console
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Bernhard Beschow <shentey@gmail.com>, Joel Upham <jupham125@gmail.com>
References: <20231019154020.99080-1-dwmw2@infradead.org>
 <20231019154020.99080-17-dwmw2@infradead.org>
 <8ba01df3-6189-4e1e-a70f-37a2d4dd21ed@xen.org>
 <3124d1d6e9af139a3c7b6dbe2b73a82914d3f559.camel@infradead.org>
Organization: Xen Project
In-Reply-To: <3124d1d6e9af139a3c7b6dbe2b73a82914d3f559.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 24/10/2023 16:48, David Woodhouse wrote:
> On Tue, 2023-10-24 at 16:44 +0100, Paul Durrant wrote:
>> On 19/10/2023 16:40, David Woodhouse wrote:
>>> From: David Woodhouse <dwmw@amazon.co.uk>
>>>
>>> On soft reset, the prinary console event channel needs to be rebound to
>>> the backend port (in the xen-console driver). We could put that into the
>>> xen-console driver itself, but it's slightly less ugly to keep it within
>>> the KVM/Xen code, by stashing the backend port# on event channel reset
>>> and then rebinding in the primary console reset when it has to recreate
>>> the guest port anyway.
>>
>> Does Xen re-bind the primary console on EVTCHNOP_reset? That's news to
>> me. I go check.
> 
> I spent an unhapp hour trying to work out how Xen actually does any of
> this :)
> 
> In the short term I'm more interested in having soft reset work, than
> an explicit EVTCHNOP_reset. And I can't work out *how*, but we do seem
> to have console again after a kexec in real Xen.

*Soft* reset may do it, but not the EVTCHNOP_reset hypercall itself, 
because there's a bunch of impenetrable toolstack magic involved the 
former. Perhaps you could just push the re-bind code up a layer into
kvm_xen_soft_reset().

   Paul

