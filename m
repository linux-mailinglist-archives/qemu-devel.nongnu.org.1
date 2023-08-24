Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FE9787635
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:58:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZDet-0004Zk-Gz; Thu, 24 Aug 2023 12:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qZDel-0004Yi-Fq; Thu, 24 Aug 2023 12:58:03 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qZDei-0003KI-8n; Thu, 24 Aug 2023 12:58:03 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5298e43bb67so231220a12.1; 
 Thu, 24 Aug 2023 09:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692896278; x=1693501078;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9LCQ6p/zK0WLQgEjeOclvmAuDKSV4LeU9T5crgIsb50=;
 b=PX3P+1k+JS2yjV0TrOPXN2eMt+9xvL497rXfphXwR5PKiwTW85CkCl7ihSnqLyDsdq
 7bd1BZ4/fwAXKEdUtMN5Q2wt14gY6IgCl/n3UGErKhUQA7Z065DmQDW2P5WZIARIUFB8
 K055WSpjk5/sgjjvPIiK1KP205AhEDUg4aRqmMqyZ59V3VV4Cc4pqpN4I+IOaOOQPU1n
 gWAjiFCrDTd956JNesSzrDAjMNiJGGP4Hj88+NHdsIuNu62ZXcnjEqMuJGtPT5ljyh37
 Q9sMUVg/Z1GF186dewOM7zAfrnTjTXnXjV/Mz67oP1OCgPqpN+O+NzNht3CrRF3yQufX
 L91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692896278; x=1693501078;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9LCQ6p/zK0WLQgEjeOclvmAuDKSV4LeU9T5crgIsb50=;
 b=ZBVdMgnXbMOBWsBds8ifRevStXnPrA96ttpd79KL2TAO43IM+NrwkXsfgLAzJA/ISV
 aNFNZlBuljSaSRz1egVxRCE6qiOqjOxp92l7YLMoSFjdywhd6y0ZstBvaz7zXNMuFcV6
 aRivPgCqSigykMvK01+2ZnPXg0YcydCEsj8pa/qVJKVrg6x6Tg8kJSX8BSWzTtE0zYEj
 etx+svCEsgDl39N70L04IfOu791GK4QWB6jSpSdceklgZgqCEP4RKPWVxrru0hkJ7Ot0
 24FBp6F4ZdWc0EUhayi2bHpXXlvUQleHn4Bu6fusOreKP6+RkjaBlCJRLc4/hT4YxyJk
 v3ig==
X-Gm-Message-State: AOJu0YysvEDVcCTL47pxDNxNwwYS/Y2bfJBC6cP6O7XkMpSmB+CdrDT6
 XVxIdePaZR9PQvXJ1FF24JhKJHlMW9gU9+Quv8M=
X-Google-Smtp-Source: AGHT+IHnPL+n5SJ0TxMxA54q2Yy8GTv8Bl5hQUGyZn7I4+6w9ob3XKI33tYu3YYJa26JRYkQNTpe8oLWBDr4Cg3sx9M=
X-Received: by 2002:a05:6402:5109:b0:51e:4218:b91b with SMTP id
 m9-20020a056402510900b0051e4218b91bmr15673358edd.1.1692896277566; Thu, 24 Aug
 2023 09:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230824155345.109765-1-hreitz@redhat.com>
 <20230824155345.109765-2-hreitz@redhat.com>
In-Reply-To: <20230824155345.109765-2-hreitz@redhat.com>
From: Sam Li <faithilikerun@gmail.com>
Date: Fri, 25 Aug 2023 00:57:28 +0800
Message-ID: <CAAAx-8JDMj5YzEKYdtgnS0t6+TqPg=ruZkDNtvi4pHzkF29J5w@mail.gmail.com>
Subject: Re: [PATCH 1/5] file-posix: Clear bs->bl.zoned on error
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x529.google.com
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

Hanna Czenczek <hreitz@redhat.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=8824=E6=97=
=A5=E5=91=A8=E5=9B=9B 23:53=E5=86=99=E9=81=93=EF=BC=9A
>
> bs->bl.zoned is what indicates whether the zone information is present
> and valid; it is the only thing that raw_refresh_zoned_limits() sets if
> CONFIG_BLKZONED is not defined, and it is also the only thing that it
> sets if CONFIG_BLKZONED is defined, but there are no zones.
>
> Make sure that it is always set to BLK_Z_NONE if there is an error
> anywhere in raw_refresh_zoned_limits() so that we do not accidentally
> announce zones while our information is incomplete or invalid.
>
> This also fixes a memory leak in the last error path in
> raw_refresh_zoned_limits().
>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/file-posix.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)

Reviewed-by: Sam Li <faithilikerun@gmail.com>

