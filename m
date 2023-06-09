Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 699F57296C6
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 12:24:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7ZGW-00036f-9W; Fri, 09 Jun 2023 06:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7ZGU-00036T-Am
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:22:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7ZGS-00044Z-LI
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686306159;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q3Uz8leaAHHfxCH8azDEcmMBr+DYZh2qfLfT0nN7Wlw=;
 b=KZqChc9DBNOpAekSEXtQ8DpXy1F++Us2rlG/BvpCqtM7kj0kmSAmPibyJBG8U3QpW6IlmU
 T6MQWT+WMbm+TX5q/hpkiBOsuKeIrSUiaFg9IzcM/BZgOWUYxIMMnbwIlZHQvpQNY0HmuT
 cld/YrYK4U3EwIZCxP8Upf61XRCI9Uw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-TbzwBA_UMnedxqN75XBnUw-1; Fri, 09 Jun 2023 06:22:38 -0400
X-MC-Unique: TbzwBA_UMnedxqN75XBnUw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f5df65fa35so7542225e9.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 03:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686306157; x=1688898157;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q3Uz8leaAHHfxCH8azDEcmMBr+DYZh2qfLfT0nN7Wlw=;
 b=jhvjGHVZcwv48xOy2Koo1asw+SYjgmlxMeW6qCn7tmj019A9rnvvBk3csYgF2sGpDy
 8A3cgew9BMUouEm7/sF+iwGm6aiod5eCjhG0BAqnv4AAqaRsBfQmjYfyMaE1Qy8w14b6
 sBw/CKyndNzHIwwBtORMHMP+mu7NzkQWHwTwMUwwVsgQcvzvqXwQkPGPzJfO98q9bZ9o
 q8xaPrqob8hzH25LRmye7aWhqyIQjgcT02eitdjf4aiq+dJcX2aT9E+rOZnc6rVF3xgP
 pSTRHEr9+Lm8gwJXf7UXwEdZhX76n9u4K19eCW97kPYkQ4Cls6uRFsyE/zgivQsvSNSK
 hzkA==
X-Gm-Message-State: AC+VfDyRNu4g/fBy+/snUdlZMheoorKmI40ViaZ+M+uojEqO6v/mawp6
 mR92HJaufZPwShHTQdUD//vUL6qm1tyOj3FYhQTJUqpb3oEak0CZ2vuX+KD7NIw6D8RKzFUwH5L
 iOuuhriWkwz9MGek=
X-Received: by 2002:a7b:ca46:0:b0:3f6:e59:c04c with SMTP id
 m6-20020a7bca46000000b003f60e59c04cmr542780wml.24.1686306157077; 
 Fri, 09 Jun 2023 03:22:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7dp1JL+YjCaOSdWKxaxk5mGkSsFTaEW/oqRjgneCgIFB3r+ilVGunMDCRX03ytbZqIrxNZ1Q==
X-Received: by 2002:a7b:ca46:0:b0:3f6:e59:c04c with SMTP id
 m6-20020a7bca46000000b003f60e59c04cmr542766wml.24.1686306156791; 
 Fri, 09 Jun 2023 03:22:36 -0700 (PDT)
Received: from redhat.com ([77.211.4.233]) by smtp.gmail.com with ESMTPSA id
 z10-20020a05600c220a00b003f735d6fa74sm2249106wml.9.2023.06.09.03.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 03:22:35 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Leonardo
 Bras <leobras@redhat.com>
Subject: Re: [PATCH 24/42] migration-test: Re-enable multifd_cancel test
In-Reply-To: <ZILaiceoEZSpJsLe@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 9 Jun 2023 08:53:45 +0100")
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-25-quintela@redhat.com>
 <ZILaiceoEZSpJsLe@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 09 Jun 2023 12:22:33 +0200
Message-ID: <87ttvhc4uu.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Fri, Jun 09, 2023 at 12:49:25AM +0200, Juan Quintela wrote:
>
> Please explain why this is considered ok, given the comment about
> why it is disabled. ie if we fixed something, refrence the commit.

I did in the cover letter, will put that on the commit:

- We used to share dest_serial file for the two targets of migration (to
  and to2), where we have a race.

- this series fixes the races in two ways:

  * we wait for "to" to finish before we launch "to2", so the race can't
    happen.

  * One of the reasons why I created GuestState is that I needed a place
    to store the serial file name (now I call it "target" and "target2").

- I put on the cover letter that this is not enough, we also need
  Fabiano fix for the thread list.

- Peter Mayel was the most vocal about this particular failure, I cc'd
  him and asked on the cover letter for the people to used to have
  failures to test.

So how should I handled this to be clearer?

Later, Juan.

>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  tests/qtest/migration-test.c | 10 ++--------
>>  1 file changed, 2 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index 01ab51a391..9f86d9bc80 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -2886,14 +2886,8 @@ int main(int argc, char **argv)
>>      }
>>      qtest_add_func("/migration/multifd/tcp/plain/none",
>>                     test_multifd_tcp_none);
>> -    /*
>> -     * This test is flaky and sometimes fails in CI and otherwise:
>> -     * don't run unless user opts in via environment variable.
>> -     */
>> -    if (getenv("QEMU_TEST_FLAKY_TESTS")) {
>> -        qtest_add_func("/migration/multifd/tcp/plain/cancel",
>> -                       test_multifd_tcp_cancel);
>> -    }
>> +    qtest_add_func("/migration/multifd/tcp/plain/cancel",
>> +                   test_multifd_tcp_cancel);
>>      qtest_add_func("/migration/multifd/tcp/plain/zlib",
>>                     test_multifd_tcp_zlib);
>>  #ifdef CONFIG_ZSTD
>> --=20
>> 2.40.1
>>=20
>
> With regards,
> Daniel


