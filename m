Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A60791657
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 13:43:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd7yW-0006lk-19; Mon, 04 Sep 2023 07:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qd7yP-0006lV-8u
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:42:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qd7yN-000649-0H
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693827745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hM/U8uGbMUBuvfOwJEsKQBhoJ7uwhgVWu/D20rxgaKw=;
 b=JDNTQWrLGBh2vuFLt0uJIHrFJLZsrJIrMhf4WHA2olQC/3qEZDI8L8vUymKJUfgVVUBGbv
 Vg09lZCVvkrD+cWu/yPJmkaN8UkRasujfaCYQHUX+Ph5Ud6n7z3tx9/rCnypRac/WGpmeg
 A0H1l+dgmaK6nsyeZ6l8vsYf44t8dtE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-vU7oRnSaOSyN04_QlPohVw-1; Mon, 04 Sep 2023 07:42:22 -0400
X-MC-Unique: vU7oRnSaOSyN04_QlPohVw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DAA923804519;
 Mon,  4 Sep 2023 11:42:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 68F36C02996;
 Mon,  4 Sep 2023 11:42:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 103F818007A8; Mon,  4 Sep 2023 13:42:20 +0200 (CEST)
Date: Mon, 4 Sep 2023 13:42:20 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: lixianglai <lixianglai@loongson.cn>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, 
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>
Subject: Re: [PATCH] roms: Support compile the efi bios for loongarch
Message-ID: <lx3zo3f2ox5d4cgi2rhce2mikiiqetdngvzhfaxx5tnsz65vtr@al2euj2s7m6j>
References: <260307952ffe5382a55d66a4999034490e04f7df.1691653307.git.lixianglai@loongson.cn>
 <41a215d5-4ae6-dfa3-a61e-c21fd8ca311d@linaro.org>
 <0cc3d20d-e849-9e2d-7560-fd694a412032@loongson.cn>
 <c9f1e257-0875-21cf-4bbb-f678aab6b60c@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9f1e257-0875-21cf-4bbb-f678aab6b60c@loongson.cn>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

  Hi,

> The loongarch cross-compilation tool on the fedora38 operating system is a
> bit old,

The gcc 12 -> 13 update for the cross compilers landed meanwhile,
right now we have:

    binutils-loongarch64-linux-gnu.x86_64 2.39-4.fc38    @updates
    gcc-loongarch64-linux-gnu.x86_64      13.2.1-1.fc38  @updates

Trying to build the loongarch firmware throws errors
(edk2/edk2-platforms repos, master branch, checkout
being a few days old):

build.py...
/home/kraxel/projects/edk2-platforms/Platform/Loongson/LoongArchQemuPkg/Loongson.dsc(...): error 4000: Instance of library class [AcpiPlatformLib] is not found
	in [/home/kraxel/projects/edk2/OvmfPkg/AcpiPlatformDxe/AcpiPlatformDxe.inf] [LOONGARCH64]
	consumed by module [/home/kraxel/projects/edk2/OvmfPkg/AcpiPlatformDxe/AcpiPlatformDxe.inf]

take care,
  Gerd


