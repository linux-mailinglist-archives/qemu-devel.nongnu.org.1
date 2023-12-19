Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B417818880
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 14:20:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFZzt-0007ka-Ls; Tue, 19 Dec 2023 08:18:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rFZzs-0007kQ-9H
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 08:18:56 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rFZzq-0003dp-PO
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 08:18:56 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DB8C11FD67;
 Tue, 19 Dec 2023 13:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702991932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9w88mC3yTLak9kL9NIG2krENPYY8xdru479M/7Fo4E0=;
 b=t7/3GwWX8DJtspDCOCj2e3p+uE3g9QEcZGJbqWTEaWbWwNbePS71ImsT+gy+UntT+RnPFs
 MjBPDAc5EijDEYKpPEALTa/YykYlqn20YvCzBAJXtMV8CMz0v+/qIPSJL4b04ea4L5sO2s
 mR4sKdllfofMTEVt+GTyH+S+JI/d6EU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702991932;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9w88mC3yTLak9kL9NIG2krENPYY8xdru479M/7Fo4E0=;
 b=X7ebJxVBBRjD/d1ur/qyz61oruu7aSxcqjbgEDsDfdn5mR9iNy2UlaJGmhyf2A0VT1xnHo
 VM5bPfo81+6nlrDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702991931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9w88mC3yTLak9kL9NIG2krENPYY8xdru479M/7Fo4E0=;
 b=lDlIBiJN4zg4GfTlrcTo1yUuV/1DfHjbK21VUQeL1jfM7FhZ8QcrBY64gRCGYbvnMOTkru
 YUeQKKdIeX/JD4kWqNDCk/wi3K4nXSXGvvQo8zFPGU7aIM5ucYAA8MJvqKKPPAucNxNmKM
 wDEl6i2ykcZz3MSFSv+4F0rguREVEUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702991931;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9w88mC3yTLak9kL9NIG2krENPYY8xdru479M/7Fo4E0=;
 b=tb0MNMUk2fz1d/a79qOw8AMNbvzj6R3NCLE0s3rdkM+MY55W0Vdv5up44+h/FXNDULqJq7
 66SH9kwt+iQ7iFAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6847F136A5;
 Tue, 19 Dec 2023 13:18:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id seUwDDuYgWWRUQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 19 Dec 2023 13:18:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: peter.maydell@linaro.org, quintela@redhat.com, peterx@redhat.com,
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Subject: Re: [External] Re: [PATCH v2 07/20] util/dsa: Implement DSA device
 start and stop logic.
In-Reply-To: <CAAYibXhX1Rw++m47SgOtd3B1zC3fOGCqBuMRTMihPJgm=ZQF1A@mail.gmail.com>
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
 <20231114054032.1192027-8-hao.xiang@bytedance.com>
 <87h6koh1is.fsf@suse.de>
 <CAAYibXhX1Rw++m47SgOtd3B1zC3fOGCqBuMRTMihPJgm=ZQF1A@mail.gmail.com>
Date: Tue, 19 Dec 2023 10:18:48 -0300
Message-ID: <87ttoexrd3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.00)[43.48%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
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

Hao Xiang <hao.xiang@bytedance.com> writes:

>>
>> > +}
>> > +
>> > +void dsa_start(void) {}
>> > +
>> > +void dsa_stop(void) {}
>> > +
>> > +void dsa_cleanup(void) {}
>> > +
>> > +#endif
>>
>> These could all be in the header.
>
> The function definitions are already in dsa.h Do you mean moving the
> function implementations to the header as well?
>

I mean the empty !CONFIG_DSA_OPT variants could be in the header as
static inline.


