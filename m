Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 425EB749DA4
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 15:29:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHP2W-00040q-Bk; Thu, 06 Jul 2023 09:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qHP1w-0003t3-3f; Thu, 06 Jul 2023 09:28:24 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qHP1s-0001wQ-Tj; Thu, 06 Jul 2023 09:28:19 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4F59312092;
 Thu,  6 Jul 2023 16:28:07 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id AC287133B3;
 Thu,  6 Jul 2023 16:28:06 +0300 (MSK)
Message-ID: <33088999-cc41-7dd6-b522-84af01913172@tls.msk.ru>
Date: Thu, 6 Jul 2023 16:28:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] migration: factor out "resume_requested" in
 qmp_migrate()
Content-Language: en-US
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-trivial@nongnu.org
References: <20230706102937.82490-1-lersek@redhat.com>
 <20230706102937.82490-2-lersek@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230706102937.82490-2-lersek@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

06.07.2023 13:29, Laszlo Ersek пишет:
> It cuts back on those awkward, duplicated !(has_resume && resume)
> expressions.
> 
> Cc: Juan Quintela <quintela@redhat.com> (maintainer:Migration)
> Cc: Leonardo Bras <leobras@redhat.com> (reviewer:Migration)
> Cc: Peter Xu <peterx@redhat.com> (reviewer:Migration)
> Cc: qemu-trivial@nongnu.org
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2018404
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>   migration/migration.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 096e8191d15c..a60a5acee533 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1637,6 +1637,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>                    bool has_inc, bool inc, bool has_detach, bool detach,
>                    bool has_resume, bool resume, Error **errp)
>   {
> +    bool resume_requested;
>       Error *local_err = NULL;
>       MigrationState *s = migrate_get_current();
>       const char *p = NULL;
> @@ -1646,13 +1647,14 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>           return;
>       }
>   
> +    resume_requested = has_resume && resume;

Dunno if it's worth it or cleaner, but it can be reduced to

       if (!has_resume)  resume = false;

and checking for only resume below this point.
In other words, there's no need for an additional local var.

All other params (has_inc & inc, has_detach_detach etc) are like this
too.

Anyway,

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

/mjt

