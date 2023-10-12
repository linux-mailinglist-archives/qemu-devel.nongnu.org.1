Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB1F7C713D
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 17:17:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqxRG-0006Tg-5Q; Thu, 12 Oct 2023 11:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqxRD-0006TQ-AH
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 11:17:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqxRB-0004bm-4Q
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 11:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697123839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cLxUmTsrqtRz6u7lP59SY+Qj0H09N97ZczK4zdDfDNI=;
 b=UEsv5wz1W50LXRJQqnWrHYnIBS/oqJVTNqdjBpVyBcWNDQtbOWP0gaQWTUFQkeP/dbiHt7
 wdeTOTO/ZoZThECKX+Rmv0elSUTJdIe9vU138Wqeb9SKBZ3JetsfhCf+Jv4UYHmQHdeWbf
 n9BQGtGaUDWal/lB3cbuFtRgpF+LUpM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-XptXSnDFMzSP7d-buYoUBA-1; Thu, 12 Oct 2023 11:17:18 -0400
X-MC-Unique: XptXSnDFMzSP7d-buYoUBA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B31BC10334B0
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 15:17:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 92309903
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 15:17:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 84C4E21E6A21; Thu, 12 Oct 2023 17:17:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  qemu-devel@nongnu.org,  Gerd Hoffmann
 <kraxel@redhat.com>
Subject: Re: [PATCH v2] contrib/vhost-user-gpu: Fix compiler warning when
 compiling with -Wshadow
References: <20231009083726.30301-1-thuth@redhat.com>
 <87h6mwyqxn.fsf@pond.sub.org>
 <20231012090829-mutt-send-email-mst@kernel.org>
Date: Thu, 12 Oct 2023 17:17:16 +0200
In-Reply-To: <20231012090829-mutt-send-email-mst@kernel.org> (Michael
 S. Tsirkin's message of "Thu, 12 Oct 2023 09:08:56 -0400")
Message-ID: <87bkd3oooz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Thu, Oct 12, 2023 at 02:18:44PM +0200, Markus Armbruster wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>> 
>> > Rename some variables to avoid compiler warnings when compiling
>> > with -Wshadow=local.
>> >
>> > Signed-off-by: Thomas Huth <thuth@redhat.com>
>> > ---
>> >  v2: Renamed the variable to something more unique

[...]

>> v1 renamed to s_ instead, which I find much easier to read.  Michael
>> asked you to change it so it's less likely to break if we pass it a
>> macro that also uses s_.  Unlikely to happen, and would fail safe: build
>> breaks.

[...]

>> I'm going to queue v1.  Michael, if you want me to queue v2 instead, or
>> neither of the two, let me know.
>
> Yea I think v2 is better, queue that please.

Done.  Thanks!


