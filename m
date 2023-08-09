Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB1E776196
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 15:48:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTjXU-0006s3-Hy; Wed, 09 Aug 2023 09:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qTjXS-0006rR-0l
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 09:47:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qTjXQ-0005Nl-CM
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 09:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691588867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zmhd7JMKMCgqoC8YNzrpomo2C16dWkOVGIKW/bXyPKA=;
 b=RYgW4V1lKPU26tW5Ir0XnapqYf5F3KVB5vcmQXLLhO+MJjuY8ocppu2c+sS9PO0xkSmiwv
 XiJ88xYhPmr7+YKToC/kPqTeAw7pgmqjWPmrc8f9wbUIJ8RdfXVV1PLugITbczg5pQjIWY
 rumV6YUNvZi7I5PsEM9me+gXKhYSSrI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-pTlv3pZQMPewk1fox0q9EA-1; Wed, 09 Aug 2023 09:47:45 -0400
X-MC-Unique: pTlv3pZQMPewk1fox0q9EA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ba37b5519fso38621331fa.2
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 06:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691588864; x=1692193664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zmhd7JMKMCgqoC8YNzrpomo2C16dWkOVGIKW/bXyPKA=;
 b=dRnUlktCaXFpsFVw2J0OUYc++5eXc73vosk9ByP5xt23uew1GSV2mhiN29q+a4Ci4j
 bVygMOpaX0jqLh/HFN3H+rvd76aOttm5Fs+F09br1BpfOD0/KoiRcCmVyXDTjcjTzU6X
 3E8FbNFUUnVd8qktFngRmWKdFvHS7wiINhDzjSJGehlJejztJQVls41YsqugVyGtKfRb
 qSG+5GwPK3xjfBbqgiOgC0rQOqVA0/R9U3aytM1GF1VNoxJu6ei+EZBM7JiqM/pswlQj
 zs0q/IwOfl+NUlQxfC2xkJKvJ53AFOmB5Vq6TOSNQQxukwekfNZ4huXkJ0hNUKPAwvbP
 eniQ==
X-Gm-Message-State: AOJu0YzAHRHgFpmO0F8KGfIStxqrn+NVplpzJV06kCYnyPOU/6LdPNNb
 9Dz+0wUveXM/RS3ULGICdZogsmLq6AEpo2puXyjfwkXqFcr+0ixyPY6E/MWXwBdrmwMYuW8BQAT
 oRkG5HcdOw0iLYgo=
X-Received: by 2002:a2e:8609:0:b0:2b7:15d:24 with SMTP id
 a9-20020a2e8609000000b002b7015d0024mr1957711lji.41.1691588864052; 
 Wed, 09 Aug 2023 06:47:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFT9CrAgxqb8xzR/majllOm/tmG+HsFy50mZZz+xL1i00qxP7KxW3cSnypbB8hx6NtcGQC5Q==
X-Received: by 2002:a2e:8609:0:b0:2b7:15d:24 with SMTP id
 a9-20020a2e8609000000b002b7015d0024mr1957696lji.41.1691588863700; 
 Wed, 09 Aug 2023 06:47:43 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 h11-20020a170906854b00b0099cb1a2cab0sm6652162ejy.28.2023.08.09.06.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 06:47:43 -0700 (PDT)
Date: Wed, 9 Aug 2023 15:47:42 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Wen, Qian" <qian.wen@intel.com>
Cc: qemu-devel@nongnu.org, xiaoyao.li@intel.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, babu.moger@amd.com
Subject: Re: [PATCH v2] target/i386: Avoid cpu number overflow in legacy
 topology
Message-ID: <20230809154742.494c3697@imammedo.users.ipa.redhat.com>
In-Reply-To: <f1710cde-a3ce-6125-2608-c1ebcf4be581@intel.com>
References: <20230809102732.3124908-1-qian.wen@intel.com>
 <20230809131426.1d9f5821@imammedo.users.ipa.redhat.com>
 <f1710cde-a3ce-6125-2608-c1ebcf4be581@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 9 Aug 2023 21:20:48 +0800
"Wen, Qian" <qian.wen@intel.com> wrote:

> On 8/9/2023 7:14 PM, Igor Mammedov wrote:
> > On Wed,  9 Aug 2023 18:27:32 +0800
> > Qian Wen <qian.wen@intel.com> wrote:
> >  
> >> The legacy topology enumerated by CPUID.1.EBX[23:16] is defined in SDM
> >> Vol2:
> >>
> >> Bits 23-16: Maximum number of addressable IDs for logical processors in
> >> this physical package.
> >>
> >> When launching the VM with -smp 256, the value written to EBX[23:16] is
> >> 0 because of data overflow. If the guest only supports legacy topology,
> >> without V2 Extended Topology enumerated by CPUID.0x1f or Extended
> >> Topology enumerated by CPUID.0x0b to support over 255 CPUs, the return
> >> of the kernel invoking cpu_smt_allowed() is false and AP's bring-up will
> >> fail. Then only CPU 0 is online, and others are offline.
> >>
> >> To avoid this issue caused by overflow, limit the max value written to
> >> EBX[23:16] to 255.  
> > what happens on real hw or in lack of thereof what SDM says about this
> > value when there is more than 255 threads?.
> >  
> 
> Current SDM doesn't specify what the value should be when APIC IDs per package exceeds 255. So we asked the internal HW architect, the response is that EBX[23:16] will report 255 instead of being truncated to a smaller value.

then mention it in commit log so one wouldn't wonder where the value came from.

> 
> Thanks,
> Qian
> 
> >> Signed-off-by: Qian Wen <qian.wen@intel.com>
> >> ---
> >> Changes v1 -> v2:
> >>  - Revise the commit message and comment to more clearer.
> >>  - Rebased to v8.1.0-rc2.
> >> ---
> >>  target/i386/cpu.c | 16 ++++++++++++++--
> >>  1 file changed, 14 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> >> index 97ad229d8b..6e1d88fbd7 100644
> >> --- a/target/i386/cpu.c
> >> +++ b/target/i386/cpu.c
> >> @@ -6008,6 +6008,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >>      uint32_t die_offset;
> >>      uint32_t limit;
> >>      uint32_t signature[3];
> >> +    uint32_t threads_per_socket;
> >>      X86CPUTopoInfo topo_info;
> >>  
> >>      topo_info.dies_per_pkg = env->nr_dies;
> >> @@ -6049,8 +6050,19 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >>              *ecx |= CPUID_EXT_OSXSAVE;
> >>          }
> >>          *edx = env->features[FEAT_1_EDX];
> >> -        if (cs->nr_cores * cs->nr_threads > 1) {
> >> -            *ebx |= (cs->nr_cores * cs->nr_threads) << 16;
> >> +        /*
> >> +         * Only bits [23:16] represent the maximum number of addressable
> >> +         * IDs for logical processors in this physical package.
> >> +         * When thread_per_socket > 255, it will 1) overwrite bits[31:24]
> >> +         * which is apic_id, 2) bits [23:16] get truncated.
> >> +         */
> >> +        threads_per_socket = cs->nr_cores * cs->nr_threads;
> >> +        if (threads_per_socket > 255) {
> >> +            threads_per_socket = 255;
> >> +        }
> >> +
> >> +        if (threads_per_socket > 1) {

> >> +            *ebx |= threads_per_socket << 16;
                          ^^^^^^^^^^^^^^^^^^^^^^^^^
more robust would be mask out non-relevant fields at rhs 

also perhaps double check if we could do induce similar overflow
tweaking other -smp properties (todo for another patch[es] if there are such places).

> >>              *edx |= CPUID_HT;
> >>          }
> >>          if (!cpu->enable_pmu) {  


