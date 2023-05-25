Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86789710AF7
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 13:32:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q28uY-00036w-1w; Thu, 25 May 2023 07:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q28uU-00036G-W5
 for qemu-devel@nongnu.org; Thu, 25 May 2023 07:13:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q28uT-00044z-Eo
 for qemu-devel@nongnu.org; Thu, 25 May 2023 07:13:34 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9C72721D42;
 Thu, 25 May 2023 11:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1685013210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4SBlbVnYKuBwj6vxW73JBDj4hM8cjwRATkbGx8hQE/E=;
 b=Q/kgEvHSLb8THwQj+dZG9H8T1es3/3RVIDJOizggHPQbHZGhmRSP9oMIaaPOAUgW+iVeis
 SOrbEUUCOEXRH4NuNkYGnUmFAvJr2wAsSRWxvt0oyterfiZjf9JGKdUlu8ucckZk7GAOX6
 oMImNvehgw66CnolYw2b8N6DfC4Zreo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1685013210;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4SBlbVnYKuBwj6vxW73JBDj4hM8cjwRATkbGx8hQE/E=;
 b=amF2AODmObkRyMZRnsoqkLu4HZTcCdZIulZ0IRc6OcPfz5kyWmXktJxYt+6JxzlmdMnbTM
 BGSa0qk/4AjmcACQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2176B13356;
 Thu, 25 May 2023 11:13:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9iw4NtlCb2ScEwAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 25 May 2023 11:13:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier
 <lvivier@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 2/4] tests/qtest: Check for virtio-blk before using
 -cdrom with the arm virt machine
In-Reply-To: <20230525081016.1870364-3-thuth@redhat.com>
References: <20230525081016.1870364-1-thuth@redhat.com>
 <20230525081016.1870364-3-thuth@redhat.com>
Date: Thu, 25 May 2023 08:13:27 -0300
Message-ID: <877cswbr54.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
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

Thomas Huth <thuth@redhat.com> writes:

> The arm "virt" machine needs "virtio-blk-pci" for devices that get attached
> via the "-cdrom" option. Since this is an optional device that might not
> be available in the binary, we should check for the availability of this
> device first before using it.
>

We're still producing a binary that exposes runtime options that may not
work depending on the state of seemingly unrelated config options. And
barfs QEMU implementation details at the user:

qemu-system-aarch64: -cdrom foo.qcow2: 'virtio-blk' (alias
'virtio-blk-pci') is not a valid device model name

Anyway, this patch is good so:

Reviewed-by: Fabiano Rosas <farosas@suse.de>

