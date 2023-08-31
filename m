Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CD378F2B9
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 20:35:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbmUw-0004PU-N9; Thu, 31 Aug 2023 14:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qbmUg-0004Nd-TB
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 14:34:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qbmUd-0000lq-8Z
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 14:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693506846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PKtgOjaCmJ5QnQ5q0SNdvtVlaFG6qMBq+6fdh+G+BWE=;
 b=iawDBuTSsYMYrm4TqRPs0sDv0afBgUQVJ6jbFDbc7nfAU1625Vy2mOTWoeup3AGoRsa563
 WtyNe5Kaqmn8ZrdqifvxlLbM5d2mLk+3YsxjOKk/5Tb4OAsNCmzUMUuWsccDXovUX8G3mJ
 wSVtqfrNyVVnH/MaXTgalWabw5Q4yPw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-ANPc03K7OMSTMLgw3Pe74w-1; Thu, 31 Aug 2023 14:34:04 -0400
X-MC-Unique: ANPc03K7OMSTMLgw3Pe74w-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-65161011acfso1790196d6.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 11:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693506844; x=1694111644;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PKtgOjaCmJ5QnQ5q0SNdvtVlaFG6qMBq+6fdh+G+BWE=;
 b=dEoTzPIrKtrXRu5jw2AA1apBfHCFSvCcGvHBQHOOsOnCk/OWOgmsV4u82Qai7vzGAG
 45dMM0kzX/UiC2KTkSnwRdEfnCHTOCWfp0WXWEjl5B74vs5zxu5XeMuFO+irGHa4j8+t
 mmm+4jVuKYhNkRcm3hJd7M1WsJFxJ3MBTQ/iE943UoxScQWlivS4yPB3MiTSGVCZko1h
 BPLeY6/i7wYFFVVLHN2DV7xiIBz+iYRAxrxYe5XhcI8a66v88v3bIP29M5DlBx5w9plK
 8QvKeuNTbmFUZblA6eweMjkZZaX9n9NDE2rffk8unqxCQNLCZtJ9oeiB/j6slrx6t5UP
 wGQA==
X-Gm-Message-State: AOJu0YwB+QjhYhmn1azfc3MRNYo4fUfpG+RHPL1bj2ypfQmuOdI1kXJZ
 1rLpC4r2m2wEi/Tc1M7+nme6rGJvU6mX2TR5YHnCU0hySASlSC+j3A8z2+0uI/0rTP5ONVN6xWt
 WLKaFFuaaRSlpHcE=
X-Received: by 2002:ad4:5c41:0:b0:635:da19:a67f with SMTP id
 a1-20020ad45c41000000b00635da19a67fmr26749qva.1.1693506843921; 
 Thu, 31 Aug 2023 11:34:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1n+2Tlw72Sfg5vmo/fS8BjUOy3nKJYtBFsspytLE0qg4iIsI2DLUt1ofpyHWmrerfPz2mWQ==
X-Received: by 2002:ad4:5c41:0:b0:635:da19:a67f with SMTP id
 a1-20020ad45c41000000b00635da19a67fmr26734qva.1.1693506843703; 
 Thu, 31 Aug 2023 11:34:03 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 o3-20020a0ce403000000b0063fbfbde4adsm794701qvl.129.2023.08.31.11.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 11:34:03 -0700 (PDT)
Date: Thu, 31 Aug 2023 14:34:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: qemu-devel@nongnu.org, Zhiyi Guo <zhguo@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>,
 Chensheng Dong <chdong@redhat.com>
Subject: Re: [PATCH for-8.2 v2 2/2] migration: Allow user to specify
 migration switchover bandwidth
Message-ID: <ZPDdGg1bAYcvd62n@x1n>
References: <20230803155344.11450-1-peterx@redhat.com>
 <20230803155344.11450-3-peterx@redhat.com>
 <29067b18-c7af-745a-283e-62f3a2442980@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <29067b18-c7af-745a-283e-62f3a2442980@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Aug 31, 2023 at 07:14:47PM +0100, Joao Martins wrote:
> On 03/08/2023 16:53, Peter Xu wrote:
> > @@ -2719,7 +2729,8 @@ static void migration_update_counters(MigrationState *s,
> >      update_iteration_initial_status(s);
> >  
> >      trace_migrate_transferred(transferred, time_spent,
> > -                              bandwidth, s->threshold_size);
> > +                              bandwidth, migrate_max_switchover_bandwidth(),
> > +                              s->threshold_size);
> >  }
> 
> (...)
> 
> > diff --git a/migration/trace-events b/migration/trace-events
> > index 4666f19325..1296b8db5b 100644
> > --- a/migration/trace-events
> > +++ b/migration/trace-events
> > @@ -185,7 +185,7 @@ source_return_path_thread_shut(uint32_t val) "0x%x"
> >  source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
> >  source_return_path_thread_switchover_acked(void) ""
> >  migration_thread_low_pending(uint64_t pending) "%" PRIu64
> > -migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t bandwidth, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " max_size %" PRId64
> > +migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t bandwidth, uint64_t avail_bw, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " avail_bw %" PRIu64 " max_size %" PRId64
> 
> Given your previous snippet, perhaps you meant to introduce
> 'max_switchover_bandwidth' arg, unless of course you meant in the callpath of
> the tracepoint to instead use @avail_bw as the variable to use?

Yeah, got it overlooked...  I'll fix that when repost, thanks.

-- 
Peter Xu


