Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E025B7AD1AD
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 09:31:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkg2f-0005P9-9i; Mon, 25 Sep 2023 03:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qkg2d-0005Nl-K8
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 03:30:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qkg2b-00031I-W3
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 03:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695627000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P0Vl9O8Vyrbg0xf7Lu5RbHbd8gKSbsQiza2cxKFRHVo=;
 b=Mu6PvMWD32GZHImnyURzV3CAUV2baJf71BlMMm12Pw/4HpGLR8e2zqtCtvMZGtqNqz+3OY
 oxYZEJ4UMYzfHPA2X6LKcu1sBhCEN7S0oQGmBsRdDA3VtMSGpAb5qAkdhvwRtJsXkJnowT
 B8GFqF3yevdvtYX4sWJG252vWDyMin4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-dRXZD385NcyVWBjK_XkqDA-1; Mon, 25 Sep 2023 03:29:57 -0400
X-MC-Unique: dRXZD385NcyVWBjK_XkqDA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADC9029A9D3C;
 Mon, 25 Sep 2023 07:29:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B9F22026D4B;
 Mon, 25 Sep 2023 07:29:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7D10321E6900; Mon, 25 Sep 2023 09:29:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Markus Armbruster <armbru@redhat.com>,  "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>,  "quintela@redhat.com" <quintela@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,  "leobras@redhat.com"
 <leobras@redhat.com>
Subject: Re: [PATCH 28/52] migration/rdma: Check negative error values the
 same way everywhere
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-29-armbru@redhat.com>
 <5b2560b5-63ed-37f0-5367-07ca55d43ab4@fujitsu.com>
Date: Mon, 25 Sep 2023 09:29:55 +0200
In-Reply-To: <5b2560b5-63ed-37f0-5367-07ca55d43ab4@fujitsu.com> (Zhijian Li's
 message of "Mon, 25 Sep 2023 06:26:42 +0000")
Message-ID: <87wmwed824.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> writes:

> On 18/09/2023 22:41, Markus Armbruster wrote:
>> When a function returns 0 on success, negative value on error,
>> checking for non-zero suffices, but checking for negative is clearer.
>> So do that.
>> 
>
> This patch is no my favor convention.

Certainly a matter of taste, which means maintainers get to decide, not
me.

Failure checks can be confusing in C.  Is

    if (foo(...))

checking for success or for failure?  Impossible to tell.  If foo()
returns a pointer, it almost certainly checks for success.  If it
returns bool, likewise.  But if it returns an integer, it probably
checks for failure.

Getting a condition backwards is a common coding mistake.  Consider
patch review of

    if (condition) {
        obviously the error case
    }

Patch review is more likely to catch a backward condition when the
condition's sense is locally obvious.

Conventions can help.  Here's the one I like:

* Check for a function's failure the same way everywhere.

* When a function returns something "truthy" on success, and something
  "falsy" on failure, use

    if (!fun(...))

  Special cases:

  - bool true on success, false on failure

  - non-null pointer on success, null pointer on failure

* When a function returns non-negative value on success, negative value
  on failure, use

    if (fun(...) < 0)

* Avoid non-negative integer error values.

* Avoid if (fun(...)), because it's locally ambiguous.

> @Peter, Juan
>
> I'd like to hear your opinions.

Yes, please.


