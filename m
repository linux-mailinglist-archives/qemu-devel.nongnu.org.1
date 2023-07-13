Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A0F75234C
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 15:19:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJwDk-0002bo-Ap; Thu, 13 Jul 2023 09:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qJwDV-0002bc-Vy
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 09:18:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qJwDU-0004wj-7E
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 09:18:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B78981FD88;
 Thu, 13 Jul 2023 13:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1689254321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8KoG0O7kibShKQ4/Tn1cHGuAG5nc9iywqYJ8hmF4lIQ=;
 b=UeFQCNas6HadDXi28I6kKF86i4C5UbTXeBBGC/su/ACE3sTFgmjhHGjMRzT8y11SJr/Puy
 OWX216CRdkaiJZiIE5ifZmf1f0ff4cdtS0wAbYNU0OL9P3Dmnc/wb0ISnemzR0s/knHFvR
 UlPHt/R+2b8ixsEpVuAHuKi0NWTaaPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1689254321;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8KoG0O7kibShKQ4/Tn1cHGuAG5nc9iywqYJ8hmF4lIQ=;
 b=Xy8UWwdsdTrtIkXPkbupw5RlMNfayJqOqGZ8p2MhkQAjZ4X0ev/wXS12YkYQjiWo9vRH6n
 l78PWAbvvUPpiLAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 492FA13489;
 Thu, 13 Jul 2023 13:18:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HDhvBbH5r2S+RgAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 13 Jul 2023 13:18:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Peter Xu
 <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 2/2] migration: Make it clear that qemu_file_set_error()
 needs a negative value
In-Reply-To: <CAFEAcA-_VD5w5ubznavt+5F6q9_LzhmmVFQyEwCj7JYSuxOXbg@mail.gmail.com>
References: <20230706195201.18595-1-farosas@suse.de>
 <20230706195201.18595-3-farosas@suse.de>
 <CAFEAcA-_VD5w5ubznavt+5F6q9_LzhmmVFQyEwCj7JYSuxOXbg@mail.gmail.com>
Date: Thu, 13 Jul 2023 10:18:38 -0300
Message-ID: <87v8eogdap.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 6 Jul 2023 at 20:52, Fabiano Rosas <farosas@suse.de> wrote:
>>
>> The convention in qemu-file.c is to return a negative value on
>> error.
>>
>> The only place that could use qemu_file_set_error() to store a
>> positive value to f->last_error was vmstate_save() which has been
>> fixed in the previous patch.
>>
>> bdrv_inactivate_all() already returns a negative value on error.
>>
>> Document that qemu_file_set_error() needs -errno and alter the callers
>> to check ret < 0.
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/qemu-file.c | 2 ++
>>  migration/savevm.c    | 6 +++---
>>  2 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
>> index acc282654a..8276bac248 100644
>> --- a/migration/qemu-file.c
>> +++ b/migration/qemu-file.c
>> @@ -222,6 +222,8 @@ int qemu_file_get_error(QEMUFile *f)
>>
>>  /*
>>   * Set the last error for stream f
>> + *
>> + * The error ('ret') should be in -errno format.
>>   */
>>  void qemu_file_set_error(QEMUFile *f, int ret)
>>  {
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 95c2abf47c..f3c303ab74 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -1249,7 +1249,7 @@ void qemu_savevm_state_setup(QEMUFile *f)
>>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>>          if (se->vmsd && se->vmsd->early_setup) {
>>              ret = vmstate_save(f, se, ms->vmdesc);
>> -            if (ret) {
>> +            if (ret < 0) {
>>                  qemu_file_set_error(f, ret);
>
> You say qemu_file_set_error() should take an errno,
> but vmstate_save() doesn't return one. It will directly
> return whatever the VMStateInfo put, pre_save, etc hooks
> return, which isn't necessarily an errno. (Specifically,
> patch 1 in this series makes a .put hook return -1,
> rather than an errno. I'm guessing other implementations
> might too, though it's a bit hard to find them. A
> coccinelle script could probably locate them.)
>

All implementations return either 0, -1 or some errno; that one instance
from patch 1 returns 1. But you're right, those -1 are not really errno,
they are just "some negative value".

Since qemu-file.c puts the error through the error.c functions and those
call strerror(), all values that will go into qemu_file_set_error()
should be proper errnos.

I should probably audit users of qemu_file_set_error() instead and stop
using it for errors that have nothing to do with the actual migration
stream/QEMUFile. Currently it seems to have morphed into a mechanism to
record generic migration errors.

