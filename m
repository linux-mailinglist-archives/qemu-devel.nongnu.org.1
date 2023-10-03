Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D62CF7B6943
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:44:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnekz-0001jR-7d; Tue, 03 Oct 2023 08:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnekx-0001iZ-8W
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:44:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnekv-0002mS-Ls
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696337044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bp6irl+EWB1q4/By8O9wSojjNa0G3bO5LormJk6g/ms=;
 b=YZVNoHBThwIA1y6+0F1nNACxJpOoQYortDmybU/G1zvHInYsJB8PCGMgAoOzup+45qNI9J
 fLmc9iyaoh0NEjTuJX/ZPp5aqd7nl3RNkA2OSa+b0Wiz38ygTk6U1vWXgLdn4xOirGuPhe
 p/hSRsMr7SWFY5eMHPKd6WumG4ZKJL0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-dUozBUrqP9WmP707eKj3Lg-1; Tue, 03 Oct 2023 08:44:03 -0400
X-MC-Unique: dUozBUrqP9WmP707eKj3Lg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4063dd6729bso5969545e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 05:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696337042; x=1696941842;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bp6irl+EWB1q4/By8O9wSojjNa0G3bO5LormJk6g/ms=;
 b=dXbyB8Gi5ePys9q8/TAD3nuOUiedRzwtZkHJxKQwrqTMOI4S6miD7z1lYvXHQ+fLFf
 ijYAIXlAKUXmx8jK4IUKwsDHAbuXGKV2imj1hLBaFRPsMBabhfsXK8f+a3Xlxhtwn4Sc
 dHyV3tw14i0VNudcLTGCSj7iq3HQhFAEfKZzz38eAf4TVR8DViCcsOCeeZI57UUjON74
 PooLpBFqxkBFoZvAfgxGpWtTChn5cfCulsR70fqSpdk7Ghi0TLXQGxzBTZtDLyuwUnbp
 wT55+Qg0OULmTfi1UgBP6iqKyw936yTxvKOswVlGLH8BdWWtp37Hh1IxJGBd4mKqd84T
 Hu+A==
X-Gm-Message-State: AOJu0YzguFbGjA16uXLftMnYnSThD0u+uJyTIrC2Ae1b/by0G/5OZ1vN
 lu5HElHxk7NfnJxvBZ6iXNzCgF+N314bsfwtGe95V8gY9cD8duIlJ99YjfwXdP9+dVvIBVu/xMl
 UPh1nUIWmA2eQ5/k=
X-Received: by 2002:a05:600c:22d1:b0:405:3251:47a1 with SMTP id
 17-20020a05600c22d100b00405325147a1mr12970335wmg.40.1696337041898; 
 Tue, 03 Oct 2023 05:44:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9caOT9rgoPXWuz1Z5+je8xpiiK62hqlA29Bgy4tRw58eKIhZYWSiSSqT5x1xelbF63WsYzg==
X-Received: by 2002:a05:600c:22d1:b0:405:3251:47a1 with SMTP id
 17-20020a05600c22d100b00405325147a1mr12970314wmg.40.1696337041548; 
 Tue, 03 Oct 2023 05:44:01 -0700 (PDT)
Received: from redhat.com ([2.52.132.27]) by smtp.gmail.com with ESMTPSA id
 l22-20020a7bc456000000b004058e6379d8sm9416630wmi.23.2023.10.03.05.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 05:44:00 -0700 (PDT)
Date: Tue, 3 Oct 2023 08:43:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, jasowang@redhat.com,
 lvivier@redhat.com
Subject: Re: [PATCH] vhost: Add a defensive check in vhost_commit against
 wrong deallocation
Message-ID: <20231003084047-mutt-send-email-mst@kernel.org>
References: <20230913074657.523530-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913074657.523530-1-eric.auger@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 13, 2023 at 09:46:57AM +0200, Eric Auger wrote:
> In vhost_commit(), it may happen that dev->mem_sections and
> dev->tmp_sections are equal,

Could you please explain a bit more how this can happen?
I don't see how.

> in which case, unconditionally
> freeing old_sections at the end of the function will also free
> dev->mem_sections used on subsequent call leading to a segmentation
> fault.
> 
> Check this situation before deallocating memory.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Fixes: c44317efecb2 ("vhost: Build temporary section list and deref
> after commit")
> CC: QEMU Stable <qemu-stable@nongnu.org>
> 
> ---
> 
> This SIGSEV condition can be reproduced with
> https://lore.kernel.org/all/20230904080451.424731-1-eric.auger@redhat.com/#r
> This is most probably happening in a situation where the memory API is
> used in a wrong manner but well.

sounds like misusing the memory API can lead to all kind of mischief.

> ---
>  hw/virtio/vhost.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index e2f6ffb446..c02c599ef0 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -545,6 +545,11 @@ static void vhost_commit(MemoryListener *listener)
>      dev->mem_sections = dev->tmp_sections;
>      dev->n_mem_sections = dev->n_tmp_sections;
>  
> +    if (old_sections == dev->mem_sections) {
> +        assert(n_old_sections ==  dev->n_mem_sections);
> +        return;
> +    }
> +
>      if (dev->n_mem_sections != n_old_sections) {
>          changed = true;
>      } else {
> -- 
> 2.41.0


