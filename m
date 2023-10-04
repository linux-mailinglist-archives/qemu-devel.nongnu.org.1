Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB497B7D82
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 12:49:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnzRF-00041r-BR; Wed, 04 Oct 2023 06:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qnzRD-0003wz-Fy
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 06:49:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qnzR9-0002Lr-BK
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 06:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696416542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H/w2VtaiME7xfbFstUn9JTvRJYudJc6Qxswnany+tw8=;
 b=UMGfEmWWipunFvIJtKrvySE4coprY0vYO9N9jq5tYv+gSPRWcUuhwU2OGTJybveQMxx7QW
 y2VpYFuKbjbCxMPlqPEE7CNZzAr+yErbZuJJtSDQwrFKM8iGBhmtac4XROYSx/o3QN2VWC
 J41I6QLtV8Mkb+/Kgxzlb3H2UuY39f4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-RFPm_qNwNbqoPXVBUm7sNQ-1; Wed, 04 Oct 2023 06:48:50 -0400
X-MC-Unique: RFPm_qNwNbqoPXVBUm7sNQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9a9f282713fso175973466b.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 03:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696416529; x=1697021329;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H/w2VtaiME7xfbFstUn9JTvRJYudJc6Qxswnany+tw8=;
 b=WrVL5mqA2DYFYdYnKpeEr885KVrlNb08j00t56+z5HDuy9Zijo5pt0va892MKIryIT
 PqGODuu+OFRf8JnFrwCV+JSp3eQ0bHbiy1MUyLE7D2PB/RKuploGtBE2jxkDQVCt4f0S
 w54qfwNa6wrVFOqSXRQ740IKpPfW9LEQyXToP1VFsoy0MmSRlssonn6iY1Y7HelWlI2k
 VGuZGwE10+VTrha+hNENn8Q5Jpgo+ux5q5Wnul0Vwf8tMFf/txKhpUBYnpYiPM+UABWU
 2WoRFrXt0dkJzp5jPu3BeBwBYHGj09kni3BnW6pgUkfW9+xxjYXTfFS8UVTZnCkTfYU9
 7/9g==
X-Gm-Message-State: AOJu0YzOjBxegMfkCby8vUahCLy7sIZ+I00ecAtf+T+kG2S9cpTGC5Dz
 wUUrw2n78U+cNQlM8sFf/PZQ149L561uF5Jh+QeFB6iPmfh7jNrwV2c+TudTlBXWEH5ayF4gUFu
 IbVRBKhawxnOMtvA=
X-Received: by 2002:a17:906:2085:b0:9b2:b9bf:e28f with SMTP id
 5-20020a170906208500b009b2b9bfe28fmr1458987ejq.34.1696416529828; 
 Wed, 04 Oct 2023 03:48:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7f5T4LWQz3Mdn0hfV/Y3EDSVzknfWEDguFZI9mom5vOOE7Ion9hDVj7dWCj2NyebXTSMc0g==
X-Received: by 2002:a17:906:2085:b0:9b2:b9bf:e28f with SMTP id
 5-20020a170906208500b009b2b9bfe28fmr1458974ejq.34.1696416529556; 
 Wed, 04 Oct 2023 03:48:49 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 lj16-20020a170906f9d000b0099bd5d28dc4sm2570432ejb.195.2023.10.04.03.48.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 03:48:48 -0700 (PDT)
Message-ID: <228b7a27-1e16-dc9d-1a8e-1e69d2df2f77@redhat.com>
Date: Wed, 4 Oct 2023 12:48:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/3] vhost-backend: remove vhost_kernel_reset_device()
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Raphael Norwitz
 <raphael.norwitz@nutanix.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, eperezma@redhat.com,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20231004014532.1228637-1-stefanha@redhat.com>
 <20231004014532.1228637-3-stefanha@redhat.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20231004014532.1228637-3-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 04.10.23 03:45, Stefan Hajnoczi wrote:
> vhost_kernel_reset_device() invokes RESET_OWNER, which disassociates the
> owner process from the device. The device is left non-operational since
> SET_OWNER is only called once during startup in vhost_dev_init().
>
> vhost_kernel_reset_device() is never called so this latent bug never
> appears. Get rid of vhost_kernel_reset_device() for now. If someone
> needs it in the future they'll need to implement it correctly.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   hw/virtio/vhost-backend.c | 6 ------
>   1 file changed, 6 deletions(-)

The obvious way would be to immediately call SET_OWNER again, but I 
assume that just like in vhost-user, it is probably pretty much left 
undefined what exactly should happen in the back-end on RESET_OWNER, and 
so I agree that in general, starting to call this function now when we 
didn’t before is more of a liability then anything.

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


