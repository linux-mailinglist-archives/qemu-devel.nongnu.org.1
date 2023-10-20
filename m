Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6427D1672
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 21:41:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtvM5-0007vO-Vl; Fri, 20 Oct 2023 15:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtvM4-0007pS-97
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 15:40:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtvM2-000804-GZ
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 15:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697830816;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=m98aXwFFS2G+lbitdNT+qIJvrMvrSTYoVzCY9soDOZs=;
 b=CAiCE+1LUZpr06yZRM/Ii2rZf1SwIj9yMAMa4Pgni3F5IQHii/88Bvb+mGu32E9+zpebL9
 K5/e8QnSsSzKMWugGQBW3sncTKamJ8dSOFLRYsNcE86HMy+aMrlOyozvMH+d/do3LIi2a0
 OMNEmfPZ0O/KO+ZiH7a9zuFmMSEiRa0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-P8qu4R5_PkWHpe0Tv02dAA-1; Fri, 20 Oct 2023 15:40:14 -0400
X-MC-Unique: P8qu4R5_PkWHpe0Tv02dAA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32dd782e2d1so593536f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 12:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697830813; x=1698435613;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m98aXwFFS2G+lbitdNT+qIJvrMvrSTYoVzCY9soDOZs=;
 b=HiF4HmQ3Wz9C/1KXiDLs2VcyPCBHGLMj62zbnk5iHfBjhOYRcUhGc0cBcWKXxUB2x5
 m2G7nDo8Pc8MLkBcbMhyAcoFsZg9b3ZhI6eDvFkuVbSnlb6EK9HPfrgINhFjjLe1PvAR
 8DdZrhQZpJ+D4qj4q9z8z5udEwsaNV2T2oMVQ9VyEZmG9BWK1HuVMPyqmkdDW+aao/gY
 xTwPIZRzRBbnhBwR7GdxTBgLMZWEx7gGzzAhZY7xlYMTU9am+wSmYI+rm421wkwWD86N
 SJ1b9XAMtyEjBul1EgYnprLE1ct2LhaDYa1zGwKN6QT+x2qRCMlCnb3ZX9jilzcm/oT2
 cd7Q==
X-Gm-Message-State: AOJu0YznmRGYc2synZCVCTbR0Z/LPTO8bzPWounWOuwqQw499v4hEcog
 9s8Hy+6EHnEUIYJSkU69lePfukXJH2DFFD+qlhKBOBrBfKQZ5ihmPoVhcmcztZtncyv5JULu1sf
 54JJJMxPgBfX4EOI=
X-Received: by 2002:a5d:52cd:0:b0:32d:9daf:3f8d with SMTP id
 r13-20020a5d52cd000000b0032d9daf3f8dmr2003395wrv.49.1697830813708; 
 Fri, 20 Oct 2023 12:40:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUku3ld377Jmt3LZC/YdquObwxqK5Egux58KxOVF+a/FjXphIkoiJKSJtDF6XkfFjNXO87Lg==
X-Received: by 2002:a5d:52cd:0:b0:32d:9daf:3f8d with SMTP id
 r13-20020a5d52cd000000b0032d9daf3f8dmr2003379wrv.49.1697830813294; 
 Fri, 20 Oct 2023 12:40:13 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 r5-20020a056000014500b0032db4825495sm2293758wrx.22.2023.10.20.12.40.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 12:40:12 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V1 4/4] cpr: reboot mode
In-Reply-To: <2814d5e1-76be-4d4e-a76b-25b2eabd2cfe@oracle.com> (Steven
 Sistare's message of "Fri, 20 Oct 2023 10:09:18 -0400")
References: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
 <1697748466-373230-5-git-send-email-steven.sistare@oracle.com>
 <87mswdzkyj.fsf@secure.mitica>
 <2814d5e1-76be-4d4e-a76b-25b2eabd2cfe@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Fri, 20 Oct 2023 21:40:12 +0200
Message-ID: <875y31yter.fsf@secure.mitica>
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
> On 10/20/2023 5:45 AM, Juan Quintela wrote:
>> Steve Sistare <steven.sistare@oracle.com> wrote:
>>> Add the cpr-reboot migration mode.  Usage:
>>>
>>> $ qemu-system-$arch -monitor stdio ...
>>> QEMU 8.1.50 monitor - type 'help' for more information
>>> (qemu) migrate_set_capability x-ignore-shared on
>>> (qemu) migrate_set_parameter mode cpr-reboot
>>> (qemu) migrate -d file:vm.state
>>> (qemu) info status
>>> VM status: paused (postmigrate)
>>> (qemu) quit
>>>
>>> $ qemu-system-$arch -monitor stdio -incoming defer ...
>>> QEMU 8.1.50 monitor - type 'help' for more information
>>> (qemu) migrate_set_capability x-ignore-shared on
>>> (qemu) migrate_set_parameter mode cpr-reboot
>>> (qemu) migrate_incoming file:vm.state
>>> (qemu) info status
>>> VM status: running
>>>
>>> In this mode, the migrate command saves state to a file, allowing one
>>> to quit qemu, reboot to an updated kernel, and restart an updated version
>>> of qemu.  The caller must specify a migration URI that writes to and reads
>>> from a file.  Unlike normal mode, the use of certain local storage options
>>> does not block the migration, but the caller must not modify guest block
>>> devices between the quit and restart.  The guest RAM memory-backend must
>>> be shared, and the @x-ignore-shared migration capability must be set,
>>> to avoid saving RAM to the file.  Guest RAM must be non-volatile across
>>> reboot, such as by backing it with a dax device, but this is not enforced.
>>> The restarted qemu arguments must match those used to initially start qemu,
>>> plus the -incoming option.
>> 
>> Please, add this message to doc/<somewhere> instead (or additionally) to
>> the commit log.
>> 
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>  qapi/migration.json | 16 +++++++++++++++-
>>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index 184fb78..2d862fa 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -620,9 +620,23 @@
>>>  #
>>>  # @normal: the original form of migration. (since 8.2)
>>>  #
>>> +# @cpr-reboot: The migrate command saves state to a file, allowing one to
>>> +#              quit qemu, reboot to an updated kernel, and restart an updated
>>> +#              version of qemu.  The caller must specify a migration URI
>>> +#              that writes to and reads from a file.  Unlike normal mode,
>>> +#              the use of certain local storage options does not block the
>>> +#              migration, but the caller must not modify guest block devices
>>> +#              between the quit and restart.  The guest RAM memory-backend
>>> +#              must be shared, and the @x-ignore-shared migration capability
>>> +#              must be set, to avoid saving it to the file.  Guest RAM must
>>> +#              be non-volatile across reboot, such as by backing it with
>>> +#              a dax device, but this is not enforced.  The restarted qemu
>>> +#              arguments must match those used to initially start qemu, plus
>>> +#              the -incoming option. (since 8.2)
>>> +#
>>>  ##
>>>  { 'enum': 'MigMode',
>>> -  'data': [ 'normal' ] }
>>> +  'data': [ 'normal', 'cpr-reboot' ] }
>>>  
>>>  ##
>>>  # @BitmapMigrationBitmapAliasTransform:
>> 
>> It only works with file backend, and we don't have any check for that.
>> Wondering how to add that check.
>
> Actually, it works for other backends, but the ram contents are saved in the
> state file, which is slower. I should spell that out in the json comment and
> in the commit message.

Thanks.
>
>> Additionally, you are not adding a migration test that does exactly what
>> you put there in the comment.
>
> I provide tests/avocado/cpr.py in the original long series.  Would you
> like me to add it to this series, or post it later?  Would you prefer I
> add a test to tests/qtest/migration-test.c?

test/qtest/migration-test.c

please.

Something simple like what you say in the commit should be a good start.

Thanks, Juan.


