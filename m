Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 277838B6D45
	for <lists+qemu-devel@lfdr.de>; Tue, 30 Apr 2024 10:49:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1j9J-0007dj-IC; Tue, 30 Apr 2024 04:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1j9G-0007dA-K8
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 04:47:38 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1j9C-0007A4-Sp
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 04:47:38 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2a2a:0:640:d546:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id D406D60C56;
 Tue, 30 Apr 2024 11:47:29 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8829::1:3c] (unknown
 [2a02:6b8:b081:8829::1:3c])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id SlMU0V11LmI0-0EkxKRql; Tue, 30 Apr 2024 11:47:29 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714466849;
 bh=oa/8nyG6gthUqQrE7eTqBgM2VkG05y5lOXUB2yypLTE=;
 h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
 b=g3oiBC+4xg21xHBEOoUydUz1g4TWTp+2oapDuR0JacZaMEUDiQoAF3i63VDEib17R
 kUCM6Ja0+HorU2UZcnlXcDKA2+abmWzU6fTST/foGolOW6oVEvtODRzVKo/kwtrQof
 HVsL5JDPyTg65jgTg2NMLbd0EBa+H7yNp9S/0CvY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <108e55a9-f891-406d-be9b-43ef2e779651@yandex-team.ru>
Date: Tue, 30 Apr 2024 11:47:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] migration: process_incoming_migration_co(): fix
 reporting s->error
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: Peter Xu <peterx@redhat.com>
Cc: farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org, yc-core@yandex-team.ru
References: <20240429191426.2327225-1-vsementsov@yandex-team.ru>
 <20240429191426.2327225-4-vsementsov@yandex-team.ru> <Zi_15NLonFVFjQQP@x1n>
 <b357680e-d45e-435d-b5d6-8d7c688cf972@yandex-team.ru>
 <4b1f5a9a-fbc0-4430-9fe2-c218fce7c83c@yandex-team.ru>
Content-Language: en-US
In-Reply-To: <4b1f5a9a-fbc0-4430-9fe2-c218fce7c83c@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 30.04.24 11:09, Vladimir Sementsov-Ogievskiy wrote:
> On 30.04.24 11:06, Vladimir Sementsov-Ogievskiy wrote:
>> On 29.04.24 22:32, Peter Xu wrote:
>>> On Mon, Apr 29, 2024 at 10:14:24PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> It's bad idea to leave critical section with error object freed, but
>>>> s->error still set, this theoretically may lead to use-after-free
>>>> crash. Let's avoid it.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>> ---
>>>>   migration/migration.c | 24 ++++++++++++------------
>>>>   1 file changed, 12 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index 0d26db47f7..58fd5819bc 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -732,9 +732,19 @@ static void process_incoming_migration_bh(void *opaque)
>>>>       migration_incoming_state_destroy();
>>>>   }
>>>> +static void migrate_error_free(MigrationState *s)
>>>> +{
>>>> +    QEMU_LOCK_GUARD(&s->error_mutex);
>>>> +    if (s->error) {
>>>> +        error_free(s->error);
>>>> +        s->error = NULL;
>>>> +    }
>>>> +}
>>>> +
>>>>   static void coroutine_fn
>>>>   process_incoming_migration_co(void *opaque)
>>>>   {
>>>> +    MigrationState *s = migrate_get_current();
>>>>       MigrationIncomingState *mis = migration_incoming_get_current();
>>>>       PostcopyState ps;
>>>>       int ret;
>>>> @@ -779,11 +789,9 @@ process_incoming_migration_co(void *opaque)
>>>>       }
>>>>       if (ret < 0) {
>>>> -        MigrationState *s = migrate_get_current();
>>>> -
>>>>           if (migrate_has_error(s)) {
>>>>               WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
>>>> -                error_report_err(s->error);
>>>> +                error_report_err(error_copy(s->error));
>>>
>>> This looks like a bugfix, agreed.
>>>
>>>>               }
>>>>           }
>>>>           error_report("load of migration failed: %s", strerror(-ret));
>>>> @@ -801,6 +809,7 @@ fail:
>>>>                         MIGRATION_STATUS_FAILED);
>>>>       migration_incoming_state_destroy();
>>>> +    migrate_error_free(s);
>>>
>>> Would migration_incoming_state_destroy() be a better place?
>>
>> Hmm. But we want to call migration_incoming_state_destroy() in case when exit-on-error=false too. And in this case we want to keep the error for further query-migrate commands.
> 
> Actually, I think we shouldn't care about freeing the error for exit() case. I think, we skip a lot of other cleanups which we normally do in main() in case of this exit().
> 

Or, just do the simplest fix of potential use-after-free, and don't care:

WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
    error_report_err(s->error);
    s->error = NULL;
}

- I'll send v6 with it.

>>
>>>
>>> One thing weird is we actually reuses MigrationState*'s error for incoming
>>> too, but so far it looks ok as long as QEMU can't be both src & dst.  Then
>>> calling migrate_error_free even in incoming_state_destroy() looks ok.
>>>
>>> This patch still looks like containing two changes.  Better split them (or
>>> just fix the bug only)?
>>>
>>> Thanks,
>>>
>>>>       exit(EXIT_FAILURE);
>>>>   }
>>>> @@ -1433,15 +1442,6 @@ bool migrate_has_error(MigrationState *s)
>>>>       return qatomic_read(&s->error);
>>>>   }
>>>> -static void migrate_error_free(MigrationState *s)
>>>> -{
>>>> -    QEMU_LOCK_GUARD(&s->error_mutex);
>>>> -    if (s->error) {
>>>> -        error_free(s->error);
>>>> -        s->error = NULL;
>>>> -    }
>>>> -}
>>>> -
>>>>   static void migrate_fd_error(MigrationState *s, const Error *error)
>>>>   {
>>>>       assert(s->to_dst_file == NULL);
>>>> -- 
>>>> 2.34.1
>>>>
>>>
>>
> 

-- 
Best regards,
Vladimir


