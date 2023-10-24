Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0BA7D4E6F
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 12:58:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvF6V-00087V-IT; Tue, 24 Oct 2023 06:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvF6K-00085I-OY
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 06:57:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvF6F-000375-Hi
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 06:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698145045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KBsownQUXCyjLu75u8hHfY68Wwa3OhiUqvalRj6awT8=;
 b=S6oEOW06o6otARgYPLPHdSw69XO/kNOLrvMHEl25PgutvoPe1N1tbUfBgt9QfXN3bP8dd1
 6q3XSF5laLNg84eZbri4lUg+D/Vld+PVmnT3fQ0H2ksh45V66Yu4G29ruWOWfc5nqa2TkL
 iVuugHbhfSHBs7h6Qjln94r7h19SsWU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-_0QySwVwP3C10_9easPL9Q-1; Tue,
 24 Oct 2023 06:57:22 -0400
X-MC-Unique: _0QySwVwP3C10_9easPL9Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 595FE3803512;
 Tue, 24 Oct 2023 10:57:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 38CFB40C6F79;
 Tue, 24 Oct 2023 10:57:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3155821E6A1F; Tue, 24 Oct 2023 12:57:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,  qemu-devel@nongnu.org,  Peter Xu
 <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH v2] migration/ram: Fix compilation with -Wshadow=local
References: <20231024092220.55305-1-thuth@redhat.com>
 <87edhk1fbq.fsf@secure.mitica>
Date: Tue, 24 Oct 2023 12:57:21 +0200
In-Reply-To: <87edhk1fbq.fsf@secure.mitica> (Juan Quintela's message of "Tue, 
 24 Oct 2023 12:32:09 +0200")
Message-ID: <87o7goqodq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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

Juan Quintela <quintela@redhat.com> writes:

> Thomas Huth <thuth@redhat.com> wrote:
>> Rename the variable here to avoid that it shadows a variable from
>> the beginning of the function scope. With this change the code now
>> successfully compiles with -Wshadow=local.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
>
> queued.

I'm going to post a patch to enable -Wshadow=local, based on all the
outstanding shadow fixes, including this one.  When I do the PR for the
enabling patch, I'll need to include any outstanding shadow fixes.
Should be fine no matter how it races with your PR.

>> ---
>>  v2: Need the value for the qemu_file_set_error() line, too
>
> I also hate qemu_file_set_error().
>
> Direct translation of Spanish Saying:
>
> Evil of many, consolation of fools
>
> O:-)

Good one!


