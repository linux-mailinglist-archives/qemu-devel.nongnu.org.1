Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 020B576CB95
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 13:17:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR9pW-0007FE-8q; Wed, 02 Aug 2023 07:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qR9pU-0007En-FG
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 07:15:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qR9pT-0007gQ-3S
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 07:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690974945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xtt6kA2ADe9UpzPBMZSGlAecVkobvygpt+mHPeqkBzs=;
 b=PqUGbU5a6aislLxbmmmoNp8Y3FECywvQYBXqoc/KN+jEvcNEqlBW6ZmvWSPwOmqipwk2t7
 tDzAQIVKYTwGPoif11e5LuxrOYOPRYp4mMfs9CfmTN29igRn1dKMSr3F0UtBCCj+Vt3GnW
 FRXaUJW2BL+brenZ8OSbI/IFV/r5YPw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-yPIlVjgdMFSnYiQBEAuwGA-1; Wed, 02 Aug 2023 07:15:43 -0400
X-MC-Unique: yPIlVjgdMFSnYiQBEAuwGA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94a348facbbso460001466b.1
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 04:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690974943; x=1691579743;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xtt6kA2ADe9UpzPBMZSGlAecVkobvygpt+mHPeqkBzs=;
 b=Bnd9vDGvtAdYOr0aJCEstpgJb2Ck+8QKBZCwQ3QpDxk0JTJPh2vre4pvnmVWAUAdAX
 iuGAMCXAvWMwzILiYAaZy3SjBf9BMBvQ/fchHYCM28XbH3u/LC9lAk0c4Z3ShMNTwoZ4
 j6Wk9G5Phac7IjdyF7ROxO+q7kSvlSpNNoX2xH2Ah+tt/2d9Nsgo6iHkyKuMOqnHgU0H
 nbg4fJKO14oHZe93IIQ2d8/8w1fGq7d8UxDEq9cXOrmXvHqOoY8+4xregT8HGPWaMuX6
 2QVRCo9JtnfDHiFlwuLJ3VDKwr+F9jE6Dl0b+x/xpP2ZQYZz3RBqDAteoOi+pUhiZvsb
 jxlA==
X-Gm-Message-State: ABy/qLZixm0SOdwRDknZ0z2cJ2CJcSnaBEQjbTVL9sEYB/IAWaoEF47u
 nh9GU81b41oNcfZu4rIPlqsiofKpSXAV/QDavQbqYhl5lQU+NjU85VIBjEkgumLf40LCJ1O1Ht/
 lKUb16sqJUam3iNw=
X-Received: by 2002:a17:906:224b:b0:99b:d435:e994 with SMTP id
 11-20020a170906224b00b0099bd435e994mr4895356ejr.32.1690974942916; 
 Wed, 02 Aug 2023 04:15:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFiUfqKua/oyGI8wSIREkVsNP1Aw5T6qSlCk+1Qe+y+kvhkMGyUN/6gvhfft0qlZBj2NueqKA==
X-Received: by 2002:a17:906:224b:b0:99b:d435:e994 with SMTP id
 11-20020a170906224b00b0099bd435e994mr4895344ejr.32.1690974942649; 
 Wed, 02 Aug 2023 04:15:42 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 e6-20020a1709067e0600b0099315454e76sm8871373ejr.211.2023.08.02.04.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 04:15:41 -0700 (PDT)
Message-ID: <00d6b251-a33a-96d4-f5fc-92558fb3f261@redhat.com>
Date: Wed, 2 Aug 2023 13:15:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] block/blkio: close the fd when blkio_connect() fails
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20230801160332.122564-1-sgarzare@redhat.com>
 <20230801160332.122564-2-sgarzare@redhat.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230801160332.122564-2-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.102, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 01.08.23 18:03, Stefano Garzarella wrote:
> libblkio drivers take ownership of `fd` only after a successful
> blkio_connect(), so if it fails, we are still the owners.
>
> Fixes: cad2ccc395 ("block/blkio: use qemu_open() to support fd passing for virtio-blk")
> Suggested-by: Hanna Czenczek <hreitz@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   block/blkio.c | 9 +++++++++
>   1 file changed, 9 insertions(+)

Works, so:

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


But personally, instead of having `fd_supported` track whether we have a 
valid FD or not, I’d find it more intuitive to track ownership through 
the `fd` variable itself, i.e. initialize it to -1, and set it -1 when 
ownership is transferred, and then close it once we don’t need it 
anymore, but failed to transfer ownership to blkio.  The elaborate way 
would be something like

...
-int fd, ret;
+int fd = -1;
+int ret;
...
  ret = blkio_connect(s->blkio);
+if (!ret) {
+    /* If we had an FD, libblkio now has ownership of it */
+    fd = -1;
+}
+if (fd >= 0) {
+    /* We still have FD ownership, but no longer need it, so close it */
+    qemu_close(fd);
+    fd = -1;
+}
  /*
   * [...]
   */
  if (fd_supported && ret == -EINVAL) {
-    qemu_close(fd);
-
...


Or the shorter less-verbose version would be:

...
-int fd, ret;
+int fd = -1;
+int ret;
...
  ret = blkio_connect(s->blkio);
+if (fd >= 0 && ret < 0) {
+    /* Failed to give the FD to libblkio, close it */
+    qemu_close(fd);
+}
  /*
   * [...]
   */
  if (fd_supported && ret == -EINVAL) {
-    qemu_close(fd);
-
...


