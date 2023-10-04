Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD05C7B81C0
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 16:05:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo2UY-0003qa-Gf; Wed, 04 Oct 2023 10:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qo2UW-0003pw-Oi; Wed, 04 Oct 2023 10:04:44 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qo2UU-0006nR-Rk; Wed, 04 Oct 2023 10:04:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 52CE321855;
 Wed,  4 Oct 2023 14:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696428281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gci+VsQJo6i2NjQiY0nCGeiIES/5YTkgy0m2PG7G7q4=;
 b=lU66kDNSMuZ7ECm1btvaQfs9UJmxgtEwg9zwY3C+I4SO1EdtRCa5cwKWTKr59WJwl9uZq8
 GaR3rt8ROmns34mvx9OKLOObAJtACjmNmuSvGSyI1seRS4dN8HJ67ll9/alSPWlvBF5PQN
 ouLGdIQD2Ez2BKkMvKBViuWJjz+QsAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696428281;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gci+VsQJo6i2NjQiY0nCGeiIES/5YTkgy0m2PG7G7q4=;
 b=noYb2ycw3nq3jGjuPd44FXGsJiIzjh/bcvKCDnAyiQDcTzXWqQXuKul4DXxhXV+BBR/ZZ7
 NMgwOxzadODiMtCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA907139F9;
 Wed,  4 Oct 2023 14:04:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gYwdKfhwHWVcbAAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 04 Oct 2023 14:04:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Leonardo Bras <leobras@redhat.com>, Peter Xu
 <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>, Li Zhijian
 <lizhijian@fujitsu.com>, qemu-s390x@nongnu.org, Steve Sistare
 <steven.sistare@oracle.com>, Michael Galaxy <mgalaxy@akamai.com>,
 =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PULL 09/11] migration: file URI
In-Reply-To: <87cyxu33fp.fsf@secure.mitica>
References: <20231004124038.16002-1-quintela@redhat.com>
 <20231004124038.16002-10-quintela@redhat.com> <87y1gi4i32.fsf@suse.de>
 <87cyxu33fp.fsf@secure.mitica>
Date: Wed, 04 Oct 2023 11:04:38 -0300
Message-ID: <87o7hepjpl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Juan Quintela <quintela@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> wrote:
>> Juan Quintela <quintela@redhat.com> writes:
>>
>>> From: Steve Sistare <steven.sistare@oracle.com>
>>>
>>> Extend the migration URI to support file:<filename>.  This can be used =
for
>>> any migration scenario that does not require a reverse path.  It can be
>>> used as an alternative to 'exec:cat > file' in minimized containers that
>>> do not contain /bin/sh, and it is easier to use than the fd:<fdname> UR=
I.
>>> It can be used in HMP commands, and as a qemu command-line parameter.
>>>
>>> For best performance, guest ram should be shared and x-ignore-shared
>>> should be true, so guest pages are not written to the file, in which ca=
se
>>> the guest may remain running.  If ram is not so configured, then the us=
er
>>> is advised to stop the guest first.  Otherwise, a busy guest may re-dir=
ty
>>> the same page, causing it to be appended to the file multiple times,
>>> and the file may grow unboundedly.  That issue is being addressed in the
>>> "fixed-ram" patch series.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> Tested-by: Michael Galaxy <mgalaxy@akamai.com>
>>> Reviewed-by: Michael Galaxy <mgalaxy@akamai.com>
>>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>> Message-ID: <1694182931-61390-2-git-send-email-steven.sistare@oracle.co=
m>
>>
>> Juan, FYI we have tests for this feature already reviewed and ready to
>> merge:
>>
>> [PATCH v5 0/6] migration: Test the new "file:" migration
>> https://lore.kernel.org/r/20230712190742.22294-1-farosas@suse.de
>
> I searched for URI and didn't found it.
>
> Will got it on next PULL request.

Do you want me to do resend? It's no big deal.

