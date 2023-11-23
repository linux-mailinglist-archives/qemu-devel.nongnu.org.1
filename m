Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 126507F5CC0
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 11:45:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r67CL-0006le-U8; Thu, 23 Nov 2023 05:44:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r67CK-0006lR-D7
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 05:44:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r67CI-0006U9-MA
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 05:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700736277;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nFwo97CqPE7msAOb4xq/2HCfrvTbqQaW0gwM1pUQLsI=;
 b=Qq+ovt6GkD2D4M3kaXarJpCO//PIJRIFc++bmOm7lC/8IuhdpGM2kcDz/ABdHigMGiMmQD
 j9B0yurPKjd9yBKiAIbFnb/BKB1FwHWs147EuNRks5+YUtZaJzYu6aexHxO6MJ7kE0mics
 U/lU0A8RW9CAYeP6vyHorBdeseZ/aag=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-KLznl71CMOeCgRDoZTpQNg-1; Thu,
 23 Nov 2023 05:44:35 -0500
X-MC-Unique: KLznl71CMOeCgRDoZTpQNg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 136D83C14760;
 Thu, 23 Nov 2023 10:44:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB1C2492BFA;
 Thu, 23 Nov 2023 10:44:33 +0000 (UTC)
Date: Thu, 23 Nov 2023 10:44:31 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] tests/acpi/bios-tables-test: do not write new blobs
 unless there are changes
Message-ID: <ZV8tDzgl0O1lNj9e@redhat.com>
References: <20231107044952.5461-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231107044952.5461-1-anisinha@redhat.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Nov 07, 2023 at 10:19:51AM +0530, Ani Sinha wrote:
> When dumping table blobs using rebuild-expected-aml.sh, table blobs from all
> test variants are dumped regardless of whether there are any actual changes to
> the tables or not. This creates lot of new files for various test variants that
> are not part of the git repository. This is because we do not check in all table
> blobs for all test variants into the repository. Only those blobs for those
> variants that are different from the generic test-variant agnostic blob are
> checked in.
> 
> This change makes the test smarter by checking if at all there are any changes
> in the tables from the checked-in gold master blobs and take actions
> accordingly.
> 
> When there are no changes:
>  - No new table blobs would be written.
>  - Existing table blobs will be refreshed (git diff will show no changes).
> When there are changes:
>  - New table blob files will be dumped.
>  - Existing table blobs will be refreshed (git diff will show that the files
>    changed, asl diff will show the actual changes).
> When new tables are introduced:
>  - Zero byte empty file blobs for new tables as instructed in the header of
>    bios-tables-test.c will be regenerated to actual table blobs.
> 
> This would make analyzing changes to tables less confusing and there would
> be no need to clean useless untracked files when there are no table changes.
> 
> CC: peter.maydell@linaro.org
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  tests/qtest/bios-tables-test.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> changelog:
> v2: commit description updated to make things a little clearer.
>     No actual changes.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


