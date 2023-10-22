Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 667767D25C3
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 22:14:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1queoY-0005FV-Ox; Sun, 22 Oct 2023 16:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1queoU-0005Co-TP
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 16:12:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1queoS-00060w-R0
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 16:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698005558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qIkrzZ0dL1HqtLhZGIAdNSiBRoVFtTSHA/kHiulqF7g=;
 b=C3TIR09x8IbT5tkuU2j0yH+Iz34z8EnlQLqaI8AVZlTpBKMaj69P9oYcWh5DjAvdU8GQ2U
 jolPLMTbtcNIrbp7W/5g+7m7YTyY/XNlR4UQQTFwNWSWYlK+FKjowPRIqmacM37SuGezJ4
 nEOJkSuORXfUYsgzWnb09j3aGKdNTPs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-b9rrIxPwPUWKibf39kCQ1g-1; Sun, 22 Oct 2023 16:12:35 -0400
X-MC-Unique: b9rrIxPwPUWKibf39kCQ1g-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-66011f0d521so11036556d6.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 13:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698005554; x=1698610354;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qIkrzZ0dL1HqtLhZGIAdNSiBRoVFtTSHA/kHiulqF7g=;
 b=ii7PflSYlZZQR78qPhwVh3jHmOtieYOHW2KEz/7E8RFA+PeeK/ONMDWm4yUXGKrFr+
 yy6rhXnIf6GeSH3dJNWNGT+fl6UoVFzm+gy9NATMl+kg7ku59P6ttSTmmJIRoWkIPhvK
 r3B4udSzio11eVPOp7zh6r+wdLbDqg9tBc79fQWHRjNHL+Edr71s6DI3Vo2Wv66IHpr+
 ZjHKpElGBSl46ONURNUifk9E+I/GjquIkySz25i1+bVGPgc3Pp6ZG8i6aipdWqeFIJQB
 xLY1NB6sT3JfyiECqBk3vYTeqDmdiffo8arwj5noYyEC1QsuUKoS3Wx4z608d5ORoTzI
 Yxng==
X-Gm-Message-State: AOJu0Yy06hNr3DJohJVG2YnSW454ZnEnHwzJ7Qqbox9OwonxStT9SDg2
 BLFfSk2rvH6YAw8YUt7QNVQGnJ4OxmQxZbQmDpOU97ERMcYCnhrVL7S/17hxEJMoF/lD9qIxhaQ
 9Cxj+g+BmxCW10QaFtuq4kKoYITb5Z0nc00ktvz7lS9ZSq1e+tLUY/BvPnk34W7UDH24Be2Oq
X-Received: by 2002:a0c:e7d1:0:b0:66d:1b9b:196c with SMTP id
 c17-20020a0ce7d1000000b0066d1b9b196cmr8375361qvo.2.1698005554503; 
 Sun, 22 Oct 2023 13:12:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBW58orPIO22byFnmUIfNddQykfru+S3noLW2eeiJ8oSg/lGuVC91BA/vuoZ2apIHdK1a7TQ==
X-Received: by 2002:a0c:e7d1:0:b0:66d:1b9b:196c with SMTP id
 c17-20020a0ce7d1000000b0066d1b9b196cmr8375342qvo.2.1698005554040; 
 Sun, 22 Oct 2023 13:12:34 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a0cfe0b000000b0065af657ddf7sm2330515qvr.144.2023.10.22.13.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 13:12:33 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com
Subject: [PATCH RFC 0/7] migration/multifd: quit unitifications and separate
 sync packet
Date: Sun, 22 Oct 2023 16:12:04 -0400
Message-ID: <20231022201211.452861-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

This is an RFC series, at least for 9.0, so not urgent for this release.
Just for early reviews.

Said so, patch 1 could be a bugfix, didn't copy stable as I don't think
it's worthwhile.  Maybe worth picking up even soon.

This series majorly does two things as mentioned in the subject, namely:

 1) Quit unifications: after read Fabiano's patch, I moved that further to
    drop p->quit, meanwhile I found some path that may miss things here and
    there.  Got all of them cleaned/fixed up.

 2) Separate SYNC packet: it seems the SYNC packet is confusing in multifd,
    where it's the only case that main thread can modify p->flags too.  The
    field "pending_job" is also confusing to be an integer.  Split it can
    be helpful to make multifd code more readable, meanwhile making
    pending_job a boolean (with yet another one added pending_sync for SYNC).

I think I'm more confident 1) is a good idea, maybe not 2). The last patch
I put it last because I think it reduces duplication, but I'm not sure
whether that's a common flavour of how code should be written.  Let me know
your opinions.  Thanks,

Peter Xu (7):
  migration: Drop stale comment for multifd zero copy
  migration: Fix error leak in multifd_tls_outgoing_handshake()
  migration: multifd_send_kick_main()
  migration: Drop MultiFDSendParams.quit and cleanup error paths
  migration: Modulize multifd send threads with a few helpers
  migration: Split multifd pending_job into two booleans
  migration: Further unify paths for multifd normal or sync requests

 migration/multifd.h |  18 +--
 migration/multifd.c | 307 +++++++++++++++++++++++---------------------
 2 files changed, 170 insertions(+), 155 deletions(-)

-- 
2.41.0


