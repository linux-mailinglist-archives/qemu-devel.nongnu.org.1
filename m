Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E346AB7D8E
	for <lists+qemu-devel@lfdr.de>; Thu, 15 May 2025 08:08:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFRkg-0005ya-UK; Thu, 15 May 2025 02:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uFRkT-0005uI-57
 for qemu-devel@nongnu.org; Thu, 15 May 2025 02:07:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uFRkP-00030o-E5
 for qemu-devel@nongnu.org; Thu, 15 May 2025 02:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747289229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GuJwUwmG7prUQ7Psjn1LGRVPZwTS2qD9eTe++uk5ek8=;
 b=ZvGSeTXflh43U8q9s11zwzkkjPYygrDP4ETrIZZacHNspidn8uU3CgH6KkCslmtaRjSIZs
 nf+CME3Bru9hXMldsfdn7PGAavn/zoyg2rYv66mmhrPAgrYE4hr+DaXUpglTQT0WRZRbS2
 bNwQ+saAvN1ACG/YquFGyDwNrbJsf4Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-z72kBtgMO6y8aa1djrvUZg-1; Thu,
 15 May 2025 02:07:06 -0400
X-MC-Unique: z72kBtgMO6y8aa1djrvUZg-1
X-Mimecast-MFC-AGG-ID: z72kBtgMO6y8aa1djrvUZg_1747289225
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E9A11956094; Thu, 15 May 2025 06:07:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C91E730001A1; Thu, 15 May 2025 06:07:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 10A8A21E6768; Thu, 15 May 2025 08:07:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Eric Blake <eblake@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] qapi/misc-target: Fix the doc of query-sgx and
 query-sgx-capabilities
In-Reply-To: <20250513143131.2008078-1-zhao1.liu@intel.com> (Zhao Liu's
 message of "Tue, 13 May 2025 22:31:29 +0800")
References: <20250513143131.2008078-1-zhao1.liu@intel.com>
Date: Thu, 15 May 2025 08:07:02 +0200
Message-ID: <87cyca4dbt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Zhao Liu <zhao1.liu@intel.com> writes:

> Hi all,
>
> There're 2 QMP commands: query-sgx and query-sgx-capabilities, but
> their outputs are very similar and the documentation lacks clear
> differentiation.
>
 >From the codes, query-sgx is used to gather guest's SGX capabilities
> (including SGX related CPUIDs and EPC sections' size, in SGXInfo), and
> query-sgx-capabilities is used to gather host's SGX capabilities 
> (descripted by SGXInfo as well).
>
> Therefore, fix their documentation to reflect this difference.

Acked-by: Markus Armbruster <armbru@redhat.com>

I'll take this through my tree unless Paolo is faster.


