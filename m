Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30951741B2D
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 23:52:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEd4z-00064o-HZ; Wed, 28 Jun 2023 17:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qEd4w-00061S-QP; Wed, 28 Jun 2023 17:51:58 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qEd4v-0000FC-60; Wed, 28 Jun 2023 17:51:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DAC351F750;
 Wed, 28 Jun 2023 21:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1687989114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JrmVMEKvCpwICEIOWOUY0XbVeXGFMU6QizL/dyKqd00=;
 b=TkNUrNoGxquyCD2d1KKnsRG60ulEERyE9aBxjcQD0rMJzGLVg12zKTeQhRHs8VcDeQ4vza
 z/zUuoW3njEMUpwitYtBED2TiXP7aUaPkPixUq6qaKcKxIt1Amk9C/JXEkmmmIXTYmFr8q
 BrsMrTRUzm9LOh4zIxL++nxySDrtEEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1687989114;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JrmVMEKvCpwICEIOWOUY0XbVeXGFMU6QizL/dyKqd00=;
 b=+IHlLvhKV00EL+UuYCY1xXfDiIBhbAUYHxsocpQFDyb5A7yWvq6dltNnpfoZRDHZIoQ8u7
 oicq2W7yqeVRdXAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 696BA138EF;
 Wed, 28 Jun 2023 21:51:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XAwoDXqrnGTRYAAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 28 Jun 2023 21:51:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Richard
 Henderson <richard.henderson@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] target/arm: gdbstub: Guard M-profile code with CONFIG_TCG
In-Reply-To: <441e8217-31ac-0fd9-1d85-e83f9fdcb3f3@linaro.org>
References: <20230628164821.16771-1-farosas@suse.de>
 <441e8217-31ac-0fd9-1d85-e83f9fdcb3f3@linaro.org>
Date: Wed, 28 Jun 2023 18:51:52 -0300
Message-ID: <87bkgzqmpz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 28/6/23 18:48, Fabiano Rosas wrote:
>> This code is only relevant when TCG is present in the build. Building
>> with --disable-tcg --enable-xen on an x86 host we get:
>>=20
>> $ ../configure --target-list=3Dx86_64-softmmu,aarch64-softmmu --disable-=
tcg --enable-xen
>> $ make -j$(nproc)
>> ...
>> libqemu-aarch64-softmmu.fa.p/target_arm_gdbstub.c.o: in function `m_sysr=
eg_ptr':
>>   ../target/arm/gdbstub.c:358: undefined reference to `arm_v7m_get_sp_pt=
r'
>>   ../target/arm/gdbstub.c:361: undefined reference to `arm_v7m_get_sp_pt=
r'
>>=20
>> libqemu-aarch64-softmmu.fa.p/target_arm_gdbstub.c.o: in function `arm_gd=
b_get_m_systemreg':
>> ../target/arm/gdbstub.c:405: undefined reference to `arm_v7m_mrs_control'
>
> I'm a bit confused, isn't this covered by the cross-arm64-xen-only
> job?

It should be. Perhaps the CI is using different optimization flags. I'll
try to figure it out.

