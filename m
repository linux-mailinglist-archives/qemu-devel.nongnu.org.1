Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3827980A956
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 17:38:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBdra-00010v-Hr; Fri, 08 Dec 2023 11:38:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rBdrZ-0000xg-5A
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 11:38:05 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rBdrX-0004l8-95
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 11:38:04 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B36281F454;
 Fri,  8 Dec 2023 16:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702053481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xtanU/vKe3IMXQVWSQDbAx0/JJc8VM9p3fj1fcJmgIk=;
 b=lVym1ZYHj8BJ8Nq58q11bdD1JndsMD0Ap3dcLQ78aXRZlzpNfkiuXNl2uQy2q9rSibbNKa
 UH6ieCiOQgyPyX3JTUtoM05JOlWqv7maZ2YCslhrvBGkThJzldKddmZTep8vrO+KeZSdva
 bACEt7Bv7q1HpOI0onuGUX6uyiSuKEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702053481;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xtanU/vKe3IMXQVWSQDbAx0/JJc8VM9p3fj1fcJmgIk=;
 b=hEav//9sFRVqznO/MdyCEkr43f8H8wHx2H9SDaM+Y5H8zCQJ/DRY1RGZVBg2A5OlROL+Vf
 0kOOrGFP/bGYGxDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702053481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xtanU/vKe3IMXQVWSQDbAx0/JJc8VM9p3fj1fcJmgIk=;
 b=lVym1ZYHj8BJ8Nq58q11bdD1JndsMD0Ap3dcLQ78aXRZlzpNfkiuXNl2uQy2q9rSibbNKa
 UH6ieCiOQgyPyX3JTUtoM05JOlWqv7maZ2YCslhrvBGkThJzldKddmZTep8vrO+KeZSdva
 bACEt7Bv7q1HpOI0onuGUX6uyiSuKEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702053481;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xtanU/vKe3IMXQVWSQDbAx0/JJc8VM9p3fj1fcJmgIk=;
 b=hEav//9sFRVqznO/MdyCEkr43f8H8wHx2H9SDaM+Y5H8zCQJ/DRY1RGZVBg2A5OlROL+Vf
 0kOOrGFP/bGYGxDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E0E412FF7;
 Fri,  8 Dec 2023 16:38:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dn/2AWlGc2UPDwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 08 Dec 2023 16:38:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V7 11/12] tests/qtest: precopy migration with suspend
In-Reply-To: <1701883417-356268-12-git-send-email-steven.sistare@oracle.com>
References: <1701883417-356268-1-git-send-email-steven.sistare@oracle.com>
 <1701883417-356268-12-git-send-email-steven.sistare@oracle.com>
Date: Fri, 08 Dec 2023 13:37:58 -0300
Message-ID: <87ttosy7ix.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -0.33
X-Spamd-Result: default: False [-0.33 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.03)[56.47%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[9];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -0.33
Authentication-Results: smtp-out2.suse.de;
	none
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Add a test case to verify that the suspended state is handled correctly
> during live migration precopy.  The test suspends the src, migrates, then
> wakes the dest.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>


