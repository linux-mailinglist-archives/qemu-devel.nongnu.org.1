Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF05785A67
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 16:25:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYonL-0002hZ-HF; Wed, 23 Aug 2023 10:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qYomZ-0002Lh-Q8
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:24:27 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qYomX-0001gA-SW
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:24:27 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-525bd0b2b48so7310926a12.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 07:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692800664; x=1693405464;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jDooUX4RBDBLxbJElR7u6qFvuQLYsc2Fs9AfguddLwQ=;
 b=fQO9fyvHyyuSqEFTeqBHCk+i4DEDIhStWLmhDDO5+NBH+7MDKKBM/Qg8y0Fb2IrT7k
 FkbzKxyceEFNGfRghA2gAW30KLnWuOKeKgPpFXIWt+UN9OLDl92K5FUqOvX0K2sNx/OM
 qfhOX8ca7dW4kosRg1xSscG0B5CiAJgAJ3xgvQvGBgbxGaaGyul4aXoChSnZHSW3ZMEN
 fzTMezZye36IXSIVPYONlDsQP+OBDYThb07YRycTZg674rTzvT3QOxtCnOQVEsxbMLdh
 mUMHxyDYHUpT9dBgtQ73u7gB0Lr9POS330eFRlxY3I2a7VZLAeSx3BETrfnH72zjIhi2
 2W4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692800664; x=1693405464;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jDooUX4RBDBLxbJElR7u6qFvuQLYsc2Fs9AfguddLwQ=;
 b=QRCTaYFqSVeGiKIc7Yvm+6g13Zb2hcxV5asQETjG7eO3Zgl9S39MND6WDvK9YC6b5c
 IIeniFVH1NrLcEyhoUoqqsvsJneeNNYLocz4UuKNqRWtTyAV3aZ8zzvRmSsIdgDofvJQ
 MD83EcaJgBfe+rx6DveXvEBuiJMeLLE4gTENFUG9eRj+JP3MbDX9PmAafx3VL2naCNYT
 AFbzpBH3vmtR2XGV60YxR5fAFgsXp7ssM7og4OzF6ctzmhaxhHy+hvxr9QTy3SX2S8H4
 NcLS9UJ6zRuwNQKS1xbyWYfLGL2mrCK/qRZR0UKTL066KRpyMYOgwLUfEqNOw0fjquzT
 ukXg==
X-Gm-Message-State: AOJu0YxSeYzFlYdYUQHOJQLzh3mps/JsOh5ZQsY6fU+PEZzRGngWY4Jj
 tMgpwOgGKfdyhgsYMOHLrBdXlcBWcKj7K337x00=
X-Google-Smtp-Source: AGHT+IGKjfCbSttAh4Wuffh46RGvPOzSWg542CyVgwyRelNEmQbsOdJNLFk7r++T7/F4xwkI1Yf3Fu9/q6kCcN9i69o=
X-Received: by 2002:aa7:cf99:0:b0:525:45dc:40b7 with SMTP id
 z25-20020aa7cf99000000b0052545dc40b7mr8305995edx.17.1692800663177; Wed, 23
 Aug 2023 07:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QU7gp1OjmrGhV1Y4jLRF0DYQAG=vn7LTS8SOa0eADW70Q@mail.gmail.com>
In-Reply-To: <CAJSP0QU7gp1OjmrGhV1Y4jLRF0DYQAG=vn7LTS8SOa0eADW70Q@mail.gmail.com>
From: Sam Li <faithilikerun@gmail.com>
Date: Wed, 23 Aug 2023 22:23:51 +0800
Message-ID: <CAAAx-8KKesRCK1-4-1Yx=SvsmMgxBZKLaCZXPZkKk4vyDkEOVg@mail.gmail.com>
Subject: Re: NVMe ZNS last zone size
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Val Adler <spantamd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x52c.google.com
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

Hi Stefan,

Stefan Hajnoczi <stefanha@gmail.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=8823=E6=
=97=A5=E5=91=A8=E4=B8=89 21:26=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Sam and Klaus,
> Val is adding nvme-io_uring ZNS support to libblkio
> (https://gitlab.com/libblkio/libblkio/-/merge_requests/221) and asked
> how to test the size of the last zone when the namespace's total size
> is not a multiple of the zone size.

I think a zone report operation can do the trick. Given zone configs,
the size of last zone should be [size - (nr_zones - 1) * zone_size].
Reporting last zone on such devices tells whether the value is
correct.

>
> My understanding is that the zoned storage model allows the last zone
> to be smaller than the zone size in this case. However, the NVMe ZNS
> emulation code in QEMU makes all zones a multiple of the zone size. I
> think QEMU cannot be used for this test case at the moment.
>
> Are there any plans to allow the last zone to have a different size?
> Maybe Sam's qcow2 work will allow this?

Yes, the zone report in qcow2 allows smaller last zone.
Please let me know if there is any problem.

Thanks,
Sam

