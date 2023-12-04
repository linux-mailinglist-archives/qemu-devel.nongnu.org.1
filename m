Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 282F9802D94
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 09:51:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA4eZ-0002XD-Dj; Mon, 04 Dec 2023 03:50:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rA4eW-0002Wk-FC
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 03:50:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rA4eU-0007kp-Qq
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 03:50:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701679805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RokDO3QdPhWeRocvgfKaBmZ1TTaso2aNG+vh8QpQ1RU=;
 b=S9WWcx0GtYAH7QQzMlUYDcji2+6dmjJWCAJ7X5Jm8gisIUAHmJOs4CkKk4uNHYbf8sM0uK
 oza4cCcsLtlibOpeYa7Ky6f2XF1ZLWFXZdzzPryZku1OYeCSoAgqrnWigJHX+LfCfX42Do
 ys1HpTVm4AxAwvGH6mFPDYwO2rn1Onk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-jQitIPCfMoKOSQKjqTnnxQ-1; Mon, 04 Dec 2023 03:50:04 -0500
X-MC-Unique: jQitIPCfMoKOSQKjqTnnxQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33343bb5dc2so824087f8f.0
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 00:50:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701679803; x=1702284603;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RokDO3QdPhWeRocvgfKaBmZ1TTaso2aNG+vh8QpQ1RU=;
 b=Iet0oqHvDCEYp7zcNzvQnkwndedLdFuytCSkcv3LkecvgsmmUq/CMIgKKPAYit9Xic
 1HpVjDHVk356p1M7klNy8XXmPsKI1YMy8mBiW/WtVD8Dl6rqgfJwiqcGga2okKFL7XsX
 DniV0YSb4o82qGinW37wmacc9aspHL24vhblIvHAodzBfTQZjgdCwKE90zDeI2RdNgSH
 JhTNnEpDmYgujNFYhA7hu+KEVTPpTsnnm+KouJ/LF/o+3VT3K4BO1KqyonYULMt4OnEt
 24kQC+pgwmiCqAlQxh6IqNRgXpvG4DTbpPvVO6rgTeXaN+5tUk/VhZO1afPwCjnbUVqK
 90JA==
X-Gm-Message-State: AOJu0YyIZ7LKp6hlJ/8Db0GD6NqK80Tq5cB8IeYabXVHcqodsiqhyPLG
 spk1scuCOqVgtw1Ga9pRokGOvXVjbf7XHbw6zuwId48UqXWhe5jGi1EudhQs/sSFhQoMQ8HCdjF
 Ije8dAbDCJdGOnbs=
X-Received: by 2002:a5d:6ad2:0:b0:333:2fd2:6f7b with SMTP id
 u18-20020a5d6ad2000000b003332fd26f7bmr2637074wrw.133.1701679802942; 
 Mon, 04 Dec 2023 00:50:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEssd6UZQqbygOskFzu2pYplK9/wFI8cuyI+O/jCuFk0X7jc5DnJPSXwFJTgw8SMVkwf21zxw==
X-Received: by 2002:a5d:6ad2:0:b0:333:2fd2:6f7b with SMTP id
 u18-20020a5d6ad2000000b003332fd26f7bmr2637064wrw.133.1701679802560; 
 Mon, 04 Dec 2023 00:50:02 -0800 (PST)
Received: from redhat.com ([2.55.11.133]) by smtp.gmail.com with ESMTPSA id
 dm11-20020a0560000bcb00b0033334625bdbsm7542868wrb.13.2023.12.04.00.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 00:50:01 -0800 (PST)
Date: Mon, 4 Dec 2023 03:49:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, stefanha@gmail.com,
 marcandre.lureau@gmail.com
Subject: Re: [PATCH 0/3] Virtio dmabuf improvements
Message-ID: <20231204034947-mutt-send-email-mst@kernel.org>
References: <20231107093744.388099-1-aesteve@redhat.com>
 <CADSE00Ji6Gk8LJF-1Yr9VBmmcOFFAVYMVGQYsdT59kQQ2adyDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADSE00Ji6Gk8LJF-1Yr9VBmmcOFFAVYMVGQYsdT59kQQ2adyDA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Nov 30, 2023 at 04:49:35PM +0100, Albert Esteve wrote:
> 
> 
> 
> On Tue, Nov 7, 2023 at 10:37 AM Albert Esteve <aesteve@redhat.com> wrote:
> 
>     Various improvements for the virtio-dmabuf module.
>     This patch includes:
> 
>     - Check for ownership before allowing a vhost device
>       to remove an object from the table.
>     - Properly cleanup shared resources if a vhost device
>       object gets cleaned up.
>     - Rename virtio dmabuf functions to `virtio_dmabuf_*`
> 
>     Albert Esteve (3):
>       hw/virtio: check owner for removing objects
>       hw/virtio: cleanup shared resources
>       hw/virtio: rename virtio dmabuf API
> 
>      hw/display/virtio-dmabuf.c        | 14 +++++-----
>      hw/virtio/vhost-user.c            | 33 ++++++++++++++++++-----
>      hw/virtio/vhost.c                 |  5 ++++
>      include/hw/virtio/vhost.h         |  6 +++++
>      include/hw/virtio/virtio-dmabuf.h | 33 ++++++++++++-----------
>      tests/unit/test-virtio-dmabuf.c   | 44 +++++++++++++++----------------
>      6 files changed, 83 insertions(+), 52 deletions(-)
> 
>     --
>     2.41.0
> 
> 
> 
> Bump :)
> 
> @Marc-André Lureau could you please take a look? You suggested the API
> upgrades, so would be great if you could check if it is what you had in mind.
> 
> Thanks!

All this is post releas material, right?


