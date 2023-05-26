Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4CC712A74
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:17:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2a6w-0005A3-PU; Fri, 26 May 2023 12:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2a6Z-00059E-RC
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:15:59 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2a6X-0004Gj-U8
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:15:51 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-64d3fbb8c1cso1311077b3a.3
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685117747; x=1687709747;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9jV4/BYEdcjuF8yaNFIke23zmTuRLb1apLAvv73BGeE=;
 b=ugAnrS9bDCqdunO7yMeqOn2f8DfVTmonpt/CDxqDTAPCKFEsH3cDmcHHP9BzCKj9LR
 YLwVNoSI6OCJylqWcA1VlObR1EsskZq9Vo8iHMqjIWuFnAbgIlogyafLAqQMPbTb+MRX
 MCJdftY4aoq3IkvXW6h0C9h6uivHHpVbfgg5PvOxG/7cHcFqCjgAMqJF+pDZifdWPVbQ
 HZOimSX6RTsKDVJdaUmZWwihn7A8ujauYKK01kAlk4fiO9qo+qCBSTeKB40ZaXtRWHRg
 X98Ov+BjHZAZTr8sV5Dx83PvfT2T4xCMa3RuTT3ERn+Mig+VLSmINW5K2JASMnfUEXfT
 1EvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685117747; x=1687709747;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9jV4/BYEdcjuF8yaNFIke23zmTuRLb1apLAvv73BGeE=;
 b=GT5v18kOHIwGNjBrR37MyYUIOPxzI263Wy4H7od3pKM6ZQTEyxkzyirt0pSuveIk7a
 a+NgKnKlupFhMsIur0bdToWIZapqp+V6FrNBFCLCO69j3U3WR5iaUR+9STwpTmuRDdbt
 3xwhjKJSd++KD7ppkz6nxzIQZELKsIqO7KY8lCezO/hbAc8ppXugIcaZzzR25+YbKNS1
 ZU4tBwV7td34dwVfW+/LcjelfzBqRIl8f4/ko0A+tFf8vPZTUOonqfLkjnb4Si/Cr/60
 5KRQCxxOD6+b+PMhXW8foZ0FoepCqhBqaJnHRHoEklqA1UbGqMdFQVQjAA8BIywtOSI2
 HLqQ==
X-Gm-Message-State: AC+VfDxBKfWjaYTFHaClKUJj19AOQVYTtYxTBxUvpi6wpz0UrhDLc2pb
 7krFKAMEOPyZWq6JfNROzJDLhg==
X-Google-Smtp-Source: ACHHUZ7HqDcNK7TpdQ5GKgGggk+16zxzIcqTEhLivjIPwh6oQi/Jqaevr0ZDx0oc9UuAqxGgSGAYIg==
X-Received: by 2002:a05:6a21:980d:b0:10d:d0cd:c1c7 with SMTP id
 ue13-20020a056a21980d00b0010dd0cdc1c7mr2257792pzb.15.1685117746701; 
 Fri, 26 May 2023 09:15:46 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:86cc:4482:68db:2c0f?
 ([2602:ae:1598:4c01:86cc:4482:68db:2c0f])
 by smtp.gmail.com with ESMTPSA id
 oj16-20020a17090b4d9000b00252a7b73486sm2993188pjb.29.2023.05.26.09.15.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 09:15:46 -0700 (PDT)
Message-ID: <fdfdaa79-8d86-64e7-007f-07e424ac0b80@linaro.org>
Date: Fri, 26 May 2023 09:15:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 10/10] accel/tcg: include cs_base in our hash
 calculations
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20230524133952.3971948-1-alex.bennee@linaro.org>
 <20230524133952.3971948-11-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230524133952.3971948-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 5/24/23 06:39, Alex Bennée wrote:
> We weren't using cs_base in the hash calculations before. Since the
> arm front end moved a chunk of flags in a378206a20 (target/arm: Move
> mode specific TB flags to tb->cs_base) they comprise of an important
> part of the execution state.
> 
> Widen the tb_hash_func to include cs_base and expand to qemu_xxhash8()
> to accommodate it.
> 
> My initial benchmark shows very little difference in the
> runtime.
> 
> Before:
> 
> armhf
> 
> ➜  hyperfine -w 2 -m 20 "./arm-softmmu/qemu-system-arm -cpu cortex-a15 -machine type=virt,highmem=off -display none -m 2048 -serial mon:stdio -netdev user,id=unet,hostfwd=tcp::2222-:22 -device virtio-net-pci,netdev=unet -device virtio-scsi-pci -blockdev driver=raw,node-name=hd,discard=unmap,file.driver=host_device,file.filename=/dev/zen-disk/debian-bullseye-armhf -device scsi-hd,drive=hd -smp 4 -kernel /home/alex/lsrc/linux.git/builds/arm/arch/arm/boot/zImage -append 'console=ttyAMA0 root=/dev/sda2 systemd.unit=benchmark.service' -snapshot"
> Benchmark 1: ./arm-softmmu/qemu-system-arm -cpu cortex-a15 -machine type=virt,highmem=off -display none -m 2048 -serial mon:stdio -netdev user,id=unet,hostfwd=tcp::2222-:22 -device virtio-net-pci,netdev=unet -device virtio-scsi-pci -blockdev driver=raw,node-name=hd,discard=unmap,file.driver=host_device,file.filename=/dev/zen-disk/debian-bullseye-armhf -device scsi-hd,drive=hd -smp 4 -kernel /home/alex/lsrc/linux.git/builds/arm/arch/arm/boot/zImage -append 'console=ttyAMA0 root=/dev/sda2 systemd.unit=benchmark.service' -snapshot
>    Time (mean ± σ):     24.627 s ±  2.708 s    [User: 34.309 s, System: 1.797 s]
>    Range (min … max):   22.345 s … 29.864 s    20 runs
> 
> arm64
> 
> ➜  hyperfine -w 2 -n 20 "./qemu-system-aarch64 -cpu max,pauth-impdef=on -machine type=virt,virtualization=on,gic-version=3 -display none -serial mon:stdio -netdev user,id=unet,hostfwd=tcp::2222-:22,hostfwd=tcp::1234-:1234 -device virtio-net-pci,netdev=unet -device virtio-scsi-pci -blockdev driver=raw,node-name=hd,discard=unmap,file.driver=host_device,file.filename=/dev/zen-disk/debian-bullseye-arm64 -device scsi-hd,drive=hd -smp 4 -kernel ~/lsrc/linux.git/builds/arm64/arch/arm64/boot/Image.gz -append 'console=ttyAMA0 root=/dev/sda2 systemd.unit=benchmark-pigz.service' -snapshot"
> Benchmark 1: 20
>    Time (mean ± σ):     62.559 s ±  2.917 s    [User: 189.115 s, System: 4.089 s]
>    Range (min … max):   59.997 s … 70.153 s    10 runs
> 
> After:
> 
> armhf
> 
> Benchmark 1: ./arm-softmmu/qemu-system-arm -cpu cortex-a15 -machine type=virt,highmem=off -display none -m 2048 -serial mon:stdio -netdev user,id=unet,hostfwd=tcp::2222-:22 -device virtio-net-pci,netdev=unet -device virtio-scsi-pci -blockdev driver=raw,node-name=hd,discard=unmap,file.driver=host_device,file.filename=/dev/zen-disk/debian-bullseye-armhf -device scsi-hd,drive=hd -smp 4 -kernel /home/alex/lsrc/linux.git/builds/arm/arch/arm/boot/zImage -append 'console=ttyAMA0 root=/dev/sda2 systemd.unit=benchmark.service' -snapshot
>    Time (mean ± σ):     24.223 s ±  2.151 s    [User: 34.284 s, System: 1.906 s]
>    Range (min … max):   22.000 s … 28.476 s    20 runs
> 
> arm64
> 
> hyperfine -w 2 -n 20 "./qemu-system-aarch64 -cpu max,pauth-impdef=on -machine type=virt,virtualization=on,gic-version=3 -display none -serial mon:stdio -netdev user,id=unet,hostfwd=tcp::2222-:22,hostfwd=tcp::1234-:1234 -device virtio-net-pci,netdev=unet -device virtio-scsi-pci -blockdev driver=raw,node-name=hd,discard=unmap,file.driver=host_device,file.filename=/dev/zen-disk/debian-bullseye-arm64 -device scsi-hd,drive=hd -smp 4 -kernel ~/lsrc/linux.git/builds/arm64/arch/arm64/boot/Image.gz -append 'console=ttyAMA0 root=/dev/sda2 systemd.unit=benchmark-pigz.service' -snapshot"
> Benchmark 1: 20
>    Time (mean ± σ):     62.769 s ±  1.978 s    [User: 188.431 s, System: 5.269 s]
>    Range (min … max):   60.285 s … 66.868 s    10 runs
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> Message-Id:<20230523125000.3674739-11-alex.bennee@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

