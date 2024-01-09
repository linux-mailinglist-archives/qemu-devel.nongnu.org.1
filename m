Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DAF827C5F
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 02:07:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN0ZB-00017j-1Z; Mon, 08 Jan 2024 20:06:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rN0Z6-00016s-DP
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 20:06:00 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rN0Yz-0000wx-MU
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 20:06:00 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-556c3f0d6c5so2837330a12.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 17:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704762349; x=1705367149; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JbxYJbZW9KV2XDbSQtg5ohtaQ371q9pSmjvMPciRPY0=;
 b=MjlFwjNMlRckfOvWNKb05pyeGCIHRFhFZoc5BxwjsrGY3haWQAoJo80kqqkT4fCXro
 +E4dy6FCSvfEJPL8sdKowxLbauPcv4aGNlDvtk8AlJKYNvZ7l/wiIy0jqskH9uGSzsqf
 LQpcWQ31w2KTIkesUbYIowRqEXDZ59wLLiwEpUNUrXKgA1Kxmra9RQ1cbFep/4o0CwJn
 9M+qc4qRbtZTiaEBVV4CnGqnVLKkBwRkPaXgESq+/OXNNfKjWhidbGP2tQzSB4upWMNr
 LPDqqX68CF7nMQ93gAW0Inr9UP6x6iL3L3cFEy4q5mBUAODr1hoGnm1rXHgOsVVdN2tg
 cxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704762349; x=1705367149;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JbxYJbZW9KV2XDbSQtg5ohtaQ371q9pSmjvMPciRPY0=;
 b=tpbu5ZEL3P5TXuBaE7KFZsR6WEw3WuM/XVpqDEOS3H6jHWbXqc2+F80p7xFCCfNpeQ
 DOhKGDoV/sI05RFNlpU5LGYRPEh2i5bIR21N2ozbTdelY6PpEDA//BwKg96KD7tAJN+x
 R0krjkkkLOpHWxvlnEvUc0pUOGWjgTqiMKEc75HrUpRI3RS0oQ20pO3X5NSzXDBPLlWY
 cwbSnlilHE8FaqousxCi/A7fCb2ILIfVYtY1AXks7AA9qVOAHo5o60POW53AI+L0h+vf
 Pz/BsZ7mN2ctKZx0zLw/AH+Nt+PM8vr3fGJES8NK2TOb2Tv4joDxx+TKuNTgHj0d6TJB
 MOEQ==
X-Gm-Message-State: AOJu0Yzf+uSIo0CKl9k5NeqbdoQ4Hlq6rMSi2dcbOF4kN1+eObNHCP+1
 G3sH8bh502XYcvwST90PK3hjGWuZaWXqUONc5IhpaZCMcHUYqA==
X-Google-Smtp-Source: AGHT+IHyriWiMpInj+ARzn2z829bWUco4JuGpZ3Zuyxo2QyeqMKEsJUFVxipUVdPS9gnQ0j51yotkoM0J1WzwzC7J6A=
X-Received: by 2002:a50:d6c5:0:b0:553:4e62:317a with SMTP id
 l5-20020a50d6c5000000b005534e62317amr1855949edj.16.1704762349213; Mon, 08 Jan
 2024 17:05:49 -0800 (PST)
MIME-Version: 1.0
References: <20240101075315.43167-1-horenchuang@bytedance.com>
 <20240101075315.43167-2-horenchuang@bytedance.com>
 <ZZXX95yvk/WTIBT/@memverge.com>
 <CAAYibXjZ0HSCqMrzXGv62cMLncS_81R3e1uNV5Fu4CPm0zAtYw@mail.gmail.com>
 <ZZwtmiucNXxmrZ7S@memverge.com>
 <CAAYibXhfUu8dMwvBmWz4P6N9-yLao0QwAFozk4rS_0GPsEZd7Q@mail.gmail.com>
In-Reply-To: <CAAYibXhfUu8dMwvBmWz4P6N9-yLao0QwAFozk4rS_0GPsEZd7Q@mail.gmail.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Mon, 8 Jan 2024 17:05:38 -0800
Message-ID: <CAAYibXgf6i5+aqopCrVu5ZveDJ9WP2M2AJaUUaj5qFXFHQQxmQ@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ed1-x531.google.com
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

On Mon, Jan 8, 2024 at 2:47=E2=80=AFPM Hao Xiang <hao.xiang@bytedance.com> =
wrote:
>
> On Mon, Jan 8, 2024 at 9:15=E2=80=AFAM Gregory Price <gregory.price@memve=
rge.com> wrote:
> >
> > On Fri, Jan 05, 2024 at 09:59:19PM -0800, Hao Xiang wrote:
> > > On Wed, Jan 3, 2024 at 1:56=E2=80=AFPM Gregory Price <gregory.price@m=
emverge.com> wrote:
> > > >
> > > > For a variety of performance reasons, this will not work the way yo=
u
> > > > want it to.  You are essentially telling QEMU to map the vmem0 into=
 a
> > > > virtual cxl device, and now any memory accesses to that memory regi=
on
> > > > will end up going through the cxl-type3 device logic - which is an =
IO
> > > > path from the perspective of QEMU.
> > >
> > > I didn't understand exactly how the virtual cxl-type3 device works. I
> > > thought it would go with the same "guest virtual address ->  guest
> > > physical address -> host physical address" translation totally done b=
y
> > > CPU. But if it is going through an emulation path handled by virtual
> > > cxl-type3, I agree the performance would be bad. Do you know why
> > > accessing memory on a virtual cxl-type3 device can't go with the
> > > nested page table translation?
> > >
> >
> > Because a byte-access on CXL memory can have checks on it that must be
> > emulated by the virtual device, and because there are caching
> > implications that have to be emulated as well.
>
> Interesting. Now that I see the cxl_type3_read/cxl_type3_write. If the
> CXL memory data path goes through them, the performance would be
> pretty problematic. We have actually run Intel's Memory Latency
> Checker benchmark from inside a guest VM with both system-DRAM and
> virtual CXL-type3 configured. The idle latency on the virtual CXL
> memory is 2X of system DRAM, which is on-par with the benchmark
> running from a physical host. I need to debug this more to understand
> why the latency is actually much better than I would expect now.

So we double checked on benchmark testing. What we see is that running
Intel Memory Latency Checker from a guest VM with virtual CXL memory
VS from a physical host with CXL1.1 memory expander has the same
latency.

From guest VM: local socket system-DRAM latency is 117.0ns, local
socket CXL-DRAM latency is 269.4ns
From physical host: local socket system-DRAM latency is 113.6ns ,
local socket CXL-DRAM latency is 267.5ns

I also set debugger breakpoints on cxl_type3_read/cxl_type3_write
while running the benchmark testing but those two functions are not
ever hit. We used the virtual CXL configuration while launching QEMU
but the CXL memory is present as a separate NUMA node and we are not
creating devdax devices. Does that make any difference?

>
> >
> > The cxl device you are using is an emulated CXL device - not a
> > virtualization interface.  Nuanced difference:  the emulated device has
> > to emulate *everything* that CXL device does.
> >
> > What you want is passthrough / managed access to a real device -
> > virtualization.  This is not the way to accomplish that.  A better way
> > to accomplish that is to simply pass the memory through as a static num=
a
> > node as I described.
>
> That would work, too. But I think a kernel change is required to
> establish the correct memory tiering if we go this routine.
>
> >
> > >
> > > When we had a discussion with Intel, they told us to not use the KVM
> > > option in QEMU while using virtual cxl type3 device. That's probably
> > > related to the issue you described here? We enabled KVM though but
> > > haven't seen the crash yet.
> > >
> >
> > The crash really only happens, IIRC, if code ends up hosted in that
> > memory.  I forget the exact scenario, but the working theory is it has
> > to do with the way instruction caches are managed with KVM and this
> > device.
> >
> > > >
> > > > You're better off just using the `host-nodes` field of host-memory
> > > > and passing bandwidth/latency attributes though via `-numa hmat-lb`
> > >
> > > We tried this but it doesn't work from end to end right now. I
> > > described the issue in another fork of this thread.
> > >
> > > >
> > > > In that scenario, the guest software doesn't even need to know CXL
> > > > exists at all, it can just read the attributes of the numa node
> > > > that QEMU created for it.
> > >
> > > We thought about this before. But the current kernel implementation
> > > requires a devdax device to be probed and recognized as a slow tier
> > > (by reading the memory attributes). I don't think this can be done vi=
a
> > > the path you described. Have you tried this before?
> > >
> >
> > Right, because the memory tiering component lumps the nodes together.
> >
> > Better idea:  Fix the memory tiering component
> >
> > I cc'd you on another patch line that is discussing something relevant
> > to this.
> >
> > https://lore.kernel.org/linux-mm/87fs00njft.fsf@yhuang6-desk2.ccr.corp.=
intel.com/T/#m32d58f8cc607aec942995994a41b17ff711519c8
> >
> > The point is: There's no need for this to be a dax device at all, there
> > is no need for the guest to even know what is providing the memory, or
> > for the guest to have any management access to the memory.  It just
> > wants the memory and the ability to tier it.
> >
> > So we should fix the memory tiering component to work with this
> > workflow.
>
> Agreed. We really don't need the devdax device at all. I thought that
> choice was made due to the memory tiering concept being started with
> pmem ... Let's continue this part of the discussion on the above
> thread.
>
> >
> > ~Gregory

