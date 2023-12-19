Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56846818D5F
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 18:03:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFdUK-00012S-VK; Tue, 19 Dec 2023 12:02:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rFdUI-00011X-UW
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 12:02:34 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rFdUH-00054N-9P
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 12:02:34 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B6F9021EBE;
 Tue, 19 Dec 2023 17:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1703005351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SH/8Z2zcb5HeIBmB4d+wkVrdFhVLjxFshXeJ+N6jtVk=;
 b=AJuLIite3v4WHtJYEhbbuzrDgc8Z7pdKIo7rKVq8Cb4FsXD5DUqWdRHa6RMOkmHp25x9HH
 6Ja4T2Gtx8xIy7cKTPdmPaixmTGNXo64apJ8aHDXZEBWW/fcVFix0vYPqGa2Nw65IBQY6V
 sYjjHeczMtSG6QBXxepemYpkdG8KwqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1703005351;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SH/8Z2zcb5HeIBmB4d+wkVrdFhVLjxFshXeJ+N6jtVk=;
 b=JwvPpkZCNYiIiWu0jz+87KTvuH5fi+9Sk+SVWfDYBmoWn5LXD8mtbwViHFP8TBGOAVPlFO
 VPMJqEg2yso03mAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1703005351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SH/8Z2zcb5HeIBmB4d+wkVrdFhVLjxFshXeJ+N6jtVk=;
 b=AJuLIite3v4WHtJYEhbbuzrDgc8Z7pdKIo7rKVq8Cb4FsXD5DUqWdRHa6RMOkmHp25x9HH
 6Ja4T2Gtx8xIy7cKTPdmPaixmTGNXo64apJ8aHDXZEBWW/fcVFix0vYPqGa2Nw65IBQY6V
 sYjjHeczMtSG6QBXxepemYpkdG8KwqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1703005351;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SH/8Z2zcb5HeIBmB4d+wkVrdFhVLjxFshXeJ+N6jtVk=;
 b=JwvPpkZCNYiIiWu0jz+87KTvuH5fi+9Sk+SVWfDYBmoWn5LXD8mtbwViHFP8TBGOAVPlFO
 VPMJqEg2yso03mAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23913136A5;
 Tue, 19 Dec 2023 17:02:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BBKnEKbMgWU2CwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 19 Dec 2023 17:02:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 2/5] tests/qtest/migration: Add infrastructure to
 skip tests on older QEMUs
In-Reply-To: <260ff019-3bd9-49b1-a364-d0b713372713@redhat.com>
References: <20231207155809.25673-1-farosas@suse.de>
 <20231207155809.25673-3-farosas@suse.de> <87zfykybyc.fsf@suse.de>
 <260ff019-3bd9-49b1-a364-d0b713372713@redhat.com>
Date: Tue, 19 Dec 2023 14:02:27 -0300
Message-ID: <874jgef7mk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[9];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Thomas Huth <thuth@redhat.com> writes:

> On 08/12/2023 16.02, Fabiano Rosas wrote:
>> Fabiano Rosas <farosas@suse.de> writes:
>> 
>>> We can run the migration tests with two different QEMU binaries to
>>> test migration compatibility between QEMU versions. This means we'll
>>> be running the tests with an older QEMU in either source or
>>> destination.
>>>
>>> We need to avoid trying to test functionality that is unknown to the
>>> older QEMU. This could mean new features, bug fixes, error message
>>> changes, QEMU command line changes, migration API changes, etc.
>>>
>>> Add a 'since' argument to the tests that inform when the functionality
>>> that is being test has been added to QEMU so we can skip the test on
>>> older versions.
>>>
>>> Also add a version comparison function so we can adapt test code
>>> depending on the QEMU binary version being used.
>>>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>> ---
>>>   tests/qtest/migration-helpers.c | 11 +++++++++++
>>>   tests/qtest/migration-helpers.h |  1 +
>>>   tests/qtest/migration-test.c    | 28 ++++++++++++++++++++++++++++
>>>   3 files changed, 40 insertions(+)
>>>
>>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
>>> index 24fb7b3525..d21f5cd8c0 100644
>>> --- a/tests/qtest/migration-helpers.c
>>> +++ b/tests/qtest/migration-helpers.c
>>> @@ -292,3 +292,14 @@ char *resolve_machine_version(const char *alias, const char *var1,
>>>   
>>>       return find_common_machine_version(machine_name, var1, var2);
>>>   }
>>> +
>>> +int migration_vercmp(QTestState *who, const char *tgt_version)
>>> +{
>>> +    int major, minor, micro;
>>> +    g_autofree char *version = NULL;
>>> +
>>> +    qtest_query_version(who, &major, &minor, &micro);
>>> +    version = g_strdup_printf("%d.%d.%d", major, minor, micro);
>> 
>> I just noticed this is not right. I need to increment the minor when
>> there's a micro to account for the versions in between releases. The
>> whole point of this series is to test a X.Y.0 release vs. a X.Y.Z
>> development branch.
>
> Also this looks like it cannot deal with two-digit minor versions ... we 
> still have machine types for QEMU 2.12.0 around ... do we care here?
>

I particularly don't. I suspect any issues this series would have caught
would have already been spotted in the wild. This is all about catching
compatibility issues during the development cycle, so not very useful
for older QEMUs and distro versions.

