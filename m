Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF9D7915B8
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 12:32:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd6sP-0004Pa-Gu; Mon, 04 Sep 2023 06:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qd6sA-0004P1-1E
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:32:01 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qd6s7-0005Vc-Qq
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:31:57 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-401bdff4cb4so13827195e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 03:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693823514; x=1694428314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XnNWmts93hq8y19y2f4Sj44fRytYqKQhUGuKNCPCN3o=;
 b=yObTVOx+Nx6siBzvmi/PSuqr7e5Ck0ANUK0Na0tlm6GuXpePzxysosmu9v+cwd/dIM
 7WRyBHdBKJ9r22hWUFSv2NqS7v/LvMj2AD/MjfavN9WVuJnuQ5ntpjDH5SkJZq/xG3zf
 1iBlxuq/2bYdhp7wCLWoPuhlyXr4gA4zgB5IpaRNnA4JIIXPZk9RxEGyz18iThaM11K2
 e7gYToICh1k2rID1Lk1UGBNaLYNFywMzh8JXeg3RCqm8ZPg9NlGVdabq4tUj1mSGI+R4
 6ZCPhsSB3WMZN7FDDXCiywRtSKEb/A0fq7f5qU4087bRuCQOL6eOzBy0cwZVg4OgJv9u
 4OPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693823514; x=1694428314;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XnNWmts93hq8y19y2f4Sj44fRytYqKQhUGuKNCPCN3o=;
 b=GSIgmQjdLaovxeY/IsQ/VdIgfhWT38RPXVqsG/QNBw0h3gNAquCpH19+wH2lI78HVg
 GC7HSmtf9wClffH+4+odGo3lZrMPZyte+i0MYqUk6AW8kZMSEPkmFQ2GbTwCJbOBLF8U
 8LQRDRe/z3ZZZYuta5/mgP4Wfe3NBOv10tfMCRFhDtBadV/ZemGcrGH+ubwI17iSKChQ
 gTC+PjCNxSyEp9b9lB/M3qt7qyvMTVplViKFl0jlc63t4WtzWUDzjPKq01f50UtFzDt1
 JW++kYyDY4mmyhEI+k4xI0t7dWAyZPsKBnxbkNX9vFHMrYFMzX4tQT/cPpt2VWIOyEnz
 0V3A==
X-Gm-Message-State: AOJu0Yx9acbyOJraXfVpL4/SyVTDL2BTPZwfTVQ0ulR5aYalSoMqHzF7
 v6bOOWdospLvkTo3u809iMvTyQ==
X-Google-Smtp-Source: AGHT+IEWEXoU48zDWlb6XU2SzA0/WRqbEF+jvKH/DDlBNYxsjgisH23eKUgcsalbwwoqhgLh1xu6XQ==
X-Received: by 2002:a1c:771a:0:b0:3fe:e7b2:c97f with SMTP id
 t26-20020a1c771a000000b003fee7b2c97fmr6992794wmi.36.1693823514020; 
 Mon, 04 Sep 2023 03:31:54 -0700 (PDT)
Received: from meli.delivery (adsl-194.37.6.2.tellas.gr. [37.6.2.194])
 by smtp.gmail.com with ESMTPSA id
 k15-20020a7bc40f000000b003feee8d8011sm16737199wmi.41.2023.09.04.03.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 03:31:53 -0700 (PDT)
Date: Mon, 04 Sep 2023 13:26:11 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Volker R=?UTF-8?B?w7w=?= melin <vr_qemu@t-online.de>, qemu-devel@nongnu.org
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "ichael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 "K=?UTF-8?B?xZE=?= v=?UTF-8?B?w6E=?= g=?UTF-8?B?w7M=?= ,
 Zolt=?UTF-8?B?w6E=?= n" <DirtY.iCE.hu@gmail.com>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Subject: Re: [PATCH v8 02/12] Add virtio-sound-pci device
User-Agent: meli 0.8.0
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
 <8de966a86bc21358528eeee66ffe74f8a82bb687.1693252037.git.manos.pitsidianakis@linaro.org>
 <99c231b8-8447-93a7-6a94-3a68921190ae@t-online.de>
In-Reply-To: <99c231b8-8447-93a7-6a94-3a68921190ae@t-online.de>
Message-ID: <0gil3.63jtdidrts0@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32a.google.com
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

On Mon, 04 Sep 2023 09:32, Volker Rümelin <vr_qemu@t-online.de> wrote:
>> +static Property virtio_snd_pci_properties[] = {
>> +    DEFINE_AUDIO_PROPERTIES(VirtIOSoundPCI, vdev.card),
>
>I think DEFINE_AUDIO_PROPERTIES should be moved back to virtio-snd.c. 
>The audiodev property is a virtio-sound property and not a 
>virtio-sound-pci property.

Hm, is it? Can you instantiate a virtio-sound device without the PCI 
wrapper? Under hw/audio, DEFINE_AUDIO_PROPERTIES is set in PCI devices 
as well (e.g. ac97)

>
>> +    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
>> +                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
>> +    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
>> +                       DEV_NVECTORS_UNSPECIFIED),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void virtio_snd_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>> +{
>> +    VirtIOSoundPCI *dev = VIRTIO_SND_PCI(vpci_dev);
>> +    DeviceState *vdev = DEVICE(&dev->vdev);
>> +
>> +    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
>> +        vpci_dev->nvectors = 2;
>> +    }
>
>Why do you need that intermediate step with DEV_NVECTORS_UNSPECIFIED? 
>Unlike e.g. virtio-scsi-pci and virtio-net-pci devices, the default 
>value of nvectors is already known at compile time and can be specified 
>in the property definition.

I did not think this through properly, you are correct. Thank you!

Manos

