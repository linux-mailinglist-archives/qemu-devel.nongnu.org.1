Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D385800B65
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 14:03:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r939R-0006Ka-Ex; Fri, 01 Dec 2023 08:01:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r938X-0006Hk-9D
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 08:00:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r938T-0002Cs-62
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 08:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701435647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OdT5jHq8VfaQS0aBa/J9bOAE/xUX3PGIe7SOusWs57g=;
 b=As778MQyVEO5o74QNPYZkv+/iuf3LrQ4Xo+xsfc89df7gf9320cDW6hf+ZmDNBLRwCY5Om
 fBVmhyTimOUNJ5GJYaDYymaoc/MDoLCBQadzVNqzfWFVMac/gNr2Od7UU+UX8i/ehCya8p
 QZgvjuGmFc4nHMoyymVuGwIIHiPA87U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-Ejtesx3OPaC5jm3do35iRQ-1; Fri,
 01 Dec 2023 08:00:46 -0500
X-MC-Unique: Ejtesx3OPaC5jm3do35iRQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A335A3C0EAD4;
 Fri,  1 Dec 2023 13:00:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 194231C060AE;
 Fri,  1 Dec 2023 13:00:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0CC3421E6A1F; Fri,  1 Dec 2023 14:00:44 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Maksim Davydov <davydov-max@yandex-team.ru>,  qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru,  eduardo@habkost.net,
 marcel.apfelbaum@gmail.com,  wangyanan55@huawei.com,  jsnow@redhat.com,
 crosa@redhat.com,  bleal@redhat.com,  eblake@redhat.com,
 pbonzini@redhat.com,  berrange@redhat.com,  alxndr@bu.edu,
 bsd@redhat.com,  stefanha@redhat.com,  thuth@redhat.com,
 darren.kenny@oracle.com,  Qiuhao.Li@outlook.com,  lvivier@redhat.com
Subject: Re: [PATCH v6 0/4] compare machine type compat_props
References: <20231108153827.39692-1-davydov-max@yandex-team.ru>
 <6efb4ba0-e137-4869-b0a9-05f53c278737@linaro.org>
Date: Fri, 01 Dec 2023 14:00:44 +0100
In-Reply-To: <6efb4ba0-e137-4869-b0a9-05f53c278737@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 1 Dec 2023 12:04:15
 +0100")
Message-ID: <87r0k6ulfn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Hi Maksim,
>
> On 8/11/23 16:38, Maksim Davydov wrote:
>> This script can be used to choose the best machine type in the
>> appropriate cases. Also we have to check compat_props of the old MT
>> after changes to be sure that they haven't broken old the MT. For
>> example, pc_compat_3_1 of pc-q35-3.1 has Icelake-Client which was
>> removed.
>
>> Maksim Davydov (4):
>>    qom: add default value
>>    qmp: add dump machine type compatible properties
>>    python: add binary
>>    scripts: add script to compare compatible properties
>>   hw/core/machine-qmp-cmds.c     |  23 +-
>>   python/qemu/machine/machine.py |   5 +
>>   qapi/machine.json              |  54 +++-
>>   qom/qom-qmp-cmds.c             |   1 +
>>   scripts/compare_mt.py          | 484 +++++++++++++++++++++++++++++++++
>
> "compare_machine_types.py" name is more meaningful.

Please use '-' instead of '_' in program names.

>>   tests/qtest/fuzz/qos_fuzz.c    |   2 +-
>>   6 files changed, 565 insertions(+), 4 deletions(-)
>>   create mode 100755 scripts/compare_mt.py


