Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A697B122B
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 07:37:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qljhh-0001dd-8F; Thu, 28 Sep 2023 01:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qljhf-0001bV-ED
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 01:36:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qljhd-0004Gp-Uz
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 01:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695879404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YnkwhRs4ZyzgnR6SP/85XEmQqpmPm2l1uT46WZyQwc0=;
 b=ESkSeChOXLdzo91vT2b0hcjkWgyrCIkxH1gmyOmJzvxcb5orwmhhgoLn6hh5dM8TKWtcJZ
 yPfgvAP10wPp8CmFwAkcmwE+0kuva6coz2pIdtEfIpXJa4HqaQDy4+8bngjv7FJIYA4kWt
 4W4OCmSaV8BeQ8UiHs361uEJ3oQ9Jz0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-5IGiwBjiP8ChHDjXF7xq8g-1; Thu, 28 Sep 2023 01:36:40 -0400
X-MC-Unique: 5IGiwBjiP8ChHDjXF7xq8g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 507573C0EAA3;
 Thu, 28 Sep 2023 05:36:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E1E42156A27;
 Thu, 28 Sep 2023 05:36:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1C0D521E6900; Thu, 28 Sep 2023 07:36:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Peter Xu <peterx@redhat.com>,  qemu-devel@nongnu.org,  Juan Quintela
 <quintela@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Philippe =?utf-8?Q?Math?=
 =?utf-8?Q?ieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Thomas Huth <thuth@redhat.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v3 1/4] migration/qmp: Fix crash on setting tls-authz
 with null
References: <20230905162335.235619-1-peterx@redhat.com>
 <20230905162335.235619-2-peterx@redhat.com>
 <0c8f70af-90dc-cdd9-f0fd-746eb503368e@tls.msk.ru>
Date: Thu, 28 Sep 2023 07:36:39 +0200
In-Reply-To: <0c8f70af-90dc-cdd9-f0fd-746eb503368e@tls.msk.ru> (Michael
 Tokarev's message of "Thu, 28 Sep 2023 07:47:35 +0300")
Message-ID: <87wmwa5060.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> 05.09.2023 19:23, Peter Xu:
>> QEMU will crash if anyone tries to set tls-authz (which is a type
>> StrOrNull) with 'null' value.  Fix it in the easy way by converting it to
>> qstring just like the other two tls parameters.
>
> Ping?  Has this been forgotten?

Obviously not: review of the series is ongoing.  PATCH 1+2 look ready,
though, and could be expedited.


