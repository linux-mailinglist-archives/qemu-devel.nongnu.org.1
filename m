Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D2977D56D
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 23:59:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW240-0007E6-In; Tue, 15 Aug 2023 17:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW23y-0007Di-Iv
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 17:58:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW23w-0002xD-Aq
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 17:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692136731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AaEIKg+0CQQSGCwUed5mJiWytEDxi81ig685OJvxh2g=;
 b=fdn4iLSjB4LsglC2FhCOwJY5wcb+159zLEPS+38HqY46CDEAVqdLSj26jvtXcBPcEmMwBy
 kKbaF1cqi4mCn1WnKf87AN2YLW6G3weeXoQpe3H+kzcp8jQuKYrs30m7+GH3sS8NpT56F/
 i2DjtgmXJxgakMPk0XNw0Xjcm6ulAV0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-6m8oUiBbN4-nnHX-gc8jmA-1; Tue, 15 Aug 2023 17:58:49 -0400
X-MC-Unique: 6m8oUiBbN4-nnHX-gc8jmA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-642efbdc73fso12276746d6.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 14:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692136729; x=1692741529;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AaEIKg+0CQQSGCwUed5mJiWytEDxi81ig685OJvxh2g=;
 b=bGftFnIYd/F4E9rOKqG2RXk5pNuLcC4/4SF+3Yy2Qev1+mCasxZpGMS3q1YyWa0IjQ
 k/ejNI0OaMLkNdy5DzbPwA7V2/MSgFGP77cKjdUWMdJZzJRb6JfcasUFp1dHlVKWjHb9
 y6VKhSsDw3MbQQCJX6avnAhJSAXacvSYewZ8/AwWwNi44APTkKmaVdd1NAmw7ctgXmIu
 q3ksuiBBwmG0NByUF17BFORS8UUq+VHK8jBS2DvMEgAy655P4UTv3oIv5hiVvSfveWg6
 zGFlHGONZSO4bQ/cJPtGC7AHm4YKVz1Sd4CQphnmUJulW+OQ1Rgxc/i/n6LuUklomu6+
 Xb/Q==
X-Gm-Message-State: AOJu0YyHxNkePHP4Jq2oyNUwecyYuWikFIi0v1xsKEKaa3lCUt7yXT3F
 ZQo/UVXoNYlXo4JRb6viS5USmFzERZJqRKzUfQJJhrRItWIG7HDM30jFIC/YH1YLDqyN/kf6l3I
 djzFMu3V90Bhw3IE=
X-Received: by 2002:ad4:5745:0:b0:63d:1861:29d2 with SMTP id
 q5-20020ad45745000000b0063d186129d2mr15207qvx.4.1692136728778; 
 Tue, 15 Aug 2023 14:58:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFukNasRhQIOf/c1HtU2yyoVIGSALAyVfMjaZM19DvBzV33ffyvP2sjELBXjMRllDXCNwAtng==
X-Received: by 2002:ad4:5745:0:b0:63d:1861:29d2 with SMTP id
 q5-20020ad45745000000b0063d186129d2mr15195qvx.4.1692136728461; 
 Tue, 15 Aug 2023 14:58:48 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 d18-20020a0cb2d2000000b0064724376066sm1602356qvf.133.2023.08.15.14.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 14:58:48 -0700 (PDT)
Date: Tue, 15 Aug 2023 17:58:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v3 07/10] migration: Replace the return path retry logic
Message-ID: <ZNv1Fi2a6n+TXC3o@x1n>
References: <20230811150836.2895-1-farosas@suse.de>
 <20230811150836.2895-8-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230811150836.2895-8-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.04,
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

On Fri, Aug 11, 2023 at 12:08:33PM -0300, Fabiano Rosas wrote:
> Replace the return path retry logic with finishing and restarting the
> thread. This fixes a race when resuming the migration that leads to a
> segfault.
> 
> Currently when doing postcopy we consider that an IO error on the
> return path file could be due to a network intermittency. We then keep
> the thread alive but have it do cleanup of the 'from_dst_file' and
> wait on the 'postcopy_pause_rp' semaphore. When the user issues a
> migrate resume, a new return path is opened and the thread is allowed
> to continue.
> 
> There's a race condition in the above mechanism. It is possible for
> the new return path file to be setup *before* the cleanup code in the
> return path thread has had a chance to run, leading to the *new* file
> being closed and the pointer set to NULL. When the thread is released
> after the resume, it tries to dereference 'from_dst_file' and crashes:
> 
> Thread 7 "return path" received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x7fffd1dbf700 (LWP 9611)]
> 0x00005555560e4893 in qemu_file_get_error_obj (f=0x0, errp=0x0) at ../migration/qemu-file.c:154
> 154         return f->last_error;
> 
> (gdb) bt
>  #0  0x00005555560e4893 in qemu_file_get_error_obj (f=0x0, errp=0x0) at ../migration/qemu-file.c:154
>  #1  0x00005555560e4983 in qemu_file_get_error (f=0x0) at ../migration/qemu-file.c:206
>  #2  0x0000555555b9a1df in source_return_path_thread (opaque=0x555556e06000) at ../migration/migration.c:1876
>  #3  0x000055555602e14f in qemu_thread_start (args=0x55555782e780) at ../util/qemu-thread-posix.c:541
>  #4  0x00007ffff38d76ea in start_thread (arg=0x7fffd1dbf700) at pthread_create.c:477
>  #5  0x00007ffff35efa6f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
> 
> Here's the race (important bit is open_return_path happening before
> migration_release_dst_files):
> 
> migration                 | qmp                         | return path
> --------------------------+-----------------------------+---------------------------------
> 			    qmp_migrate_pause()
> 			     shutdown(ms->to_dst_file)
> 			      f->last_error = -EIO
> migrate_detect_error()
>  postcopy_pause()
>   set_state(PAUSED)
>   wait(postcopy_pause_sem)
> 			    qmp_migrate(resume)
> 			    migrate_fd_connect()
> 			     resume = state == PAUSED
> 			     open_return_path <-- TOO SOON!
> 			     set_state(RECOVER)
> 			     post(postcopy_pause_sem)
> 							(incoming closes to_src_file)
> 							res = qemu_file_get_error(rp)
> 							migration_release_dst_files()
> 							ms->rp_state.from_dst_file = NULL
>   post(postcopy_pause_rp_sem)
> 							postcopy_pause_return_path_thread()
> 							  wait(postcopy_pause_rp_sem)
> 							rp = ms->rp_state.from_dst_file
> 							goto retry
> 							qemu_file_get_error(rp)
> 							SIGSEGV
> -------------------------------------------------------------------------------------------
> 
> We can keep the retry logic without having the thread alive and
> waiting. The only piece of data used by it is the 'from_dst_file' and
> it is only allowed to proceed after a migrate resume is issued and the
> semaphore released at migrate_fd_connect().
> 
> Move the retry logic to outside the thread by waiting for the thread
> to finish before pausing the migration.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


