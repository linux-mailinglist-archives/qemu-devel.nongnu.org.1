Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8480576CF5B
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 15:58:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRCMi-0006Ww-1d; Wed, 02 Aug 2023 09:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qRCMf-0006VQ-Li
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 09:58:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qRCMe-00077F-7T
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 09:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690984691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WsF1KUw3/B+TbqvlEU0qBBTT+ycqIN8J69iFP4GRjLY=;
 b=fRVI0jiRta0r7OxYvNoK1dDZ/G64pgvou6xQWLdHgA/e1ptD418NZ5OADMaKXKpWz/BKbd
 XRUBQZggtP1/LJrLRV/7z0znM990je4pN2k2M/Xe5BLo6C2z7GWAzPSQRD92cqg1R4960S
 LwYlIADpUgt5hZOtWU0uhJhR8mUvAbU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-p-T_LCpRNWqLNInxj2jBXw-1; Wed, 02 Aug 2023 09:58:10 -0400
X-MC-Unique: p-T_LCpRNWqLNInxj2jBXw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-63d245b67abso82659276d6.3
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 06:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690984689; x=1691589489;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WsF1KUw3/B+TbqvlEU0qBBTT+ycqIN8J69iFP4GRjLY=;
 b=ZU641Dmoxa23o6VBxOXZWuL882itGLqLbtPSwyjuZAQlLMZWmDcm/cX06ol6zwwDI7
 9xgoCK+d1/o/FoO9ZgSo8aSxpGLNLVOBnXtdzxsNdjY+MsHALoVGkfj33TTxG5r68jhA
 PIunkiD4EKCt/+UDXKVe7/BnQsQxofTGWDTGJcFqXLKgllYlugWsxoJPyMmFgwXayq6K
 KdFO7OTF+/UaAZUWiOolB5ThZNSdUulTm76ScvDaLIJnUGwIuGXqriW0+eUw4LpVgem0
 H5sn2rB7Yt2G60dr/ns4h34nDYeJVMLVyyEASno0u28GPSMyptlRY1VJjI3zOtyUJrKJ
 +VGQ==
X-Gm-Message-State: ABy/qLYHkM+6ELbRLVx0uBrNTynT7VzhTYsiM1KZMirQX7Qnz8kgdUDq
 8qsHPhpWwEsm+gdSogZ27E0+bmiL+223EpPtqHv1MTP++5MFrqEO0koC8C/BUR3hPh18SmmIVWN
 yhXVAB6GX+noEuQI=
X-Received: by 2002:a0c:a9db:0:b0:634:d868:f0d5 with SMTP id
 c27-20020a0ca9db000000b00634d868f0d5mr17048810qvb.9.1690984689584; 
 Wed, 02 Aug 2023 06:58:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHAQnCdY0tI1OYPZvhYC3md636SlRUicG386mKKY36XYF+biY71i0d8FXFHIgVzzsU2pS/jUw==
X-Received: by 2002:a0c:a9db:0:b0:634:d868:f0d5 with SMTP id
 c27-20020a0ca9db000000b00634d868f0d5mr17048799qvb.9.1690984689349; 
 Wed, 02 Aug 2023 06:58:09 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-214.retail.telecomitalia.it.
 [82.57.51.214]) by smtp.gmail.com with ESMTPSA id
 c14-20020a0ca9ce000000b0063d038df3f3sm5575978qvb.52.2023.08.02.06.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 06:58:08 -0700 (PDT)
Date: Wed, 2 Aug 2023 15:58:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 1/2] block/blkio: close the fd when blkio_connect() fails
Message-ID: <2ifpkjvlfgtw33sbzegfxgxaqt3pdyvirszvx4p3szfpdifkwr@yejndm46za5y>
References: <20230801160332.122564-1-sgarzare@redhat.com>
 <20230801160332.122564-2-sgarzare@redhat.com>
 <00d6b251-a33a-96d4-f5fc-92558fb3f261@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00d6b251-a33a-96d4-f5fc-92558fb3f261@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

On Wed, Aug 02, 2023 at 01:15:40PM +0200, Hanna Czenczek wrote:
>On 01.08.23 18:03, Stefano Garzarella wrote:
>>libblkio drivers take ownership of `fd` only after a successful
>>blkio_connect(), so if it fails, we are still the owners.
>>
>>Fixes: cad2ccc395 ("block/blkio: use qemu_open() to support fd passing for virtio-blk")
>>Suggested-by: Hanna Czenczek <hreitz@redhat.com>
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>---
>>  block/blkio.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>
>Works, so:
>
>Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
>
>
>But personally, instead of having `fd_supported` track whether we have 
>a valid FD or not, I’d find it more intuitive to track ownership 
>through the `fd` variable itself, i.e. initialize it to -1, and set it 
>-1 when ownership is transferred, and then close it once we don’t need 
>it anymore, but failed to transfer ownership to blkio.  The elaborate 
>way would be something like
>
>...
>-int fd, ret;
>+int fd = -1;
>+int ret;
>...
> ret = blkio_connect(s->blkio);
>+if (!ret) {
>+    /* If we had an FD, libblkio now has ownership of it */
>+    fd = -1;
>+}
>+if (fd >= 0) {
>+    /* We still have FD ownership, but no longer need it, so close it */
>+    qemu_close(fd);
>+    fd = -1;
>+}
> /*
>  * [...]
>  */
> if (fd_supported && ret == -EINVAL) {
>-    qemu_close(fd);
>-
>...
>
>
>Or the shorter less-verbose version would be:
>
>...
>-int fd, ret;
>+int fd = -1;
>+int ret;
>...
> ret = blkio_connect(s->blkio);
>+if (fd >= 0 && ret < 0) {
>+    /* Failed to give the FD to libblkio, close it */
>+    qemu_close(fd);
>+}

I like this, I'll do it in v2!

Thanks,
Stefano


