Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C99705018
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 16:00:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyvDA-0001wC-1J; Tue, 16 May 2023 09:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pyvD8-0001w3-9B
 for qemu-devel@nongnu.org; Tue, 16 May 2023 09:59:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pyvD3-000666-4i
 for qemu-devel@nongnu.org; Tue, 16 May 2023 09:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684245564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S02nB1jjQ0NVNUpG11U8n9l5spFfzxltOChCcjgcSbs=;
 b=U0n0AUZWhnQZYrjJEsnSFs4y/oBIZ19kBW6BQlqcnKp/Ru57eq2aqwb8COUF+BKsl/bWd1
 ROe/6NCg2+9j7LHFs4TYQhvvz3UcwV5DnBE9m5HHwt5WzWFsNBA/9F9Zh/SDHM9xbwyFCY
 2lvqZxqIG7ETFgtKTdmViXGq7NrvmYo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-438-IkKtMUaRO36AKtcYzVy_hA-1; Tue, 16 May 2023 09:59:22 -0400
X-MC-Unique: IkKtMUaRO36AKtcYzVy_hA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C5E488B767;
 Tue, 16 May 2023 13:59:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F374A400F5A;
 Tue, 16 May 2023 13:59:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CBD9721E681C; Tue, 16 May 2023 15:59:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org,  Juan Quintela
 <quintela@redhat.com>
Subject: Re: [PULL v2 12/17] qapi: Rewrite parsing of doc comment section
 symbols and tags
References: <20230510081224.3588673-1-armbru@redhat.com>
 <20230510081224.3588673-2-armbru@redhat.com>
 <20230516140707.30f02a68@imammedo.users.ipa.redhat.com>
Date: Tue, 16 May 2023 15:59:20 +0200
In-Reply-To: <20230516140707.30f02a68@imammedo.users.ipa.redhat.com> (Igor
 Mammedov's message of "Tue, 16 May 2023 14:07:07 +0200")
Message-ID: <87o7mkpebr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Igor Mammedov <imammedo@redhat.com> writes:

> On Wed, 10 May 2023 10:12:22 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> To recognize a line starting with a section symbol and or tag, we
>> first split it at the first space, then examine the part left of the
>> space.  We can just as well examine the unsplit line, so do that.
>
> this makes build fail on RHEL8.9 (Python 3.6.8)
> with:
>  configure --target-list=x86_64-softmmu --disable-docs
>  make -j32
>  ...
>  /usr/bin/python3 /builds/qemu/scripts/qapi-gen.py -o qapi -b ../../builds/qemu/qapi/qapi-schema.json

[...]

>   File "/builds/qemu/scripts/qapi/parser.py", line 563, in QAPIDoc               
>     def _match_at_name_colon(string: str) -> re.Match:                           
> AttributeError: module 're' has no attribute 'Match'   

Working on it.  First attempt "[PATCH] qapi/parser: Fix type hints"
failed.

Thanks!


