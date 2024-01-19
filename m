Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FDE8329FD
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 14:03:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQoVc-0000kE-Rx; Fri, 19 Jan 2024 08:02:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQoVF-0000ek-Mr
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 08:01:48 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQoVC-0008Si-TH
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 08:01:45 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3D75A1F7F1;
 Fri, 19 Jan 2024 13:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705669296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DI6YYq69+mwlAJzC5mXHVPYbi+VXUzLQxR+EMkOPCZc=;
 b=x6N8Zy8RUsYLpaqdymXRuol97woQZou5j3lu+lzEdsnAkMOQYqHq5Kym0nPuy8WBLm38Ed
 bUXQp76hgVMZj/129AAGkbrXLAsTbuuTa1S4g9CWIF5MX5w7FV6pUMuQr8Ob2wrEVmJzg/
 NQLaO+qe2v7hPUx/yoKDIWZeSpEb3jA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705669296;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DI6YYq69+mwlAJzC5mXHVPYbi+VXUzLQxR+EMkOPCZc=;
 b=yiY6Z5jHc2bOrLi2jWy+xYXNCkchJEO0szUe65dlPEaaGl/T+Vp+v+nmydiXrzuFGGrhJE
 KJz4IgwRUMARUHCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705669295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DI6YYq69+mwlAJzC5mXHVPYbi+VXUzLQxR+EMkOPCZc=;
 b=yoAt73l0LIVXunERTjDsd6LughdF5tvNkS1N/HQdFT4Q1620DatrLRMcglwl9aYthOOepj
 bPMiTzj5R8vydbRyqTKWDan1exJMN22Rnx/Sg44ngtEZn1C7IDM1bkX6FK1r1y+R1sp4lF
 9QMOd+OCLT57VrI4b5KyoQROaayfdRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705669295;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DI6YYq69+mwlAJzC5mXHVPYbi+VXUzLQxR+EMkOPCZc=;
 b=+fT6eb7yHznYxgrd+QoWSXoXLJc8Pxaa9hTJWWgwme23nvmd4ZdGx9ypQVcmonXEZh/PzS
 XbeRIMBp9vvX4lAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA2DE136F5;
 Fri, 19 Jan 2024 13:01:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SMW7Hq5yqmWDFQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 19 Jan 2024 13:01:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>
Subject: Re: [PATCH v4 0/3] migration & CI: Add a CI job for migration
 compat testing
In-Reply-To: <Zao8whp3WCWOPb-9@x1n>
References: <20240118164951.30350-1-farosas@suse.de> <Zao8whp3WCWOPb-9@x1n>
Date: Fri, 19 Jan 2024 10:01:31 -0300
Message-ID: <87v87pzdck.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.00)[41.15%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> Fabiano,
>
> On Thu, Jan 18, 2024 at 01:49:48PM -0300, Fabiano Rosas wrote:
>> Here's the second half of adding a migration compatibility test to CI.
>> 
>> We've already added support for running the full set of migration
>> tests with two QEMU binaries since commit 5050ad2a380
>> ("tests/qtest/migration: Support more than one QEMU binary"), now
>> what's left is adding it to the CI.
>> 
>> changes since v3:
>> 
>> - Removed all the 'since' logic and started using the n-1 version of
>>   the tests.
>> 
>> - New patch to fix the aarch64 cpu. We shouldn't have been using
>>   'max'.
>> 
>> - New patch to disable aarch64 tests while the fix^ doesn't reach a
>>   released version.
>> 
>> v3:
>> https://lore.kernel.org/r/20240105180449.11562-1-farosas@suse.de
>> v2:
>> https://lore.kernel.org/r/20240104171857.20108-1-farosas@suse.de
>> v1:
>> https://lore.kernel.org/r/20231207155809.25673-1-farosas@suse.de
>
> I gave it a try but build-previous-qemu somehow failed..
>
>   https://gitlab.com/peterx/qemu/-/jobs/5965634871
>
> You normally attach a "CI run" which I wanted to reference, but it's gone
> in this v4 unfortunately.  The error:
>
>   error: pathspec 'v8.2.0' did not match any file(s) known to git

I mentioned this at the bottom of the commit message for patch 2/3. You
need to push your tags. Otherwise your fork on gitlab won't have
knowledge of v8.2.0.

