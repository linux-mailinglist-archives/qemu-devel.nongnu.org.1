Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEAA7D61A3
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 08:26:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvXLA-0003Cn-DJ; Wed, 25 Oct 2023 02:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvXKz-0003C7-RL
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:25:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvXKv-0001p6-La
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698215146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tPDjEoZlSrb6jGu8cQWvpw3hcn9ZqhDDxR0Veq2YNJk=;
 b=Ig7040h0R05R6zcRjRNFYzAohF8g3NtnhqyUPU7k9xs9jDmAcS3Ytj4vQ8n9jI3KNDKSWR
 CtO2mlpuLgBu6HWLcRloQa1ekdRI18CUzSH+ZoSgULeGvxnq1WVpU6dPq0zh6R77kzaL1R
 qutE2xzgo7UDEBrN/D0ACf/lvtPWFS0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-vUsUo32DMESkH2lI8Cpugg-1; Wed,
 25 Oct 2023 02:25:42 -0400
X-MC-Unique: vUsUo32DMESkH2lI8Cpugg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3FB53C01D98;
 Wed, 25 Oct 2023 06:25:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C2560492BD9;
 Wed, 25 Oct 2023 06:25:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D197121E6A1F; Wed, 25 Oct 2023 08:25:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Zhijian Li <lizhijian@fujitsu.com>,  Juan
 Quintela <quintela@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Thomas
 Huth <thuth@redhat.com>
Subject: Re: [PATCH v3] migration: Stop migration immediately in RDMA error
 paths
References: <20231024163933.516546-1-peterx@redhat.com>
Date: Wed, 25 Oct 2023 08:25:40 +0200
In-Reply-To: <20231024163933.516546-1-peterx@redhat.com> (Peter Xu's message
 of "Tue, 24 Oct 2023 12:39:33 -0400")
Message-ID: <87h6mfkyl7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> In multiple places, RDMA errors are handled in a strange way, where it only
> sets qemu_file_set_error() but not stop the migration immediately.
>
> It's not obvious what will happen later if there is already an error.  Make
> all such failures stop migration immediately.
>
> Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Good move!  Since this already has competent review, I'll leave it
there.


