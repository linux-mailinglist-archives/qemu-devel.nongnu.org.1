Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4184F78D772
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 18:12:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbNn3-0006hE-Ci; Wed, 30 Aug 2023 12:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qbNn1-0006Wb-V3
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:11:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qbNmz-0002xX-PX
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693411888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LErgMzxFsW5JBoNyyLMjb3nqsH5NP/7n+dVTdPPQ+LU=;
 b=gQ98taGOVIgfwV5Bf+Wr+oYTQwiQ8fwUatv4zo4/rHB02TaSusRutpgVcS4mo98Z6Dn5Jh
 cQse1nzYJQdehHc3i8/lggcp5vgMLLm2H0h0bK9VG/lZwIFe+YNw/xElwc+nf8ONhYut7d
 JQv0OXE4w8/UAvXFRkvqhYKUGz9hk2o=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-iL6tcVyyOfKRD4qzwH9kGg-1; Wed, 30 Aug 2023 12:11:26 -0400
X-MC-Unique: iL6tcVyyOfKRD4qzwH9kGg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6515b44388fso6719006d6.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693411886; x=1694016686;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LErgMzxFsW5JBoNyyLMjb3nqsH5NP/7n+dVTdPPQ+LU=;
 b=RZbaaKOwJCZEcY8OpuORC8sj4ispvU56ckQkN8eL+nb8HQL0bB2UvUWxwkY9+CJrB0
 mbgVhzODOO9csE61bRz9MKlbpiHvOaqgWhtScwLsrwa0w2qccCIeLFqEkoZBI8XUM7h2
 ACQvj5Gc51a+o7Dlmi7hEzpShuM5UdHa4fC91nwHhHaI7Nc27r9iP8MkjT8CM3DvxPHk
 oBkfa5e/UCiuTEl3a4QP4tDnCDukwy1YEL245Sew4SGMgfwqz6giRBE1IBwM1NXi6SB0
 5Amvi1uuP3T38Mi43cD/nwdYvwvW3KqR5BN993mJo+O2I6yXzW1FIwmFFHmA2YfDm+pb
 S/tw==
X-Gm-Message-State: AOJu0YzzJNiLSs3RAMiFRTTfykhsPjxEol6e9LSPiST98bOSjvn2eXIi
 HRenO53JRC4bBc1ScD3c+zOtw2qL5YFI++/YvXplBFAKBpZQ+IRE1ffsQ/fLxGqoAH4Jxt0zyT3
 xoZBXXA5vHXbfT3Q=
X-Received: by 2002:a05:6214:487:b0:641:8d4a:1a83 with SMTP id
 pt7-20020a056214048700b006418d4a1a83mr2697357qvb.3.1693411885859; 
 Wed, 30 Aug 2023 09:11:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAdVTsauw9s2VMjYGRZV/8Z0KR9gyk0x6I6Lnveus0RBWZ0u2pZRhcKeNDe4UjLJzyfTN7bw==
X-Received: by 2002:a05:6214:487:b0:641:8d4a:1a83 with SMTP id
 pt7-20020a056214048700b006418d4a1a83mr2697331qvb.3.1693411885394; 
 Wed, 30 Aug 2023 09:11:25 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 e13-20020ad4418d000000b0064f70a860d8sm483642qvp.41.2023.08.30.09.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 09:11:25 -0700 (PDT)
Date: Wed, 30 Aug 2023 12:11:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH V4 03/11] migration: add runstate function
Message-ID: <ZO9qKxAy1LM2kU7O@x1n>
References: <1693333086-392798-1-git-send-email-steven.sistare@oracle.com>
 <1693333086-392798-4-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1693333086-392798-4-git-send-email-steven.sistare@oracle.com>
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

On Tue, Aug 29, 2023 at 11:17:58AM -0700, Steve Sistare wrote:
> Create a subroutine for preserving the runstate after migration,
> to be used in a subsequent patch.  No functional change.

There is actually a functional change when postcopy=on && colo=on, but I
don't think it's a valid use case, so maybe we should fail
migrate_caps_check perhaps when both set?  Not some immediate concern.

> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


