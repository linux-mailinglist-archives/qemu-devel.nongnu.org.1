Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A9A7B5DBC
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 01:30:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnSMC-0006QT-NS; Mon, 02 Oct 2023 19:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qnSMB-0006MZ-Ch
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 19:29:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qnSM9-00018d-Qy
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 19:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696289381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nvul3dJDyf7gD92K5/rLUjy+/G2KhfUL9htI/tgqRw4=;
 b=Loptb/PaRbyTClyWSfdPBTBSJ+vxQQoskRXkdAO3OKavM5QMF0JI+mNo96YrnDtdrY57e4
 bpuxTyht9vFJjtwjlmwHJvuSi3ZZIUFeSO4DfS++aFmCVsmeVJD+nkju8poF89t/fjYvOq
 Bll/ieREVKn9KrubH9RUkgEjE8/JXGA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-SUToARU-OCG-UsmLvIxfAA-1; Mon, 02 Oct 2023 19:29:38 -0400
X-MC-Unique: SUToARU-OCG-UsmLvIxfAA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7756d0fb11dso10432785a.0
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 16:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696289378; x=1696894178;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nvul3dJDyf7gD92K5/rLUjy+/G2KhfUL9htI/tgqRw4=;
 b=pB49nnUsfySjzbMihcpUGXD6K45AqvRgBoTsjTdspurm4DO5w2jzfMl+CTE3hgT31A
 QYSVmoZda/10c6hHFjl3UYy0NKCjo8DtF/pqwglyHTQZApT6sihis0gIAPjwADxa5oiH
 B4J6IW0B3AeTxbFUe9dOIqZFvXufFhbIVytVtGe3AHOMUX/8Ao3xYleGUHsh6OvkR2im
 0PyhZP5/bxzlcx0P3qJW6GZmKQK25fqTbbCslLmUUG+DZ1xryHqd08TUzX1CnzbTGzTi
 yWE/AbQVD0+DpNIociyhMuCS0Ero4y+AZUts/JCifxoB9jmoiqfcKZPCjWmsoqSVxcVk
 xnxA==
X-Gm-Message-State: AOJu0YwzLQtHVUpwV5zzaTQ2o0VaG9IBryhfINiQPmP3YOfolZR5gXq/
 /omvz+Dj/OjwcHQ3ofFL7qbmgbJdw+OTUHcs7JQcxtdfC3Q7NfNAzFNYiBwllCAPwUdznhft1Ah
 NETXh75/kbfLn+wM=
X-Received: by 2002:a05:6214:964:b0:668:e10e:3ca8 with SMTP id
 do4-20020a056214096400b00668e10e3ca8mr3574312qvb.6.1696289377725; 
 Mon, 02 Oct 2023 16:29:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN9KizlghvLO0+WZulLFxfWSNOBN56+roeCCiNlqxfggRifP3/yIR4gZaWddpy7vkffDS3sA==
X-Received: by 2002:a05:6214:964:b0:668:e10e:3ca8 with SMTP id
 do4-20020a056214096400b00668e10e3ca8mr3574299qvb.6.1696289377397; 
 Mon, 02 Oct 2023 16:29:37 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 b11-20020a0ccd0b000000b0065aff6b49afsm7377939qvm.110.2023.10.02.16.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 16:29:36 -0700 (PDT)
Date: Mon, 2 Oct 2023 19:29:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 0/8] migration fixes
Message-ID: <ZRtSXxz0TeDY8odY@x1n>
References: <20230918172822.19052-1-farosas@suse.de>
 <1531b1d7-2c8c-4a69-109a-170bd686d894@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1531b1d7-2c8c-4a69-109a-170bd686d894@tls.msk.ru>
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

On Tue, Oct 03, 2023 at 01:55:35AM +0300, Michael Tokarev wrote:
> 18.09.2023 20:28, Fabiano Rosas wrote:
> > This series contains fixes for the two currently know failures that
> > show up in migration tests plus a set of fixes for some theoretical
> > race conditions around QEMUFile handling.
> > 
> > Patch 1 addresses the issue found in the postcopy/preempt/plain test:
> > https://gitlab.com/qemu-project/qemu/-/issues/1886
> > 
> > Patch 7 fixes a rare crash during the postocpy/preempt/recovery/plain test:
> > 
> >    Thread 7 "return path" received signal SIGSEGV, Segmentation fault.
> >        0x00005555560e4893 in qemu_file_get_error_obj (f=0x0, errp=0x0) at ../migration/qemu-file.c:154
> >        154         return f->last_error;
> > 
> > CI run: https://gitlab.com/farosas/qemu/-/pipelines/1008652837
> > 
> > Fabiano Rosas (7):
> >    migration: Fix possible race when setting rp_state.error
> >    migration: Fix possible races when shutting down the return path
> >    migration: Fix possible race when shutting down to_dst_file
> >    migration: Remove redundant cleanup of postcopy_qemufile_src
> >    migration: Consolidate return path closing code
> >    migration: Replace the return path retry logic
> >    migration: Move return path cleanup to main migration thread
> > 
> > Peter Xu (1):
> >    migration: Fix race that dest preempt thread close too early
> > 
> >   migration/migration.c    | 145 +++++++++++++++------------------------
> >   migration/migration.h    |  14 +++-
> >   migration/postcopy-ram.c |  38 +++++++++-
> >   3 files changed, 106 insertions(+), 91 deletions(-)
> 
> What can be done for -stable?
> 
> At least the whole thing applies cleanly to 8.1.

It seems v8.0.5 needs at least a few conflict resolutions.

I'd say we go apply those to 8.1.1, and we can skip 8.0 unless someone
requests for it.

Thanks,

-- 
Peter Xu


