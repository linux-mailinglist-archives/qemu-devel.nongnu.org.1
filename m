Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA11BD1696
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Oct 2025 07:12:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Aqd-0006ES-4F; Mon, 13 Oct 2025 01:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asmadeus@codewreck.org>)
 id 1v8Aqa-0006E6-Nt
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 01:11:48 -0400
Received: from submarine.notk.org ([2001:bc8:3310:100::1])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <asmadeus@codewreck.org>) id 1v8AqZ-0007nL-6Q
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 01:11:48 -0400
Received: from gaia.codewreck.org (localhost [127.0.0.1])
 by submarine.notk.org (Postfix) with ESMTPS id 9CE2114C2DE;
 Mon, 13 Oct 2025 07:11:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
 s=2; t=1760332306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yys0QJE1T+un83xhtL/9x8bcIOj3RnN90v7UdMINz+s=;
 b=s/DIxy+191HfFOoR7LLJQj4HqKSclU9agZCl5jMG3xCiGDT8bUqNigzpjiJYUevxLUR/Fx
 Da7nBBCAns38kw14sn0ma5c7/UiS8UP2sq5RdxwbWL3V15zx07hAJp1cFNe0lgpYvpF5FQ
 m9Tg/1JsG9PM0vbCvbyqKhu9mEodTWD+0rzTiAON9bBDUqMXMEVBXwD/t4lsE4IY2CofT4
 L0KfXCAjiZrwYIimeciqyqEv7VF1sxyihGLz8kVPY9bNzC78FvhSlo3TQj0hcFOOl/oMzT
 3QIciKijLluYseZ1g/Sd6nk/nSABsXZsa+qFe/xqvQYiziNZHeRLpaYAMfqQ0g==
Received: from localhost (gaia.codewreck.org [local])
 by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 2b1641bd;
 Mon, 13 Oct 2025 05:11:39 +0000 (UTC)
Date: Mon, 13 Oct 2025 14:11:24 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
 Szymon Lukasz <noh4hss@gmail.com>
Subject: Re: [PATCH RFC v5 02/12] chardev: add CHR_EVENT_RESIZE
Message-ID: <aOyJ_CCuvNSxEpaT@codewreck.org>
References: <20250921-console-resize-v5-0-89e3c6727060@gmail.com>
 <20250921-console-resize-v5-2-89e3c6727060@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250921-console-resize-v5-2-89e3c6727060@gmail.com>
Received-SPF: pass client-ip=2001:bc8:3310:100::1;
 envelope-from=asmadeus@codewreck.org; helo=submarine.notk.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Filip Hejsek wrote on Sun, Sep 21, 2025 at 01:45:32AM +0200:
> From: Szymon Lukasz <noh4hss@gmail.com>
> 
> Add a new chardev event, CHR_EVENT_RESIZE, which a backend should
> trigger if it detects the size of the connected terminal changed.
> 
> Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>

Reviewed-by: Dominique Martinet <dominique.martinet@codewreck.org>
Tested-by: Dominique Martinet <dominique.martinet@codewreck.org>

--
Dominique Martinet | Asmadeus

