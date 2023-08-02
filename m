Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF12D76DACF
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 00:28:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRKK3-00032S-LH; Wed, 02 Aug 2023 18:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qRKK1-00032E-5w
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 18:28:01 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qRKJz-0007u0-Ma
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 18:28:00 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bba54f7eefso9851825ad.1
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 15:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691015278; x=1691620078;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=diAn+FKr0zNwv+Q0FyEJsNfox3GjhgMx9VJ8FYcl68k=;
 b=b+4GnyMp4cySJ8LvGAQJAvfv+x8FmX9W+RN3TYE/+lDoM8ZbQZtEVrJwzKqO693s3r
 kqHixRM1hPLcOFMGlH6id60RvuwrGl3C8xbOAU6i5Vmgg8LCDKytjhePJaN8emz2Nl6b
 F8gOt0YtqFkuhe5M+j4p9xL14jtzsj1weHHel8P7kZlrNODd92BzKM0JN8Vpk8kVl4wH
 emZMi4GD7tB3uMPWPZZZP0qj3iPpdPEHWdxH8mJquMsiyTL/eauEEa5y45HWv7/hh2Ti
 6kMV67ynWsH3uDI13UrZQasodF9f+u6cQs84ZQEUW5cAxzQGM0enukMIhS98nHdgBzee
 MOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691015278; x=1691620078;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=diAn+FKr0zNwv+Q0FyEJsNfox3GjhgMx9VJ8FYcl68k=;
 b=NKHQGuVQkCzZtlztSlbsLWrivBH2p3HgP1EzFCSd3YvT8+qTtx4EEsqQxgvalZVYRH
 7fYNBLScKcLn551sMLB1hWUfPbG7z8xLbiFPofkT9Fph3D123l8B0xu8h/2/wjlbbxXm
 CnTTpGUCy+Zv99qsirSfhZ1+OWGuEtKKUZcyma9rGTU9sAIGd/tF8TC5CcZwwgNTSOVf
 LZFTrKHaVOIAN5Kt0xEbvpPYQ7giKsTZ6CWbA/TiGhfbhg3UFTY/b+Kt7Fgguyzpm4CE
 xMnsNaFM3jNKj24Xn5A5ufR5i4mYpkolrNJCAF2TEiCHlErJMNvDP17JVMgor//czcDW
 iZOQ==
X-Gm-Message-State: ABy/qLZvHQFXsVJGwAeKHwWbxSvjqrfXjt/hw6edZUGZWPfy0MDG0iRt
 +YVem030I7E09UOTIOhmBcY=
X-Google-Smtp-Source: APBJJlFJk2qUGcY8yfvQufY0guAPyuz7ZM1+yh+At2xeYTF+hZtFPVyavvUs2veqwUXF9r/gwWqMug==
X-Received: by 2002:a17:902:e5c5:b0:1b2:676d:1143 with SMTP id
 u5-20020a170902e5c500b001b2676d1143mr23438318plf.15.1691015278245; 
 Wed, 02 Aug 2023 15:27:58 -0700 (PDT)
Received: from localhost ([192.55.55.51]) by smtp.gmail.com with ESMTPSA id
 z18-20020a170903019200b001bba7aab838sm12891445plg.162.2023.08.02.15.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 15:27:57 -0700 (PDT)
Date: Wed, 2 Aug 2023 15:27:56 -0700
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
Subject: Re: [RFC PATCH 19/19] i386: Disable SMM mode for X86_SW_PROTECTED_VM
Message-ID: <20230802222756.GD1807130@ls.amr.corp.intel.com>
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
 <20230731162201.271114-20-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230731162201.271114-20-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=isaku.yamahata@gmail.com; helo=mail-pl1-x630.google.com
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

On Mon, Jul 31, 2023 at 12:22:01PM -0400,
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/kvm/kvm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index a96640512dbc..62f237068a3a 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -2654,6 +2654,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>  
>      if (x86ms->vm_type == KVM_X86_SW_PROTECTED_VM) {
>          memory_listener_register(&kvm_x86_sw_protected_vm_memory_listener, &address_space_memory);
> +
> +        if (x86ms->smm == ON_OFF_AUTO_AUTO) {
> +            x86ms->smm = ON_OFF_AUTO_OFF;
> +        } else if (x86ms->smm == ON_OFF_AUTO_ON) {
> +            error_report("X86_SW_PROTECTED_VM doesn't support SMM");
> +            return -EINVAL;
> +        }
>      }
>  

If we use confidential guest support, this check should go to there.
-- 
Isaku Yamahata <isaku.yamahata@gmail.com>

