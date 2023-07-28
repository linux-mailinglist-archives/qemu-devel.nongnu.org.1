Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF319767865
	for <lists+qemu-devel@lfdr.de>; Sat, 29 Jul 2023 00:14:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPV9r-00005t-4T; Fri, 28 Jul 2023 17:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qPV9p-00005V-9W
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 17:37:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qPV9n-0006UQ-R3
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 17:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690580274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b5t2zmIDsu28RKNXD2LZZmIihAz2BehwW/CWrKvVzVA=;
 b=R9bHZGcIl0khrF3BgptdrFgcw7a5egwVWX1IFSRrP9qg9Qg9HKHTYCiYvdCzisQWQybdg+
 TFGEsPgBUFdslh94WNyFNOuUVwoLNjuZZMndEVv872U6gbKUeKMnzA8M9UWk8EVzhRwQVE
 FjwnOZKI476rybJpyOsjzT6C6HIl7h0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-uPWOERrMPpOF1qJbSaKBkw-1; Fri, 28 Jul 2023 17:37:52 -0400
X-MC-Unique: uPWOERrMPpOF1qJbSaKBkw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-63cebe9238bso5165176d6.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 14:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690580272; x=1691185072;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5t2zmIDsu28RKNXD2LZZmIihAz2BehwW/CWrKvVzVA=;
 b=j+EK5miWFrC5cr3aRtZfFGRDIp7EH0+ukTMYwYUydIwh/N/ky1pDsD6Pn/SNOXXxla
 FuOaKdms6/UpA/As//G263yz26Dm/huiN+h9f4CG3D2QC+FFoTU0+mKKvDyH7XiTgl97
 Q1BgjPwKQNQJPbe64QmTEugohd3hxGDtQilT5PmIKmYF62mOaq17XwopYic61LBQNIm6
 ciUAVQvol5hqKTwPnQX7UafjMUymvQjyrmF4C/EnIEs4n6S1hbk4t/CQMPC9E+lyMpi1
 0uMenSNpog7zOmMnsnGgmudS0MM8QWgzMVFaKwfIFN7HRRDb4r7YMjPmCFttgSdVaKuL
 xdfQ==
X-Gm-Message-State: ABy/qLaPuYyofXol4TEd8h0KAuzFwpQPXFPVOEzquTBzDpn3r6PLwyCs
 e6hLnw6q/QeghhVC/BjKbSgSC7+GReGmea5ju8gCwe6ZI517hYADbFJCGQJvSXjba0FYAlXx1B/
 FDwKXUnPqhGumDjE=
X-Received: by 2002:a05:6214:5090:b0:63d:ee8:4127 with SMTP id
 kk16-20020a056214509000b0063d0ee84127mr536720qvb.2.1690580271972; 
 Fri, 28 Jul 2023 14:37:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF2We8K5GRzxb+1BLE3l8Q0cpZ2f6mjH4nux8eMAMLZYuWT0SpTuN0csBXe+rAQ0xqTpj7b+Q==
X-Received: by 2002:a05:6214:5090:b0:63d:ee8:4127 with SMTP id
 kk16-20020a056214509000b0063d0ee84127mr536707qvb.2.1690580271736; 
 Fri, 28 Jul 2023 14:37:51 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 a11-20020a0ce34b000000b006365a41c354sm1546589qvm.132.2023.07.28.14.37.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 14:37:51 -0700 (PDT)
Date: Fri, 28 Jul 2023 17:37:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 1/3] migration: Stop marking RP bad after shutdown
Message-ID: <ZMQ1LbTl5kGmAG21@x1n>
References: <20230728121516.16258-1-farosas@suse.de>
 <20230728121516.16258-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230728121516.16258-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Jul 28, 2023 at 09:15:14AM -0300, Fabiano Rosas wrote:
> When waiting for the return path (RP) thread to finish, there is
> really nothing wrong in the RP if the destination end of the migration
> stops responding, leaving it stuck.
> 
> Stop returning an error at that point and leave it to other parts of
> the code to catch. One such part is the very next routine run by
> migration_completion() which checks 'to_dst_file' for an error and fails
> the migration. Another is the RP thread itself when the recvmsg()
> returns an error.
> 
> With this we stop marking RP bad from outside of the thread and can
> reuse await_return_path_close_on_source() in the next patches to wait
> on the thread during a paused migration.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 91bba630a8..051067f8c5 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2049,7 +2049,6 @@ static int await_return_path_close_on_source(MigrationState *ms)
>           * waiting for the destination.
>           */
>          qemu_file_shutdown(ms->rp_state.from_dst_file);
> -        mark_source_rp_bad(ms);
>      }
>      trace_await_return_path_close_on_source_joining();
>      qemu_thread_join(&ms->rp_state.rp_thread);

The retval of await_return_path_close_on_source() relies on
ms->rp_state.error.  If mark_source_rp_bad() is dropped, is it possible
that it'll start to return succeed where it used to return failure?

Maybe not a big deal: I see migration_completion() also has another
qemu_file_get_error() later to catch errors, but I don't know how solid
that is.

I think as long as after this patch we can fail properly on e.g. network
failures for precopy when cap return-path=on, then we should be good.

-- 
Peter Xu


