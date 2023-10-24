Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2F17D4FD7
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 14:33:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvGai-0002k8-7z; Tue, 24 Oct 2023 08:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvGae-0002gc-4m; Tue, 24 Oct 2023 08:32:56 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvGac-0007qK-Dq; Tue, 24 Oct 2023 08:32:55 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40839807e82so25716205e9.0; 
 Tue, 24 Oct 2023 05:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698150772; x=1698755572; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z8xi1P/dcTtFP7ePzE6x4tmvxxQQYlCJaujecDuFetg=;
 b=dmMIBFfvz0+RdX8/98fWlPt8My6PVyLXEIBSKSOFQPw1wa/pXmkN9ESnwQ9NqwS7Xy
 l7dDJle6g0J09Ix7u9ARTM1nNR50gGp3bROCEjW6z/pwu0dRQlJsBUZnz3bH+BvqkFUW
 2O48hlWnj2+Acp5zQl0puASs2DMpu5nIQFMkdLuzxlzPbbkj2+z0Zfk306yEGgKsyc8m
 JEaMfSYjZBbtBpGODieWeyn6V7PDH68BbplFEZZbgq2dQ2N5KhwNAY4htnK703+3wSb5
 woHV2quwOyx5u4InbrtTxOU38xTrRtR7rhk5lNq08q9et3sYJu4GGG//kB7liynwlM9f
 XgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698150772; x=1698755572;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z8xi1P/dcTtFP7ePzE6x4tmvxxQQYlCJaujecDuFetg=;
 b=F1pGcKg3cr8gnxMnGiYwx+LCYwFLfrI4v2HkLiv8G/aCGz3rQBtu0U3ilNA7XlLy3R
 XRgdtUVex5sB6xWQZYogYLUnCL1JDyK6nwcr/4xFTylaaZGTMUZya5gwhBj5dX4unLJx
 LYr8nuqgYwP0W692OxriimORwM0rlUuCgV3Qxtc0dlmuNf2kP++ytn2AgPGZOGM8IzGK
 ISpG8V1ERhQj77Ycn7Ii5wSBMLNh85l9VMFlxZInJAP0kC7A+gysmlhkJA8cGWLq9oDt
 jTTce50JESC4nh6myrqw+Rp6SFWf0GCqT2kLdy0vP03iUJP+4DqzPtXQ0GxX1xG2I3dd
 wkVw==
X-Gm-Message-State: AOJu0Yx8YhGeEQYwzO/yvf8jqZgVEfqAf538yQDe6iV9FscwhvB+hKk8
 8jzvrXG7yzGdnJ7KYxsCq3U=
X-Google-Smtp-Source: AGHT+IGLdFkCr04zokQorvoqlEejP4kWXqo5hK8lgihYOMmGeEBHFMEAE6OQhDXnhcyIoipg+gCexQ==
X-Received: by 2002:a7b:c8ce:0:b0:406:5a14:5c1e with SMTP id
 f14-20020a7bc8ce000000b004065a145c1emr14719463wml.1.1698150772070; 
 Tue, 24 Oct 2023 05:32:52 -0700 (PDT)
Received: from [192.168.6.66] (54-240-197-238.amazon.com. [54.240.197.238])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a05600c1c8600b003fe1c332810sm16779437wms.33.2023.10.24.05.32.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 05:32:51 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <2126ac82-3ec5-4535-b676-d4a745d6314e@xen.org>
Date: Tue, 24 Oct 2023 13:32:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] i386/xen: advertise XEN_HVM_CPUID_UPCALL_VECTOR in
 CPUID
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
 <20231016151909.22133-5-dwmw2@infradead.org>
Organization: Xen Project
In-Reply-To: <20231016151909.22133-5-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x331.google.com
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
> This will allow Linux guests (since v6.0) to use the per-vCPU upcall
> vector delivered as MSI through the local APIC.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   target/i386/kvm/kvm.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


