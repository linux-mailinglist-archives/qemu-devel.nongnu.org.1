Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E71271602D
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:42:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3ygH-0001Ag-Id; Tue, 30 May 2023 08:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3yfo-00018f-5Y
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:42:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3yfh-00042V-9x
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685450461;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=uZS8BMrxI5e5o6EaleD85+nDUt9106srEolGNdtsLLw=;
 b=f1jevPwUbcj7y5LQVb5/WHKDD3p1nFIhFZblBW/fajWAm0uikXBboNDRirPoZ9f90Q0CTD
 +mDtbshWi0K4PUVd5aF7fkFC4dI88fuWoX4Pi8ECUFdg7tYcqLCTzwUPm3WmvwKectZPji
 2y7t7avMoW6fv0N1w7OxI6SJS3vFhi0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-CF4fOlfYP9Colvay8MYaPA-1; Tue, 30 May 2023 08:40:59 -0400
X-MC-Unique: CF4fOlfYP9Colvay8MYaPA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f61408d926so16599415e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685450458; x=1688042458;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uZS8BMrxI5e5o6EaleD85+nDUt9106srEolGNdtsLLw=;
 b=Je96/ZnZgJ4SQ7rh6uod1toKTVbOR9QnQD+CUWhWXBzMxBf81cg+Ue0+Q9Q2vX9B7v
 cZ9MGiuYOxjHr3O6bIA/CbiODORTXkBG4Xn4hCkC6P9I1Wzkt2g+O4CBol9x15G1kylb
 bOiZHCkVqIpiMC4fB5IKVPB6nx1Ur6iR7ptQZz41snHWWZZQL5tf9bs11TS4XR5l3ACX
 9BzHsLT46v/wPS1+iTNsNFQpWRAck9jwEjezaGAyownk+2b+he2ssAQjv5cJNVDWMuaA
 0HLz5b5ZNNzFDeX1n7tDS5O08YbnKIGXVkXJ+xEG55kg918YhEylWZUtbogu8o8C9f+5
 JIAg==
X-Gm-Message-State: AC+VfDwj3J2aOA82C+s+f1PurGlHPNadwU7sdegmAnO5FMF3jbVBGWNf
 fYeL8XqgvAozt4eLEEILL8oXti/4w0d24QWySTd00UDsAStH2vUBBfgkJuAJCB0ZgeaxzIuknKu
 Zskyctmsotv0CpZ/T65iRc75wmXHTKugtqe1kwJXTEcwDQ/yOmJrfhvzr2J4kYkOlcchwls7Cl+
 kJhA==
X-Received: by 2002:a1c:c903:0:b0:3f4:e4f5:1f63 with SMTP id
 f3-20020a1cc903000000b003f4e4f51f63mr1350968wmb.41.1685450458255; 
 Tue, 30 May 2023 05:40:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4bIaPWZFyeBJB43HAKAlT6r/krL36iRrjFoAjOOKD41PjTAp4qht4KdSqO7axbc4jB8HnKYg==
X-Received: by 2002:a1c:c903:0:b0:3f4:e4f5:1f63 with SMTP id
 f3-20020a1cc903000000b003f4e4f51f63mr1350946wmb.41.1685450457893; 
 Tue, 30 May 2023 05:40:57 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 n4-20020a05600c294400b003f3157988f8sm17030050wmd.26.2023.05.30.05.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 05:40:57 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org,  Leonardo Bras <leobras@redhat.com>,  Hailiang
 Zhang <zhanghailiang@xfusion.com>,  Peter Xu <peterx@redhat.com>,  Fam
 Zheng <fam@euphon.net>,  Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 00/16] Next round of migration atomic counters
In-Reply-To: <20230530122813.2674-1-quintela@redhat.com> (Juan Quintela's
 message of "Tue, 30 May 2023 14:27:57 +0200")
References: <20230530122813.2674-1-quintela@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 30 May 2023 14:40:56 +0200
Message-ID: <87fs7evvon.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Juan Quintela <quintela@redhat.com> wrote:
> Hi

Hi

Fiona, I forgot to put your on the CC'd list.  This series should reget
the speed problem that you find.

Later, Juan.

> On this series:
>
> - Make sure that qemu_file_transferred() make sense and its used
>   coherently
>
> - Use stat64 for qemu_file_transferred(), so we can call the function
>   from any thread.
>
> - Don't account for the same transfer twice (i.e. it is multifd_bytes,
>   rdma_bytes or qemu_file_bytes) qemu_file_transferred() just sums all
>   of them.
>
> - Use this new counter for rate_limit()
>
> - Remove old trasferred stat64 (now we use the real thing)
>
> - Simplify qemu_file_get_error(): see where next cleanups are coming
>
> - As an example, qemu_fflush() now return errors.
>
> Please review.
>
> Later, Juan.
>
> Based-on: Message-Id: <20230530115429.1998-1-quintela@redhat.com>
> Subject: [PULL 00/21] Migration 20230530 patches
>
> Juan Quintela (16):
>   qemu-file: Rename qemu_file_transferred_ fast -> noflush
>   migration: Change qemu_file_transferred to noflush
>   migration: Use qemu_file_transferred_noflush() for block migration.
>   qemu-file: Don't call qemu_fflush() for read only files
>   qemu-file: We only call qemu_file_transferred_* on the sending side
>   qemu_file: Use a stat64 for qemu_file_transferred
>   qemu_file: total_transferred is not used anymore
>   migration: Use the number of transferred bytes directly
>   qemu_file: Remove unused qemu_file_transferred()
>   qemu-file: Remove _noflush from qemu_file_transferred_noflush()
>   migration: migration_transferred_bytes() don't need the QEMUFile
>   migration: migration_rate_limit_reset() don't need the QEMUFile
>   qemu-file: Simplify qemu_file_get_error()
>   migration: Use migration_transferred_bytes()
>   migration: Remove transferred atomic counter
>   qemu-file: Make qemu_fflush() return errors
>
>  migration/migration-stats.h | 16 ++++++----------
>  migration/qemu-file.h       | 29 +++++------------------------
>  migration/colo.c            | 11 +++--------
>  migration/migration-stats.c | 10 +++++-----
>  migration/migration.c       | 17 ++++++-----------
>  migration/multifd.c         |  3 ---
>  migration/qemu-file.c       | 35 ++++++++++++++---------------------
>  migration/ram.c             | 29 ++++++++++-------------------
>  migration/rdma.c            |  4 +---
>  migration/savevm.c          |  7 +++----
>  migration/vmstate.c         |  4 ++--
>  11 files changed, 55 insertions(+), 110 deletions(-)


