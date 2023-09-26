Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 590357AEB6B
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 13:24:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql6AX-0004VB-KU; Tue, 26 Sep 2023 07:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1ql6AU-0004Tf-JF
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:23:54 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1ql6AR-00040l-4k
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:23:54 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-991c786369cso1029996366b.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 04:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695727429; x=1696332229; darn=nongnu.org;
 h=content-transfer-encoding:organization:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nm20C0Aigymb/jcI46Gxfp/COqzQsE6pYT/7Tn3bfvw=;
 b=BOrJxltPsqz46zy+dc6QkCaq7SVyQc1+J5HOI/8Jo7dRJh8QOJZSD7mQscFwqWH5qf
 3e2V04JG1AV3N9cda8QJV9ZtbCTU/4WoAwIV50vPMpX3Jo/2y25+Lq6q9IbR08qH8El0
 6XeqqSAM5rgPsMrkVTDEv5XhcTFAo2NV1Y0Pvy7U4roPCeqzCytzrQQbpsJ9vx07+SgW
 9mDlrb34KzjJufpT5vfeJZXLha326dZHDCfM1BgpQ63kYcZMoSZhavcFAw4VHWK8Qs6V
 xpyGUd6FwyxRx4YmzckRgXBRybRls+CR0flZKUTZKL3kC9NWXSDscjo1Oj+7CyZ6YUE1
 UAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695727429; x=1696332229;
 h=content-transfer-encoding:organization:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nm20C0Aigymb/jcI46Gxfp/COqzQsE6pYT/7Tn3bfvw=;
 b=aer3n0JaPDJbX0dDErrmOyiZPG3BzrdQ9JqsK/DrZqE/84IN2sikACs5kRHjMITaq9
 Y++EgZk6pFaSFmv8ZdJ4HEmhnoHUKmAwqZPkaEf0nXyYJXWLkCuZnIgpHwU5IqbrNNnI
 RwD65PWUUw4toIbRYX+2xQiu7U000l0dGb/Av1IcHNu1tTVCX0xjgWptj7zrUxlz+ykk
 6YbCRKOXTaGlDNnILq59i6ndPRpu65z2TzyAqaAJsGZEXew3Q7MHSUdhJ/WUXWfAIU8k
 5N75Lvs8I3gALgBPWwEESLbLJbg69jh0LFyWskfZLsHlXz4dZtKM2yfUSamwrckLLw9Z
 5x2A==
X-Gm-Message-State: AOJu0YwPuVXn6myr3Mak/HK06Xws3965zW/+wLy6Wr9+E6e+HGJEbaMH
 yOPr1fUquJqzJUkRrvmsKd9tBHj6SU74apHY2K8jO67f
X-Google-Smtp-Source: AGHT+IGPxlgLMvrHzGPCrjj2IzH1m2ecx0rr1LITfzRILUwA6jLetczamRzAqbIyCF5kgjESvfJ+yA==
X-Received: by 2002:a17:907:75ce:b0:99c:c50f:7fb4 with SMTP id
 jl14-20020a17090775ce00b0099cc50f7fb4mr7509034ejc.1.1695727428866; 
 Tue, 26 Sep 2023 04:23:48 -0700 (PDT)
Received: from [192.168.200.206] (83.11.3.58.ipv4.supernova.orange.pl.
 [83.11.3.58]) by smtp.gmail.com with ESMTPSA id
 rv7-20020a17090710c700b009adc81bb544sm7619368ejb.106.2023.09.26.04.23.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 04:23:48 -0700 (PDT)
Message-ID: <b7e00b36-2ac8-44fa-9847-b2025ebe05f6@linaro.org>
Date: Tue, 26 Sep 2023 13:23:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: pl-PL, en-GB, en-HK
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Niklas Cassel <nks@flawful.org>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Ard Biesheuvel <ardb+tianocore@kernel.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: FreeBSD 13.2 installer does not see AHCI devices on aarch64/sbsa-ref
 and x86-64/q35
Organization: Linaro
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

I work on SBSA Reference Platform (sbsa-ref) at Linaro. And yesterday I
wanted to check how non-Linux operating systems work on sbsa-ref machine.

One of them was FreeBSD 13.2 - the latest one. Fetched bootonly ISO
image [1] and booted system.

1. https://download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/13.2/FreeBSD-13.2-RELEASE-arm64-aarch64-bootonly.iso

QEMU command line arguments:

-drive if=ide,file=disks/FreeBSD-13.2-RELEASE-arm64-aarch64-bootonly.iso,media=cdrom
-machine sbsa-ref
-m 4096
-smp 2
-cpu neoverse-n1
-drive file=fat:rw:/home/marcin/devel/linaro/sbsa-qemu/sbsa-ref-status/disks/virtual/,format=raw
-drive format=raw,file=/home/marcin/devel/linaro/sbsa-qemu/sbsa-ref-status/disks/full-debian.hddimg
-watchdog-action none
-no-reboot
-monitor telnet::45454,server,nowait
-serial stdio
-device igb
-nographic
-drive if=pflash,file=SBSA_FLASH0.fd,format=raw
-drive if=pflash,file=SBSA_FLASH1.fd,format=raw


Firmware loaded FreeBSD loader, kernel booted but it does not see
any AHCI devices:

ahci0: <AHCI SATA controller> iomem 0x60100000-0x6010ffff irq 1 on acpi0
ahci0: AHCI v1.00 with 6 1.5Gbps ports, Port Multiplier not supported
ahci0: Caps: 64bit NCQ 1.5Gbps 32cmd 6ports
ahcich0: <AHCI channel> at channel 0 on ahci0
ahcich0: Caps:
[..]
ahcich0: AHCI reset...
ahcich0: SATA connect time=0us status=00000113
ahcich0: AHCI reset: device found
ahcich0: AHCI reset: device ready after 0ms
ahcich1: AHCI reset...
ahcich1: SATA connect time=0us status=00000113
ahcich1: AHCI reset: device found
ahcich1: AHCI reset: device ready after 0ms
ahcich2: AHCI reset...
ahcich2: SATA connect time=0us status=00000113
ahcich2: AHCI reset: device found
ahcich2: AHCI reset: device ready after 0ms
[..]
Trying to mount root from cd9660:/dev/iso9660/13_2_RELEASE_AARCH64_BO [ro]...
Root mount waiting for: CAM
[..]
Root mount waiting for: CAM
ahcich0: Poll timeout on slot 1 port 0
ahcich0: is 00000000 cs 00000002 ss 00000000 rs 00000002 tfd 170 serr 00000000 cmd 0000c017

And finally it gives up.


v8.1.1 was bad, v8.0.5 was bad so I did git bisecting.
Which gave me this commit:

commit 7bcd32128b227cee1fb39ff242d486ed9fff7648
Author: Niklas Cassel <niklas.cassel@wdc.com>
Date:   Fri Jun 9 16:08:40 2023 +0200

     hw/ide/ahci: simplify and document PxCI handling

     The AHCI spec states that:
     For NCQ, PxCI is cleared on command queued successfully.



I built x86_64-softmmu target and checked both "pc" and "q35"
machines.

./build/x86_64-softmmu/qemu-system-x86_64
-cdrom FreeBSD-13.2-RELEASE-amd64-bootonly.iso
-m 2048 -serial stdio  -monitor telnet::45454,server,nowait

PC target ("-M pc") booted fine. But Q35 ("-M q35") failed
similar way as aarch64/sbsa-ref did:

ahci0: <Intel ICH9 AHCI SATA controller> port 0xc060-0xc07f mem 0xfebd5000-0xfebd5fff irq 16 at device 31.2 on pci0
ahci0: attempting to allocate 1 MSI vectors (1 supported)
msi: routing MSI IRQ 26 to local APIC 0 vector 52
ahci0: using IRQ 26 for MSI
ahci0: AHCI v1.00 with 6 1.5Gbps ports, Port Multiplier not supported
ahci0: Caps: 64bit NCQ 1.5Gbps 32cmd 6ports
ahcich0: <AHCI channel> at channel 0 on ahci0
ahcich0: Caps:
ahcich1: <AHCI channel> at channel 1 on ahci0
ahcich1: Caps:
ahcich2: <AHCI channel> at channel 2 on ahci0
ahcich2: Caps:
[..]
ahcich2: AHCI reset...
ahcich2: SATA connect time=0us status=00000113
ahcich2: AHCI reset: device found
ahcich2: AHCI reset: device ready after 0ms
[..]
Trying to mount root from cd9660:/dev/iso9660/13_2_RELEASE_AMD64_BO [ro]...
ahcich2: Poll timeout on slot 1 port 0
ahcich2: is 00000000 cs 00000002 ss 00000000 rs 00000002 tfd 170 serr 00000000 cmd 0000c017
(aprobe2:ahcich2:0:0:0): SOFT_RESET. ACB: 00 00 00 00 00 00 00 00 00 00 00 00
(aprobe2:ahcich2:0:0:0): CAM status: Command timeout
(aprobe2:ahcich2:0:0:0): Error 5, Retries exhausted
ahcich2: Poll timeout on slot 2 port 0
ahcich2: is 00000000 cs 00000006 ss 00000000 rs 00000004 tfd 170 serr 00000000 cmd 0000c017
(aprobe2:ahcich2:0:0:0): SOFT_RESET. ACB: 00 00 00 00 00 00 00 00 00 00 00 00
(aprobe2:ahcich2:0:0:0): CAM status: Command timeout
(aprobe2:ahcich2:0:0:0): Error 5, Retries exhausted
mountroot: waiting for device /dev/iso9660/13_2_RELEASE_AMD64_BO...
Mounting from cd9660:/dev/iso9660/13_2_RELEASE_AMD64_BO failed with error 19.

Same thing happens with current qemu HEAD:

commit 494a6a2cf7f775d2c20fd6df9601e30606cc2014
Merge: 29578f5757 b821109583
Author: Stefan Hajnoczi <stefanha@redhat.com>
Date:   Mon Sep 25 10:10:30 2023 -0400

     Merge tag 'pull-request-2023-09-25' of https://gitlab.com/thuth/qemu into staging


Any ideas?

