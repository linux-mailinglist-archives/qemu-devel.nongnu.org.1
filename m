Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8E58D6518
	for <lists+qemu-devel@lfdr.de>; Fri, 31 May 2024 17:02:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD3lN-0005r6-W0; Fri, 31 May 2024 11:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sD3lL-0005qy-7N
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:01:47 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sD3lJ-0003kM-JI
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:01:46 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 177EF1FB5E;
 Fri, 31 May 2024 15:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717167704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kgxj5qQtABfspQi0kIEMIHkMTWNiMQSr0NWSOIyO8ZA=;
 b=DTrB42AgP7rt5oanO55wgj7kw/Ih21hh7qZgoDqo1rWEwQi6PUJDE+OSFniotcb437j/ru
 hcuE/ulX/UJrQ0X6ozobh/oBQIKYHPHQTqQ8FPP3TLPIDO3zioHemN2hf7GR15/3u0L5iO
 gK08LecXHoU+LfV4MgaucfdtFtWwnjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717167704;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kgxj5qQtABfspQi0kIEMIHkMTWNiMQSr0NWSOIyO8ZA=;
 b=wDT/ndO8PnKATlJbrnHQ/CXKR1CWVlTcleLo87bkpJql9Vy3LRddUcIuccBbsN3vjtRal3
 RZO3EmC3Suux/XDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717167704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kgxj5qQtABfspQi0kIEMIHkMTWNiMQSr0NWSOIyO8ZA=;
 b=DTrB42AgP7rt5oanO55wgj7kw/Ih21hh7qZgoDqo1rWEwQi6PUJDE+OSFniotcb437j/ru
 hcuE/ulX/UJrQ0X6ozobh/oBQIKYHPHQTqQ8FPP3TLPIDO3zioHemN2hf7GR15/3u0L5iO
 gK08LecXHoU+LfV4MgaucfdtFtWwnjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717167704;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kgxj5qQtABfspQi0kIEMIHkMTWNiMQSr0NWSOIyO8ZA=;
 b=wDT/ndO8PnKATlJbrnHQ/CXKR1CWVlTcleLo87bkpJql9Vy3LRddUcIuccBbsN3vjtRal3
 RZO3EmC3Suux/XDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92C2B137C3;
 Fri, 31 May 2024 15:01:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FwlJFlfmWWY3AwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 31 May 2024 15:01:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Claudio
 Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH v2 05/18] monitor: Introduce monitor_fdset_*free
In-Reply-To: <Zljbptai4sXq4Ai5@x1n>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-6-farosas@suse.de> <Zljbptai4sXq4Ai5@x1n>
Date: Fri, 31 May 2024 12:01:41 -0300
Message-ID: <87r0dikotm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Score: -4.30
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, May 23, 2024 at 04:05:35PM -0300, Fabiano Rosas wrote:
>> Introduce two new functions to remove and free no longer used fds and
>> fdsets.
>> 
>> We need those to decouple the remove/free routines from
>> monitor_fdset_cleanup() which will go away in the next patches.
>> 
>> The new functions:
>> 
>> - monitor_fdset_free() will be used when a monitor connection closes
>>   and when an fd is removed to cleanup any fdset that is now empty.
>> 
>> - monitor_fdset_fd_free() will be used to remove one or more fds that
>>   have been explicitly targeted by qmp_remove_fd().
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> One nitpick below.
>
>> ---
>>  monitor/fds.c | 26 ++++++++++++++++++--------
>>  1 file changed, 18 insertions(+), 8 deletions(-)
>> 
>> diff --git a/monitor/fds.c b/monitor/fds.c
>> index fb9f58c056..101e21720d 100644
>> --- a/monitor/fds.c
>> +++ b/monitor/fds.c
>> @@ -167,6 +167,22 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
>>      return -1;
>>  }
>>  
>> +static void monitor_fdset_free(MonFdset *mon_fdset)
>> +{
>> +    if (QLIST_EMPTY(&mon_fdset->fds) && QLIST_EMPTY(&mon_fdset->dup_fds)) {
>> +        QLIST_REMOVE(mon_fdset, next);
>> +        g_free(mon_fdset);
>> +    }
>> +}
>
> Would monitor_fdset_free_if_empty() (or similar) slightly better?

Yes, I'll use that.

>
> static void monitor_fdset_free(MonFdset *mon_fdset)
> {
>     QLIST_REMOVE(mon_fdset, next);
>     g_free(mon_fdset);
> }
>
> static void monitor_fdset_free_if_empty(MonFdset *mon_fdset)
> {
>     if (QLIST_EMPTY(&mon_fdset->fds) && QLIST_EMPTY(&mon_fdset->dup_fds)) {
>         monitor_fdset_free(mon_fdset);
>     }
> }
>
>> +
>> +static void monitor_fdset_fd_free(MonFdsetFd *mon_fdset_fd)
>> +{
>> +    close(mon_fdset_fd->fd);
>> +    g_free(mon_fdset_fd->opaque);
>> +    QLIST_REMOVE(mon_fdset_fd, next);
>> +    g_free(mon_fdset_fd);
>> +}
>> +
>>  static void monitor_fdset_cleanup(MonFdset *mon_fdset)
>>  {
>>      MonFdsetFd *mon_fdset_fd;
>> @@ -176,17 +192,11 @@ static void monitor_fdset_cleanup(MonFdset *mon_fdset)
>>          if ((mon_fdset_fd->removed ||
>>                  (QLIST_EMPTY(&mon_fdset->dup_fds) && mon_refcount == 0)) &&
>>                  runstate_is_running()) {
>> -            close(mon_fdset_fd->fd);
>> -            g_free(mon_fdset_fd->opaque);
>> -            QLIST_REMOVE(mon_fdset_fd, next);
>> -            g_free(mon_fdset_fd);
>> +            monitor_fdset_fd_free(mon_fdset_fd);
>>          }
>>      }
>>  
>> -    if (QLIST_EMPTY(&mon_fdset->fds) && QLIST_EMPTY(&mon_fdset->dup_fds)) {
>> -        QLIST_REMOVE(mon_fdset, next);
>> -        g_free(mon_fdset);
>> -    }
>> +    monitor_fdset_free(mon_fdset);
>>  }
>>  
>>  void monitor_fdsets_cleanup(void)
>> -- 
>> 2.35.3
>> 

