Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA057207F2
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 18:53:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q580f-0003YE-RF; Fri, 02 Jun 2023 12:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q580d-0003Vt-CV
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 12:52:15 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q580b-0001qq-HO
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 12:52:15 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5147e441c33so4947170a12.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 09:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685724730; x=1688316730;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Sff7bInCDdmadu0pclO55dmrQPtENAgkIJ6z/J/eXzo=;
 b=zycFv3nNrCXhICyiP2hfWl03I9A0Fw22BP+DUvwbTV9qMHywDYJpxwpmQaCJJ+l8Yg
 IvfXksxvvytfyE4gHuHvpDPG8TE9jPad9yVJBGyDm4xHZGJpbkhv0cKUKb3gg5GhkwdK
 KnFmwRnpL5Gik8AsEjFcXwEh9yHY+bceUw8u9pP4p5L2IE+C0IX/1HU3rDLPflnzsdD5
 UL3kjWIhEHZWU+ENMtHD4qM2YZTAiE9l7EdEs3i+Vdz4K0/HN7TkiciIEvneU1mz77aS
 miZbMhfwkijtBrw16svrciFqldTxf45Vfof4sS4ZU9nZIVcWnhvSOu0cW7kewWlzzeh1
 MNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685724731; x=1688316731;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Sff7bInCDdmadu0pclO55dmrQPtENAgkIJ6z/J/eXzo=;
 b=g7SD0/CHBfso5yC5EaNDwYrHFnJ0dC8wTykRcKtvb36u4Ms5t5eMotluzFGR87bFdu
 YwG4XDI2kz2h972b5fsghjOzcIDdp6T2sX9mdNMVwzZ5EfOiZCKw3vCuLVMN7OZFlxE+
 bndctD1Vv+EKaAUdu5Mr8l7ViQPit9IsLwAid/MH1znSTjXz/jTkOX4qz+ABUz21AzDi
 yDgVfUTciR2dyix+DPXRH5b24K5/MbKrbf+SkQcPnaI7qqQxcLYoh/anLpXpwU5BSTPY
 9tD+pt9lVjO7AxjX5bMPU/ct+qUo2j0p1UdjI30ULr7Ol3Wj2EVnHPN6qOMZnKn3L8TH
 EgMw==
X-Gm-Message-State: AC+VfDyWPkalZq3qwSW/N2yxhhQXrzu17elfGwXZ4TgAEZMxJ8N3jJlz
 UOScxd6nakhsLF6rZi8xAOA1lEY1Zj2QiG7FOKz/rw==
X-Google-Smtp-Source: ACHHUZ48GIu3kcVCKoUhs6C0La9ICHZ4Pv25CaMQNiLfJ9zUa6lDlaoSxOF6UZMIO+xjYkU7iGptnZm2+Xtr9aJuNcA=
X-Received: by 2002:a05:6402:50ce:b0:510:e8dc:f2a7 with SMTP id
 h14-20020a05640250ce00b00510e8dcf2a7mr3366440edb.7.1685724730737; Fri, 02 Jun
 2023 09:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230515160506.1776883-1-stefanha@redhat.com>
 <20230515160506.1776883-11-stefanha@redhat.com>
In-Reply-To: <20230515160506.1776883-11-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Jun 2023 17:51:59 +0100
Message-ID: <CAFEAcA9bDh12FSk8CjEkBZjQOEBVd6-=fVwnM9bx8aoXvQdMuw@mail.gmail.com>
Subject: Re: [PULL v2 10/16] block: introduce zone append write for zoned
 devices
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Sam Li <faithilikerun@gmail.com>, Dmitry Fomichev <dmitry.fomichev@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 15 May 2023 at 17:06, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> From: Sam Li <faithilikerun@gmail.com>
>
> A zone append command is a write operation that specifies the first
> logical block of a zone as the write position. When writing to a zoned
> block device using zone append, the byte offset of the call may point at
> any position within the zone to which the data is being appended. Upon
> completion the device will respond with the position where the data has
> been written in the zone.
>
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Message-id: 20230508051510.177850-3-faithilikerun@gmail.com
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Hi; Coverity flagged up a possible bug here (CID 1512459):

> @@ -2453,8 +2454,12 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, uint64_t offset,
>      if (fd_open(bs) < 0)
>          return -EIO;
>  #if defined(CONFIG_BLKZONED)
> -    if (type & QEMU_AIO_WRITE && bs->wps) {
> +    if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) && bs->wps) {

Here we check for bs->wps being NULL, which implies that it might be NULL...

>          qemu_co_mutex_lock(&bs->wps->colock);
> +        if (type & QEMU_AIO_ZONE_APPEND && bs->bl.zone_size) {
> +            int index = offset / bs->bl.zone_size;
> +            offset = bs->wps->wp[index];
> +        }
>      }
>  #endif
>
> @@ -2502,9 +2507,13 @@ out:
>  {
>      BlockZoneWps *wps = bs->wps;
>      if (ret == 0) {
> -        if (type & QEMU_AIO_WRITE && wps && bs->bl.zone_size) {
> +        if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND))
> +            && wps && bs->bl.zone_size) {
>              uint64_t *wp = &wps->wp[offset / bs->bl.zone_size];
>              if (!BDRV_ZT_IS_CONV(*wp)) {
> +                if (type & QEMU_AIO_ZONE_APPEND) {
> +                    *s->offset = *wp;
> +                }
>                  /* Advance the wp if needed */
>                  if (offset + bytes > *wp) {
>                      *wp = offset + bytes;
> @@ -2512,12 +2521,12 @@ out:
>              }
>          }
>      } else {
> -        if (type & QEMU_AIO_WRITE) {
> +        if (type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) {

...but here we do not, even though update_zones_wp() can
dereference bs->wps in some code paths.

Should we be checking for NULL here before calling, or
should update_zones_wp() handle a NULL bs->wps, or something else?

>              update_zones_wp(bs, s->fd, 0, 1);
>          }
>      }
>
> -    if (type & QEMU_AIO_WRITE && wps) {
> +    if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) && wps) {
>          qemu_co_mutex_unlock(&wps->colock);
>      }
>  }

thanks
-- PMM

