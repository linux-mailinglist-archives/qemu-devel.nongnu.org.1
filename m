Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E76BB7687
	for <lists+qemu-devel@lfdr.de>; Fri, 03 Oct 2025 17:54:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4hv2-0005UR-Qy; Fri, 03 Oct 2025 11:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4huo-0005M9-8D
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htz-0007jS-Lj
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IPjuVNL/q1U96AXGabPRYkeJDkmfntwGHZ3pI05llmQ=;
 b=cZhdXkZDNDu4mJl9YGjvQ+Mfo3EHRKYSqnG7QJ/0/diQcctK/VCb8OKpB+GSyjFOuTb2Ww
 IZiwLVprNsQWEkCjNTyFFy2Yiw0eXue3/pjqIflOEtVcqYFaNAmXOrtgUn2TnJz6Cd91rA
 syswIL9TRUSG/uXRFpTBUBgKtfMVYLA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-F-yLHJmbP7iPpzsa0wF-cQ-1; Fri, 03 Oct 2025 11:40:44 -0400
X-MC-Unique: F-yLHJmbP7iPpzsa0wF-cQ-1
X-Mimecast-MFC-AGG-ID: F-yLHJmbP7iPpzsa0wF-cQ_1759506043
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-78f28554393so3364726d6.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506043; x=1760110843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IPjuVNL/q1U96AXGabPRYkeJDkmfntwGHZ3pI05llmQ=;
 b=GO4JSwbfJCA2N8uJkAkxQ1cz+qzbXE0/cm5gk5YLjXQGotbogveDYmoKeBkqzqP4bv
 unlxRbdFJMIYEDf46SyNNux/xQ+OFi3MhMcwm5R98A5Q+VxHErAqtzWT7kDythfOIraI
 +llbrvCf+xQQ6IpkcX54q98OloQfe33F6fU8b1jjzv0Gqwf+46ToMC4m60kDm4fSEKLN
 iIMZd1jIx20umGQT0OByS+Lv0LYVLWHym3kJa1IINaVyMHVo3+I9OqpOGENfbhernS48
 nIAzg6qpR3A9WB4YglI5wdZ/ntGfNWN7Wp/bzk/DCMfM1Ydu4WCKTEgPstLZkzk504iO
 YF3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyDw5BlLgv79Bt6mkwGNK3ABk9sGST/vBVQ0NL58Tci3QsksIo7XlrcU4Xj5100gbGOigK2JAdiUC2@nongnu.org
X-Gm-Message-State: AOJu0YyedYlr/xOU++FtfHGfJGU2p7deK2kxlU/H5iUT0NV7Dn81Fkmo
 kKvFx+4jAUgyOJgPBLi4dhdhyTaT31HnDyxgOUnt9RRHsJiRsA8zqFTARdeS9eNKvvSeM8/L50q
 YVjSyIHoSAzJAtWhAOlFb0UF8zr1FynSRWPsU0r7geCkkHEjE92A8I2Fp
X-Gm-Gg: ASbGncu/8i9Rd3jygFxfiW+5HgJOLktCtv5hqgLqCgP/JdGpJpKyi5wEHdM5/qt+SBZ
 b85008UwwhFp/9831BAKBEbOHhn9WvE14ok2tUCLOoT9Jkm/6ilMhuyn8lAGY1MC6Eg2csOnFAZ
 pk96ibLco3IHsgvp7RKLhiUyTb+LKo+PcL76nvIj6Mz5A7X3tvutcGRO9ewJssByWjUDQh3jini
 wpvjShs+yTNc8N1ikuXEDia0Me8HkXB7hAIAFMLK5D8q7f4Fl66yBGeYHjwvGOZC6Ay+h4hOi0C
 7OnxJAT9UgLXx7PuHwC2xWVpxs1EgpenJz3imA==
X-Received: by 2002:a05:6214:3319:20b0:879:defa:a6f2 with SMTP id
 6a1803df08f44-879defaa90emr29180586d6.18.1759506042664; 
 Fri, 03 Oct 2025 08:40:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxEVERul45gbjsaUPibQ2ZdU/T5y0RiOKjgwKHBc0EzV+azJPlbLV4yhULuiy2V0uOCjiUbg==
X-Received: by 2002:a05:6214:3319:20b0:879:defa:a6f2 with SMTP id
 6a1803df08f44-879defaa90emr29180216d6.18.1759506042205; 
 Fri, 03 Oct 2025 08:40:42 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:41 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 36/45] migration: simplify error reporting after channel read
Date: Fri,  3 Oct 2025 11:39:39 -0400
Message-ID: <20251003153948.1304776-37-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

The code handling the return value of qio_channel_read proceses
len == 0 (EOF) separately from len < 1  (error), but in both
cases ends up calling qemu_file_set_error_obj() with -EIO as the
errno. This logic can be merged into one codepath to simplify it.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Link: https://lore.kernel.org/r/20250801170212.54409-2-berrange@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/qemu-file.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 0ee0f48a3e..2d4ce174a5 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -348,17 +348,13 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
             } else {
                 qio_channel_wait(f->ioc, G_IO_IN);
             }
-        } else if (len < 0) {
-            len = -EIO;
         }
     } while (len == QIO_CHANNEL_ERR_BLOCK);
 
     if (len > 0) {
         f->buf_size += len;
-    } else if (len == 0) {
-        qemu_file_set_error_obj(f, -EIO, local_error);
     } else {
-        qemu_file_set_error_obj(f, len, local_error);
+        qemu_file_set_error_obj(f, -EIO, local_error);
     }
 
     for (int i = 0; i < nfd; i++) {
-- 
2.50.1


