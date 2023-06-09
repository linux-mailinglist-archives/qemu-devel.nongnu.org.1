Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A402E7296D9
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 12:30:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7ZMK-0004gr-0X; Fri, 09 Jun 2023 06:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7ZMI-0004gg-DY
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:28:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7ZMG-0005ec-RS
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686306519;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=s7yBYsdgDsHY7g1y8zdZUvJDWLsRMxl8o1l7nrQCpZQ=;
 b=AZMf8mPLU74ysMabppwNGrs6Ai2knstD5jIj+mK6AZ8HZ6+A0YnsgNEEn3gkJrKVfDMBWP
 pRYM+fCEw+KhkZ4s06KlXd6nj/IvIu/n5lL6dvXluziGLrw5AXsdXrWiVQF0oUujlGgl64
 oWYHSgz5m4jntfSe255YeEte/ysB4I8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-BFuozN8sMFOOT7Nw_viDjg-1; Fri, 09 Jun 2023 06:28:37 -0400
X-MC-Unique: BFuozN8sMFOOT7Nw_viDjg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f5fa06debcso10326175e9.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 03:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686306517; x=1688898517;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s7yBYsdgDsHY7g1y8zdZUvJDWLsRMxl8o1l7nrQCpZQ=;
 b=Q9JXKsrqQoNoktyU2nX+MnwM98Cg4LwRd6ztkmAxJh9habdeqBIOaZOSCP9QI2tdDM
 VTxPxXXe6XYMMPKu+FuvugdbDscoRRG5IiEG5JvNAAPoCd5Y6sMtxNBe1c+DS/33x6FS
 JTelIAT+esz3+KVXYW36nJzP2UmS+kNI/PmkkiTEQdP58+nT4YSizJ8YXMGC1ynqwuch
 NyQ5Ay+ZofgY6sBuKnB2fMw8qyDvOEwuLa282jsTlgEnF4i1Qbwtrr4/b/Bu7b2xGbzp
 mCjJ+xldGcNOJA69CvfhFxTpkOuPRrtWrxRXnn5Zrl1dgjKXPqawTMhKp6h5FGkES6gh
 ai9w==
X-Gm-Message-State: AC+VfDzKG0Z8VbjnVWaBDZ5QmvP8FgFwRsr1c71DZqXgMomXeD+ude5V
 Sb116dCeXWJ02BeE6euClYla/7OnB57TlOQ6ozFT4wl7O9ncOp/gczBUjV2pUKkgvG6fXZB7vtX
 M0pRz3fPYOXUR15k=
X-Received: by 2002:a05:600c:aca:b0:3f7:f614:9970 with SMTP id
 c10-20020a05600c0aca00b003f7f6149970mr812399wmr.34.1686306516813; 
 Fri, 09 Jun 2023 03:28:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ZN6XX5emCHQTKs+3Tf7EvzULIVPf1+liqlcB8rxJ4Lm4Dk/VufhveUEE7qCz9TfueN+nM9g==
X-Received: by 2002:a05:600c:aca:b0:3f7:f614:9970 with SMTP id
 c10-20020a05600c0aca00b003f7f6149970mr812385wmr.34.1686306516535; 
 Fri, 09 Jun 2023 03:28:36 -0700 (PDT)
Received: from redhat.com ([77.211.4.233]) by smtp.gmail.com with ESMTPSA id
 v12-20020a05600c214c00b003f72d7dc66esm2256925wml.13.2023.06.09.03.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 03:28:34 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,  Jiang
 Jiacheng <jiangjiacheng@huawei.com>,  Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v2 2/3] migration/multifd: Protect accesses to
 migration_threads
In-Reply-To: <20230607161306.31425-3-farosas@suse.de> (Fabiano Rosas's message
 of "Wed, 7 Jun 2023 13:13:05 -0300")
References: <20230607161306.31425-1-farosas@suse.de>
 <20230607161306.31425-3-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 09 Jun 2023 12:28:33 +0200
Message-ID: <87mt19c4ku.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> This doubly linked list is common for all the multifd and migration
> threads so we need to avoid concurrent access.
>
> Add a mutex to protect the data from concurrent access. This fixes a
> crash when removing two MigrationThread objects from the list at the
> same time during cleanup of multifd threads.
>
> Fixes: 671326201d ("migration: Introduce interface query-migrationthreads")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


