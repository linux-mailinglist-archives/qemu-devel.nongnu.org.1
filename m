Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A74B27C7092
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:45:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqwvK-0000fQ-Es; Thu, 12 Oct 2023 10:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqwvI-0000am-IP
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:44:24 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqwvH-0006pO-0y
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:44:24 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EEE121F8A4;
 Thu, 12 Oct 2023 14:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697121859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E2s1zDTXzAFOEjYR97dBMuv/4V6MvO3J6B0Ixbv0Bn4=;
 b=e/hLDSsZ3xVcRL9Y/Ch42fRhE1hVQtNtJ1gp3Mztu9Z13tO6pcn9SbMlXa0BZkYgZyDokr
 facdmn9Z+Ix20D07rEbyfKtriuhZNCXftBKvvMqtf8hY3DuI48Mmo3aCoRYGJMS0ITqdT9
 2uD5TCVQTpVIEPwDgzQZqJvpBR5GHvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697121859;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E2s1zDTXzAFOEjYR97dBMuv/4V6MvO3J6B0Ixbv0Bn4=;
 b=azZuL2aJlsVKbjUzERsa8WpqjrvwZNdGqccdX9DdPtkzAfPf0msHDiAj1/c3kNQYssWgMj
 HTwsxzRiOOR4KVAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F3E4139F9;
 Thu, 12 Oct 2023 14:44:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pBLREkMGKGW6HgAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 12 Oct 2023 14:44:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH v3 13/13] migration/rdma: Remove all "ret" variables
 that are used only once
In-Reply-To: <20231011203527.9061-14-quintela@redhat.com>
References: <20231011203527.9061-1-quintela@redhat.com>
 <20231011203527.9061-14-quintela@redhat.com>
Date: Thu, 12 Oct 2023 11:44:17 -0300
Message-ID: <87wmvrzyri.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -6.16
X-Spamd-Result: default: False [-6.16 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-2.06)[95.41%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[6];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
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

> Change code that is:
>
> int ret;
> ...
>
> ret = foo();
> if (ret[ < 0]?) {
>
> to:
>
> if (foo()[ < 0]) {
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/rdma.c | 29 ++++++++---------------------
>  1 file changed, 8 insertions(+), 21 deletions(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index a43527a83c..c382588b26 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -1107,7 +1107,6 @@ err_alloc_pd_cq:
>  static int qemu_rdma_alloc_qp(RDMAContext *rdma)
>  {
>      struct ibv_qp_init_attr attr = { 0 };
> -    int ret;
>  
>      attr.cap.max_send_wr = RDMA_SIGNALED_SEND_MAX;
>      attr.cap.max_recv_wr = 3;
> @@ -1117,8 +1116,7 @@ static int qemu_rdma_alloc_qp(RDMAContext *rdma)
>      attr.recv_cq = rdma->recv_cq;
>      attr.qp_type = IBV_QPT_RC;
>  
> -    ret = rdma_create_qp(rdma->cm_id, rdma->pd, &attr);
> -    if (ret < 0) {
> +    if (rdma_create_qp(rdma->cm_id, rdma->pd, &attr) < 0) {

This particular pattern hurts readability IMO. See how the < 0 got
pushed all the way to the end of the line. The longer the list of
arguments, the larger the chance of missing the < 0 when glancing over
the code.

Anyway:

Reviewed-by: Fabiano Rosas <farosas@suse.de>

