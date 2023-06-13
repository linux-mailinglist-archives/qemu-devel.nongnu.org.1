Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EE172E7C1
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 18:03:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q96Ta-0004pI-4A; Tue, 13 Jun 2023 12:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q96TW-0004mr-44
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 12:02:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q96TU-00041L-K5
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 12:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686672147;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4RRgOs2Sbm7hqPt9DtnP5tt5MimC4ZTzB0J7PGxLlDs=;
 b=P7d/DgdGOvpcr4ctM9N8X70FY6e7tEktqX5GiPGHgFqkyrs/KjahJRXjZR/7aHCJBf2Sur
 p73lWe6ns7zO08b0v2q+T2Vur1STDNpYXM0ZeSguJKpRpWrYiWccTErcrBh2YppLwUwlr6
 4pmymMWTMIKf5PyRdbwkn8AkStOEVXI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-KUCIaNXFP7Or4xgFotMwbQ-1; Tue, 13 Jun 2023 12:02:19 -0400
X-MC-Unique: KUCIaNXFP7Or4xgFotMwbQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30fb891c5e3so4730821f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 09:02:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686672128; x=1689264128;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4RRgOs2Sbm7hqPt9DtnP5tt5MimC4ZTzB0J7PGxLlDs=;
 b=bcLCRcXU9DZAtu/U/4Z5XX3XU4r3tfSK/DrnflPuB6sVvqDlWqbrhIeFRJuusl9Wzc
 aoStUmOObiTF6KMCWF98jvyf8lJcmZ5RN8Tkp7MgxyaPhfLJ8m4h475Vj369PwL3tiEr
 vVSvQ4xWESYTcuxyxc68PHPVIhe7BXErZudAXzCNzi3gF7R6SrF2YRdoQzSldDNFdZFX
 qod1kyQwWjorMnJ/8av2HxojUJxDT3TIXrIt/XNASPulQ9WiSDKLEPlFlMH/SoXJCUYv
 aLZ/jDnkZWdYs5iT/30rJXgdZHPm7rBYBonwiTpENz8UktPbaHVWJc6Cto3Jn5Z5CICB
 ISyA==
X-Gm-Message-State: AC+VfDwrwQVn3HDmW9tz01ABvS6GQFKDjFaUG5ZoB/UzUDxMJvy0OlF8
 PwOHsm3bRYkMkW8NU8XFERinJiqo/OZzvlRCb7Spnkjm+p5nm1sT2glHHGyd9Gtg49Fm0+fiLC8
 pXcBu3MIN3WL7Hmo=
X-Received: by 2002:a5d:568c:0:b0:30f:ca33:5352 with SMTP id
 f12-20020a5d568c000000b0030fca335352mr2820130wrv.30.1686672128560; 
 Tue, 13 Jun 2023 09:02:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5b3xjeeZL6YgNReSkMyb/4gdxZufUoLWaHrhVKz8NxR+VHgDCoJAOgI61S4mu1fZl1EcOohA==
X-Received: by 2002:a5d:568c:0:b0:30f:ca33:5352 with SMTP id
 f12-20020a5d568c000000b0030fca335352mr2820110wrv.30.1686672128128; 
 Tue, 13 Jun 2023 09:02:08 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 t3-20020a5d6903000000b0030fcaf57660sm3030353wru.29.2023.06.13.09.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 09:02:06 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Leonardo Bras <leobras@redhat.com>,  Hailiang
 Zhang <zhanghailiang@xfusion.com>,  Fiona Ebner <f.ebner@proxmox.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,  qemu-block@nongnu.org,  Fam Zheng
 <fam@euphon.net>
Subject: Re: [PATCH v2 04/20] qemu-file: We only call
 qemu_file_transferred_* on the sending side
In-Reply-To: <ZH4m8nUAEfZglPLD@x1n> (Peter Xu's message of "Mon, 5 Jun 2023
 14:18:26 -0400")
References: <20230530183941.7223-1-quintela@redhat.com>
 <20230530183941.7223-5-quintela@redhat.com> <ZH4m8nUAEfZglPLD@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 13 Jun 2023 18:02:05 +0200
Message-ID: <87y1kne4g2.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Peter Xu <peterx@redhat.com> wrote:
> On Tue, May 30, 2023 at 08:39:25PM +0200, Juan Quintela wrote:
>> Remove the increase in qemu_file_fill_buffer() and add asserts to
>> qemu_file_transferred* functions.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> The read side accounting does look a bit weird and never caught my notice..
>
> Maybe worth also touching the document of QEMUFile::total_transferred to
> clarify what it accounts?
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> Though when I'm looking at the counters (didn't follow every single recent
> patch on this..), I found that now reading transferred value is actually
> more expensive - qemu_file_transferred() needs flushing, even if for the
> fast version, qemu_file_transferred_fast() loops over all possible iovs,
> which can be as large as MAX_IOV_SIZE==64.
>
> To be explicit, I _think_ for each guest page we now need to flush...
>
>   ram_save_iterate
>     migration_rate_exceeded
>       migration_transferred_bytes
>         qemu_file_transferred
>
> I hope I'm wrong..

See patch 7:

diff --git a/migration/migration-stats.c b/migration/migration-stats.c
index 79eea8d865..1696185694 100644
--- a/migration/migration-stats.c
+++ b/migration/migration-stats.c
@@ -62,7 +62,7 @@ uint64_t migration_transferred_bytes(QEMUFile *f)
 {
     uint64_t multifd = stat64_get(&mig_stats.multifd_bytes);
     uint64_t rdma = stat64_get(&mig_stats.rdma_bytes);
-    uint64_t qemu_file = qemu_file_transferred(f);
+    uint64_t qemu_file = stat64_get(&mig_stats.qemu_file_transferred);
 
     trace_migration_transferred_bytes(qemu_file, multifd, rdma);
     return qemu_file + multifd + rdma;


> Does it mean that perhaps we simply need "sent and put into send buffer"
> more than "what really got transferred"?  So I start to wonder what's the
> origianl purpose of this change, and which one is better..

That is basically what patch 5 and 6 do O:-)

Problem is arriving to something that is bisectable (for correctness)
and is easy to review.

And yes, my choices can be different from the ones tat you do.

The other reason for the small patches is that:
a - sometimes I found a different test where things broke, and have to
    bisect
b - small patches are much easier to rebase (that I am doing a lot)

Later, Juan.


