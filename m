Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 235A07DD80F
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 23:11:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxwwv-0002uR-HU; Tue, 31 Oct 2023 18:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxwwt-0002tf-NW
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 18:10:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxwws-0006X1-28
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 18:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698790256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yOAQpi0Xo+IJj4YP835LYQfY6t1F6OkFrk+ewlJ71M4=;
 b=N8gdwKDc+5KjZqxclWaYxuFimXFVV0gY2XW5PcWoqTwKxukuKqQdJtvSfPCiNCjhoEtoF4
 QTgxnGKHegCWZf87dKS6Dxljd3UIa+JcclfLls3JyQyU4iX1hteyp3L0zhzZKf9iiBSbD6
 /P27NQBxcBIVXpLIXcZjhXJnqbERRJ8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-6E_ayk3fMpm-vHEY8H5gfA-1; Tue, 31 Oct 2023 18:10:53 -0400
X-MC-Unique: 6E_ayk3fMpm-vHEY8H5gfA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6716c2696c7so12578226d6.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 15:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698790253; x=1699395053;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yOAQpi0Xo+IJj4YP835LYQfY6t1F6OkFrk+ewlJ71M4=;
 b=Q/FR/UWfJxUWzak8uJdS8V7l1yjPQBUO7d8nhmHCyqqyL1FTvxMY39OhL3EZZVKJwu
 DKAyXCX5l8kH4ALdNOAzoxIDC5U6EwihUzTWMIONk0A2D9s2rftQ6xu46kZ8dfm7Btcr
 wzqMZ5IHutjjmg8QIw0FO/mhJxhEJHTwSgzuYpTICiZcREUfSqJLlhYOMEYMUAtZFtDI
 gFQC94bueWJx9MY0xspoxVG6LtBAgpEqg+M4YSroUK9vMPX/uYhbITTP+24Q9n5KWQ3y
 O+RZDTZ0Yh+NSOrea4OxlFHHd/hDcYynqoOcYvNx1FDjD4SUHZ4KTjCs4uxoAE7LmsOl
 sTrQ==
X-Gm-Message-State: AOJu0Yz/ptASncIkTtdMACxc1xh8E7QC1LZZx8cv81YrjfMZCzvuWyjd
 rGq/qPhcnu7LoPCFzCo/0MFmr2ApYtYs5Y0MUIHuMnV1eYdcvPlyggRBmMGecVJNjfJ+Mq56Cfk
 QV1/Ha1fBt1rWNVM=
X-Received: by 2002:a05:6214:9a5:b0:670:9c0b:d82 with SMTP id
 du5-20020a05621409a500b006709c0b0d82mr10948936qvb.2.1698790252724; 
 Tue, 31 Oct 2023 15:10:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwOMk7XAV90vngcqytcnsJL6e4tTUbtiq8xL/6PHjOsnTE5N52uwN4Gdw+QFjGo+CT2FlG0w==
X-Received: by 2002:a05:6214:9a5:b0:670:9c0b:d82 with SMTP id
 du5-20020a05621409a500b006709c0b0d82mr10948927qvb.2.1698790252471; 
 Tue, 31 Oct 2023 15:10:52 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 db12-20020a056214170c00b0066d04196c39sm898601qvb.81.2023.10.31.15.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 15:10:52 -0700 (PDT)
Date: Tue, 31 Oct 2023 18:10:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v2 21/29] migration/multifd: Add pages to the receiving
 side
Message-ID: <ZUF7VG+CWvuOEbqD@x1n>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-22-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023203608.26370-22-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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

On Mon, Oct 23, 2023 at 05:36:00PM -0300, Fabiano Rosas wrote:
> Currently multifd does not need to have knowledge of pages on the
> receiving side because all the information needed is within the
> packets that come in the stream.
> 
> We're about to add support to fixed-ram migration, which cannot use
> packets because it expects the ramblock section in the migration file
> to contain only the guest pages data.
> 
> Add a pointer to MultiFDPages in the multifd_recv_state and use the
> pages similarly to what we already do on the sending side. The pages
> are used to transfer data between the ram migration code in the main
> migration thread and the multifd receiving threads.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

If it'll be new code to maintain anyway, I think we don't necessarily
always use multifd structs, right?

Rather than introducing MultiFDPages_t into recv side, can we allow pages
to be distributed in chunks of (ramblock, start_offset, end_offset) tuples?
That'll be much more efficient than per-page.  We don't need page granule
here on recv side, we want to load chunks of mem fast.

We don't even need page granule on sender side, but since only myself cared
about perf.. and obviously the plan is to even drop auto-pause, then VM can
be running there, so sender must do that per-page for now.  But now on recv
side VM must be stopped before all ram loaded, so there's no such problem.
And since we'll introduce new code anyway, IMHO we can decide how to do
that even if we want to reuse multifd.

Main thread can assign these (ramblock, start_offset, end_offset) jobs to
recv threads.  If ramblock is too small (e.g. 1M), assign it anyway to one
thread.  If ramblock is >512MB, cut it into slices and feed them to multifd
threads one by one.  All the rest can be the same.

Would that be better?  I would expect measurable loading speed difference
with much larger chunks and with that range-based tuples.

Thanks,

-- 
Peter Xu


