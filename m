Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A60E76DB04
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 00:53:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRKic-0004hI-A8; Wed, 02 Aug 2023 18:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qRKia-0004eI-HW
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 18:53:24 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qRKiY-0003hv-ML
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 18:53:24 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bc02bd4eafso3626625ad.1
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 15:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691016801; x=1691621601;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+rWczut5E+c7+k9ca3L6xWg9snmsSn9OBlNNsSEH6Y4=;
 b=MIlrxKBHC0TNDZsfAeLiVDU4zHyn67wCDnYvBy7zfmtLny8BbGZO0y5b/KYbfy5V3J
 XJf+z7EAd7DXeNGHU+MXrr12bAqG+Xu+lKQ2Ker8z53PXOUksp4ZR4QGJG4sPzuHlaT9
 tZr1XaEI+PdtlDnpHwYm5F2jeQdUwXgqm3zSxLJPf0bZzVacUDl7VtWokGgV6/y77VwQ
 4kQFyIzbf/I49qdHsJlLii2JyBVUrUSrgluivMZqxLXVpIAyoUwNl+P8937emXDVfR1M
 3edI/npOTpAxvLd2K6zcHWfXSAaEpvoRIovuv1ENJMP/i/QLXkYbUPxlz4b41KV+3FVR
 eHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691016801; x=1691621601;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+rWczut5E+c7+k9ca3L6xWg9snmsSn9OBlNNsSEH6Y4=;
 b=VSmrsFcPLB4mNZFQz7n6zTw5ev/jf35FZXaCHkUMGeNkX4y0V++gve9tVm/qJR7es5
 rYRbv/cYESgm86Nld4H5lFOHSjGoWOPislnXT06pA1bdJ6maRTASoCzph6ve9gUpP8Eb
 q/1j3aTFS2meA9Ks0LHgUmkjE/hOKV4dYkSiMbbsMqxo3EZvJv+5KHyc2A9KAMUwHPd7
 X/TAs7Ipcjk+H5hLoYpIiz7VlhcFz8Oly9F8gfYU4jwE4kUfN9NbFt7YY894GVKdwwzP
 Wzk4TuJ8Xw+/7QsBpT78u4L1PzhG6hUXCRkkv+25KMMLEQhlzlVghCVBBK643zZNWd/c
 pNbA==
X-Gm-Message-State: ABy/qLZ+jeTxxSJYpy8fIs2gG3EdAnY72U4YafzslcNyZF6itJ3wYc+L
 mp8Zp72uWZMPdTiKMxPpHw0=
X-Google-Smtp-Source: APBJJlFWJWv7Q/ttPBQ+d4tEcYgX+BEoNN8e2Kkay8S7mNyJkvLSzVCdME6KV6v8TRydMaqFNn/MNQ==
X-Received: by 2002:a17:902:8697:b0:1b5:219a:cbbd with SMTP id
 g23-20020a170902869700b001b5219acbbdmr13697862plo.3.1691016800740; 
 Wed, 02 Aug 2023 15:53:20 -0700 (PDT)
Received: from localhost ([192.55.55.51]) by smtp.gmail.com with ESMTPSA id
 w5-20020a1709029a8500b001b03cda6389sm12938265plp.10.2023.08.02.15.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 15:53:20 -0700 (PDT)
Date: Wed, 2 Aug 2023 15:53:18 -0700
From: Isaku Yamahata <isaku.yamahata@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC PATCH 08/19] HostMem: Add private property to indicate to
 use kvm gmem
Message-ID: <20230802225318.GE1807130@ls.amr.corp.intel.com>
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
 <20230731162201.271114-9-xiaoyao.li@intel.com>
 <f8e40f1a-729b-f520-299a-4132e371be61@redhat.com>
 <2addfff0-88bf-59aa-f2f3-8129366a006d@intel.com>
 <a154c33d-b24d-b713-0dc0-027d54f2340f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a154c33d-b24d-b713-0dc0-027d54f2340f@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=isaku.yamahata@gmail.com; helo=mail-pl1-x62a.google.com
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

On Wed, Aug 02, 2023 at 04:14:29PM +0200,
David Hildenbrand <david@redhat.com> wrote:

> On 02.08.23 10:03, Xiaoyao Li wrote:
> > On 8/2/2023 1:21 AM, David Hildenbrand wrote:
> > > On 31.07.23 18:21, Xiaoyao Li wrote:
> > > > From: Isaku Yamahata <isaku.yamahata@intel.com>
> > > > 
> > > > Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> > > > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > > ---
> > > >    backends/hostmem.c       | 18 ++++++++++++++++++
> > > >    include/sysemu/hostmem.h |  2 +-
> > > >    qapi/qom.json            |  4 ++++
> > > >    3 files changed, 23 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/backends/hostmem.c b/backends/hostmem.c
> > > > index 747e7838c031..dbdbb0aafd45 100644
> > > > --- a/backends/hostmem.c
> > > > +++ b/backends/hostmem.c
> > > > @@ -461,6 +461,20 @@ static void
> > > > host_memory_backend_set_reserve(Object *o, bool value, Error **errp)
> > > >        }
> > > >        backend->reserve = value;
> > > >    }
> > > > +
> > > > +static bool host_memory_backend_get_private(Object *o, Error **errp)
> > > > +{
> > > > +    HostMemoryBackend *backend = MEMORY_BACKEND(o);
> > > > +
> > > > +    return backend->private;
> > > > +}
> > > > +
> > > > +static void host_memory_backend_set_private(Object *o, bool value,
> > > > Error **errp)
> > > > +{
> > > > +    HostMemoryBackend *backend = MEMORY_BACKEND(o);
> > > > +
> > > > +    backend->private = value;
> > > > +}
> > > >    #endif /* CONFIG_LINUX */
> > > >    static bool
> > > > @@ -541,6 +555,10 @@ host_memory_backend_class_init(ObjectClass *oc,
> > > > void *data)
> > > >            host_memory_backend_get_reserve,
> > > > host_memory_backend_set_reserve);
> > > >        object_class_property_set_description(oc, "reserve",
> > > >            "Reserve swap space (or huge pages) if applicable");
> > > > +    object_class_property_add_bool(oc, "private",
> > > > +        host_memory_backend_get_private,
> > > > host_memory_backend_set_private);
> > > > +    object_class_property_set_description(oc, "private",
> > > > +        "Use KVM gmem private memory");
> > > >    #endif /* CONFIG_LINUX */
> > > >        /*
> > > >         * Do not delete/rename option. This option must be considered
> > > > stable
> > > > diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
> > > > index 39326f1d4f9c..d88970395618 100644
> > > > --- a/include/sysemu/hostmem.h
> > > > +++ b/include/sysemu/hostmem.h
> > > > @@ -65,7 +65,7 @@ struct HostMemoryBackend {
> > > >        /* protected */
> > > >        uint64_t size;
> > > >        bool merge, dump, use_canonical_path;
> > > > -    bool prealloc, is_mapped, share, reserve;
> > > > +    bool prealloc, is_mapped, share, reserve, private;
> > > >        uint32_t prealloc_threads;
> > > >        ThreadContext *prealloc_context;
> > > >        DECLARE_BITMAP(host_nodes, MAX_NODES + 1);
> > > > diff --git a/qapi/qom.json b/qapi/qom.json
> > > > index 7f92ea43e8e1..e0b2044e3d20 100644
> > > > --- a/qapi/qom.json
> > > > +++ b/qapi/qom.json
> > > > @@ -605,6 +605,9 @@
> > > >    # @reserve: if true, reserve swap space (or huge pages) if applicable
> > > >    #     (default: true) (since 6.1)
> > > >    #
> > > > +# @private: if true, use KVM gmem private memory
> > > > +#           (default: false) (since 8.1)
> > > > +#
> > > 
> > > But that's not what any of this does.
> > > 
> > > This patch only adds a property and doesn't even explain what it intends
> > > to achieve with that.
> > > 
> > > How will it be used from a user? What will it affect internally? What
> > > will it modify in regards of the memory backend?
> > 
> > How it will be used is in the next patch, patch 09.
> > 
> > for kvm_x86_sw_protected_vm type VM, it will allocate private gmem with
> > KVM ioctl if the memory backend has property "private" on.
> 
> It feels wired up the wrong way.
> 
> When creating/initializing the memory backend, we should also take care of
> allocating the gmem_fd, for example, by doing some gmem allocation callback,
> ideally *internally* creating the RAM memory region / RAMBlock.
> 
> And we should fail if that is impossible (gmem does not apply to the VM) or
> creating the gmem_fd failed for other reason.
> 
> Like passing a RAM_GMEM flag to memory_region_init_ram_flags_nomigrate() in
> ram_backend_memory_alloc(), to then handle it internally, failing if there
> is an error.

KVM gmem is tied to VM. not before creating VM. We have to delay of the
allocation of kvm gmem until VM initialization.

Hmm, one options is to move gmem_fd from RAMBlock to KVMSlot.  Handle the
allocation of KVM gmem (issuing KVM gmem ioctl) there. i.e. in
kvm_set_phys_mem() or kvm_region_add() (or whatever functions of KVM memory
listener).  Maybe we can drop ram_block_convert_range() and can have KVM
specific logic instead.

We still need a way for user to specify which guest memory region is subject
to KVM gmem, though.
-- 
Isaku Yamahata <isaku.yamahata@gmail.com>

