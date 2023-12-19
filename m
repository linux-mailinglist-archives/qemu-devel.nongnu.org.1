Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA3C818A24
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 15:37:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFbDC-0000LX-5B; Tue, 19 Dec 2023 09:36:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rFbDA-0000LM-Lm
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 09:36:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rFbD9-0002wD-4Q
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 09:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702996601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qPDP3v3xfFn6Dv+TZsgwkZwhJP+S8y+bclKo7Dv6sdQ=;
 b=IATKb7GABRTpVmeInSxMBi6rCucNlXR0H7+a2hupTxv/+ZckB3Qt7JJQLstyxNYFJV+WQU
 AwQ6j4XKCgvldxOz4UEp/CZsPUmNit05ycYLASDtm3Fl9NXoQhBnJ7bncI5iarq6TkYRNp
 V6InCZIlZSLPZlnccnZcjgtfPXmA6q0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-0Kf2CJ6VOfKysSYuFHnK7A-1; Tue, 19 Dec 2023 09:36:38 -0500
X-MC-Unique: 0Kf2CJ6VOfKysSYuFHnK7A-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-77f4fd94d77so694840385a.3
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 06:36:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702996598; x=1703601398;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qPDP3v3xfFn6Dv+TZsgwkZwhJP+S8y+bclKo7Dv6sdQ=;
 b=aO1oUWl7dm5at8oC1yoRgvZYIqynjvgC4aTEOAqLa5gaIdDU2jTRMsLA53awp+dIlR
 o1I7YJntRQksdZm+BkMfEK1I7Tcdsr0o7KDA0faoPYup3gbmSvnnZvSvBk5QNmiV3DAl
 aCViiUNSwvZ/8EMRdoSgyptIgWFlRjPEfdpOgPZo7H7xB0ygbzTs4RhWB+/SOXOdWg90
 uCdSLl0U7RgOpyy8hkiY+us35tinrpm3VfuF2f8C73NFxgnp2BTaYpYYcx4BPd4d7FAx
 xu+MqghyxLHG97n+QFOZcGQz0b31aPxuyRamn9B6Zgdo0sfy+lCNIHMCacQosC2juT02
 Okyw==
X-Gm-Message-State: AOJu0YwbK7Wfz7SIPRBqgOeGE1OWCGTfUe6IRe/GNaiCghggBzlkAL4o
 lXJBc8IY1U3epBJG+wV3uXsAVMHnT2AyjJxJVVjf9GlWKCZZZ6TW+HW5rC9ZI6sBdCz+YWsV4jj
 nueltDt2rSJB4D8U=
X-Received: by 2002:a05:620a:22c9:b0:773:a9f7:eaf1 with SMTP id
 o9-20020a05620a22c900b00773a9f7eaf1mr18505163qki.21.1702996598523; 
 Tue, 19 Dec 2023 06:36:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsQH9dYjZbAlDGMm308vm/FnVW5eq4tBeJU1DyLbanAWrZhVOBZxDnTVFGH4xjP5nk92bGZA==
X-Received: by 2002:a05:620a:22c9:b0:773:a9f7:eaf1 with SMTP id
 o9-20020a05620a22c900b00773a9f7eaf1mr18505149qki.21.1702996598286; 
 Tue, 19 Dec 2023 06:36:38 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-177-45.web.vodafone.de.
 [109.43.177.45]) by smtp.gmail.com with ESMTPSA id
 z28-20020a05620a101c00b0077d8dbfd1c3sm9110902qkj.79.2023.12.19.06.36.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Dec 2023 06:36:38 -0800 (PST)
Message-ID: <260ff019-3bd9-49b1-a364-d0b713372713@redhat.com>
Date: Tue, 19 Dec 2023 15:36:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/5] tests/qtest/migration: Add infrastructure to skip
 tests on older QEMUs
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20231207155809.25673-1-farosas@suse.de>
 <20231207155809.25673-3-farosas@suse.de> <87zfykybyc.fsf@suse.de>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <87zfykybyc.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
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

On 08/12/2023 16.02, Fabiano Rosas wrote:
> Fabiano Rosas <farosas@suse.de> writes:
> 
>> We can run the migration tests with two different QEMU binaries to
>> test migration compatibility between QEMU versions. This means we'll
>> be running the tests with an older QEMU in either source or
>> destination.
>>
>> We need to avoid trying to test functionality that is unknown to the
>> older QEMU. This could mean new features, bug fixes, error message
>> changes, QEMU command line changes, migration API changes, etc.
>>
>> Add a 'since' argument to the tests that inform when the functionality
>> that is being test has been added to QEMU so we can skip the test on
>> older versions.
>>
>> Also add a version comparison function so we can adapt test code
>> depending on the QEMU binary version being used.
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   tests/qtest/migration-helpers.c | 11 +++++++++++
>>   tests/qtest/migration-helpers.h |  1 +
>>   tests/qtest/migration-test.c    | 28 ++++++++++++++++++++++++++++
>>   3 files changed, 40 insertions(+)
>>
>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
>> index 24fb7b3525..d21f5cd8c0 100644
>> --- a/tests/qtest/migration-helpers.c
>> +++ b/tests/qtest/migration-helpers.c
>> @@ -292,3 +292,14 @@ char *resolve_machine_version(const char *alias, const char *var1,
>>   
>>       return find_common_machine_version(machine_name, var1, var2);
>>   }
>> +
>> +int migration_vercmp(QTestState *who, const char *tgt_version)
>> +{
>> +    int major, minor, micro;
>> +    g_autofree char *version = NULL;
>> +
>> +    qtest_query_version(who, &major, &minor, &micro);
>> +    version = g_strdup_printf("%d.%d.%d", major, minor, micro);
> 
> I just noticed this is not right. I need to increment the minor when
> there's a micro to account for the versions in between releases. The
> whole point of this series is to test a X.Y.0 release vs. a X.Y.Z
> development branch.

Also this looks like it cannot deal with two-digit minor versions ... we 
still have machine types for QEMU 2.12.0 around ... do we care here?

  Thomas



