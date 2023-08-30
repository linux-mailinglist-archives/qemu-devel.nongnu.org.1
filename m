Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D741178D416
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 10:24:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbGTg-0004Hl-Nm; Wed, 30 Aug 2023 04:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qbGTe-0004HM-GS
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:23:02 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qbGTZ-0002OB-3H
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:23:01 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50043cf2e29so8219799e87.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 01:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693383775; x=1693988575; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=3MHYzLT29b91n+PztaYFJfltDPpZKVrYcVws59a3o5A=;
 b=Rl0h2FYiZI0nWRjYsmjbNwNmlET6tiw2IawbPr6hCtEFElvmOt5aaqeiUC0s5EmXhC
 nOS+kt7p9zeE+btc2p16GeDFb4geCBIWPNemzsy+QjdO0tBeiPLbVG/dl+x0e1kmvxr6
 od3ctph2gDfPouz0Ph2wvF0XlkVvpju96dRictmMyHCmJT/HWx0hvvdFtxIokBSRi76X
 6cbhA9CdnUyrIQ/c4jt4Pb+dJfRD7GTU6zqiIN3tB9kSmd0G/9ZQ0xbD79G/+99nfB7C
 pL9Wdw/sSTxKP5REeiiolu5j/iQr8wTfPepXCc7iO3mzaIDprpu/9bRgA4cg0ynEj3Lh
 QXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693383775; x=1693988575;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3MHYzLT29b91n+PztaYFJfltDPpZKVrYcVws59a3o5A=;
 b=GfA11pdiuXSOiytqBjKWKHLN5WtQm8C03L1gzFbGOdx7SqnayMnqU6e0sUDyNWj8x5
 JGw68DcwW2IUa0JCaKmfpYt/4xhLVRrsgCvR2zxUT4dXPamI6Muv/Gt5znkeo9pXLXNJ
 RtZOOFLqntTUTI9Pv1MN53X3aR4J5aTmczSvtasKGplcWRk+QQZDYswgPf/P3Q9pV7fH
 0I89Pf5tI1jbDfQcz9mL0z9UBDXiUyciDhSsmGXAzsjyA9Wvq7pBpKjY60xuCGU5DnQV
 84LWqOtH02i/AK+9j094avL0hXd8FsdRgiY55hFmFoUWaU7QZJo51uWP+oo4bNSPFPA7
 De+Q==
X-Gm-Message-State: AOJu0YyQfSh689Bhl7KYfqYIkKE29yAzcRVX6wEWxKB+SGdeEsj6ZNUa
 4XlG33zXGrcVPYJ0Y+PYXMbOjA==
X-Google-Smtp-Source: AGHT+IFwFGuNrlR4UoKlTyaXjvAaVzchGJvl26wUVOFj95cvFP3lOflA/3wn8qhPfvffNkz+yuiAIQ==
X-Received: by 2002:a05:6512:234d:b0:4fb:52a3:e809 with SMTP id
 p13-20020a056512234d00b004fb52a3e809mr1132024lfu.28.1693383775067; 
 Wed, 30 Aug 2023 01:22:55 -0700 (PDT)
Received: from [192.168.200.206] (83.11.188.80.ipv4.supernova.orange.pl.
 [83.11.188.80]) by smtp.gmail.com with ESMTPSA id
 c2-20020ac25302000000b005008cd9396bsm2268860lfh.25.2023.08.30.01.22.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 01:22:54 -0700 (PDT)
Message-ID: <86c5e07d-58f0-41a0-f497-bd236691188b@linaro.org>
Date: Wed, 30 Aug 2023 10:22:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PCIe: SLT attribute mismatch: 0xFF020100 instead of 0x20100
Content-Language: pl-PL, en-GB, en-HK
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Gowtham Siddarth <gowtham.siddarth@arm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <56aa4acb-d54c-a457-5a32-9258cec1ac96@linaro.org>
 <CAFEAcA81xq_yEXYdtAXtkqcdR=MHagSNf5rXOtt+AwohMY_=BQ@mail.gmail.com>
 <20230829093909-mutt-send-email-mst@kernel.org>
 <43653986-c04f-0076-637b-9061f9702f77@linaro.org>
 <20230829130617-mutt-send-email-mst@kernel.org>
 <ff230439-5d76-1f50-a25a-1fd666c3f369@linaro.org>
 <20230829161732-mutt-send-email-mst@kernel.org>
 <601619fb-5f1e-4b93-3dd1-b415d0ee8979@linaro.org>
 <20230829163929-mutt-send-email-mst@kernel.org>
 <fd3665ae-da56-9d86-ff91-b1efa107671b@linaro.org>
 <20230829164638-mutt-send-email-mst@kernel.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <20230829164638-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

W dniu 29.08.2023 o 22:46, Michael S. Tsirkin pisze:
> On Tue, Aug 29, 2023 at 10:44:08PM +0200, Marcin Juszkiewicz wrote:
>> W dniu 29.08.2023 o 22:40, Michael S. Tsirkin pisze:
>>>> It passes with sbsa-ref (which is not using QEMU versioning).
>>>>
>>>> Fails (as expected) when used new property for each pcie-root-port
>>>> (ignore line breaks):
>>>>
>>>> "-device pcie-root-port,
>>>>     x-pci-express-writeable-slt-bug=true,
>>>>     id=root30,chassis=30,slot=0"
>>>
>>> could you also check with -machine pc-q35-8.1 instead of this
>>> property?
>>
>> BSA ACS is AArch64 only.
> 
> virt-8.1 then

Passes for virt, virt-8.1 and virt-8.0 machines.

./code/qemu/build/aarch64-softmmu/qemu-system-aarch64 \
  -machine virt-8.0 \
  -m 4096  \
  -cpu neoverse-n1 \
  -smp 2 \
  -drive if=pflash,format=raw,file=QEMU_EFI.fd \
  -drive if=pflash,format=raw,file=QEMU_EFI-vars.fd \
-drive file=fat:rw:$PWD/disks/virtual/,format=raw \
-device pcie-root-port,id=root30,chassis=30,slot=0 \
-device igb,bus=root30 \
  -device qemu-xhci,id=usb \
  -device bochs-display \
  -device e1000e \
-nographic \
  -usb \
  -device usb-kbd \
  -device usb-tablet \
  -monitor telnet::45454,server,nowait \
  -serial stdio



