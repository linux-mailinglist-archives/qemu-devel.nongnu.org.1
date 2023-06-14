Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 415CC72FC33
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 13:17:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9OTg-0001Pz-RU; Wed, 14 Jun 2023 07:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q9OTe-0001PR-7S
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 07:15:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q9OTc-00083p-K5
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 07:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686741347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+qMRXwWzTqDuizTjkfKiVrvMTBT5b/GwJ9j3B741FxQ=;
 b=M8iiQgKPY1hBL8ScIpjySTnFLFzZ5s8uXYylhXsGovVpBwN63+z5HB56m9cW8Omrq6nZ96
 IM595v5Hc203ipqYaNS1oqU7RwP1rwPgu5zCHlcNGecvHZghVZ3DSwqczxFh69WbGOy0Nw
 5EhdgxHyMFs9/nMwHK5yac6ZmvtWf9M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-GLBmhLOWNMGRphUwcYoGfg-1; Wed, 14 Jun 2023 07:15:46 -0400
X-MC-Unique: GLBmhLOWNMGRphUwcYoGfg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FCD3185A78B;
 Wed, 14 Jun 2023 11:15:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D4AA40C20F4;
 Wed, 14 Jun 2023 11:15:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3B8FB21E668A; Wed, 14 Jun 2023 13:15:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Mark Kanda <mark.kanda@oracle.com>
Subject: Re: [PATCH] kvm: reuse per-vcpu stats fd to avoid vcpu interruption
References: <ZIiz8R3F76VqTmKO@tpad>
Date: Wed, 14 Jun 2023 13:15:44 +0200
In-Reply-To: <ZIiz8R3F76VqTmKO@tpad> (Marcelo Tosatti's message of "Tue, 13
 Jun 2023 15:22:41 -0300")
Message-ID: <87h6rab8gv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Marcelo Tosatti <mtosatti@redhat.com> writes:

> A regression has been detected in latency testing of KVM guests.
> More specifically, it was observed that the cyclictest
> numbers inside of an isolated vcpu (running on isolated pcpu) are:
>
> # Max Latencies: 00090 00096 00141
>
> Where a maximum of 50us is acceptable.
>
> The implementation of KVM_GET_STATS_FD uses run_on_cpu to query
> per vcpu statistics, which interrupts the vcpu (and is unnecessary).
>
> To fix this, open the per vcpu stats fd on vcpu initialization,
> and read from that fd from QEMU's main thread.
>
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

[...]

> @@ -4038,7 +4040,8 @@ static StatsDescriptors *find_stats_descriptors(StatsTarget target, int stats_fd
>  }
>  
>  static void query_stats(StatsResultList **result, StatsTarget target,
> -                        strList *names, int stats_fd, Error **errp)
> +                        strList *names, int stats_fd, Error **errp,
> +                        CPUState *cpu)

include/qapi/error.h:

 * - Functions that use Error to report errors have an Error **errp
 *   parameter.  It should be the last parameter, except for functions
 *   taking variable arguments.

>  {
>      struct kvm_stats_desc *kvm_stats_desc;
>      struct kvm_stats_header *kvm_stats_header;

[...]


