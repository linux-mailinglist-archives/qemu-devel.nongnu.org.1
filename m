Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCCBA25E37
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Feb 2025 16:16:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teyAT-0000M5-S4; Mon, 03 Feb 2025 10:15:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1teyAO-0000Lg-JW
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 10:15:17 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1teyAM-0006Gh-Ic
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 10:15:16 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6479A2115C;
 Mon,  3 Feb 2025 15:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738595710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U7sK9oplg9Zh+W/hHRN6bIYxtiaZTVi+73+Lb5IMK7Q=;
 b=NVbgeZTRxMNuKIdEsF4Ey5zsUNSI8HInVySiPvnWwMg+jp36xEXJqI8ZxQhEXWfl1yKjj3
 G1ChqjC0SCobmGVwh+UkiyqzkIm4DYjZVh1hYODp6cIN6sbPvHjAnJhHnK9Alcvkbb/Pwj
 j2lOMefxhPwwhEpQ6n++1kGSiJaJidk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738595710;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U7sK9oplg9Zh+W/hHRN6bIYxtiaZTVi+73+Lb5IMK7Q=;
 b=+rYxHNvPXlngsflhal5N4UySL6/m0GeiL39v2PuJVRsquI+7tCXiW6uDI9JF8kJit1ZQ6q
 KUTJIATkWAIqQlCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738595710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U7sK9oplg9Zh+W/hHRN6bIYxtiaZTVi+73+Lb5IMK7Q=;
 b=NVbgeZTRxMNuKIdEsF4Ey5zsUNSI8HInVySiPvnWwMg+jp36xEXJqI8ZxQhEXWfl1yKjj3
 G1ChqjC0SCobmGVwh+UkiyqzkIm4DYjZVh1hYODp6cIN6sbPvHjAnJhHnK9Alcvkbb/Pwj
 j2lOMefxhPwwhEpQ6n++1kGSiJaJidk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738595710;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U7sK9oplg9Zh+W/hHRN6bIYxtiaZTVi+73+Lb5IMK7Q=;
 b=+rYxHNvPXlngsflhal5N4UySL6/m0GeiL39v2PuJVRsquI+7tCXiW6uDI9JF8kJit1ZQ6q
 KUTJIATkWAIqQlCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF3D613A78;
 Mon,  3 Feb 2025 15:15:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bRC8In3doGcCVQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 03 Feb 2025 15:15:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jason Wang
 <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] tests/qtest/vhost-user-test: Use modern virtio for
 vhost-user tests
In-Reply-To: <20250203124346.169607-1-thuth@redhat.com>
References: <20250203124346.169607-1-thuth@redhat.com>
Date: Mon, 03 Feb 2025 12:15:06 -0300
Message-ID: <871pwfgiv9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[9]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Score: -4.30
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Thomas Huth <thuth@redhat.com> writes:

> All other vhost-user tests here use modern virtio, too, so let's
> adjust the vhost-user-net test accordingly.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qtest/vhost-user-test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
> index 76d142a158..bd977ef28d 100644
> --- a/tests/qtest/vhost-user-test.c
> +++ b/tests/qtest/vhost-user-test.c
> @@ -1043,7 +1043,8 @@ static void test_multiqueue(void *obj, void *arg, QGuestAllocator *alloc)
>  
>  static uint64_t vu_net_get_features(TestServer *s)
>  {
> -    uint64_t features = 0x1ULL << VHOST_F_LOG_ALL |
> +    uint64_t features = 0x1ULL << VIRTIO_F_VERSION_1 |
> +        0x1ULL << VHOST_F_LOG_ALL |
>          0x1ULL << VHOST_USER_F_PROTOCOL_FEATURES;
>  
>      if (s->queues > 1) {

Reviewed-by: Fabiano Rosas <farosas@suse.de>

