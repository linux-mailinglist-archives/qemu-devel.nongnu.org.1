Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 281B07E9AC0
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 12:10:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Up6-0000uT-9l; Mon, 13 Nov 2023 06:09:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r2Uon-0000aY-U4
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 06:09:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r2Uom-0001Q6-2i
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 06:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699873758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uRb6VR66fyu8Qw94CTyi59aEQoZfP018pw3f6l2Tygw=;
 b=hTS4iO2E31oVvwnnAhkcKOYEmMKJCS857ljQShZRYTkycUfSfRn871l8WzcBAFf75JR18p
 XJy+mzRect7BENSNA1eXwwT2FUY5hBKcE3a1FHoKOthFVqzsD6bVhE+3AH+OR6J/Z2ZBW5
 77vnKzU7ew1jRRMxMXV88HJM6p4v8Gs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-Kb59maLtM2mR8VLCapEDig-1; Mon,
 13 Nov 2023 06:09:16 -0500
X-MC-Unique: Kb59maLtM2mR8VLCapEDig-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 278FE3C0C485;
 Mon, 13 Nov 2023 11:09:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.194.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E5FF21121306;
 Mon, 13 Nov 2023 11:09:15 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A20C81804A63; Mon, 13 Nov 2023 12:09:14 +0100 (CET)
Date: Mon, 13 Nov 2023 12:09:14 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Akihiko Odaki <akihiko.odaki@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PULL 0/8] Firmware/edk2 20230918 patches
Message-ID: <jn7jj2lcb5qab7kpi3x46xhli257h7wqyk5ioe74a3etjdl4ga@uz3imwwenks6>
References: <20230918133338.2399701-1-kraxel@redhat.com>
 <7d866ee2-a166-457b-8137-4791caaff3cc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d866ee2-a166-457b-8137-4791caaff3cc@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

> Hi,
> 
> This apparently broke EDK2 for AArch64. I tried the following command:
> build/qemu-system-aarch64 -drive
> file=build/pc-bios/edk2-aarch64-code.fd,format=raw,if=pflash,readonly=on -M
> virt -cpu max -nographic -cdrom Fedora-Silverblue-ostree-aarch64-37-1.7.iso

https://bugzilla.redhat.com/show_bug.cgi?id=2113005

tl:dr:  shim is broken, and recent edk2 starting to expose
EFI_MEMORY_ATTRIBUTE_PROTOCOL makes the bug visible (without
the protocol the buggy code path is never taken).

take care,
  Gerd


