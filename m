Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF7FA1A816
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Jan 2025 17:48:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb0Md-0000Ga-K1; Thu, 23 Jan 2025 11:47:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tb0Mb-0000Bx-Mw
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 11:47:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tb0MX-0007K1-FJ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 11:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737650843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+x2h8ERaFW8p89LuZnTutbaxdGV9s6TZW3q0FaXNER0=;
 b=a3v3JM0BUoAEoN2+HZRZMoLRj9Br0+FmufHC6B0dkJZyv6+VQIZYcuJutvtBbHl3ft/F3D
 VHun/3KYaPPFTRtMNgvaeG3HTuPdF7mMzw6LC0NnNKbgQCA4elOQBXT4E59FqA2xaei6PQ
 aXEbMtI6kuMTlyUavqMeBg1/y45H8Z8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-2ZVqn36SNuWMQLVOrZED9g-1; Thu, 23 Jan 2025 11:47:22 -0500
X-MC-Unique: 2ZVqn36SNuWMQLVOrZED9g-1
X-Mimecast-MFC-AGG-ID: 2ZVqn36SNuWMQLVOrZED9g
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b6f943f59dso176151085a.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 08:47:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737650841; x=1738255641;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+x2h8ERaFW8p89LuZnTutbaxdGV9s6TZW3q0FaXNER0=;
 b=BT9VegmnaOeXGSAM/ET6+FM+9Aj3uoT/NFnEE/9MRp0rEEm819hNNgsTYZUJAh1c2K
 8rNJt3736VpRO9c2aX03Tps+RsCFlcFZhhG/rKNqwL+AEPum1+5Mb0KfK6Z5FZhC1iqg
 WnAATYyA2WGtmOHMJLAWyHidi6KduWMAMEpSlpi7yCQTt00CC1/0crhmI6VpUQUueBeF
 5AeByIxaU2PefSBHz2Zoh4lRRfUzqhDRzhHwqLdMJ74zQzb0lFxIUqnOj1VX8/3Ephhz
 IZBPVjiDpw1RqTSf53JRidM014WMkFXx0MzUKfa+REcIu184NrsvZ//t717gSpq0RO+R
 qpfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6p11bBW/TL3fa9uTzc3e8SGCcgFyd8BISWQ18JNPcKBgmblpg2hpkqWELOBzF9Zk4RJ38Jc4cDzvB@nongnu.org
X-Gm-Message-State: AOJu0YwqDmbmkUNFPpW/ERpjsyhFE97V2tMf/XXa3UQOgMNE143J+3l4
 Ego77kmP6SXUsR+Or2h/osSCMReMzP48RJgiPKYUvrOMqO412Fh5ZWkpXOtm5N8tWgKHQKJFVBH
 Ldamc6rpxGY5vremeFmrsto88hKtv71eqazsd/aJBLYY6UjmvPCf7
X-Gm-Gg: ASbGncvz18VL+zDHsLW/BStPdtb6BPVxS0O0P8rNV8ys5Lrs4gXgPdcyJoiqCOV0ORC
 sue+ozThaDoZrLUwP8XL+HoWcMeskTw3nm5Pn4z1iL582JVzn0AsoSZOmv+5Jbd15eok01W+X5H
 u9LpWkVadWUCyIMskHudZsoP3H5ojohtT0UpBq3KP4Z+oCRNVSuOYzpc6Suh1F9REj2b1blZRWx
 bDhyd+0s5Xz7HikDF7uYOD4I/4Y2ixe/DP6q0LJraQ6HukXxZBt+ZZjy2BAVLu3e+0JOxjVmTmp
 aoP0ghuxfSnbyYVRVroKSNdGXSMo4rg=
X-Received: by 2002:ac8:7d50:0:b0:466:9bc4:578 with SMTP id
 d75a77b69052e-46e12a5eacfmr325293311cf.22.1737650841416; 
 Thu, 23 Jan 2025 08:47:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZdgyatydQjnPIgqHbXi7K9pY0F2gta/w5TjMk6hnXXzDTtDY+5ejWIezOCpes/HsmGFvnXA==
X-Received: by 2002:ac8:7d50:0:b0:466:9bc4:578 with SMTP id
 d75a77b69052e-46e12a5eacfmr325292961cf.22.1737650840971; 
 Thu, 23 Jan 2025 08:47:20 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e66b67951sm559541cf.58.2025.01.23.08.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 08:47:20 -0800 (PST)
Date: Thu, 23 Jan 2025 11:47:17 -0500
From: Peter Xu <peterx@redhat.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 2/7] guest_memfd: Introduce an object to manage the
 guest-memfd with RamDiscardManager
Message-ID: <Z5Jylb73kDJ6HTEZ@x1n>
References: <2400268e-d26a-4933-80df-cfe44b38ae40@amd.com>
 <590432e1-4a26-4ae8-822f-ccfbac352e6b@intel.com>
 <2b2730f3-6e1a-4def-b126-078cf6249759@amd.com>
 <Z462F1Dwm6cUdCcy@x1n> <ZnmfUelBs3Cm0ZHd@yilunxu-OptiPlex-7050>
 <Z4-6u5_9NChu_KZq@x1n>
 <95a14f7d-4782-40b3-a55d-7cf67b911bbe@amd.com>
 <Z5C9SzXxX7M1DBE3@yilunxu-OptiPlex-7050> <Z5EgFaWIyjIiOZnv@x1n>
 <Z5INAQjxyYhwyc+1@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z5INAQjxyYhwyc+1@yilunxu-OptiPlex-7050>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Jan 23, 2025 at 05:33:53PM +0800, Xu Yilun wrote:
> On Wed, Jan 22, 2025 at 11:43:01AM -0500, Peter Xu wrote:
> > On Wed, Jan 22, 2025 at 05:41:31PM +0800, Xu Yilun wrote:
> > > On Wed, Jan 22, 2025 at 03:30:05PM +1100, Alexey Kardashevskiy wrote:
> > > > 
> > > > 
> > > > On 22/1/25 02:18, Peter Xu wrote:
> > > > > On Tue, Jun 25, 2024 at 12:31:13AM +0800, Xu Yilun wrote:
> > > > > > On Mon, Jan 20, 2025 at 03:46:15PM -0500, Peter Xu wrote:
> > > > > > > On Mon, Jan 20, 2025 at 09:22:50PM +1100, Alexey Kardashevskiy wrote:
> > > > > > > > > It is still uncertain how to implement the private MMIO. Our assumption
> > > > > > > > > is the private MMIO would also create a memory region with
> > > > > > > > > guest_memfd-like backend. Its mr->ram is true and should be managed by
> > > > > > > > > RamdDiscardManager which can skip doing DMA_MAP in VFIO's region_add
> > > > > > > > > listener.
> > > > > > > > 
> > > > > > > > My current working approach is to leave it as is in QEMU and VFIO.
> > > > > > > 
> > > > > > > Agreed.  Setting ram=true to even private MMIO sounds hackish, at least
> > > > > > 
> > > > > > The private MMIO refers to assigned MMIO, not emulated MMIO. IIUC,
> > > > > > normal assigned MMIO is always set ram=true,
> > > > > > 
> > > > > > void memory_region_init_ram_device_ptr(MemoryRegion *mr,
> > > > > >                                         Object *owner,
> > > > > >                                         const char *name,
> > > > > >                                         uint64_t size,
> > > > > >                                         void *ptr)
> > 
> > [1]
> > 
> > > > > > {
> > > > > >      memory_region_init(mr, owner, name, size);
> > > > > >      mr->ram = true;
> > > > > > 
> > > > > > 
> > > > > > So I don't think ram=true is a problem here.
> > > > > 
> > > > > I see.  If there's always a host pointer then it looks valid.  So it means
> > > > > the device private MMIOs are always mappable since the start?
> > > > 
> > > > Yes. VFIO owns the mapping and does not treat shared/private MMIO any
> > > > different at the moment. Thanks,
> > > 
> > > mm.. I'm actually expecting private MMIO not have a host pointer, just
> > > as private memory do.
> > > 
> > > But I'm not sure why having host pointer correlates mr->ram == true.
> > 
> > If there is no host pointer, what would you pass into "ptr" as referenced
> > at [1] above when creating the private MMIO memory region?
> 
> Sorry for confusion. I mean existing MMIO region use set mr->ram = true,
> and unmappable region (gmem) also set mr->ram = true. So don't know why
> mr->ram = true for private MMIO is hackish.

That's exactly what I had on the question in the previous email - please
have a look at what QEMU does right now with memory_access_is_direct().
I'm not 100% sure it'll work if the host pointer doesn't exist.

Let's take one user of it to be explicit: flatview_write_continue_step()
will try to access the ram pointer if it's direct:

    if (!memory_access_is_direct(mr, true)) {
        ...
    } else {
        /* RAM case */
        uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
                                               false, true);

        memmove(ram_ptr, buf, *l);
        invalidate_and_set_dirty(mr, mr_addr, *l);

        return MEMTX_OK;
    }

I don't see how QEMU could work yet if one MR set ram=true but without a
host pointer..

As discussed previously, IMHO it's okay that the pointer is not accessible,
but still I assume QEMU assumes the pointer at least existed for a ram=on
MR.  I don't know whether it's suitable to set ram=on if the pointer
doesn't ever exist.

> 
> I think We could add another helper to create memory region for private
> MMIO.
> 
> > 
> > OTOH, IIUC guest private memory finally can also have a host pointer (aka,
> > mmap()-able), it's just that even if it exists, accessing it may crash QEMU
> > if it's private.
> 
> Not sure if I get it correct: when memory will be converted to private, QEMU
> should firstly unmap the host ptr, which means host ptr doesn't alway exist.

At least current QEMU doesn't unmap it? 

kvm_convert_memory() does ram_block_discard_range() indeed, but that's hole
punches, not unmap.  So the host pointer can always be there.

Even if we could have in-place gmemfd conversions in the future for guest
mem, we should also need the host pointer to be around, in which case (per
my current understand) it will even avoid hole punching but instead make
the page accessible (by being able to be faulted in).

Thanks,

-- 
Peter Xu


