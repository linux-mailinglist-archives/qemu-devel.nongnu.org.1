Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF207C558A
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:34:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZLp-0008Nk-11; Wed, 11 Oct 2023 09:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqZL3-00072J-2f
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:33:26 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqZKv-0007F8-Fk
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:33:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A21E91FEB4;
 Wed, 11 Oct 2023 13:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697031194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cgmdGELeyTod39mBNhRRQ9ekaSLHmXXUBSNFjey653I=;
 b=wpOV6I1ASztTy5sQi4FOuuB5GxPOdR9I5b0plPvf9HL6CChIhAfzptV4wcWgruYK9GDYAI
 KjojiTrP8R6JE15tpJozHOf5ZoxH4vcAG06bVsrf3+uhHPoq0uxKGdT67HlmLsjsPpsG9A
 3Z9Uo7jx1/3258xgugqjjnJfbW2KbNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697031194;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cgmdGELeyTod39mBNhRRQ9ekaSLHmXXUBSNFjey653I=;
 b=Wu9JJWzHhcx5NFocJYwyIcVvJKdol+RDZ5Z/vMSj9Ov/9PV67ctN2iECG66HAGgNYgxVcn
 1SS1Kg1G8iRzFAAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 329C7134F5;
 Wed, 11 Oct 2023 13:33:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wctSABqkJmUfTwAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 11 Oct 2023 13:33:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2 1/6] migration: Add the configuration vmstate to the
 json writer
In-Reply-To: <87edi1b8w2.fsf@secure.mitica>
References: <20231009184326.15777-1-farosas@suse.de>
 <20231009184326.15777-2-farosas@suse.de> <87edi1b8w2.fsf@secure.mitica>
Date: Wed, 11 Oct 2023 10:33:11 -0300
Message-ID: <87pm1l1dyg.fsf@suse.de>
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

Juan Quintela <quintela@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> wrote:
>> From: Nikolay Borisov <nborisov@suse.com>
>>
>> Make the migration json writer part of MigrationState struct, allowing
>> the 'configuration' object be serialized to json.
>>
>> This will facilitate the parsing of the 'configuration' object in the
>> next patch that fixes analyze-migration.py for arm.
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
>
> queued.
>
>>          qemu_put_byte(f, QEMU_VM_CONFIGURATION);
>> -        vmstate_save_state(f, &vmstate_configuration, &savevm_state, 0);
>> +
>> +        /*
>> +         * This starts the main json object and is paired with the
>> +         * json_writer_end_object in
>> +         * qemu_savevm_state_complete_precopy_non_iterable
>> +         */
>> +        json_writer_start_object(s->vmdesc, NULL);
>
> This don't depend of this patch, but it is ugly as hell.
>
> Can we create:
>
> json_write_start_main_object(s->vmdesc);
>
> (equivalent for end)
>
> And forbid json_writer_start_object() for taking a NULL parameter?
>
> Later, Juan.

Yep, I'll look into it.

