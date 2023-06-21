Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6FD7390C3
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 22:27:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC4Ow-0003pu-0z; Wed, 21 Jun 2023 16:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qC4Ou-0003pX-2M
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 16:26:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qC4Os-0003IQ-Kj
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 16:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687379157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EV65PXRdu407yvxg91hhcKZkdfx3Js2zWAnhrNRgxEk=;
 b=Uf5ULhK2kKhS+PHzkLFz4q5vBVeozKbk5df/Zt+cGMd7dd9OkaMlQmLSubL/O8LxU/uqfA
 FBSx1RFhXKj67HZCuW8odQBnjPXacKD5fPHpEQ6sEC491LtlKomaX0QlhkaHOkqGtsMkZI
 fGTRNhUrS64vyeytVRt0stEQTnpVtPk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-EM2w-_45NXCh2T-EvX4hnw-1; Wed, 21 Jun 2023 16:25:54 -0400
X-MC-Unique: EM2w-_45NXCh2T-EvX4hnw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9715654aba1so654912766b.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 13:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687379153; x=1689971153;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EV65PXRdu407yvxg91hhcKZkdfx3Js2zWAnhrNRgxEk=;
 b=ZRtZDsPzSPwfXx7SMmB6NAfx/7pLJlRzcAhIJQ/wvm3oeVhCJ4QhLtUrQHYSLw4Qmw
 vpQZnuuz1h55FEe3RXwnL6jsrCVW9za5FkJeQnHdwbwNo8h18ZV4aiPADS7CJRaT+Kjk
 LnoRKeoi3Mod6yy2VrBgRJeZEVhkdAFw7v83wQXGQpcswfd8WWt/hjbZLdlaZpUQTTYg
 U7z+e4ayYiJ+pViyQlBAU9RP7VFODMgXNAN6U7j1hmmOy/Aq6ymJVwplicceNvNpkj5+
 gbhUC8/2wQv3hg2xWNG+L6tJ8GLMVhhER2V1Vyy+Oj2brn6foFmud0oCF5P3nv2Wub/g
 krHA==
X-Gm-Message-State: AC+VfDx3McL4yFC87N+VFKQZYaupgW5MrvgnvXFG/UjDd8pCrnaBNZq/
 fJ5hUpr0VAhlmjua/ZCXfJSAk9NBiqY3S3MV5MpCMt+kv3jtRmLmlmYPfThcmPCnQj2QwP7fJL2
 0v7IbARCBFULdSsI=
X-Received: by 2002:a17:907:3f27:b0:989:450:e565 with SMTP id
 hq39-20020a1709073f2700b009890450e565mr7046837ejc.23.1687379153554; 
 Wed, 21 Jun 2023 13:25:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4yhgOIw/09HKfRA3dSqymZAKE7VOXB6W0RpUHAxrFM3wQeIdXEbg8Ni/JQNEo2TZ7fGX7PXg==
X-Received: by 2002:a17:907:3f27:b0:989:450:e565 with SMTP id
 hq39-20020a1709073f2700b009890450e565mr7046828ejc.23.1687379153294; 
 Wed, 21 Jun 2023 13:25:53 -0700 (PDT)
Received: from redhat.com ([2.52.159.126]) by smtp.gmail.com with ESMTPSA id
 g6-20020a170906c18600b00982a92a849asm3621673ejz.91.2023.06.21.13.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 13:25:52 -0700 (PDT)
Date: Wed, 21 Jun 2023 16:25:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, marcandre.lureau@gmail.com,
 cohuck@redhat.com, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v3 0/4] Virtio shared dma-buf
Message-ID: <20230621162415-mutt-send-email-mst@kernel.org>
References: <20230524091333.201767-1-aesteve@redhat.com>
 <CADSE00KNb4vxsL-JzQMrVgks+EJvt1dj7v9jd3s9gnkzGow6UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADSE00KNb4vxsL-JzQMrVgks+EJvt1dj7v9jd3s9gnkzGow6UA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 21, 2023 at 10:20:25AM +0200, Albert Esteve wrote:
> Hi!
> 
> It has been a month since I sent this patch, so I'll give it a bump to get some
> attention back.
> 
> @mst and @Fam any comments? What would be the next steps to take to move this
> forward?
> 
> BR,
> Albert
> 
> 

I'd really want help from Gerd here. Don't know enough about dmabuf.
Gerd any comments or I'll just merge?


-- 
MST


