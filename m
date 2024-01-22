Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADC1837387
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 21:09:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS0ai-0002tG-4p; Mon, 22 Jan 2024 15:08:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rS0ag-0002rI-1F
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 15:08:18 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rS0ae-00054s-Hp
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 15:08:17 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DA6F121FEC;
 Mon, 22 Jan 2024 20:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705954093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kMK3u/Ow2Jl/6cLV4GVtGE4n/rFGRyIl01JTeDW7kUc=;
 b=X4ra5plxvy5tpaqPTomx9a364jSffsAJGEaF+btxqurSmAs7jQfhBB3oFz9EVXU0VnzOBt
 5iVcBbNDOJYhlDF7wdPXgQoFv65C9EmlMKWKvPF2A4ygjgmjGEnO+2vpWhWKM/Ox6gKOdF
 CTW8KpU8uoNiMnsxj/inUusWe/EltWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705954093;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kMK3u/Ow2Jl/6cLV4GVtGE4n/rFGRyIl01JTeDW7kUc=;
 b=PQe6xE5FUnQruz6/kK9Fu7X/871vp8lIIFkvCYmU6dqutRXLcfdpzI/KqJQ7cuiMQtF8fZ
 fNlvV35FyuN0SiDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705954092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kMK3u/Ow2Jl/6cLV4GVtGE4n/rFGRyIl01JTeDW7kUc=;
 b=ehSZqj0gHYetabaoL07WPhHds4AvC31JaxiuoV8ZhTF6hHBZ0CEsoZSJyQqxpBiyy5JgJ2
 X0N4NOdU4HtE3pRylwwUH4aiqRy8JvA0DmGea3liv+WFaiun8JlUtfFHsKAuWafXcHOvRU
 jiq+9LXbunXd57t3LBEdv1AZL7rKizs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705954092;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kMK3u/Ow2Jl/6cLV4GVtGE4n/rFGRyIl01JTeDW7kUc=;
 b=z0U0Q+Yt+4oLo1A6vaRpGKBgFuA8ekziCo5C9MalJtNY7rtyEfYFar9h174lOBSBKcy4vu
 w7CFw6H3baypDDBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61ED313995;
 Mon, 22 Jan 2024 20:08:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MMybCizLrmVRPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 22 Jan 2024 20:08:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Lukas Straub <lukasstraub2@web.de>, Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH v6 08/10] migration/yank: Use channel features
In-Reply-To: <ZQIV9RZFS0soEOJ4@x1n>
References: <20230911171320.24372-1-farosas@suse.de>
 <20230911171320.24372-9-farosas@suse.de> <ZQIV9RZFS0soEOJ4@x1n>
Date: Mon, 22 Jan 2024 17:08:09 -0300
Message-ID: <87il3lgmhi.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -1.35
X-Spamd-Result: default: False [-1.35 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.05)[59.84%];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FREEMAIL_ENVRCPT(0.00)[web.de]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[nongnu.org,web.de,redhat.com];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

> On Mon, Sep 11, 2023 at 02:13:18PM -0300, Fabiano Rosas wrote:
>> Stop using outside knowledge about the io channels when registering
>> yank functions. Query for features instead.
>> 
>> The yank method for all channels used with migration code currently is
>> to call the qio_channel_shutdown() function, so query for
>> QIO_CHANNEL_FEATURE_SHUTDOWN. We could add a separate feature in the
>> future for indicating whether a channel supports yanking, but that
>> seems overkill at the moment.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Hi Peter, this one has fell through the cracks, think we could merge it?

