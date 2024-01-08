Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3288827AD4
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 23:48:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMyPW-0005oE-9X; Mon, 08 Jan 2024 17:47:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rMyPT-0005nz-Lv
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 17:47:56 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rMyPR-0007vR-38
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 17:47:55 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-55753dc5cf0so2774040a12.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 14:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704754069; x=1705358869; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nU5iUIUz5AvAKHcKU1Jgq94VzySO/q5wQJDD8hZswmM=;
 b=H45IhwbhdyLiO6Cv5PukxaYD5QQYQEyEL9e9lP4Wz9T6/IU+dhftU24VrEC1RHDnqM
 NBhTwoetYGOkwkd8dyaEsIRaSI7VNMZOjefLDhg4njeUvKvQH7OpX5TrlbWiuuCYPNLa
 qRHNuW9Rpc8WPleZljCf5Yze84gzv544MmmoNdQtlJF1DempTMf52ZfoX2Rb2LptjowS
 t2qq6cXMt0Fx0GbncBhKNSqyZS62ZfK+n0myYJhDe4CKEQlMjLLi0YtKlmCb8MnedAtY
 vj067sYQzlC1LvAvuNk+I8hI5yXy6S3POT6xurQSURDsHVvsGcTaB9962x6q2+gkl4Ga
 8XJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704754069; x=1705358869;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nU5iUIUz5AvAKHcKU1Jgq94VzySO/q5wQJDD8hZswmM=;
 b=k/+65HhmBLSuoRp5Y95g5EJSfeHTrFkCm2hat/YL/3w03y782u25emeVwvO9fzBw1V
 k/T2ta7YzLwCuCBjxoF9fjDcKE8XId0hyM9W6n4F53w09F5pxOSXVez4QJbPjufdBqD/
 TjyzGck6Pqyuxv4P+QQvU1T8iarxqziM1kYzOR64TzalRsMrKCVTUdjnzYjrdbWfdveQ
 +zFqrKVEwhClqhQwcyK3ksloxXH/Rhf4WFLtKVYjC188AEr5Jb34oPXVuH8L9yJQ7e0B
 pfJs4KtP1d4DCwDm6cK31unb/wsSCdx7PhaCnTSL2FTnTfGIY6xYvIHc9qxlqkNQatYz
 txcg==
X-Gm-Message-State: AOJu0YzdKHN4hkyFGgWzGlBwvjamYAP+QjltYbyYhpigjVSbrijPswj6
 issvKo4zn6cwX86PXScXID6SwRXwQe4lyTRnsRwf+TTtvq6TUw==
X-Google-Smtp-Source: AGHT+IHxjyzHsgvVkrQ/nH+HF/FWxC5IUrrAwOyyY+znamR0WhvZKfmd11bHaKCdubV6+fL09EqQLpW1nNqhpdo6EgA=
X-Received: by 2002:aa7:c601:0:b0:554:1af:fe19 with SMTP id
 h1-20020aa7c601000000b0055401affe19mr2499884edq.71.1704754068840; Mon, 08 Jan
 2024 14:47:48 -0800 (PST)
MIME-Version: 1.0
References: <20240101075315.43167-1-horenchuang@bytedance.com>
 <20240101075315.43167-2-horenchuang@bytedance.com>
 <ZZXX95yvk/WTIBT/@memverge.com>
 <CAAYibXjZ0HSCqMrzXGv62cMLncS_81R3e1uNV5Fu4CPm0zAtYw@mail.gmail.com>
 <ZZwtmiucNXxmrZ7S@memverge.com>
In-Reply-To: <ZZwtmiucNXxmrZ7S@memverge.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Mon, 8 Jan 2024 14:47:37 -0800
Message-ID: <CAAYibXhfUu8dMwvBmWz4P6N9-yLao0QwAFozk4rS_0GPsEZd7Q@mail.gmail.com>
Subject: Re: [External] Re: [QEMU-devel][RFC PATCH 1/1] backends/hostmem:
 qapi/qom: Add an ObjectOption for memory-backend-* called HostMemType and its
 arg 'cxlram'
To: Gregory Price <gregory.price@memverge.com>
Cc: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ben Widawsky <ben.widawsky@intel.com>, 
 Gregory Price <gourry.memverge@gmail.com>, Fan Ni <fan.ni@samsung.com>, 
 Ira Weiny <ira.weiny@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org, 
 "Ho-Ren (Jack) Chuang" <horenc@vt.edu>, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Jan 8, 2024 at 9:15=E2=80=AFAM Gregory Price <gregory.price@memverg=
e.com> wrote:
>
> On Fri, Jan 05, 2024 at 09:59:19PM -0800, Hao Xiang wrote:
> > On Wed, Jan 3, 2024 at 1:56=E2=80=AFPM Gregory Price <gregory.price@mem=
verge.com> wrote:
> > >
> > > For a variety of performance reasons, this will not work the way you
> > > want it to.  You are essentially telling QEMU to map the vmem0 into a
> > > virtual cxl device, and now any memory accesses to that memory region
> > > will end up going through the cxl-type3 device logic - which is an IO
> > > path from the perspective of QEMU.
> >
> > I didn't understand exactly how the virtual cxl-type3 device works. I
> > thought it would go with the same "guest virtual address ->  guest
> > physical address -> host physical address" translation totally done by
> > CPU. But if it is going through an emulation path handled by virtual
> > cxl-type3, I agree the performance would be bad. Do you know why
> > accessing memory on a virtual cxl-type3 device can't go with the
> > nested page table translation?
> >
>
> Because a byte-access on CXL memory can have checks on it that must be
> emulated by the virtual device, and because there are caching
> implications that have to be emulated as well.

Interesting. Now that I see the cxl_type3_read/cxl_type3_write. If the
CXL memory data path goes through them, the performance would be
pretty problematic. We have actually run Intel's Memory Latency
Checker benchmark from inside a guest VM with both system-DRAM and
virtual CXL-type3 configured. The idle latency on the virtual CXL
memory is 2X of system DRAM, which is on-par with the benchmark
running from a physical host. I need to debug this more to understand
why the latency is actually much better than I would expect now.

>
> The cxl device you are using is an emulated CXL device - not a
> virtualization interface.  Nuanced difference:  the emulated device has
> to emulate *everything* that CXL device does.
>
> What you want is passthrough / managed access to a real device -
> virtualization.  This is not the way to accomplish that.  A better way
> to accomplish that is to simply pass the memory through as a static numa
> node as I described.

That would work, too. But I think a kernel change is required to
establish the correct memory tiering if we go this routine.

>
> >
> > When we had a discussion with Intel, they told us to not use the KVM
> > option in QEMU while using virtual cxl type3 device. That's probably
> > related to the issue you described here? We enabled KVM though but
> > haven't seen the crash yet.
> >
>
> The crash really only happens, IIRC, if code ends up hosted in that
> memory.  I forget the exact scenario, but the working theory is it has
> to do with the way instruction caches are managed with KVM and this
> device.
>
> > >
> > > You're better off just using the `host-nodes` field of host-memory
> > > and passing bandwidth/latency attributes though via `-numa hmat-lb`
> >
> > We tried this but it doesn't work from end to end right now. I
> > described the issue in another fork of this thread.
> >
> > >
> > > In that scenario, the guest software doesn't even need to know CXL
> > > exists at all, it can just read the attributes of the numa node
> > > that QEMU created for it.
> >
> > We thought about this before. But the current kernel implementation
> > requires a devdax device to be probed and recognized as a slow tier
> > (by reading the memory attributes). I don't think this can be done via
> > the path you described. Have you tried this before?
> >
>
> Right, because the memory tiering component lumps the nodes together.
>
> Better idea:  Fix the memory tiering component
>
> I cc'd you on another patch line that is discussing something relevant
> to this.
>
> https://lore.kernel.org/linux-mm/87fs00njft.fsf@yhuang6-desk2.ccr.corp.in=
tel.com/T/#m32d58f8cc607aec942995994a41b17ff711519c8
>
> The point is: There's no need for this to be a dax device at all, there
> is no need for the guest to even know what is providing the memory, or
> for the guest to have any management access to the memory.  It just
> wants the memory and the ability to tier it.
>
> So we should fix the memory tiering component to work with this
> workflow.

Agreed. We really don't need the devdax device at all. I thought that
choice was made due to the memory tiering concept being started with
pmem ... Let's continue this part of the discussion on the above
thread.

>
> ~Gregory

