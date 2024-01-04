Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E609D8246DB
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 18:07:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLRAO-0008I0-EN; Thu, 04 Jan 2024 12:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rLRAI-0008Fz-EB
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 12:05:54 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rLRAF-00026N-OA
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 12:05:54 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C5A601F7AB;
 Thu,  4 Jan 2024 17:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704387947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FircfhfzKLiXtDrU4+TC+lvhcFUct3Exzfbtfsw5tYA=;
 b=E442+V5EwIInyYN2yGpIrgYL/KH3QQSsmPdSeNbr4f9w45UV94cYbpWkhyFQcFdXR8P/w7
 /DSuPcLW/qSEFmzOmX11kXXEWRoBWVf5HBbLlMdOgfHvOaiClf/77XOd3m22hc0QZQcr2v
 TeMV4+Z+mRUok7FiAy/HWsA/4hEjgGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704387947;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FircfhfzKLiXtDrU4+TC+lvhcFUct3Exzfbtfsw5tYA=;
 b=G/8h7P25e3UDHiJtsvPE880q8dsiLm4f4o/3eldmkMpPczETkkcSX6VpddWGrIt9fhpYNX
 cPeh1R73j/YqOrCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704387944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FircfhfzKLiXtDrU4+TC+lvhcFUct3Exzfbtfsw5tYA=;
 b=K0enkngz81PiR5KIQHMTFIKYq8unNNN69bN1KkEs66BDQweXUJgD/eAbE3WEhAPzYpTM56
 J1qbWor/kKkYX/9HrfKwGr0jALsSyjFnW79AZZFAGQ0yL16oh8yRlG188ClNtZf//Nn/H5
 m0EilfNmKJzk3DOYVG+Ro0DiJqgxcbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704387944;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FircfhfzKLiXtDrU4+TC+lvhcFUct3Exzfbtfsw5tYA=;
 b=M1Vn1jS7Fg5qLcLrSHbVAgovN6Ibd7A0tg2p12E2CwjwJ6ts4iLGrG1kPmUIU5FvPZ1sC0
 T7E+qF+lLoFRV/CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DF2213722;
 Thu,  4 Jan 2024 17:05:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wgajBWjllmXSaAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 04 Jan 2024 17:05:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] hw/audio/sb16: Do not migrate qdev properties
In-Reply-To: <48dcbec1-dceb-4bfe-8876-96b99c8ed6c7@linaro.org>
References: <20231124182615.94943-1-philmd@linaro.org>
 <48dcbec1-dceb-4bfe-8876-96b99c8ed6c7@linaro.org>
Date: Thu, 04 Jan 2024 14:05:41 -0300
Message-ID: <87sf3dhvve.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C5A601F7AB
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=K0enkngz;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=M1Vn1jS7
X-Spam-Score: -3.22
X-Spamd-Result: default: False [-3.22 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:email,suse.de:dkim,linaro.org:email];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-2.71)[98.74%];
 MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:email,suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> If there are no objections I'll queue this patch (fixing
> the typo reported by Zoltan).
>
> On 24/11/23 19:26, Philippe Mathieu-Daud=C3=A9 wrote:
>> Since commit f7b4f61f63 ("qdev/isa: convert soundblaster") these
>> fields has been converted to qdev properties, so don't need to be
>> migrated:
>>=20
>>    static Property sb16_properties[] =3D {
>>        DEFINE_AUDIO_PROPERTIES(SB16State, card),
>>        DEFINE_PROP_UINT32 ("version", SB16State, ver,  0x0405), /* 4.5 */
>>        DEFINE_PROP_UINT32 ("iobase",  SB16State, port, 0x220),
>>        DEFINE_PROP_UINT32 ("irq",     SB16State, irq,  5),
>>        DEFINE_PROP_UINT32 ("dma",     SB16State, dma,  1),
>>        DEFINE_PROP_UINT32 ("dma16",   SB16State, hdma, 5),
>>        DEFINE_PROP_END_OF_LIST (),
>>    };
>>=20
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> ---
>>   hw/audio/sb16.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
>> index 18f6d252db..be614d7bc3 100644
>> --- a/hw/audio/sb16.c
>> +++ b/hw/audio/sb16.c
>> @@ -1325,11 +1325,11 @@ static const VMStateDescription vmstate_sb16 =3D=
 {
>>       .minimum_version_id =3D 1,
>>       .post_load =3D sb16_post_load,
>>       .fields =3D (VMStateField[]) {
>> -        VMSTATE_UINT32 (irq, SB16State),
>> -        VMSTATE_UINT32 (dma, SB16State),
>> -        VMSTATE_UINT32 (hdma, SB16State),
>> -        VMSTATE_UINT32 (port, SB16State),
>> -        VMSTATE_UINT32 (ver, SB16State),
>> +        VMSTATE_UNUSED(  4 /* irq */
>> +                       + 4 /* dma */
>> +                       + 4 /* hdma */
>> +                       + 4 /* port */
>> +                       + 4 /* ver */),
>>           VMSTATE_INT32 (in_index, SB16State),
>>           VMSTATE_INT32 (out_data_len, SB16State),
>>           VMSTATE_INT32 (fmt_stereo, SB16State),
LGTM

Reviewed-by: Fabiano Rosas <farosas@suse.de>

