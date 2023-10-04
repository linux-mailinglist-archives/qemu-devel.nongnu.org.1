Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D85FF7B7B22
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:07:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxYL-0003pU-1W; Wed, 04 Oct 2023 04:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxWr-0000bJ-1H
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:46:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxWh-0002af-J0
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7o6L3Hf/e9kUu5lCaCSDHMU6Bu6TjGI//1ytCFQ5e54=;
 b=Rl0yarRCnhOArPaaoHp/EXqLI1t6I54Q2o5rbOt68zrt4vvmgN5jJCLADzLTTol17Igo2h
 45MQbmSQzFkY8zW5NU1omIeab9KRL4wNsrcRtUCzli8kxH6oNNJu7JfiyZK+TpeSQ2+F6u
 AWZ0J3NobG6IIDmfez0qGyLdKuJIRQ4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-hmy7hDGQOdWpZoKek_Ic-A-1; Wed, 04 Oct 2023 04:46:37 -0400
X-MC-Unique: hmy7hDGQOdWpZoKek_Ic-A-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5344aaf2703so1679014a12.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409195; x=1697013995;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7o6L3Hf/e9kUu5lCaCSDHMU6Bu6TjGI//1ytCFQ5e54=;
 b=IQPaI3ItcVwvL26ScKRBhCdSZoHDiuxXhskxtoQiOeAz/ElKiTZkz3Yq6Jg5XxmdfY
 elE8EoFy9GtRfSpD6Ar/BRPANXAAEr7emuPv86Zc7k2dpoJMg5vuJj3vtkmIf0yJEYyG
 ciZpExzc+g+wz0WmaIviUKLmk3t/pxes2ObJ87aBKoGOpbNjV9Owm9Mb0ytxJ4Vkl34R
 h4y2QIiWuHNtOuh1LTJIEKaltsJ6hsu+fok+27Y+E50l7kNNqGnXgbePlcuA0/j790Ak
 5KupEsneNzWcn1Xd8gA/RH3Atu1wOfIa07wn8DO0uCpydrHNpXTbIPXX2BKSKS1VqQ5S
 XqIw==
X-Gm-Message-State: AOJu0YyKATUiF7LLMV8jB9R0Mv4ZdzGMw3cxp4vq2fPs4i1LY1kACdRr
 Kb/GptAboyg9u9CK+Vimx2FjGW2TamR6bP2C4jRXZFC1v6jquMQ2g6H7HsVtI6fn3MLgovXWok4
 Hmt+7RmYZWeOyZJFf2yC0nYp/W3jE8ppDC5C1nuFz6B1tcKQ3GnU4x97jD+XLPJO6L07w
X-Received: by 2002:aa7:db46:0:b0:532:ac24:3081 with SMTP id
 n6-20020aa7db46000000b00532ac243081mr1399092edt.30.1696409194318; 
 Wed, 04 Oct 2023 01:46:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEH8OD4Qkkhg+n804PM75ktSs8CJpzoVQfgEcX8F5GiytdfUPd5M6a8JU+fZi0DAAV4e2DWfQ==
X-Received: by 2002:adf:e388:0:b0:31a:e73f:3fe7 with SMTP id
 e8-20020adfe388000000b0031ae73f3fe7mr1614936wrm.3.1696409171396; 
 Wed, 04 Oct 2023 01:46:11 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 d14-20020adffd8e000000b00325a59b2080sm3477994wrr.97.2023.10.04.01.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:46:10 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:46:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 56/63] libvhost-user.c: add assertion to vu_message_read_default
Message-ID: <9fc8df14b1039493700f7db717a729d8d618439a.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
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


