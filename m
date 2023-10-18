Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BC97CDFF1
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:34:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7be-0007xx-Iq; Wed, 18 Oct 2023 10:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt7bd-0007xm-2l
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:33:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt7ba-0008Ka-Oz
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697639580;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=xrCnGMChRNfdQfFSuRZ/yFuBtLxtuc83ebW6lFTfXTE=;
 b=YVU2gTSlhf8pxHvWRdi0G/OOU/U4W9DIZVgEUyBhhuh5OCQwlumyzwTyGbUeU5/kFsvZQK
 CfDS8k521ybcBUDMCCfURc1DLdXdmo9v0N+lP5vMJE1iNL8zSVZg9zO7hhKvCx1vA6QaOo
 YTN63d4K91HD5NwAPlChXJvmLsC+5n0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-0fv6QZYdMn-uzH6vWjDcFQ-1; Wed, 18 Oct 2023 10:32:48 -0400
X-MC-Unique: 0fv6QZYdMn-uzH6vWjDcFQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4083a670d25so6198595e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 07:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697639566; x=1698244366;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xrCnGMChRNfdQfFSuRZ/yFuBtLxtuc83ebW6lFTfXTE=;
 b=Ynrlr8d3+TJcmwOLJFqojrMqHBT/VzgA/u6qasyR7wSG96W7lBVr+u99ZXNdb9Zh3c
 Sdd1m2GRLHj2+HjbeUjTqz8WcJQIcpvdrLAIv3+HVHkF60xYoiaZEtQBRZ71ng3SVLCH
 reU2dy8v+dDktnCzRsBcZ0NTf+OyaK4SpFKYYGZOKDx4hh5yT2HxgfmD0b+u+dA/BULs
 yHnE+WyXyjgW3XNX/dTHAbT9SVUhnoM0Z3jrkHiBeBFs9EuPgsb/K2KiumL9GTHKdVq8
 z12JyWglcbPKhEm2tlLNf5iDz8kBzW7c1uDBWFfr/lf/QZzRvNs+6HokpqC3VSy8066A
 O8Dg==
X-Gm-Message-State: AOJu0YzkUr5Va9nmPN/Ot0tNrGnR/VP5iTK3VFjVQo0X5dEbC+g2lI56
 55vBYUPfqKe2CvHoI7iYBWwji72HD5hmtsERSnPrJLqsQ57/D+toadpEI4GIGvcvz/aV4NAHUHw
 lGkHoydBrffuaqhA=
X-Received: by 2002:a05:600c:5492:b0:408:3ab3:a029 with SMTP id
 iv18-20020a05600c549200b004083ab3a029mr1943687wmb.38.1697639566657; 
 Wed, 18 Oct 2023 07:32:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg4DLSgizE6Vptu4yuRqhRJksjg4vAdG4e1x4C+l3D9tcIcSXgCB2iT8N/nBlMY7jNRR/D+w==
X-Received: by 2002:a05:600c:5492:b0:408:3ab3:a029 with SMTP id
 iv18-20020a05600c549200b004083ab3a029mr1943663wmb.38.1697639566234; 
 Wed, 18 Oct 2023 07:32:46 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 k6-20020a05600c1c8600b003fe1c332810sm1809112wms.33.2023.10.18.07.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 07:32:45 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Li Zhijian <lizhijian@fujitsu.com>,  leobras@redhat.com,
 qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 1/2] migration: Fix rdma migration failed
In-Reply-To: <ZSAtKmOFkomgXyJ7@x1n> (Peter Xu's message of "Fri, 6 Oct 2023
 11:52:10 -0400")
References: <20230926100103.201564-1-lizhijian@fujitsu.com>
 <87edib5ybg.fsf@secure.mitica> <ZSAtKmOFkomgXyJ7@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 18 Oct 2023 16:32:45 +0200
Message-ID: <87a5sg80he.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


I see in upstream already:

(master)$ g branch --show-current 
master
(master)$ g branch --contains d4f34485ca8a077c98fc2303451e9bece9200dd7
* master
(master)$ 


commit d4f34485ca8a077c98fc2303451e9bece9200dd7
Author: Juan Quintela <quintela@redhat.com>
Date:   Wed Oct 11 22:55:48 2023 +0200

    migration: Non multifd migration don't care about multifd flushes
    
    RDMA was having trouble because
    migrate_multifd_flush_after_each_section() can only be true or false,
    but we don't want to send any flush when we are not in multifd
    migration.
    
    CC: Fabiano Rosas <farosas@suse.de
    Fixes: 294e5a4034e81 ("multifd: Only flush once each full round of memory")
    
    Reported-by: Li Zhijian <lizhijian@fujitsu.com>
    Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
    Reviewed-by: Peter Xu <peterx@redhat.com>
    Signed-off-by: Juan Quintela <quintela@redhat.com>
    Message-ID: <20231011205548.10571-2-quintela@redhat.com>

Or I am missing something?

Later, Juan.


