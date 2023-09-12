Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6371A79DBBE
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 00:18:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgBgn-0006I8-0Z; Tue, 12 Sep 2023 18:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgBgk-0006HO-H9
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgBgi-0008Tx-9y
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694557010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q7pM0dH+qD/W7oxo4fiBaJLMQ4GgYbYPoG7KZcwI2Ec=;
 b=eRFWc4fMOVpDbo5wvTUU2xiN4rJpB1B3Vmn/BrR61WS3uWm2ed9mTewBKmqaKf0oUoaiEt
 g80xRtoLJnhOmZoAV+JBPwnLPrRlb/yTZKf/yh8ZehfQncYmmAobUlFEFkic6A3bntbH/5
 Xrdt0U+RpR/Mo9GBt9zDjNLEyj5go2k=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-R1crF9f0NfOqW28R8nBfGg-1; Tue, 12 Sep 2023 18:16:49 -0400
X-MC-Unique: R1crF9f0NfOqW28R8nBfGg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-63d2b88325bso14324176d6.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 15:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694557008; x=1695161808;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q7pM0dH+qD/W7oxo4fiBaJLMQ4GgYbYPoG7KZcwI2Ec=;
 b=iYbtRXdZtpjs4x1MajGToRC+ESzDkLhIgyqD+ArnAq0gAH22/vYjtbAlSHlCrlhxV3
 0pYiwPUiPOmBm+t149rKyvavs60W88RlMNkbO8Fk9OmF1y0GgaQUhAgU3zKq2jH5sYva
 +JnPnAiBqS28mrrNLMAzWBfMBF8+yCGA5Lb8sWKhTtQtDxBpzHRaBJl/gN/4ykli1KDp
 ExcF/YgovtsqJzorUrXQfiRQ7XFJKhWs49+yLka71d0T5IkW530xy3dY/pE0vLW0ThGm
 SqxMAMkisfGlsYWrN7DssEDyyFAh5XcfuaqPk1kQMswwMA8TwHEtV4u4VkD+eWWXcWjS
 hTgw==
X-Gm-Message-State: AOJu0YyO9N4zHvfF4OU56glJW9ycBj9UmxSA9H/FizjKLQR7o4wL/8Mu
 +jYEGH0vyR8Yg14sIgF0esMQNDMy90DJEKELs4HALbdVvG9vyBXA5Q5PQUOFGS5CFdLh2OZx0X6
 akUZQns0/alSIIqE=
X-Received: by 2002:a05:6214:528a:b0:63f:89d3:bf21 with SMTP id
 kj10-20020a056214528a00b0063f89d3bf21mr731644qvb.5.1694557008714; 
 Tue, 12 Sep 2023 15:16:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVq2zL/kE5vOGTHcrVv2rzyQIL+tvHhWdGPpoDst8HyMCxYRuCIViJhrxV1WYyfIx68VPjcw==
X-Received: by 2002:a05:6214:528a:b0:63f:89d3:bf21 with SMTP id
 kj10-20020a056214528a00b0063f89d3bf21mr731640qvb.5.1694557008453; 
 Tue, 12 Sep 2023 15:16:48 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 b15-20020a0cf04f000000b00647290bd591sm3974037qvl.121.2023.09.12.15.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 15:16:48 -0700 (PDT)
Date: Tue, 12 Sep 2023 18:16:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Xiaohui Li <xiaohli@redhat.com>
Subject: Re: [PATCH 9/9] migration/postcopy: Allow network to fail even
 during recovery
Message-ID: <ZQDjTRtNVbtruUtD@x1n>
References: <20230829214235.69309-1-peterx@redhat.com>
 <20230829214235.69309-10-peterx@redhat.com>
 <877cowmdu0.fsf@suse.de> <ZQDEh85X2IcC+o8M@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZQDEh85X2IcC+o8M@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Tue, Sep 12, 2023 at 04:05:27PM -0400, Peter Xu wrote:
> Thanks for contributing the test case!
> 
> Do you want me to pick this patch up (with modifications) and repost
> together with this series?  It'll also work if you want to send a separate
> test patch.  Let me know!

It turns out I found more bug when I was reworking that test case based on
yours.  E.g., currently we'll crash dest qemu if we really fail during
recovery, because we miss:

diff --git a/migration/savevm.c b/migration/savevm.c
index bb3e99194c..422406e0ee 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2723,7 +2723,8 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
         qemu_mutex_unlock(&mis->postcopy_prio_thread_mutex);
     }
 
-    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
+    /* Current state can be either ACTIVE or RECOVER */
+    migrate_set_state(&mis->state, mis->state,
                       MIGRATION_STATUS_POSTCOPY_PAUSED);
 
     /* Notify the fault thread for the invalidated file handle */

So in double failure case we'll not set RECOVER to PAUSED, and we'll crash
right afterwards, as we'll skip the semaphore:

    while (mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {  <--- not true, continue
        qemu_sem_wait(&mis->postcopy_pause_sem_dst);
    }

Now within the new test case I am 100% sure I can kick both sides into
RECOVER state (one trick still needed along the way; the test patch will
tell soon), then kick them back, then proceed with a successful migration.

Let me just repost everything with the new test case.

Thanks,

-- 
Peter Xu


