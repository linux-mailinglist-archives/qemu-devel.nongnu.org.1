Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA22710B28
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 13:35:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q28vR-0003lr-RQ; Thu, 25 May 2023 07:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q28vP-0003io-F1
 for qemu-devel@nongnu.org; Thu, 25 May 2023 07:14:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q28vN-0004Cb-QK
 for qemu-devel@nongnu.org; Thu, 25 May 2023 07:14:31 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 680CE21A8E;
 Thu, 25 May 2023 11:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1685013268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jOFhriZnR+1eLaIDmiZOxjmMynYYI+YkzKNvwbAlF60=;
 b=WX3vxU4L/h9ZrVs/SfCfbfw1uHNrbtVN9ymMxday5w9z8hYeTi+o51JOa6q3Zosd1/SlQb
 t+h3Soviho9pzYKfWWg87gX54xIiRSNvaDBCl7poZlmEtUQZLnOBnoHvIimYfGV0Mj1qX8
 m7xZ+v//2lKUrgA+tNBViZHjddS9XiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1685013268;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jOFhriZnR+1eLaIDmiZOxjmMynYYI+YkzKNvwbAlF60=;
 b=0wI+a24UVpaPtsCMUQQfIdJPQ/Zuj5VYKAcuqpQf4Zgap6YkPznMIF0e60D+VCSExtSf7y
 3btTD57H/1bswvDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E9AA913356;
 Thu, 25 May 2023 11:14:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4W5PLBNDb2T9EwAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 25 May 2023 11:14:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier
 <lvivier@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 3/4] tests/qtest/rtl8139-test: Check whether the rtl8139
 device is available
In-Reply-To: <20230525081016.1870364-4-thuth@redhat.com>
References: <20230525081016.1870364-1-thuth@redhat.com>
 <20230525081016.1870364-4-thuth@redhat.com>
Date: Thu, 25 May 2023 08:14:25 -0300
Message-ID: <874jo0br3i.fsf@suse.de>
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

> Though we are already using CONFIG_RTL8139_PCI in the meson.build file
> for testing whether the rtl8139 device is available or not, this is not
> enough: The CONFIG switch might have been selected by another target
> (e.g. the mips fuloong2e machine has the rtl8139 chip soldered on the
> board), so CONFIG_RTL8139_PCI ends up in config_all_devices and the
> test then gets executed on x86. We need an additional run-time check
> to be on the safe side to make this test also work when configure has
> been run with "--without-default-devices".
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>


