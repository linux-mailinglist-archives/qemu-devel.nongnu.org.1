Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9576975B24E
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 17:19:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMVPS-0007UZ-Ir; Thu, 20 Jul 2023 11:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qMVPO-0007UL-SX
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 11:17:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qMVPN-0007U0-FP
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 11:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689866256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dv1v2FjqDjC2Hb8ZmfbVa9WoAqmaqDuK/ImA2r+AHkE=;
 b=aEX7L6YqejmqoPKzShY8qBWqky6ZzkZqKBPoGtAEFJBTvBXjX2p5jlkp2HOv3bbUfdGbKN
 g3S6Z+/722gC1EwOk15WsdxW1aw05ck8BybFh90GmVtuQdv7+6UposjFd6RocDKs7ngnhO
 jNkll1l0RLokDVOszBrtHA6OusFlklY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-1oom0Bp6Mxiq2aOlGIFdfQ-1; Thu, 20 Jul 2023 11:14:05 -0400
X-MC-Unique: 1oom0Bp6Mxiq2aOlGIFdfQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5AEB7185AD06;
 Thu, 20 Jul 2023 15:13:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A7B7C2C7D3;
 Thu, 20 Jul 2023 15:13:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 23C3621E6608; Thu, 20 Jul 2023 17:13:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  eblake@redhat.com,  QEMU Trivial
 <qemu-trivial@nongnu.org>
Subject: Re: [PATCH 5/6] qapi: Correct "eg." to "e.g." in documentation
References: <20230720071610.1096458-1-armbru@redhat.com>
 <20230720071610.1096458-6-armbru@redhat.com>
 <7e62d4fd-a23d-8dfc-1d3b-dae63975bc53@linaro.org>
Date: Thu, 20 Jul 2023 17:13:32 +0200
In-Reply-To: <7e62d4fd-a23d-8dfc-1d3b-dae63975bc53@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 20 Jul 2023 15:41:21
 +0200")
Message-ID: <87bkg64nvn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Hi Markus,
>
> On 20/7/23 09:16, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   qapi/char.json | 2 +-
>>   qapi/misc.json | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>> diff --git a/qapi/char.json b/qapi/char.json
>> index e413ac2b70..52aaff25eb 100644
>> --- a/qapi/char.json
>> +++ b/qapi/char.json
>> @@ -18,7 +18,7 @@
>>   # @filename: the filename of the character device
>>   #
>>   # @frontend-open: shows whether the frontend device attached to this
>> -#     backend (eg. with the chardev=3D... option) is in open or closed
>> +#     backend (e.g. with the chardev=3D... option) is in open or closed
>>   #     state (since 2.1)
>>   #
>>   # Notes: @filename is encoded using the QEMU command line character
>> diff --git a/qapi/misc.json b/qapi/misc.json
>> index ff070ec828..cda2effa81 100644
>> --- a/qapi/misc.json
>> +++ b/qapi/misc.json
>> @@ -18,7 +18,7 @@
>>   # fail and the FD will be closed.
>>   #
>>   # @protocol: protocol name.  Valid names are "vnc", "spice",
>> -#     "@dbus-display" or the name of a character device (eg. from
>> +#     "@dbus-display" or the name of a character device (e.g. from
>>   #     -chardev id=3DXXXX)
>>   #
>>   # @fdname: file descriptor name previously passed via 'getfd' command
>
> $ git grep -wF 'eg.' | wc -l
>       45
>
> Why not fix all the tree?

Because I have qapi/ myopia today?


