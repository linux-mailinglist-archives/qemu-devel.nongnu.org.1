Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B85767B85EE
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:56:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5Ac-0002yR-Sj; Wed, 04 Oct 2023 12:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo5Aa-0002v3-Km
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:56:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo5AX-0002tk-Ro
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:56:20 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-i6rWYOrTNou21sCTU8U7hA-1; Wed, 04 Oct 2023 12:56:15 -0400
X-MC-Unique: i6rWYOrTNou21sCTU8U7hA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40524bc3c5cso203765e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 09:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696438574; x=1697043374;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SWzNdUhw7/H0LNd6VW2uqhmuGir3fv28M9ujxCLPGOI=;
 b=SMxunpkAesx6rAwS0Je1ZeKAqsFrXAssZlqSf+sZxs+Gi4VWyqowTkBUd1h3lqR6n6
 8kYFueS5Ra9KByNsQmL6OR4AKBkiioZc4rc3JsvP6rnpzfmPJYdfMSeyyZMeqQ4F23WI
 umGP52x+HWJWu3UxvlyN5KUs2c0x4gtX5/5kyOYI78rgErtFthi4S3XGqXqgH/McPxhW
 EIoMjZgqTJaYmoklxxi4Yzz4VA+jVoAPWeeTVgu6t43Tx3PpGd9bvlNarSA1pOsBm7G8
 fOwEnzXKb9THGlHw9yrWiFJAU4USIRnBLplkoK68kNXynCweRefOUMizBNUeLt2Wlkn8
 D1mQ==
X-Gm-Message-State: AOJu0YxX87GtBzaPzgp4JMK/TXh7B74PQDymNQqNGvb2h1f2gzsrfpFx
 /ocNJXHGLh4Y6OY91yNhW4V9ZsMa4j1mZcGWkzX928M1GHjGlikISIIEt2P9YM7CZMyHFdDhif4
 arveaDf28kmlkbfU=
X-Received: by 2002:a05:600c:2804:b0:406:44e6:cfd1 with SMTP id
 m4-20020a05600c280400b0040644e6cfd1mr2365485wmb.3.1696438574013; 
 Wed, 04 Oct 2023 09:56:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEszljJEqRluIWB9K6J9CjPWZVbMwWKw0WktmowabRMJRXAe/nGiU7bRM4d1mTGFiAWeJxIJQ==
X-Received: by 2002:a05:600c:2804:b0:406:44e6:cfd1 with SMTP id
 m4-20020a05600c280400b0040644e6cfd1mr2365472wmb.3.1696438573670; 
 Wed, 04 Oct 2023 09:56:13 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 m7-20020a05600c280700b00405391f485fsm1938850wmb.41.2023.10.04.09.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:56:13 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 38/53] migration/rdma: Convert
 qemu_rdma_reg_whole_ram_blocks() to Error
In-Reply-To: <20230928132019.2544702-39-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:20:04 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-39-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 18:56:12 +0200
Message-ID: <87ediatjgz.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> wrote:
> Functions that use an Error **errp parameter to return errors should
> not also report them to the user, because reporting is the caller's
> job.  When the caller does, the error is reported twice.  When it
> doesn't (because it recovered from the error), there is no error to
> report, i.e. the report is bogus.
>
> qemu_rdma_exchange_send() violates this principle: it calls
> error_report() via callback qemu_rdma_reg_whole_ram_blocks().  I
> elected not to investigate how callers handle the error, i.e. precise
> impact is not known.
>
> Clean this up by converting the callback to Error.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


