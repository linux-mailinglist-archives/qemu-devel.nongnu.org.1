Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE799738F59
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 20:57:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC30k-0005Zl-A8; Wed, 21 Jun 2023 14:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC30i-0005ZE-9F
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 14:56:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC30g-0002bf-Oi
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 14:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687373811;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=seWYZ4KZKU2+nwlpmjLyVa7O2DzqqpcU2dHcl3Vbk2g=;
 b=PoJFhDvUvi3LbyD1OUukul7622K8euaVKjvH99AaPB/S8n/5+rFlMfbGW6SXRyzN9SNPA8
 mjOIlmVheoigbP1xIyBlcLQseSCuqDkiOQgkpdZc3GBLBvK0/9P+0OhSHjL+iGMvegZQmh
 yOpDQz+5r3z3aghVvlBUe7/s8Hj2uO8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-fW9_ExV7Nvikd6j3rup9tA-1; Wed, 21 Jun 2023 14:56:50 -0400
X-MC-Unique: fW9_ExV7Nvikd6j3rup9tA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f9b1ec2826so17151405e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 11:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687373809; x=1689965809;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=seWYZ4KZKU2+nwlpmjLyVa7O2DzqqpcU2dHcl3Vbk2g=;
 b=GtUyLaOmNFuazozmO+f5sN99n0o+BWjTp4GU0uIvbZZpmfE3HLQkXDNA4zDdDTwjYn
 dzGWTq8bSic+kQIeRxRBLW4+vwbzCjuqBk+y4G96fNGmf4qAKPRgyqBBjVazyiea5uPh
 togu2P6SZnuGILjqlLbm59KvMoHW1SI2yi3+CoQohYvv+htYjCi2ktJW9BlqWQZ6Tl0J
 TlrYjYE+zsMcJdVoupE99kp90wskYTdYTzs6DSn41GClu4QNmA5l09uZEAb3qNhnzsbx
 S6o0ozn2Y8ltLZW2NpzYNV+1LFsaLws7g9lcS7NKgoyJWyXqZ6yacdcLQq5jHOoQWQAY
 jOMA==
X-Gm-Message-State: AC+VfDyL8toJF/d8tlBiAN02g0d1HX341YEcnkT0hm6oN/V2289ZeFhv
 jSDXfF0sTcG64cw9i4Pcrw7NPul0vMo0EyOrA8qgSn6fyUTeJnRTdj6Rbcd+Z/PI/vnDqcoaYtq
 VesbNWJvmBpeCjPY=
X-Received: by 2002:a1c:7c13:0:b0:3f4:1ce0:a606 with SMTP id
 x19-20020a1c7c13000000b003f41ce0a606mr14827241wmc.1.1687373808950; 
 Wed, 21 Jun 2023 11:56:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7VEUXOfvjcHxSnhM4UzrWcKIuw6ijReMUPSYMjVeDdJytjxkqJCIOLHa2IDF+BKoY6NDaZNg==
X-Received: by 2002:a1c:7c13:0:b0:3f4:1ce0:a606 with SMTP id
 x19-20020a1c7c13000000b003f41ce0a606mr14827229wmc.1.1687373808648; 
 Wed, 21 Jun 2023 11:56:48 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 m7-20020a7bce07000000b003f9b155b148sm8627599wmc.34.2023.06.21.11.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 11:56:48 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 13/42] migration-test: Check for shared memory like for
 everything else
In-Reply-To: <ZJL3w7i+disrA+i1@x1n> (Peter Xu's message of "Wed, 21 Jun 2023
 09:14:43 -0400")
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-14-quintela@redhat.com> <ZJHGq847FcrpobuD@x1n>
 <87h6r1b02v.fsf@secure.mitica> <ZJL3w7i+disrA+i1@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Wed, 21 Jun 2023 20:56:47 +0200
Message-ID: <87wmzwabkg.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
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

Peter Xu <peterx@redhat.com> wrote:
> On Wed, Jun 21, 2023 at 12:07:20PM +0200, Juan Quintela wrote:
>> Peter Xu <peterx@redhat.com> wrote:
>> > On Fri, Jun 09, 2023 at 12:49:14AM +0200, Juan Quintela wrote:
>> >> Makes things easier and cleaner.
>> >> 
>> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> >> ---
>> >>  tests/qtest/migration-test.c | 20 ++++++++++++--------
>> >>  1 file changed, 12 insertions(+), 8 deletions(-)
>> >> 
>> >> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> >> index daaf5cd71a..5837060138 100644
>> >> --- a/tests/qtest/migration-test.c
>> >> +++ b/tests/qtest/migration-test.c
>> >> @@ -645,13 +645,6 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>> >>      const char *arch = qtest_get_arch();
>> >>      const char *memory_size;
>> >>  
>> >> -    if (args->use_shmem) {
>> >> -        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
>> >> -            g_test_skip("/dev/shm is not supported");
>> >> -            return -1;
>> >> -        }
>> >> -    }
>> >
>> > Maybe assert on: "!args->use_shmem || shm_supported()" here?
>> 
>> Nope.
>> 
>> We are being extra defensive in some tests.
>
> This will protect a new test passing in use_shmem=true without checking
> shm_supported().  It'll then fail at starting the VM I think otherwise.

Hi


As it should.
Test is wrong and it aborts.
It is not that it has found an error, it is that it is badly written.

And anyways, args->use_shmem dissapears later in the series O:-)

Later, Juan.


