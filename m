Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB927E536F
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 11:32:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0fql-0006mW-St; Wed, 08 Nov 2023 05:31:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r0fqc-0006js-S4
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:31:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r0fqb-00005z-4j
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:31:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699439504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bSFY1Uw+mw5cctE+fjMvDe7ESQwocrcsH8vuPM9RRJ4=;
 b=WkSfV3vF5YvYqDDB0QvXHt3FfKCd+vu8RYBEIdnLtVGSW1jDc++u/37y7rTWOidv+YvIOw
 MFjMMpDdtx+O6b0oqAtN9mxFeXBPG+AvlVm9ePqAE9gu/HK/k3SXHh9dshYH//IH7ff2LY
 4gS1ZZbjsWv4xgQCrdTBNpSjK7X/ZgA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-ewKc9xx9PUOQFC080b24-Q-1; Wed, 08 Nov 2023 05:31:43 -0500
X-MC-Unique: ewKc9xx9PUOQFC080b24-Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CFC61811E7E;
 Wed,  8 Nov 2023 10:31:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE91B2026D68;
 Wed,  8 Nov 2023 10:31:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B26F621E6A1F; Wed,  8 Nov 2023 11:31:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: qemu-devel@nongnu.org,  marcandre.lureau@redhat.com,  berrange@redhat.com
Subject: Re: [PATCH 0/2] dump: Fix issues flagged by Coverity
References: <20231108053731.112043-1-armbru@redhat.com>
 <87zfzo3ded.fsf@oracle.com>
Date: Wed, 08 Nov 2023 11:31:41 +0100
In-Reply-To: <87zfzo3ded.fsf@oracle.com> (Stephen Brennan's message of "Tue,
 07 Nov 2023 23:36:10 -0800")
Message-ID: <87v8aca642.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Stephen Brennan <stephen.s.brennan@oracle.com> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>> Markus Armbruster (2):
>>   dump: Plug file descriptor leak on non-seekable file
>>   dump: Fix HMP dump-guest-memory -z without -R
>
> Hi Markus,
>
> I'm a bit late on the uptake here as these are already queued, but thank
> you so much for finding and fixing my issues. Sorry for the extra work.

Happens :)

> Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>

Thanks!


