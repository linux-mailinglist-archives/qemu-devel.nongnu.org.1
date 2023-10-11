Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 612757C5838
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 17:39:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqbIb-0000cb-Pn; Wed, 11 Oct 2023 11:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qqbIU-0000P4-Tq; Wed, 11 Oct 2023 11:38:56 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qqbIT-0001je-69; Wed, 11 Oct 2023 11:38:54 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-57b6a7e0deeso4114901eaf.2; 
 Wed, 11 Oct 2023 08:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697038731; x=1697643531; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jf7GpPCsEnly/lZZa9FVIoXSWQ7Np5F4jDc1RPG5f6I=;
 b=ZU3/KO85TgAzXYol/xbwZ4XnYJSW312MMm+ctM7pJc56d/M9m7gByyn9td/CCSx47F
 v0m0YK6cohENsqBz5vui57IliZi5SGUZ65H6hlfzW3wD5eEanLoWmSN7YdPf6Z5vA26H
 mSesCHyudq5akHFA7M70u/j6M8z7AOCh4Zt0pC/UyF91N64wJc7bnIy/m2ENjk9aaGcb
 vl/2T9C/6Drb42czjZStV+K6BGc6RJjupszL1iFyBL3C7wxuPzgse5F4+J4/RbHGOFnM
 jRy5pvw8lxDRbAcu0WzNhsFukmTpJYJEM27Cv0TsB5JNhUlKT+AOa6qhiKhzoCdlzkiX
 1mkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697038731; x=1697643531;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jf7GpPCsEnly/lZZa9FVIoXSWQ7Np5F4jDc1RPG5f6I=;
 b=lIzrqj196y2SyAIUpEf35iKWLHBQEDjP3u64kwef1HlQhJ7jsH4/r70eXSW4LhcTWe
 nRuN8I7PxGOSMfm0uvQ6MB7qAhJMsEbcfjsDc0BtBKFgWqg/9lpHP3h/UyMjC7+vJ2sl
 t+ZvZDFhAQqmSq72lW7CaSQjYDUhmDWMQ29QgN4GwUQ9vqXIDu4RuWr9Q8eExo16GqsG
 JAXlZkhSCafTi11LQnRask7rr96QMkCGqlEX5rq5hdruQutfnpZ4eFuxd4nsj3tp3Y7u
 MyMfJAMx1GInEpXOChl0bBHfFwwZ0bs1cMM6hUeau9B3NrMFFL0cuYv778BoEP8v7p3x
 jzKg==
X-Gm-Message-State: AOJu0YzYbYFx169pD4yx68uSmFM4SEt897CyIFe7LayrwnD8y6wy/5Cm
 RBW2/E/ddf0MW03GssLRYlI0wfm0pl1EOEfHKHA=
X-Google-Smtp-Source: AGHT+IG2fSoa4RI2xTP7/k4x0aAOvYPBBUql1FVFhgcRsJ3pgqxHmzlT4No3/sPL/I2qreEjBISYPcxOrR6iSq3/a+s=
X-Received: by 2002:a4a:9d12:0:b0:56c:d297:164c with SMTP id
 w18-20020a4a9d12000000b0056cd297164cmr21964901ooj.4.1697038731096; Wed, 11
 Oct 2023 08:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231011112054.1031975-1-mjt@tls.msk.ru>
 <20231011112054.1031975-3-mjt@tls.msk.ru>
In-Reply-To: <20231011112054.1031975-3-mjt@tls.msk.ru>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 11 Oct 2023 11:38:38 -0400
Message-ID: <CAJSP0QVkuu4EbW5gKmrN6Gotnhw1LG+ka=6vjuftPXBrKY+R3g@mail.gmail.com>
Subject: Re: [PULL 02/13] hw/rdma/vmw/pvrdma_cmd: Use correct struct in
 query_port()
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-trivial@nongnu.org, qemu-stable@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2f.google.com
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

On Wed, 11 Oct 2023 at 07:23, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> From: Peter Maydell <peter.maydell@linaro.org>
>
> In query_port() we pass the address of a local pvrdma_port_attr
> struct to the rdma_query_backend_port() function.  Unfortunately,
> rdma_backend_query_port() wants a pointer to a struct ibv_port_attr,
> and the two are not the same length.
>
> Coverity spotted this (CID 1507146): pvrdma_port_attr is 48 bytes
> long, and ibv_port_attr is 52 bytes, because it has a few extra
> fields at the end.
>
> Fortunately, all we do with the attrs struct after the call is to
> read a few specific fields out of it which are all at the same
> offsets in both structs, so we can simply make the local variable the
> correct type.  This also lets us drop the cast (which should have
> been a bit of a warning flag that we were doing something wrong
> here).
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  hw/rdma/vmw/pvrdma_cmd.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

The following CI failure has occurred:

../hw/rdma/vmw/pvrdma_cmd.c:144:59: error: implicit conversion from
enumeration type 'enum ibv_port_state' to different enumeration type
'enum pvrdma_port_state' [-Werror,-Wenum-conversion]
resp->attrs.state =3D dev->func0->device_active ? attrs.state :
~ ~~~~~~^~~~~
../hw/rdma/vmw/pvrdma_cmd.c:146:33: error: implicit conversion from
enumeration type 'enum ibv_mtu' to different enumeration type 'enum
pvrdma_mtu' [-Werror,-Wenum-conversion]
resp->attrs.max_mtu =3D attrs.max_mtu;
~ ~~~~~~^~~~~~~
../hw/rdma/vmw/pvrdma_cmd.c:147:36: error: implicit conversion from
enumeration type 'enum ibv_mtu' to different enumeration type 'enum
pvrdma_mtu' [-Werror,-Wenum-conversion]
resp->attrs.active_mtu =3D attrs.active_mtu;
~ ~~~~~~^~~~~~~~~~

https://gitlab.com/qemu-project/qemu/-/jobs/5270666420

Please take a look.

Thanks,
Stefan

>
> diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
> index c6ed025982..d31c187593 100644
> --- a/hw/rdma/vmw/pvrdma_cmd.c
> +++ b/hw/rdma/vmw/pvrdma_cmd.c
> @@ -129,14 +129,13 @@ static int query_port(PVRDMADev *dev, union pvrdma_=
cmd_req *req,
>  {
>      struct pvrdma_cmd_query_port *cmd =3D &req->query_port;
>      struct pvrdma_cmd_query_port_resp *resp =3D &rsp->query_port_resp;
> -    struct pvrdma_port_attr attrs =3D {};
> +    struct ibv_port_attr attrs =3D {};
>
>      if (cmd->port_num > MAX_PORTS) {
>          return -EINVAL;
>      }
>
> -    if (rdma_backend_query_port(&dev->backend_dev,
> -                                (struct ibv_port_attr *)&attrs)) {
> +    if (rdma_backend_query_port(&dev->backend_dev, &attrs)) {
>          return -ENOMEM;
>      }
>
> --
> 2.39.2
>
>

