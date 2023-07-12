Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE857506E0
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 13:49:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJXqh-0003lT-H2; Wed, 12 Jul 2023 07:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qJXqf-0003kr-CP
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 07:17:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qJXqd-00032t-W0
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 07:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689160651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pBUGAtLzY6a3C5VNxEO57Blf+D6X+FxQa2ph9sR59b4=;
 b=D6kKKiFGnHj8wf0EIbtzwd5k/iKsSduMCuodcMBLh6a9h9+c9XmplZjPLmslMl2KhdSROG
 XgS5juAzhRHO6a++DeRtkYfIoExLEIysS1Vwyzzl7OqAzrMb+69P5/RnLDwYHkZonEKtem
 W/eF+SIr7FKLjF4Vqa6rWwEelcqv0nk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-7PDBs__APK6xPa7s3pDihA-1; Wed, 12 Jul 2023 07:17:27 -0400
X-MC-Unique: 7PDBs__APK6xPa7s3pDihA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-2f2981b8364so4145952f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 04:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689160647; x=1691752647;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pBUGAtLzY6a3C5VNxEO57Blf+D6X+FxQa2ph9sR59b4=;
 b=W9hMKs8OrFrLs3qetkJYVPGgEjNXu8LDq/4YDtD6S+HRpuV6eb3QQAw+HHwSDdCODY
 1+A0dHe8do/Z+8L9EiAHEQ09K6AY3xnxsSiXi8Ww50Rgi8dyKw8QMLA44YUKfHBKBrIQ
 yjp3o7tbsdeR+8V1vaug5e37YNlBOfvJALnKkZBvzscUdHPDOF33rGWyH3n9TqeP7yGg
 BXQCnpwS8eWdOQA3ObHZoxJ+I//1RtMkBt85KM7UwRwz2P+i/Zgj9CGZsHjBuMi5HRtV
 r3n/Ibk1NCopzLswo6Vyox0ekUhsZlmeC9OfuzZ1yCrOD/gXkj8+cxmXsk5FupH9Qc2T
 nWQw==
X-Gm-Message-State: ABy/qLbrnuvEiXjDnl9xuGixioeaNRbfSUIlfDaGAibEusd2oN31FIBc
 Wdj2AEBqXHxP48xOWj2bacTf2WkoWmZ6zrdh2xe7F/ptA6XcYjcyoQHoLLQlp3YgPo5o7n4wre4
 1PfFB+2Y1k+WyECs=
X-Received: by 2002:adf:e450:0:b0:313:ded8:f346 with SMTP id
 t16-20020adfe450000000b00313ded8f346mr18011512wrm.22.1689160646893; 
 Wed, 12 Jul 2023 04:17:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGiFh/MxI/vtCrOC8r0ux9jbco2F0l+Vac8NmLoFNoBLnRR63izllTFWnMuNRAXlYueU+1Rlg==
X-Received: by 2002:adf:e450:0:b0:313:ded8:f346 with SMTP id
 t16-20020adfe450000000b00313ded8f346mr18011492wrm.22.1689160646547; 
 Wed, 12 Jul 2023 04:17:26 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f3:f1da:a306:cee7:ddff:8ed0])
 by smtp.gmail.com with ESMTPSA id
 a23-20020a5d4577000000b0030ae53550f5sm4808366wrc.51.2023.07.12.04.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 04:17:25 -0700 (PDT)
Date: Wed, 12 Jul 2023 07:17:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 German Maglione <gmaglione@redhat.com>
Subject: Re: [PATCH] vhost-user.rst: Clarify enabling/disabling vrings
Message-ID: <20230712071357-mutt-send-email-mst@kernel.org>
References: <20230712091704.15589-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712091704.15589-1-hreitz@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Jul 12, 2023 at 11:17:04AM +0200, Hanna Czenczek wrote:
> Currently, the vhost-user documentation says that rings are to be
> initialized in a disabled state when VHOST_USER_F_PROTOCOL_FEATURES is
> negotiated.  However, by the time of feature negotiation, all rings have
> already been initialized, so it is not entirely clear what this means.
> 
> At least the vhost-user-backend Rust crate's implementation interpreted
> it to mean that whenever this feature is negotiated, all rings are to be
> put into a disabled state, which means that every SET_FEATURES call
> would disable all rings, effectively halting the device.  This is
> problematic because the VHOST_F_LOG_ALL feature is also set or cleared
> this way, which happens during migration.  Doing so should not halt the
> device.
> 
> Other implementations have interpreted this to mean that the device is
> to be initialized with all rings disabled, and a subsequent SET_FEATURES
> call that does not set VHOST_USER_F_PROTOCOL_FEATURES will enable all of
> them.  Here, SET_FEATURES will never disable any ring.

Huh. I don't know why we don't set VHOST_USER_F_PROTOCOL_FEATURES
on all calls though. I think it's a bug. Let's fix that first of all?
Then we can still document behaviour of existing buggy QEMU.

> This other interpretation does not suffer the problem of unintentionally
> halting the device whenever features are set or cleared, so it seems
> better and more reasonable.
> 
> We should clarify this in the documentation.
> 
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  docs/interop/vhost-user.rst | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 5a070adbc1..ca0e899765 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -383,12 +383,23 @@ and stop ring upon receiving ``VHOST_USER_GET_VRING_BASE``.
>  
>  Rings can be enabled or disabled by ``VHOST_USER_SET_VRING_ENABLE``.
>  
> -If ``VHOST_USER_F_PROTOCOL_FEATURES`` has not been negotiated, the
> -ring starts directly in the enabled state.
> -
> -If ``VHOST_USER_F_PROTOCOL_FEATURES`` has been negotiated, the ring is
> -initialized in a disabled state and is enabled by
> -``VHOST_USER_SET_VRING_ENABLE`` with parameter 1.
> +Between initialization and the first ``VHOST_USER_SET_FEATURES`` call, it
> +is implementation-defined whether each ring is enabled or disabled.
> +
> +If ``VHOST_USER_SET_FEATURES`` does not negotiate
> +``VHOST_USER_F_PROTOCOL_FEATURES``, each ring, when started, will be
> +enabled immediately.
> +
> +If ``VHOST_USER_SET_FEATURES`` does negotiate
> +``VHOST_USER_F_PROTOCOL_FEATURES``, each ring will remain in the disabled
> +state until ``VHOST_USER_SET_VRING_ENABLE`` enables it with parameter 1.
> +
> +Back-end implementations that support ``VHOST_USER_F_PROTOCOL_FEATURES``
> +should implement this by initializing each ring in a disabled state, and
> +enabling them when ``VHOST_USER_SET_FEATURES`` is used without
> +negotiating ``VHOST_USER_F_PROTOCOL_FEATURES``.  Other than that, rings
> +should only be enabled and disabled through
> +``VHOST_USER_SET_VRING_ENABLE``.
>  
>  While processing the rings (whether they are enabled or not), the back-end
>  must support changing some configuration aspects on the fly.
> -- 
> 2.41.0


