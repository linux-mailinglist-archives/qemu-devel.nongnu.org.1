Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17567AF0F50
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Jul 2025 11:12:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWtVX-0007uu-W6; Wed, 02 Jul 2025 05:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uWtVV-0007uf-2s
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 05:11:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uWtVS-0007NW-2y
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 05:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751447511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nTeiDQfgTpuLIfDJVU4DnZ+Vs01tDZ/Gh0tPGf0RwYs=;
 b=fouSWhilcWqvif1Xsf3z1jZHuxl2Z7tLtbG9upLfKkVBzr7fZgRYS4prWNnQTdtBQo14qH
 nQ0sQFGlcQRrpITDGBXKo+xi+c5LLQBY9D48m4sMkXwquBgD0AC4ih38hp4vBSkgAK1E+N
 1l9zZqOqnqaU+q/sZMjC5nqpP4+r1a4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-TkJf2VLIPnmOb352FoxrbA-1; Wed,
 02 Jul 2025 05:11:47 -0400
X-MC-Unique: TkJf2VLIPnmOb352FoxrbA-1
X-Mimecast-MFC-AGG-ID: TkJf2VLIPnmOb352FoxrbA_1751447506
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 834CD180136B; Wed,  2 Jul 2025 09:11:45 +0000 (UTC)
Received: from localhost (dhcp-192-236.str.redhat.com [10.33.192.236])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15A8E1956087; Wed,  2 Jul 2025 09:11:43 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Roman Bolshakov <rbolshakov@ddn.com>, Thomas Huth
 <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, Wei Liu
 <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Wei Liu
 <liuwe@microsoft.com>, Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Markus
 Armbruster <armbru@redhat.com>, Magnus Kulke <magnuskulke@microsoft.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 05/27] include/hw/hyperv: Add MSHV ABI header
 definitions
In-Reply-To: <20250701172834.44849-6-magnuskulke@linux.microsoft.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20250701172834.44849-1-magnuskulke@linux.microsoft.com>
 <20250701172834.44849-6-magnuskulke@linux.microsoft.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Wed, 02 Jul 2025 11:11:41 +0200
Message-ID: <8734bfq7n6.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 01 2025, Magnus Kulke <magnuskulke@linux.microsoft.com> wrote:

> Introduce headers for the Microsoft Hypervisor (MSHV) userspace ABI,
> including IOCTLs and structures used to interface with the hypervisor.
>
> These definitions are based on the upstream Linux MSHV interface and
> will be used by the MSHV accelerator backend in later patches.
>
> Note that for the time being the header `linux-mshv.h` is also being
> included to allow building on machines that do not ship the header yet.
> The header will be available in kernel 6.15 (at the time of writing
> we're at -rc6) we will probably drop it in later revisions of the
> patch set.

The right way to handle header updates is to split the linux-header
updates into a "dummy" update (that just adds the header) and replace
that patch with a proper header update once the changes hit Linux
mainline.

I have not looked at the contents of the series otherwise -- but if this
is a system header (and not something that defines the kernel<->vmm
interface), how do you make sure that your system has that installed?
Maybe I'm misunderstanding.


