Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B9F726346
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:49:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6uSj-0007zM-Hk; Wed, 07 Jun 2023 10:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6uSf-0007z6-JL
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:48:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6uSd-0008Gn-VM
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686149310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+OttcQp0YCvLLpu41ZnVKya0ArdmDMHp4WLIrPdtTK8=;
 b=H+e3cjF4oILjEOELnukXcNQfoTCBKS2Dw8of2awvpSHDDkB0zYjErNIYgKSs240L8jVNr3
 crG3qGya55MK0UzR6M43gWmkb1pbTRYEtl1w0YT7sQx/wBaVUQfl0eVjgMshoimySr0U0n
 AOb9r5orf3fwmjIP79qJLR6Y19vttJs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-K6ot5ViuNMGbdtDB-AsmIA-1; Wed, 07 Jun 2023 10:48:29 -0400
X-MC-Unique: K6ot5ViuNMGbdtDB-AsmIA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-62b67ff6943so3373086d6.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 07:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686149309; x=1688741309;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+OttcQp0YCvLLpu41ZnVKya0ArdmDMHp4WLIrPdtTK8=;
 b=GZ64cqevKKzQ9eCEYYsHuXjwxsk7PkJkGnZEXYJ3X93IFrMQb0y7J+397Xi5M+aBFK
 lCRNn6kGNrMs5cvGPbyyAtbdw+7zGMd1Yq1umQBJheg4LCHHz93GSlnKDR8afrNwodVe
 evgdDArozibctNqCsB8EvexqzfhM2rjO0fsG6dtAHUjZ5fOpr9hpbiRfGv/T0rJ6tdJI
 az7exdHuFvcJRNaoW2cWfLeCaYnZVft06KIXCOlLRL6yurPqLW14kuOFlxjAKhTg8N4P
 jHheoKMXEkWLf0goniC9KBiBP+YiRsByUqVg3fL/LzETy1+Wux0uKen4UrzqySiskRa2
 lxtg==
X-Gm-Message-State: AC+VfDxPI0SfrBcct3Af0J58SS7Kdh2wA3WSb4RH9krIzuS7YPX9gjRr
 u5BQ24pLdD+9In060dW3NovH6qUkSnrrGzylN+NDu0DYSw+WOKqSkRH5qV1K80/S1gwMdwu7miU
 LbllRj1Izv6OC4ns=
X-Received: by 2002:a05:6214:518c:b0:625:aa49:c182 with SMTP id
 kl12-20020a056214518c00b00625aa49c182mr6223022qvb.6.1686149309057; 
 Wed, 07 Jun 2023 07:48:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4pjSUw8JTi1d2alGS7UNI3O58S/7xV/2YapS9+0LFGLcvrKbKdSConpNfBM/teM2FsRsp2/w==
X-Received: by 2002:a05:6214:518c:b0:625:aa49:c182 with SMTP id
 kl12-20020a056214518c00b00625aa49c182mr6223004qvb.6.1686149308793; 
 Wed, 07 Jun 2023 07:48:28 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 bz5-20020ad44c05000000b005f227de6b1bsm6118640qvb.116.2023.06.07.07.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 07:48:28 -0700 (PDT)
Date: Wed, 7 Jun 2023 10:48:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philippe.mathieu.daude@gmail.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH V2] memory: RAM_NAMED_FILE flag
Message-ID: <ZICYulJ0iuSkd6Bs@x1n>
References: <1675796613-235716-1-git-send-email-steven.sistare@oracle.com>
 <Y+KzMDdc+F9zHMh2@x1n>
 <25b316ac-18da-cd63-fd36-472db6ae9b51@oracle.com>
 <Y+P2k6iDQc0x0xtT@x1n>
 <331c7f30-a68c-2253-5bb4-f67935e1bca5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <331c7f30-a68c-2253-5bb4-f67935e1bca5@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jun 07, 2023 at 10:05:11AM -0400, Steven Sistare wrote:
> On 2/8/2023 2:22 PM, Peter Xu wrote:
> > On Wed, Feb 08, 2023 at 01:34:18PM -0500, Steven Sistare wrote:
> >> On 2/7/2023 3:23 PM, Peter Xu wrote:
> >>> On Tue, Feb 07, 2023 at 11:03:33AM -0800, Steve Sistare wrote:
> >>>> migrate_ignore_shared() is an optimization that avoids copying memory
> >>>> that is visible and can be mapped on the target.  However, a
> >>>> memory-backend-ram or a memory-backend-memfd block with the RAM_SHARED
> >>>> flag set is not migrated when migrate_ignore_shared() is true.  This is
> >>>> wrong, because the block has no named backing store, and its contents will
> >>>> be lost.  To fix, ignore shared memory iff it is a named file.  Define a
> >>>> new flag RAM_NAMED_FILE to distinguish this case.
> >>>
> >>> There's also TYPE_MEMORY_BACKEND_EPC.  Reading the commit message it seems
> >>> it can still be used in similar ways.  Pasting commit message from c6c0232:
> >>>
> >>>     Because of its unique requirements, Linux manages EPC separately from
> >>>     normal memory.  Similar to memfd, the device /dev/sgx_vepc can be
> >>>     opened to obtain a file descriptor which can in turn be used to mmap()
> >>>     EPC memory.
> >>>
> >>> I'm not sure whether it means that should apply for RAM_NAMED_FILE too,
> >>> neither do I think it's super important..  Still better to define it
> >>> properly.
> >>
> >> The RAM_NAMED_FILE flag will be false for TYPE_MEMORY_BACKEND_EPC, so 
> >> ramblock_is_ignored will return false, and the contents will be copied
> >> over the socket to the target, and the segment will be recreated there.
> >>
> >> However, perhaps I do not understand your point.
> > 
> > My point was it looked like it should apply RAM_NAMED_FILE too, because
> > it's also a named file.
> > 
> > But..  I don't think another QEMU can share the same data if opening the
> > same file.  Based on my zero knowledge on it... I quickly looked up
> > sgx_vepc_open() in the Linux impl where sgx_vepc.page_array plays a role of
> > page cache iiuc, while it's private per vma even if VM_SHARED.
> > 
> > So please ignore my comment..
> > 
> >>
> >>> Another comment is, AFAIK this patch will modify senamtics of the old
> >>> capability "x-ignore-shared".  But I'd say in a sensible way.  Maybe worth
> >>> directly modify qapi/migration.json to reflect it (especially it's x-
> >>> prefixed) to something like:
> >>>
> >>> # @x-ignore-shared: If enabled, QEMU will not migrate named shared memory
> >>> #                   (since 4.0) 
> >>
> >> Good idea.  I propose:
> >>
> >> # @x-ignore-shared: If enabled, QEMU will not migrate shared memory that is
> >> #                   accessible on the target. (since 4.0)
> > 
> > I would use s/target/destination host/ because target can be misread as the
> > VM itself (at least a general term in migration code base).  Other than
> > that looks good to me.
> 
> Hi Peter, I will rebase to the tip, modify the wording, and repost.  
> Can I add your RB?

Yes. thanks,

-- 
Peter Xu


