Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE93B7DCDEB
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 14:33:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxoRi-0004Iy-9s; Tue, 31 Oct 2023 09:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qxoRc-0004Ga-6b
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:06:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qxoRV-00072G-P9
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:06:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 81000210EA;
 Tue, 31 Oct 2023 13:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698757559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BjpcRHXbKNqZ1+Ifu26zfUMZh3e52LozoGN08SXDx2A=;
 b=aCrZisOyVJcUzTU8TZIQK9+Bo5TTQTqttuBNTw84kLlR9gOtCILWdlHyuD6u+vG1SyTgU6
 ZOKkBKD9JxyP7nAVzjA66IyWOiCTwha+DMaLw+x7SgfkNuozUmcZw6zA3oLZC54PO8ktiC
 B5RMsAxvl8O54l8jhhjBHrFD0y465BQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698757559;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BjpcRHXbKNqZ1+Ifu26zfUMZh3e52LozoGN08SXDx2A=;
 b=m9YW0oNApFyPWbKX2ZJJFwjS3J3ORqfoB1AR4piiG5ieJqzunWIEFRGX3z8ut5RgSL+lqZ
 8Kx6u01DWGWDzMDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 152E21391B;
 Tue, 31 Oct 2023 13:05:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HefeM7b7QGU+YwAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 31 Oct 2023 13:05:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Juan
 Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo
 Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>, Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v2 28/29] migration: Add direct-io parameter
In-Reply-To: <ZUDC4aoPZZQAF6JU@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-29-farosas@suse.de> <878r7svapt.fsf@pond.sub.org>
 <87msw7ddfp.fsf@suse.de> <ZTjVg9NVTd0MT6mW@redhat.com>
 <87cyx2epsv.fsf@suse.de> <ZTkpllWQdLSMw3pP@redhat.com>
 <87cywvenbd.fsf@suse.de> <ZUDC4aoPZZQAF6JU@redhat.com>
Date: Tue, 31 Oct 2023 10:05:56 -0300
Message-ID: <878r7jdjrf.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Oct 30, 2023 at 07:51:34PM -0300, Fabiano Rosas wrote:
>> I could use some advice on how to solve this situation. The fdset code
>> at monitor/fds.c and the add-fd command don't seem to be usable outside
>> the original use-case of passing fds with different open flags.
>>=20
>> There are several problems, the biggest one being that there's no way to
>> manipulate the set of file descriptors aside from asking for duplication
>> of an fd that matches a particular set of flags.
>>=20
>> That doesn't work for us because the two fds we need (one for main
>> channel, other for secondary channels) will have the same open flags. So
>> the fdset code will always return the first one it finds in the set.
>
> QEMU may want multiple FDs *internally*, but IMHO that fact should
> not be exposed to mgmt applications. It would be valid for a QEMU
> impl to share the same FD across multiple threads, or have a different
> FD for each thread. All threads are using pread/pwrite, so it is safe
> for them to use the same FD if they desire. It is a private impl choice
> for QEMU at any given point in time and could change over time.
>

Sure, I don't disagree. However up until last week we had a seemingly
usable "add-fd" command that allows the user to provide a *set of file
descriptors* to QEMU. It's just now that we're learning that interface
serves only a special use-case.

> Thus from the POV of the mgmt app, QEMU is writing to a single file, no
> matter how many threads are involved & thus it should only need to supply
> a single FD for thta file. QEMU can then call 'dup()' on that FD as many
> times as it desires, and use fcntl() to toggle O_DIRECT if and when
> it needs to.

Ok, so I think the way to go here is for QEMU to receive a file + offset
instead of an FD. That way QEMU can have adequate control of the
resources for the migration. I don't remember why we went on the FD
tangent. Is it not acceptable for libvirt to provide the file name +
offset?

>> Another problem (or feature) of the fdset code is that it only removes
>> an fd when qmp_remove_fd() is called if the VM runstate is RUNNING,
>> which means that the migration code cannot remove the fds after use
>> reliably. We need to be able to remove them to make sure we use the
>> correct fds in a subsequent migration.
>
> The "easy" option is to just add a new API that does what you want.
> Maybe during review someone will then point out why the orgianl
> API works the way it does.

Hehe so I'll add a qmp_actually_remove_fd() =3D)

