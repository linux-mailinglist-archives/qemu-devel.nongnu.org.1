Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F1BB1B7EF
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Aug 2025 18:06:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujK9N-0003ve-P8; Tue, 05 Aug 2025 12:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujK57-0008Hn-OC
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 12:00:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujK54-0005mh-DD
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 12:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754409600;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=SIscS+7Kcd6vjwYpEERr7sDVUJc7MuIS6841SYw8F+Q=;
 b=fMcGBN4zvE3x1q4Kcu5YpBDvgYdXCfUxmc79Ihy+FAibkNHkcMV9hun3D8Udgzq406ZIUv
 mzvf5bTyCypGTL8pttYC9GcyuWFfSmnxRN6o97MA5005/SPBvL5j+SycqEM1EXWTPJORSt
 qjpiADvGWF3fffzBt+nm1zldpc+T0RE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-8Jf-ENdRNEmtSseZR_zl0A-1; Tue,
 05 Aug 2025 11:59:57 -0400
X-MC-Unique: 8Jf-ENdRNEmtSseZR_zl0A-1
X-Mimecast-MFC-AGG-ID: 8Jf-ENdRNEmtSseZR_zl0A_1754409596
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 032A51800446; Tue,  5 Aug 2025 15:59:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.80])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B04E1955E88; Tue,  5 Aug 2025 15:59:52 +0000 (UTC)
Date: Tue, 5 Aug 2025 16:59:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH RFC] util/error.c: Print backtrace on error
Message-ID: <aJIqdQSYXO4K6lCJ@redhat.com>
References: <20250805-backtrace-v1-1-d189d09b1e92@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250805-backtrace-v1-1-d189d09b1e92@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 05, 2025 at 12:19:26PM +0300, Manos Pitsidianakis wrote:
> Add a backtrace_on_error meson feature (enabled with
> --enable-backtrace-on-error) that compiles system binaries with
> -rdynamic option and prints a function backtrace on error to stderr.
> 
> Example output by adding an unconditional error_setg on error_abort in hw/arm/boot.c:
> 
>   ./qemu-system-aarch64(+0x13b4a2c) [0x55d015406a2c]
>   ./qemu-system-aarch64(+0x13b4abd) [0x55d015406abd]
>   ./qemu-system-aarch64(+0x13b4d49) [0x55d015406d49]
>   ./qemu-system-aarch64(error_setg_internal+0xe7) [0x55d015406f62]
>   ./qemu-system-aarch64(arm_load_dtb+0xbf) [0x55d014d7686f]
>   ./qemu-system-aarch64(+0xd2f1d8) [0x55d014d811d8]
>   ./qemu-system-aarch64(notifier_list_notify+0x44) [0x55d01540a282]
>   ./qemu-system-aarch64(qdev_machine_creation_done+0xa0) [0x55d01476ae17]
>   ./qemu-system-aarch64(+0xaa691e) [0x55d014af891e]
>   ./qemu-system-aarch64(qmp_x_exit_preconfig+0x72) [0x55d014af8a5d]
>   ./qemu-system-aarch64(qemu_init+0x2a89) [0x55d014afb657]
>   ./qemu-system-aarch64(main+0x2f) [0x55d01521e836]
>   /lib/x86_64-linux-gnu/libc.so.6(+0x29ca8) [0x7f3033d67ca8]
>   /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0x85) [0x7f3033d67d65]
>   ./qemu-system-aarch64(_start+0x21) [0x55d0146814f1]
> 
>   Unexpected error in arm_load_dtb() at ../hw/arm/boot.c:529:

From an end-user POV, IMHO the error messages need to be good enough
that such backtraces aren't needed to understand the problem. For
developers, GDB can give much better backtraces (file+line numbers,
plus parameters plus local variables) in the ideally rare cases that
the error message alone has insufficient info. So I'm not really
convinced that programs (in general, not just QEMU) should try to
create backtraces themselves.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


