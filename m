Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 528757CF7B5
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 13:57:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtReA-0006WU-Ge; Thu, 19 Oct 2023 07:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtRe7-0006Vz-5H
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:56:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtRe4-0006Hy-LV
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697716615;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=kv1G9io4JumbUqyHaBo+vKNcoZ8aJz1kf5gRsmniphQ=;
 b=ee4+hAL/1fTqMUtuyz7A0vjTefhkQjzyoieqcJwH01CmOPqtt9yZQhc9g4hEXZ/R56pbkk
 kiufFzniDCOWkDMX19c0XU8ZKIo6em0G9Q0mKsU+hfT3qeFq5qnmCYBe1T6lm7IrIM0grh
 pRQzq5bV/Y8/mLYqf+6ebdTRuyOv6ho=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-csCFzCygOvaslkICgM6aFA-1; Thu, 19 Oct 2023 07:56:54 -0400
X-MC-Unique: csCFzCygOvaslkICgM6aFA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32172e3679bso4811209f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 04:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697716613; x=1698321413;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kv1G9io4JumbUqyHaBo+vKNcoZ8aJz1kf5gRsmniphQ=;
 b=v9eN7J1zyP+zkUR20OlRomhRwb3bkqWOgYSC1Cfry0ihKQLmPya3xdMubI1mF3pEh6
 7sgZ/odSsKdQfGnnE7y+ZVIhggV0r3uSvJCE4rl4okpcbKlPraXwWjurhslRfnaIjeK+
 i6qyFbjEg2y+wcoOsxaUUaLvjYCqWfmrq6kwvFtciHRNtOTLMtktYaHtDUFqhGMV6MyY
 tdwW8xVc0+x4AH3R+7aPK5XfjhvWUFhI7G9jmLALfUnUbx+ZF3xfBFEvaVLDWx6reL9P
 D7uMpT3nctmFiQwx1Q/SWk1aKgjorDtaj+pDtYfVC6nXXpXfNi/ORlqzGXqzToMLZVZI
 AE0w==
X-Gm-Message-State: AOJu0Yzqpzi/FoSS0l7UWzFiDlErUVQcnDURij8C+gx0drb5jV2OPvXO
 KfTovG9pM/Yy7hlNwGkBLCymom/kCzuPPWMBLpDMgestOtoQmP7/WYxTyQY2W24HrpoqNe2BNgl
 h2WaNAh4vWqfUKv8=
X-Received: by 2002:a5d:45d1:0:b0:32d:9df1:6f6d with SMTP id
 b17-20020a5d45d1000000b0032d9df16f6dmr1366662wrs.17.1697716613322; 
 Thu, 19 Oct 2023 04:56:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSw+2af+zN0JHJt3gLY+aMe6qULDZcI2b3l+ljTUyxcAWpUosA+Ly+ateWi4j5BPuY5JDI7g==
X-Received: by 2002:a5d:45d1:0:b0:32d:9df1:6f6d with SMTP id
 b17-20020a5d45d1000000b0032d9df16f6dmr1366640wrs.17.1697716612959; 
 Thu, 19 Oct 2023 04:56:52 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 y10-20020a5d614a000000b0032d402f816csm4276382wrt.98.2023.10.19.04.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 04:56:52 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,  qemu-devel@nongnu.org,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Laurent
 Vivier <lvivier@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 10/12] tests/qtest/migration: Support more than one
 QEMU binary
In-Reply-To: <e4645bfb-9ded-41cb-adc5-6c81effea275@redhat.com> (Thomas Huth's
 message of "Thu, 19 Oct 2023 08:46:56 +0200")
References: <20231018192741.25885-1-farosas@suse.de>
 <20231018192741.25885-11-farosas@suse.de>
 <e4645bfb-9ded-41cb-adc5-6c81effea275@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 19 Oct 2023 13:56:52 +0200
Message-ID: <874jim6d17.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Thomas Huth <thuth@redhat.com> wrote:
> On 18/10/2023 21.27, Fabiano Rosas wrote:
>> We have strict rules around migration compatibility between different
>> QEMU versions but no test to validate the migration state between
>> different binaries.
>> Add infrastructure to allow running the migration tests with two
>> different QEMU binaries as migration source and destination.
>> The code now recognizes two new environment variables
>> QTEST_QEMU_BINARY_SRC and QTEST_QEMU_BINARY_DST. In the absence of
>> either of them, the test will use the QTEST_QEMU_BINARY variable. If
>> both are missing then the tests are run with single binary as
>> previously.
>> The machine type is selected automatically as the latest machine
>> type
>> version that works with both binaries.
>> Usage (only one of SRC|DST is allowed):
>> QTEST_QEMU_BINARY_SRC=../build-8.2.0/qemu-system-x86_64 \
>> QTEST_QEMU_BINARY=../build-8.1.0/qemu-system-x86_64 \
>> ./tests/qtest/migration-test
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   tests/qtest/migration-test.c | 28 ++++++++++++++++++++++++----
>>   1 file changed, 24 insertions(+), 4 deletions(-)
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
> I wonder whether we could test this in the gitlab-CI, too, e.g. by
> using a Debian container and installing the qemu-system-x86_64 from
> the Debian distro there (since this should be close enough to an older
> version of an upstream release), then run the test with that version
> from Debian and the one that has just been compiled from the master
> branch? Anyway, just an idea, this can certainly be done later.

My idea would be to modify the container to create two trees:
- last released version
- upstream tip

And just use that two binaries with the upstream one handling this.

Later, Juan.


