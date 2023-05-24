Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A52A70F66F
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 14:31:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1ndZ-0005d5-FV; Wed, 24 May 2023 08:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q1ndV-0005aV-J1; Wed, 24 May 2023 08:30:37 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q1ndU-0002Ky-3D; Wed, 24 May 2023 08:30:37 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 23E101FE3E;
 Wed, 24 May 2023 12:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1684931433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2FQE7SLwQxkPXQQqUFc2QzpKsHt3Vd3i/46Qw5/j9mQ=;
 b=mPCSmGoVsNWEnL/+R6kJ+nZRoTiUX2LYktvkpoE+xF78dUb8UPQqMUtzk0uybPtoToqYZv
 XdpyUFWrLXF2cTKQ0JjrJukNS2qs2WmmUDcOmujeYTAWdmWClKbJFlL0Mc2boRghv45YTn
 ep6lqTM/SheSUp8aUZQlSa1zIiOKwz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1684931433;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2FQE7SLwQxkPXQQqUFc2QzpKsHt3Vd3i/46Qw5/j9mQ=;
 b=TAGJx9z1DD+OyKPXFHRhCW9PieYpt44hzR+AnRGAGQW1s09e56uB3C7hhCoG996tu9SRDm
 2BJ+nUrhrRrOlzBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A60A413425;
 Wed, 24 May 2023 12:30:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id K0fOG2gDbmTdaAAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 24 May 2023 12:30:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Lin Ma <LMa@suse.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?Q?Jo=C3=A3o?= Silva <jsilva@suse.de>, Claudio
 Fontana <cfontana@suse.de>, Dario Faggioli <dfaggioli@suse.com>, Eric Blake
 <eblake@redhat.com>
Subject: Re: [RFC PATCH 4/6] Convert query-block/info_block to coroutine
In-Reply-To: <AM9PR04MB860233F22701D1A5483216EAC5419@AM9PR04MB8602.eurprd04.prod.outlook.com>
References: <20230523213903.18418-1-farosas@suse.de>
 <20230523213903.18418-5-farosas@suse.de>
 <AM9PR04MB860233F22701D1A5483216EAC5419@AM9PR04MB8602.eurprd04.prod.outlook.com>
Date: Wed, 24 May 2023 09:30:30 -0300
Message-ID: <87fs7loqs9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
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

Lin Ma <LMa@suse.com> writes:

> The commit title/message are duplicated to previous one, Here should
> use "query-named-block-nodes" instead.
>
> Lin
>

Ugh, what a blunder, they're even nicely aligned in the git log. I'll
fix it in the next version.

Thanks!


