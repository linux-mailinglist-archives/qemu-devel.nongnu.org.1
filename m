Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3368FBD169C
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Oct 2025 07:13:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8AsT-00073z-HQ; Mon, 13 Oct 2025 01:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asmadeus@codewreck.org>)
 id 1v8AsR-00071x-BC
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 01:13:43 -0400
Received: from submarine.notk.org ([2001:bc8:3310:100::1])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <asmadeus@codewreck.org>) id 1v8AsP-0007qG-Kb
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 01:13:43 -0400
Received: from gaia.codewreck.org (localhost [127.0.0.1])
 by submarine.notk.org (Postfix) with ESMTPS id 61DB214C2DE;
 Mon, 13 Oct 2025 07:13:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
 s=2; t=1760332420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yxENwii5XhHJku+7B/6E+Q6/ihMKR23IlgOlemVyNP4=;
 b=cHMWYaD0G3t4JcQsznLeGJdj5bugmw0Eo56ltrIulbjjMuJZzOzhUjrGV3SB/ZQhp1yqjK
 YJoSEX20PDJsQ/LjWFV0BuBF1dEgyaAa4SABUPZi9POeblbVhlCaTmZOuGs2vaMbLIf4Ca
 0Re2X4SWg+GjG7vF22FC1/KvN9mS9RSA7gqaQinht08n52sji8cUHC8VzqigcAZQL3anhZ
 qFE3u3Y8Yqm4ZFoI4mUflmivFaP+arlkLYGjVUW7+2ewomWH8KpdR3gqgQMmSQAkt50RAk
 UW/MlPV4yrsxDKmAjtFgRG3ttD8H7rSmDpAWkUu9dXSkJ/CMwh99Fv2kWrOGbA==
Received: from localhost (gaia.codewreck.org [local])
 by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 85bf0468;
 Mon, 13 Oct 2025 05:13:33 +0000 (UTC)
Date: Mon, 13 Oct 2025 14:13:18 +0900
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
Subject: Re: [PATCH RFC v5 04/12] char-mux: add support for the terminal size
Message-ID: <aOyKbq4F-V_kYxhD@codewreck.org>
References: <20250921-console-resize-v5-0-89e3c6727060@gmail.com>
 <20250921-console-resize-v5-4-89e3c6727060@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250921-console-resize-v5-4-89e3c6727060@gmail.com>
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

Filip Hejsek wrote on Sun, Sep 21, 2025 at 01:45:34AM +0200:
> From: Szymon Lukasz <noh4hss@gmail.com>
> 
> The terminal size of a mux chardev should be the same as the real
> chardev, so listen for CHR_EVENT_RESIZE to be up to date.
> 
> We forward CHR_EVENT_RESIZE only to the focused frontend. This means
> frontends should update their view of the terminal size on
> receiving CHR_EVENT_MUX_IN.
> 
> Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>

Reviewed-by: Dominique Martinet <dominique.martinet@codewreck.org>
Tested-by: Dominique Martinet <dominique.martinet@codewreck.org>

--
Dominique Martinet | Asmadeus

