Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B53830396
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 11:30:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ3Ae-0007lN-UT; Wed, 17 Jan 2024 05:29:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQ3Ab-0007k6-Cv
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 05:29:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQ3AZ-0002RZ-5s
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 05:29:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705487354;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ronjSXsDMZEFM2S3ZGqOkMKA1GmE7cL7E4Aq9ZEyCkk=;
 b=WJJquBl1h0KmKISGvET5hsDX9K7nJ6ni/oyQKa8JC0EDUNJXxUAL+gOkvlAaBQjo/9ONdp
 9kvudjEQRCME/b9EM5N/bs/mxzYWrgS1euCEavhITTHggCMe7t8LXtPCSLOjqW5g/l0p4W
 r1XF9eOnyDYkD+TW5+u64N2Z7uw3EFo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-JBORJS_4OAy_Yk7yF01kIg-1; Wed, 17 Jan 2024 05:29:12 -0500
X-MC-Unique: JBORJS_4OAy_Yk7yF01kIg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-68183d81339so2556776d6.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 02:29:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705487352; x=1706092152;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ronjSXsDMZEFM2S3ZGqOkMKA1GmE7cL7E4Aq9ZEyCkk=;
 b=uso6UH1BKuPox301GWkGv3NYi0+F9XKb1Vu0R/0t9G940uO0je8V6rCdCN/Q9fvXpM
 uo+UsG+tNtzY9+PcUEsVPB5vKMWW/9xHg9+MOlQKr6yBvEq+0IOjzZOwrXsOW70J8DF7
 7y9P9mTF2Zw28cBTTZ930CPlgih7WmcvVeY7RzJCG6A41WsjBMZ26DpHN5fm5FuTfmyU
 TXnVCTj/CLSJKiwIpQ0Pafcz1IFAKLpo5+BXIfEN9hHCfE7/ylAVt14zfkupYkIl5vuk
 Yojel+Mqb5bwL6inlEsJUMFRcrUtxO1fTxaNuWJ/aj9VDVwALIk6JMob40Sw3hleNvbs
 Fbrg==
X-Gm-Message-State: AOJu0Yz4ogPxYqsE2zlGP8lPiCDz/yQHSseRi7Gj1B5PcDywZ2PpVuoj
 cGi9mg8EUjJQSzKrUM+mR8AWBQSakUZbnyMi7g9sQO6mZKy9s/oq1O7GGlOVP/J50N3IAdwHqOI
 /R9Rd4UPwV7unPhydt452m2FeSaUqWUDytv0Y5w9zaIE+z71IJuJu
X-Received: by 2002:ad4:5b84:0:b0:681:6877:f815 with SMTP id
 4-20020ad45b84000000b006816877f815mr682395qvp.57.1705487352288; 
 Wed, 17 Jan 2024 02:29:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGd09PuVvfrBhMz8QqoCZYccFDY2878aRl0xGsyRFM5U2OoiOASJWYpEi3UJYKfXeGAm/NXgA==
X-Received: by 2002:ad4:5b84:0:b0:681:6877:f815 with SMTP id
 4-20020ad45b84000000b006816877f815mr682385qvp.57.1705487352087; 
 Wed, 17 Jan 2024 02:29:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a0cec8e000000b0068173c2ff1fsm1056819qvo.78.2024.01.17.02.29.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 02:29:09 -0800 (PST)
Message-ID: <2cad020f-73b4-48ac-87ab-6ed965fe4cf5@redhat.com>
Date: Wed, 17 Jan 2024 11:29:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] intel_iommu: Reset vIOMMU after all the rest of
 devices
Content-Language: en-US
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20240117091559.144730-1-peterx@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240117091559.144730-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Peter,

On 1/17/24 10:15, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
>
> There're issue reported that when syetem_reset the VM with an intel iommu
system_reset
> device and MT2892 PF(mlx5_core driver), the host kernel throws DMAR error.
>
>   https://issues.redhat.com/browse/RHEL-7188
>
> Alex quickly spot a possible issue on ordering of device resets.
>
> It's verified by our QE team then that it is indeed the root cause of the
> problem.  Consider when vIOMMU is reset before a VFIO device in a system
> reset: the device can be doing DMAs even if the vIOMMU is gone; in this
> specific context it means the shadow mapping can already be completely
> destroyed.  Host will see these DMAs as malicious and report.
That's curious we did not get this earlier?
>
> To fix it, we'll need to make sure all devices under the vIOMMU device
> hierachy will be reset before the vIOMMU itself.  There's plenty of trick
> inside, one can get those by reading the last patch.
Not sure what you meant here ;-)
>
> I didn't check other vIOMMUs, but this series should fix the issue for VT-d
> as of now.  The solution can be slightly ugly, but a beautiful one can be
> very non-trivial.
>
> Review comments welcomed, thanks.
Thanks

Eric
>
> Peter Xu (4):
>   reset: qemu_register_reset_one()
>   reset: Allow multiple stages of system resets
>   intel_iommu: Tear down address spaces before IOMMU reset
>   intel_iommu: Reset vIOMMU at the last stage of system reset
>
>  include/sysemu/reset.h |  5 ++++
>  hw/core/reset.c        | 67 ++++++++++++++++++++++++++++++------------
>  hw/i386/intel_iommu.c  | 56 +++++++++++++++++++++++++++++++++--
>  3 files changed, 107 insertions(+), 21 deletions(-)
>


