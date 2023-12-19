Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E95F681923B
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 22:25:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFhZ4-0005Y2-L4; Tue, 19 Dec 2023 16:23:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rFhYz-0005Xj-Ku; Tue, 19 Dec 2023 16:23:41 -0500
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rFhYw-0000Wm-VB; Tue, 19 Dec 2023 16:23:40 -0500
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-594015ee9e6so78994eaf.1; 
 Tue, 19 Dec 2023 13:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703021017; x=1703625817; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nICuEkfj3PLAPb4crBPZRGpg1B1vpuOWK3zadnS8iKQ=;
 b=bgo0+yuzJCyMypv/CrS0i2X/t8w5hluq4U2hnGu5vljX2mPwL2LdvHC+rQAm+mS4s0
 B5zoNk7uKj035fjTXkB6aj5E4aV4bcmUFtfZBpBE7YFgqmih1xFWD0mk6OWVsPbmM5N4
 DuxIN0S0YQnMGl3LTl74mST3d9Q49T8kxd8dcNlg0BQlIT+4ak6kDVLoMy7zVgen1H0H
 QaOz1hcQEuTnEg+bmyaMZKVuaYPfPqUb3r65OfoLkp2WjWYywH9dSHf2agaPW8AVojFi
 vrGZPUi39aKeqR3qlh57LzFl3zIo6BJPZPlPlweGygvFbGkCpwleGuzwInRBTQ+aTubd
 9XkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703021017; x=1703625817;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nICuEkfj3PLAPb4crBPZRGpg1B1vpuOWK3zadnS8iKQ=;
 b=pteKZ2OMkUpi/Lf+7YoQEBbR7FvkJaQWQquoflRbDAS5hLGKCYBTlLR/ce0LmBF5sI
 e0vC68t7u8Lvte0EdeTCPYYB2U8MCPt8Qqbd0WydRymh1EWlVU+OdN5OAiALTqsLhx5y
 T42PnZhw5ljKkcK43tPrDMCe8nBjsKdXyUD5yUN0N44IB4xTuvxgalQ6cVjx+2kx7n6d
 4TyEthmPNHy3OlQtWK+H4KH7mOhwQ3RMAblaMjZLcizv8r7fCbBEwBw/Af0jiI+qC9X3
 PO6wirXztfog52hrHIMQJYpwneT1SVKKHJ+muI1RRbJRO9fehsvL1pM0Vx8wfaG7XDWt
 WM6Q==
X-Gm-Message-State: AOJu0YyvyLhbgDx2BNgF32fyNiDLRHYWgzulnyxtwtkLFXFhACJx2CgP
 tIIgbrlqvlIujb+qUIeS2YJJFnbw5gWyoGQeX44=
X-Google-Smtp-Source: AGHT+IHVIv/bhibWf/9XrrtIyC0FAx9t0SjtZNCD+Hdo7m5wJu+F4HtlpD8Eqdypy7Sair+AhRUzUIcHjZxF9HQZERU=
X-Received: by 2002:a4a:aac4:0:b0:593:f907:68ec with SMTP id
 e4-20020a4aaac4000000b00593f90768ecmr686837oon.14.1703021017426; Tue, 19 Dec
 2023 13:23:37 -0800 (PST)
MIME-Version: 1.0
References: <20231205182011.1976568-1-stefanha@redhat.com>
 <20231205182011.1976568-5-stefanha@redhat.com>
 <ZYG2mSe1JWnC0tq_@redhat.com> <ZYHew2poxuJJRyhC@redhat.com>
In-Reply-To: <ZYHew2poxuJJRyhC@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 19 Dec 2023 16:23:25 -0500
Message-ID: <CAJSP0QX0fg0TGWuveJz6+QbF9EmY=vPiU-c99fHZMN=1jAnXkw@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] aio: make
 aio_context_acquire()/aio_context_release() a no-op
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Cleber Rosa <crosa@redhat.com>, 
 Xie Changlong <xiechanglong.d@gmail.com>, Paul Durrant <paul@xen.org>,
 Ari Sundholm <ari@tuxera.com>, 
 Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Wen Congyang <wencongyang2@huawei.com>, 
 Alberto Garcia <berto@igalia.com>, Anthony Perard <anthony.perard@citrix.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org, 
 Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, 
 Fabiano Rosas <farosas@suse.de>, Hanna Reitz <hreitz@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Peter Xu <peterx@redhat.com>, 
 Emanuele Giuseppe Esposito <eesposit@redhat.com>, Fam Zheng <fam@euphon.net>,
 Leonardo Bras <leobras@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following hack makes the test pass but there are larger safety
issues that I'll need to look at on Wednesday:

diff --git a/nbd/server.c b/nbd/server.c
index 895cf0a752..cf4b7d5c6d 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1617,7 +1617,7 @@ static void nbd_drained_begin(void *opaque)
     }
 }

-static void nbd_drained_end(void *opaque)
+static void nbd_resume_clients(void *opaque)
 {
     NBDExport *exp = opaque;
     NBDClient *client;
@@ -1628,6 +1628,15 @@ static void nbd_drained_end(void *opaque)
     }
 }

+static void nbd_drained_end(void *opaque)
+{
+    NBDExport *exp = opaque;
+
+    /* TODO how to make sure exp doesn't go away? */
+    /* TODO what if AioContext changes before this runs? */
+    aio_bh_schedule_oneshot(nbd_export_aio_context(exp),
nbd_resume_clients, exp);
+}
+
 static bool nbd_drained_poll(void *opaque)
 {
     NBDExport *exp = opaque;

