Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA137DCC6B
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 12:56:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxnKk-0006Mh-8G; Tue, 31 Oct 2023 07:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qxnKi-0006Kn-GF
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qxnKg-00087X-Hj
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698753293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v5jvvhL/ocH8Dp9vpdoh1oirov3TATFg8bc5Pjfo7EA=;
 b=OqsiM03R4miTqNgqkvHFtwRkw9N4GulJ311v6ByuAM/gev+nKgLT5AWYO1qNEUzAx6azJk
 x8ZPfG4HdGFUM4hXC+EmRgYxeXVJ/nH7ydDZAFlZ1pw2N5I2URs53QVICfe0252UrUDcEu
 MmfVt+Oe9cfMekTG6CUeTwiJ4YKmWO0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-mKxDYVNqOjmE5OTpU5cJsw-1; Tue, 31 Oct 2023 07:54:52 -0400
X-MC-Unique: mKxDYVNqOjmE5OTpU5cJsw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-408695c377dso40333555e9.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 04:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698753291; x=1699358091;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v5jvvhL/ocH8Dp9vpdoh1oirov3TATFg8bc5Pjfo7EA=;
 b=WYj4zsWQNxnRpse7Y355AgF1z0JLhpfqA24nFhNxTHOqyOZXeUjuTzT3W2HG98+mtg
 9dhtVkhdE9XwweOq5M1NICGN1yCCo+ljLMFh2C2DsresLRtDWbvdZ0ooJmm4+Qq6EB0D
 m7x/NwZkV55IK1BBklFW3TdthqtDWlqj8WDrh0OscYJHD2mFjEqZIUT7HLexpfJVGgld
 oTtZBkpAtPte1227fcX+V/kfrBDT59C8AfEg/GpGNPR/KfscrX9GpRLsQhqVxLHj0T60
 aWjagThKARjiE1Tumg7Fue/i1gN/xtyKf+qY7Yztmq5D8qDRdxgoacrR5Sa5UfmaZw+9
 yfQQ==
X-Gm-Message-State: AOJu0Yy2LYTjpT72Yx8v2FYzW3C2i2wDL4ahTjokkY4SD2DGj9kfWtbS
 y/2VAhMcOgIGCgshpLU7goT6il6wceaXOojxgKJYPBNi4AQ3A1156hFBOmZpkbowti6URVyU7V2
 MwW23Gen/YIZeaM8=
X-Received: by 2002:a7b:cd14:0:b0:3fe:ba7:f200 with SMTP id
 f20-20020a7bcd14000000b003fe0ba7f200mr10372034wmj.20.1698753290864; 
 Tue, 31 Oct 2023 04:54:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmjbgUapmtmnNblNfA7ZcyUvjqYAOyfg96dGJQKwRzI8Wp0l9ZEVNLYuANINCf1Ld6iuR8Uw==
X-Received: by 2002:a7b:cd14:0:b0:3fe:ba7:f200 with SMTP id
 f20-20020a7bcd14000000b003fe0ba7f200mr10372025wmj.20.1698753290489; 
 Tue, 31 Oct 2023 04:54:50 -0700 (PDT)
Received: from ?IPV6:2003:cf:d746:c551:3d67:278e:c0a1:87a2?
 (p200300cfd746c5513d67278ec0a187a2.dip0.t-ipconnect.de.
 [2003:cf:d746:c551:3d67:278e:c0a1:87a2])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a05600c310c00b003fe1fe56202sm1540446wmo.33.2023.10.31.04.54.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 04:54:49 -0700 (PDT)
Message-ID: <7dd7cca5-6706-4ecd-9d5b-cc0133053d86@redhat.com>
Date: Tue, 31 Oct 2023 12:54:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Fix locking in media change monitor commands
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: stefanha@redhat.com, qemu-devel@nongnu.org
References: <20231013153302.39234-1-kwolf@redhat.com>
 <20231013153302.39234-2-kwolf@redhat.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20231013153302.39234-2-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 13.10.23 17:33, Kevin Wolf wrote:
> blk_insert_bs() requires that the caller holds the AioContext lock for
> the node to be inserted. Since commit c066e808e11, neglecting to do so
> causes a crash when the child has to be moved to a different AioContext
> to attach it to the BlockBackend.
>
> This fixes qmp_blockdev_insert_anon_medium(), which is called for the
> QMP commands 'blockdev-insert-medium' and 'blockdev-change-medium', to
> correctly take the lock.
>
> Cc: qemu-stable@nongnu.org
> Fixes: https://issues.redhat.com/browse/RHEL-3922
> Fixes: c066e808e11a5c181b625537b6c78e0de27a4801
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/qapi-sysemu.c | 5 +++++
>   1 file changed, 5 insertions(+)

Do we need to take the lock for the dev_ops tray callbacks, too?  I 
suppose not, and it also wouldn’t really matter in light of the lock 
being supposed to go away anyway, but still thought I should ask.

In any case, this change here is necessary, so:

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


