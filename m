Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B27B7AB582
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 18:07:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjiZI-0001EX-SM; Fri, 22 Sep 2023 11:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qjiZG-0001Cy-RZ
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:59:46 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qjiZC-000642-01
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:59:46 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4F50D1FF31;
 Fri, 22 Sep 2023 15:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695398380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lhq6Obx8enQWJ7M2NQgaYrYo62umeTcVcFclKmLFyCk=;
 b=EQ0GpO9EZBF2fgjA8i3vaOd26JNvT6Yliz9rhyDkmEl9MQH46fnSa54BQeCaq34pyGYIBf
 7mDlJwIA/FJ3yQUfJ8Cx+PDOLQoaH9/O9vuuYd41770jOTBcCRLmDsTCpPH0jgwkNKyDdR
 3PJUxmpXRVvGemxdZJ8OImvExFPIHT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695398380;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lhq6Obx8enQWJ7M2NQgaYrYo62umeTcVcFclKmLFyCk=;
 b=fPmVxtcoy2ooOpXNUwbhn4PbkP7++HV1bSK0Sfjz8DEwTkNYvM95Ft2xwEeEWpVnKub8YR
 K0b8ACRgSM6LcvBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5C5613597;
 Fri, 22 Sep 2023 15:59:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HE/sJ+u5DWUgLAAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 22 Sep 2023 15:59:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>
Cc: quintela@redhat.com, leobras@redhat.com, qemu-devel@nongnu.org, Li
 Zhijian <lizhijian@cn.fujitsu.com>
Subject: Re: [PATCH 1/2] migration: Fix rdma migration failed
In-Reply-To: <ZQ210LoAWDIJ5l9J@x1n>
References: <20230920090412.726725-1-lizhijian@fujitsu.com>
 <ZQ210LoAWDIJ5l9J@x1n>
Date: Fri, 22 Sep 2023 12:59:37 -0300
Message-ID: <87ediqmc5y.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On Wed, Sep 20, 2023 at 05:04:11PM +0800, Li Zhijian wrote:
>> From: Li Zhijian <lizhijian@cn.fujitsu.com>
>> 
>> Destination will fail with:
>> qemu-system-x86_64: rdma: Too many requests in this message (3638950032).Bailing.
>> 
>> migrate with RDMA is different from tcp. RDMA has its own control
>> message, and all traffic between RDMA_CONTROL_REGISTER_REQUEST and
>> RDMA_CONTROL_REGISTER_FINISHED should not be disturbed.
>> 
>> find_dirty_block() will be called during RDMA_CONTROL_REGISTER_REQUEST
>> and RDMA_CONTROL_REGISTER_FINISHED, it will send a extra traffic to
>> destination and cause migration to fail.
>> 
>> Since there's no existing subroutine to indicate whether it's migrated
>> by RDMA or not, and RDMA is not compatible with multifd, we use
>> migrate_multifd() here.
>> 
>> Fixes: 294e5a4034 ("multifd: Only flush once each full round of memory")
>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>> ---
>>  migration/ram.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 9040d66e61..89ae28e21a 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -1399,7 +1399,8 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
>>          pss->page = 0;
>>          pss->block = QLIST_NEXT_RCU(pss->block, next);
>>          if (!pss->block) {
>> -            if (!migrate_multifd_flush_after_each_section()) {
>> +            if (migrate_multifd() &&
>> +                !migrate_multifd_flush_after_each_section()) {
>>                  QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
>>                  int ret = multifd_send_sync_main(f);
>>                  if (ret < 0) {
>> -- 
>> 2.31.1
>> 
>
> Maybe better to put that check at the entry of
> migrate_multifd_flush_after_each_section()?
>
> I also hope that some day there's no multifd function called in generic
> migration code paths..

I wonder what happened with that MigrationOps idea. We added the
ram_save_target_page pointer and nothing else. It seems like it could be
something in the direction of allowing different parts of the migration
code to provide different behavior without having to put these explicit
checks all over the place.

And although we're removing the QEMUFile hooks, those also looked like
they could help mitigate these cross-layer interactions. (I'm NOT
advocating bringing them back).

