Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF39E8008C1
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 11:45:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r910k-0006Ae-3G; Fri, 01 Dec 2023 05:44:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r910i-0006AS-A1
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 05:44:40 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r910f-0007Bg-GT
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 05:44:40 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-54bf9a54fe3so2414937a12.3
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 02:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701427476; x=1702032276; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fugN4KgxB91Avy5CuqaH0uab0gF6UbNKCvDqkJzjmYI=;
 b=AYnCTlbC017D9MypFMPln3mbcDHwggqwNueOriGlRmnnb3E9wB6QTC6laznpPjXOUj
 1KxEbBL9rteiL95n8aGp7zwSYfvBEAHS/o9kXdUqvUhWymTg/ryXTUyfrwnR/1ditSZd
 UF0Zg3al1m5Y4Fc/wHVwESvs3ob+cXGo8wGRwV1Vytiaa2Gyni5WF6NYQwO4FeM0XnCW
 QIWv5+bjcevZuiqsKgNh8Dxsov5g1PSymb4FsYc8G7bGO1u9wfshQydZQnk1cbKi+sDC
 TxwytkBbpsFYvG29QFixHXq+5m3jAVO6ac//XZR9tGIfynHx3b0ZClHUzvnh+xc5o68a
 Mf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701427476; x=1702032276;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fugN4KgxB91Avy5CuqaH0uab0gF6UbNKCvDqkJzjmYI=;
 b=orSJVfwG2FpGePQfxay6vWc4InZO7DoQxNsinzwpyUjjy1otZU35KqltavwL2F2VKN
 pfnb7Q+JUPaashPb6H/lzV4TqvTKx/pscDVpav3nEVBoEZzlxx03vsoxRdAwEdvu7I8d
 XTGGF45RF/LNJWJ12t6pjCmxvpodftoaGuFSsUgirDc4UbP+gZxEsqzycAZ151vGGhB0
 L8OCVMpFBJtbF4/2Qh4NX5lGXFhKPcWZJH4zWpIknoy6WmQAKzcrxGDb0GtCh/dK8EGJ
 Koic5url0IN6XpDNa8zwQzeIPDJbIvTUxTj0N8RxlO7GgtSH8eioptYLLzplGh0Ng3zX
 cfXQ==
X-Gm-Message-State: AOJu0YyqMYvdVO5xEAi0nNHcsUo0BEvfHb1e5LfCRO+e/3fJzqIRyJxj
 F6IKZFBM+OQtWsFZ+evlz8SqVQ==
X-Google-Smtp-Source: AGHT+IGhXS2SC9TnAIKlwhETC4tEf/fsx6JxpzAvIf/Ww/eJdE8DcKZnPz3L5reGEpkAb9pFmJ7t2Q==
X-Received: by 2002:a50:9344:0:b0:54a:f1db:c2b3 with SMTP id
 n4-20020a509344000000b0054af1dbc2b3mr724054eda.0.1701427475710; 
 Fri, 01 Dec 2023 02:44:35 -0800 (PST)
Received: from [192.168.69.100] ([176.176.160.225])
 by smtp.gmail.com with ESMTPSA id
 y24-20020a056402135800b00548d649f638sm1487495edw.96.2023.12.01.02.44.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 02:44:35 -0800 (PST)
Message-ID: <f976901a-b1a0-45ff-a079-f348e9459aba@linaro.org>
Date: Fri, 1 Dec 2023 11:44:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 42/46] tests/avocado: add cpr regression test
Content-Language: en-US
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, Jason Zeng <jason.zeng@linux.intel.com>,
 Zheng Chuan <zhengchuan@huawei.com>, Mark Kanda <mark.kanda@oracle.com>,
 Guoyi Tu <tugy@chinatelecom.cn>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philippe.mathieu.daude@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>,
 John Snow <jsnow@redhat.com>, Peng Liang <tcx4c70@gmail.com>
References: <1658851843-236870-1-git-send-email-steven.sistare@oracle.com>
 <1658851843-236870-43-git-send-email-steven.sistare@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1658851843-236870-43-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Steve,

On 26/7/22 18:10, Steve Sistare wrote:
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   MAINTAINERS          |   1 +
>   tests/avocado/cpr.py | 176 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 177 insertions(+)
>   create mode 100644 tests/avocado/cpr.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b93b0bb..adc1218 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3172,6 +3172,7 @@ F: stubs/cpr-state.c
>   F: include/migration/cpr.h
>   F: migration/cpr.c
>   F: hw/vfio/cpr.c
> +F: tests/avocado/cpr.py

Maybe rename migration_cpr.py.

>   
>   Record/replay
>   M: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> diff --git a/tests/avocado/cpr.py b/tests/avocado/cpr.py
> new file mode 100644
> index 0000000..11e1376
> --- /dev/null
> +++ b/tests/avocado/cpr.py
> @@ -0,0 +1,176 @@
> +# cpr test

"migration CPR test"

> +
> +# Copyright (c) 2021, 2022 Oracle and/or its affiliates.
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2.
> +# See the COPYING file in the top-level directory.

Preferably replace/complement with SPDX tag.

> +
> +import tempfile
> +from avocado_qemu import QemuSystemTest
> +from avocado.utils import wait
> +
> +class Cpr(QemuSystemTest):

MigrationCpr

> +    """
> +    :avocado: tags=cpr

Also:
        :avocado: tags=migration

or even:

        :avocado: tags=migration
        :avocado: tags=migration:cpr

> +    """
> +
> +    timeout = 5
> +    fast_timeout = 1

These methods ...

> +    @staticmethod
> +    def has_status(vm, status, command):
> +        return vm.command(command)['status'] in status

            s/status/status_set/
> +
> +    def wait_for_status(self, vm, status, command):
> +        wait.wait_for(self.has_status,
> +                      timeout=self.timeout,
> +                      step=0.1,
> +                      args=(vm,status,command,))

            s/status/status_set/

> +
> +    def wait_for_runstate(self, vm, status):
> +        self.wait_for_status(vm, status, 'query-status')

            s/status/status_set/

> +
> +    def wait_for_migration(self, vm, status):
> +        self.wait_for_status(vm, status, 'query-migrate')

            s/status/status_set/

> +
> +    def run_and_fail(self, vm, msg):
> +        # Qemu will fail fast, so disable monitor to avoid timeout in accept
> +        vm.set_qmp_monitor(False)
> +        vm.launch()
> +        vm.wait(self.timeout)
> +        self.assertRegex(vm.get_log(), msg)

... are generic so could go to QemuSystemTest.

The rest LGTM!

Regards,

Phil.

