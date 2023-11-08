Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A86787E4E3D
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 01:47:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0WiT-0003k3-Ka; Tue, 07 Nov 2023 19:46:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r0WiR-0003jv-S0
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 19:46:43 -0500
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r0WiQ-0004wa-87
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 19:46:43 -0500
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-581f78a0206so3356940eaf.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 16:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699404401; x=1700009201; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PN0aRIuJdoohIewJeuenj5RGUM6PE4AwAzb9JtQcOJg=;
 b=Cx6436BMN1cqAoJNFuiV8THrkCXQq5dcvcZQ+ITxsm0axh2LqH0e/x/9rL42iMZkne
 Z2Uoxvo51Oo4++otVF+5PJd5YnFRywOnDR8S3LM79e9ROVOzt4JDv4K1RDZGhTf8zGYH
 +2yyQLU0FZX1p7ooA+jRiLG+sJAwlBbpfIaJvqFq/DCk52cUj9ILV+jbMGIKIL83ht9q
 T/J0NPWy+qgK1AdBl0TQ331c5Y/HkqweoAHRcMm5xHiR+XsrMIOv5tNeV6BpZqz7ep6w
 t093wrSEHjla8Q7Gd/pRo01aeRJofvy0eyNeyZ/I6Mg7SLEwFn5lnCC5lyE+grO3Nf1i
 WT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699404401; x=1700009201;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PN0aRIuJdoohIewJeuenj5RGUM6PE4AwAzb9JtQcOJg=;
 b=P8zN4KHnTU6VKIL4dCwC5709Jeag/y2qjRNHEIAKFn6Knzxu4V+igoSBxSYqSvCFC9
 5e/lSgJ42Xgurwc+g+h/8S6AH3Nlpkzw8i9PW81HEBJoOmfAVVQwJXZ5D2qG3raGH4fk
 5dp392XdyWeHkEtgokLieWcOhGO0UAQtXmy0PNtd0gSsX/tEStXqnNyMIyI1tsmUv0Wj
 yT5UkL9+e2ExL/wYbtumoxNwxIM2v5NXr0thhfEqEynmDRliybE7qWA8z+9C8zH4erKH
 HKQnCca0oqpPRMUHXzvyN693ctbLVgKURZrcHu01mkTV6Cfh2EgjQXijwEIIdsoOr6ij
 QBww==
X-Gm-Message-State: AOJu0Yx6AkPQWKqR5Q4i4HmQTDr7a/zWUFNQJVHocP5f42vBoKsdgA2M
 SkWekrEv2bfiNCrJTqi9qnOqAmwK9SzHoK9CvFw=
X-Google-Smtp-Source: AGHT+IE9vM8whP3HvwS46uUsqH3n5VKk0OWXIgCrEKqa+Md2tEt3EPWLSJR73c1BYkvR+luG6v77bhF9nd2sYO6Be0c=
X-Received: by 2002:a4a:e088:0:b0:587:873d:7e2c with SMTP id
 w8-20020a4ae088000000b00587873d7e2cmr432673oos.1.1699404400854; Tue, 07 Nov
 2023 16:46:40 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2311071310190.3478774@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2311071310190.3478774@ubuntu-linux-20-04-desktop>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 8 Nov 2023 08:46:28 +0800
Message-ID: <CAJSP0QVcHi41Fq_ms3vu6qhBTmd3fLFhf6_wqzvySwEY-BXFCQ@mail.gmail.com>
Subject: Re: [PULL 0/1] xen-virtio-fix-1-tag
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc29.google.com
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

On Wed, 8 Nov 2023 at 05:14, Stefano Stabellini <sstabellini@kernel.org> wrote:
>
> Minor bug fix for Virtio/Xen support
>
>
> The following changes since commit 462ad017ed76889d46696a3581e1b52343f9b683:
>
>   Merge tag 'xen-virtio-fix-1-tag' of https://gitlab.com/marcandre.lureau/qemu into staging (2023-11-07 19:00:03 +0800)
>
> are available in the Git repository at:
>
>   https://gitlab.com/sstabellini/qemu.git

What is the git ref that I should fetch? xen-virtio-fix-1-tag?

The gpg key that signed that tag has expired:

gpg: Signature made Wed 08 Nov 2023 05:08:23 HKT
gpg:                using RSA key D04E33ABA51F67BA07D30AEA894F8F4870E1AE90
gpg: Good signature from "Stefano Stabellini <sstabellini@kernel.org>" [expired]
gpg:                 aka "Stefano Stabellini
<stefano.stabellini@eu.citrix.com>" [expired]
gpg: Note: This key has expired!
Primary key fingerprint: D04E 33AB A51F 67BA 07D3  0AEA 894F 8F48 70E1 AE90
Does not appear to be a signed tag

Stefan

> for you to fetch changes up to 01bb72afbb95003fb5562e341a592f583e27e280:
>
>   Xen: Fix xen_set_irq() and xendevicemodel_set_irq_level() (2023-11-07 13:03:19 -0800)
>
> ----------------------------------------------------------------
> Vikram Garhwal (1):
>       Xen: Fix xen_set_irq() and xendevicemodel_set_irq_level()
>
>  hw/arm/xen_arm.c            | 4 +++-
>  include/hw/xen/xen_native.h | 4 ++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
>

