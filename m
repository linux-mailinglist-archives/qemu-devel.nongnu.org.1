Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B7175AE73
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 14:32:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMSnh-00005n-3D; Thu, 20 Jul 2023 08:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qMSnf-00005W-2V
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 08:30:31 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qMSnd-00048a-9l
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 08:30:30 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 054F822C38;
 Thu, 20 Jul 2023 12:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1689856226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PvfhhWzH+nzN+rg6WjWnXAqD36xvocKzShf6FP5vJxc=;
 b=nV6q8D5eHgRSeK3/t2ZkFKzNlsryBT9cm8SKNzhQDDR41j7PoOmmlnNUItGtI6XlyG7IIn
 tjsvU4WJgysBf7I0+H7cSEb0W8dWCfS/dYm3EOQTpNUImR82C3VYaBt54YI+OE1ceMYJbO
 SuQeZCuoMZr4ltM6R8Rll9G+dluaFgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1689856226;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PvfhhWzH+nzN+rg6WjWnXAqD36xvocKzShf6FP5vJxc=;
 b=U9A3iWpoQ1iSCO+gjt5W5ceOhSoXkMJhur1rGnypV62IPdH3M+E0/SY9PETfyVVdBmyDkG
 QDxJ4cDBHUyD2fBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A4D1138EC;
 Thu, 20 Jul 2023 12:30:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Wpz7FeEouWTkLQAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 20 Jul 2023 12:30:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Milan Zamazal <mzamazal@redhat.com>, qemu-devel@nongnu.org
Cc: Milan Zamazal <mzamazal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Subject: Re: [PATCH] hw/virtio: Add a protection against duplicate
 vu_scmi_stop calls
In-Reply-To: <20230720101037.2161450-1-mzamazal@redhat.com>
References: <20230720101037.2161450-1-mzamazal@redhat.com>
Date: Thu, 20 Jul 2023 09:30:23 -0300
Message-ID: <87edl2sr34.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
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

Milan Zamazal <mzamazal@redhat.com> writes:

> The QEMU CI fails in virtio-scmi test occasionally.  As reported by
> Thomas Huth, this happens most likely when the system is loaded and it
> fails with the following error:
>
>   qemu-system-aarch64: ../../devel/qemu/hw/pci/msix.c:659:
>   msix_unset_vector_notifiers: Assertion `dev->msix_vector_use_notifier && dev->msix_vector_release_notifier' failed.
>   ../../devel/qemu/tests/qtest/libqtest.c:200: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
>
> As discovered by Fabiano Rosas, the cause is a duplicate invocation of
> msix_unset_vector_notifiers via duplicate vu_scmi_stop calls:
>
>   msix_unset_vector_notifiers
>   virtio_pci_set_guest_notifiers
>   vu_scmi_stop
>   vu_scmi_disconnect
>   ...
>   qemu_chr_write_buffer
>
>   msix_unset_vector_notifiers
>   virtio_pci_set_guest_notifiers
>   vu_scmi_stop
>   vu_scmi_set_status
>   ...
>   qemu_cleanup
>
> While vu_scmi_stop calls are protected by vhost_dev_is_started()
> check, it's apparently not enough.  vhost-user-blk and vhost-user-gpio
> use an extra protection, see f5b22d06fb (vhost: recheck dev state in
> the vhost_migration_log routine) for the motivation.  Let's use the
> same in vhost-user-scmi, which fixes the failure above.
>
> Fixes: a5dab090e142 ("hw/virtio: Add boilerplate for vhost-user-scmi device")
> Signed-off-by: Milan Zamazal <mzamazal@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

