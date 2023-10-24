Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA037D54A8
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:04:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvIvq-0007aU-P7; Tue, 24 Oct 2023 11:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvIvo-0007aE-Pz; Tue, 24 Oct 2023 11:02:56 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvIvn-000813-43; Tue, 24 Oct 2023 11:02:56 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-507a0907896so6819578e87.2; 
 Tue, 24 Oct 2023 08:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698159773; x=1698764573; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CgHp0CJaaQlW610O/NVGeBqWOSNojjcDIIfF8qOnyh8=;
 b=EBXGx6NeDL57N619PbAYh4uLLLcKpxTXBedDG/jQXdEEoWm79FEmiw3xGlRwMrHw62
 TfWddn6FRDHTSi22NplRhPFysxvMz/atHGoD0nIG8cbyjwcNiruGpBUiXJJJIkuhV0pf
 XYkEemzTuCSw6e3GH/Z1mOodNGzrA5VB01eY+iRwBx7hnC4P8nLpsdTe/o8MTjzFoqEw
 cWdnGB4UikPZh7v9znxiFLDhsKyR/vIqJ1HDMNosZAcfQ8E8PEUz0IETZARZWr8SJbkU
 rrCR501mvoKQwS/y5n+yHXVXOF9CrRvIcWMdKmiu1O7g4UwPBvYH+humHzdh8Z/i8icD
 2uzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698159773; x=1698764573;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CgHp0CJaaQlW610O/NVGeBqWOSNojjcDIIfF8qOnyh8=;
 b=bo4HiMyGzzxVzc5zIJij1QIOUXDNX8Reg1jHB/y1kzyIMrgB0ljQ75Bd8LJ1MZp5vf
 jEl4M9dq8GxMBQOZ+O50tBLwxY+66pdunSqqnYS6fzQuDyvdnzeozZu8VrQ0iED8YEdJ
 AhharwTW0wRQtmYxYFWZnMQUcm7HHMVaAOkFEWHn0W9T6FHFBUscDvpdOms6A59ZmNhz
 +/SnT8fJIjlCF4fqOJfomzvQH8oJf5l7rWgXU6drhv9/BJf/F/MQ46wy4+DkfdgNHaro
 8f6IDKBurFSPLP/oTOj6OlgRUhLonezj8akayb2/cu5b0N+tXD0lJ7WGhYueidlaqXz4
 SqBA==
X-Gm-Message-State: AOJu0YwYW2UHxZE/HNtdNOgrXjHM5HSMJUxSyC3SUWbMHOL2jK4PkU8+
 wf1A4ol678gCLQ1WiC7Hs6Y=
X-Google-Smtp-Source: AGHT+IH9T45ADuXoRcFMFSb5Oytx69M3MV46mrRNCIVJ622Q0DyMPbV1Z877betPlfNUrQXWzUmZCw==
X-Received: by 2002:a05:6512:3b8e:b0:502:ffdf:b098 with SMTP id
 g14-20020a0565123b8e00b00502ffdfb098mr11070376lfv.6.1698159772803; 
 Tue, 24 Oct 2023 08:02:52 -0700 (PDT)
Received: from [192.168.6.66] (54-240-197-238.amazon.com. [54.240.197.238])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a056000128500b0031c6581d55esm10091262wrx.91.2023.10.24.08.02.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 08:02:52 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <bd55f12a-1a01-40fb-a61a-dd5ddbd58557@xen.org>
Date: Tue, 24 Oct 2023 16:02:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/24] hw/xen: select kernel mode for per-vCPU event
 channel upcall vector
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
 <20231019154020.99080-4-dwmw2@infradead.org>
Organization: Xen Project
In-Reply-To: <20231019154020.99080-4-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=xadimgnik@gmail.com; helo=mail-lf1-x12d.google.com
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

On 19/10/2023 16:39, David Woodhouse wrote:
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
> That's explicitly setting the delivery to GSI#1, but it's supposed to be
> overridden by the per-vCPU vector setting. This mostly works in Qemu
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

Reviewed-by: Paul Durrant <paul@xen.org>


