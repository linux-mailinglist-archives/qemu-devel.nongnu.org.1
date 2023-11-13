Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6442A7EA139
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 17:24:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2ZiN-00072o-2u; Mon, 13 Nov 2023 11:23:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r2ZiL-000724-DS
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 11:23:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r2ZiJ-0005Gw-Mm
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 11:23:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699892583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5FF8VvkwUcZrfN2KkFU+AGkFEcy2kySXeryCtxcW9Ug=;
 b=Jgx5bx5Uqc4DGP+3ib88PhJ1fZzB76YKTW4WXtL8pY8Vptw2ml5gtfMMJ8UQLs4+XoGEPK
 i0FN2vevlLl1R3B5DAjNipVE8buM5P6Dr/Csi6sm6LmILNHujiTqo7nhYnPGxDuFCKih5Q
 hHXvBrDmUWT3wIF2+CPonaO8TvPEFqs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-KOSOH5WUMHmb2y3DwXQKtQ-1; Mon, 13 Nov 2023 11:22:57 -0500
X-MC-Unique: KOSOH5WUMHmb2y3DwXQKtQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B8F82852AC0;
 Mon, 13 Nov 2023 16:22:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D2B336EE;
 Mon, 13 Nov 2023 16:22:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6C4F321E6A1F; Mon, 13 Nov 2023 17:22:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  alistair@alistair23.me,
 edgar.iglesias@gmail.com,  peter.maydell@linaro.org,
 francisco.iglesias@amd.com,  qemu-arm@nongnu.org
Subject: Re: [PATCH 1/2] docs/system/arm: Fix for rename of type
 "xlnx.bbram-ctrl"
References: <20231113134344.1195478-1-armbru@redhat.com>
 <20231113134344.1195478-2-armbru@redhat.com>
 <43bf23f8-ef98-453b-a687-5367e39f0c2b@redhat.com>
Date: Mon, 13 Nov 2023 17:22:54 +0100
In-Reply-To: <43bf23f8-ef98-453b-a687-5367e39f0c2b@redhat.com> (Thomas Huth's
 message of "Mon, 13 Nov 2023 16:54:52 +0100")
Message-ID: <87pm0dk4gx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Thomas Huth <thuth@redhat.com> writes:

> On 13/11/2023 14.43, Markus Armbruster wrote:
>> Fixes: b65b4b7ae3c8 (xlnx-bbram: hw/nvram: Use dot in device type name)
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   docs/system/arm/xlnx-versal-virt.rst | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
>> index d2d1b26692..a6a77b3799 100644
>> --- a/docs/system/arm/xlnx-versal-virt.rst
>> +++ b/docs/system/arm/xlnx-versal-virt.rst
>> @@ -194,7 +194,7 @@ To use a different index value, N, from default of 0, add:
>>     .. code-block:: bash
>>   -  -global xlnx,bbram-ctrl.drive-index=N
>> +  -global xlnx.bbram-ctrl.drive-index=N
>
> Ouch, that's now ugly, too. Imagine that we have a device called "xlnx" one day, how's the reader supposed to distinguish between the "xlnx" and the "xlnx.bbram-ctrl" device here?

Hmm, it's actually worse than ugly: it doesn't work.

    $ qemu-system-aarch64 -nodefaults -S -display none -M none -global xlnx.bbram-ctrl.drive-index=2
    qemu-system-aarch64: warning: global xlnx.bbram-ctrl.drive-index has invalid class name

That's because xlnx.bbram-ctrl.drive-index=N is syntactically ambiguous: it
could be sugar for

    driver=xlnx.bbram-ctrl,property=drive-index,value=N

or for

    driver=xlnx,property=bbram-ctrl.drive-index,value=N

Our parser picks the latter.

I'll respin the patch to use longhand syntax.

> It feels like we should forbid both, "," and "." in device names...

Yes, '.' is a bad idea, too.  But there are many names with them, and
I'm not ready to tackle them.

> Anyway, for the current state:
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks!


