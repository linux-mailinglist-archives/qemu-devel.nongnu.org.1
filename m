Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A0A905531
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jun 2024 16:31:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHP0h-0003mQ-Ck; Wed, 12 Jun 2024 10:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sHP0f-0003hO-3x
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 10:31:33 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sHP0d-000116-EN
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 10:31:32 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 397EE5C2D2;
 Wed, 12 Jun 2024 14:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718202687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AlizMYU18wbD7Lf15QFvvuM+VNwM/S7O6EvDmuh354I=;
 b=X6evhL3uedFP81MT+ZIkHyOvd/dyLrmhaz2dixVbOBS3ehGfLI9zyNzXHmPW/7MlBANFtW
 /cvfKK3KXDxaVIZfDlguuTAj/LDaBLihZmY5DUyidYOp/dGAJjF4sg3FQu/qmKwNWcJpo2
 B51QH2xAW5C4Ew8+Z5zeANr2Cdv9Itk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718202687;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AlizMYU18wbD7Lf15QFvvuM+VNwM/S7O6EvDmuh354I=;
 b=VC4GPStYefT9KNPZ6DQrYqi+3iTvGqqtT6+LL7/Yyqinepf3QxcAWozZ4QC4kGYYqm7pMr
 np0rgoV5qU+EFBAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=X6evhL3u;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VC4GPStY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718202687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AlizMYU18wbD7Lf15QFvvuM+VNwM/S7O6EvDmuh354I=;
 b=X6evhL3uedFP81MT+ZIkHyOvd/dyLrmhaz2dixVbOBS3ehGfLI9zyNzXHmPW/7MlBANFtW
 /cvfKK3KXDxaVIZfDlguuTAj/LDaBLihZmY5DUyidYOp/dGAJjF4sg3FQu/qmKwNWcJpo2
 B51QH2xAW5C4Ew8+Z5zeANr2Cdv9Itk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718202687;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AlizMYU18wbD7Lf15QFvvuM+VNwM/S7O6EvDmuh354I=;
 b=VC4GPStYefT9KNPZ6DQrYqi+3iTvGqqtT6+LL7/Yyqinepf3QxcAWozZ4QC4kGYYqm7pMr
 np0rgoV5qU+EFBAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B67D61372E;
 Wed, 12 Jun 2024 14:31:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bDXMHj6xaWa9TAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 12 Jun 2024 14:31:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yuan Liu <yuan1.liu@intel.com>, peterx@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org
Cc: qemu-devel@nongnu.org, yuan1.liu@intel.com, nanhai.zou@intel.com,
 shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH v8 4/7] migration/multifd: add qpl compression method
In-Reply-To: <87msnqck32.fsf@suse.de>
References: <20240610102110.900410-1-yuan1.liu@intel.com>
 <20240610102110.900410-5-yuan1.liu@intel.com> <87msnqck32.fsf@suse.de>
Date: Wed, 12 Jun 2024 11:31:24 -0300
Message-ID: <87h6dycjwj.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[11]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.de:email,suse.de:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 397EE5C2D2
X-Spam-Score: -6.51
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
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

Fabiano Rosas <farosas@suse.de> writes:

> Yuan Liu <yuan1.liu@intel.com> writes:
>
>> add the Query Processing Library (QPL) compression method
>>
>> Introduce the qpl as a new multifd migration compression method, it can
>> use In-Memory Analytics Accelerator(IAA) to accelerate compression and
>> decompression, which can not only reduce network bandwidth requirement
>> but also reduce host compression and decompression CPU overhead.
>>
>> How to enable qpl compression during migration:
>> migrate_set_parameter multifd-compression qpl
>>
>> There is no qpl compression level parameter added since it only supports
>> level one, users do not need to specify the qpl compression level.
>>
>> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
>> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>
> I don't think I ever reviewed this patch. Please drop this when you
> resubmit.

Actually, just leave it. I thought you'd need to fix the output size on
6/7, but I saw you just moved it elsewhere. So no need to respin. I'll
queue this version shortly unless anyone else has comments.

