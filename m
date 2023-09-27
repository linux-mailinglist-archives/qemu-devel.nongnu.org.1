Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E5A7B03BB
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 14:17:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlTTL-0004vd-DY; Wed, 27 Sep 2023 08:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlTTI-0004os-N6
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 08:16:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlTTH-0006ZW-7J
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 08:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695817010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V94JQ/3MJktq/PVii/1McWpiPVt9hJ0Wk+a3n+YgI1Y=;
 b=Tl4m/7ifQEfbBp6jKYc6ClI76OT7nifkB/IbjYjC64ERo0YhGyq9ac5xLTiCF2o9XW+Pzx
 RLNHT4ak0+WRhS2DcxWvE+U2ntCTUkzCX3+4Fuo6etYfpGx/Ctr0Ega+9Pa/1pwVxAOgPU
 6nu9f8/cqUwtR6rdy+qCGEOkePrNYCA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-u2Fhq-MKOVC71aPk4UarCg-1; Wed, 27 Sep 2023 08:16:49 -0400
X-MC-Unique: u2Fhq-MKOVC71aPk4UarCg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B90E6280FECB;
 Wed, 27 Sep 2023 12:16:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96F6D2026D4B;
 Wed, 27 Sep 2023 12:16:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 85A3C21E6900; Wed, 27 Sep 2023 14:16:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,  "quintela@redhat.com"
 <quintela@redhat.com>,  "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 51/52] migration/rdma: Use error_report() & friends
 instead of stderr
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-52-armbru@redhat.com>
 <8ddefe9a-bb2a-7ec5-972a-d2ab567adc54@fujitsu.com>
Date: Wed, 27 Sep 2023 14:16:47 +0200
In-Reply-To: <8ddefe9a-bb2a-7ec5-972a-d2ab567adc54@fujitsu.com> (Zhijian Li's
 message of "Tue, 26 Sep 2023 06:35:27 +0000")
Message-ID: <87ttrfdd5c.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> writes:

> On 18/09/2023 22:42, Markus Armbruster wrote:
>>           if (local->nb_blocks != nb_dest_blocks) {
>> -            fprintf(stderr, "ram blocks mismatch (Number of blocks %d vs %d) "
>> -                    "Your QEMU command line parameters are probably "
>> -                    "not identical on both the source and destination.",
>> -                    local->nb_blocks, nb_dest_blocks);
>> +            error_report("ram blocks mismatch (Number of blocks %d vs %d)",
>> +                         local->nb_blocks, nb_dest_blocks);
>> +            error_printf("Your QEMU command line parameters are probably "
>> +                         "not identical on both the source and destination.");
>
>
> Why is this one handled specifically? It seems like it would be fine with error_report().

Error message before the patch:

    ram blocks mismatch (Number of blocks %d vs %d) Your QEMU command line parameters are probably not identical on both the source and destination.

Afterwards:

    <ERROR-MSG-PREFIX>ram blocks mismatch (Number of blocks %d vs %d)
    Your QEMU command line parameters are probably not identical on both the source and destination.

where <ERROR-MSG-PREFIX> shows current time (if enabled), guest name (if
enabled), program name (unless in monitor context), and "location" (if
we have one).

The first line is the error message.  It's consists of our common error
message prefix and a single phrase without trailing punctuation.

The second line is a hint.  Repeating the error message prefix there
is unnecessary.  Not repeating it there makes it more obvious that it's
not an error of its own, merely additional information.

Splitting the old message into error message and hint makes the error
message conform to the "single phrase" convention.

Makes sense?


