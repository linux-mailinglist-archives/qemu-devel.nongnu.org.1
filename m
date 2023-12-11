Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A16F80C0B6
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 06:31:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCYql-0006Vm-T5; Mon, 11 Dec 2023 00:29:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCYqi-0006UP-MF
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 00:29:00 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCYqg-0007yO-Mc
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 00:29:00 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-59064bca27dso2396000eaf.0
 for <qemu-devel@nongnu.org>; Sun, 10 Dec 2023 21:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702272537; x=1702877337;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wYNl1NfKRB1T0VsFS69a4+BXxX5/zSDJ9HnrEHV17ZQ=;
 b=END6Wv+xW2835SOEO0viIJzqx+08zOQlCihF6hj/h17MHdO9DkTUEo+PaLViQoVtf5
 d+M38ETuhvAerF2jxIs8ZSgukj0ldxqnmcpIiYFc1r6JqnAMdgRKMKCJqc/ysRJnOjac
 ztqZqrxywtgcNQWhpAmD5r25GQxlIDoDuVCn1iK2bZBT2qktGP7qI+sJo+9h1aj+7Wkc
 Z3Vtv+Vu93gxo9M6MA6zyoXpYKjT9bwKC/Lg6cbMQN+sZfTncS8wP3BgqRNSOCUNIYmo
 8bcr+sOISlDyRlt1hAmVFjxLOgCU9Iu81YQ/e3RUhMzV25hkdbA1a0z9Q+VxErtaqFDW
 XeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702272537; x=1702877337;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wYNl1NfKRB1T0VsFS69a4+BXxX5/zSDJ9HnrEHV17ZQ=;
 b=H+zIfMFK6jNYvGva03YcWKpRdAmkb5jRuZcMZfqgL3lDaEoqlt0qIaQT2GXJLk8LYp
 d/wbV/2oQBRUPSkIHRpfh+4MakTeIIf8IwQLxhLTYHcUaBVgB+026r2/CtNnm4klxoYD
 u+0vqyK44hNav6q2dXAoTMAXg2qyRkocB84IQt9PhByTnIQehUploDxoc58IpCIc7y2v
 XO0l3A0Qm3+2Ml+Ya92nRyMdyqNh3ONHGzYPW0eEoj+sJjjh/NNkkx+S82rBu6qNtC+w
 U63AvVw0eONUtuyAE5WsRtMLXIxpmMokCt6j8ayOjvWl8ATV5A8onZX1Wc8h5RF3w81h
 9pkw==
X-Gm-Message-State: AOJu0YwpZdshCrq6o9ZInWYIjEpupD9nSKcgui1TrKSXIf59ykYRnFWn
 RRCCTBNpu/Wwfi+O2GLG4NIZ+g==
X-Google-Smtp-Source: AGHT+IFLEz5OrWHljVU5umz3O8Sgs5dOSGQgSbhlma9luDn7l8O0p46vnD4MMDfxsB6n33nvKr8h5g==
X-Received: by 2002:a05:6358:3a1b:b0:170:c15a:8004 with SMTP id
 g27-20020a0563583a1b00b00170c15a8004mr3262680rwe.53.1702272536995; 
 Sun, 10 Dec 2023 21:28:56 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 c12-20020a62e80c000000b006ce7e497302sm5278879pfi.21.2023.12.10.21.28.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Dec 2023 21:28:56 -0800 (PST)
Message-ID: <dc5bb0f8-3554-40f2-b683-3b5e58377ed3@daynix.com>
Date: Mon, 11 Dec 2023 14:28:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 00/12] virtio-net: add support for SR-IOV emulation
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Yui Washizu <yui.washidu@gmail.com>
References: <20231210-sriov-v2-0-b959e8a6dfaf@daynix.com>
 <CACGkMEuYa7CUUp6F4D91P0mg=2GadhRESCx2j63P7Fkm42q++w@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEuYa7CUUp6F4D91P0mg=2GadhRESCx2j63P7Fkm42q++w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c36;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/12/11 11:52, Jason Wang wrote:
> On Sun, Dec 10, 2023 at 12:06 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> Introduction
>> ------------
>>
>> This series is based on the RFC series submitted by Yui Washizu[1].
>> See also [2] for the context.
>>
>> This series enables SR-IOV emulation for virtio-net. It is useful
>> to test SR-IOV support on the guest, or to expose several vDPA devices
>> in a VM. vDPA devices can also provide L2 switching feature for
>> offloading though it is out of scope to allow the guest to configure
>> such a feature.
>>
>> The PF side code resides in virtio-pci. The VF side code resides in
>> the PCI common infrastructure, but it is restricted to work only for
>> virtio-net-pci because of lack of validation.
>>
>> User Interface
>> --------------
>>
>> A user can configure a SR-IOV capable virtio-net device by adding
>> virtio-net-pci functions to a bus. Below is a command line example:
>>    -netdev user,id=n -netdev user,id=o
>>    -netdev user,id=p -netdev user,id=q
>>    -device pcie-root-port,id=b
>>    -device virtio-net-pci,bus=b,addr=0x0.0x3,netdev=q,sriov-pf=f
>>    -device virtio-net-pci,bus=b,addr=0x0.0x2,netdev=p,sriov-pf=f
>>    -device virtio-net-pci,bus=b,addr=0x0.0x1,netdev=o,sriov-pf=f
>>    -device virtio-net-pci,bus=b,addr=0x0.0x0,netdev=n,id=f
>>
>> The VFs specify the paired PF with "sriov-pf" property. The PF must be
>> added after all VFs. It is user's responsibility to ensure that VFs have
>> function numbers larger than one of the PF, and the function numbers
>> have a consistent stride.
> 
> This seems not user friendly. Any reason we can't just allow user to
> specify the stride here?

It should be possible to assign addr automatically without requiring 
user to specify the stride. I'll try that in the next version.

> 
> Btw, I vaguely remember qemu allows the params to be accepted as a
> list. If this is true, we can accept a list of netdev here?

Yes, rocker does that. But the problem is not just about getting 
parameters needed for VFs, which I forgot to mention in the cover letter 
and will explain below.

> 
>>
>> Keeping VF instances
>> --------------------
>>
>> A problem with SR-IOV emulation is that it needs to hotplug the VFs as
>> the guest requests. Previously, this behavior was implemented by
>> realizing and unrealizing VFs at runtime. However, this strategy does
>> not work well for the proposed virtio-net emulation; in this proposal,
>> device options passed in the command line must be maintained as VFs
>> are hotplugged, but they are consumed when the machine starts and not
>> available after that, which makes realizing VFs at runtime impossible.
> 
> Could we store the device options in the PF?

I wrote it's to store the device options, but the problem is actually 
more about realizing VFs at runtime instead of at the initialization time.

Realizing VFs at runtime have two major problems. One is that it delays 
the validations of options; invalid options will be noticed when the 
guest requests to realize VFs. netdevs also warn that they are not used 
at initialization time, not knowing that they will be used by VFs later. 
References to other QEMU objects in the option may also die before VFs 
are realized.

The other problem is that QEMU cannot interact with the unrealized VFs. 
For example, if you type "device_add virtio-net-pci,id=vf,sriov-pf=pf" 
in HMP, you will expect "device_del vf" works, but it's hard to 
implement such behaviors with unrealized VFs.

I was first going to compromise and allow such quirky behaviors, but I 
realized such a compromise is unnecessary if we reuse the PCI power down 
logic so I wrote v2.

Regards,
Akihiko Odaki

