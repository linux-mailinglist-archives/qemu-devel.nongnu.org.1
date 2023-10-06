Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B392B7BB63B
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:17:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoimy-00084D-Tn; Fri, 06 Oct 2023 07:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoimw-00081y-L7
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoimv-0000Hj-1t
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NAACJAej5aSBwACda6Ra2S0VR9ySPOa1Dz12qYGkco0=;
 b=bIrULPC2AHzbxs3Rv4UA5lXnFWwdcgauWd8GTRUYqjqd5FcRvIPOVcDEWbK45BNh0iB9I+
 qh9J1jOpqtdd0u++1UnEQwmRiokYD+qcFVFjkUU92ICFIZpCwxtlK2fOzeTJBPN1bMF3Rp
 jlTuFUT1HJOaq/cxek+UjQRHGCd1T9k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-9StRu68kNfO6XnPGIap9yQ-1; Fri, 06 Oct 2023 07:14:21 -0400
X-MC-Unique: 9StRu68kNfO6XnPGIap9yQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9a62adedadbso174428866b.1
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590860; x=1697195660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NAACJAej5aSBwACda6Ra2S0VR9ySPOa1Dz12qYGkco0=;
 b=SXqbSEn4z5ljdzSmaKZaiC0H/Dm3TnNMR5xAZ1bsA0+0PRH9nrYIm6If62cH8OmRK/
 SqR+9/5aSuZBQt/Eb1Fdj8sqWf0NTXeBNr/65gl1xD65AIqsYf/iaSApggWuJxX1V8g7
 MHKE27xX3yRsBiqkolJ0lfBz/ivKpfuCo/OVnsdhTDn0GeXvvprFWZSuDQsxWmp1AzJV
 XZUPGsPOE/2GZWHzFpvxhpN/ryki0sa6dbtliWlIJQPVozpd1CS4tLsLycQ59qTQNDAm
 jHMTK0g8NywqLIuil3Vw4vjB9gooKmUK2b0dKjbinMTJem6m6tgm0uZmlN4I0Oy3pDvF
 x75g==
X-Gm-Message-State: AOJu0YxM6ylqUuLc0uieeivtekFAB2/4oVWPvp79/dwCNCR+/z2hygag
 bKk0ioepsWRehSz2RVa5qHiAWvzd79xFrJW9YMus4ss6CakrCfo7M5T1L8oR3uWPjvJbYdOKO/p
 0I1zXSa4UTd/YsuW8fYxdvdmeYhsWubf8Wm1q5eR17MuswmQ6isYq3+yXrI43RqkeDB1WgGRDdo
 g=
X-Received: by 2002:a17:906:20d8:b0:9b9:f990:c701 with SMTP id
 c24-20020a17090620d800b009b9f990c701mr1638537ejc.52.1696590859907; 
 Fri, 06 Oct 2023 04:14:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkviGhsvdKX/bDur8391ZftJMTFPFu3D0FXyj02RlF9DsD11585cAmOXrAIKNUi3yUfWl9Cg==
X-Received: by 2002:a17:906:20d8:b0:9b9:f990:c701 with SMTP id
 c24-20020a17090620d800b009b9f990c701mr1638514ejc.52.1696590859421; 
 Fri, 06 Oct 2023 04:14:19 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 p22-20020a05640210d600b00530a9488623sm2414770edu.46.2023.10.06.04.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 04:14:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fiona Ebner <f.ebner@proxmox.com>
Subject: [PULL 03/26] util/log: re-allow switching away from stderr log file
Date: Fri,  6 Oct 2023 13:13:49 +0200
Message-ID: <20231006111412.13130-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006111412.13130-1-pbonzini@redhat.com>
References: <20231006111412.13130-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

From: Fiona Ebner <f.ebner@proxmox.com>

Commit 59bde21374 ("util/log: do not close and reopen log files when
flags are turned off") prevented switching away from stderr on a
subsequent invocation of qemu_set_log_internal(). This prevented
switching away from stderr with the 'logfile' monitor command as well
as an invocation like
> ./qemu-system-x86_64 -trace 'qemu_mutex_lock,file=log'
from opening the specified log file.

Fixes: 59bde21374 ("util/log: do not close and reopen log files when flags are turned off")
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20231004124446.491481-1-f.ebner@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/log.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/util/log.c b/util/log.c
index def88a9402b..d36c98da0b4 100644
--- a/util/log.c
+++ b/util/log.c
@@ -298,6 +298,8 @@ static bool qemu_set_log_internal(const char *filename, bool changed_name,
             r->fd = logfile;
             qatomic_rcu_set(&global_file, NULL);
             call_rcu(r, rcu_close_file, rcu);
+        }
+        if (changed_name) {
             logfile = NULL;
         }
     }
-- 
2.41.0


