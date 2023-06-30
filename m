Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BA37444C2
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 00:17:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFMPT-0004mf-Eh; Fri, 30 Jun 2023 18:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qFMPJ-0004jv-G5
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 18:16:03 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qFMPG-0005Sh-LU
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 18:16:00 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-51bece5d935so2780353a12.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 15:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688163355; x=1690755355;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dhY4C5ZJRIijV3cIrjXpWAgQASRDI4B2VavHCpYmPB8=;
 b=M66Y8n3c5PBxCGpMSo4iaQl7x/9p03Qe8YKlCL7sjhjJiKMNgJFQU08+25pwfPEgtE
 61XyQBRIckB+XNuWqjM8GVuy8e7UTrqMG2rRBIyanbWcflivubIw26Gil4ZLqJGCoiBz
 zFI86tNBpbXBaubfXrMXPOB2DjemjSw+ZO3GiBokVsB1GQPurcpedSH3pAe4SmHBGfdi
 320EOSGlvu0lbVV2r3rMneh4F330B/zaY6Eq+1D5pZ4s+wz3NgAScCkzBlje2hHShkFx
 rIhTymtuZ4vADVgUjVJMZQQ5q5GRpS0r2fOwAYWw+PzOokpfauqVLrs5nT7Gq4AIyXvN
 aqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688163355; x=1690755355;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dhY4C5ZJRIijV3cIrjXpWAgQASRDI4B2VavHCpYmPB8=;
 b=hq5iKYj4qT0N9AQjJm8L/Uv+K8vS1UpyBpomr7QS+PjSVlYm1sK3RKiphytgY/KvrR
 hDlZLY0j+oVdNUDsUBoo8C+OYOgg0nLAFFSC3tM9h8qEKs221yCNzIGd05+pjw/2Q5Qx
 /Pu/1OKmtq5gw6J0RGOl3i600KDw+J0/vawJvION1oPG5bGXMKIsWjCJ/OBnJ+cEKwvl
 vqWVmjpikluKiWyDAH9EBBC1jj2Ki/11Xi7NQMliB3MLCIt3kDlYhAWTdON0txP3pOh4
 hlATsBK3JO6v+UD4oFNm0XVksnOqCoWfhvPwFnZtzYSjp6i4TsSxaB5l0vs99fOUUS5h
 tLJQ==
X-Gm-Message-State: ABy/qLbF3pl26wh8hoGml0gvLk+yIuMJnNawJaeMD1gkelVrVvI46x+b
 X5J5uLRUXPiUBGkY/0U6Sos=
X-Google-Smtp-Source: APBJJlE6VPs33xp/N2N5bZ0za/J9ybzkK8/WVyZkxJ5BocgkkNrAJuSEnOUZU57Mk3FP+UZjXUzcpA==
X-Received: by 2002:aa7:d390:0:b0:51d:9b4d:66bd with SMTP id
 x16-20020aa7d390000000b0051d9b4d66bdmr2611559edq.9.1688163355371; 
 Fri, 30 Jun 2023 15:15:55 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-089-012-063-194.89.12.pool.telefonica.de.
 [89.12.63.194]) by smtp.gmail.com with ESMTPSA id
 e13-20020a50fb8d000000b0051d80d7a95bsm7012099edq.14.2023.06.30.15.15.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 15:15:54 -0700 (PDT)
Date: Fri, 30 Jun 2023 22:15:45 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Olaf Hering <olaf@aepfle.de>
CC: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH v2] piix: fix regression during unplug in Xen HVM domUs
In-Reply-To: <20230630133242.58e6d9ed.olaf@aepfle.de>
References: <20210317070046.17860-1-olaf@aepfle.de>
 <4441d32f-bd52-9408-cabc-146b59f0e4dc@redhat.com>
 <20210325121219.7b5daf76.olaf@aepfle.de>
 <dae251e1-f808-708e-902c-05cfcbbea9cf@redhat.com>
 <20230509225818.GA16290@aepfle.de> <20230626231901.5b5d11c1.olaf@aepfle.de>
 <c939b695-2b68-085a-0f19-108ecdcc1a05@redhat.com>
 <5DB37FA5-41DF-4ED6-8C8A-CDDD6F276F42@gmail.com>
 <20230627140740.2736f6e8.olaf@aepfle.de>
 <4F5609FD-4A89-4450-89E2-3311CC5A9317@gmail.com>
 <20230630092921.392b302d.olaf@aepfle.de>
 <367317C5-DB65-40EF-B45B-97E0E802A994@gmail.com>
 <20230630133242.58e6d9ed.olaf@aepfle.de>
Message-ID: <EEF26EF5-F7EF-4F61-BB32-DEBC2C68E5A1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



Am 30=2E Juni 2023 11:32:42 UTC schrieb Olaf Hering <olaf@aepfle=2Ede>:
>Fri, 30 Jun 2023 08:05:29 +0000 Bernhard Beschow <shentey@gmail=2Ecom>:
>
>> Yes=2E Have a look for piix3/piix4 here: https://www=2Eintel=2Ecom/desi=
gn/archives/chipsets/440/index=2Ehtm
>
>This is hidden behind a login or whatever=2E

None of the links ask annoying questions in my case=2E

Best regards,
Bernhard

>
>I should be able to come up with a commit message without hardware specs =
being available=2E
>
>
>Olaf

