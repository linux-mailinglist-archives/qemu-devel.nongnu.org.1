Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B88D2704A10
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 12:08:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyrax-0004rt-KC; Tue, 16 May 2023 06:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pyrap-0004pN-7x
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:07:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pyran-0004Dg-K7
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684231660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HkjynwLsFLsmGkZ0xMVphS2o6FG82rWm/LIeB+dD5K8=;
 b=Hki/g4KIhGsgPpCpgOpTY7PoFCv5INgZSm/KB0RUWlpYBMEJelohvoKWJRTtl/1QxMu8Ke
 bQH2PelcOBmeEPCqIwPt9JSRs+ZChGClN6CC+nz+Nb4f1ZueZYVDUWTTqSzGRsbnTkNhPF
 kgb6qW+GAMCNrTR4LKEy09ZuvJBpO3U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-_vlLoJU0MOWOz3WGVAmdIA-1; Tue, 16 May 2023 06:07:37 -0400
X-MC-Unique: _vlLoJU0MOWOz3WGVAmdIA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f422dc5ee5so57530625e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 03:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684231656; x=1686823656;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HkjynwLsFLsmGkZ0xMVphS2o6FG82rWm/LIeB+dD5K8=;
 b=SbHrUcR/pMarYWWIavxY40As40LlF6p/7dZ1WoAMmmNeDF9uDQMCOxrPJWftoXMc1B
 jXNSa5SQbn74gpJAi6Ek+ogftx3zHNXtT5YNMVWgH3c+QVMU5dEkNN+nEP33PaJKDYHd
 CklvOU+vB+snupX9Q4g2Vl//0t+PpRL9n0WAZlhh0zsQc3MCSWpNJ8QfL4dVXE2LqyHx
 xB6732DF0ORhagQDua9SODWoV51WUGqW+4vS7ZQTxSZCUNUVYwKFe05lSdjC52CZTX5l
 Mr8e5muW4Onep2PzYXK0LMtoFTG8DvHw8v0qXpqFKcH5TZ0jwLP658eqwP4+9+efoJq2
 WypQ==
X-Gm-Message-State: AC+VfDyolkqDmH24RrsQq+gxW2dobqLVk7sLCxv5NumEi8N+lScr3eRK
 atDhUuQpnNu5zvyM6X9cizMJM3sNiX4iDzX4ZLrttvqpaIv2/FEldt0DJ8L/II8WcLVtii5Jp2u
 QDyEYEGpMEMlm+hE=
X-Received: by 2002:a7b:c847:0:b0:3f5:60b:32 with SMTP id
 c7-20020a7bc847000000b003f5060b0032mr7268432wml.27.1684231656035; 
 Tue, 16 May 2023 03:07:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6fkTatQH6Lo8pc1cBcY6rtzSR9SQ5j0cMrCV19IEmSReaQJBxeRqO9tEQLVTCDPvPwhxyyJQ==
X-Received: by 2002:a7b:c847:0:b0:3f5:60b:32 with SMTP id
 c7-20020a7bc847000000b003f5060b0032mr7268416wml.27.1684231655757; 
 Tue, 16 May 2023 03:07:35 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-218.web.vodafone.de.
 [109.43.177.218]) by smtp.gmail.com with ESMTPSA id
 j4-20020adfe504000000b002f6dafef040sm2039494wrm.12.2023.05.16.03.07.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 03:07:35 -0700 (PDT)
Message-ID: <552c1618-d238-0750-6e24-c873b8f0e9a6@redhat.com>
Date: Tue, 16 May 2023 12:07:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] lsi53c895a: disable reentrancy detection for MMIO region, 
 too
Content-Language: en-US
To: Alexander Bulekov <alxndr@bu.edu>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-devel@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Darren Kenny <darren.kenny@oracle.com>
References: <20230516090556.553813-1-thuth@redhat.com>
 <20230516092705.pdn5zs2yag5pvfgk@mozz.bu.edu>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230516092705.pdn5zs2yag5pvfgk@mozz.bu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.811, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 16/05/2023 11.27, Alexander Bulekov wrote:
> On 230516 1105, Thomas Huth wrote:
>> While trying to use a SCSI disk on the LSI controller with an
>> older version of Fedora (25), I'm getting:
>>
>>   qemu: warning: Blocked re-entrant IO on MemoryRegion: lsi-mmio at addr: 0x34
> 
> Do you have a gdb backtrace for this one or is there some easy way to
> reproduce with just a LiveCD or something?

I reproduced it like this:

./qemu-system-x86_64 -accel kvm -m 2G -machine q35 \
  -device lsi53c810,id=lsi1 -device scsi-hd,drive=d0 \
  -drive if=none,id=d0,file=.../somedisk.qcow2 \
  -cdrom Fedora-Everything-netinst-i386-25-1.3.iso

Where somedisk.qcow2 is an image that contains already some partitions and 
file systems.

In the boot menu of Fedora, go to "Troubleshooting" -> "Rescue a Fedora 
system" -> "3) Skip to shell"

Then check "dmesg | grep -i 53c" for failure messages, and try to mount a 
partition from somedisk.qcow2

> Marking mmio_io re-entrancy
> safe would bring back https://gitlab.com/qemu-project/qemu/-/issues/1563
> Maybe there is some other workaround here?

I think we manually have to disallow endless reentrancy in 
lsi_execute_script() ... I'm currently doing some experiments there...

  Thomas


