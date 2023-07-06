Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B63CE74A3E0
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 20:40:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHTtz-0000zc-JD; Thu, 06 Jul 2023 14:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHTtw-0000z0-1g
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:40:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHTtu-00060B-BM
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688668821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EwcoR630wLPnHTr9do7leqZ5u1Nkv2fmUl67i+Q0QW4=;
 b=ExC3fqRl/uQgw0zAiQh4RYzclLeesGaQc342fA2BIOyMwqklrE26sppjnSUiYbW2WY9yRq
 GU/GWy7wHmWOs/uTAUcn+0yFMmI5UeZo4vOHXJZ8EAmA0pixj0dKnKNtndUxOVxKdG0AEm
 L91y+pV85vJ0E1sWNO/Kpq3+CppzQkM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-BTRWRAVSOIeUTSZSsFKhqQ-1; Thu, 06 Jul 2023 14:40:20 -0400
X-MC-Unique: BTRWRAVSOIeUTSZSsFKhqQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-635eb5b04e1so2548026d6.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 11:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688668819; x=1689273619;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EwcoR630wLPnHTr9do7leqZ5u1Nkv2fmUl67i+Q0QW4=;
 b=XV1dBCBjB/iLca7PkKVdsuBdGRm0XIitRZ36VVr1u+pFBEwdgRlx0Q6vzPuNq/XY8q
 sbxWsZX5VFBgvE29NcFn2ZfhO0WE+2vHuzf07TMUmwtD+Shg/1w06fqDsBHAn7JfDpyr
 5z1pgj1znq2VeQAgFyRde576hNZpY80XOxbiTMisxtF625yCHZrzbRHZl1EWR7wnYkPw
 iaj2aZ/D8VCj2VPfoDdLXoj+X8LDqX1Qqz8rpmXIxp0hR+/2CHt8jWgGyZPcgfKzn77O
 e61E+wgAY/ocWR5GkiEII8lqOQB1gPnnwF096lT9lZpDbbqQxKkaR0rM7T2ywoK/TYr4
 +F2Q==
X-Gm-Message-State: ABy/qLYUiK53gcsz6ebtslOkLwqFoReXm6hZGxna3vpWaCKx3rO9VxLS
 liuB0RBz7Ra6TG+ZAdPFdfonZpBGsZfOiOVdvj6fJKAQp6ugrMRme8QPiF/EbgcQS0L2Y9oZptn
 VAP8f5OXmcikzTT8=
X-Received: by 2002:ad4:4eee:0:b0:635:da19:a680 with SMTP id
 dv14-20020ad44eee000000b00635da19a680mr2921286qvb.2.1688668819566; 
 Thu, 06 Jul 2023 11:40:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH+Cfyx7Q4szf+1jr1/RvT+dDr56tfZgR1oKfql8i3TeD59KfJPQ2XFV5no7hrZNe9umjcPRA==
X-Received: by 2002:ad4:4eee:0:b0:635:da19:a680 with SMTP id
 dv14-20020ad44eee000000b00635da19a680mr2921273qvb.2.1688668819280; 
 Thu, 06 Jul 2023 11:40:19 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 n8-20020a0c9d48000000b00631eaf8b9e5sm1153438qvf.138.2023.07.06.11.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 11:40:19 -0700 (PDT)
Date: Thu, 6 Jul 2023 14:40:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v3 4/6] migration: Set migration status early in incoming
 side
Message-ID: <ZKcKkZ6uSqQnYBqe@x1n>
References: <20230630212902.19925-1-farosas@suse.de>
 <20230630212902.19925-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230630212902.19925-5-farosas@suse.de>
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

On Fri, Jun 30, 2023 at 06:29:00PM -0300, Fabiano Rosas wrote:
> We are sending a migration event of MIGRATION_STATUS_SETUP at
> qemu_start_incoming_migration but never actually setting the state.
> 
> This creates a window between qmp_migrate_incoming and
> process_incoming_migration_co where the migration status is still
> MIGRATION_STATUS_NONE. Calling query-migrate during this time will
> return an empty response even though the incoming migration command
> has already been issued.
> 
> Commit 7cf1fe6d68 ("migration: Add migration events on target side")
> has added support to the 'events' capability to the incoming part of
> migration, but chose to send the SETUP event without setting the
> state. I'm assuming this was a mistake.
> 
> This introduces a change in behavior, any QMP client waiting for the
> SETUP event will hang, unless it has previously enabled the 'events'
> capability. Having the capability enabled is sufficient to continue to
> receive the event.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


