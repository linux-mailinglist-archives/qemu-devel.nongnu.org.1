Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 067DE7EFF6F
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Nov 2023 13:12:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4K9q-00046B-Bn; Sat, 18 Nov 2023 07:10:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4K9o-00045u-CJ
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 07:10:40 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4K9l-0004YX-Ua
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 07:10:40 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5c2139492d9so596895a12.0
 for <qemu-devel@nongnu.org>; Sat, 18 Nov 2023 04:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700309436; x=1700914236;
 darn=nongnu.org; 
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qVeDlYP/jY5Kc2oqfXCUuVwRL0RzlNUiNOgs0AHKgo8=;
 b=n/yQlR45P/XQ2cNVk4i6cr7tC047nslgG3rxFDbVcdFmYGk4+EllcQUj3gxR6ZlGkA
 Cc0BjEEspq7nWLT1QckI2qlLQwmSLiHh78AtFGlmxuZTrBuP//mLeNaKh18zXRfZrjQf
 t8LO8ETPfDvklZ5ce62FEPL4tHPS59Fzy0R2wzRle4tnWRxn4v+R1/FlIZNTM1yI+V77
 +xoQwO6JDxxxUBllmTrQZN2gTyJoHRzoh9X1mkLnHGqboouMSaVB9w0NpHWImIpsI37Q
 /zXWur6UnO39mb+8Xe8KEFwKVVh5iijxMyjSLxjUuVnT5HDliujfIReZPL1OLSzMvBvo
 7XNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700309436; x=1700914236;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qVeDlYP/jY5Kc2oqfXCUuVwRL0RzlNUiNOgs0AHKgo8=;
 b=UZBb8sJXTOW+hMi7wPJxW424zv8KDxFY7/EwA5cpP69ewPu3rx7cobvLIbLXQOxgEv
 nmRR+s9xFC4J5tNs+8Q3NLRYhzS1YlR6FLxWftXmf4MCK3102L7o7gntgPDkbQ0ES0+X
 RmM1830g40aSfrQYXA4L99pi4dcHtdXPobEut+0jx66igtO9NDUXB3eyt8FBAGFrOUqL
 PwzLGi5X7xd/BV3bAz2xYO49U6kGG/3QOQdn19NcE2nSs9n0Vx2+OetvSTgXv9DDaflM
 X+zu6KVgApIRc4KBstUyumu4vi5ZR6WuszNUzbj4IP5Nd8hTGfTxbXBrazmKMFdaE7Av
 nBRw==
X-Gm-Message-State: AOJu0YzwXTouOxLssXmmJWykqUzLgOK5F3Gg6CoN45bjvsX8VfEnYUP9
 tyZBJ0bmhCR7sbdtxV1IVMqIOg==
X-Google-Smtp-Source: AGHT+IHFwo15ky8BpzVkHSniloieGheZ+99kBtpfKrADmlEJygctmLm1gQXBMJe0pcAOd7DtY78CHw==
X-Received: by 2002:a05:6a21:328b:b0:187:d189:53df with SMTP id
 yt11-20020a056a21328b00b00187d18953dfmr1594083pzb.16.1700309436413; 
 Sat, 18 Nov 2023 04:10:36 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 md24-20020a17090b23d800b00273744e6eccsm2910112pjb.12.2023.11.18.04.10.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Nov 2023 04:10:35 -0800 (PST)
Message-ID: <5d46f455-f530-4e5e-9ae7-13a2297d4bc5@daynix.com>
Date: Sat, 18 Nov 2023 21:10:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Washizu Yui <yui.washidu@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [RFC] Flexible SR-IOV support for virtio-net
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::531;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x531.google.com
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

Hi,

We are planning to add PCIe SR-IOV support to the virtio-net driver for 
Windows ("NetKVM")[1], and we want a SR-IOV feature for virtio-net 
emulation code in QEMU to test it. I expect there are other people 
interested in such a feature, considering that people are using igb[2] 
to test SR-IOV support in VMs.

Washizu Yui have already proposed an RFC patch to add a SR-IOV feature 
to virtio-net emulation[3][4] but it's preliminary and has no 
configurability for VFs.

Now I'm proposing to add SR-IOV support to virtio-net with full 
configurability for VFs by following the implementation of virtio-net 
failover[5]. I'm planning to write patches myself, but I know there are 
people interested in such patches so I'd like to let you know the idea 
beforehand.

The idea:

The problem when implementing configurability for VFs is that SR-IOV VFs 
can be realized and unrealized at runtime with a request from the guest. 
So a naive implementation cannot deal with a command line like the 
following:
-device virtio-net-pci,addr=0x0.0x0,sriov=on
-device virtio-net-pci,addr=0x0.0x1
-device virtio-net-pci,addr=0x0.0x2

This will realize the virtio-net functions in 0x0.0x1 and 0x0.0x2 when 
the guest starts instead of when the guest requests to enable VFs.

However, reviewing the virtio-net emulation code, I realized the 
virtio-net failover also "hides" devices when the guest starts. The 
following command line hides hostdev0 when the guest starts, and adds it 
when the guest requests VIRTIO_NET_F_STANDBY feature:

-device virtio-net-pci,netdev=hostnet1,id=net1,mac=52:54:00:6f:55:cc, \
   bus=root2,failover=on
-device vfiopci,host=5e:00.2,id=hostdev0,bus=root1,failover_pair_id=net1

So it should be also possible to do similar to "hide" VFs and 
realize/unrealize them when the guest requests.

There are two things I hate with this idea when contrasting it with the 
conventional multifunction feature[6] though. One is that the PF must be 
added before VFs; a similar limitation is imposed for failover.

Another is that it will be specific to virtio-net. I was considering to 
implement a "generic" SR-IOV feature that will work on various devices, 
but I realized that will need lots of configuration validations. We may 
eventually want it, but probably it's better to avoid such a big leap as 
the first step.

Please tell me if you have questions or suggestions.

Regards,
Akihiko Odaki

[1] https://github.com/virtio-win/kvm-guest-drivers-windows
[2] https://qemu.readthedocs.io/en/v8.1.0/system/devices/igb.html
[3] 
https://patchew.org/QEMU/1689731808-3009-1-git-send-email-yui.washidu@gmail.com/
[4] 
https://netdevconf.info/0x17/sessions/talk/unleashing-sr-iov-offload-on-virtual-machines.html
[5] https://qemu.readthedocs.io/en/v8.1.0/system/virtio-net-failover.html
[6] https://gitlab.com/qemu-project/qemu/-/blob/v8.1.2/docs/pcie.txt

