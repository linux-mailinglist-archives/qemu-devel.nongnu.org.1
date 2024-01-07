Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B3A82644B
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 14:40:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMTMQ-0005dN-GL; Sun, 07 Jan 2024 08:38:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rMTMO-0005d1-5J
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 08:38:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rMTMM-0003zT-Gd
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 08:38:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704634716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Kmv2eBhKEVs+UcQO7gKfM0ohSzFuLSFM4u/0gKa1Ic=;
 b=BQnSUI4xAxj4L+MFEsXK2uJtqT3e+yK2DzunYaKfjYdrGBkgMz1+jggOY7VgU6wQVngtGw
 vOsbY+IJSq8Soos0zllmC2/rBHSDglLR685v/lEvgas8LrGHY/GUrL1hv61RH71+mL3Blv
 SFCDzqOx4TJuKsEoT/8HwZMLpzSn3QE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-xbGGB6JhNYOtVmqCOm42gQ-1; Sun, 07 Jan 2024 08:38:30 -0500
X-MC-Unique: xbGGB6JhNYOtVmqCOm42gQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40e419b52d5so5965925e9.3
 for <qemu-devel@nongnu.org>; Sun, 07 Jan 2024 05:38:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704634709; x=1705239509;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Kmv2eBhKEVs+UcQO7gKfM0ohSzFuLSFM4u/0gKa1Ic=;
 b=IWoKpmOkiDoFWzEtN3wZVDdnHU2QWUaSe4NQXlmfrFeSoTFqogUt4XGavkfKFt2+y1
 nMXyOOiOR8u1u2qCzObHPVFwTly8OnxQNlkwYeY/qloC8pGp5elixcv/SNtyh8eqqbLF
 ufX9c/YlqVYdR2ZsvwGHNruMnI0T5YJHNqV6lwiRRsjshfqh65Eg+4pz9c+5+tF5nsUH
 0bq49SLMgSvaCjsUv06pP6sL7nfBlPe1FyaD+sZRwmaX8nGAorAtx66MUzyNLYit0kDL
 JIbWa2ybheUXbgKknx1cIyNwqz6skzE7kuaGoaP/qHreWXiFjpSe/5MLLJ5Vafd9695x
 JQCg==
X-Gm-Message-State: AOJu0YyC2X/tyX9TTlJ8FDyVTYmyFHWU8SxMXMVhikheAoJdkJonFXca
 mnxAK4w3ovCa6Hrm6NDAvaBsnrrMw029tZDoDlkBOtVBw6iVSrWKI5onEMrK5koiiC9lSC2xGVK
 hQNeG/K02s1qMV/DidjGKsxU=
X-Received: by 2002:a05:600c:6022:b0:40e:4582:d538 with SMTP id
 az34-20020a05600c602200b0040e4582d538mr348478wmb.171.1704634708896; 
 Sun, 07 Jan 2024 05:38:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvYtlH/wMrB7Avf9e39UAXoUdQlvXTmIby4s3JhZUu/xz5zcP7PulabillHGewwSdBkncR2Q==
X-Received: by 2002:a05:600c:6022:b0:40e:4582:d538 with SMTP id
 az34-20020a05600c602200b0040e4582d538mr348473wmb.171.1704634708411; 
 Sun, 07 Jan 2024 05:38:28 -0800 (PST)
Received: from redhat.com ([2.52.137.138]) by smtp.gmail.com with ESMTPSA id
 p11-20020a05600c468b00b0040d81ca11casm7709353wmo.28.2024.01.07.05.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jan 2024 05:38:27 -0800 (PST)
Date: Sun, 7 Jan 2024 08:38:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: qemu-devel@nongnu.org, David Woodhouse <dwmw2@infradead.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Joao Martins <joao.m.martins@oracle.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <lists@philjordan.eu>,
 Santosh Shukla <santosh.shukla@amd.com>
Subject: Re: [PATCH v11 0/7] Support x2APIC mode with TCG accelerator
Message-ID: <20240107083613-mutt-send-email-mst@kernel.org>
References: <20231225164101.105958-1-minhquangbui99@gmail.com>
 <20231226042009-mutt-send-email-mst@kernel.org>
 <e3f17b85-697b-4f71-854d-411a3878db00@gmail.com>
 <322c9b6b-84fa-46a3-b173-34e6e9acc00d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <322c9b6b-84fa-46a3-b173-34e6e9acc00d@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.098,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sat, Jan 06, 2024 at 11:33:29PM +0700, Bui Quang Minh wrote:
> On 12/28/23 22:44, Bui Quang Minh wrote:
> > On 12/26/23 16:21, Michael S. Tsirkin wrote:
> > > On Mon, Dec 25, 2023 at 11:40:54PM +0700, Bui Quang Minh wrote:
> > > > Hi everyone,
> > > > 
> > > > This series implements x2APIC mode in userspace local APIC and the
> > > > RDMSR/WRMSR helper to access x2APIC registers in x2APIC mode.
> > > > Intel iommu
> > > > and AMD iommu are adjusted to support x2APIC interrupt
> > > > remapping. With this
> > > > series, we can now boot Linux kernel into x2APIC mode with TCG
> > > > accelerator
> > > > using either Intel or AMD iommu.
> > > > 
> > > > Testing to boot my own built Linux 6.3.0-rc2, the kernel
> > > > successfully boot
> > > > with enabled x2APIC and can enumerate CPU with APIC ID 257
> > > > 
> > > > Using Intel IOMMU
> > > > 
> > > > qemu/build/qemu-system-x86_64 \
> > > >    -smp 2,maxcpus=260 \
> > > >    -cpu qemu64,x2apic=on \
> > > >    -machine q35 \
> > > >    -device intel-iommu,intremap=on,eim=on \
> > > >    -device
> > > > qemu64-x86_64-cpu,x2apic=on,core-id=257,socket-id=0,thread-id=0
> > > > \
> > > >    -m 2G \
> > > >    -kernel $KERNEL_DIR \
> > > >    -append "nokaslr console=ttyS0 root=/dev/sda
> > > > earlyprintk=serial net.ifnames=0" \
> > > >    -drive file=$IMAGE_DIR,format=raw \
> > > >    -nographic \
> > > >    -s
> > > > 
> > > > Using AMD IOMMU
> > > > 
> > > > qemu/build/qemu-system-x86_64 \
> > > >    -smp 2,maxcpus=260 \
> > > >    -cpu qemu64,x2apic=on \
> > > >    -machine q35 \
> > > >    -device amd-iommu,intremap=on,xtsup=on \
> > > >    -device
> > > > qemu64-x86_64-cpu,x2apic=on,core-id=257,socket-id=0,thread-id=0
> > > > \
> > > >    -m 2G \
> > > >    -kernel $KERNEL_DIR \
> > > >    -append "nokaslr console=ttyS0 root=/dev/sda
> > > > earlyprintk=serial net.ifnames=0" \
> > > >    -drive file=$IMAGE_DIR,format=raw \
> > > >    -nographic \
> > > >    -s
> > > > 
> > > > Testing the emulated userspace APIC with kvm-unit-tests, disable test
> > > > device with this patch
> > > 
> > > Seems to break build for windows/amd64
> > > https://gitlab.com/mstredhat/qemu/-/pipelines/1118886361/failures
> > 
> > I saw the CI test "pages" failed too. On my CI, most of the time, it
> > failed with
> > 
> > $ htags -anT --tree-view=filetree -m qemu_init -t "Welcome to the QEMU
> > sourcecode"
> > 00:24
> > htags: Negative exec line limit = -8099
> > 
> > It only succeeded once. I could not reproduce locally. Do you have any
> > ideas what the problem is?
> 
> I think I briefly understand why pages test fails. Internally, htags call
> global to parse the output of gtags. When executing command, it expects the
> size of argv and env to 20*1024 (https://github.com/harai/gnu-global/blob/f86ba74d867385353815f8656c4a6cf4029c1f0b/libutil/xargs.c#L92-L105).
> The failed test case only happens when the last commit is patch 7 (test:
> bios-tables-test: add IVRS changed binary) which has a very long commit
> message (around 9000 bytes). By default, Gitlab appends some environment
> variables to the runner and one of them is CI_COMMIT_MESSAGE which contains
> the long commit message. So it exceeds the limit of 20*1024 bytes and fails.


Thanks for debugging this!
So I think we should clear CI_COMMIT_MESSAGE when invoking htags, right?


> In my opinion, this failed test is not so critical and seems unrelated to
> the series so I skip this failed test.

Yes ok to ignore. But even better if we also add a workaround.

> I will post the new version to fix
> the windows/amd64 build soon.
> 
> Thanks,
> Quang Minh.


