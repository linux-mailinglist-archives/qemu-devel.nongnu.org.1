Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F317D7D4FCA
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 14:31:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvGXi-0000Ln-0G; Tue, 24 Oct 2023 08:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvGXg-0000LT-8P; Tue, 24 Oct 2023 08:29:52 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvGXe-0007Bu-Gj; Tue, 24 Oct 2023 08:29:52 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c51388ccebso65748581fa.3; 
 Tue, 24 Oct 2023 05:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698150588; x=1698755388; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6W+0Okxg9I00CjQFxVnV6ntSdHCpG+SP4y3vva54Y8E=;
 b=lqQNFJwWj6n7tDcJXMuIuqrz5TdP2VIpzZgK7ERntyP7jLWT3T7wVdzn88wzOwGgmt
 DCkw9zelgl3uIoOov5k9C3rdtskbN9a5k+kSKmQ3Ym8VKhCGnLD98VCfxvt5I1QFZAM/
 meLAy3Q534cHPG/OiSSQUZc/XrXwNy5wOl06m2SBZou6mM+ynKLut1lRhi8w7QPeIBv8
 IMBNiC4f+p2JDGoYeDc0mfDi4XJ8/lYB7hdw0GGjUjZDCHj1CAVw92BoQFjIbOe9kGIi
 Da4kBtZ69nMxWeVEypOndMjvlIMBvBGplfkiFAbU9uC9F5KPYiqiTiMZpNqUZiBL2sUd
 tWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698150588; x=1698755388;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6W+0Okxg9I00CjQFxVnV6ntSdHCpG+SP4y3vva54Y8E=;
 b=etNTnHCGV8A6bavxOXetSZv8/QpmRgYQKxgC0EVVJmoqbcMRDCKGattM+TCnUxi6cY
 jm9UioTDpHmZek4DzDBdDB72VqVVLr9qvTLXf/f+Vhv7SJzyPaPXEsIT9Wa8Z/T45mFV
 owibegQfSWwKaOp1DJ1CGP2EqKe8dpOCgaIlT0atgrjxuv8ZAukS6+UhfNNg0nmk9roQ
 kRJ+XxkqNH7k98WNquAmhtH6TowSZRNMBgSezBQ0zdchLD+yTSUwZ+wyhLNC4Sha4PGB
 PiLNozb90Gp46mTbTwYKwAx1GgBDpHPJ7TEhRyR+Bfcecokqy6KDBpRj/yeXJJk/IZ2Q
 k6Dw==
X-Gm-Message-State: AOJu0YyliaeutJrr0CbNJo/4Usx9tq7zilXcNvnEGd188JP2qi5zEfAA
 P4tGHbo93vfwNExS1YD0j3Y=
X-Google-Smtp-Source: AGHT+IHQXaOLRvR4fMkOTyZrwynUH3dk9Z2h9mBZ5MJ5cJrzsBPSIpwKJU7nccdNSAx+0KKpMf83eA==
X-Received: by 2002:a2e:3c19:0:b0:2c5:1809:69ba with SMTP id
 j25-20020a2e3c19000000b002c5180969bamr8123521lja.40.1698150587872; 
 Tue, 24 Oct 2023 05:29:47 -0700 (PDT)
Received: from [192.168.6.66] (54-240-197-238.amazon.com. [54.240.197.238])
 by smtp.gmail.com with ESMTPSA id
 x22-20020a05600c189600b004083a105f27sm16404394wmp.26.2023.10.24.05.29.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 05:29:47 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <9eeb2cac-2f22-4e42-9765-2fd5e5a960fa@xen.org>
Date: Tue, 24 Oct 2023 13:29:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] hw/xen: select kernel mode for per-vCPU event
 channel upcall vector
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
 <20231016151909.22133-3-dwmw2@infradead.org>
Organization: Xen Project
In-Reply-To: <20231016151909.22133-3-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=xadimgnik@gmail.com; helo=mail-lj1-x229.google.com
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

On 16/10/2023 16:18, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> A guest which has configured the per-vCPU upcall vector may set the
> HVM_PARAM_CALLBACK_IRQ param to fairly much anything other than zero.
> 
> For example, Linux v6.0+ after commit b1c3497e604 ("x86/xen: Add support
> for HVMOP_set_evtchn_upcall_vector") will just do this after setting the
> vector:
> 
>         /* Trick toolstack to think we are enlightened. */
>         if (!cpu)
>                 rc = xen_set_callback_via(1);
> 
> That's explicitly setting the delivery to GSI#, but it's supposed to be
> overridden by the per-vCPU vector setting. This mostly works in QEMU
> *except* for the logic to enable the in-kernel handling of event channels,
> which falsely determines that the kernel cannot accelerate GSI delivery
> in this case.
> 
> Add a kvm_xen_has_vcpu_callback_vector() to report whether vCPU#0 has
> the vector set, and use that in xen_evtchn_set_callback_param() to
> enable the kernel acceleration features even when the param *appears*
> to be set to target a GSI.
> 
> Preserve the Xen behaviour that when HVM_PARAM_CALLBACK_IRQ is set to
> *zero* the event channel delivery is disabled completely. (Which is
> what that bizarre guest behaviour is working round in the first place.)
> 
> Fixes: 91cce756179 ("hw/xen: Add xen_evtchn device for event channel emulation")
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_evtchn.c  | 6 ++++++
>   include/sysemu/kvm_xen.h  | 1 +
>   target/i386/kvm/xen-emu.c | 7 +++++++
>   3 files changed, 14 insertions(+)
> 
> diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
> index 4df973022c..d72dca6591 100644
> --- a/hw/i386/kvm/xen_evtchn.c
> +++ b/hw/i386/kvm/xen_evtchn.c
> @@ -490,6 +490,12 @@ int xen_evtchn_set_callback_param(uint64_t param)
>           break;
>       }
>   
> +    /* If the guest has set a per-vCPU callback vector, prefer that. */
> +    if (gsi && kvm_xen_has_vcpu_callback_vector()) {
> +        in_kernel = kvm_xen_has_cap(EVTCHN_SEND);
> +        gsi = 0;
> +    }
> +

So this deals with setting the callback via after setting the upcall 
vector. What happens if the guest then disables the upcall vector (by 
setting it to zero)? Xen checks 'v->arch.hvm.evtchn_upcall_vector != 0' 
for every event delivery.

   Paul


