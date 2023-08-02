Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3339976DACE
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 00:27:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRKI3-0002AX-Nw; Wed, 02 Aug 2023 18:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qRKI0-00029p-Ar
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 18:25:56 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qRKHx-0007dI-Pw
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 18:25:55 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bba2318546so3391485ad.1
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 15:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691015152; x=1691619952;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8NueeIcQhehh0vZ2uhP2xsg4tdP5mDg1L1vXP1dHCgc=;
 b=GUpWx2WepTtZ4YY2yzF3h4EK/q9fEEmhWkTwAKSmxWpkvdx/gaS3duDWgs8n7YMwHb
 jvOLRKTzEIn7SyTtg+cyxeKK93LUTVCOwczhNw3gxnDQho0S/yCjOsDxOKDGvkdoNj5x
 M9y07zaPlh1Mh8kh0OveDsMrneIF7f5DT+4/KMTluFlt29g0ni9SF2fBg1qQpA6MEY4x
 50L7LbW5lyygb7dWJdeJAif0Oj5RvWWho0ayhC+E+dJRqiOsrCesTyNrzvYYMoOV343x
 5EAnGET/l9S2k99FF4N2BsLr1TMMuTsKzoVjjtiEVBr0UNrSDb4NYNLDiWcf9NJWly4G
 sVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691015152; x=1691619952;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8NueeIcQhehh0vZ2uhP2xsg4tdP5mDg1L1vXP1dHCgc=;
 b=GHUXU7FxAuattUphy9AtLiQtUzCyED8W9DbWDcapjgtnOiyBb21FEGcgp0IV+FG8lB
 hobKdYP2I52KeFo6kGfN+v8pl98sfHExlAaihm4SVxfs4fwNuvrY9neS2GYwF1WR+VFl
 ZzON/xaEz6GeE9t51UWCDtSaJU3sZgUdSGEVv434i5IYdkAlwqs703bA6CbZ2Uq0SXqi
 oJJv9024Uu2oV/un4UCa7NEPBc4oJhKf64MeJntdP4E9jksGlWiODD5odOGr/8hFba10
 43ZYLsVhQ2CixIRPjGCHcfW0enlkuurjyrJSfMEi9SrfoD6Mao2uOENPyA5nr5KqgsM2
 5hHw==
X-Gm-Message-State: ABy/qLZqPnV5wFTvQ9gaXfPXX9ufjvemR6UBXwEsYP/9AIuFXNCDhpMF
 NX8buX8vezgIyXyIxrlkdbk=
X-Google-Smtp-Source: APBJJlEbbwbyg8Np5bVXnweWNCTz1B78mvGq8ka6z/HQ71m8yvQmn4YpveS1tOHmuFw4GH7cOYoK8g==
X-Received: by 2002:a17:902:9b94:b0:1bb:a6db:3fd0 with SMTP id
 y20-20020a1709029b9400b001bba6db3fd0mr14764149plp.69.1691015152060; 
 Wed, 02 Aug 2023 15:25:52 -0700 (PDT)
Received: from localhost ([192.55.55.51]) by smtp.gmail.com with ESMTPSA id
 b13-20020a170902b60d00b001bc16bc9f5fsm5977693pls.284.2023.08.02.15.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 15:25:51 -0700 (PDT)
Date: Wed, 2 Aug 2023 15:25:45 -0700
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
Subject: Re: [RFC PATCH 15/19] kvm: handle KVM_EXIT_MEMORY_FAULT
Message-ID: <20230802222545.GC1807130@ls.amr.corp.intel.com>
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
 <20230731162201.271114-16-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230731162201.271114-16-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=isaku.yamahata@gmail.com; helo=mail-pl1-x636.google.com
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

On Mon, Jul 31, 2023 at 12:21:57PM -0400,
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> From: Chao Peng <chao.p.peng@linux.intel.com>
> 
> Currently only KVM_MEMORY_EXIT_FLAG_PRIVATE in flags is valid when
> KVM_EXIT_MEMORY_FAULT happens. It indicates userspace needs to do
> the memory conversion on the RAMBlock to turn the memory into desired
> attribute, i.e., private/shared.
> 
> Note, KVM_EXIT_MEMORY_FAULT makes sense only when the RAMBlock has
> gmem memory backend.
> 
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  accel/kvm/kvm-all.c | 52 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index f9b5050b8885..72d50b923bf2 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3040,6 +3040,48 @@ static void kvm_eat_signals(CPUState *cpu)
>      } while (sigismember(&chkset, SIG_IPI));
>  }
>  
> +static int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
> +{
> +    MemoryRegionSection section;
> +    void *addr;
> +    RAMBlock *rb;
> +    ram_addr_t offset;
> +    int ret = -1;
> +
> +    section = memory_region_find(get_system_memory(), start, size);
> +    if (!section.mr) {
> +        return ret;
> +    }
> +
> +    if (memory_region_can_be_private(section.mr)) {
> +        if (to_private) {
> +            ret = kvm_set_memory_attributes_private(start, size);
> +        } else {
> +            ret = kvm_set_memory_attributes_shared(start, size);
> +        }
> +
> +        if (ret) {
> +            return ret;
> +        }
> +
> +        addr = memory_region_get_ram_ptr(section.mr) +
> +               section.offset_within_region;
> +        rb = qemu_ram_block_from_host(addr, false, &offset);

Here we have already section. section.mr->ram_block.  We don't have to
scan the existing RAMBlocks.

Except that, looks good to me.
Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
-- 
Isaku Yamahata <isaku.yamahata@gmail.com>

