Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C99776DB28
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 01:01:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRKpa-0008H7-R4; Wed, 02 Aug 2023 19:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qRKpX-0008BS-Qs
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 19:00:37 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qRKpV-0000hV-SB
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 19:00:35 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-686d8c8fc65so265640b3a.0
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 16:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691017232; x=1691622032;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WJnNH7WPlbwS2WClazkQnfqZCkMxIFmtb2LvCA2s5hY=;
 b=PRZiS5O8wBcvvUzqrOvMaeZ5T5OZh46aUekP+3vLtexyWIPeY3PMmAXL1qammA5ns3
 ef4yQcyLaDxmyAFlxciDobRB7RXjrBgBHl5JamD0X18Sghu+7oVi9KZkcniq+QNJqvHO
 mem/xL+Ir845sbxCDDk47TYrwXQz/FVGhC/xrcGogaXPzgmKu+65IIVs0GsL/3LhA3wa
 PYCzFCmQP66Fugr/Zg5N1mgkBeATJPb56JLNu8tLT4GLS0nScwfLKZAGsCLEehAZOvmW
 Q3+kpyL3DA2XBjkGXljrZXUXUpPsgXkKE+bHlttcLS7ofJrU7VXfpBgJZNWrZlNDe0eg
 F0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691017232; x=1691622032;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WJnNH7WPlbwS2WClazkQnfqZCkMxIFmtb2LvCA2s5hY=;
 b=G15T+xPz0wZykK/elsju0ze2eOAFFa2y19uo8O3NoZhexZEKHQ0rLy65p1xeV0V46I
 puOR0LpschGkA4dWVEpzwLo6AWnUJAfCgk7Qhz6+KhTz91jgHpvPL3X0Udh37Bl+6wav
 8SnLxUAip3zlIL2wm2gIMEvlKBz1z9oj9k3vEIAZXGs4E8UUEKiI2HOvXbCIZeU3OWAj
 5WAjCk8MhEn6ZbfZqqPRHnszf1vqVCplpC0zVsgsfbO5cNu8v7qWM69Run7wGMtG3Mf8
 zMlgME6RQcqpVbDDFp61NAhG6j0f5mHCbVpi5U/FzkV1hPL0v3ggyGtREyjMzBTMqLG+
 RSAQ==
X-Gm-Message-State: ABy/qLbe7sIMGo8P5/15N6V/oA+U1T0qZN6z9HsJpRuPncomLcucbZo/
 HaOae5HnkHPkolV9lZoF1D0=
X-Google-Smtp-Source: APBJJlHayr7+GgVEbAQkj1il9BK+TyTIl/mdfB4GgsJzblb3tZ5qdjU+FPXKHwje4fqyzjGJDBDQBg==
X-Received: by 2002:a05:6a00:16c1:b0:67e:e019:3a28 with SMTP id
 l1-20020a056a0016c100b0067ee0193a28mr18795785pfc.16.1691017232330; 
 Wed, 02 Aug 2023 16:00:32 -0700 (PDT)
Received: from localhost ([192.55.55.51]) by smtp.gmail.com with ESMTPSA id
 g3-20020aa78743000000b0068725ff9befsm7372004pfo.207.2023.08.02.16.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 16:00:31 -0700 (PDT)
Date: Wed, 2 Aug 2023 16:00:30 -0700
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
Subject: Re: [RFC PATCH 06/19] i386/pc: Drop pc_machine_kvm_type()
Message-ID: <20230802230030.GF1807130@ls.amr.corp.intel.com>
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
 <20230731162201.271114-7-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230731162201.271114-7-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=isaku.yamahata@gmail.com; helo=mail-pf1-x433.google.com
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

On Mon, Jul 31, 2023 at 12:21:48PM -0400,
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> pc_machine_kvm_type() was introduced by commit e21be724eaf5 ("i386/xen:
> add pc_machine_kvm_type to initialize XEN_EMULATE mode") to do Xen
> specific initialization by utilizing kvm_type method.
> 
> commit eeedfe6c6316 ("hw/xen: Simplify emulated Xen platform init")
> moves the Xen specific initialization to pc_basic_device_init().
> 
> There is no need to keep the PC specific kvm_type() implementation
> anymore. On the other hand, later patch will implement kvm_type()
> method for all x86/i386 machines to support KVM_X86_SW_PROTECTED_VM.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  hw/i386/pc.c         | 5 -----
>  include/hw/i386/pc.h | 3 ---
>  2 files changed, 8 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 3109d5e0e035..abeadd903827 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1794,11 +1794,6 @@ static void pc_machine_initfn(Object *obj)
>      cxl_machine_init(obj, &pcms->cxl_devices_state);
>  }
>  
> -int pc_machine_kvm_type(MachineState *machine, const char *kvm_type)
> -{
> -    return 0;
> -}
> -
>  static void pc_machine_reset(MachineState *machine, ShutdownCause reason)
>  {
>      CPUState *cs;
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index d54e8b1101e4..c98d628a76f3 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -296,15 +296,12 @@ extern const size_t pc_compat_1_5_len;
>  extern GlobalProperty pc_compat_1_4[];
>  extern const size_t pc_compat_1_4_len;
>  
> -int pc_machine_kvm_type(MachineState *machine, const char *vm_type);
> -
>  #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
>      static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *data) \
>      { \
>          MachineClass *mc = MACHINE_CLASS(oc); \
>          optsfn(mc); \
>          mc->init = initfn; \
> -        mc->kvm_type = pc_machine_kvm_type; \
>      } \
>      static const TypeInfo pc_machine_type_##suffix = { \
>          .name       = namestr TYPE_MACHINE_SUFFIX, \
> -- 
> 2.34.1
> 

It seems strange for MachineClass to have kvm_type(). Probably AccelClass.
(struct KVMAccelClass?)

Anyway this is independent clean up.

Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
-- 
Isaku Yamahata <isaku.yamahata@gmail.com>

