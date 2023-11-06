Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C372F7E294D
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 17:01:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r022e-0002PY-Gq; Mon, 06 Nov 2023 11:01:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r022c-0002Oq-Ei; Mon, 06 Nov 2023 11:01:30 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r022a-0001Lv-K0; Mon, 06 Nov 2023 11:01:29 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40906fc54fdso35819595e9.0; 
 Mon, 06 Nov 2023 08:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699286487; x=1699891287; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VuSTMH9ud0jYjriaosHkWWyigJusFLw9itadu/Ef8us=;
 b=MyRnUe6WTC4Yc/nc8yWium3Ksr/d/Hx0Xm8RxGMmT6TdoCiOKwFyuIkDntX4//Z25Y
 BNOMfOdQ8kA8FpYwDlLi12Cs8PQ2ufBKyu/8TAC3aSEkfU80nbWuUyVrdky/VD0vfmFt
 U/DD9yei8y9aJ14bg9oYBF8iLJ2QnA32IEeeUklo99b4MVe8nVxXttJuCFe+QJ8wJl5C
 xS2i0mdlEXkJ3v/nYOT9n/d6YYEbqKFXC8RuR/ykxXJtPFAwc9u3a5nVYuCR4HVxxOGw
 /3aySNJcGg5MUFvUyyly7bBVOiJkIShF3OsY/u1T8bBpirA3QTA3g/6+rysSIFMCQv/g
 qPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699286487; x=1699891287;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VuSTMH9ud0jYjriaosHkWWyigJusFLw9itadu/Ef8us=;
 b=FHU6mhVhaxAkmC062pbO9KaTG9WnXl2+dC5QKh48KKwvmEpIhAxp2cYFRW8aAXA/fJ
 +RYKAZ7NrwI5au50AuKlFQhy2wS325i2Qh7VsKRZKq3uKIhODYGDS/Tehao4/egNzwhC
 xH/NA61IB4aRfjBWcz7dbZsFxWb45rouikIBNmA9k9Mx95s6m6u/4whbcuU2JLZDcDIH
 FNCXc9DPIcsqcHTzjsrZ5n5tODV77R7n3uqFAcDiuVvKSGgVs8qnyXIRroAXl0VkKYEU
 qs/cEbQ0G20NQNTvpuaVaYq94Pz+0dkwYPBWXMyjBB7eWbl2sVsp4x3WAiv1deAofDH3
 gBqg==
X-Gm-Message-State: AOJu0YyFFBgaG6jBCr2H0DwTQw0qK+yaXgKU/tR232uQKr+EHmroBMvR
 9XsPWPL6IqAlLrNjsXsxytE=
X-Google-Smtp-Source: AGHT+IE+3PRRsyWElc9zPvKSrIuMWGE4WXTjXvI2QsMrBJiC6CPa5U2EB5CV13HsYIol7JDB6fOz+Q==
X-Received: by 2002:a5d:6485:0:b0:32f:a7d5:4ef with SMTP id
 o5-20020a5d6485000000b0032fa7d504efmr11943384wri.44.1699286486710; 
 Mon, 06 Nov 2023 08:01:26 -0800 (PST)
Received: from [10.95.110.31] (54-240-197-231.amazon.com. [54.240.197.231])
 by smtp.gmail.com with ESMTPSA id
 h3-20020a5d5043000000b0032dba85ea1bsm9838958wrt.75.2023.11.06.08.01.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 08:01:24 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <71dc2018-9840-458e-8ca6-3cb8ab86666d@xen.org>
Date: Mon, 6 Nov 2023 16:01:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/17] hw/i386/pc: support '-nic' for xen-net-device
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-block@nongnu.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org
References: <20231106143507.1060610-1-dwmw2@infradead.org>
 <20231106143507.1060610-14-dwmw2@infradead.org>
Organization: Xen Project
In-Reply-To: <20231106143507.1060610-14-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 06/11/2023 14:35, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The default NIC creation seems a bit hackish to me. I don't understand
> why each platform has to call pci_nic_init_nofail() from a point in the
> code where it actually has a pointer to the PCI bus, and then we have
> the special cases for things like ne2k_isa.
> 
> If qmp_device_add() can *find* the appropriate bus and instantiate
> the device on it, why can't we just do that from generic code for
> creating the default NICs too?
> 
> But that isn't a yak I want to shave today. Add a xenbus field to the
> PCMachineState so that it can make its way from pc_basic_device_init()
> to pc_nic_init() and be handled as a special case like ne2k_isa is.
> 
> Now we can launch emulated Xen guests with '-nic user'.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/pc.c             | 11 ++++++++---
>   hw/i386/pc_piix.c        |  2 +-
>   hw/i386/pc_q35.c         |  2 +-
>   hw/xen/xen-bus.c         |  4 +++-
>   include/hw/i386/pc.h     |  4 +++-
>   include/hw/xen/xen-bus.h |  2 +-
>   6 files changed, 17 insertions(+), 8 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


