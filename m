Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D797BD83B
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 12:11:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpnES-0004qh-BL; Mon, 09 Oct 2023 06:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1qpnED-0004q1-KT; Mon, 09 Oct 2023 06:11:09 -0400
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1qpnEB-0001vq-4a; Mon, 09 Oct 2023 06:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qTN9vsIsSJwyrRFyywPHlqV3v5to6QoTYdEv9vWc6Pw=; b=fFVHMscb8u7ttHfYHlgXwrJIQh
 pjr+EisoImRUn7TMhg57a1J74oA2qAiTtbfXH5Z34KA8Iv2GKyDb0Z870NV/x5R1Q1LsyvauQR3oA
 5Na/Fl8vioxwyOwKqNQ9J1yZaSREaDo0Jh1XCx3aRB8qCBlOURj9Z9BQQJBd1KwVfS/c0QIwdJcJn
 3o+uaiI8SRW9Jcriw5I5vRsnehZk72aUJYrCT1dfY3kpseZY/RDiUSesv3lawzccCTVYHLEQ2DRpf
 AZ4fxU9WAyn1so9TjQiubooPuPTwvZH3NbEBM26bVpiAbDTQcajqcJ6SsA5XqyDS3CzZfitYV4O+0
 98E2vrKA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1qpnDx-00G2Un-DD; Mon, 09 Oct 2023 12:10:53 +0200
Received: from gate.service.igalia.com ([192.168.21.52])
 by mail.igalia.com with esmtp (Exim)
 id 1qpnDv-000o2x-B0; Mon, 09 Oct 2023 12:10:53 +0200
Received: from berto by gate.service.igalia.com with local (Exim 4.96)
 (envelope-from <berto@igalia.com>) id 1qpnDv-006E3C-0a;
 Mon, 09 Oct 2023 10:10:51 +0000
From: Alberto Garcia <berto@igalia.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Hao Wu <wuhaotsh@google.com>, Kevin Wolf
 <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>, Tyrone Ting
 <kfting@nuvoton.com>, Markus Armbruster <armbru@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 02/10] tests/throttle: Clean up global variable shadowing
In-Reply-To: <20231009100251.56019-3-philmd@linaro.org>
References: <20231009100251.56019-1-philmd@linaro.org>
 <20231009100251.56019-3-philmd@linaro.org>
Date: Mon, 09 Oct 2023 10:10:51 +0000
Message-ID: <w51mswsw1g4.fsf@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon 09 Oct 2023 12:02:43 PM +02, Philippe Mathieu-Daud=C3=A9 wrote:
> Follow all other tests pattern from this file, use the
> global 'cfg' variable to fix:
>
>   tests/unit/test-throttle.c:621:20: error: declaration shadows a variabl=
e in the global scope [-Werror,-Wshadow]
>       ThrottleConfig cfg;
>                      ^
>   tests/unit/test-throttle.c:28:23: note: previous declaration is here
>   static ThrottleConfig cfg;
>                         ^
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Acked-by: Alberto Garcia <berto@igalia.com>

Berto

