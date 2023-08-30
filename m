Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE58078D7B4
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 18:56:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbOTF-0007Rl-5J; Wed, 30 Aug 2023 12:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qbOTD-0007RQ-8m
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:55:07 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qbOTA-0004rF-FR
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:55:06 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bdb7b0c8afso36372535ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693414502; x=1694019302; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=K0kNasBWHXDxag6PfFG1PPRe3KwHHljqTxvWTjzCMWw=;
 b=RRuwYcaCZZxjfZ61M7NKkWzpmZ5bJT9/2IRzRoCRDkSKovVe33vBwLeaceC1gndgjk
 zkKizZAWYX6+ECfSE/Lrc+OLBG0feWjGibUmRi0cNNJo6o/0yBQXhc3KaZV6yps+jmMl
 CGa3O0uGznI6ajwv/ccTQmATNYHJp3nP+JKwreU9YtH3/PHRNY2ODJPaynHJldOSc9au
 EmA/h8k3ku58Fta2znhFJO4LH30XV/DYXlxcer6S2MluJ+6lPFBKZ0jniw3wRAZGHdLD
 +9lYy0d3uBdr8LCLR3Lyz+k3+uHy4jj5RUa4NHREkuI0VLcygv4N1Lt31/goRHJcNOH0
 1IPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693414502; x=1694019302;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K0kNasBWHXDxag6PfFG1PPRe3KwHHljqTxvWTjzCMWw=;
 b=Sm0ezC7vkXNtxe3GMSDVZfYoGoagZn8hyvTUtt//IHjYRLTH1pd/cjnDBGBi/iE7p5
 epUZIV7Y0N3Iohg8cIzoroXhE0ce4A5IaTWkJ37VHmp4yG57eSY2RIPe6BRsvNcAg+C6
 ruO7RByzlP8DfxjCSkssCuvqMj2NptrbY0SJZpEapPpcPyzzE36yY7tKqg0WLoj368z3
 f6mmYO8nRhtj4xkICTIVthHqJep5VUC2W831crEss3z+JO9c4T2/0giLtisKrrno0VyX
 mSI9WmjTZTAAYeqE/nzHrW46bte9OlRNQlB3kbo7PbYfL/KaJnHKNilwtayafpvhPj8p
 81Ig==
X-Gm-Message-State: AOJu0YyDhB/EG929vxTKl4XVaY5uWXAecr4svJeEYG4ocME3SQgDFayA
 DygE4fDK543lHmPLNRbDFok=
X-Google-Smtp-Source: AGHT+IEY7YnkM6ikGI3bE4Jy6dgMQCVAbQv/5XNLLtG2muVIw6W6RFGP1GjEFkMCrNNM1OIieqmO9Q==
X-Received: by 2002:a17:902:e80f:b0:1c1:fbec:bc1c with SMTP id
 u15-20020a170902e80f00b001c1fbecbc1cmr3160197plg.42.1693414502173; 
 Wed, 30 Aug 2023 09:55:02 -0700 (PDT)
Received: from localhost ([192.55.55.51]) by smtp.gmail.com with ESMTPSA id
 v11-20020a170902d68b00b001bba1475c92sm11237866ply.113.2023.08.30.09.55.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 09:55:01 -0700 (PDT)
Date: Wed, 30 Aug 2023 09:54:54 -0700
From: Isaku Yamahata <isaku.yamahata@gmail.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Eduardo Habkost <eduardo@habkost.net>,
 Laszlo Ersek <lersek@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>, erdemaktas@google.com,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v2 13/58] kvm: Introduce kvm_arch_pre_create_vcpu()
Message-ID: <20230830165454.GB3638268@ls.amr.corp.intel.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-14-xiaoyao.li@intel.com>
 <5bfefa59-6e1e-dcfd-a2a6-e49a0b71fded@linaro.org>
 <6ea095cd-db21-c95a-b518-2d97b6098281@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ea095cd-db21-c95a-b518-2d97b6098281@intel.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=isaku.yamahata@gmail.com; helo=mail-pl1-x629.google.com
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Aug 30, 2023 at 09:45:58AM +0800,
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> On 8/29/2023 10:40 PM, Philippe Mathieu-Daudé wrote:
> > On 18/8/23 11:49, Xiaoyao Li wrote:
> > > Introduce kvm_arch_pre_create_vcpu(), to perform arch-dependent
> > > work prior to create any vcpu. This is for i386 TDX because it needs
> > > call TDX_INIT_VM before creating any vcpu.
> > > 
> > > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> > > ---
> > >   accel/kvm/kvm-all.c  | 12 ++++++++++++
> > >   include/sysemu/kvm.h |  1 +
> > >   2 files changed, 13 insertions(+)
> > > 
> > > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > > index c9f3aab5e587..5071af917ae0 100644
> > > --- a/accel/kvm/kvm-all.c
> > > +++ b/accel/kvm/kvm-all.c
> > > @@ -422,6 +422,11 @@ static int kvm_get_vcpu(KVMState *s, unsigned
> > > long vcpu_id)
> > >       return kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
> > >   }
> > > +int __attribute__ ((weak)) kvm_arch_pre_create_vcpu(CPUState *cpu)
> > > +{
> > > +    return 0;
> > > +}
> > 
> > kvm_arch_init_vcpu() is implemented for each arch. Why not use the
> > same approach here?
> 
> Because only x86 needs it currently, for TDX. Other arches don't require an
> implementation.
> 
> If don't provide the _weak_ function, it needs to implement the empty
> function (justing return 0) in all the other arches just as the placeholder.
> If QEMU community prefers this approach, I can change to it in next version.

Alternative is to move the hook to x86 specific function, not common kvm
function. With my quick grepping, x86_cpus_init() or x86_cpu_realizefn().
-- 
Isaku Yamahata <isaku.yamahata@linux.intel.com>

