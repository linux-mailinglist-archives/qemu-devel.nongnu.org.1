Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 645FEA19020
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Jan 2025 11:47:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taYFN-0006Ar-Ax; Wed, 22 Jan 2025 05:46:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1taYF8-00068b-Mg
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 05:45:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1taYF5-00038A-KS
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 05:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737542751;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H0ezmLNRc+dY13l3WQ1ASeSxqFaS+7aY1B9Ht/jPH1o=;
 b=E8qHCBOrdv8hCfXXj5OTCy9JRQr+NHJ3RcmOmcQb3hg7VNMgPa5d3bPSAPWrJYbnRO8Ar6
 FJXSuHQNUxI7g/MpUHSEWv1izaYIbReMPjFtlstrmnmL8Muw6SY/nXg+pzgjaZcb5Idyh2
 UjT/WvB4ysL/Gu42T4t9u20qNmGkQMQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686--Nls20rgMRuffKSpAerpVw-1; Wed,
 22 Jan 2025 05:45:45 -0500
X-MC-Unique: -Nls20rgMRuffKSpAerpVw-1
X-Mimecast-MFC-AGG-ID: -Nls20rgMRuffKSpAerpVw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E8CF19560A2; Wed, 22 Jan 2025 10:45:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.43])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5593195608E; Wed, 22 Jan 2025 10:45:40 +0000 (UTC)
Date: Wed, 22 Jan 2025 10:45:37 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH] hw/boards: Convert MachineClass bitfields to boolean
Message-ID: <Z5DMUVoEcaO4Mzp2@redhat.com>
References: <20250122103223.55523-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250122103223.55523-1-philmd@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.086,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Jan 22, 2025 at 11:32:23AM +0100, Philippe Mathieu-Daudé wrote:
> As Daniel mentioned:
> 
>  "The number of instances of MachineClass is not large enough
>   that we save a useful amount of memory through bitfields."
> 
> Also, see recent commit ecbf3567e21 ("docs/devel/style: add a
> section about bitfield, and disallow them for packed structures").

Also developers incorrectly think these are already booleans:

$ git grep  -E '\b(no_parallel|no_serial|no_floppy|no_cdrom|no_sdcard|pci_allow_0_address|legacy_fw_cfg_order)\b' | grep -E '(true|false)'
hw/arm/sbsa-ref.c:    mc->pci_allow_0_address = true;
hw/arm/virt.c:    mc->pci_allow_0_address = true;
hw/arm/xlnx-versal-virt.c:    mc->no_cdrom = true;
hw/m68k/next-cube.c:    mc->no_cdrom = true;
hw/ppc/spapr.c:    mc->pci_allow_0_address = true;
hw/riscv/virt.c:    mc->pci_allow_0_address = true;

> 
> Convert the MachineClass bitfields used as boolean as real ones.
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/boards.h        | 14 +++++++-------
>  hw/arm/aspeed.c            |  6 +++---
>  hw/arm/fby35.c             |  4 ++--
>  hw/arm/npcm7xx_boards.c    |  6 +++---
>  hw/arm/raspi.c             |  6 +++---
>  hw/arm/sbsa-ref.c          |  2 +-
>  hw/arm/virt.c              |  2 +-
>  hw/arm/xilinx_zynq.c       |  2 +-
>  hw/avr/arduino.c           |  6 +++---
>  hw/core/null-machine.c     | 10 +++++-----
>  hw/i386/microvm.c          |  2 +-
>  hw/i386/pc_piix.c          |  2 +-
>  hw/i386/pc_q35.c           |  4 ++--
>  hw/loongarch/virt.c        |  2 +-
>  hw/m68k/virt.c             |  6 +++---
>  hw/ppc/pnv.c               |  2 +-
>  hw/ppc/spapr.c             |  2 +-
>  hw/riscv/virt.c            |  2 +-
>  hw/s390x/s390-virtio-ccw.c |  8 ++++----
>  hw/xtensa/sim.c            |  2 +-
>  20 files changed, 45 insertions(+), 45 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


