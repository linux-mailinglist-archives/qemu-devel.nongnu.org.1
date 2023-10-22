Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 249837D25C2
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 22:14:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1queoX-0005F4-H2; Sun, 22 Oct 2023 16:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1queoU-0005Ce-GH
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 16:12:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1queoS-00060v-Ki
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 16:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698005558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GEK3BC2R+ljz1Pe0etq5Hqc5Baqx24HXWF1XvvP10jw=;
 b=huSvny0VB9XHgNijTA08jdBfFjYruTHxRmjp38GQnmKAoDDQydSimb2DKtJnS3bsfG6wlF
 N1L+KLwPESlFXyptQr2D7od6O04fGR7hfIeJkCuTYcob0W+WNbOwLBKaVqDkil+o6qTtXr
 1cIydGTD6R1JPnzVkySaF300gAS5nVU=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-F7XOLwcwMbOp1pyVwgrpcQ-1; Sun, 22 Oct 2023 16:12:37 -0400
X-MC-Unique: F7XOLwcwMbOp1pyVwgrpcQ-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3ade1013032so901243b6e.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 13:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698005556; x=1698610356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GEK3BC2R+ljz1Pe0etq5Hqc5Baqx24HXWF1XvvP10jw=;
 b=AttO+wcLJYo6zGvTaZhKUfc3x1Nv/A+kh/1XHjSSH8ASTisqfXZpARdPxM3CPlLwmU
 eAes0qNYaUXfCQu4btYKbk4+IE6j+aiQZ/6mk2J+dPHIeQRtWYuzxJgmG1mi9DJKriVV
 XPX1/E3p3ckHpMCUfcohVKeMKvVvptBBPHZ8UHUZdAj8Fn8b2fTNpJJiHpAuR7uQcOfK
 XEDZg7EnhShMWo0qWWbVdUMc6yQ4z5h+S/lRj0WSVmC1ZoN5xHB5HJpYymLf/9EF6xKj
 fofNGuK1XB/GKiwk7alAFPRf61fXFjvrlhC4rx4PEWRRMP5tAilQJCCjgYp+37B163NR
 7qsg==
X-Gm-Message-State: AOJu0YxdHoXk6FQ0+Hrxer50hKg2YKNUUun6QOR6BmOUq3Wi4OoiPZsy
 A6D5Nl6lXMPSKYLzrw9ArLEyvwGoa09Ji0Ve/ycGFvMjCRAK/koeGwni2TCNy85imlGyT5dbyAF
 KN9rjFhFCOg1CsPzBLEzm8GQdZm0HsmrnokrjJ/rtEKtYMpXR3MIT039A/Uu82QiiTMSuk/As
X-Received: by 2002:a05:6808:38c6:b0:3a9:f25d:d917 with SMTP id
 el6-20020a05680838c600b003a9f25dd917mr8377637oib.4.1698005556494; 
 Sun, 22 Oct 2023 13:12:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaH17Qcs7m4G/kZvhXh+gI3ScRQtv4S+b7ty/qaUpH+mSDsLBteeMs7h5qXVNNoeS2cinuPQ==
X-Received: by 2002:a05:6808:38c6:b0:3a9:f25d:d917 with SMTP id
 el6-20020a05680838c600b003a9f25dd917mr8377625oib.4.1698005556187; 
 Sun, 22 Oct 2023 13:12:36 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a0cfe0b000000b0065af657ddf7sm2330515qvr.144.2023.10.22.13.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 13:12:35 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com
Subject: [PATCH RFC 2/7] migration: Fix error leak in
 multifd_tls_outgoing_handshake()
Date: Sun, 22 Oct 2023 16:12:06 -0400
Message-ID: <20231022201211.452861-3-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231022201211.452861-1-peterx@redhat.com>
References: <20231022201211.452861-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The Error* is leaked when error triggerred.

It logically should have a Fixes here, but since the code changed a few
times, the backport won't be straightforward anyway.  Let's not bother with
leaking an error in the failure path for now.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/multifd.c b/migration/multifd.c
index c8bdd88041..4afdd88602 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -789,6 +789,7 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
     p->quit = true;
     qemu_sem_post(&multifd_send_state->channels_ready);
     qemu_sem_post(&p->sem_sync);
+    error_free(err);
 }
 
 static void *multifd_tls_handshake_thread(void *opaque)
-- 
2.41.0


