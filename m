Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C305736EE4
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 16:40:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBcVO-0003eI-Sg; Tue, 20 Jun 2023 10:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBcVM-0003e3-Dc
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 10:38:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBcVK-0006cW-VR
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 10:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687271916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D4zZXJ2c+zp7ySJseouEXjg/zHulHK8C6OARQyIXdHk=;
 b=Ld4hIkbdGmbUvEOlKkr6v+enQfavGmNUydvcnNxcy58OpZSmdU1LdvCbPi3+/029HoGE9E
 NvTfB/RAywmwyVx0YO6byYatu13SCiWalIC5rSMMSK0vQJIVP6RfdVeOtPkFLRZCU92kCL
 j7Rm/WuzrSTM7Ta7I9EL/pWA/sG4Wn8=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-028ENuWpMymth7b1MN8TVA-1; Tue, 20 Jun 2023 10:38:35 -0400
X-MC-Unique: 028ENuWpMymth7b1MN8TVA-1
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-471b1bbbfc1so460182e0c.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 07:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687271909; x=1689863909;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D4zZXJ2c+zp7ySJseouEXjg/zHulHK8C6OARQyIXdHk=;
 b=QtOXhgbZYhXI4TNXaApEB4/E4HU0r2pNQVBEUj/2w48rjhbZkBS26Dj+icdxQDRKYR
 Y/KEb3ga7joknJgqlqtJdUP0aefnaND49zvH4SQaxx00WKPOap2201ztLeEd3dGFQ71D
 mJ1KXD2cyZVpRexPPs1cf3xil0J8nPlPIucIL8O48MMv83R+q+5HCpqup9cHU2XecdJW
 PS5LGTyd3EGKcZZ450hZRq60MRx1rVqo8zVqDW0vewBocJGKVhlWhnVQwPlSiizH1hQB
 oXdNMI3rKxF/wnJ8dXya5P/9XjM7VBJjIZYMaAFEipwDSJG6DZI79+WGybCWbusHOvP0
 pY3A==
X-Gm-Message-State: AC+VfDz/Dn1/DG3PHpGTs8VoLFnDlzfe3O+UQ8YLjSfwH+2rg9s1iObK
 UWG1YEuXxiCDWOdonTxiMvAyqf/IeyzHIMciY+cLSNT2I1Y/3RLxSrHJz47oI/Z5ZAah9OSLR1a
 2TosZyrfo3Q5oTkxc98dhGry+n/xJuVRCBRAHGqw=
X-Received: by 2002:a67:fb84:0:b0:43f:550d:a329 with SMTP id
 n4-20020a67fb84000000b0043f550da329mr2756099vsr.6.1687271909205; 
 Tue, 20 Jun 2023 07:38:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6s/0/Ed/lRgRy/bzr2bBQr8e3/0MhX4jZnpra9QwXTyWVsAnE3F1cVnYz4JWpOblJBXVZI9lN26M/oS/5XobU=
X-Received: by 2002:a67:fb84:0:b0:43f:550d:a329 with SMTP id
 n4-20020a67fb84000000b0043f550da329mr2756085vsr.6.1687271908907; Tue, 20 Jun
 2023 07:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230618215114.107337-1-pbonzini@redhat.com>
 <20230618215114.107337-7-pbonzini@redhat.com>
 <e137adbf-f1cd-2d2a-a45b-359bacb32c75@linaro.org>
In-Reply-To: <e137adbf-f1cd-2d2a-a45b-359bacb32c75@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 20 Jun 2023 16:38:17 +0200
Message-ID: <CABgObfaJebXQzP9Kwd2YYT5+EgtjgYuongdAE7ggeh-9q4HHiA@mail.gmail.com>
Subject: Re: [PATCH 6/7] target/i386: implement RDPID in TCG
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 19, 2023 at 9:40=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
> What is our minimum glibc version?  This requires 2.29.

Ok, I'll add a test to meson.build.

> Also, not especially fond of the placement.  target/ including linux-user=
/ header isn't
> nice.  Might as well just place these 3 lines in misc_helper.c to begin.

Ok. Can be revisited later if BSD needs it, or split between sysemu/
and user/ so that the include is less jarring.

Thanks,

Paolo


