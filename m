Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CE67C5585
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:34:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZLj-0007ZA-Ox; Wed, 11 Oct 2023 09:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqZKj-0006p6-QW
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:33:14 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqZKe-00076I-I2
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:33:05 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5305B1FEB6;
 Wed, 11 Oct 2023 13:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697031176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m8RJGvF+xMhfxD+XKl08vS/z6sQv+VY2hEu5l0zS7Hc=;
 b=fee849W8/rvpilDB11qez0yvMjRFp0i6PON55n9XvHcuLNe2dqPRcoPNcqTojubSmqnuZd
 d4L07rcdkAK6kvP014UYD20xVAC6RQ0yPrtHUhS+LhpkExRVH2BAu2LeXrc6xC8HN+Yl3R
 4Syr3frheADIc1gusWUKMP2NuA/Uxhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697031176;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m8RJGvF+xMhfxD+XKl08vS/z6sQv+VY2hEu5l0zS7Hc=;
 b=R7MCjGDsVTEn8ZwUUKuZEfs3uzULMNowbG7d7uY0NsuvyOclbiVJ/fu2UmiWrnVTEihgvz
 UdtE7ROmwz9M+lDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8134134F5;
 Wed, 11 Oct 2023 13:32:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sb2hKAekJmXxTgAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 11 Oct 2023 13:32:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>, Cleber
 Rosa <crosa@redhat.com>
Subject: Re: [PATCH v2 4/6] migration: Fix analyze-migration.py when
 ignore-shared is used
In-Reply-To: <87v8bd9tsr.fsf@secure.mitica>
References: <20231009184326.15777-1-farosas@suse.de>
 <20231009184326.15777-5-farosas@suse.de> <87v8bd9tsr.fsf@secure.mitica>
Date: Wed, 11 Oct 2023 10:32:53 -0300
Message-ID: <87sf6h1dyy.fsf@suse.de>
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
>> The script is currently broken when the x-ignore-shared capability is
>> used:
>>
>> Traceback (most recent call last):
>>   File "./scripts/analyze-migration.py", line 656, in <module>
>>     dump.read(dump_memory = args.memory)
>>   File "./scripts/analyze-migration.py", line 593, in read
>>     section.read()
>>   File "./scripts/analyze-migration.py", line 163, in read
>>     self.name = self.file.readstr(len = namelen)
>>   File "./scripts/analyze-migration.py", line 53, in readstr
>>     return self.readvar(len).decode('utf-8')
>> UnicodeDecodeError: 'utf-8' codec can't decode byte 0x82 in position 55: invalid start byte
>>
>> We're currently adding data to the middle of the ram section depending
>> on the presence of the capability. As a consequence, any code loading
>> the ram section needs to know about capabilities so it can interpret
>> the stream.
>>
>> Skip the byte that's added when x-ignore-shared is used to fix the
>> script.
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
>
>> @@ -582,6 +586,7 @@ def read(self, desc_only = False, dump_memory = False, write_memory = False):
>>                  config_desc = self.vmsd_desc.get('configuration')
>>                  section = ConfigurationSection(file, config_desc)
>>                  section.read()
>> +                ramargs['ignore_shared'] = section.has_capability('x-ignore-shared')
>
> should we consider s/x-ignore-shared/ignore-shared/?
>

We can consider s/ignore-shared/x-ignore-shared/ if that's what you
mean. The way you suggested doesn't work because the cap name comes from
QEMU with the "x-" part in it.

If you meant filtering the x out when parsing the capabilities in this
script, I think that would cause a sort of a UX issue because we need to
use x-ignore-shared to set the cap in QMP/HMP.

