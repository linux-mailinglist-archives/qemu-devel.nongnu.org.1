Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F57D828ED9
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 22:28:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNJdS-0005ex-58; Tue, 09 Jan 2024 16:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rNJdP-0005cn-UX
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 16:27:43 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rNJdN-0002BT-Bj
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 16:27:43 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a293f2280c7so393631866b.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 13:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704835659; x=1705440459; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3RYRcrJ2njCxlwPi4dMGvfXtU/fOWdqaKi3X1OjueHQ=;
 b=WwrJkFhaDN7yf5e2SaQLSQqwRDlnPK/k5WqmmfAV93xB9PTgzQFC7pPYozdAxTHcyI
 Jdw4tcuvDb6gfw+7gGlDFC/I89vWL0kwkNPG70gFogTKmJ8hNuCexpmfRqixioaNgQno
 NGJClG/sDXEDxpozqLDm0YC+YgsKrbaMpfrx6hmkbXFJmHhokLKyEq0swxCzuWM50sSz
 +HLfX9kb4JMibZY4Nh4bS304HMvlERRPFvdZjQpvZYHGCpJJNV5x2CyANBeOtaoBwAle
 XYk+uoSdfakdg9X8UagIgU2IdQaSFt+NSLZ66cGYWt2IAMQcXYOzvYjeiyssPbzpEa8D
 uWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704835659; x=1705440459;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3RYRcrJ2njCxlwPi4dMGvfXtU/fOWdqaKi3X1OjueHQ=;
 b=Bjms/WjjfxW2L5IRS16Q8pZQl3RVD1cNmVMDs7ypr/hEHwz8aUxG/fliOF1lSBaEE8
 WcAbIbt2Pp5FfhyHUgp/xkkffzy0bh4hoU6/q4e7AE/FvKdZdDbRjK82fjkrmuS97cWQ
 uV+wFHVLdIDJa445nhdZGE/YSATlsDIRAXxIr3UlEopJ7RgN9uLDwMYfpRJxc6ui52Rp
 tBOzP9vcWr8e4k+dIQZGjWeh7NDdxOtGHJkTKNK37LbNXTc4l60nhVyOwWkZtTpJc8bP
 Csgtc5PUT9lPPXVRge3N54G3sQaw9Pymo5mOaHRaC60J1j7gvxaLy+GG+hfrSZm3zPwR
 w10w==
X-Gm-Message-State: AOJu0Yy5+ivr1Oj/Sss9BUJVoSNWbAgf5lWVY3aovoee0HhIGTFhXpQD
 sFOp5dDE3bF8stf7oFEaQHBVgeTMwzn7p7GIFVMzhAd829FKJQ==
X-Google-Smtp-Source: AGHT+IELB2iV38lStakkc2NRWLmg3gGjNhZ/JM43UXn64f+wOsc6MGcQVY8z7Szp+mWheb9aXuWF+h3xi7kk1Q7o10k=
X-Received: by 2002:a17:907:94c9:b0:a29:1419:f522 with SMTP id
 dn9-20020a17090794c900b00a291419f522mr40459ejc.72.1704835659487; Tue, 09 Jan
 2024 13:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20240101075315.43167-1-horenchuang@bytedance.com>
 <20240101075315.43167-2-horenchuang@bytedance.com>
 <ZZXX95yvk/WTIBT/@memverge.com>
 <CAAYibXjZ0HSCqMrzXGv62cMLncS_81R3e1uNV5Fu4CPm0zAtYw@mail.gmail.com>
 <ZZwtmiucNXxmrZ7S@memverge.com>
 <CAAYibXhfUu8dMwvBmWz4P6N9-yLao0QwAFozk4rS_0GPsEZd7Q@mail.gmail.com>
 <CAAYibXgf6i5+aqopCrVu5ZveDJ9WP2M2AJaUUaj5qFXFHQQxmQ@mail.gmail.com>
 <ZZydwBTS4NeSizzb@memverge.com>
 <CAAYibXhY5p6VN7yAMpmfAgHO+gsf51dvNw68y__RYV+43CVVLQ@mail.gmail.com>
 <ZZ2lNoTQ8hDHADTT@memverge.com>
In-Reply-To: <ZZ2lNoTQ8hDHADTT@memverge.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Tue, 9 Jan 2024 13:27:28 -0800
Message-ID: <CAAYibXjcVu-13h9jHpt2fZ3wmjz-_Dyj+WfUh0AEpid87GLriQ@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ej1-x633.google.com
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

On Tue, Jan 9, 2024 at 11:58=E2=80=AFAM Gregory Price
<gregory.price@memverge.com> wrote:
>
> On Tue, Jan 09, 2024 at 11:33:04AM -0800, Hao Xiang wrote:
> > On Mon, Jan 8, 2024 at 5:13=E2=80=AFPM Gregory Price <gregory.price@mem=
verge.com> wrote:
> >
> > Sounds like the technical details are explained on the other thread.
> > From what I understand now, if we don't go through a complex CXL
> > setup, it wouldn't go through the emulation path.
> >
> > Here is our exact setup. Guest runs Linux kernel 6.6rc2
> >
> > taskset --cpu-list 0-47,96-143 \
> > numactl -N 0 -m 0 ${QEMU} \
> > -M q35,cxl=3Don,hmat=3Don \
> > -m 64G \
> > -smp 8,sockets=3D1,cores=3D8,threads=3D1 \
> > -object memory-backend-ram,id=3Dram0,size=3D45G \
> > -numa node,memdev=3Dram0,cpus=3D0-7,nodeid=3D0 \
> > -msg timestamp=3Don -L /usr/share/seabios \
> > -enable-kvm \
> > -object memory-backend-ram,id=3Dvmem0,size=3D19G,host-nodes=3D${HOST_CX=
L_NODE},policy=3Dbind
> > \
> > -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
> > -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,slot=
=3D2 \
> > -device cxl-type3,bus=3Droot_port13,volatile-memdev=3Dvmem0,id=3Dcxl-vm=
em0 \
> > -numa node,memdev=3Dvmem0,nodeid=3D1 \
> > -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D19G,cxl-fmw.0.interleav=
e-granularity=3D8k
>
> :] you did what i thought you did
>
> -numa node,memdev=3Dvmem0,nodeid=3D1
>
> """
> Another possiblity: You mapped this memory-backend into another numa
> node explicitly and never onlined the memory via cxlcli.  I've done
> this, and it works, but it's a "hidden feature" that probably should
> not exist / be supported.
> """
>
> You're mapping vmem0 into an explicit numa node *and* into the type3
> device.  You don't need to do both - and technically this shouldn't be
> allowed.
>
> With this configuration, you can go thorugh the cxl-cli setup process
> for the CXL device, you'll find that you can create *another* node
> (node 2 in this case) that maps to the same memory you mapped to node1..
>
>
> You can drop the cxl devices objects in here and the memory will still
> come up the way you want it to.
>
> If you drop this line:
>
> -numa node,memdev=3Dvmem0,nodeid=3D1

We tried this as well and it works after going through the cxlcli
process and created the devdax device. The problem is that without the
"nodeid=3D1" configuration, we cannot connect with the explicit per numa
node latency/bandwidth configuration "-numa hmat-lb". I glanced at the
code in hw/numa.c, parse_numa_hmat_lb() looks like the one passing the
lb information to VM's hmat.

From what I understand so far, the guest kernel will dynamically
create a numa node after a cxl devdax device is created. That means we
don't know the numa node until after VM boot. 2. QEMU can only
statically parse the lb information to the VM at boot time. How do we
connect these two things?

Assuming that the same issue applies to a physical server with CXL.
Were you able to see a host kernel getting the correct lb information
for a CXL devdax device?

>
> You have to use the CXL driver to instantiate the dax device and the
> numa node, and at *that* point you will see the read/write functions
> being called.
>
> ~Gregory

