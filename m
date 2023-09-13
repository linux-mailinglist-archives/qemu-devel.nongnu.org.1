Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6358E79EB11
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 16:29:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgQpv-0005bu-02; Wed, 13 Sep 2023 10:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qgQps-0005bQ-NW
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 10:27:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qgQpq-0000nN-9J
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 10:27:20 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B02AE1F390;
 Wed, 13 Sep 2023 14:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694615236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=orZXRP5h410epfElh9LocOE70vO8CyLMfH6OVMT1C5k=;
 b=BkvrnvsN3s7j2Im68aMDYz537FFKxFNU92lSLHuhS8DUTj2rN073FotGuSuh9H+Urnnja1
 NnGh6HHcNXYtW7JfxBRgWUe93cVRCkrRHK//sCuFjhXwmLOovQ2fzJAQLmz03sVXrWz0Q3
 GJkIQoD6+Jfkm7Gz2qWbwOVXzTF3qIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694615236;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=orZXRP5h410epfElh9LocOE70vO8CyLMfH6OVMT1C5k=;
 b=RbUqhR/AYyrxcef+luOVzA3XvxMnHbb2UhZ9nYeCsHMWLCplWz+Io3y6wTz+Z0rr2vDGMw
 vw6tcOAxUa3CrOBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2BEAB13582;
 Wed, 13 Sep 2023 14:27:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cnuzNsPGAWUBYwAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 13 Sep 2023 14:27:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v2 11/11] tests/migration-test: Add a test for postcopy
 hangs during RECOVER
In-Reply-To: <20230912222145.731099-12-peterx@redhat.com>
References: <20230912222145.731099-1-peterx@redhat.com>
 <20230912222145.731099-12-peterx@redhat.com>
Date: Wed, 13 Sep 2023 11:27:13 -0300
Message-ID: <87wmwujghq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Peter Xu <peterx@redhat.com> writes:

>  
> +static void wait_for_postcopy_status(QTestStatus *one, const char *status)
> +{

QTestState *who

> +    wait_for_migration_status(from, status,

s/from/who

> +                              (const char * []) { "failed", "active",
> +                                                  "completed", NULL });
> +}
> +
> +static void postcopy_recover_fail(QTestState *from, QTestState *to)
> +{
> +    int ret, pair1[2], pair2[2];
> +    char c;
> +
> +    /* Create two unrelated socketpairs */
> +    ret = qemu_socketpair(PF_LOCAL, SOCK_STREAM, 0, pair1);
> +    g_assert_cmpint(ret, ==, 0);
> +
> +    ret = qemu_socketpair(PF_LOCAL, SOCK_STREAM, 0, pair2);
> +    g_assert_cmpint(ret, ==, 0);
> +
> +    /*
> +     * Give the guests unpaired ends of the sockets, so they'll all blocked
> +     * at reading.  This mimics a wrong channel established.
> +     */
> +    qtest_qmp_fds_assert_success(from, &pair1[0], 1,
> +                                 "{ 'execute': 'getfd',"
> +                                 "  'arguments': { 'fdname': 'fd-mig' }}");
> +    qtest_qmp_fds_assert_success(to, &pair2[0], 1,
> +                                 "{ 'execute': 'getfd',"
> +                                 "  'arguments': { 'fdname': 'fd-mig' }}");
> +
> +    /*
> +     * Write the 1st byte as QEMU_VM_COMMAND (0x8) for the dest socket, to
> +     * emulate the 1st byte of a real recovery, but stops from there to
> +     * keep dest QEMU in RECOVER.  This is needed so that we can kick off
> +     * the recover process on dest QEMU (by triggering the G_IO_IN event).
> +     *
> +     * NOTE: this trick is not needed on src QEMUs, because src doesn't
> +     * rely on an pre-existing G_IO_IN event, so it will always trigger the
> +     * upcoming recovery anyway even if it can read nothing.
> +     */
> +#define QEMU_VM_COMMAND              0x08
> +    c = QEMU_VM_COMMAND;
> +    ret = send(pair2[1], &c, 1, 0);
> +    g_assert_cmpint(ret, ==, 1);
> +
> +    migrate_recover(to, "fd:fd-mig");
> +    migrate_qmp(from, "fd:fd-mig", "{'resume': true}");
> +
> +    /*
> +     * Make sure both QEMU instances will go into RECOVER stage, then test
> +     * kicking them out using migrate-pause.
> +     */
> +    wait_for_postcopy_status(from, "postcopy-recover")

semicolon

> +    wait_for_postcopy_status(to, "postcopy-recover");
> +
> +    /*
> +     * This would be issued by the admin upon noticing the hang, we should
> +     * make sure we're able to kick this out.
> +     */
> +    migrate_pause(from);
> +    wait_for_postcopy_status(from, "postcopy-paused");
> +
> +    /* Do the same test on dest */
> +    migrate_pause(to);
> +    wait_for_postcopy_status(to, "postcopy-paused");
> +
> +    close(pair1[0]);
> +    close(pair1[1]);
> +    close(pair2[0]);
> +    close(pair2[1]);
> +}

