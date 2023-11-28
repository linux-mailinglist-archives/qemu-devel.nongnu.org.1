Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 307197FB4BF
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 09:49:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7tkr-0007T0-4l; Tue, 28 Nov 2023 03:47:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1r7tko-0007Ss-Nr
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 03:47:38 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1r7tkm-0002CL-GH
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 03:47:38 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6cb66fbc63dso3759749b3a.0
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 00:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701161254; x=1701766054; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uTD9rqTdFed8NfQb4XGI6SSfSC10NZ4sOnnIXAySq1E=;
 b=JMXoL4TBYSf+EQGcEZK4PsykXNDoscll5/AiaZTe+kdpvA+vjh8vV4rjnDKgjNqaYF
 pOqwMJCzyoAdAHjFYzOzHuyb9apJ4F7FS4RZfqT9UwmOJBjGKAaQL3xYN78GNRCKpTrX
 pKLTdCEyaqkyCrePDj1GGUTTAek23JfDyMQFVHrHtm3oafpB51sHdutg4EK3DKuZL09D
 A6mia9DZMKzrKHTQEYzT7dh79wOnaW7FsYsnH5FTWDptAPUVTd1v7sBjd17VYzg4NW2Q
 tFlXHuiXVO61PzKGR3c/KatJZqyBBGxHVwU1MkcwCPTZzB19nsosZ1ZSngKquFnaCSXY
 amUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701161254; x=1701766054;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uTD9rqTdFed8NfQb4XGI6SSfSC10NZ4sOnnIXAySq1E=;
 b=t4Hp1N/SqB9HULIHn7+gu+RNofYH0UyUt4p+WCM2ynJBWKlZ5Bymzth4s1Ec3krGpI
 u9n29xvF9gttyTLJ6mrJYAUfmjU6lyYAZ8jMkcWHcxEfC3/M5pvTdpOwXSJWxbPm1p57
 Rs/RevEoNZmD4eKDHcXRk/SZ6Bxaktc5exkQjl9MPxaQr99tBGP6K2g8iKGssCdwX9MF
 VURz8foeegrFqtBsiv8FbpDTsICOvM9w3quyvl5KxNByC2d0Wxvs8QaNw1tKoJEPMlky
 bKMNWecFqJ+v7dK/HsNUiW16Qp0d9haYor5uWN4tibxpk/JKWb2b806d1E8F6RNX/ukW
 uShQ==
X-Gm-Message-State: AOJu0YzkSqQHO45JcL3KyKR4QDBnPXcfMflC8QC3QIfwMsOKfZJGN8aG
 p3lbAWPnFjpQcFh3FuZRqYI=
X-Google-Smtp-Source: AGHT+IHeN8LvKwI1zCqasKu0AvQsm7ZNOY8HdcR32Me7+Y/h7+pcjWGNkYsMpcvBSO6TYjuK7SVn7w==
X-Received: by 2002:a05:6a21:6d8a:b0:187:bb9c:569 with SMTP id
 wl10-20020a056a216d8a00b00187bb9c0569mr21244478pzb.5.1701161254345; 
 Tue, 28 Nov 2023 00:47:34 -0800 (PST)
Received: from ?IPV6:240b:10:b280:d600:acea:596b:895:6391?
 ([240b:10:b280:d600:acea:596b:895:6391])
 by smtp.gmail.com with ESMTPSA id
 v8-20020aa78088000000b006be22fde07dsm8475622pff.106.2023.11.28.00.47.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 00:47:33 -0800 (PST)
Message-ID: <63ba118d-b203-4ec2-a4b5-a8ebacce5c1d@gmail.com>
Date: Tue, 28 Nov 2023 17:47:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Flexible SR-IOV support for virtio-net
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <5d46f455-f530-4e5e-9ae7-13a2297d4bc5@daynix.com>
Content-Language: en-US
From: Yui Washizu <yui.washidu@gmail.com>
In-Reply-To: <5d46f455-f530-4e5e-9ae7-13a2297d4bc5@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=yui.washidu@gmail.com; helo=mail-pf1-x436.google.com
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


On 2023/11/18 21:10, Akihiko Odaki wrote:
> Hi,
>
> We are planning to add PCIe SR-IOV support to the virtio-net driver 
> for Windows ("NetKVM")[1], and we want a SR-IOV feature for virtio-net 
> emulation code in QEMU to test it. I expect there are other people 
> interested in such a feature, considering that people are using igb[2] 
> to test SR-IOV support in VMs.
>
> Washizu Yui have already proposed an RFC patch to add a SR-IOV feature 
> to virtio-net emulation[3][4] but it's preliminary and has no 
> configurability for VFs.
>
> Now I'm proposing to add SR-IOV support to virtio-net with full 
> configurability for VFs by following the implementation of virtio-net 
> failover[5]. I'm planning to write patches myself, but I know there 
> are people interested in such patches so I'd like to let you know the 
> idea beforehand.
>
> The idea:
>
> The problem when implementing configurability for VFs is that SR-IOV 
> VFs can be realized and unrealized at runtime with a request from the 
> guest. So a naive implementation cannot deal with a command line like 
> the following:
> -device virtio-net-pci,addr=0x0.0x0,sriov=on
> -device virtio-net-pci,addr=0x0.0x1
> -device virtio-net-pci,addr=0x0.0x2
>
> This will realize the virtio-net functions in 0x0.0x1 and 0x0.0x2 when 
> the guest starts instead of when the guest requests to enable VFs.
>
> However, reviewing the virtio-net emulation code, I realized the 
> virtio-net failover also "hides" devices when the guest starts. The 
> following command line hides hostdev0 when the guest starts, and adds 
> it when the guest requests VIRTIO_NET_F_STANDBY feature:
>
> -device virtio-net-pci,netdev=hostnet1,id=net1,mac=52:54:00:6f:55:cc, \
>   bus=root2,failover=on
> -device vfiopci,host=5e:00.2,id=hostdev0,bus=root1,failover_pair_id=net1
>
> So it should be also possible to do similar to "hide" VFs and 
> realize/unrealize them when the guest requests.
>
> There are two things I hate with this idea when contrasting it with 
> the conventional multifunction feature[6] though. One is that the PF 
> must be added before VFs; a similar limitation is imposed for failover.
>
> Another is that it will be specific to virtio-net. I was considering 
> to implement a "generic" SR-IOV feature that will work on various 
> devices, but I realized that will need lots of configuration 
> validations. We may eventually want it, but probably it's better to 
> avoid such a big leap as the first step.
>
> Please tell me if you have questions or suggestions.
>


Hi, Odaki-san

The idea appears to be practical and convenient.

I have some things I want to confirm.
I understood your idea can make deices for VFs,
created by qdev_new or qdev_realize function, invisible from guest OS.
Is my understanding correct ?
And, if your idea is realized,
will it be possible to specify the backend device for the virtio-pci-net 
device ?

Could you provide insights into the next steps
beyond the implementation details ?
About when do you expect your implementation
to be merged into qemu ?
Do you have a timeline for this plan ?
Moreover, is there any way
we can collaborate on the implementation you're planning ?

Regards,

Yui Washizu


> Regards,
> Akihiko Odaki
>
> [1] https://github.com/virtio-win/kvm-guest-drivers-windows
> [2] https://qemu.readthedocs.io/en/v8.1.0/system/devices/igb.html
> [3] 
> https://patchew.org/QEMU/1689731808-3009-1-git-send-email-yui.washidu@gmail.com/
> [4] 
> https://netdevconf.info/0x17/sessions/talk/unleashing-sr-iov-offload-on-virtual-machines.html
> [5] https://qemu.readthedocs.io/en/v8.1.0/system/virtio-net-failover.html
> [6] https://gitlab.com/qemu-project/qemu/-/blob/v8.1.2/docs/pcie.txt

