Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CEA7B05E3
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 15:58:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlV3f-0004dG-JM; Wed, 27 Sep 2023 09:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qlV3S-0004bI-Gd
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 09:58:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qlV3Q-0006rt-KX
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 09:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695823094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VR1zw3PDEmFBO6HWYT8hs1BwiETeZxCeC6Y1tfPBazc=;
 b=guKR9VEIY1DT6nClmhND4kV38RNY9vvuRVMSrUbYbkcF+TknMitLTPhCoHlPvgO3Nu6gET
 W+ggOfRN48bZhNxBDM7L9+KU4lTmpPy5nyYaZ3aBJmI/cfQbaERbab5i9IGcH3UFYf6pg8
 iposMbhqK8O5sgx7X+xkSavr+2HiYzA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-Nr7dewB7O1-Dln9djo3H0Q-1; Wed, 27 Sep 2023 09:58:13 -0400
X-MC-Unique: Nr7dewB7O1-Dln9djo3H0Q-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-655bc5ee855so38418766d6.0
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 06:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695823092; x=1696427892;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VR1zw3PDEmFBO6HWYT8hs1BwiETeZxCeC6Y1tfPBazc=;
 b=XVNhnidT3kS4pa+CFu3EQy2eowzAx/h13PajJn3AvrmmK//zqjBs9UsPTiZ/zM0/b9
 r6O0J+tn66hp7YG22ZsMGVBbZ8Az3mkTdtbosYjEJOmoyeMtIOvi4owpf3eT2qDYGTP+
 yCtxrNqvKOX9l7JjFa6IKRyPMFWGiwe/GvigBvNRCOEG2SvNOW+/ORXgJqTnTMGkQ4PG
 lGAicIkuFXI63dWcgoctfGfcFZHBGLTD7KynCo4hMn920wTYIekoG9pLGqA9drXio7yB
 qxg8iQRP6kor149bYzm0K7G8cETJxFvpabCPgPY9r8KHBr2xyeCeMm8X4dvQXC77EXC5
 Xarg==
X-Gm-Message-State: AOJu0Yx6xtjMcawBIUpkRy3uSRMRz/22iQyivxZ++yIRYOXWTP8SkPk8
 GxcdFk4xh7HFs/HBi0Yc8fUI2b9PskohVJrsLJkCpYhuc+6DkF+/XBVDLuL3dBB/CNHe/hL7lxU
 7d7zoxFA1bJPk0k8=
X-Received: by 2002:a05:6214:da2:b0:65a:fc68:be20 with SMTP id
 h2-20020a0562140da200b0065afc68be20mr2160640qvh.3.1695823092629; 
 Wed, 27 Sep 2023 06:58:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAO1chNh2iLroXv8YNxhb2t2yV9r6V76MDAzPlXuhiXcyWTzodjoZCHOXHqIgvu07uCaqjaw==
X-Received: by 2002:a05:6214:da2:b0:65a:fc68:be20 with SMTP id
 h2-20020a0562140da200b0065afc68be20mr2160627qvh.3.1695823092276; 
 Wed, 27 Sep 2023 06:58:12 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 v6-20020a0cdd86000000b0065af657ddf7sm3958087qvk.144.2023.09.27.06.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 06:58:11 -0700 (PDT)
Date: Wed, 27 Sep 2023 09:58:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 0/8] migration fixes
Message-ID: <ZRQ08mYxTWfXbvfj@x1n>
References: <20230918172822.19052-1-farosas@suse.de> <8734yzn62i.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8734yzn62i.fsf@suse.de>
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

On Wed, Sep 27, 2023 at 09:39:33AM -0300, Fabiano Rosas wrote:
> Fabiano Rosas <farosas@suse.de> writes:
> 
> > This series contains fixes for the two currently know failures that
> > show up in migration tests plus a set of fixes for some theoretical
> > race conditions around QEMUFile handling.
> >
> > Patch 1 addresses the issue found in the postcopy/preempt/plain test:
> > https://gitlab.com/qemu-project/qemu/-/issues/1886
> >
> > Patch 7 fixes a rare crash during the postocpy/preempt/recovery/plain test:
> >
> >   Thread 7 "return path" received signal SIGSEGV, Segmentation fault.
> >       0x00005555560e4893 in qemu_file_get_error_obj (f=0x0, errp=0x0) at ../migration/qemu-file.c:154
> >       154         return f->last_error;
> >
> > CI run: https://gitlab.com/farosas/qemu/-/pipelines/1008652837
> >
> > Fabiano Rosas (7):
> >   migration: Fix possible race when setting rp_state.error
> >   migration: Fix possible races when shutting down the return path
> >   migration: Fix possible race when shutting down to_dst_file
> >   migration: Remove redundant cleanup of postcopy_qemufile_src
> >   migration: Consolidate return path closing code
> >   migration: Replace the return path retry logic
> >   migration: Move return path cleanup to main migration thread
> >
> > Peter Xu (1):
> >   migration: Fix race that dest preempt thread close too early
> >
> >  migration/migration.c    | 145 +++++++++++++++------------------------
> >  migration/migration.h    |  14 +++-
> >  migration/postcopy-ram.c |  38 +++++++++-
> >  3 files changed, 106 insertions(+), 91 deletions(-)
> 
> Ping

Stefan,

This is the series I mentioned to you before that will solve all known
migration-test intermittent failures.  It covers two bugs we're aware of.

I've already provided all R-bs on the patches.

Feel free to merge this series if you want even before Juan's back.

Thanks!

-- 
Peter Xu


