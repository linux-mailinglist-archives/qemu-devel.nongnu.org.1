Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8047A0FA0
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 23:14:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgteb-0007YC-20; Thu, 14 Sep 2023 17:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qgteY-0007Xl-U0
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 17:13:34 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qgteX-0006Q1-E4
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 17:13:34 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3C51E1F74C;
 Thu, 14 Sep 2023 21:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694726008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b3kaPKrs3Qnq2/jqpkd29Gj5VRFXY/HG4O8Qxstew54=;
 b=u1U1SzJESKxcoz4xrJ47Hvpxu7yj3FjufNC5R01WtPtH0oZkEZ9cYhKz+Jo0NwM5POmJ5a
 TQF+7AtwhpueAjOAK+iSQm11GiuJRIrcC1eApjbq3XBfBVt4jLD9pOWdh7DXhDGyBP3s1U
 Bxduq7WcWUj1LKaKJcrbyDbR1s/+oHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694726008;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b3kaPKrs3Qnq2/jqpkd29Gj5VRFXY/HG4O8Qxstew54=;
 b=xv/t4Ov/AP7Q4+3s3fuTliMVMUhjs6FQML7l3ZXU8KlBHSfPZKWg+tF7zhGDwj+/poBs7y
 tdmfC/Am5VmUE3BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AACE1139DB;
 Thu, 14 Sep 2023 21:13:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jobvGXd3A2VVKQAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 14 Sep 2023 21:13:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: QEMU migration-test CI intermittent failure
In-Reply-To: <ZQM3SV4eqSltoQSe@x1n>
References: <20230913192301.GA917052@fedora> <87r0n1kggo.fsf@suse.de>
 <ZQMfIO3oiqTsawtU@x1n> <87edj0kcz7.fsf@suse.de> <ZQMoUzRH1BZKs39g@x1n>
 <87bke4kasr.fsf@suse.de> <ZQM3SV4eqSltoQSe@x1n>
Date: Thu, 14 Sep 2023 18:13:24 -0300
Message-ID: <87led8e9vv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
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

> On Thu, Sep 14, 2023 at 12:57:08PM -0300, Fabiano Rosas wrote:
>> I managed to reproduce it. It's not the return path error. In hindsight
>> that's obvious because that error happens in the 'recovery' test and this
>> one in the 'plain' one. Sorry about the noise.
>
> No worry.  It's good to finally identify that.
>
>> 
>> This one reproduced with just 4 iterations of preempt/plain. I'll
>> investigate.

It seems that we're getting a tcp disconnect (ECONNRESET) on when doing
that shutdown() on postcopy_qemufile_src. The one from commit 6621883f93
("migration: Fix potential race on postcopy_qemufile_src").

I'm trying to determine why that happens when other times it just
returns 0 as expected.

Could this mean that we're kicking the dest too soon while it is still
receiving valid data?

