Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F30A7D0F63
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 14:09:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtoI3-0003qw-Bq; Fri, 20 Oct 2023 08:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtoHu-0003qd-VT
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:07:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtoHs-0003d4-St
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:07:34 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B732F21888;
 Fri, 20 Oct 2023 12:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697803648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uGGMrMqFAnSBi8qoDdBZA9KB6jzi9PP0UIdcGC9Mwwk=;
 b=Cqe4IdRQqilBE1bF+iOCqkkltPGuvqzjOc+Ke/aU5fp3NfrELYZrVA07kOMdGS++EwQwO3
 2p5phzace+B0orGltnkeAcBEWG482TRwLSQNJ+3T1sEvL2CTXjz7sKIMmQqBogcx5oDNWP
 gK9JWmTLV3TSPNk+Ih088VOpQxgchGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697803648;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uGGMrMqFAnSBi8qoDdBZA9KB6jzi9PP0UIdcGC9Mwwk=;
 b=HWsX+Yu4BDGIe1VaoWsW/859p8YiCv7UCMvV8OKmvvfCEiMbzH4UVqHJ5/FtTnkHuUjkop
 90uUGd+/95guN0Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4872313584;
 Fri, 20 Oct 2023 12:07:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TQtEBYBtMmVCfgAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 20 Oct 2023 12:07:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, eblake@redhat.com,
 manish.mishra@nutanix.com, aravind.retnakaran@nutanix.com, Het Gala
 <het.gala@nutanix.com>, Juan Quintela <quintela@redhat.com>, Peter Xu
 <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v14 02/14] fixup! migration: New QAPI type 'MigrateAddress'
In-Reply-To: <87y1fxc27m.fsf@pond.sub.org>
References: <20231019192353.31500-1-farosas@suse.de>
 <20231019192353.31500-3-farosas@suse.de> <87y1fxc27m.fsf@pond.sub.org>
Date: Fri, 20 Oct 2023 09:07:25 -0300
Message-ID: <87wmvhh4zm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -5.94
X-Spamd-Result: default: False [-5.94 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-1.84)[94.08%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SUBJECT_HAS_EXCLAIM(0.00)[]; NEURAL_HAM_SHORT(-1.00)[-1.000];
 RCPT_COUNT_TWELVE(0.00)[13]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
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

Markus Armbruster <armbru@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> writes:
>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  qapi/migration.json | 20 ++++++++++++++++++--
>>  1 file changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index c352c7ac52..602cb706e3 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -1519,10 +1519,25 @@
>>  #
>>  # @rdma: Migrate via RDMA.
>>  #
>> +# @file: Direct the migration stream to a file.
>> +#
>>  # Since 8.2
>>  ##
>>  { 'enum': 'MigrationAddressType',
>> -  'data': ['socket', 'exec', 'rdma'] }
>> +  'data': ['socket', 'exec', 'rdma', 'file'] }
>
> I don't like our use of spaces around parenthesis in the QAPI schema,
> but I like inconsistency even less: please insert a space after '['.
>

Yes. But,

a contributor today has to guess what is the preferred syntax. Could we
have a checkpatch rule for this? Or should I send a patch to make the
whole file consistent at once?

Side question: are we using valid JSON at all? I threw this in a random
online linter and it complains about the single quotes. We could have a
proper tool doing the validation in CI.

