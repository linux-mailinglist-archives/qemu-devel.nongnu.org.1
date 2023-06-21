Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E663737F7B
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 12:22:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBuxK-0004lj-U4; Wed, 21 Jun 2023 06:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qBuxF-0004cW-JO
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 06:20:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qBuxD-0001bN-U7
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 06:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687342847;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=qwX4K02MN3k6EWIKgrWRh0M1ho7HFiU4PpPUAznQt3Q=;
 b=QyMhskQBa5SIMAuCKwGQ8LKrtToRCQrn+NjBVG6HVYBy4bpXMkD6JKm+DM+LnzGAGPdfnH
 G2Re9pC3I8ZohkRoDsrIpP9cMKJ3XJY933YOYB/FIBQlAM9iByrZ0kY5OK/KLb0e5CLQmT
 1gbKY1I9E8+eqmbFOjWt5V1ELn/+uis=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-KVAb1jDPNHuxhUFo9tr8Xw-1; Wed, 21 Jun 2023 06:20:45 -0400
X-MC-Unique: KVAb1jDPNHuxhUFo9tr8Xw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4f63eed2413so4164543e87.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 03:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687342844; x=1689934844;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qwX4K02MN3k6EWIKgrWRh0M1ho7HFiU4PpPUAznQt3Q=;
 b=ag0PxJa2+Np8uUehd/XbIrLrZ7WTLmHK2jjqrOhD+xZFx1S9619v8aYn1FyCK9+0Al
 CsJK/pVDXS0E6HtRdUWwMpmjhKNSzdvUXeTvqr2MTKo9PX1gNR6VlHo2dMgTIsatGtVe
 DawjaUHB85gGV5IOiwpyZo0wEecOPN5VHWGLjCQgNBCv2q+0CddsNLg/aTqCIny0SSib
 y7UIDE+nYj8miqKnbPtCyeDtLuzURuhmWzqkqcjcRFlxRxH2YUM811fF842eVzHmpUpQ
 EsWsVOcLD3hzdUkabcVqwOzmsiBCCWmoehLj3sWzbBWrG4ZpdtJYjKMmExHmjIuTUHBr
 V1fA==
X-Gm-Message-State: AC+VfDwKl6PE2B+t7fr29Ys9hqeAD96XvPXxjXox9qEKW1DE+T/ktx+h
 roCrY3STjAyOmP5aNVTqkxJRt1c3a5JDAGw9Q30usajKjbqJsaB9q58CbE5aDIl13RLfSbALtC1
 G9w/nNZEcaoUJp4g=
X-Received: by 2002:a19:710b:0:b0:4f6:2a02:fc1a with SMTP id
 m11-20020a19710b000000b004f62a02fc1amr8494515lfc.17.1687342844293; 
 Wed, 21 Jun 2023 03:20:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7BG57x/T4R8DBoSyv5cBLV+2HNuUU/cFrW9QtF3JwATXRrMwxvy32Mvw80ZrNi8MR2E94KAQ==
X-Received: by 2002:a19:710b:0:b0:4f6:2a02:fc1a with SMTP id
 m11-20020a19710b000000b004f62a02fc1amr8494502lfc.17.1687342843895; 
 Wed, 21 Jun 2023 03:20:43 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 a17-20020a5d5711000000b003062b2c5255sm4071975wrv.40.2023.06.21.03.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 03:20:43 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 02/42] migration-test: Make ignore_stderr regular with
 other options
In-Reply-To: <ZJG+x0iHS46dLqSB@x1n> (Peter Xu's message of "Tue, 20 Jun 2023
 10:59:19 -0400")
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-3-quintela@redhat.com> <ZJG+x0iHS46dLqSB@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Wed, 21 Jun 2023 12:20:42 +0200
Message-ID: <87cz1pazgl.fsf@secure.mitica>
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
> On Fri, Jun 09, 2023 at 12:49:03AM +0200, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  tests/qtest/migration-test.c | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>> 
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index c5e0c69c6b..73b2f01427 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -602,7 +602,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>>      g_autofree gchar *arch_target = NULL;
>>      g_autofree gchar *cmd_source = NULL;
>>      g_autofree gchar *cmd_target = NULL;
>> -    const gchar *ignore_stderr;
>> +    const gchar *ignore_stderr = NULL;
>>      g_autofree char *bootpath = NULL;
>>      g_autofree char *shmem_opts = NULL;
>>      g_autofree char *shmem_path = NULL;
>> @@ -672,10 +672,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>>           * IO redirection does not work, so don't bother adding IO redirection
>>           * to the command line.
>>           */
>> -        ignore_stderr = "";
>
> Personally maybe I won't bother with such a patch as a whole..

I am trying that all the options are handled the same.
The whole idea here is that I have to split guest definition and guest
creation.  See GuestState later on the series.

If all the options are handled the same, it is much easier than if I
have to do "magic" for one vs others.

One thing that I wonder is that migration-test can't be the only test
that needs to redirect stderr, but that is a completely different issue.

> but if we do
> want to, we could also remove "#else" here and move comment above it.

Done.


