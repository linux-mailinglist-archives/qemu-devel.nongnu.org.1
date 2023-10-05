Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C1E7B9A5F
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:48:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFJG-0000Br-Bk; Wed, 04 Oct 2023 23:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFJ1-0008J3-RE
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFIz-0000mK-Eq
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7o6L3Hf/e9kUu5lCaCSDHMU6Bu6TjGI//1ytCFQ5e54=;
 b=hWd8bei/m2jspmUN/+9mA+6uIFZ9tk2MnMLNfNwosfDFfLQce4qcfbLnaIhddAZbB73bO3
 5fPMD0uvXSyftB6AnKQQJa8zkh4U42lHGSDb6fTuc85Wi/2b9nH91p/nBRZLfHRmrttuv7
 CG2xrdG/q8GOpDC8LuNbGrFLm1vziUw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-VKKnfuOuNlmMNKUtW3x3DA-1; Wed, 04 Oct 2023 23:45:38 -0400
X-MC-Unique: VKKnfuOuNlmMNKUtW3x3DA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso3152665e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477536; x=1697082336;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7o6L3Hf/e9kUu5lCaCSDHMU6Bu6TjGI//1ytCFQ5e54=;
 b=JtCuiPCoZhCvJUz6gvCZbEm3J5n+bnlg9BtjD/vgg2ktvcltZDI/yVmK71cdy6BM4G
 e/fRUeI73U6ArYeaPimMpWcPNLLEU0iE3/XMtfpjPb6jY/4Br+t4Nhcf8WNK6ammdbS3
 G9cADxDg/DYdZFmu9bbr0mgc07t+GvExfR6nRfOxe6XelqE78VncnABki179BsRIc2Fg
 LtdVYQgWIexhjhc0/ek75T4yDIxH1SQPXQGnweVG1NUSwneYlTltE1xpEb5+wUC38jhY
 mKam3LlC6T2tWBBuBlfdtZfB7HlNAsaS7TQEm53//mtZFX4innq7gb43ujPU9MW8HBqV
 bynw==
X-Gm-Message-State: AOJu0Yz98D8EvpPZCfYVPZLdPTPCFIWMm9C+sDqxrSIj1QeTkMx7llav
 sYHzCJ5/VcDrO6OwnzZAZZIaNkr21QHJqo5BmgluiCevpJ4wgP7Om7BYG5aaFvcQ91JQAdhBc+j
 dX0bqHzAu5qF9EbuEHqPuO0U7QmOSpAdL1BbtF3ciIsF3KUr/oVQURrO9IiIBy0FjIl8K
X-Received: by 2002:a7b:cbd5:0:b0:3ff:ca80:eda3 with SMTP id
 n21-20020a7bcbd5000000b003ffca80eda3mr3737026wmi.10.1696477536707; 
 Wed, 04 Oct 2023 20:45:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvgbqf/fYxS5Omj4lAlvfJcsdeeSkzvFcE7h7wuZAvVmJBXO/78UVSy2lbKMWnF/H+IjoCvw==
X-Received: by 2002:a7b:cbd5:0:b0:3ff:ca80:eda3 with SMTP id
 n21-20020a7bcbd5000000b003ffca80eda3mr3737015wmi.10.1696477536300; 
 Wed, 04 Oct 2023 20:45:36 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 u20-20020a05600c211400b0040642a1df1csm544327wml.25.2023.10.04.20.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:45:35 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:45:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL v2 46/53] libvhost-user.c: add assertion to
 vu_message_read_default
Message-ID: <a6f4d2ec42f3feb6c399f5760a2567ca78897bd7.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Explain Coverity that we are not going to overflow vmsg->fds.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-Id: <20230925194040.68592-5-vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 0469a50101..49b57c7ef4 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -322,6 +322,7 @@ vu_message_read_default(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
         if (cmsg->cmsg_level == SOL_SOCKET && cmsg->cmsg_type == SCM_RIGHTS) {
             fd_size = cmsg->cmsg_len - CMSG_LEN(0);
             vmsg->fd_num = fd_size / sizeof(int);
+            assert(fd_size < VHOST_MEMORY_BASELINE_NREGIONS);
             memcpy(vmsg->fds, CMSG_DATA(cmsg), fd_size);
             break;
         }
-- 
MST


