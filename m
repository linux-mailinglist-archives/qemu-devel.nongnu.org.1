Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3056F73B8AB
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 15:21:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgiU-0004Vv-Nr; Fri, 23 Jun 2023 09:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qCgiP-0004Ub-GE; Fri, 23 Jun 2023 09:20:41 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qCgiN-0008JT-VL; Fri, 23 Jun 2023 09:20:41 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 05A0A1F74A;
 Fri, 23 Jun 2023 13:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1687526437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j+IJ8jtLwuqSOHP4C2S0eixdjy6SYqxysCvXn2iIuPo=;
 b=GrZ98AWc7fxQS+KcLR6+PX/xU5dEkYuGxaS/KaDcazfLW9u/Tap/74F3sU3/AsuU2QpMV7
 vP1N9KF5Xm+GQTwKAlsMAnhlYs3HdInMrlt6owzdNHGiqzXWuWcfaQBBQY8Kn/2THdMeF8
 B3OJSN5veuJrNVxJiqEGMdm6M6Bhx3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1687526437;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j+IJ8jtLwuqSOHP4C2S0eixdjy6SYqxysCvXn2iIuPo=;
 b=FG/RQqXT5+jB1jGEM8xZsXonnotRI9zWWv3kTRa9wGtLAGEJ3s5ALgPUmyGXxS/fF90JLw
 hyV22oHiyeSKsNCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B6CB1331F;
 Fri, 23 Jun 2023 13:20:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iN2FFSSclWQoSgAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 23 Jun 2023 13:20:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org, Christophe
 Leroy <christophe.leroy@csgroup.eu>, BALATON Zoltan <balaton@eik.bme.hu>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Daniel Henrique Barboza
 <danielhb413@gmail.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 3/4] target/ppc: Move common check in machne check
 handlers to a function
In-Reply-To: <20230623081953.290875-4-npiggin@gmail.com>
References: <20230623081953.290875-1-npiggin@gmail.com>
 <20230623081953.290875-4-npiggin@gmail.com>
Date: Fri, 23 Jun 2023 10:20:34 -0300
Message-ID: <87edm2s4bh.fsf@suse.de>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> From: BALATON Zoltan <balaton@eik.bme.hu>
>
> All powerpc exception handlers share some code when handling machine
> check exceptions. Move this to a common function.
>

Maybe Machine Check is simple enough, but this kind of sharing of code
has historically caused pain when people want to change something for
the modern cpus and end up affecting the old cpus by mistake.

There is also the inverse scenario where someone has access to the old
HW and just want to make an one-off contribution, but the community gets
insecure about it because it could also affect the new cpus.

Then comes the obvious "solution" which is to bring in an artificial
identifier (excp. model) to be able to have conditional code inside the
common function. And that causes problems because no one really knows
how it maps to actual hardware/ISA.

No objection, just a little cautionary tale. =)

