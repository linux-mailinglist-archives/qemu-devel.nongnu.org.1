Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 423947049A1
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 11:47:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyrGc-0004XP-7L; Tue, 16 May 2023 05:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pyrGW-0004Vf-FR
 for qemu-devel@nongnu.org; Tue, 16 May 2023 05:46:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pyrGU-0007vd-H9
 for qemu-devel@nongnu.org; Tue, 16 May 2023 05:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684230401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WTz7CCgqDJviLR1yM3o/vfskWvJg0LzCdkj6jvT5HBI=;
 b=BSno3kl5mG17kzf19r8+GEi0iuUQf5b1lXaHh+ujgvigacTkoPddnq8eIAnHWitdqWdTCr
 BnHVFyjSeIuMkvXjZXAoKyfJGvF6whcqYI0yoVfMB/FMAzAb8I8kmtPBHW+B9G08mCl7fP
 nYJsHg799+yMKDwZy6jwhQhHCN+Ksoc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-5yu-I7MjO1a2dyCstQBdRQ-1; Tue, 16 May 2023 05:46:39 -0400
X-MC-Unique: 5yu-I7MjO1a2dyCstQBdRQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30640be4fd0so5007279f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 02:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684230398; x=1686822398;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WTz7CCgqDJviLR1yM3o/vfskWvJg0LzCdkj6jvT5HBI=;
 b=Exf60GCgwb+YC0vGh55s0jgVJ9SyOIAkSWA/1rpcpxmvB5smbB5WBLuYfs7c1PnY/y
 bBTFJ/WBH0J65wGNHOX3ycqwmTQ8ZhJKUkPXzTlY+rUSkId6seiOsRX8n6LtnO2fhbRR
 OOmhuXsB906vlly0l3R183FPpQ+ddNAhPSpiBXfsJKrFYs1TS3J4eW9LqvU/jvmhtzaN
 vl75iDWh2l7uHfjFuDQ42V48zuWTM4XBX/n5VbyJZuVa2SjfJdeW+TmSvh0SwYIMpDD8
 Cev7vWT004/svm64ntBsmEx25S2ax2pHyBKPyO2/aZ7Yb10QkyNQXtKSO3cE4/hXHNLj
 KxVQ==
X-Gm-Message-State: AC+VfDyTtZxrBGwxTjWzaB2UezM0Cr2M3fPTL6L4dy6H9xjseiTZkgaF
 reYXoiMFr9i4j26LTf26aBoetdrT/lx15GCVaYlRf75W5bSLJWYepRQHiQhMjyAE33TEunFCeZz
 7xaed67tfIX8tBxY=
X-Received: by 2002:a5d:4485:0:b0:2fe:c0ea:18b4 with SMTP id
 j5-20020a5d4485000000b002fec0ea18b4mr25685621wrq.24.1684230398385; 
 Tue, 16 May 2023 02:46:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5VbT5yDFAHXE2PmHW9LdpUz7IFRi7ZXNqHLQLL04A/SXNXPs0fcRQR2Zib4jiOxG6WZY9mYg==
X-Received: by 2002:a5d:4485:0:b0:2fe:c0ea:18b4 with SMTP id
 j5-20020a5d4485000000b002fec0ea18b4mr25685608wrq.24.1684230398116; 
 Tue, 16 May 2023 02:46:38 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-218.web.vodafone.de.
 [109.43.177.218]) by smtp.gmail.com with ESMTPSA id
 l5-20020a7bc445000000b003f4b6bcbd8bsm1725031wmi.31.2023.05.16.02.46.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 02:46:37 -0700 (PDT)
Message-ID: <64cdb2e7-324e-d6c0-566e-e72905711610@redhat.com>
Date: Tue, 16 May 2023 11:46:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Mauro Matteo Cascella <mcascell@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, fam@euphon.net, philmd@linaro.org, alxndr@bu.edu,
 zheyuma97@gmail.com
References: <20230116204232.1142442-1-mcascell@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] scsi/lsi53c895a: restrict DMA engine to memory regions
 (CVE-2023-0330)
In-Reply-To: <20230116204232.1142442-1-mcascell@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.811, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 16/01/2023 21.42, Mauro Matteo Cascella wrote:
> This prevents the well known DMA-MMIO reentrancy problem (upstream issue #556)
> leading to memory corruption bugs like stack overflow or use-after-free.
> 
> Fixes: CVE-2023-0330
> Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
> Reported-by: Zheyu Ma <zheyuma97@gmail.com>
> ---

Since the generic reentrancy guard apparently cannot be used for the lsi 
controller (see commit bfd6e7ae6a72b8), I had a try with this patch, ... but 
it seems this breaks the LSI driver of Linux.

I ran QEMU like this:

./qemu-system-x86_64 -accel kvm -m 2G -machine q35 \
  -device lsi53c810,id=lsi1 -device scsi-hd,drive=d0 \
  -drive if=none,id=d0,file=.../somedisk.qcow2 \
  -cdrom Fedora-Everything-netinst-i386-25-1.3.iso

then booted into the rescue shell of the ISO image, and I was not able to 
mount a partition from somedisk.qcow2 anymore. And there were lots of error 
messages related to 53c8... in the "dmesg" output.

It seems like we indeed need some levels of reentrancy here and cannot 
simply disable it completely.

But maybe we can block it at another level. I'll try to come up with a patch...

  Thomas


