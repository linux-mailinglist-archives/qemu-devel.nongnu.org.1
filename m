Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7677500E5
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 10:13:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJUxU-0002BU-E9; Wed, 12 Jul 2023 04:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qJUxS-0002AG-5q
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 04:12:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qJUxQ-0006mF-Pw
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 04:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689149540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C76iMcGXKVEuzArDEweATQkflplYGS0ilAvmdCwTwww=;
 b=UtC3AFvx64ArY+t3ulgTO2QVgQYRrUvFlcQ3dOGJfniaU0u16gyMbdpn0TqbNFzRbQWTM4
 YEduTF2vqPyFMf3Vd4yISPisvfe4m4KFCIYeG1n7cq0+X9+EqrU9d9xyrAI8soK4NzVaN6
 3WiqirTy7p0S2Ccozbtk+HWCMgaT8bQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-HVrcBw4tN8S9_yVBPyu77A-1; Wed, 12 Jul 2023 04:12:18 -0400
X-MC-Unique: HVrcBw4tN8S9_yVBPyu77A-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-98df34aa83aso63402966b.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 01:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689149535; x=1691741535;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C76iMcGXKVEuzArDEweATQkflplYGS0ilAvmdCwTwww=;
 b=CiKxRo3J7mQmjjpRfVLrZ83r0YLfmEFC+YWosqh51E3H/ZiNI1ARclLa4HYSMv2WGB
 oyB5EVNFLcd1xTkD2eyT+KUGMMFsttXyEn42odPVbAtObMk5x51o4dT81XI8mnT7XQWm
 lE2lv1ffvFU3Dg5UVRGEtSTl6RNVgxuLNb1XB7giugKd5rEfJoSmzqlCYy4xSl7EQMs1
 05+09IeZGXXxDbx8tzZ0Im08xJV3l2L2rqzBt3OOdoGLQJCHHTBq7etxGJbjWlK2PdNs
 Njh7XLBAfqEynaDAV5UuBKk5FOk/NbOGkhTRTV9LM5r3rhiZf+PUdORLtGIY9zO4i6ZX
 svUw==
X-Gm-Message-State: ABy/qLYDr2r8L2mqSFnFnp1nObwVFIG6KzgTtpttOb5fsLATT5lNcUxu
 6F7pdAZ6dxLZBplIEk7tgPMyyceR6WScbiSV262S4dZwJeAiSn+Yb/ygjr5d2WoGv/XJ7PUzOe0
 Eq8JqCVAyULeecvt++CVBXxY=
X-Received: by 2002:a17:907:a410:b0:993:da5f:5a9b with SMTP id
 sg16-20020a170907a41000b00993da5f5a9bmr1474015ejc.8.1689149535188; 
 Wed, 12 Jul 2023 01:12:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH0bMElyudhhfgGyn8m0QOHES6sr4tUUss8j8hsIPSFz5RIw4p8Funzxz5SdWCB3oz7ggiRow==
X-Received: by 2002:a17:907:a410:b0:993:da5f:5a9b with SMTP id
 sg16-20020a170907a41000b00993da5f5a9bmr1473992ejc.8.1689149534866; 
 Wed, 12 Jul 2023 01:12:14 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.googlemail.com with ESMTPSA id
 i27-20020a170906265b00b00992076f4a01sm2201400ejc.190.2023.07.12.01.12.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 01:12:14 -0700 (PDT)
Message-ID: <2ec62ac2-763b-1211-7c25-f0513f99dd2c@redhat.com>
Date: Wed, 12 Jul 2023 10:12:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, qemu-stable@nongnu.org,
 Mark Kanda <mark.kanda@oracle.com>
References: <20230705071523.15496-1-sgarzare@redhat.com>
 <20230710153942-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230710153942-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 7/10/23 21:40, Michael S. Tsirkin wrote:
> 
> Acked-by: Michael S. Tsirkin<mst@redhat.com>
> 
> Seems safest to revert, but I'll let storage guys decide whether to
> queue this.

There are multiple possibilities:

1) it's a QEMU bug that can be fixed, so no need to revert.

2) there's both a QEMU and a Linux bug, but fixing the QEMU side is 
enough to hide the Linux bug.  The Linux bug can be fixed leisurely.

3) it's a Linux bug that is hard to fix, so we need to revert

4) it's a Linux bug that is worth fixing, but depending on how easy it 
is to trigger the issue we may or may not need to revert

But yeah, reverting is on the table.

Thanks,

Paolo


