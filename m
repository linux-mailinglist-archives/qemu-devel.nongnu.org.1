Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7E3769F05
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 19:11:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQWPx-0001ka-Gw; Mon, 31 Jul 2023 13:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qQWPv-0001kM-LT
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 13:10:47 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qQWPt-0001HW-Q5
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 13:10:47 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bbf0f36ce4so18858705ad.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 10:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690823444; x=1691428244;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cNU9dnqwA33bWSRJZJl5nat2xoj0PX9l4djIhWRICY0=;
 b=AExM9wKjRd/rozndMc8/4u2f60z+wSuwW8JYQ5+smlCcf0YHGMQPEQUruPl0XPdpzG
 2ANYb/cud4zqE7BmXkuxWogufbwwBUBW4jtUYheiJbLy347xk+Afw/1ceVgCHA0LHODj
 9spWt30S40RXAxlTtye35UhbLu9x8QoLFElUirVMrhuzUHclPpqo/nHiaJMAQDEtsVEs
 1COUGxlA09DFT+T/DCkbqufIfgkHZgD1zV9r0H2yLNFvLH5XUeopDRBtPT/iyugE04mc
 Q+YLmQpojd1DaUY60zBjo/GAzcFPW9Oz/7cwYv4OxIENQUV+MDaNWsOZb8yHrEv/QwOI
 fKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690823444; x=1691428244;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cNU9dnqwA33bWSRJZJl5nat2xoj0PX9l4djIhWRICY0=;
 b=ANJa6q9gmU4tTEmJOS19HliIdl1cVHbodcvFnbWnPkhsW75CD6LLHBgS3zTQiAMU/n
 +2yJOkVL+Nrcvvl+AxyfvxsRMFKasOrWBUIaGKfyTc/sgqA2txjSA4gal5gORKd95kDy
 a/016ZVVmdSkNtq+Rbdn/yUGgqRQL47C3nkfxVIOFUyLA5VHGpHVgh1aotK2tM9rDs5n
 RkfXoOGOW22v+oXti9ARb0C7xPP13G2eMdAoEMeRC+98K3CSnyPbfNhIDF/vW6MNHK0S
 5OUN4YxYp1RjH7s1VvCRed+vX875bzqO/91he6k3lXvMLcHe3Ws5fw5vBt+mB2oKJIYQ
 FLdw==
X-Gm-Message-State: ABy/qLZVWwgGHW2FmTQe6OV0R2zEF9/V3TLMrbT+OYn20WfmXsO5IyUq
 ebU0zJqzIU8oB31I7jc8AA0=
X-Google-Smtp-Source: APBJJlFD9DjtwDzTWlKNlEtUB9FGJ9bPLRBijCv/B1JFsGrtf/eJQit+5cEu0lwMuIBS7GtAxPzEyQ==
X-Received: by 2002:a17:902:c411:b0:1b8:a67f:1c0f with SMTP id
 k17-20020a170902c41100b001b8a67f1c0fmr15203176plk.39.1690823443711; 
 Mon, 31 Jul 2023 10:10:43 -0700 (PDT)
Received: from localhost ([192.55.55.51]) by smtp.gmail.com with ESMTPSA id
 m24-20020a170902bb9800b001b87bedcc6fsm8829093pls.93.2023.07.31.10.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 10:10:43 -0700 (PDT)
Date: Mon, 31 Jul 2023 10:10:41 -0700
From: Isaku Yamahata <isaku.yamahata@gmail.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC PATCH 00/19] QEMU gmem implemention
Message-ID: <20230731171041.GB1807130@ls.amr.corp.intel.com>
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230731162201.271114-1-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=isaku.yamahata@gmail.com; helo=mail-pl1-x62b.google.com
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Jul 31, 2023 at 12:21:42PM -0400,
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> This is the first RFC version of enabling KVM gmem[1] as the backend for
> private memory of KVM_X86_PROTECTED_VM.
> 
> It adds the support to create a specific KVM_X86_PROTECTED_VM type VM,
> and introduces 'private' property for memory backend. When the vm type
> is KVM_X86_PROTECTED_VM and memory backend has private enabled as below,
> it will call KVM gmem ioctl to allocate private memory for the backend.
> 
>     $qemu -object memory-backend-ram,id=mem0,size=1G,private=on \
>           -machine q35,kvm-type=sw-protected-vm,memory-backend=mem0 \
> 	  ...
> 
> Unfortunately this patch series fails the boot of OVMF at very early
> stage due to triple fault because KVM doesn't support emulate string IO
> to private memory. We leave it as an open to be discussed.
> 
> There are following design opens that need to be discussed:
> 
> 1. how to determine the vm type?
> 
>    a. like this series, specify the vm type via machine property
>       'kvm-type'
>    b. check the memory backend, if any backend has 'private' property
>       set, the vm-type is set to KVM_X86_PROTECTED_VM.

Hi Xiaoyao.  Because qemu has already confidential guest support, we should
utilize it.  Say,
qemu  \
  -object sw-protected, id=swp0, <more options for KVM_X86_SW_PROTECTED_VM> \
  -machine confidential-guest-support=swp0



> 2. whether 'private' property is needed if we choose 1.b as design 
> 
>    with 1.b, QEMU can decide whether the memory region needs to be
>    private (allocates gmem fd for it) or not, on its own.


Memory region property (how to create KVM memory slot) should be independent
from underlying VM type.  Some (e.g. TDX) may require KVM private memory slot,
some may not.  Leave the decision to its vm type backend.  They can use qemu
memory listener.
-- 
Isaku Yamahata <isaku.yamahata@gmail.com>

