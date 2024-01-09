Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F260382815D
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 09:31:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN7Uq-0003Ui-5j; Tue, 09 Jan 2024 03:30:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rN7Ug-0003TW-Mt; Tue, 09 Jan 2024 03:29:55 -0500
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rN7Ue-0003yT-8T; Tue, 09 Jan 2024 03:29:54 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (Client did not present a certificate)
 by zoidberg.rfc1149.net (Postfix) with ESMTPSA id 4568180026;
 Tue,  9 Jan 2024 09:29:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rfc1149.net; s=smtp;
 t=1704788987; bh=8255yFKtZgQ1dqXQ7zPrXu5DImJwFdNFD0bVNeJGHp4=;
 h=References:From:To:Cc:Subject:Date:In-reply-to;
 b=YRP78kYb74cSrIptkhSGVjnsqCKshOSZIlDUt66naAwGi3JPMIsP5NS/aYHVEKhxT
 TKMK4xxh98ncyp2W8cjOhquiY7eIb0WlKQVZn3deRB5jMWCimAvUAW6nCdybDYvmsi
 9BQg3tw5KWZkMqBZn+X7RrSFnaePE500RmNFB1ejfEBwXIunVCDboAE0AsHrkG/q5j
 ZfgeiyayaIldvJKYlfylKJVpZ0asbjhEwCFxOopxVdbvsDaw0G/qfuoLwsOtB7UGl+
 8OxOXBe6nlmd5reAyNWxKk1HKFnboUyN+vnuSPeMNwQKikWq6dObY2zxfxeBiyh4LM
 LuBGjS6uk2Wtw==
References: <20240108171523.2487291-1-sam@rfc1149.net>
 <20240108171523.2487291-2-sam@rfc1149.net>
 <55b697ed-381f-47f8-bcaa-d8258c75b2a2@linaro.org>
User-agent: mu4e 1.10.8; emacs 29.1
From: Samuel Tardieu <sam@rfc1149.net>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Magnus Damm <magnus.damm@gmail.com>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, devel@lists.libvirt.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH 1/2] target/sh4: Deprecate the shix machine
Date: Tue, 09 Jan 2024 09:29:33 +0100
In-reply-to: <55b697ed-381f-47f8-bcaa-d8258c75b2a2@linaro.org>
Message-ID: <871qaqzz7p.fsf@rfc1149.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=195.154.227.159; envelope-from=sam@rfc1149.net;
 helo=zoidberg.rfc1149.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

>>       mc->default_cpu_type =3D TYPE_SH7750R_CPU;
>> +    mc->deprecation_reason =3D "old and unmaintained - use a=20
>> newer machine instead";
>
> "use a newer machine instead" bugs me, what would that be?
>
> Could we stick to "old and unmaintained"?

You're right. I removed the extra part in both the shix and the=20
tc58128 deprecation messages.

  Sam
--=20
Samuel Tardieu

