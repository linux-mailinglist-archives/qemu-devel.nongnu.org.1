Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C02CC774EAC
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 00:52:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTVYa-0003lh-VV; Tue, 08 Aug 2023 18:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maverickk1778@gmail.com>)
 id 1qTVYY-0003lU-GS
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 18:52:02 -0400
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maverickk1778@gmail.com>)
 id 1qTVYW-0006sG-OE
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 18:52:02 -0400
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-790ab117bd5so212886439f.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 15:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691535118; x=1692139918;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=B7EKwglenhakd2igRLrP6qwv65F4gW6aaRMaw2PLT40=;
 b=c6HGs5NkpTF2DDv+9cqnHyh30YOi4fjlDCZN7ekgywxAaFrTwxLJooK0FIzD0IFekJ
 ckNwlk6YldOibWJvaAsFa6kaKjWh/lZNuLtLoVlLjKaleGGuZdKns/6Hd2Y5nrYj/2Ta
 mfF4b4+imcRb+PMSuFdCwzJYh5OuUvH4e+il8txgezxTZs/ZDJ+Je6/p0sBxE60hWQKy
 qtt+1uPSK49RR0JHeizbHrMwn4U56VzbHRfbZYBUXQ3fLI/ooU2njCDt9eANdUhhrZEI
 uo2iyFdKCqZN57nzNfLgRzy76a6p2VEWUupUomfbfjLlTLcmA/nxOu0D1yroqVIFuptx
 hLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691535118; x=1692139918;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B7EKwglenhakd2igRLrP6qwv65F4gW6aaRMaw2PLT40=;
 b=lk+c3PVJXHtXceF8Jmb0KhmOQHHbdS1dFiC/45+r6FObxVmovnqJ2mOoQF1OJSfHIs
 GCGgLgtxDIH31TqduooUOYlSpDsKs7ecFGSWxZShzX3+g++XNE/t7zfxe9gGOYtv/On2
 Qv3ZBMesBLkNGodFKOYVfThtXcjwjWs35zsjJV5PA3CHBxPXlcI4XElnCrk+MGC0Bhno
 gaOZZk+IPPBswfl/YdA8J4J7GIdPzM5y+TM0SF90AdrcPRpFIc9CGkkCFbWl0oU5gVKq
 CYp10VZRq0T2sj7fI838qoBqahvrQd6hPQJOr/94B571smUmC3KIsMr4v6a63wvfeHs9
 G1og==
X-Gm-Message-State: AOJu0YxgguDnJXneMH/MoPBbBQgfJj6Qs0cR3cGcWkNSzzDd8qe/q3q5
 B9cBiVZA4+ZxmKiNLn3OIj5No9jMzgq1HFph1OFNvBVRW4Q=
X-Google-Smtp-Source: AGHT+IGqeEnysR4NPTO42DgksaCikePByfC1aM8L1y3y3kaqWwbohdq+vDq6cPhsKNzaAZsa9ADroD3U5tsQXWohDGA=
X-Received: by 2002:a6b:5c12:0:b0:790:fab3:2052 with SMTP id
 z18-20020a6b5c12000000b00790fab32052mr1138792ioh.5.1691535117767; Tue, 08 Aug
 2023 15:51:57 -0700 (PDT)
MIME-Version: 1.0
From: Maverickk 78 <maverickk1778@gmail.com>
Date: Wed, 9 Aug 2023 04:21:47 +0530
Message-ID: <CALfBBTtUtydebmJuh6JZ5RAXZfx5OgJ+RCug1apbZa4mm17rJQ@mail.gmail.com>
Subject: CXL volatile memory is not listed
To: Jonathan Cameron via <qemu-devel@nongnu.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2b;
 envelope-from=maverickk1778@gmail.com; helo=mail-io1-xd2b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

I am running qemu-system-x86_64

qemu-system-x86_64 --version
QEMU emulator version 8.0.92 (v8.1.0-rc2-80-g0450cf0897)

qemu-system-x86_64 \
-m 2G,slots=4,maxmem=4G \
-smp 4 \
-machine type=q35,accel=kvm,cxl=on \
-enable-kvm \
-nographic \
-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
-object memory-backend-file,id=mem0,mem-path=/tmp/mem0,size=1G,share=true \
-device cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0 \
-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=1G


I was expecting the CXL memory to be listed in "System Ram", the lsmem
shows only 2G memory which is System RAM, it's not listing the CXL
memory.

Do I need to pass any particular parameter in the kernel command line?

Is there any documentation available? I followed the inputs provided in

https://lore.kernel.org/linux-mm/Y+CSOeHVLKudN0A6@kroah.com/T/

Is there any documentation/blog listed?

