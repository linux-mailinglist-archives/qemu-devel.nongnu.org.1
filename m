Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B70A7D4FCB
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 14:31:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvGYu-0000v1-TA; Tue, 24 Oct 2023 08:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvGYl-0000pV-BO; Tue, 24 Oct 2023 08:31:06 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvGYj-0007dp-N5; Tue, 24 Oct 2023 08:30:59 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c50fbc218bso63252831fa.3; 
 Tue, 24 Oct 2023 05:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698150654; x=1698755454; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qkkKPtB+0MYb68gtsi8LcLr9VZV4vaP8LHEM7IjFw7M=;
 b=dU+++SdiPbwlt73mUS777QQBdyfyRUyb4BC/DMrHh/+RSqeuihb8tQGsgCoUWYo9ng
 weQYKQz7jNPrxrtHBn9BdlXYKB8lvnA0Wn58kJIL83gW7U65+eoL8JMG0c/TCr6gKWIi
 RyCKdtoPlkShFfmbWpaT3Tj7U+9Xn2/ULcOSsho+BDFXSw7FGWTG+k7mysfQzZuxtXTp
 5Rw6vcj9yN2KNcGFj1AVtvYg0E+3HNPWLDhRWHCrd+PE4fRjHOklUlLL4ZJfEYu2eCiw
 ViV3o773JgLMb1NaDztmMfykZyfgJudqCwTG/Fkw59t2k1JGDO5Eh3kgv9dXm76Lq+nk
 FKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698150654; x=1698755454;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qkkKPtB+0MYb68gtsi8LcLr9VZV4vaP8LHEM7IjFw7M=;
 b=pf71DgQwsRyhdpXQO//SLAmPPgNRHi9j4VIfPskAYSONC5nU361dDxGPJX6KbZqy6j
 hDXrCm9kfRNZ3xMUY8hW2GqISLBupXbjNpMj2VzbVrm3M7YGYM+JTf3Nsz8wIuXqmGSZ
 ctkUqI6M3NdjmCFpu3WutII7wjTJ70Fg5BNSeuRq6klo03SWIVS8+MXoGBI9IQX1smda
 mLXv9EAHKiqh56OlXAnQ5WgboR/WjtNhyeKk4PJZzCD6Sc6dN5d6dtMJ0tX3bc8c0ypt
 +laWrGXLAiSJbZyylRJdbyMivFOZTWaD5wUZzYdzqLh3hTVw4ToRB8fUe62YyoBdQg6V
 ucjg==
X-Gm-Message-State: AOJu0YzEMrA1Ogt+wk0aVR+JghwjZ3NwDrvFzXt15J+rA/S/2LuLr8Ua
 NVNV/Q3izaQrjERh2ZZ4smAxZIYVU6g2Kw==
X-Google-Smtp-Source: AGHT+IE/mzlKG6p6MNuMkl5KdeR+gdKt/64A9xubv6BdiuV2Bc68YaEih+Wh7ICweIO/TGve36ruQA==
X-Received: by 2002:a2e:a7cc:0:b0:2c5:fb9:49b6 with SMTP id
 x12-20020a2ea7cc000000b002c50fb949b6mr11630710ljp.10.1698150654333; 
 Tue, 24 Oct 2023 05:30:54 -0700 (PDT)
Received: from [192.168.6.66] (54-240-197-238.amazon.com. [54.240.197.238])
 by smtp.gmail.com with ESMTPSA id
 x22-20020a05600c189600b004083a105f27sm16404394wmp.26.2023.10.24.05.30.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 05:30:53 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <d6db2c5d-da65-4f93-a340-2ca4772e86db@xen.org>
Date: Tue, 24 Oct 2023 13:30:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] include: update Xen public headers to Xen 4.17.2
 release
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
 <20231016151909.22133-4-dwmw2@infradead.org>
Organization: Xen Project
In-Reply-To: <20231016151909.22133-4-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=xadimgnik@gmail.com; helo=mail-lj1-x231.google.com
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

On 16/10/2023 16:19, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> ... in order to advertise the XEN_HVM_CPUID_UPCALL_VECTOR feature,
> which will come in a subsequent commit.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_xenstore.c                    |  2 +-
>   include/hw/xen/interface/arch-arm.h           | 37 +++++++-------
>   include/hw/xen/interface/arch-x86/cpuid.h     | 31 +++++-------
>   .../hw/xen/interface/arch-x86/xen-x86_32.h    | 19 +------
>   .../hw/xen/interface/arch-x86/xen-x86_64.h    | 19 +------
>   include/hw/xen/interface/arch-x86/xen.h       | 26 ++--------
>   include/hw/xen/interface/event_channel.h      | 19 +------
>   include/hw/xen/interface/features.h           | 19 +------
>   include/hw/xen/interface/grant_table.h        | 19 +------
>   include/hw/xen/interface/hvm/hvm_op.h         | 19 +------
>   include/hw/xen/interface/hvm/params.h         | 19 +------
>   include/hw/xen/interface/io/blkif.h           | 27 ++++------
>   include/hw/xen/interface/io/console.h         | 19 +------
>   include/hw/xen/interface/io/fbif.h            | 19 +------
>   include/hw/xen/interface/io/kbdif.h           | 19 +------
>   include/hw/xen/interface/io/netif.h           | 25 +++-------
>   include/hw/xen/interface/io/protocols.h       | 19 +------
>   include/hw/xen/interface/io/ring.h            | 49 ++++++++++---------
>   include/hw/xen/interface/io/usbif.h           | 19 +------
>   include/hw/xen/interface/io/xenbus.h          | 19 +------
>   include/hw/xen/interface/io/xs_wire.h         | 36 ++++++--------
>   include/hw/xen/interface/memory.h             | 30 +++++-------
>   include/hw/xen/interface/physdev.h            | 23 ++-------
>   include/hw/xen/interface/sched.h              | 19 +------
>   include/hw/xen/interface/trace.h              | 19 +------
>   include/hw/xen/interface/vcpu.h               | 19 +------
>   include/hw/xen/interface/version.h            | 19 +------
>   include/hw/xen/interface/xen-compat.h         | 19 +------
>   include/hw/xen/interface/xen.h                | 19 +------
>   29 files changed, 124 insertions(+), 523 deletions(-)
> 

Acked-by: Paul Durrant <paul@xen.org>


