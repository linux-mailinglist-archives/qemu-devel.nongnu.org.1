Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD78737F4C
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 12:08:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBukN-0004LU-Fs; Wed, 21 Jun 2023 06:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qBukK-0004LL-5z
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 06:07:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qBukI-0005Vi-NL
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 06:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687342045;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=IfSZK+2EiF5n9mGeDjb8ZbmCmMLIgM7dSBALUyNDV7Q=;
 b=Tku1XQqZEUWj67MptSH4ANdiV/eM8Z9Vbtgyu4ZaCB7hwm0IoV3UKk96xmzulGcPxBd/U1
 fS+lqKKy36QPFRYnf3Gl5Y473wUIeZF5cEwnmUNsF4lsvnBOCT+Iky71++RYLINLSSIyIP
 xdVddErf/k1umkCNkcGDhjr7haIe3n4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-XBRkNXCIMteIVDwEjL41_g-1; Wed, 21 Jun 2023 06:07:23 -0400
X-MC-Unique: XBRkNXCIMteIVDwEjL41_g-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30e6153f0eeso2318428f8f.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 03:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687342043; x=1689934043;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IfSZK+2EiF5n9mGeDjb8ZbmCmMLIgM7dSBALUyNDV7Q=;
 b=Xtj9t2ARK5kDSlUI4fylJuqbdJLpIpfnWbw2+9BUR8s6W+p2Bs7qg/fpeBwETKQyGn
 as0I3QsaBXToL2iIUtUqGif7NRxonk/m+kN0Y5nHkSqhpfiFnlloLINXzbGYfGsHwGI4
 9RQGCalwJglHhbi2dBRSxD7HwxVFjYiD+CUl+Co6O/5zzM1abcqwdkb+7byBd5uRN4Hi
 rGrco46J5367X3LVB04juTxVYpVSLHCKwsSARxY56CnCCrSD+WYqHIaTrOrn2qz14afv
 9TsdNrbkVaDK/aaCI6MCawCiuy1+N4NrMlv7/E95SVkmG2E+Hkr3K8ZDhfj7gVyA0BKL
 0B6A==
X-Gm-Message-State: AC+VfDyKPET72PL130UFVGWW7Q4A59o++WC8corxnM3pjyIoMr5VCreO
 VC9WblvG53Dt4Ogfc3sjr7MKzRQqe8J4YP55jsnaop+Gi7Oo89+Yv5R/d5BHmMmwqN2KfCWxEwm
 RO1NWwa8+CxsIU4E=
X-Received: by 2002:a5d:44c7:0:b0:311:b44:2d74 with SMTP id
 z7-20020a5d44c7000000b003110b442d74mr10355750wrr.0.1687342042819; 
 Wed, 21 Jun 2023 03:07:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7gIw8JC+Zb3weDt2riqed4Qpy3xktpqkckqpiXIbHCLtihgkgsVf3IA51tj5Ci5hATSe1ttw==
X-Received: by 2002:a5d:44c7:0:b0:311:b44:2d74 with SMTP id
 z7-20020a5d44c7000000b003110b442d74mr10355733wrr.0.1687342042298; 
 Wed, 21 Jun 2023 03:07:22 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 k7-20020a5d5187000000b0031128382ed0sm4045935wrv.83.2023.06.21.03.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 03:07:21 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 13/42] migration-test: Check for shared memory like for
 everything else
In-Reply-To: <ZJHGq847FcrpobuD@x1n> (Peter Xu's message of "Tue, 20 Jun 2023
 11:32:59 -0400")
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-14-quintela@redhat.com> <ZJHGq847FcrpobuD@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Wed, 21 Jun 2023 12:07:20 +0200
Message-ID: <87h6r1b02v.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> wrote:
> On Fri, Jun 09, 2023 at 12:49:14AM +0200, Juan Quintela wrote:
>> Makes things easier and cleaner.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  tests/qtest/migration-test.c | 20 ++++++++++++--------
>>  1 file changed, 12 insertions(+), 8 deletions(-)
>> 
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index daaf5cd71a..5837060138 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -645,13 +645,6 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>>      const char *arch = qtest_get_arch();
>>      const char *memory_size;
>>  
>> -    if (args->use_shmem) {
>> -        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
>> -            g_test_skip("/dev/shm is not supported");
>> -            return -1;
>> -        }
>> -    }
>
> Maybe assert on: "!args->use_shmem || shm_supported()" here?

Nope.

We are being extra defensive in some tests.

It is tested here

>> -    qtest_add_func("/migration/ignore_shared", test_ignore_shared);
>> +    if (shm_supported()) {
>> +        qtest_add_func("/migration/ignore_shared", test_ignore_shared);
>> +    }

Checking (in the same code path) once in the same file looks like enough
to me.

Thanks, Juan.


