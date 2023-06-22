Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C7073A92C
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 21:53:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCQNB-0008V0-PZ; Thu, 22 Jun 2023 15:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCQN9-0008Ud-I5
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 15:53:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCQN8-0003Fc-BU
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 15:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687463617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jp9cV5tZHcHa9qbfPbj8R+XRGtvMG8wFwQqJD4l8YGg=;
 b=Zan8CAdJESE3Q89XMeadxAh8WapQ7k0ejcfLtHgsHybE5tGNovsML2hRG5ip6hZsB8h89P
 OswsB9t+QuzodF51r62lX0xBRh6nR6kIQM1QrHPDXgTheB/KDjd4y5P3gJX+XJwnhUIBsF
 X1naB4lMd9sl3tfpLL8mcrBa+A8bEnM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-vteDE2gXMKCEqaIi6Z9Nkw-1; Thu, 22 Jun 2023 15:53:35 -0400
X-MC-Unique: vteDE2gXMKCEqaIi6Z9Nkw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f8f8e29771so5311115e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 12:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687463610; x=1690055610;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jp9cV5tZHcHa9qbfPbj8R+XRGtvMG8wFwQqJD4l8YGg=;
 b=dfBXhsb80dQ3MQm01YX9KglA7FmWNwDISCMHGcsGLdZBhJ6jKMh6qS+7oSavesnVH1
 P2nrBy/Lhl3RaIn/YmhyfzIaWBiuHeBmcGlh1s1pIbXlfyAufvJkCp0sCllz/2q7SHTA
 XEIbGdS0MAPPW2jwY/KsIPDIn17qS4sCh6AC7IfJWCgWnwj1BHG8wFVryHbIXssl1FbN
 N5Xqv9TSxfnNOXdGTpSkMibib1D2LCYa2Ck1ClBYw2LmAvjV6G+LqPQ8KSLEYVTUqvD6
 Qn/FpcVhIWQKmZkfKx53nTBGY5lq5qmoCs06M8vGaUVOXal7EgKWaUpSvRS98zJajR0B
 0HYA==
X-Gm-Message-State: AC+VfDzaPX/IFcy3lejexhgaZK4RSqG3VB9KGF8P9OvAJRGcguxwQGxk
 rSTSUTCyb03qzm05v0nr1pEpC0vZaqsZ0Yf822llZplxLkUDSot9Ippna6z7Yo4pSu2c20Kwgpu
 eez4hIPNhIiNi5BY=
X-Received: by 2002:a7b:cb04:0:b0:3f7:ecdf:ab2d with SMTP id
 u4-20020a7bcb04000000b003f7ecdfab2dmr20335847wmj.20.1687463610509; 
 Thu, 22 Jun 2023 12:53:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ584N1dvbGA6ymSY++kQ8SUz+pAb/8L1SOb8cULdNKmIssmldkKAAAE1y2qN5RFmfBTNuIbwQ==
X-Received: by 2002:a7b:cb04:0:b0:3f7:ecdf:ab2d with SMTP id
 u4-20020a7bcb04000000b003f7ecdfab2dmr20335838wmj.20.1687463610173; 
 Thu, 22 Jun 2023 12:53:30 -0700 (PDT)
Received: from redhat.com ([2.52.149.110]) by smtp.gmail.com with ESMTPSA id
 t12-20020a7bc3cc000000b003f604793989sm348077wmj.18.2023.06.22.12.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 12:53:29 -0700 (PDT)
Date: Thu, 22 Jun 2023 15:53:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, marcandre.lureau@gmail.com,
 cohuck@redhat.com, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v3 0/4] Virtio shared dma-buf
Message-ID: <20230622155244-mutt-send-email-mst@kernel.org>
References: <20230524091333.201767-1-aesteve@redhat.com>
 <CADSE00KNb4vxsL-JzQMrVgks+EJvt1dj7v9jd3s9gnkzGow6UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADSE00KNb4vxsL-JzQMrVgks+EJvt1dj7v9jd3s9gnkzGow6UA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

No one seems to be worried by this patchset so I queued it.

-- 
MST


