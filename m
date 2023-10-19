Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B53BF7CFC47
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 16:18:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTpU-0008Cl-OD; Thu, 19 Oct 2023 10:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtTpS-00088Y-Cq
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:16:50 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtTpQ-0007S7-Sj
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:16:50 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9B63C21A18;
 Thu, 19 Oct 2023 14:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697725004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yZW/W0p58DucmIFjaKkVkdafjFzt8p06+i5QmjdUBC4=;
 b=a1/Wlnn7gkhHXH5D5k6PlF9q/U+SN68RdyVT6jBctxN6Q4hCLrP3QBAE5Bdq6WwfxUe57I
 DspRkma37rYvODTCqVIaI5LlWV09qNVoRZyZSJohu2c1yZvs0ytgdA97GCqqnDIpHXY9fV
 /lnYlkeu1wMveWIavKmVrDT4dqrslPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697725004;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yZW/W0p58DucmIFjaKkVkdafjFzt8p06+i5QmjdUBC4=;
 b=zz0X15tIUFPUYGQmIBlzbLZ7LvRIAneI0Gnnw438W9jduepcodnGLT8Y488QAZUqF1Bn5Y
 9I7grkwEzvcp8XAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2ED92139C2;
 Thu, 19 Oct 2023 14:16:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eoSaOks6MWVTegAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 19 Oct 2023 14:16:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Leonardo
 Bras <leobras@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Alex
 =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 02/12] tests/qtest: Introduce qtest_init_with_env
In-Reply-To: <ZTBHKOwCy72Bu5CE@x1n>
References: <20231018192741.25885-1-farosas@suse.de>
 <20231018192741.25885-3-farosas@suse.de> <ZTBHKOwCy72Bu5CE@x1n>
Date: Thu, 19 Oct 2023 11:16:41 -0300
Message-ID: <87v8b2y9x2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -4.49
X-Spamd-Result: default: False [-4.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.39)[77.60%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[10];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, Oct 18, 2023 at 04:27:31PM -0300, Fabiano Rosas wrote:
>> +/**
>> + * qtest_init_with_env:
>> + * @var: Environment variable from where to take the QEMU binary
>> + * @extra_args: Other arguments to pass to QEMU.  CAUTION: these
>> + * arguments are subject to word splitting and shell evaluation.
>> + *
>> + * Like qtest_init(), but use a different environment variable for the
>> + * QEMU binary.
>> + *
>> + * Returns: #QTestState instance.
>> + */
>> +QTestState *qtest_init_with_env(const char *var, const char *extra_args);
>
> Another way to do is instead of passing over the env var, passing over
> "char *qemu_bin" always, and take qtest_qemu_binary() as default.  Also
> relevant to patch 1.  Not a big deal though, so can be done for later.

Here's an low-hanging fruit if someone's interested. =)

I'll take note and do it when I get the chance after the PR merges
otherwise.

Thanks Peter

