Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5178AB167
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Apr 2024 17:11:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxptD-0003Py-Gq; Fri, 19 Apr 2024 11:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rxpt4-0003N3-PB
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 11:10:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rxpss-0000Fz-2i
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 11:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713539436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=797g1e+/d8qvTxCJqjjsQP4+vz2jNRk3dmP0OYu0HUI=;
 b=Fh8YUgrnZqVFMNjtm1OKALcybu2bs7uYIEsxq3ROImO2kbI0/FjKdKgUapcBsLK+ok56zR
 uKFSoEhKqzm7ze48nzn26LzOJxjtEGXdrB7xg/FIU9/DvsWiI99qMKzkCvGJPGcTD+hEqf
 c7WdQgIcjAVtOAUJNwAS9SBJ/KvK3gI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-LDBTb6T1P32lC1kWKApHzA-1; Fri, 19 Apr 2024 11:10:35 -0400
X-MC-Unique: LDBTb6T1P32lC1kWKApHzA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49C9B8140A8;
 Fri, 19 Apr 2024 15:10:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A05E1C060D0;
 Fri, 19 Apr 2024 15:10:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2792D21E6811; Fri, 19 Apr 2024 17:10:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Victor Toso de Carvalho
 <victortoso@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 00/27] Add qapi-domain Sphinx extension
In-Reply-To: <87msppl8c8.fsf@pond.sub.org> (Markus Armbruster's message of
 "Fri, 19 Apr 2024 16:45:27 +0200")
References: <20240419043820.178731-1-jsnow@redhat.com>
 <87msppl8c8.fsf@pond.sub.org>
Date: Fri, 19 Apr 2024 17:10:29 +0200
Message-ID: <87y199jsm2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.313,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Markus Armbruster <armbru@redhat.com> writes:

[...]

>> The purpose of sending this series in its current form is largely to
>> solicit feedback on general aesthetics, layout, and features. Sphinx is
>> a wily beast, and feedback at this stage will dictate how and where
>> certain features are implemented.
>
> I'd appreciate help with that.  Opinions?

Less than clear, let me try again: I'm soliciting opinions on the new
look.  Check it out...

[...]

>> This RFC series includes a "sandbox" .rst document that showcases the
>> features of this domain by writing QAPI directives by hand; this
>> document will be removed from the series before final inclusion. It's
>> here to serve as a convenient test-bed for y'all to give feedback.

... here:

>> All that said, here's the sandbox document fully rendered:
>> https://jsnow.gitlab.io/qemu/qapi/index.html
>>
>> And here's the new QAPI index page created by that sandbox document:
>> https://jsnow.gitlab.io/qemu/qapi-index.html

[...]


