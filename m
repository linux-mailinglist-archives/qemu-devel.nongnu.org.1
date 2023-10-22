Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3558C7D25C7
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 22:14:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1queoZ-0005FY-6a; Sun, 22 Oct 2023 16:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1queoU-0005Cd-GH
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 16:12:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1queoS-00060s-Nx
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 16:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698005558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fLhg34I1cMdFLR/HfPBn3YE3lnP5nXAiKWY2LyUuwjY=;
 b=dfpHBSyMo2A8c6yoKGKVFXxONKesbe4FTdpqggA1vmMtRjVOku91u+N2Mq0l9+gz4UMYEv
 H6I+UPIS8cQ3aMnnop3V5Rw3wQgZdhJb6AEle/qxD48aPp+WUKB4eDz6Il+3QlKgtTO0ZZ
 ApZEMJZX9GIzF3EnheXC0o1qvj5LzR4=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-KjmLqhOZOo295Dr1YAYN2w-1; Sun, 22 Oct 2023 16:12:36 -0400
X-MC-Unique: KjmLqhOZOo295Dr1YAYN2w-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-581e7b03855so1204120eaf.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 13:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698005556; x=1698610356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fLhg34I1cMdFLR/HfPBn3YE3lnP5nXAiKWY2LyUuwjY=;
 b=AzW4Lk10hrUzHBDIgMLvJRTPX7mqe+PHKglc5P1Ff0/6NXfQcKFxtT+gdzv4cleqjv
 5DVz6F4h3By5XYUqvQdCJXoNRwyfuq0t1JWAFsxsgCrAzkvnkCk6JfrJ8NYMKBAitVPH
 TkALoA8Ormut38sesETlESZgcazlIceZ4BASk446fK38LPWIRqnFxG1B0f8rXxkfGz+S
 pkmzRt2w3/MgESpy35YYOCFqXudwv4hxVEn7BMl4ZHt1/7Xa8kDQ80CQth0OigS7Oujj
 qrHqNoBkJ5P6Caj1Ujj3EEOs6Iw6k24qgaqcN19mfJTY78KZEOjgG8mOKHxi1t8feVgZ
 ZCAA==
X-Gm-Message-State: AOJu0Yx58SWuo0eMOfinWR394RJkx6HOyw9GaExyz1bQBVU9/LwocEDz
 ZNbPSHvGjlH9Ma+SAoVolaXpG5GXVbZLk5NwuU3kIDxBbDiMquTG/K8AEjL62na/P0BkH2p9eHc
 QYtVGnwhdDY77pWwZ7iGEwHVJobu3goMQRJ5rDv8eyHQTgAo4O1fCtmgA9XQkOBvSE316a7Hx
X-Received: by 2002:a05:6870:9d98:b0:1e9:a8ff:67e3 with SMTP id
 pv24-20020a0568709d9800b001e9a8ff67e3mr9408199oab.4.1698005555867; 
 Sun, 22 Oct 2023 13:12:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWxS4X7MsUD3DKTl4ASCdQWSYdLlztOu+wWdeVqXCMJ5wF2cLrQysPIwGaGDPZvJ6+pRbGvw==
X-Received: by 2002:a05:6870:9d98:b0:1e9:a8ff:67e3 with SMTP id
 pv24-20020a0568709d9800b001e9a8ff67e3mr9408176oab.4.1698005555399; 
 Sun, 22 Oct 2023 13:12:35 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a0cfe0b000000b0065af657ddf7sm2330515qvr.144.2023.10.22.13.12.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 13:12:34 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com
Subject: [PATCH RFC 1/7] migration: Drop stale comment for multifd zero copy
Date: Sun, 22 Oct 2023 16:12:05 -0400
Message-ID: <20231022201211.452861-2-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231022201211.452861-1-peterx@redhat.com>
References: <20231022201211.452861-1-peterx@redhat.com>
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

We've already done that with multifd_flush_after_each_section, for multifd
in general.  Drop the stale "TODO-like" comment.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 1fe53d3b98..c8bdd88041 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -600,17 +600,6 @@ int multifd_send_sync_main(QEMUFile *f)
         }
     }
 
-    /*
-     * When using zero-copy, it's necessary to flush the pages before any of
-     * the pages can be sent again, so we'll make sure the new version of the
-     * pages will always arrive _later_ than the old pages.
-     *
-     * Currently we achieve this by flushing the zero-page requested writes
-     * per ram iteration, but in the future we could potentially optimize it
-     * to be less frequent, e.g. only after we finished one whole scanning of
-     * all the dirty bitmaps.
-     */
-
     flush_zero_copy = migrate_zero_copy_send();
 
     for (i = 0; i < migrate_multifd_channels(); i++) {
-- 
2.41.0


