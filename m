Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AF29C8C2B
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Nov 2024 14:53:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBaHY-0002qU-4B; Thu, 14 Nov 2024 08:53:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tBaHV-0002jR-EJ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 08:53:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tBaHU-0000kq-1l
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 08:53:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731592386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BRKaKRlDnbcFOqBuiFKPRjz4nqOYB9MFzJ6KIelCQ+8=;
 b=erj9GP0LUQO4VlBFV87fgWZFJmXXINKalGCex4aKQ3mxhe1Gh6xntPwViDm3cZDTVMHEqL
 ItKPgCZ+8nNsZmyXRk1fTTu8HM8jOinnWjogKzHYKMBP/pxBuayGrb3/+ilVb7deyy2GKm
 cQUO2Jp+upyQBq2KoZRRh9alRRGZmHI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-BRIuEbcxPk62r2ujfmdAHw-1; Thu, 14 Nov 2024 08:53:01 -0500
X-MC-Unique: BRIuEbcxPk62r2ujfmdAHw-1
X-Mimecast-MFC-AGG-ID: BRIuEbcxPk62r2ujfmdAHw
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d3e8dccc9so337993f8f.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 05:53:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731592380; x=1732197180;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BRKaKRlDnbcFOqBuiFKPRjz4nqOYB9MFzJ6KIelCQ+8=;
 b=ih8jiFmV4ymUyYoxFZ/Urcq8sOwbxt4ANt9TX72099NqXDoXXYMq62xPr2dsoLoFiJ
 /BSPkhnHC8y32kMlQK+1+s8C4FlfHWVm1zDgzP+B7iwoCRVVfWMM20gmjg3KaWCL0aiO
 8f9QXKsjHQ9T5mL2g0JiRvKe3lhPaJ+abIvKtxH/cGh+RgnOIr1scCUToSV76bYBBZHT
 errfJo5QQEqBMX7aZfIuRtAyY2FO6WsTMg7xo7nq3DoDtCHJeY2unrElvQJ6+skEyT7x
 Z9xcuDZot1DYdvkZlMdrExh+zmZWMFDb0ALeKQuNRFlzUKnI2ifF+u7041XVEUhEGP3U
 fdcQ==
X-Gm-Message-State: AOJu0YxU2ZiqOKhOuWy8z+oF7QrNHBzYDqB140YaZLB1RQn19FnYUqpL
 JoQqMyERaZIYbtlmmm2k+Sr963s2WpXCKCtfric9wbbbVbtd6OAyx05MsUm/pQNdPbPWhQbg6eK
 YX2kv1Ge8mqPPghy2Ctu1PVCrcxCUyJ3U12qAM9+5jbiRN2EnGw3f
X-Received: by 2002:a05:6000:1868:b0:37c:d23f:e464 with SMTP id
 ffacd0b85a97d-3820df88833mr5931580f8f.38.1731592380406; 
 Thu, 14 Nov 2024 05:53:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOPIttEe9OzOGceZlr7nRugW/ttip6umC1cL5OI0whBgIZZTFvuqefJzZuCnHzZWsZTMMqRA==
X-Received: by 2002:a05:6000:1868:b0:37c:d23f:e464 with SMTP id
 ffacd0b85a97d-3820df88833mr5931563f8f.38.1731592380020; 
 Thu, 14 Nov 2024 05:53:00 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f9:9589:951c:36c3:75d1:5725])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38222a5640csm55812f8f.104.2024.11.14.05.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 05:52:59 -0800 (PST)
Date: Thu, 14 Nov 2024 08:52:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/2] virtio-gpu: coverity fixes
Message-ID: <20241114085241-mutt-send-email-mst@kernel.org>
References: <20241111230040.68470-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241111230040.68470-1-alex.bennee@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Nov 11, 2024 at 11:00:38PM +0000, Alex Benn�e wrote:
> v2,
> 
> Fixes after Dimitry's review.


You should CC Gerd.

> Alex.
> 
> Alex Benn�e (2):
>   hw/display: factor out the scanout blob to fb conversion
>   hw/display: check frame buffer can hold blob
> 
>  include/hw/virtio/virtio-gpu.h | 15 +++++++++
>  hw/display/virtio-gpu-virgl.c  | 22 +------------
>  hw/display/virtio-gpu.c        | 59 +++++++++++++++++++++-------------
>  3 files changed, 52 insertions(+), 44 deletions(-)
> 
> -- 
> 2.39.5


