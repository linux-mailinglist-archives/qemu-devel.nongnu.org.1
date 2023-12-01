Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9725F80122C
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 19:03:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r97pb-0006rc-QU; Fri, 01 Dec 2023 13:01:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r97pP-0006r6-Qz
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 13:01:32 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r97pN-0007Le-RZ
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 13:01:27 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9922E21CB3;
 Fri,  1 Dec 2023 18:01:22 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2022A1369E;
 Fri,  1 Dec 2023 18:01:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7rEtNnEfamUgdwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 01 Dec 2023 18:01:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yuan Liu <yuan1.liu@intel.com>, quintela@redhat.com, peterx@redhat.com,
 leobras@redhat.com
Cc: qemu-devel@nongnu.org, yuan1.liu@intel.com, nanhai.zou@intel.com
Subject: Re: [PATCH v2 2/4] multifd: Implement multifd compression accelerator
In-Reply-To: <20231109154638.488213-3-yuan1.liu@intel.com>
References: <20231109154638.488213-1-yuan1.liu@intel.com>
 <20231109154638.488213-3-yuan1.liu@intel.com>
Date: Fri, 01 Dec 2023 15:01:19 -0300
Message-ID: <87a5qtby4w.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Bar: ++++++++++
X-Spam-Score: 10.40
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de; dkim=none;
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither
 permitted nor denied by domain of farosas@suse.de)
 smtp.mailfrom=farosas@suse.de; 
 dmarc=fail reason="No valid SPF,
 No valid DKIM" header.from=suse.de (policy=none)
X-Rspamd-Queue-Id: 9922E21CB3
X-Spamd-Result: default: False [10.40 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-2.89)[99.54%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_SPAM_SHORT(3.00)[1.000];
 MIME_GOOD(-0.10)[text/plain]; R_SPF_SOFTFAIL(4.60)[~all:c];
 RCVD_COUNT_THREE(0.00)[3]; MX_GOOD(-0.01)[];
 NEURAL_SPAM_LONG(3.50)[1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Yuan Liu <yuan1.liu@intel.com> writes:

> when starting multifd live migration, if the compression method is
> enabled, compression method can be accelerated using accelerators.
>
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> ---
>  migration/multifd.c | 38 ++++++++++++++++++++++++++++++++++++--
>  migration/multifd.h |  8 ++++++++
>  2 files changed, 44 insertions(+), 2 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 1fe53d3b98..7149e67867 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -165,6 +165,34 @@ static MultiFDMethods multifd_nocomp_ops = {
>  static MultiFDMethods *multifd_ops[MULTIFD_COMPRESSION__MAX] = {
>      [MULTIFD_COMPRESSION_NONE] = &multifd_nocomp_ops,
>  };
> +static MultiFDAccelMethods *accel_multifd_ops[MULTIFD_COMPRESSION_ACCEL__MAX];
> +
> +static MultiFDMethods *get_multifd_ops(void)
> +{
> +    MultiFDCompression comp = migrate_multifd_compression();
> +    MultiFDCompressionAccel accel = migrate_multifd_compression_accel();
> +
> +    if (comp == MULTIFD_COMPRESSION_NONE ||
> +        accel == MULTIFD_COMPRESSION_ACCEL_NONE) {
> +        return multifd_ops[comp];
> +    }
> +    if (accel == MULTIFD_COMPRESSION_ACCEL_AUTO) {
> +        for (int i = 0; i < MULTIFD_COMPRESSION_ACCEL__MAX; i++) {
> +            if (accel_multifd_ops[i] &&
> +                accel_multifd_ops[i]->is_supported(comp)) {
> +                return accel_multifd_ops[i]->get_multifd_methods();
> +            }
> +        }
> +        return multifd_ops[comp];
> +    }
> +
> +    /* Check if a specified accelerator is available */
> +    if (accel_multifd_ops[accel] &&

The CI is complaining that we might reach here with accel=2 when
!CONFIG_QPL. It seems the assert at migrate_multifd_compression_accel is
not enough.


