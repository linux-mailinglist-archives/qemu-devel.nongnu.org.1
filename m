Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE46776D8D
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 03:35:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTuZQ-00054K-NB; Wed, 09 Aug 2023 21:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTuZP-000546-Ei; Wed, 09 Aug 2023 21:34:35 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTuZN-0001P3-OK; Wed, 09 Aug 2023 21:34:35 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-686f94328a4so309743b3a.0; 
 Wed, 09 Aug 2023 18:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691631272; x=1692236072;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XQ9pKefyJp5v1WELZFm0Wa2aDjq4xGO7KrIiPXot3Q4=;
 b=eW2yzCDzctcBVg/65Rwx1ITJlolPpi1s0W04XWxNUW5QQFZAkEH/pd3oJGRjIK2FpD
 KIgXFRU41GPdNHyMStNCiYvZMGCLJsaeZ018exOMJF8YiCBuJGJ/pvzuCKxLd3iHLEAC
 Pe15HUgpQmOLMpIq+kpN/2hSTEEKLhLjSfV+ey/1yhnJInrbcBSKKeiBCGxTbeoPDTGT
 mrqLPNFPHoKraVyL3kvbM8xv+7u1EEjuaH1IMQ2qJQKQL5GNLGI1HQ2ylWEujZMK75Tn
 lyXLa9l4tg5srfMwssDMQhtt6cHEa8CtsvWIAJjm+70F9Ia8+t0sT9Ntrz6kbLsvEmlT
 EOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691631272; x=1692236072;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XQ9pKefyJp5v1WELZFm0Wa2aDjq4xGO7KrIiPXot3Q4=;
 b=keB3ZcKzNYEJdWWNlXt1Di+n+Ga8n/rDm/9kaprh0Vjs342CiQiVWPW7v8I+5VQVgs
 IXki34ZgGz8ahw8ovC7tdBCDwSzzT2fEibEXKeJUOsZ9L8PwkxeNdse+sJ8RgIiU3MBn
 aqXHoqfIpAWvAAXx59ww1VNlRPheD3A57qyKsiLPyeNK2VLWor2kCbCPQwfhpHrGL6lH
 EKSZgpRr46FiauFG2ttEZzQZFaLvo7qVq3pDdTsmEP8pEZ8ws3qdE+1EvLSCNheK8hAh
 PyRqPWAnkUY64KohG3TIZYfIArwA6lRKYG0Oc/qEzuqXuyOwdfIkDxPazl8p5kxvCSUY
 QqPg==
X-Gm-Message-State: AOJu0YyvAO4z8IXT8BDk+6T9yTjOzQnIFCnnle1Wjyrn9YBjKvyCeuAs
 gCO0UbHRgd7vrKGvsf6u4BlW4t3TlCU=
X-Google-Smtp-Source: AGHT+IEl9tkEGc7VJgCzYC6drAucIJeCIjW0DDTIh2rcoNMmhikz14xn3zzw80+3uj5wKXuSKxmSIA==
X-Received: by 2002:a05:6a00:1301:b0:687:1706:e8bf with SMTP id
 j1-20020a056a00130100b006871706e8bfmr781756pfu.10.1691631271968; 
 Wed, 09 Aug 2023 18:34:31 -0700 (PDT)
Received: from localhost (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 c9-20020a62e809000000b0064aea45b040sm226108pfi.168.2023.08.09.18.34.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 18:34:31 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Aug 2023 11:34:26 +1000
Message-Id: <CUOH8JPKIYFX.28OUSWNMQMQJR@wheely>
Cc: <qemu-ppc@nongnu.org>, <pavel.dovgaluk@ispras.ru>,
 <pbonzini@redhat.com>, <alex.bennee@linaro.org>, "Vitaly Cheptsov"
 <cheptsov@ispras.ru>
Subject: Re: [PATCH] hw/ppc/e500: fix broken snapshot replay
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Maksim Kostin" <maksim.kostin@ispras.ru>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230809100733.32189-1-maksim.kostin@ispras.ru>
In-Reply-To: <20230809100733.32189-1-maksim.kostin@ispras.ru>
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed Aug 9, 2023 at 8:07 PM AEST, Maksim Kostin wrote:
> ppce500_reset_device_tree is registered for system reset, but after
> c4b075318eb1 this function rerandomizes rng-seed via
> qemu_guest_getrandom_nofail. And when loading a snapshot, it tries to rea=
d
> EVENT_RANDOM that doesn't exist, so we have an error:
>
>   qemu-system-ppc: Missing random event in the replay log
>
> To fix this, use qemu_register_reset_nosnapshotload instead of
> qemu_register_reset.

This is the same issue that spapr machine hit, so that looks good.

But is there a problem that the device tree can change after the
machine reset? In that case your snapshot could resume with a
different device tree and replay will diverge.

It looks like software could just overwrite the device tree value
in memory. That seems to be why it's rebuilt at reset time. But
maybe you could just copy the machine->fdt again.

There is also qemu_fdt_randomize_seeds that some archs use that
we might be able to use for this, if it helps.

But this is better than nothing and probably a minimal fix, so
probably good to go upstream before more complicated changes.

Thanks,
Nick

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Reported-by: Vitaly Cheptsov <cheptsov@ispras.ru>
> Fixes: c4b075318eb1 ("hw/ppc: pass random seed to fdt ")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1634
> Signed-off-by: Maksim Kostin <maksim.kostin@ispras.ru>
> ---
>  hw/ppc/e500.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 67793a86f1..d5b6820d1d 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -712,7 +712,7 @@ static int ppce500_prep_device_tree(PPCE500MachineSta=
te *machine,
>      p->kernel_base =3D kernel_base;
>      p->kernel_size =3D kernel_size;
> =20
> -    qemu_register_reset(ppce500_reset_device_tree, p);
> +    qemu_register_reset_nosnapshotload(ppce500_reset_device_tree, p);
>      p->notifier.notify =3D ppce500_init_notify;
>      qemu_add_machine_init_done_notifier(&p->notifier);
> =20


