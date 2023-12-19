Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 929A8818D29
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 18:01:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFdRK-00072l-WE; Tue, 19 Dec 2023 11:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rFdRI-00072c-Tj
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 11:59:28 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rFdRG-0004Sc-2R
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 11:59:28 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6E2211FD78;
 Tue, 19 Dec 2023 16:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1703005164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=86ui//NTpyrv/ugtEJS84ufabuPCSD7ThPYBSPo+34I=;
 b=qNS158vnWxCl4+7/IMADghsiOj9dtISkLq6+wjKefRkE+lfoMyJ3kS2xI6QnprRsY4J/e2
 VDm9a5ClUOpvp9ttTVzNpx8tinKxgsvLnTUCwST8SKgeJHf/0Pw8jlnfE71MlNB+/zgnxH
 SDKSw02kXeJqetc0x5PXVGB4FYlfLpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1703005164;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=86ui//NTpyrv/ugtEJS84ufabuPCSD7ThPYBSPo+34I=;
 b=5DklwY3t9r4DX+13CD09fbytdROAodSEVH12antV4/iD6zAp91ujOEqcU/LBkJd4Aqqe97
 NGT+Tnol3NQYfKBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1703005164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=86ui//NTpyrv/ugtEJS84ufabuPCSD7ThPYBSPo+34I=;
 b=qNS158vnWxCl4+7/IMADghsiOj9dtISkLq6+wjKefRkE+lfoMyJ3kS2xI6QnprRsY4J/e2
 VDm9a5ClUOpvp9ttTVzNpx8tinKxgsvLnTUCwST8SKgeJHf/0Pw8jlnfE71MlNB+/zgnxH
 SDKSw02kXeJqetc0x5PXVGB4FYlfLpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1703005164;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=86ui//NTpyrv/ugtEJS84ufabuPCSD7ThPYBSPo+34I=;
 b=5DklwY3t9r4DX+13CD09fbytdROAodSEVH12antV4/iD6zAp91ujOEqcU/LBkJd4Aqqe97
 NGT+Tnol3NQYfKBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF707136A5;
 Tue, 19 Dec 2023 16:59:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Qt3UIevLgWVnCgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 19 Dec 2023 16:59:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 1/5] tests/qtest: Add a helper to query the QEMU version
In-Reply-To: <16f68c89-dcf4-4da7-bfa1-c64db0754bca@redhat.com>
References: <20231207155809.25673-1-farosas@suse.de>
 <20231207155809.25673-2-farosas@suse.de>
 <16f68c89-dcf4-4da7-bfa1-c64db0754bca@redhat.com>
Date: Tue, 19 Dec 2023 13:59:20 -0300
Message-ID: <877claf7rr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.93 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-2.83)[99.26%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[9];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -2.93
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

Thomas Huth <thuth@redhat.com> writes:

> On 07/12/2023 16.58, Fabiano Rosas wrote:
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   tests/qtest/libqtest.c | 24 ++++++++++++++++++++++++
>>   tests/qtest/libqtest.h | 10 ++++++++++
>>   2 files changed, 34 insertions(+)
>> 
>> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
>> index f33a210861..7cee68a834 100644
>> --- a/tests/qtest/libqtest.c
>> +++ b/tests/qtest/libqtest.c
>> @@ -337,6 +337,30 @@ void qtest_remove_abrt_handler(void *data)
>>       }
>>   }
>>   
>> +void qtest_query_version(QTestState *who, int *major, int *minor, int *micro)
>
> I'd prefer "qts" instead of "who" ... but that's bikeshedding, so:

I'll change it. I need to send another version of this series anyway.

