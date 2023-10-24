Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E85547D4EA3
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 13:14:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvFMT-0000F9-Mr; Tue, 24 Oct 2023 07:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvFMN-0000Cm-1U
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 07:14:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvFMH-0007kS-EY
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 07:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698146040;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=kfm8ia2jUd/ZJM8dhsCx19XX1F4qnJDCfhk6LOQYTI8=;
 b=N5YmS55TLkScFD6lB0Q/LPjN2U6+u4rsudaWjDFnkvXLGnoprgtAXZwvqoJlGFbYxBL5kq
 +RYtJbcUSnzimayeqCU++qsflV3d+lyiE8AAhKBJ8C077qSQKFSyDscZ8cjA6uQ6TQwmVe
 KJk8bDB7ahX4vK+dWq0AResw+6lkUhs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-7P8hxvYhP2OGoHBjzh1Dtw-1; Tue, 24 Oct 2023 07:13:49 -0400
X-MC-Unique: 7P8hxvYhP2OGoHBjzh1Dtw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c506abc320so36543001fa.2
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 04:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698146027; x=1698750827;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kfm8ia2jUd/ZJM8dhsCx19XX1F4qnJDCfhk6LOQYTI8=;
 b=LPZrSOtuwRqMo78Az4dgN+X7WfqpmrQIclKXGWrTZ56sUcbJeaAJg0kx5IFSzzfgke
 6iY/xRmZf48BnhE10eq3uwvwGCaPFEW0gnKfuEh3bxePd+cJFTvbkobBNgYZZvkj68IZ
 qSLHGDwYl7Ml+WxtKNLSv6wPasdU043DN/i/1n/JdBlyFeW2OWjKZ7VAEUKjly/znpZl
 /tS24NkU7ibaI6UI7w/WX3juytvpwL5MpHyifwSFGuTqHeNbz9QeFKV3JlSoIJK7SSE4
 zVScVcskiP2qTwrCYS6yeMRwuUJ2OqTK9LNDh3SzB2CiluSCi5IAST1Qn9wmqu+8rGnu
 MFFw==
X-Gm-Message-State: AOJu0Yyxj4aVYhJBVGfNiDUVmTAeQPnB4jO7gYdGFUtO05gePt0Abflp
 zIBUhckavkrnvKpftvnHpaWrCABwK4fK0jSYXeOjohQ3oEixvexTraXSUG+dQojfc3Yj+0vg3f5
 H54ht+vIICUKNidA=
X-Received: by 2002:a2e:a7d2:0:b0:2c5:4956:5112 with SMTP id
 x18-20020a2ea7d2000000b002c549565112mr7969609ljp.35.1698146027538; 
 Tue, 24 Oct 2023 04:13:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEseC/WrNRBA8k7qz9aZr1LsicQuazKL05IPS872mJCH67xzMQD+en/+7YZOSvOcc7AuvAxkw==
X-Received: by 2002:a2e:a7d2:0:b0:2c5:4956:5112 with SMTP id
 x18-20020a2ea7d2000000b002c549565112mr7969593ljp.35.1698146027156; 
 Tue, 24 Oct 2023 04:13:47 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 r9-20020a05600c158900b0040776008abdsm11655572wmf.40.2023.10.24.04.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 04:13:46 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V1 4/4] cpr: reboot mode
In-Reply-To: <fe0848ae-6600-4b46-bf2a-05b9dea55472@oracle.com> (Steven
 Sistare's message of "Mon, 23 Oct 2023 14:39:19 -0400")
References: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
 <1697748466-373230-5-git-send-email-steven.sistare@oracle.com>
 <87mswdzkyj.fsf@secure.mitica>
 <2814d5e1-76be-4d4e-a76b-25b2eabd2cfe@oracle.com>
 <875y31yter.fsf@secure.mitica>
 <fe0848ae-6600-4b46-bf2a-05b9dea55472@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 24 Oct 2023 13:13:46 +0200
Message-ID: <87fs20z311.fsf@secure.mitica>
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

Steven Sistare <steven.sistare@oracle.com> wrote:
> On 10/20/2023 3:40 PM, Juan Quintela wrote:
>> Steven Sistare <steven.sistare@oracle.com> wrote:
>>> On 10/20/2023 5:45 AM, Juan Quintela wrote:
>>>> Steve Sistare <steven.sistare@oracle.com> wrote:
>>>>> Add the cpr-reboot migration mode.  Usage:
>>>>>
>>>>> $ qemu-system-$arch -monitor stdio ...
>>>>> QEMU 8.1.50 monitor - type 'help' for more information
>>>>> (qemu) migrate_set_capability x-ignore-shared on
>>>>> (qemu) migrate_set_parameter mode cpr-reboot
>>>>> (qemu) migrate -d file:vm.state
>>>>> (qemu) info status
>>>>> VM status: paused (postmigrate)
>>>>> (qemu) quit
>>>>>
>>>>> $ qemu-system-$arch -monitor stdio -incoming defer ...
>>>>> QEMU 8.1.50 monitor - type 'help' for more information
>>>>> (qemu) migrate_set_capability x-ignore-shared on
>>>>> (qemu) migrate_set_parameter mode cpr-reboot
>>>>> (qemu) migrate_incoming file:vm.state
>>>>> (qemu) info status
>>>>> VM status: running
>>>>>
>>>>> In this mode, the migrate command saves state to a file, allowing one
>>>>> to quit qemu, reboot to an updated kernel, and restart an updated version
>>>>> of qemu.  The caller must specify a migration URI that writes to and reads
>>>>> from a file.  Unlike normal mode, the use of certain local storage options
>>>>> does not block the migration, but the caller must not modify guest block
>>>>> devices between the quit and restart.  The guest RAM memory-backend must
>>>>> be shared, and the @x-ignore-shared migration capability must be set,
>>>>> to avoid saving RAM to the file.  Guest RAM must be non-volatile across
>>>>> reboot, such as by backing it with a dax device, but this is not enforced.
>>>>> The restarted qemu arguments must match those used to initially start qemu,
>>>>> plus the -incoming option.
>>>>
>>>> Please, add this message to doc/<somewhere> instead (or additionally) to
>>>> the commit log.
>>>>
>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>> ---
>>>>>  qapi/migration.json | 16 +++++++++++++++-
>>>>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>>> index 184fb78..2d862fa 100644
>>>>> --- a/qapi/migration.json
>>>>> +++ b/qapi/migration.json
>>>>> @@ -620,9 +620,23 @@
>>>>>  #
>>>>>  # @normal: the original form of migration. (since 8.2)
>>>>>  #
>>>>> +# @cpr-reboot: The migrate command saves state to a file, allowing one to
>>>>> +#              quit qemu, reboot to an updated kernel, and restart an updated
>>>>> +#              version of qemu.  The caller must specify a migration URI
>>>>> +#              that writes to and reads from a file.  Unlike normal mode,
>>>>> +#              the use of certain local storage options does not block the
>>>>> +#              migration, but the caller must not modify guest block devices
>>>>> +#              between the quit and restart.  The guest RAM memory-backend
>>>>> +#              must be shared, and the @x-ignore-shared migration capability
>>>>> +#              must be set, to avoid saving it to the file.  Guest RAM must
>>>>> +#              be non-volatile across reboot, such as by backing it with
>>>>> +#              a dax device, but this is not enforced.  The restarted qemu
>>>>> +#              arguments must match those used to initially start qemu, plus
>>>>> +#              the -incoming option. (since 8.2)
>>>>> +#
>>>>>  ##
>>>>>  { 'enum': 'MigMode',
>>>>> -  'data': [ 'normal' ] }
>>>>> +  'data': [ 'normal', 'cpr-reboot' ] }
>>>>>  
>>>>>  ##
>>>>>  # @BitmapMigrationBitmapAliasTransform:
>>>>
>>>> It only works with file backend, and we don't have any check for that.
>>>> Wondering how to add that check.
>>>
>>> Actually, it works for other backends, but the ram contents are saved in the
>>> state file, which is slower. I should spell that out in the json comment and
>>> in the commit message.
>> 
>> Thanks.
>>>
>>>> Additionally, you are not adding a migration test that does exactly what
>>>> you put there in the comment.
>>>
>>> I provide tests/avocado/cpr.py in the original long series.  Would you
>>> like me to add it to this series, or post it later?  Would you prefer I
>>> add a test to tests/qtest/migration-test.c?
>> 
>> test/qtest/migration-test.c
>> 
>> please.
>> 
>> Something simple like what you say in the commit should be a good start.
>
> I wrote a new test which I will submit with V2 of this series.  Turned out to be
> easy after Fabiano provided test_file_common.
>
> +static void *test_mode_reboot_start(QTestState *from, QTestState *to)
> +{
> +    migrate_set_parameter_str(from, "mode", "cpr-reboot");
> +    migrate_set_parameter_str(to, "mode", "cpr-reboot");
> +
> +    migrate_set_capability(from, "x-ignore-shared", true);
> +    migrate_set_capability(to, "x-ignore-shared", true);
> +
> +    return NULL;
> +}
> +
> +static void test_mode_reboot(void)
> +{
> +    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
> +                                           FILE_TEST_FILENAME);
> +    MigrateCommon args = {
> +        .start.use_shmem = true,
> +        .connect_uri = uri,
> +        .listen_uri = "defer",
> +        .start_hook = test_mode_reboot_start
> +    };
> +
> +    test_file_common(&args, true);
> +}
>
> - Steve

As a started, that sounds good.
When you add more features, please add tests acordingly.

Thanks again, Juan.


