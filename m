Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B15E278D41F
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 10:33:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbGcn-0007xE-RY; Wed, 30 Aug 2023 04:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qbGcc-0007vN-Dz
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:32:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qbGca-0003zY-9m
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693384334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F7aMZ14QdTR84yY9Ds3iu3dR6/Z0dlvCAfq8iXH9CVA=;
 b=jIL/VJCe1dmDKGcIg18G14pGOofl5erXdSJQqhMwniGMEBSn8EdxSkJtuKQrwrUm2NIngm
 PSL0X2TzoJ3XhhN7tA5HEg3fhHZ0Kx6F27qlwwih0a8et5x3KNH+v5UEt10bKl+zpWm3wm
 XdbF2xxxYohJbuuzuLvlKKKXPNhhuTw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-qlLsrt8BOUaL7ilbhzbA2A-1; Wed, 30 Aug 2023 04:32:13 -0400
X-MC-Unique: qlLsrt8BOUaL7ilbhzbA2A-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9a5c0f8134eso173980866b.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 01:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693384332; x=1693989132;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7aMZ14QdTR84yY9Ds3iu3dR6/Z0dlvCAfq8iXH9CVA=;
 b=hgNDtSSEG61NrcG9w0yz8bwdfjl0nBMc3x3sGzp9hr/CsxajDQveBF9cWMCh6qWBQw
 y/lYWKpbR8l+/zSjHWXGdXngcMJyg4PMoV0cmoXq8u9AaRtzFcpkJ+bOh/806ISeVRJ4
 /2T6UkQDhYj4XrFqt67QUkW+M0uoNGt4pqukhhlimCVK+HideB2GpAIT8zULQu4FdsEv
 iyXPojsfs6y3b4lxdZ83qtMsgV6cpAlNNvjuVC/aIoQ7QThXfmQoDxknGvbdbR0DMDNR
 bNFzSXuKFyDvZr96pU1jEEi3TMsv4u4QyiOO6X4L1eZO1AeJ1v+pmSlLX5uJ990GAtxu
 8g/w==
X-Gm-Message-State: AOJu0YyNcaE2J7n9esI4scY0QtGToa1vv/VqTkEo55MqdhmDrTfVOZM3
 SXix5s/Ja38SafhgdnCXagNdCtR3cizNxcd24pxZlZV5yCWU1P39M3QkrM0wy04nYLDjZUxTYIp
 fEJ/+9zQoJa49Y+Y=
X-Received: by 2002:a17:906:845a:b0:99c:c50f:7fb4 with SMTP id
 e26-20020a170906845a00b0099cc50f7fb4mr1061059ejy.1.1693384332366; 
 Wed, 30 Aug 2023 01:32:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGd5r7ZoyBtakEUuY9S9uDikV2J5jz7t8PMLYU3fN00XZs0FNn9PIbHs95laSRBAmQ6ymvclw==
X-Received: by 2002:a17:906:845a:b0:99c:c50f:7fb4 with SMTP id
 e26-20020a170906845a00b0099cc50f7fb4mr1061049ejy.1.1693384332009; 
 Wed, 30 Aug 2023 01:32:12 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it.
 [82.57.51.114]) by smtp.gmail.com with ESMTPSA id
 j16-20020a170906051000b0099cc402d3ddsm6886078eja.202.2023.08.30.01.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 01:32:11 -0700 (PDT)
Date: Wed, 30 Aug 2023 10:32:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, 
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>
Subject: Re: [PATCH 5/7] vhost-user: hoist "write_msg", "get_features",
 "get_u64"
Message-ID: <vgjq676yvuns6rwafy6cwxwbxdhdeclxjhbarwdwydi4csn5gi@vlvwek4rqui4>
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-6-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230827182937.146450-6-lersek@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, Aug 27, 2023 at 08:29:35PM +0200, Laszlo Ersek wrote:
>In order to avoid a forward-declaration for "vhost_user_write_msg" in a
>subsequent patch, hoist "vhost_user_write_msg" ->
>"vhost_user_get_features" -> "vhost_user_get_u64" just above
>"vhost_set_vring".
>
>This is purely code movement -- no observable change.
>
>Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
>Cc: Eugenio Perez Martin <eperezma@redhat.com>
>Cc: German Maglione <gmaglione@redhat.com>
>Cc: Liu Jiang <gerry@linux.alibaba.com>
>Cc: Sergio Lopez Pascual <slp@redhat.com>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>---
> hw/virtio/vhost-user.c | 170 ++++++++++----------
> 1 file changed, 85 insertions(+), 85 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


