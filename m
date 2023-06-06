Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDB2724D23
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 21:35:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6cS0-0006G0-9f; Tue, 06 Jun 2023 15:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q6cRy-0006Fb-76
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:34:38 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q6cRw-0004DV-KJ
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:34:37 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C0A021FD8C;
 Tue,  6 Jun 2023 19:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1686080074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O8gzm4bqt0mEHi4WLCa9RLtHvyf8WKu59gQLASGLlpw=;
 b=hnjR6QXfM3Lam7g6dTIJcwROBeHuPDbWRafnCu2020zlOHg3p02Nj49QDhkE9Kep5l4dwg
 SabZL6GbPJeQntnrob+1gcn3yn1DkwWAWypHus0dl8sVhahBdB6CSa7A9skZuucMaC+3x5
 ssGtI20PleLho8+3sEGBhnqd9L32EG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1686080074;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O8gzm4bqt0mEHi4WLCa9RLtHvyf8WKu59gQLASGLlpw=;
 b=VvJbzexSjlcIbZQfLuLoGm55mei4dBvyOaPIiG0bfeecWvkVoH6zBPu2SdSsipT0+TCh5x
 nvnId5t1Da1Dy9AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 482F113519;
 Tue,  6 Jun 2023 19:34:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VTM/BEqKf2S0FQAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 06 Jun 2023 19:34:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Juan
 Quintela <quintela@redhat.com>, Jiang Jiacheng <jiangjiacheng@huawei.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 1/3] migration/multifd: Rename threadinfo.c functions
In-Reply-To: <ZH99EuY3c/RqIELY@x1n>
References: <20230606144551.24367-1-farosas@suse.de>
 <20230606144551.24367-2-farosas@suse.de> <ZH99EuY3c/RqIELY@x1n>
Date: Tue, 06 Jun 2023 16:34:31 -0300
Message-ID: <87wn0gwfjs.fsf@suse.de>
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Jun 06, 2023 at 11:45:49AM -0300, Fabiano Rosas wrote:
>> The code in threadinfo.c is only used for the QMP command
>> query-migrationthreads. Make it explicit that this is something
>> related to QMP.
>> 
>> The current names are also too generic for a piece of code that
>> doesn't affect the migration directly in any way.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> Looks good here, but shall we reserve the qmp_* prefix to mostly qmp stuff
> only?  Dropping "qmp_" in the new names would look better to me..
>

Well, we're just putting the thread name and id on a list so that QMP
can use them later. It is nothing "important" enough to have a generic
name like migration_thread.

Perhaps:

thread_info_add
thread_info_remove
thread_info_init
thread_info_cleanup

Anyway, as long as we drop that camel case I'm ok with just removing the
qmp =)


