Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F098FBE01
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jun 2024 23:26:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEbeQ-0006FP-TI; Tue, 04 Jun 2024 17:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sEbeL-0006ET-LN
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 17:24:57 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sEbeK-00057i-4k
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 17:24:57 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4DDD72197D;
 Tue,  4 Jun 2024 21:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717536294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m7FVNSQ4aq4BpJtoeRpricaVqG6+XqZJDMSV92hPy3s=;
 b=dOxqFl21kx1m3RLYHcnxrUiu3PjiqVo8lQflgnqKvZ0bbkhNtOZ9DAunit5d6/Nfo1NjpT
 0U3gEWOBPI3GWH49SK6W8kLQDcFrizWBipbMlz8q7EkTz3oc08KDlMv9vM6E9ehjUJKAOU
 QVbPuKhUQ3atDfS7MBloT06WF7hAC7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717536294;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m7FVNSQ4aq4BpJtoeRpricaVqG6+XqZJDMSV92hPy3s=;
 b=eS7i7Wd9ZeLip/irVHxvmHNzq8LCbC6R8C75dDFp8poimrB7bEyf/0K5K+UlAalLsHb3Ga
 NbC9ezepPQ0uZOBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dOxqFl21;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eS7i7Wd9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717536294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m7FVNSQ4aq4BpJtoeRpricaVqG6+XqZJDMSV92hPy3s=;
 b=dOxqFl21kx1m3RLYHcnxrUiu3PjiqVo8lQflgnqKvZ0bbkhNtOZ9DAunit5d6/Nfo1NjpT
 0U3gEWOBPI3GWH49SK6W8kLQDcFrizWBipbMlz8q7EkTz3oc08KDlMv9vM6E9ehjUJKAOU
 QVbPuKhUQ3atDfS7MBloT06WF7hAC7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717536294;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m7FVNSQ4aq4BpJtoeRpricaVqG6+XqZJDMSV92hPy3s=;
 b=eS7i7Wd9ZeLip/irVHxvmHNzq8LCbC6R8C75dDFp8poimrB7bEyf/0K5K+UlAalLsHb3Ga
 NbC9ezepPQ0uZOBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCDCE13A93;
 Tue,  4 Jun 2024 21:24:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ck5xJCWGX2b+BQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 04 Jun 2024 21:24:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 peterx@redhat.com, yuan1.liu@intel.com
Cc: qemu-devel@nongnu.org, linuxarm@huawei.com, linwenkai6@hisilicon.com,
 zhangfei.gao@linaro.org, huangchenghai2@huawei.com
Subject: Re: [PATCH 3/7] migration/multifd: add uadk compression framework
In-Reply-To: <20240529094435.11140-4-shameerali.kolothum.thodi@huawei.com>
References: <20240529094435.11140-1-shameerali.kolothum.thodi@huawei.com>
 <20240529094435.11140-4-shameerali.kolothum.thodi@huawei.com>
Date: Tue, 04 Jun 2024 18:24:51 -0300
Message-ID: <87frtsh04c.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -1.58
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4DDD72197D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.58 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 BAYES_HAM(-0.07)[62.00%]; MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_TRACE(0.00)[suse.de:+]
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

Shameer Kolothum via <qemu-devel@nongnu.org> writes:

> Adds the skeleton to support uadk compression method.
> Complete functionality will be added in subsequent patches.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>


